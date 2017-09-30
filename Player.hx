package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.FlxObject;

class Player extends FlxSprite 
{
	//hey george remember to add a condition that if they player is going down velocity.y > 0 and then it touches a wall then it must fall ok?
	//public var speed:Float = 1000;
	public var speed:Float = 1200;
	public var maxSpeed:Float = 1200*2;
	var gravity = 1000;
	var jumped:Bool;
	var jump:Float;
	//var jumpHeight:Int = -1000;
	var jumpHeight:Int = -600;
	// real one var jumpTime:Float = 0.33;
	var jumpTime:Float = 0.40;
	
	public var updateValue:Int = 250;
	public var downAcceleration:Int = 1000;
	
	public function new() 
	{
		super();
		
		this.loadGraphic("assets/images/Spritesheets/spritesheet_aliens.png", true, 126, 172);	
		
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		this.acceleration.y = this.gravity;
		this.drag.x = 11600;
		this.facing = FlxObject.RIGHT;
		
		this.animation.add("walk", [1, 2], 15, false);
		this.animation.add("idle", [0], 15, false);
		this.animation.add("jump", [3], 15, false);
		this.animation.add("duck", [4], 15, false);
	}
	
	override public function update(elapsed:Float):Void
	{
		movement(elapsed);
		super.update(elapsed);
	}
	
	public function movement(elapsed):Void
	{	
		if (FlxG.keys.anyPressed([DOWN, S])) 
		{
			if (velocity.x != 0)
			{
				if (velocity.x < 0)
				{
					velocity.x += elapsed;
				}
				else if (velocity.x > 0) 
				{
					velocity.x -= elapsed;
				}
			}
			animation.play("duck");
		}
		/*else if (FlxG.keys.anyPressed([RIGHT, D]) || FlxG.keys.anyPressed([LEFT, A]))
		{
			if (FlxG.keys.anyPressed([RIGHT, D]))
				velocity.x = speed;
			if (FlxG.keys.anyPressed([LEFT, A]))
				velocity.x = -speed;
		}
		else
		{
			velocity.x = 0;
			animation.play("idle");
		}*/
		
		else if (FlxG.keys.anyPressed([RIGHT, D]) || FlxG.keys.anyPressed([LEFT, A]))
		{
			if (acceleration.x < maxSpeed)
			{
				if (FlxG.keys.anyPressed([RIGHT, D]))
					acceleration.x = speed;
				if (FlxG.keys.anyPressed([LEFT, A]))
					acceleration.x = -speed;
			}
			else
			{
				if (FlxG.keys.anyPressed([RIGHT, D]))
					acceleration.x = maxSpeed;
				if (FlxG.keys.anyPressed([LEFT, A]))
					acceleration.x = -maxSpeed;
			}
		}
		else
		{
			acceleration.x = 0;
			animation.play("idle");
		}	
		
		//up speed 2
		
		if (velocity.x < 0)
			this.facing = FlxObject.LEFT;
		if (velocity.x > 0)
			this.facing = FlxObject.RIGHT;
			
		var jumpPressed:Bool = FlxG.keys.anyPressed([UP, W]);
		//var jumpPressed:Bool = FlxG.keys.justPressed.W;

		if (jumped && !jumpPressed)
			jumped = false;

		if (this.isTouching(FlxObject.DOWN) && !jumped)
			jump = 0;
			
		if (this.isTouching(FlxObject.RIGHT) && velocity.y > 0)
			this.velocity.y = gravity;
			
		if (this.isTouching(FlxObject.UP))
			this.velocity.y = gravity;

		if (jump >= 0 && jumpPressed)
		{
			jumped = true;
			//jump += elapsed;
			jump += elapsed;
			if (jump > jumpTime)
				jump = -1;
		}
		else
			jump = -1;
		
		if (jump > 0)
		{
			if (jump < 0.065)
				this.velocity.y = jumpHeight *2;//que tan rapido sube
			else
				//this.acceleration.y = 10;
				this.acceleration.y = downAcceleration; //que tan rapido cae
		}
		else
		{
			this.velocity.y = gravity;
		}
 
		if (velocity.x != 0 || velocity.y != 0) 
		{
			if (velocity.x != 0)
			{
				switch (facing)
				{
					case FlxObject.LEFT, FlxObject.RIGHT:
						animation.play("walk");
				}
			}
			if (velocity.y != 0 && touching != FlxObject.DOWN)
			{
				animation.play("jump");
			}
		}
		else if (touching == FlxObject.UP)
		{
			animation.play("idle");
		}
	}
}