package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Background extends FlxSprite 
{
	var backgrounds:Map<String, String> = [
		"blueDesert" => "assets/images/Backgrounds/blue_desert.png",
		"blueGrass" => "assets/images/Backgrounds/blue_grass.png",
		"blueLand" => "assets/images/Backgrounds/blue_land.png",
		"blueShroom" => "assets/images/Backgrounds/blues_shroom.png",
		"coloredDesert" => "assets/images/Backgrounds/colored_desert.png",
		"coloredGrass" => "assets/images/Backgrounds/colored_grass.png",
		"coloredLand" => "assets/images/Backgrounds/colored_land.png",
		"coloredShroom" => "assets/images/Backgrounds/colored_shroom.png"
	];
	
	public function new(backgroundChoice:String) 
	{
		super(0, 0);
		this.loadGraphic(backgrounds[backgroundChoice], false);
	}	
	
	public function movement(playerPosition:Float)
	{
		this.setPosition(playerPosition - (FlxG.width/2 - 64), 0);
	}
}

