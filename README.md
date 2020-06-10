# dkconvert
A Stata package for converting Danish municipalities (c_kom) to counties (c_amt), or regions (c_reg). Can also convert old municipalities (from before the structural reform in 2007) to new municipalities or regions. Work-in-progress.

## Syntax
**dkconvert** _varname_, {**generate**(_newvar_) | **replace**} **from**(oldkom|newkom) **to**(oldkom|newkom|county|region) [**assert**]

where _varlist_ is the municipalities codes ("kommunenumre") to be converted. _varname_ must be an integer.

### Options
* generate**(_newvar_) generate _newvar_ containing converted values
* **replace** replace _varname_ with converted values
* **from**(_old_) is the type of _varname_ being converted. Can either be oldkom (municipality codes from before 2007) or newkom (municipalities after structural reform 2007)
* **to**(_new_) is the resulting municipality/county or region code
* **assert** require all  values in _varlist_ to be match with a known municipality and terminates program if it does not.


## Installation
```stata
net install github, from("https://haghish.github.io/github/")
github install andreasebbehoj/dkconvert
```

Program requires the _labutil_ package to work. Install by typing:
```stata
ssc install labutil
```

## Notes
This is my first Stata package and both package and documentation is still very much a work-in-progress. Comments and suggestions are more than welcome.
