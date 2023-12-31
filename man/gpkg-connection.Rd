% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gpkg-connection.R
\name{gpkg_connect}
\alias{gpkg_connect}
\alias{gpkg_connect.geopackage}
\alias{gpkg_connect.character}
\alias{gpkg_is_connected}
\alias{gpkg_is_connected.geopackage}
\alias{gpkg_disconnect}
\alias{gpkg_disconnect.geopackage}
\alias{gpkg_disconnect.SQLiteConnection}
\title{Create SQLite Connection to GeoPackage}
\usage{
gpkg_connect(x)

\method{gpkg_connect}{geopackage}(x)

\method{gpkg_connect}{character}(x)

gpkg_is_connected(x)

\method{gpkg_is_connected}{geopackage}(x)

gpkg_disconnect(x)

\method{gpkg_disconnect}{geopackage}(x)

\method{gpkg_disconnect}{SQLiteConnection}(x)
}
\arguments{
\item{x}{A \emph{geopackage} or \emph{SQLiteConnection} object}
}
\value{
A DBIConnection (SQLiteConnection) object. \code{NULL} on error.

If \code{x} is \emph{geopackage}, the disconnected object is returned. If x is a \emph{SQLiteConnection}, logical (\code{TRUE} if successfully disconnected).
}
\description{
Method for creating and connecting \code{SQLiteConnection} object stored within \code{geopackage} object.
}
\details{
The S3 method for \code{geopackage} objects does not require the use of assignment to create an object containing an active SQLiteConnection. e.g. \code{gpkg_connect(g)} connects the existing \code{geopackage} object \code{g}
}
