/**
 * Created with IntelliJ IDEA.
 * User: a.protasov
 * Date: 07.08.13
 * Time: 10:35
 * To change this template use File | Settings | File Templates.
 */
package org.flammenmensch.cameraapp.ui {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.media.Camera;
import flash.media.Video;

public class CameraView extends Sprite {

		private var __video:Video;

		private var __camera:Camera;

		protected var __picture:Bitmap;

		public function CameraView(width:uint=300, height:uint=300, frameRate:uint=30) {
			this.init(width, height, frameRate);
		}

		protected function init(width:uint, height:uint, frameRate:uint):void {
			this.__video = new Video(width, height);

			if (!Camera.isSupported) {
				throw new Error('Camera is not supported');
			} else {
				this.__camera = Camera.getCamera();

				if (!this.__camera) {
					throw new Error('Cannot find camera');
				}

				this.__camera.setMode(width, height, frameRate);

				this.__video.attachCamera(this.__camera);

				this.__picture = new Bitmap();

				this.addChild(this.__picture);

				this.addEventListener(Event.ENTER_FRAME, this.update, false, 0, true);
			}
		}

		protected function update(event:Event=null):void {
			var bd:BitmapData = new BitmapData(this.__camera.width, this.__camera.height, false, 0x000000);
			bd.draw(this.__video);

			this.__picture.bitmapData = bd;
		}
	}
}
