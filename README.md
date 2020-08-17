# dkconvert
A Stata package for converting Danish municipalities (c_kom) to counties (c_amt), or regions (c_reg). Can also convert old municipalities (from before the structural reform in 2007) to new municipalities or regions and add value labels.

## Introduction
Statistics Denmark (DST, or "Danmarks Statistik", [link](https://www.dst.dk/)) hosts many data sets that contain municipalities ("kommuner"), counties ("amter") and/or regions ("regioner"). With Bornholm's referendum in 2003 and the Structural Reform in 2007 ("Kommunalreformen"), the 275 old municipalities were combined into 98 new and larger municipalities. In this reform, some old municipalities were split geographically between two to three new municipalities, thus introducing a data break.

Combining municipalities into regions and converting pre-2007 municipalities codes into post2007 codes are both common, time-consuming, and rather boring tasks in epidemiological studies that use DST datasets, such as the population registries  (BEF1, BEF1A, BEF1A07, and FOLK1A).

The purpose of this Stata program is:
1. Facilitate an easy conversion from municipalities (c_kom) to regions (c_reg) (or from old municipalities to counties, c_amt)
2. Provide a consistent and reproduceable conversion from old to new municipalities, where decisions on how to handle old municipalities, that were split, are transparent.  

Note: This is my first Stata package. Comments and suggestions are more than welcome.

## Syntax
Convert municipality (old or new) to other geographic area (new municipality or region):
**dkconvert** _varname_, **from**(oldkom|newkom) **to**(newkom|county|region) {**generate**(_newvar_) | **replace**} [**other options**]

Only add value label to municipality, county, or region code without any conversion:
**dkconvert** _varname_, **from**(oldkom|newkom|county|region) **labelonly** [**other options**]

### Options
* **from** is the type of _varname_ being converted (oldkom|newkom) or adding value label to (oldkom|newkom|county|region). oldkom and newkom refer to the municipality codes before and after the Structural Reform in 2007 ("Kommunalreformen").
* **to**(newkom|county|region) is the resulting new municipality, county, or region code
* **labelonly** specify instead of to() to only add value labels
* **generate**(_newvar_) generate _newvar_ containing converted values
* **replace** replace _varname_ with converted values
* **assert** (optional) require all values in _varname_ to match a valid code and terminates program if not.

Install and see Stata help-file for more details

## Installation
```stata
net install github, from("https://haghish.github.io/github/")
github install andreasebbehoj/dkconvert
```

Program requires the _labutil_ package to work. `github` should install automatically. If not, type:
```stata
ssc install labutil
```

## Update
```stata
github uninstall dkconvert
github install andreasebbehoj/dkconvert
```

## Uninstall
```stata
github uninstall dkconvert
```
