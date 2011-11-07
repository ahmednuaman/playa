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
			
			stage.align		= StageAlign.TOP_LEFT;
			stage.scaleMode	= StageScaleMode.NO_SCALE;
			
			addChild( loader );
			
			DisplayObjectUtil.loadMovie( 
				( loaderInfo.parameters.swf || 'Player.swf' ) + 
				'?url=' + ( loaderInfo.parameters.url || 'WeQP0Ibkq2k' ) + 
				'&autoplay=' + ( loaderInfo.parameters.autoplay || 'true' ), 
				null, handleComplete );
		}
		
		private function handleComplete(e:Event):void
		{
			var player:Object	= e.target.content;
			
			removeChild( loader );
			
			addChild( player as Sprite );
			
			stage.addEventListener( Event.RESIZE, player.handleResize, false, 0, true );
		}
	}
}