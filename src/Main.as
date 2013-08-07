package {

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;

import org.flammenmensch.cameraapp.ui.*;

[SWF(width="670", height="350", frameRate="30", backgroundColor="#ffffff")]
	public class Main extends Sprite {

		private var __leftCameraView:CameraView;

		private var __rightCameraView:CameraView;

		private var __leftHistogramView:HistogramView;

		private var __rightHistogramView:HistogramView;

		private static const UPDATE_FREQUENCY:uint = 15;

		private var __frameCounter:uint = 0;

		public function Main() {
			this.init();
		}

		private function init():void {
			this.createLeftCameraView();
			this.createRightCameraView();

			this.createLeftHistogramView();
			this.createRightHistogramView();

			this.addEventListener(Event.ENTER_FRAME, this.update, false, 0, true);
		}

		private function update(event:Event=null):void {
			this.__frameCounter++;

			if (this.__frameCounter === UPDATE_FREQUENCY) {
				this.__frameCounter = 0;

				this.__leftHistogramView.draw(this.calculateHistogramFor(this.__leftCameraView));
				this.__rightHistogramView.draw(this.calculateHistogramFor(this.__rightCameraView));
			}
		}

		private function createLeftCameraView():void {
			this.__leftCameraView = new CameraView(320, 240);
			this.__leftCameraView.x = 10;
			this.__leftCameraView.y = 10;

			this.addChild(this.__leftCameraView);
		}

		private function createRightCameraView():void {
			this.__rightCameraView = new FilteredCameraView(320, 240)
			this.__rightCameraView.x = 340;
			this.__rightCameraView.y = 10;

			this.addChild(this.__rightCameraView);
		}

		private function createLeftHistogramView():void {
			this.__leftHistogramView = new HistogramView();
			this.__leftHistogramView.x = 10;
			this.__leftHistogramView.y = 260;

			this.addChild(this.__leftHistogramView);
		}

		private function createRightHistogramView():void {
			this.__rightHistogramView = new HistogramView();
			this.__rightHistogramView.x = 340;
			this.__rightHistogramView.y = 260;

			this.addChild(this.__rightHistogramView);
		}

		private function calculateHistogramFor(target:DisplayObject):Vector.<Vector.<Number>> {
			var bitmapData:BitmapData = new BitmapData(target.width, target.height);
			bitmapData.draw(target);

			return bitmapData.histogram();
		}
	}
}
