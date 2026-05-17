package;

import funkin.FunkinAssets;
#if VIDEOS_ALLOWED import funkin.video.FunkinVideoSprite; #end

@:access(flixel.FlxGame)
class Splash extends flixel.FlxState {
    var _cachedAutoPause:Bool;
    
    #if VIDEOS_ALLOWED var video:FunkinVideoSprite; #end

    override function create() {
        super.create();
        
        _cachedAutoPause = FlxG.autoPause = false;

        FlxTimer.wait(1, () -> start());
    }

    function start() {
        #if VIDEOS_ALLOWED 
            add(video = new FunkinVideoSprite());
            video.onFormat(() -> {
                video.setGraphicSize(0, FlxG.height);
                video.updateHitbox();
                video.screenCenter();
            });
            video.onEnd(finish);
            if (video.load(Paths.video('intro'))) video.delayAndStart();
			else
        #end
    }

    override function update(elapsed:Float) {
        #if VIDEOS_ALLOWED 
            if (video != null) {
                if (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER)
                    finish();
            }
        #end

        super.update(elapsed);
    }

    function finish() {
        #if VIDEOS_ALLOWED 
            video.stop();
            video.destroy();
        #end

        FlxG.sound.muted = FlxG.save.data.muted;
        FlXG.sound.volume = FlxG.save.data.volume;

        FlxG.autoPause = _cachedAutoPause;

        FlxG.switchState(() -> Type.createInstance(Main.startMeta.initialState, []));
    }
}