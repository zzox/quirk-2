package core.gameobjects;

import core.system.Camera;
import kha.Font;
import kha.graphics2.Graphics;

class FontText extends GameObject {
    var font:Font;
    public var size:Int;
    public var textWidth:Int = 0;
    var text:String;

    public function new (x:Int = 0, y:Int = 0, font:Font, text:String = '', size:Int = 16) {
        this.x = x;
        this.y = y;
        this.font = font;
        this.size = size;
        setText(text);
    }

    override function update (delta:Float) {}

    override function render (g2:Graphics, camera:Camera) {
        g2.pushTranslation(-camera.scrollX * scrollFactorX, -camera.scrollY * scrollFactorY);
        g2.pushScale(camera.scale, camera.scale);

        g2.color = Math.floor(255 * alpha) * 0x1000000 | color;
        g2.font = font;
        g2.fontSize = size;
        g2.drawString(text, x, y);
        textWidth = Std.int(font.width(size, text));

        g2.popTransformation();
        g2.popTransformation();
    }

    public function setText (text:String) {
        this.text = text;
        textWidth = Std.int(font.width(size, text));
    }
}
