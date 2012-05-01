package
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	/**
	 * Static class that has some of the vector math functions for behaviors.
	 * 
	 * @author Base code from FlashGameDojo
	 */
	public class VMath {
		
		/**
		 * Returns the angle of the vector in radians.
		 */
		static public function getAngle(v:Point):Number {
			return Math.atan2(v.y, v.x);
		}
		
		/**
		 * Sets the angle of the vector in radians while maintaining the length 
		 */
		static public function setAngle(v:Point, angle:Number):void {
			var len:Number = v.length;
			v.x = Math.cos(angle) * len;
			v.y = Math.sin(angle) * len;
		}
		
		/**
		 * Calculates the angle between two vectors.
		 * @param v1 The first vector instance.
		 * @param v2 The second vector instance.
		 * @return Number the angle between the two given vectors.
		 */
		static public function angleBetween(v1:Point, v2:Point):Number
		{
			return Math.acos(dot(v1, v2) / (v1.length * v2.length));
		}
		
		static public function setLength(v:Point, l:Number):void {
			var a:Number = getAngle(v);
			v.x = Math.cos(a) * l;
			v.y = Math.sin(a) * l;
		}
		
		static public function getLength(v:Point):Number {
			return v.length;
		}
		
		static public var getMagnitude:Function = getLength;
		static public var setMagnitude:Function = setLength;
		
		static public function distance(v1:Point, v2:Point):Number {
			return Point.distance(v1, v2);
		}
		
		/**
		 * Finds a point on a line between two points. 
		 * 
		 * @param p1 The first point.
		 * @param p2 The second point. 
		 * @param percentageBetween The location on the line to find the point. Default is 0.5 which
		 * 							is exactly halfway between the two points.
		 * @return Point A new point located on the line between the two points. 
		 */
		static public function pointBetween(p1:Point, p2:Point, percentageBetween:Number = 0.5):Point {
			return Point.interpolate(p1, p2, percentageBetween);
		}
		
		/**
		 * sets the x and y of the display object to that of the vector.
		 */
		static public function apply(displayObject:DisplayObject, vector:Point):void {
			displayObject.x = vector.x;
			displayObject.y = vector.y;
		}
		
		/**
		 * Adds vector2 to vector1 and returns the result without altering either vector.
		 * @param	v1	The Vector2D in question
		 * @param	v2	The Vector2D to be added to v1
		 * @param	vn	Additional vectors to add.
		 */
		static public function add(v1:Point, v2:Point, ... vn):Point {
			var i:int = 0, l:int = vn.length, 
				v:Point = v1.add(v2);
			for (;i<l;i+=1) {
				v = v.add(Point(vn[i]));
			}
			return v;
		}
		
		/**
		 * Adds vector2 to vector1 and modifies the value of v1.
		 * @param	v1	The Vector2D in question
		 * @param	v2	The Vector2D to be added to v1
		 * @param	vn	Additional vectors to add.
		 */
		static public function $add(v1:Point, v2:Point, ... vn):Point { 
			vn.push(v2);
			var i:int = 0, l:int = vn.length;
			for (; i<l; i+=1) {
				v1.x += Point(vn[i]).x;
				v1.y += Point(vn[i]).y;
			}
			return v1;
		}
		
		/**
		 * Subtracts v2 from v1 and returns the result.
		 */
		static public function subtract(v1:Point, v2:Point):Point {
			return v1.subtract(v2);
		}

		/**
		 * Subtracts v2 from v1 and affects the original vector
		 */
		static public function $subtract(v1:Point, v2:Point):Point {
			v1.x -= v2.x;
			v1.y -= v2.y;
			return v1;
		}

		
		/**
		 * Multiplies a vector by a scalar and returns the result without affecting the original vector.
		 * @param v 	A vector instance.
		 * @param s 	A scalar value to multipy by.
		 */
		static public function multiply(v:Point, s:Number):Point {
		 	v = v.clone(); 
			return $multiply(v, s);
		}
		
		/**
		 * Multiplies a vector by a scalar and altering the original vector.
		 * @param v 	A vector instance.
		 * @param s 	A scalar value to multipy by.
		 */
		static public function $multiply (v:Point, s:Number):Point {
			v.x *= s;
			v.y *= s;
			return v;
		}
		
		static public var scale:Function = multiply;
		static public var $scale:Function = $multiply;
		
		/**
		 * Divides a vector by a scalar and returns the result without affecting the original vector.
		 * @param v 	A vector instance.
		 * @param s 	A scalar value to divides by.
		 */
		static public function divide(v:Point, s:Number):Point {
			v = v.clone();
			return $divide(v, s);
		}

		/**
		 * Divides a vector by a scalar and alters the original vector.
		 * @param v 	A vector instance.
		 * @param s 	A scalar value to divides by.
		 */
		static public function $divide(v:Point, s:Number):Point {
			v.x /= s;
			v.y /= s;
			return v;
		}
		
		/**
		 * Gets the dot product of two vectors.
		 * 
		 * @return the dot product of v and the instance
		 * */
		static public function dot( v1:Point, v2:Point ) : Number
		{
			return v1.x * v2.x + v1.y * v2.y;
		}
		
		
		/**
		 * Gets the cross product of the Vector and instance
		 * 
		 * @param v Vector to evaluate cross product with
		 * @return cross product of v and instance
		 * */
		static public function cross( v1:Point, v2:Point ) : Number
		{
			return v1.x * v2.y - v1.y * v2.x;
		}
		
		static public function crossScalar(v:Point, s:Number):Point {
			v = v.clone();
			var temp:Number = v.x;
			v.x = -s * v.y;
			v.y = s * temp;
			return v;
		}
		
		
		static public function getUnit(v:Point):Point {
			v = v.clone();
			v.normalize(1);
			return v;
		}
		
		/**
		 * Returns a new vector that is pointing the opposite direction from <code>v</code>.
		 * 
		 * @param v A vector to reverse.
		 * @return Point a new vector.
		 */ 
		static public function reverse(v:Point):Point {
			v = v.clone();
			$reverse(v);
			return v;
		}
		
		/**
		 * Reverses the vector <code>v</code>.
		 * 
		 * @param v A vector to reverse.
		 */ 
		static public function $reverse(v:Point):void {
			v.x *= -1;
			v.y *= -1;
		}
		
		/**
		 * Determines if a given vector is to the right or left of this vector.
		 * @return int If to the left, returns -1. If to the right, +1.
		 */
		static public function sign(v1:Point, v2:Point):int
		{
			return dot(getPerpindicular(v1), (v2)) < 0 ? -1 : 1;
		}

		/**
		 * Ensures the length of the vector is no longer than the given value.
		 * @param	v	A Vector2D instance to truncate.
		 * @param	max	The maximum value this vector should be. If length is larger than max, it will be truncated to this value.
		 */
		static public function truncate(v:Point, max:Number):Point {
			v = v.clone();
			setLength(v,Math.min(max, v.length)); 
			return v;
		}
		
		static public function isEqual(v1:Point, v2:Point, ... vn):Boolean {
			vn.push(v2);
			var i:int = 0, l:int = vn.length;
			for (;i<l;i+=1) {
				v2 = (vn[i] as Point);
				if (v1.x != v2.x || v1.y != v2.y) {
					return false;
				}
			}
			return true;
		}
		
		static public function isPerpindicular (v1:Point, v2:Point):Boolean {
			return dot(v1, v2) == 0;
		}
		static public function isParallel (v1:Point, v2:Point):Boolean {
			return dot(v1, v2) == 1;
		}
		static public function isColinear (v1:Point, v2:Point):Boolean {
			return dot(v1, v2) == -1;
		}
		static public var isOpposite:Function = isColinear;
		
		static public function getZeroVector():Point {
			return new Point(0, 0);
		}
		
		/**
		 * @return a new Vector that is perpindicular to the vector provided.
		 */
		static public function getPerpindicular(v:Point) : Point
		{
			v = v.clone();
			var temp:Number = v.x;
			v.x = -v.y;
			v.y = temp;
			return v;
		}
	} 
}
