package
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * Static class that has some of the vector math functions for behaviors.
	 * 
	 * @author Mims H. Wright beginning with code from FlashGameDojo
	 */
	public class VMath {
		
		/** 
		 * Returns the length of the vector (distance from 0,0 to v).
		 * 
		 * @param v The vector to get the length from.
		 * @return Number The length of the vector.
		 * 
		 * @see flash.geom.Point#length
		 */
		static public function getLength(v:Point):Number { return v.length; }
		
		/**
		 * Sets the length of the vector to a new scalar.
		 * Note: if the vector is already length zero, the result will be zero. 
		 * 
		 * @param v The vector to set the length of. 
		 * @param l The new length of the vector. 
		 */
		static public function setLength(v:Point, l:Number):void { v.normalize(l); }
		
		/**
		 * A copy of the Point object's normalize() function put here for consistency.
		 */ 
		static public function normalize(v:Point, l:Number = 1.0):void { v.normalize(l); }
		
		/** Alternate name for getLength() */
		static public var getMagnitude:Function = getLength;
		/** Alternate name for setLength() */
		static public var setMagnitude:Function = setLength;
		
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
		 * Rotates the vector by the specified angle in radians. Different from setAngle()
		 * in that it adds to the previous angle. 
		 */
		static public function rotate(v:Point, angle:Number):void {
			setAngle(v, getAngle(v) + angle);
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
		
		
		/**
		 * @see flash.geom.Point#distance()
		 */
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
		static public function setPosition(displayObject:DisplayObject, vector:Point):void {
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
		 * @param	v1	The vector in question
		 * @param	v2	The vector to be added to v1
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
		static public function dot( v1:Point, v2:Point ):Number
		{
			return v1.x * v2.x + v1.y * v2.y;
		}
		
		
		/**
		 * Gets the cross product of two vectors
		 * 
		 * @param v1 Vector to evaluate cross product with
		 * @param v2 Vector to evaluate cross product with
		 * @return cross product of v1 and v2
		 * */
		static public function cross( v1:Point, v2:Point ):Number
		{
			return v1.x * v2.y - v1.y * v2.x;
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

		
		///// COMPARISSON functions that test aspects of two vectors.
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
		
		/** Returns true if the angle between v1 and v2 is 90° or 270°. */
		static public function isPerpindicular (v1:Point, v2:Point):Boolean { return dot(v1, v2) == 0; }
		
		/** Returns true if the angle between v1 and v2 is 0° or 180°. */
		static public function isParallel (v1:Point, v2:Point):Boolean { 
			var d:Number = dot(v1, v2);
			return d == 1 || d == -1; 
		}
		
		/** Returns true if v2 points in the opposite direction of v1. */
		static public function isOpposite (v1:Point, v2:Point):Boolean { return dot(v1, v2) == -1; }
		
		/**
		 * Determines if a given vector is to the right or left of this vector.
		 * @return int If to the left, returns -1. If to the right, +1.
		 */
		static public function sign(v1:Point, v2:Point):int
		{
			return dot(getPerpindicular(v1), (v2)) < 0 ? -1 : 1;
		}
		
		///// CONSTRUCTOR functions that return commonly used Vectors.
		
		/** Returns a new vector with components (0,0). */ 
		static public function getZeroVector():Point { return new Point(0, 0); }
		
		/** Returns a unit vector "i-hat" codirectional with the x axis. */
		static public function getUnitI():Point { return new Point(1, 0); }
		
		/** Returns a unit vector "j-hat" codirectional with the y axis. */
		static public function getUnitJ():Point { return new Point(0, 1); }
		
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
		
		
		//// CONVERSIONS to other data types.
		
		/** Returns an array with two elements based on the vector. */
		static public function toArray(v:Point):Array { return [v.x, v.y]; }
		
		/** Returns a transformation matrix with x and y translation based on the vector. */
		static public function toMatrix(v:Point):Matrix { return new Matrix(1, 0, 0, 1, v.x, v.y); }
	} 
}
