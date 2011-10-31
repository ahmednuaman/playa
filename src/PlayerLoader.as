package
{
	import com.firestartermedia.lib.as3.utils.DisplayObjectUtil;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF( background=0x000000, frameRate=30, height=268, width=476 )]
	
	public class PlayerLoader extends Sprite
	{
		private var loader:SimpleAssetLoader					= new SimpleAssetLoader();
		
		public function PlayerLoader()
		{
			loaderInfo.addEventListener( Event.INIT, handleInit );
		}
		
		private function handleInit(e:Event):void
		{
			loaderInfo.removeEventListener( Event.INIT, handleInit );
			
			loader.x		= ( stage.stageWidth - loader.width ) / 2;
			loader.y		= ( stage.stageHeight - loader.height ) / 2;
			
			//stage.align		= StageAlign.TOP_LEFT;
			//stage.scaleMode	= StageScaleMode.NO_SCALE;
			
			addChild( loader );
			
			DisplayObjectUtil.loadMovie( loaderInfo.parameters.swf + '?url=' + loaderInfo.parameters.url + '&autoplay=' + loaderInfo.parameters.autoplay, 
											null, handleComplete );
		}
		
		private function handleComplete(e:Event):void
		{
			removeChild( loader );
			
			addChild( e.target.content );
		}
	}
}