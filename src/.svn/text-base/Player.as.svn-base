package
{
	import com.firestartermedia.lib.as3.display.component.video.YouTubePlayerAS3;
	import com.firestartermedia.lib.as3.events.YouTubePlayerEvent;
	
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Player extends Sprite
	{
		private var asset:MixedAssetPlayer						= new MixedAssetPlayer();
		private var player:Object;
		
		public function Player()
		{
			loaderInfo.addEventListener( Event.INIT, handleInit );
		}
		
		private function handleInit(e:Event):void
		{
			loaderInfo.removeEventListener( Event.INIT, handleInit );
			
			var url:String	= loaderInfo.parameters.url;
			
			if ( url.indexOf( '.' ) !== -1 )
			{
				player	= asset.player;
				
				asset.player.autoPlay			= loaderInfo.parameters.autoplay == 'true';
				asset.player.bufferingBar		= asset.buffering;
				asset.player.muteButton			= asset.controls.buttonVolume;
				asset.player.playPauseButton	= asset.controls.buttonPlayPause;
				
				if ( loaderInfo.parameters.autoplay == 'true' )
				{
					asset.player.play( url );
				}
				else
				{
					asset.player.load( url );
				}
			}
			else
			{
				player	= new YouTubePlayerAS3();
				
				player.autoplay		= loaderInfo.parameters.autoplay == 'true';
				player.chromeless	= true;
				
				player.height		= asset.player.height;
				player.width		= asset.player.width;
				
				player.addEventListener( YouTubePlayerEvent.PLAYING, handleYTPlayerPlaying );
				player.addEventListener( YouTubePlayerEvent.ENDED, handleYTPlayerEnded );
				
				asset.buffering.visible	= false;
				
				player.play( url );
				
				asset.controls.buttonPlayPause.pause_mc.visible	= false;
				asset.controls.buttonVolume.off_mc.visible		= false;
				
				asset.player.visible	= false;
				
				asset.addChildAt( player as YouTubePlayerAS3, asset.getChildIndex( asset.player ) );
				
				asset.controls.buttonVolume.addEventListener( MouseEvent.CLICK, handleVolume );
				asset.controls.buttonPlayPause.addEventListener( MouseEvent.CLICK, handlePlayPause );
			}
			
			asset.controls.buttonMode	= true;
			
			addEventListener( Event.ENTER_FRAME, handleEnterFrame );
			
//			asset.controls.buttonFullscreen.addEventListener( MouseEvent.CLICK, handleFullscreen );
			
			asset.controls.seekBar.addEventListener( MouseEvent.CLICK, handleSeekClick );
			
			addChild( asset );
		}
		
		private function handleYTPlayerPlaying(e:YouTubePlayerEvent):void
		{
			asset.controls.buttonPlayPause.pause_mc.visible	= true;
			asset.controls.buttonPlayPause.play_mc.visible	= false;
		}
		
		private function handleYTPlayerEnded(e:YouTubePlayerEvent):void
		{
			asset.controls.buttonPlayPause.pause_mc.visible	= false;
			asset.controls.buttonPlayPause.play_mc.visible	= true;
		}
		
		private function handleVolume(e:MouseEvent):void
		{
			var p:YouTubePlayerAS3	= player as YouTubePlayerAS3;
			
			if ( p.isMuted() )
			{
				p.unMute();
				
				asset.controls.buttonVolume.off_mc.visible	= false;
				asset.controls.buttonVolume.on_mc.visible	= true;
			}
			else
			{
				p.mute();
				
				asset.controls.buttonVolume.off_mc.visible	= true;
				asset.controls.buttonVolume.on_mc.visible	= false;
			}
		}
		
		private function handlePlayPause(e:MouseEvent):void
		{
			var p:YouTubePlayerAS3	= player as YouTubePlayerAS3;
			
			if ( p.playing )
			{
				p.pause();
				
				asset.controls.buttonPlayPause.pause_mc.visible	= false;
				asset.controls.buttonPlayPause.play_mc.visible	= true;
			}
			else
			{
				p.resume();
				
				asset.controls.buttonPlayPause.pause_mc.visible	= true;
				asset.controls.buttonPlayPause.play_mc.visible	= false;
			}
		}
		
		private function handleEnterFrame(e:Event):void
		{
			/*if ( asset.player.playing )
			{*/
				asset.controls.seekBar.playBar.width	= asset.controls.seekBar.width * ( currentTime / totalTime );
				
//				asset.controls.time.text				= NumberUtil.toTimeString( asset.player.playheadTime );
//			}
		}
		
		private function handleSeekClick(e:MouseEvent):void
		{
			var t:Number	= ( asset.controls.seekBar.mouseX / asset.controls.seekBar.width ) * totalTime;
			
			if ( player is YouTubePlayerAS3 )
			{
				player.seekTo( t );
			}
			else
			{
				asset.player.seek( t );
			}
		}
		
		/*private function handleMouse(e:MouseEvent):void
		{
			trace(e);
			
			e.stopImmediatePropagation();
			
			TweenMax.killTweensOf( asset.controls );
			
			TweenMax.to( asset.controls, .5, { autoAlpha: e.type == MouseEvent.ROLL_OUT ? 0 : 1 } );
		}*/
		
		private function handleFullscreen(e:MouseEvent):void
		{
			if ( stage.displayState == StageDisplayState.FULL_SCREEN )
			{
				stage.displayState	= StageDisplayState.NORMAL;
			}
			else
			{
				//stage.fullScreenSourceRect	= new Rectangle( 0, 0, stage.stageWidth, stage.stageHeight );
				
				stage.displayState	= StageDisplayState.FULL_SCREEN;
			}
		}
		
		private function get currentTime():Number
		{
			return player is YouTubePlayerAS3 ? player.getCurrentTime() : asset.player.playheadTime;
		}
		
		private function get totalTime():Number
		{
			return player is YouTubePlayerAS3 ? player.getDuration() : asset.player.totalTime;
		}
	}
}