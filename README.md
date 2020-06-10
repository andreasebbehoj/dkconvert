# dkconvert
A Stata package for converting Danish municipalities (c_kom) to counties (c_amt), or regions (c_reg). Can also convert old municipalities (from before the structural reform in 2007) to new municipalities or regions.

## Introduction
Statistics Denmark (DST, or "Danmarks Statistik", [link](https://www.dst.dk/)) hosts many data sets that contain municipalities ("kommuner"), counties ("amter") and/or regions ("regioner"). With Bornholm's referendum in 2003 and the Structural Reform in 2007 ("Kommunalreformen"), the 275 old municipalities were combined into 98 new and larger municipalities. In this reform, some old municipalities were split geographically between two to three new municipalities, thus introducing a data break.

Combining municipalities into regions and converting pre-2007 municipalities codes into post2007 codes are both common, time-consuming, and rather boring tasks in epidemiological studies that use DST datasets, such as the population registries  (BEF1, BEF1A, BEF1A07, and FOLK1A).

The purpose of this Stata program is:
1. Facilitate an easy conversion from municipalities (c_kom) to regions (c_reg) (or from old municipalities to counties, c_amt)
2. Provide a consistent and reproduceable conversion from old to new municipalities, where decisions on how to handle old municipalities, that were split, are transparent.  

Note: This is my first Stata package. Both package and documentation is still very much a work-in-progress. Comments and suggestions are more than welcome.

## Installation
```stata
net install github, from("https://haghish.github.io/github/")
github install andreasebbehoj/dkconvert
```

Program requires the _labutil_ package to work. Install by typing:
```stata
ssc install labutil
```

## Syntax
**dkconvert** _varname_, {**generate**(_newvar_) | **replace**} **from**(oldkom|newkom) **to**(newkom|county|region) [**assert**]

where _varlist_ is the municipalities codes ("kommunenumre") to be converted. _varname_ must be an integer.

### Options
* **generate**(_newvar_) generate _newvar_ containing converted values
* **replace** replace _varname_ with converted values
* **from**(_old_) is the type of _varname_ being converted. Can either be oldkom (municipality codes from before 2007) or newkom (municipalities after structural reform 2007)
* **to**(_new_) is the resulting municipality/county or region code
* **assert** require all  values in _varlist_ to be match with a known municipality and terminates program if it does not.
