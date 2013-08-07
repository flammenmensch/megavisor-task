/**
 * Created with IntelliJ IDEA.
 * User: a.protasov
 * Date: 07.08.13
 * Time: 12:11
 * To change this template use File | Settings | File Templates.
 */
package org.flammenmensch.cameraapp.ui {
import flash.display.BitmapData;
import flash.events.Event;
import flash.filters.BitmapFilter;
import flash.filters.ConvolutionFilter;
import flash.geom.Point;
import flash.geom.Rectangle;

public class FilteredCameraView extends CameraView {

		public function FilteredCameraView(width:uint=300, height:uint=300, frameRate:uint=30) {
			super(width, height, frameRate);
		}

		override protected function update(event:Event=null):void {
			super.update(event);

			var src:BitmapData = this.__picture.bitmapData;
			var rect:Rectangle = new Rectangle(0, 0, src.width, src.height);
			var point:Point = new Point(0, 0);
			var filter:BitmapFilter = new ConvolutionFilter(3, 3, [ 0, 1, 0, 1, -3, 1, 0, 1, 0 ], 0);

			this.__picture.bitmapData.applyFilter(src, rect, point, filter);
		}
	}
}
