<!-- README.md is generated from README.Rmd. Please edit that file -->
[![ORCiD](https://img.shields.io/badge/ORCiD-0000--0002--3410--3732-green.svg)](http://orcid.org/0000-0002-3410-3732)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1117419.svg)](https://doi.org/10.5281/zenodo.1117419)
[![Licence](https://img.shields.io/github/license/mashape/apistatus.svg)](http://choosealicense.com/licenses/mit/)

[![Build
Status](https://travis-ci.org/potterzot/rnassqs.svg?branch=master)](https://travis-ci.org/potterzot/rnassqs)
[![Last-changedate](https://img.shields.io/badge/last%20change-2017--12--20-brightgreen.svg)](https://github.com/potterzot/rnassqs/commits/master)
[![Coverage
Status](https://coveralls.io/repos/github/potterzot/rnassqs/badge.svg?branch=master)](https://coveralls.io/github/potterzot/rnassqs?branch=master)

rnassqs (R NASS QuickStats)
---------------------------

This is a package that allows users to access the NASS quickstats data
through their API. It is fairly low level and does not include a lot of
scaffolding or setup. Some things may change, but at this point it is
relatively stable.

Installing
----------

Install like any R package from github:

    library(devtools)
    install_github('potterzot/rnassqs')

API Key
-------

To use the NASS Quickstats API you need an [API
key](http://quickstats.nass.usda.gov/api). There are several ways of
clueing the rnassqs package in to your api key. You can set the variable
explicitly and pass it to functions, like so

    params <- list(...)                    # parameters for query 
    api_key <- "<your api key here>"       # api key
    data <- nassqs(params, key = api_key)  # query and return data

Alternatively, you can set the api key as an environmental variable
either by adding it to your `.Renviron` like so:

    NASSQS_TOKEN="<your api key here>"

or by setting it explicitly in the console by calling
`rnassqs::nassqs_token()`. This will prompt you to enter the api key if
not set, and return the value of the api key if it is set. If you do not
set the key and you are running the session interactively, R will ask
you for the key when you try to issue a query.

Usage
-----

See the examples in [inst/examples](inst/examples) for quick recipes to
download data.

The most basic level of access is with `nassqs_GET()`, with which you
can make any query of variables. For example, to mirror the request that
is on the [NASS API documentation](http://quickstats.nass.usda.gov/api),
you can do:

    library(nassqs)
    params = list("commodity_desc"="CORN", "year__GE"=2012, "state_alpha"="VA")
    req = nassqs_GET(params=params, key=your_api_key)
    qsJSON = nassqs_parse(req)

Note that you can request data for multiple values of the same parameter
by as follows:

    params = list("commodity_desc"="CORN", "year__GE"=2012, "state_alpha"="VA", "state_alpha"="WA")
    req = nassqs_GET(params=params, key=your_api_key)
    qsJSON = nassqs_parse(req)

NASS does not allow GET requests that pull more than 50,000 records in
one request. The function will inform you if you try to do that. It will
also inform you if you’ve requested a set of parameters for which there
are no records.

### Handling inequalities and operators other than “=”

The NASS API handles other operators by modifying the variable name. The
API can accept the following modifications:

-   \_\_LE: &lt;=
-   \_\_LT: &lt;
-   \_\_GT: &gt;
-   \_\_GE: &gt;=
-   \_\_LIKE: like
-   \_\_NOT\_LIKE: not like
-   \_\_NE: not equal

For example, to request corn yields for all years since 2000, you would
use something like:

    params = list("commodity_desc"="CORN", 
                  "year__GE"=2000, 
                  "state_alpha"="VA", 
                  "statisticcat_desc"="YIELD")
    df = nassqs(params=params) #returns data as a data frame.

You could also use the helper function `nassqs_yield()`:

    nassqs_yield(list("commodity_desc"="CORN", "agg_level_desc"="NATIONAL")) #gets US yields

Alternatives
------------

NASS also provides a daily tarred and gzipped file of their entire
dataset. At the time of writing it is approaching 1 GB. You can download
that file from their FTP:

<ftp://ftp.nass.usda.gov/quickstats>

The FTP link also contains builds for: NASS’ census (every 5 years, the
next is 2017), or data for one of their specific sectors (CROPS,
ECONOMICS, ANIMALS & PRODUCTS). At the time of this writing, specific
files for the ENVIRONMENTAL and DEMOGRAPHICS sectors are not available.
