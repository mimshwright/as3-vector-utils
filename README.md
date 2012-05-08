# AS3 Vector Utils

A collection of useful utilities for working with Vectors (the geometric type, not the data structure type). These are designed for creating games with a focus on optimization and low memory-usage. 

Chiefly, the `VMath` class contains many mathematical operations for manipulating vectors.

The package structure mirrors that of [AS3-Utils](https://github.com/as3/as3-utils), which is another great general purpose library.

Please be aware, I am not a mathematician or physicist and there may be errors in the code. If you see anything that is incorrect or that could be iproved, please submit a pull request!

### Note on using `Point` objects: 
Vectors are not, strictly speaking, Points. But due to the intricate ways the Flash Player is optimized, the Point object can perform many of these functions faster than a custom-built Vector2D object. In AS3, Points are faster, functionally interchangeable with vectors, and in many cases more convenient when working with the Flash Player API (e.g. `globalToLocal()` uses points). That's why I chose to use them.

## Todo
- Finish writing unit tests