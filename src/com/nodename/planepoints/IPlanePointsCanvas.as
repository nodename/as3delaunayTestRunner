package com.nodename.planepoints
{
	import com.nodename.geom.Circle;
	import com.nodename.geom.LineSegment;
	import com.nodename.utils.IDisposable;
	
	import flash.display.Graphics;
	import flash.display.IBitmapDrawable;
	import flash.geom.Point;

	public interface IPlanePointsCanvas extends IDisposable, IBitmapDrawable
	{
		function get graphics():Graphics;
		function clear():void;
		function lineStyle(thickness:Number, color:uint, alpha:Number = 1.0):void;
		function fillRegions(regions:Vector.<Vector.<Point>>, colors:Vector.<uint> = null):void;
		function drawSites(points:Vector.<Point>, colors:Vector.<uint>):void;
		function drawCircles(circles:Vector.<Circle>, colors:Vector.<uint>):void;
		function drawLineSegments(segments:Vector.<LineSegment>):void;
	}
}