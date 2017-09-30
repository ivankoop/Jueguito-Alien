package;

import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;

class MapLoader
{
	
	var loader:FlxOgmoLoader;
	var tile:FlxTilemap;
	var ground:FlxTilemap;
	
	var returnTile:FlxTilemap;
	var returnGround:FlxTilemap;
	
	
	var tiles:Map<String, Array<String>> = [
		"firstTiles" => ["assets/images/Spritesheets/spritesheet_tiles.png", "walls"],
		"firstGround" => ["assets/images/Spritesheets/spritesheet_ground.png", "tiles"]
	];
	
	public function new(tile:String, ground:String) 
	{
		loader = new FlxOgmoLoader("assets/data/level11.oel");
		
		returnTile = loader.loadTilemap(tiles[tile][0], 128, 128, tiles[tile][1]);
		returnTile.follow();
		returnGround = loader.loadTilemap(tiles[ground][0], 128, 128, tiles[ground][1]);
		returnGround.follow();
		returnGround.setTileProperties(1, FlxObject.ANY);
	}
	public function load():Array<FlxTilemap>
	{
		return [returnTile, returnGround];
	}

}