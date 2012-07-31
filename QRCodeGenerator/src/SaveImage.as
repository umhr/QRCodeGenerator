package{
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	public class SaveImage{
		public function SaveImage(){};
		/**
		 * PNG画像を書き出すためのメソッド
		 * @param displayObject
		 * @param is32BitColor//アルファチャンネル付きか否か
		 * @param isClearEdge//1pxの余白を付けるか否か
		 * @param isEven//画像の大きさ（縦横）を偶数にするか否か
		 *
		 */
		static public function PNGfromDisplayObject(displayObject:DisplayObject, is32BitColor:Boolean = true, isClearEdge:Boolean = false, isEven:Boolean = false, fileName:String = "image"):void {
			var width:int = displayObject.width+(isClearEdge?2:0);
			var height:int = displayObject.height+(isClearEdge?2:0);
			var txty:int = isClearEdge?1:0;
			if(isEven){
				width += width%2;
				height += height%2;
			}
			var bitmapData:BitmapData = new BitmapData(width,height,is32BitColor,0xFFFFFF);
			bitmapData.draw(displayObject,new Matrix(1,0,0,1,txty,txty));
			var byteArray:ByteArray = PNGEncoder.encode(bitmapData);
			var fileReference:FileReference = new FileReference();
			fileReference.save(byteArray, fileName + ".png");
		}
		/**
		 * JPG画像を書き出すためのメソッド
		 * @param displayObject
		 * @param quality//画質0-100
		 *
		 */
		static public function JPGfromDisplayObject(displayObject:DisplayObject, quality:Number = 50, fileName:String = "image"):void {
			var width:int = displayObject.width;
			var height:int = displayObject.height;
			var bitmapData:BitmapData = new BitmapData(width,height);
			bitmapData.draw(displayObject);
			var jPGEncoder:JPGEncoder = new JPGEncoder(quality);
			var byteArray:ByteArray = jPGEncoder.encode(bitmapData);
			var fileReference:FileReference = new FileReference();
			fileReference.save(byteArray, fileName + ".jpg");
		}
	}
}