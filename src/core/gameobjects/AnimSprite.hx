package core.gameobjects;

import core.gameobjects.Sprite;

typedef AnimItem = {
    var name:String;
    var frames:Array<Int>;
    var frameTime:Int;
    var repeats:Bool;
}

class AnimSprite extends Sprite {
    var _animations:Map<String, AnimItem> = new Map();

    var frame:Int = 0;
    var currentAnim:AnimItem;

    public function addAnim (name:String, frames:Array<Int>, frameTime:Int = 1, repeats:Bool = true) {
        _animations[name] = {
            name: name,
            frames: frames,
            frameTime: frameTime,
            repeats: repeats
        };
    }

    // Play animation by name.  Won't restart same anim unless forced.
    public function playAnim (name:String, forceRestart:Bool = false) {
        // isPaused = false;
        // NOTE: `|| completed` isn't adequately tested
        if (forceRestart /*|| completed*/ || currentAnim == null || name != currentAnim.name) {
            frame = 0;
            currentAnim = _animations.get(name);
            // completed = false;
            // HACK: without this a previous anim may play before the sprite is updated.
            // spriteRef.tileIndex = currentAnim.vals[0];
        }
    }

    override function update (delta:Float) {
        // unnecessary null-check? compilation macro in future?
        if (currentAnim == null) {
            return;
        }

        final f = currentAnim.repeats ?
            ++frame % (currentAnim.frames.length * currentAnim.frameTime) :
            Math.min(++frame, currentAnim.frames.length * currentAnim.frameTime - 1);
        tileIndex = currentAnim.frames[Math.floor(f / currentAnim.frameTime)];
    }
}
