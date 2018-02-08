


normal = list(
    name = "Normal",
    qfun = qnorm,
    dfun = dnorm,
    args = c("Mean ( \\(\\mu\\))" = "mean" , "SD (\\(\\sigma\\))" = "sd"),
    init_args = c( 0 , 1),
    class = "C" , 
    frm = '$$
        f\\left(x \\mid \\mu, \\sigma \\right) = 
        \\frac{1}{\\sqrt{2\\pi\\sigma^2}}exp\\left( -2 \\frac{(x-\\mu)^2}{\\sigma^2} \\right)
    $$'
    
)



beta = list(
    name = "Beta",
    qfun = qbeta,
    dfun = dbeta,
    args = c("Shape 1 (a)" = "shape1" , "Shape 2 (b)" = "shape2"),
    init_args = c( 2, 2), 
    class = "C" ,
    frm = "$$
        f(x \\mid a , b) = \\frac{\\Gamma(a+b)}{\\Gamma(a)\\Gamma(b)} x^{a-1} (1-x)^{(b-1)}
    $$"
)

exponential = list(
    name = "Exponential",
    qfun = qexp ,
    dfun = dexp ,
    args = c( "Rate (\\(\\lambda\\))" = "rate") ,
    init_args = 1,
    class = "C" ,
    frm = "$$f(x \\mid \\lambda ) = \\lambda e^{- \\lambda x}$$"
)



weibull = list(
    name = "Weibull",
    qfun = qweibull ,
    dfun = dweibull ,
    args = c("Shape (a)" = "shape" , "Scale (b)" = "scale") ,
    init_args = c(1,1),
    class = "C" ,
    frm = "$$
        f(x \\mid a, b) = 
        \\left(\\frac{a}{b}\\right) \\left(\\frac{x}{b}\\right)^{(a-1)} 
        exp\\left(-\\left(\\frac{x}{b}\\right)^a\\right)
    $$"
)

chi2 = list(
    name = "Chi-Square",
    qfun = qchisq,
    dfun = dchisq,
    args = c( "Degrees of Freedom (n)" = "df"),
    init_args = c(2),
    class = "C" ,
    frm = "$$
        f(x \\mid , n) = \\frac{1}{2^{(n/2)} \\Gamma(n/2) } x^{(n/2 - 1)} e^{-x/2}
    $$"
)



cauchy = list(
    name = "Cauchy",
    qfun = qcauchy,
    dfun = dcauchy,
    args = c( "Location (L)" = "location", "Scale (s)" = "scale"),
    init_args = c(0 ,1),
    class = "C" ,
    frm = "$$
        f(x \\mid L , s) = \frac{1}{ \\pi s (1 + ((x-L)/s)^2)}
    $$"
)

logistic = list(
    name = "Logistic",
    qfun = qlogis,
    dfun = dlogis,
    args = c( "Location (m)" = "location", "Scale (s)" = "scale"),
    init_args = c(0,1),
    class = "C" ,
    frm = "$$
        f( x \\mid m , s) = \\frac{e^{-\\frac{x-m}{s}}}{s \\left( 1 + e^{-\\frac{x-m}{s}} \\right)^2}
    $$"
)

gamma = list(
    name = "Gamma",
    qfun = qgamma,
    dfun = dgamma,
    args = c( "Shape (a)" = "shape" , "Scale (s)" = "scale"),
    init_args = c(1 , 1),
    class = "C" ,
    frm = "$$
        f(x \\mid a , s) = \\frac{s^{-a}}{\\Gamma(a)} x^{(a-1)} e^{-(x/s)}
    $$"
)

fdist = list(
    name = "F",
    qfun = qf,
    dfun = df,
    args = c( "Degrees of Freedom 1 (n1)" = "df1", "Degrees of Freedom 2 (n2)" = "df2"),
    init_args = c(2 , 2),
    class = "C" ,
    frm = "$$
        f(x \\mid n1 , n2) = 
            \\frac{\\Gamma((n1 + n2)/2)}{\\Gamma(n1/2) \\Gamma(n2/2)}
            (n1/n2)^{(n1/2)} x^{(n1/2 - 1)} (1 + (n1/n2) x)^{-(n1 + n2)/2}
    $$"
)


poisson = list(
    name = "Poisson",
    qfun = qpois,
    dfun = dpois,
    args = c( "Lambda (\\(\\lambda\\))" = "lambda"),
    init_args = c(1),
    class = "D" ,
    frm = "$$
        f(x \\mid \\lambda) = \\frac{\\lambda x e^{-\\lambda}}{x!}
    $$"
)

binom = list(
    name = "Binomial",
    qfun = qbinom,
    dfun = dbinom,
    args = c( "Size (n)" = "size" , "Probability (p)" = "prob"),
    init_args = c(20 , 0.5),
    class = "D" ,
    frm = "$$
        f(x \\mid n, p) =  {n \\choose x} p ^ x (1-p)^{n-x}
    $$"
)


# shortname = list(
#     name = "...",
#     qfun = qfun,
#     dfun = dfun,
#     args = c( "Long name" = "sname"),
#     init_args = c(1),
#     class = "C" ,
#     frm = "$$
#     $$"
# )







