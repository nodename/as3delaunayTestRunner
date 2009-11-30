package com.nodename.planepoints
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.display.Graphics;
	import __AS3__.vec.Vector;
	import com.nodename.geom.Circle;
	import com.nodename.geom.LineSegment;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.nodename.utils.IDisposable;
	
	public class PlanePointsCanvas extends Sprite implements IPlanePointsCanvas
	{
		protected var _scale:Number;
		
		public function PlanePointsCanvas(scale:Number = 1.0)
		{
			_scale = scale;
		}
		
		public function dispose():void
		{
			// nothing
		}

		public function clear():void
		{
			graphics.clear();
		}
		
		public function lineStyle(thickness:Number, color:uint, alpha:Number = 1.0):void
		{
			graphics.lineStyle(thickness, color, alpha);
		}
		
		public function fillRegions(regions:Vector.<Vector.<Point>>, colors:Vector.<uint> = null):void
		{
			var i:int;
			if (colors)
			{
				for (i = regions.length; --i > -1;)
				{
					fillRegion(regions[i], colors[i]);
				}
			}
			else
			{
				for (i = regions.length; --i > -1;)
				{
					fillRegion(regions[i], i);
				}
			}
		}

		internal function fillRegion(points:Vector.<Point>, color:uint):void
		{
			var n:int = points.length;
			if (n < 2)
			{
				return;
			}
			var point:Point;
			graphics.beginFill(color);
			point = points[0];
			graphics.moveTo(_scale * point.x, _scale * point.y);
			for (var i:int = 1; i < n; ++i)
			{
				point = points[i];
				graphics.lineTo(_scale * point.x, _scale * point.y);
			}
			graphics.endFill();
		}
		
		public function drawSites(points:Vector.<Point>, colors:Vector.<uint>):void
		{
			for (var i:int = points.length; --i > -1;)
			{
				var p:Point = points[i];
				drawSite(p, colors[i]);
			}
		}
		
		private function drawSite(p:Point, color:uint):void
		{
			circle(p, 1.5, color);
		}
		
		public function drawCircles(circles:Vector.<Circle>, colors:Vector.<uint>):void
		{
			for (var i:int = circles.length; --i > -1;)
			{
				var theCircle:Circle = circles[i];
				circle(theCircle.center, theCircle.radius, colors[i], false);
			}
		}
		
		private function circle(p:Point, radius:Number, color:uint, fill:Boolean = true):void
		{
			graphics.lineStyle(0, color);
			fill && graphics.beginFill(color);
			graphics.drawCircle(_scale * p.x, _scale * p.y, radius);
			fill && graphics.endFill();
		}
		
		public function drawLineSegments(segments:Vector.<LineSegment>):void
		{
			for (var i:int = segments.length; --i > -1;)
			{
				var segment:LineSegment = segments[i];
				var p0:Point = segment.p0;
				var p1:Point = segment.p1;
				line(p0.x, p0.y, p1.x, p1.y);
			}
		}
		
		private function line(x0:Number, y0:Number, x1:Number, y1:Number):void
		{
			graphics.moveTo(_scale * x0, _scale * y0);
			graphics.lineTo(_scale * x1, _scale * y1);
		}
		
	}
}