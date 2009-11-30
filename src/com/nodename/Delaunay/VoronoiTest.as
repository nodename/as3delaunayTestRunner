package com.nodename.Delaunay
{
	import asunit.framework.TestCase;
	
	import com.nodename.geom.Polygon;
	import com.nodename.geom.Winding;
	import com.nodename.planepoints.PlanePointsCanvas;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class VoronoiTest extends TestCase
	{
		private var _voronoi:Voronoi;
		private var _point0:Point;
		private var _point1:Point;
		private var _point2:Point;
		private var _points:Vector.<Point>;
		private var _plotBounds:Rectangle;
		
		public function VoronoiTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		override protected function setUp():void
		{
			_point0 = new Point(-10, 0);
			_point1 = new Point(10, 0);
			_point2 = new Point(0, 10);
			_points = Vector.<Point>(
				[
					_point0,
					_point1,
					_point2
				]);
			_plotBounds = new Rectangle(-20, -20, 40, 40);
			_voronoi = new Voronoi(_points, null, _plotBounds);
		}
		
		override protected function tearDown():void
		{
			_voronoi.dispose();
			_voronoi = null;
			_plotBounds = null;
			_points = null;
			_point0 = _point1 = _point2 = null;
		}
		
		public function testRegionsHaveNoDuplicatedPoints():void
		{
			for each (var region:Vector.<Point> in _voronoi.regions())
			{
				trace(region);
				var sortedRegion:Vector.<Point> = region.concat();
				sortedRegion.sort(compareYThenX);
				var length:uint = sortedRegion.length;
				for (var i:uint = 1; i < length; ++i)
				{
					assertFalse(sortedRegion[i].equals(sortedRegion[i - 1]));
				}
			}
			
			function compareYThenX(p0:Point, p1:Point):Number
			{
				if (p0.y < p1.y) return -1;
				if (p0.y > p1.y) return 1;
				if (p0.x < p1.x) return -1;
				if (p0.x > p1.x) return 1;
				return 0;
			}
		}
		
		public function testRegionsPointsAreInCounterclockwiseOrder():void
		{
			for each (var region:Vector.<Point> in _voronoi.regions())
			{
				trace(region);
				var polygon:Polygon = new Polygon(region);
				trace(polygon.winding());
				assertEquals(polygon.winding(), Winding.COUNTERCLOCKWISE);
			}
		}
		
		public function testMyPointIsInRegionOfPoint2():void
		{
			var myPoint:Point = new Point(10, 11);
			var nearestSite:Point = nearestSitePoint(myPoint.x, myPoint.y);
			assertNotNull(nearestSite);
			assertTrue(nearestSite.equals(_point2));
		}

		private function nearestSitePoint(x:Number, y:Number):Point
		{
			if (x < _plotBounds.x || x > _plotBounds.right || y < _plotBounds.y || y > _plotBounds.bottom)
			{
				return null;
			}
			var proximityBuffer:PlanePointsCanvas = new PlanePointsCanvas();
			proximityBuffer.fillRegions(_voronoi.regions(), null);
			var bmp:BitmapData = new BitmapData(_plotBounds.width, _plotBounds.height, false, 0xffffff);
			var matrix:Matrix = new Matrix();
			matrix.translate(-_plotBounds.x, -_plotBounds.y);
			bmp.draw(proximityBuffer, matrix);
			var coord:Point = _voronoi.nearestSitePoint(bmp, x - _plotBounds.x, y - _plotBounds.y);
			bmp.dispose();
			return coord;
		}
		
		public function testNeighbors():void
		{
			var neighbors:Vector.<Point> = _voronoi.neighborSitesForSite(_point0);
			assertTrue(neighbors.indexOf(_point0) == -1);
			assertFalse(neighbors.indexOf(_point1) == -1);
			assertFalse(neighbors.indexOf(_point2) == -1);
		}
	}
}