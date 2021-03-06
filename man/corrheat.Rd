% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/corrheat.R
\name{corrheat}
\alias{corrheat}
\title{D3 Heatmap widget for correlation matrices}
\source{
Base code comes from \link[d3heatmap]{d3heatmap} package's core
  function, which was mostly gutted, and all dendrogram functionality
  replaced with a factor analytic approach.
}
\usage{
corrheat(x, psychOptions = NULL, factanalOptions = NULL,
  ordering = c("fa", "raw", "first", "absolute"), labRow = rownames(x),
  labCol = colnames(x), cexRow, cexCol, digits = 3L, cellnote,
  cellnote_scale = FALSE, theme = NULL, width = NULL, height = NULL,
  xaxis_height = 80, yaxis_width = 120, xaxis_font_size = NULL,
  yaxis_font_size = NULL, brush_color = "#0000FF", show_grid = TRUE,
  anim_duration = 500, ...)
}
\arguments{
\item{x}{A complete correlation matrix}

\item{psychOptions}{a \emph{named} list(!) of options to be passed to the psych package.
Do not include the \code{nfactors} argument, as that is chosen
automatically. Default is \code{NULL}.}

\item{factanalOptions}{a \emph{named} list(!) of options to be passed to the factanal
function in base R. \code{psychOptions} will be checked first, and if present
the psych package will be used and override this argument. Do not include the
\code{factors} argument, as that is chosen automatically. Default is \code{NULL}.}

\item{ordering}{Order cols/rows based on \code{psych::fa.sort} (default), max
raw ("raw"), or absolute ("absolute") loadings across all factors, or based
on the first
factor's raw loadings from \code{psych::fa} or \code{factanal}.}

\item{labRow}{character vectors with row labels to use (from top to bottom);
default to rownames(x).}

\item{labCol}{character vectors with column labels to use (from left to
right); default to colnames(x).}

\item{cexRow}{positive numbers. If not missing, it will override
\code{xaxis_font_size} and will give it a value cexRow*14}

\item{cexCol}{positive numbers. If not missing, it will override
\code{yaxis_font_size} and will give it a value cexCol*14}

\item{digits}{integer indicating the number of decimal places to be used by
\link{round} for 'label'.}

\item{cellnote}{(optional) matrix of the same dimensions as \code{x} that has
the human-readable version of each value, for displaying to the user on
hover. If \code{NULL}, then \code{x} will be coerced using
\code{\link{as.character}}. If missing, it will use \code{x}, after
rounding it based on the \code{digits} parameter.}

\item{cellnote_scale}{logical (default is FALSE). IF cellnote is missing and
x is used, should cellnote be scaled if x is also scaled?}

\item{theme}{A custom CSS theme to use. Currently the only valid values are
\code{""} and \code{"dark"}. \code{"dark"} is primarily intended for
standalone visualizations, not R Markdown or Shiny.}

\item{width}{Width in pixels (optional, defaults to automatic sizing).}

\item{height}{Height in pixels (optional, defaults to automatic sizing).}

\item{xaxis_height}{Size of axes, in pixels.}

\item{yaxis_width}{Size of axes, in pixels.}

\item{xaxis_font_size}{Font size of axis labels, as a CSS size (e.g. "14px"
or "12pt").}

\item{yaxis_font_size}{Font size of axis labels, as a CSS size (e.g. "14px"
or "12pt").}

\item{brush_color}{The base color to be used for the brush. The brush will be
filled with a low-opacity version of this color. \code{"#RRGGBB"} format
expected.}

\item{show_grid}{\code{TRUE} to show gridlines, \code{FALSE} to hide them, or
a numeric value to specify the gridline thickness in pixels (can be a
non-integer).}

\item{anim_duration}{Number of milliseconds to animate zooming in and out.
For large \code{x} it may help performance to set this value to \code{0}.}

\item{...}{currently ignored}
}
\description{
Creates a D3.js-based heatmap widget specifically geared toward
  correlation matrices. All dendrogram related functionality related to the
  original \code{d3heatmap} function is removed, and replaced with an
  ordering based on a factor analysis.
}
\details{
\code{d3heatmap} was a great tool for matrix visualization, though it has
  largely been abandoned in favor of \code{heatmaply}, which I recommended for
  standard matrices, though it also has functionality for correlation matrices.

  Correlation matrices are typically better visualized rather than parsed
  numerically, and while one can do so with various packages at this point,
  they invariably only order based on cluster analysis (for reasons unknown),
  and one often may not want the cluster based approach to ordering if
  dealing with a correlation matrix, which may be too small column-wise to be
  useful for a cluster analysis, or may be a specific type of data more
  amenable to a measurement error approach (e.g. items from a particular
  scale).

  \code{corrheat} produces a color coded matrix in which Blue represents
  positive, and Red, negative correlations, and fades to white the smaller
  the values are.  The ordering is based on the results of a factor analysis
  from the \code{\link[psych]{fa}} package (which is required).  Though one
  can use factanal from base R, it's not recommended, and can actually be
  reproduced with an additional argument to the psych options (as such I will
  likely deprecate this option). This function does not currently allow
  choice of the number of factors. Instead, the number of factors is chosen
  to more likely 'just work' for visualization purposes (\code{nfact = 1} if
  \code{ncol <=4}, else \code{floor(sqrt(ncol(x)))}), which is all we are
  worried about here. If you want explore a factor analysis you should
  do that separately.
}
\examples{
library(heatR)
corrheat(cor(mtcars), factanalOptions=list(rotation='varimax'), ordering='absolute')
corrheat(cor(mtcars), factanalOptions=list(rotation='varimax'), ordering='raw')
corrheat(Harman74.cor$cov, psychOptions=list(fm='ml'))
corrheat(cor(state.x77), psychOptions=list(fm='ml'), ordering='raw')


}
\seealso{
\code{\link[psych]{fa}}, \code{\link[stats]{factanal}}
}
