module Geometry

using Statistics

import Base.show, Base.==

export Point2D, Point3D, Polygon, distance, perimeter, isRectangular, Area, midpoint

#structs:
"""
    Point2D{T <: Real,S <: Real}

Create a 2D point by taking two Real values that represent our x value and our y value.

### Example:
```julia-repl
julia> Point2D(1,2)
(1,2)
```
"""
mutable struct Point2D{T <: Real,S <: Real}
    x :: T
    y :: S

    # function Point2D(str::String)
    #     format = r"^\s*\(\s*(-?\d*\.?\d+)\s*,\s*(-?\d*\.?\d+)\s*\)\s*$"
    #     m = match(format, str)

    #     m === nothing && throw(ArgumentError("The string: $str is not in proper format."))
    #     x = parse(Float64, m[1])
    #     y = parse(Float64, m[2])
    #     Point2D(x,y)
    # end
end
Base.show(io::IO,p::Point2D) = print(io, string("(",p.x,",",p.y,")"))

"""
    Point3D{i <: Real, j <: Real, k <: Real}

Create a 3D point by taking three Real values that represent our x value, y value, and z value.

### Example:
```julia-repl
julia> Point2D(1,2,3)
(1,2,3)
```
"""
struct Point3D{i <: Real, j <: Real, k <: Real}
    x::i
    y::j
    z::k
end
Base.show(io::IO,p3::Point3D) = print(io, string("(",p3.x,",",p3.y,",",p3.z,")"))

"""
    Polygon(points::Vector{Point2D})
    Polygon(pts::Vector{Point2D{Int64,Int64}})
    Polygon(coordinates::Vector{<:Real})
    Polygon(num::Real...)

Create a Polygon that is made up of a vector of Point2D objects. The arguments for Polygon can be given as
a vector of Point2Ds, a vector of real numbers that amounts to an even number, or any amount of real numbers listed out
in the argument as long as it is still even.

### Examples:
```julia-repl
julia> Polygon([Point2D(1,2),Point2D(3,4),Point2D(5,6)])
[(1,2), (3,4), (5,6)]

julia> Polygon([1,2,3,4,5,6])
[(1,2), (3,4), (5,6)]

julia> Polygon(1,2,3,4,5,6)
[(1,2), (3,4), (5,6)]
```
"""
mutable struct Polygon
    points::Vector{Point2D}

    function Polygon(pts::Vector{Point2D{Int64,Int64}})
        length(pts) >= 3 || throw(ArgumentError("There must be at least three points."))
        new(pts)
    end
    function Polygon(coordinates::Vector{<:Real})
        length(coordinates) % 2 ==  0 || throw(ArgumentError("There must be an even number of coordinates."))
        points = []
        for i=1:2:length(coordinates)
            push!(points, Point2D(coordinates[i],coordinates[i+1]))
        end
        new(points)
    end
    function Polygon(num::Real...)
        array = collect(num)
        Polygon(array)
    end
end
Base.show(io::IO, poly::Polygon) = print(io, string("[",join(poly.points,", "),"]"))


#functions:
"""
    distance(point1::Point2D,point2::Point2D)
    distance(point1::Point3D,point2::Point3D)

Calculates the distance between two points. Depending on the arguments the points could either be in 2D or 3D.

### Example:
```julia-repl
julia> distance(point1_2D,point2_2D)
```
"""
function distance(point1::Point2D,point2::Point2D)
    sqrt((point2.x-point1.x)^2 + (point2.y-point1.y)^2)
end
function distance(point1::Point3D,point2::Point3D)
    sqrt((point2.x-point1.x)^2 + (point2.y-point1.y)^2 + (point2.z-point1.z)^2)
end

"""
    perimeter(poly::Polygon)

Calculates the perimeter of a given Polygon.

### Example:
```julia-repl
julia> perimeter(Polygon([Point2D(0,0),Point2D(3,0),Point2D(0,4)]))
```
"""
function perimeter(poly::Polygon)
    perim = 0
    for i = 1:length(poly.points)-1
        perim += distance(poly.points[i],poly.points[i+1])
    end
    perim += distance(poly.points[1],poly.points[length(poly.points)])
end

"""
    isRectangular(poly::Polygon)

Returns true if the given Polygon is rectangular, otherwise returns false.

### Example:
```julia-repl
julia> isRectangular(Polygon([Point2D(0,0),Point2D(3,0),Point2D(0,4)]))
```
"""
function isRectangular(poly::Polygon)
    if length(poly.p) != 4
        return false
    end
    d1 = distance(poly.p[1],poly.p[3])
    d2 = distance(poly.p[2],poly.p[4])
    isapprox(d1,d2)
end

"""
    Area(poly::Polygon)

Calculates the area of a given Polygon.

### Example:
```julia-repl
julia> Area(Polygon([Point2D(0,0),Point2D(3,0),Point2D(0,4)]))
```
"""
function Area(poly::Polygon)
    area = 0
    for i = 1:length(poly.p)-1
        area += (poly.p[i].x * poly.p[i+1].y) - (poly.p[i].y * poly.p[i+1].x)
    end
    area += (poly.p[length(poly.p)].x * poly.p[1].y) - (poly.p[length(poly.p)].y * poly.p[1].x)
    area = abs(area/2)
end

Base.:(==)(p1::Point2D, p2::Point2D) = p1.x == p2.x && p1.y == p2.y

Base.:(==)(p1::Point3D, p2::Point3D) = p1.x == p2.x && p1.y == p2.y && p1.z == p2.z

Base.:(==)(a::Polygon, b::Polygon) = a.points == b.points

"""
```
midpoint(p::Polyon)
```
calculates the midpoint of the polygon.
"""
midpoint(p::Polygon) = Point2D(mean(map(pt -> pt.x, p.points)), mean(map(pt -> pt.y, p.points)))

end