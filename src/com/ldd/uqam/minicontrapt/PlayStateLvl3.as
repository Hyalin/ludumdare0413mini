package com.ldd.uqam.minicontrapt
{
	import org.flixel.*;
 
	public class PlayStateLvl3 extends FlxState
	{
		public var p1:SquarePlayer;
		public var p2:SecondPlayer;
		
		[Embed(source = '../../../../../Assets/Level3.png')] private var ImgTiles:Class;
		[Embed(source = '../../../../../Assets/Level3.txt', mimeType = "application/octet-stream")] private var DataMap:Class;
		[Embed(source = '../../../../../Assets/BlackFlag.png')] private var ImgFlag:Class;
		[Embed(source = '../../../../../Assets/button_down.png')] private var ImgBtnDown:Class;
		[Embed(source = '../../../../../Assets/button_up.png')] private var ImgBtnUp:Class;
		[Embed(source = '../../../../../Assets/Door.png')] private var ImgDoor:Class;
		[Embed(source="../../../../../Assets/platformer-lvl-1.jpg")] public static var LevelSprite:Class;
		private var _map:FlxTilemapExt;
		public static var lyrStage:FlxGroup;
		private var deathLine: FlxGroup;
		
		override public function create():void
		{	
			FlxG.worldBounds.width = 1500;
			var bg:FlxSprite = new FlxSprite(16, 16, LevelSprite);
            add(bg);
			
			_map = new FlxTilemapExt;
			_map.loadMap(new DataMap, ImgTiles, 16); 
			lyrStage = new FlxGroup;
			var tempFL:Array = new Array("7");
			var tempFR:Array = new Array("6");
			var tempCL:Array = new Array();
			var tempCR:Array = new Array();
			_map.setSlopes(tempFL, tempFR, tempCL, tempCR);
            lyrStage.add(_map);
			_map.immovable = true;
			this.add(lyrStage);
			
			this.deathLine = RedSquareOfDeath.create_death_line(2500, 448);
			add(this.deathLine);
			
			p1 = new SquarePlayer(50,50);
			add(p1);
			
			p2 = new SecondPlayer(255,50);
			add(p2);
			
			FlxG.camera.follow(p1, 1);
		}
		
		override public function update():void
		{
			FlxG.collide(p1, _map);
			FlxG.collide(p2, _map);
			FlxG.collide(p1, p2);
			
			if (FlxG.collide(p1, this.deathLine)) {
				this.p1.x = 50;
				this.p1.y = 50;
			}
			FlxG.collide(this.deathLine, _map);
			
			if (FlxG.keys.K) {
				this.p1.x = 50;
				this.p1.y = 50;
			}
			
			super.update();
		}
	}
}