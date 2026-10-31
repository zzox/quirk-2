package core.gameobjects;

import core.system.Camera;
import kha.Assets;
import kha.graphics2.Graphics;

// basically a rect but using a pixel
class ScalePixel extends GameObject {
    public var width:Int;
    public var height:Int;

    public function new (x:Float, y:Float, width:Int, height:Int) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }

    override function update (detla:Float) {}

    override function render (g2:Graphics, camera:Camera) {
        g2.pushTranslation(-camera.scrollX * scrollFactorX, -camera.scrollY * scrollFactorY);
        g2.pushScale(camera.scale, camera.scale);

        g2.color = Math.floor(255 * alpha) * 0x1000000 | color;
        g2.drawScaledImage(Assets.images.pixel, x, y, width, height);

        g2.popTransformation();
        g2.popTransformation();
    }
}
