/**
 * Created with IntelliJ IDEA.
 * User: a.protasov
 * Date: 07.08.13
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
package org.flammenmensch.cameraapp.ui {

import flash.display.Sprite;

public class HistogramView extends Sprite {

		public function HistogramView(histogram:Vector.<Vector.<Number>>=null) {
			super();

			if (histogram) {
				this.draw(histogram);
			}
		}

		public function draw(histogram:Vector.<Vector.<Number>>):void {
			var i:uint;
			var h:uint = 48;
			var w:uint = 256;
			var max:Number;
			var value:Number;
			var color:uint = 16;

			this.graphics.clear();

			for (var channel:uint = 0; channel < 3; channel++) {

				max = 0.0;

				for (i = 1; i < 255; i++) {
					value = histogram[channel][i];
					max = value > max ? value : max;
				}

				i = 0;

				for each (value in histogram[channel]) {
					this.graphics.lineStyle(1.0, i << color);
					this.graphics.moveTo(i, h);
					this.graphics.lineTo(i, Math.max(0.0, h - value * h / max));

					i++;
				}

				color -= 8;
			}
		}
	}
}
