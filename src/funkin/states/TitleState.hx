package funkin.states;

class TitleState extends MusicBeatState {
    var logo:FlxSprite;
    var bg:FlxSprite;

    override function create() {
        logo = new FlxSprite().loadGraphic(Paths.image('menus/logo'));
        logo.screenCenter();
        
        bg = new FlxSprite();
        bg.frames = Paths.getSparrowAtlas('menus/titleBG');
        bg.animation.addByPrefix('anim', 'TitleMenuSSBG instance', 12, true);
        bg.animation.play('anim');

        add(bg);
        add(logo);

        super.create();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.ACCEPT)
            FlxG.switchState(() -> new MainMenuState());
    }
}