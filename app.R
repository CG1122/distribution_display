

library(shiny)
library(tidyverse)
library(scales)
library(purrr)




### Load distriutions and copy them into a list object (as names() doesn't work on environment obj)
distribs_raw <- new.env()
source("distributions.R" , local = distribs_raw)
distribs <- list()
for ( i in ls(distribs_raw)) distribs[[i]] <- distribs_raw[[i]]

### Create named vector so users see "nice" names for the objects
distrib_lookup <- names(distribs)
names(distrib_lookup) <- map_chr(distribs , "name")




### function to use distribution functions to create a plot ready dataset
get_dist_data <- function(dist , args, grp ){
    
    qfun = dist$qfun
    dfun = dist$dfun
    
    if ( dist$class == "C"){
        x <- seq(
            from = invoke( qfun , args , p = 0.0001),
            to = invoke( qfun , args , p = 0.9999),
            length.out = 500
        )
        y <- invoke( dfun , args , x = x )
        
        dat <- data_frame(
            x = x ,
            y = y , 
            group = paste0( "Distribution " , grp)
        )
        return(
            geom_line( data = dat , aes(x=x, y=y , group = group, col = group)) 
            
        )
        
    } else if (dist$class == "D"){
 
        x <- seq(
            from = invoke( qfun , args , p = 0.0001),
            to = invoke( qfun , args , p = 0.9999),
            by = 1
        )
        y <- invoke( dfun , args ,  x = x )
        
        dat <- data_frame(
            x = x ,
            y = y , 
            group = paste0( "Distribution " , grp)
        )
        
        return(
            geom_bar( 
                data=dat, 
                aes(x=x, y=y, group=group, col=group, fill=group), 
                stat = "identity",
                alpha = 0.7
            )
        )
        
    } else {
        stop("ERROR: Undefined class")
    }
    


}






ui <- fluidPage(

    theme = "mycss.css",
    

    column(
        width = 12,
        plotOutput("plot")
    ),
    
    column(
        width = 6,
        fluidRow(
            id = "c1",
            selectInput( 
                inputId = "dist1" , 
                label = "Distribution A" , 
                choices = distrib_lookup ,
                selected = "normal"
            ) ,
            uiOutput("ex1")
        )
    ) ,
    
    column(
        width = 6,
        fluidRow(
            id = "c2",
            selectInput( 
                inputId = "dist2" , 
                label = "Distribution B" , 
                choices = distrib_lookup ,
                selected = "normal"
            ) ,
            uiOutput("ex2")
        )
    )    
)




server <-  function( input , output , session){

    DIST_CURRENT <- reactiveValues()
    PLOT <- reactiveValues()
    
    output$plot <- renderPlot({
        PLOT$p
    })

    
    ### Update formula boxes if the distributions change
    output$ex1 <- renderUI({
        div(withMathJax(DIST_CURRENT$dist1$frm))
    })
    
    output$ex2 <- renderUI({
        div(withMathJax(DIST_CURRENT$dist2$frm))
    })
    
    ### Update argument input fields if distribution 1 is changed
    observeEvent( input$dist1 , {

        DIST_OLD <- DIST_CURRENT$dist1
        
        for ( i in rev(seq_along(DIST_OLD$args))){
            removeUI(
                immediate = TRUE,
                selector = paste0( "div:has(> #dist1_" , DIST_OLD$args[[i]] , ")") 
            )              
        }
        
        DIST_CURRENT$dist1 <- distribs[[input$dist1]]
        
        for ( i in rev(seq_along(DIST_CURRENT$dist1$args))){
            insertUI(
                selector = "#c1",
                where = "afterEnd",
                immediate = TRUE,
                ui = numericInput(
                    inputId =  paste0( "dist1_" , DIST_CURRENT$dist1$args[[i]]),
                    label = withMathJax(names(DIST_CURRENT$dist1$args)[[i]]), 
                    value =  DIST_CURRENT$dist1$init_args[[i]]
                )
            )               
        }
    })
    
    
    ### Update argument input fields if distribution 2 is changed
    observeEvent( input$dist2 , {
        
        DIST_OLD <- DIST_CURRENT$dist2
        
        for ( i in rev(seq_along(DIST_OLD$args))){
            removeUI(
                immediate = TRUE,
                selector = paste0( "div:has(> #dist2_" , DIST_OLD$args[[i]] , ")") 
            )              
        }
        
        DIST_CURRENT$dist2 <- distribs[[input$dist2]]
        
        for ( i in rev(seq_along(DIST_CURRENT$dist2$args))){
            insertUI(
                selector = "#c2",
                where = "afterEnd",
                immediate = TRUE,
                ui = numericInput(
                    inputId =  paste0( "dist2_" , DIST_CURRENT$dist2$args[[i]]),
                    label = withMathJax(names(DIST_CURRENT$dist2$args)[[i]]) , 
                    value =  DIST_CURRENT$dist2$init_args[[i]]
                )
            )               
        }
    })
    
    
    
    observe({

        x1 <- list()
        ARGS <- DIST_CURRENT$dist1$args
        for( i in seq_along(ARGS) ){
            ELEMENT <- paste0( "dist1_" , DIST_CURRENT$dist1$args[[i]])
            VAL <- ifelse(
                !is.null(input[[ELEMENT]]),
                input[[ELEMENT]],
                DIST_CURRENT$dist1$init_args[[i]]
            )
            x1[[ARGS[[i]]]] = VAL 
        }
        
        x2 <- list()
        ARGS <- DIST_CURRENT$dist2$args
        for( i in seq_along(ARGS) ){
            ELEMENT <- paste0( "dist2_" , DIST_CURRENT$dist2$args[[i]])
            VAL <- ifelse(
                !is.null(input[[ELEMENT]]),
                input[[ELEMENT]],
                DIST_CURRENT$dist2$init_args[[i]]
            )
            x2[[ARGS[[i]]]] = VAL 
        }
        

        tryCatch(
            {
                PLOT$p <- ggplot(mapping = aes(fill=group)) + 
                    get_dist_data(  DIST_CURRENT$dist1 , x1 , "A")  +
                    get_dist_data( DIST_CURRENT$dist2 , x2, "B") + 
                    theme_bw()  +
                    scale_color_discrete(name = "") + 
                    scale_fill_discrete(name = "") + 
                    ylab("Probability Density or Mass") +
                    xlab("x") +
                    theme(legend.position = "bottom")
            },
            error = function(...) PLOT$p <- ggplot()
        )
        
    })
}



shinyApp( ui , server )





