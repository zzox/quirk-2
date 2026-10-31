package core.util;

import core.Types;
import kha.math.Random;

function clamp (value:Float, min:Float, max:Float) {
    return Math.max(Math.min(value, max), min);
}

function lerp (target:Float, current:Float, percent:Float):Float {
    return current + (target - current) * percent;
}

function randomInt (ceil:Int) {
    return Math.floor(Math.random() * ceil);
}

function toRadians (value:Float):Float {
    return value * (Math.PI / 180);
}

function toDegrees (value:Float):Float {
    return value / (Math.PI / 180);
}

// from: https://github.com/HaxeFlixel/flixel/blob/dev/flixel/math/FlxVelocity.hx
function velocityFromAngle (angle:Float, velocity:Float):Vec2 {
    final a = toRadians(angle);
    return new Vec2(Math.cos(a) * velocity, Math.sin(a) * velocity);
}

// from: https://stackoverflow.com/questions/2676719/calculating-the-angle-between-a-line-and-the-x-axis
function angleFromPoints (p1x:Float, p1y:Float, p2x:Float, p2y:Float):Float {
    return toDegrees(Math.atan2(p1y - p2y, p1x - p2x));
}

function distanceBetween (x1:Float, y1:Float, x2:Float, y2:Float) {
    return Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
}

// Returns true if two rectangles overlap.
function rectOverlap (
    r1px:Float,
    r1py:Float,
    r1sx:Float,
    r1sy:Float,
    r2px:Float,
    r2py:Float,
    r2sx:Float,
    r2sy:Float
):Bool {
    return r1px + r1sx >= r2px
        && r1px <= r2px + r2sx
        && r1py + r1sy >= r2py
        && r1py <= r2py + r2sy;
}

function pointInRect (px:Float, py:Float, rx:Float, ry:Float, rw:Float, rh:Float) {
    return px >= rx && py >= ry && px < rx + rw && py < ry + rh;
}

function average (arr:Array<Float>):Float {
    if (arr.length == 0) return 0;
    return Lambda.fold(arr, (item, res) -> {
        return item + res;
    }, 0) / arr.length;
}

function nanZero (num:Float):Float {
    if (Math.isNaN(num)) {
        return 0.0;
    }

    return num;
}

function nanZeroDiv (num:Float, denom:Float):Float {
    if (denom == 0) {
        return 0;
    }

    return num / denom;
}

function shuffle<T> (items:Array<T>, rand:Random):Array<T> {
    for (i in 0...items.length) {
        final index = Math.floor(rand.GetFloat() * items.length);
        final temp = items[i];
        items[i] = items[index];
        items[index] = temp;
    }

    return items;
}

function vec2 (x:Float, y:Float):Vec2 {
    return new Vec2(x, y);
}

function sortVertices (verts:Array<Vec2>):Array<Vec2> {
    final center = new Vec2(0, 0);
    for (v in verts) {
        center.x += v.x;
        center.y += v.y;
    }

    center.x /= verts.length;
    center.y /= verts.length;

    verts.sort((a, b) -> {
        if (a.x >= 0 && b.x < 0) return 1;
        if (a.x == 0 && b.x == 0) return a.y > b.y ? 1 : -1;

        final det = (a.x - center.x) * (b.y - center.y) - (b.x - center.x) * (a.y - center.y);
        if (det < 0) return 1;
        if (det > 0) return -1;

        final d1 = (a.x - center.x) * (a.x - center.x) + (a.y - center.y) * (a.y - center.y);
        final d2 = (b.x - center.x) * (b.x - center.x) + (b.y - center.y) * (b.y - center.y);
        return d1 > d2 ? 1 : -1;
    });

    return verts;
}

function checkTooClose (point:Vec2, points:Array<Vec2>, distance:Float):Bool {
    for (p in points) {
        if (distanceBetween(point.x, point.y, p.x, p.y) < distance) {
            return true;
        }
    }
    return false;
}

// https://stackoverflow.com/questions/47410054/generate-random-locations-within-a-triangular-domain
function randomPointsInTriangle (points:Array<Vec2>, num:Int, ?maxFails:Int, ?tooCloseDist:Int = 2):Array<Vec2> {
    var fails = 0;

    if (maxFails == null) {
        maxFails = num;
    }

    final items = [];
    while (true) {
        final x = Math.random();
        final y = Math.random();
        final q = Math.abs(x - y);
        final s = q;
        final t = 0.5 * (x + y - q);
        final u = 1 - 0.5 * (q + x + y);
        final point = vec2(
            s * points[0].x + t * points[1].x + u * points[2].x,
            s * points[0].y + t * points[1].y + u * points[2].y
        );

        final isTooClose = checkTooClose(point, items, tooCloseDist);
        if (!isTooClose) {
            items.push(point);
        } else {
            fails++;
        }

        if (items.length == num) break;
        if (fails == maxFails) break;
    }

    return items;
}

function fixAngle (angle:Float):Float {
    while (angle < 0) angle += 360;
    return angle % 360;
}
