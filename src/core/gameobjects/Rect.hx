package core.gameobjects;

import core.Types;
import core.components.Component;
import core.system.Camera;
import kha.graphics2.Graphics;

class Rect extends GameObject {
    var width:Int;
    var height:Int;

    public function new (x:Float, y:Float, width:Int, height:Int) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }

    override function update (delta:Float) {}

    override function render (g2:Graphics, camera:Camera) {
        g2.pushTranslation(-camera.scrollX * scrollFactorX, -camera.scrollY * scrollFactorY);
        g2.pushScale(camera.scale, camera.scale);

        g2.color = Math.floor(255 * alpha) * 0x1000000 | color;
        g2.fillRect(x, y, width, height);

        g2.popTransformation();
        g2.popTransformation();
    }
}
