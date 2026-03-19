package game.scenes;

import core.Game;
import core.gameobjects.AnimSprite;
import core.scene.Scene;
import kha.Assets;
import kha.input.KeyCode;

class GameScene extends Scene {
    var xDir:Int = 2;
    var yDir:Int = 1;
    var testSprite:AnimSprite;

    override function create () {
        super.create();

        testSprite = new AnimSprite(0, 0, Assets.images.test_image, 16, 16, 40, [0, 1, 2, 3], true);
        entities.push(testSprite);
    }

    override function update (delta:Float) {
        if (Game.keys.pressed(KeyCode.Left)) {
            camera.bgColor = 0xffffff00;
        }
        if (Game.keys.pressed(KeyCode.Right)) {
            camera.bgColor = 0xffff00ff;
        }
        if (Game.keys.pressed(KeyCode.Up)) {
            camera.bgColor = 0xff00ffff;
        }
        if (Game.keys.pressed(KeyCode.Down)) {
            camera.bgColor = 0xff0000ff;
        }

        testSprite.angle = (2 + testSprite.angle) % 360;

        testSprite.x += xDir;
        testSprite.y += yDir;
        if (testSprite.x + 16 == game.bufferWidth || testSprite.x == 0) {
            xDir = -xDir;
        }

        if (testSprite.y + 16 == game.bufferHeight || testSprite.y == 0) {
            yDir = -yDir;
        }

        super.update(delta);
    }
}
