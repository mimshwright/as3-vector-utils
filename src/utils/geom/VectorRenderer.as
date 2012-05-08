package utils.geom
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import spark.primitives.Graphic;

	/**
	 * A helper class used for visualizing vectors.
	 * 
	 * @example Draw an arrow representing a velocity vector.
	 * <listing version="3.0">
		 package {
			import flash.display.Shape;
			import flash.display.Sprite;
			import flash.events.Event;
			import flash.geom.Point;
			import flash.utils.getTimer;
			
			import utils.geom.VectorRenderer;
			
			[SWF(frameRate="60")]
			public class TestRender extends Sprite
			{
				public function TestRender()
				{
					super();
					
					var shape:Shape = new Shape(); 
					shape.y = 300;
					addChild(shape);
					
					var vel:Point = new Point(2,-5); 
					var accel:Point = new Point(0, 0.05);
					
					var renderer:VectorRenderer = new VectorRenderer(shape.graphics);
					
					addEventListener(Event.ENTER_FRAME, function onEnterFrame(event:Event):void {
						vel = vel.add(accel);
						shape.x += vel.x;
						shape.y += vel.y;
						
						renderer.clear();
						renderer.renderArrow (vel, 0xFF00FF, 8.0, true);
					});
				}
			}
		}
	 * </listing>
	 * 
	 * @author Mims Wright
	 */
	public class VectorRenderer
	{
		/** The graphics object used for the drawings. */
		public var graphics:Graphics;
		
		/**
		 * Constructor.
		 * 
		 * @param graphics The graphics object used for the drawings. 
		 */
		public function VectorRenderer(graphics:Graphics) {
			this.graphics = graphics;
		}
		
		/**
		 * Clears the graphics object.
		 */
		public function clear():void {
			graphics.clear();
		}
		
		/**
		 * Draws an arrow representing the vector.
		 * 
		 * @param v The vector or point to use as the hypotenuse. 
		 * @param color The color of the lines of the triangle. Default is black.
		 * @param scale The amount to scale up the size of the triangle. Default is 1.0 (no change)
		 * @param drawArrowHead When true, draws the arrowhead. When false, only a line is drawn. 
		 */ 
		public function renderArrow(v:Point, color:uint = 0x000000, scale:Number = 1.0, drawArrowHead:Boolean = true):void {
			v = VMath.multiply(v, scale); // clones the vector in the process.
			graphics.lineStyle(1, color);
			graphics.moveTo(0,0);
			graphics.lineTo(v.x, v.y);
			
			if (drawArrowHead) {
				var v2:Point = VMath.multiply(v, 0.2);  
				VMath.$rotate(v2, Math.PI *3/4);
				VMath.$add(v2,v);
				graphics.lineTo(v2.x, v2.y);
				
				VMath.$subtract(v2, v);
				VMath.$rotate(v2, Math.PI /2);
				VMath.$add(v2,v);
				graphics.moveTo(v.x, v.y);
				graphics.lineTo(v2.x, v2.y);
			}
		}
		
		/**
		 * Draws a triangle using the vector as the hypotenuse.
		 * 
		 * @param v The vector or point to use as the hypotenuse. 
		 * @param color The color of the lines of the triangle. Default is black.
		 * @param scale The amount to scale up the size of the triangle. Default is 1.0 (no change)
		 */ 
		public function renderTriangle(v:Point, color:uint = 0, scale:Number = 1.0):void {
			
			graphics.lineStyle(1, color);
			graphics.lineTo(v.x, 0);
			graphics.lineTo(v.x, v.y);
			graphics.lineTo(0, 0);
		}
	}
}