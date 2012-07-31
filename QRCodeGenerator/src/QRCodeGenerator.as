package {

	import com.d_project.qrcode.ErrorCorrectLevel;
	import com.d_project.qrcode.QRCode;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
    

    public class QRCodeGenerator extends Sprite {

        public function QRCodeGenerator() {
			
			var bitmap:Bitmap = new Bitmap();
			bitmap.bitmapData = getBitmapData();
			
			addChild(bitmap);
			
        }
		
		static public function getBitmapData(data:String = "foobar", width:int = 200, height:int = 200, padding:int = 10):BitmapData {
            var size : Number = Math.min(width, height) - padding * 2;
            var xOffset : Number = (width - size) / 2;
            var yOffset : Number = (height - size) / 2;
            
			var result:BitmapData = new BitmapData(width, height, true);
			var shape:Shape = new Shape();
			
			try {
				
				var qr : QRCode = QRCode.getMinimumQRCode(data, ErrorCorrectLevel.H);
				var cs : Number = size / qr.getModuleCount();
				for (var row : int = 0; row < qr.getModuleCount(); row++) {
					for (var col : int = 0; col < qr.getModuleCount(); col++) {
						shape.graphics.beginFill( (qr.isDark(row, col)? 0 : 0xffffff) );
						shape.graphics.drawRect(cs * col + xOffset, cs * row + yOffset,  cs, cs);
						shape.graphics.endFill();
					}
				}
				result.draw(shape);
				
			}catch (error:Error) {
				var textField:TextField = new TextField();
				textField.text = "文字量がオーバーしました。減らしてください。";
				textField.width = width;
				textField.height = height;
				textField.wordWrap = true;
				textField.multiline = true;
				result.draw(textField);
			}
			
			
			return result;
		}
		
		
		
    }
}

