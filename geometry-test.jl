using .Geometry
using Test

#2a
@test Point2D(1,3) == Point2D(1,3)
@test Point3D(1,2,3) == Point3D(1,2,3)
@test Polygon([Point2D(0,0),Point2D(1,1),Point2D(2,0)]) == Polygon([Point2D(0,0),Point2D(1,1),Point2D(2,0)])

#2b
@test isa(Point2D(1,2),Point2D)
@test isa(Point2D(2,1),Point2D)
@test isa(Point2D(1.2,3.4),Point2D)
@test isa(Point2D(4.3,2.1),Point2D)
@test isa(Point2D(1,2.5),Point2D)

#2c

#2d
@test isa(Point3D(1,2,3),Point3D)
@test isa(Point3D(3,2,1),Point3D)
@test isa(Point3D(1.2,2.3,3.4),Point3D)
@test isa(Point3D(4.3,3.2,2.1),Point3D)
@test isa(Point3D(1,2.2,3),Point3D)

#2e
@test isa(Polygon([Point2D(0,0),Point2D(1,1),Point2D(2,0)]),Polygon)
@test isa(Polygon([0,0,0,2,1,2,1,0]),Polygon)
@test isa(Polygon(0,0,1,1,3,1,2,0),Polygon)

#2f
@test Polygon([Point2D(0,0),Point2D(1,1),Point2D(2,0)]) == Polygon([0,0,1,1,2,0])
@test Polygon([Point2D(0,0),Point2D(1,1),Point2D(2,0)]) == Polygon(0,0,1,1,2,0)

#2g
@test_throws ArgumentError Polygon(1,2,3)
@test_throws ArgumentError Polygon([Point2D(0,0),Point2D(1,1)])

#2h
@test isapprox(distance(Point2D(0,0),Point2D(0,1)),1)
@test isapprox(distance(Point2D(0,0),Point2D(1,1)),sqrt(2))
@test isapprox(distance(Point2D(0,0),Point2D(3,4)),5)

#2i
@test isapprox(perimeter(Polygon([Point2D(0,0),Point2D(3,0),Point2D(3,4)])),12)
@test isapprox(perimeter(Polygon([Point2D(0,0),Point2D(3,4),Point2D(8,4),Point2D(5,0)])),20)
@test isapprox(perimeter(Polygon([Point2D(0,0),Point2D(4,0),Point2D(4,1),Point2D(0,1)])),10)


triangle = Polygon([Point2D(0, 0), Point2D(1, 0), Point2D(0, 1)])
rectangle = Polygon([Point2D(0, 0), Point2D(1, 0), Point2D(1, 2), Point2D(0, 2)])

@testset "midpoint caclulations" begin
  @test midpoint(triangle) == Point2D(1/3,1/3)
  @test midpoint(rectangle) == Point2D(0.5,1)
end