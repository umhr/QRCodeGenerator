package  
{
	
	import com.bit101.components.HUISlider;
	import com.bit101.components.PushButton;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	/**
	 * ...
	 * @author umhr
	 */
	public class Canvas extends Sprite 
	{
		private var _bitmap:Bitmap = new Bitmap(new BitmapData(400, 400));
		private var _textField:TextField = new TextField();
		private var _sizeSlider:HUISlider;
		public function Canvas() 
		{
			init();
		}
		private function init():void 
		{
            if (stage) onInit();
            else addEventListener(Event.ADDED_TO_STAGE, onInit);
        }
        
        private function onInit(event:Event = null):void 
        {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			_sizeSlider = new HUISlider(this, 8, 7, "Size", onSizeChange);
			_sizeSlider.minimum = 50;
			_sizeSlider.maximum = 400;
			_sizeSlider.value = 200;
			_sizeSlider.tick = 1;
			
			_textField.type = TextFieldType.INPUT;
			_textField.x = 8;
			_textField.y = 30;
			_textField.width = 465 - 16;
			_textField.height = 34;
			_textField.border = true;
			_textField.addEventListener(Event.CHANGE, textField_change);
			_textField.text = "この欄にQRCodeにしたいテキストを記入してください";
			_textField.wordWrap = true;
			_textField.multiline = true;
			_textField.border = true;
			_textField.borderColor = 0x666666;
			_textField.backgroundColor = 0xFFFFFF;
			_textField.background = true;
			addChild(_textField);
			
			_bitmap.x = 8;
			_bitmap.y = 68;
			addChild(_bitmap);
			
			new PushButton(this, 355, 6, "SAVE PNG", onSavePNG);
			
			textField_change(null);
			
		}
		
		private function onSavePNG(event:Event):void {
			var data:String = _textField.text;
			var size:int = _sizeSlider.value;
			
			SaveImage.PNGfromDisplayObject(new Bitmap(QRCodeGenerator.getBitmapData(data, size, size)), true, false, false, "QRCode");
		}
		private function onSizeChange(event:Event):void {
			generate();
		}
		
		private function textField_change(event:Event):void 
		{
			generate();
		}
		
		private function generate():void {
			var data:String = _textField.text;
			var size:int = _sizeSlider.value;
			
			_bitmap.bitmapData.fillRect(_bitmap.bitmapData.rect, 0xFFFFFF);
			_bitmap.bitmapData.draw(QRCodeGenerator.getBitmapData(data, size, size));
			
		}
	}
	
}