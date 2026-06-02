package core.gameobjects;

import core.Types;
import core.components.Component;
import core.system.Camera;
import kha.graphics2.Graphics;

class Triangle extends GameObject {
    var v1:Vec2;
    var v2:Vec2;
    var v3:Vec2;

    public function new (v1:Vec2, v2:Vec2, v3:Vec2) {
        this.v1 = v1;
        this.v2 = v2;
        this.v3 = v3;
    }

    override function update (delta:Float) {}

    override function render (g2:Graphics, camera:Camera) {
        g2.pushTranslation(-camera.scrollX * scrollFactorX, -camera.scrollY * scrollFactorY);
        g2.pushScale(camera.scale, camera.scale);

        g2.color = Math.floor(255 * alpha) * 0x1000000 | color;
        g2.fillTriangle(v1.x, v1.y, v2.x, v2.y, v3.x, v3.y);

        g2.popTransformation();
        g2.popTransformation();
    }
}
