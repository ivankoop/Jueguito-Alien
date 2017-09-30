package;

import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxG;

import flixel.ui.FlxButton;

class PlayState extends FlxState
{
	var currentBackground:Background;
	var currentMap:MapLoader;
	var currentPlayer:Player;
 
	override public function create():Void
	{
		super.create();
		
		currentBackground = new Background("blueGrass");
		this.add(currentBackground);
		
		currentMap = new MapLoader("firstTiles", "firstGround");
		for (maps in currentMap.load())
		{
			add(maps);
		}
		
		currentPlayer = new Player();
		add(currentPlayer);
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.camera.follow(currentPlayer, PLATFORMER, 1);
		FlxG.collide(currentPlayer, currentMap.load()[1]);
		FlxG.collide(currentPlayer, currentMap.load()[0]);
		super.update(elapsed);
	}
}
