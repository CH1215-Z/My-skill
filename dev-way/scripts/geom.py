"""Small geometry helpers for explanation figures: offset a polygon outward, line intersection, mm -> SVG points."""
import math

def inside(poly):
    def f(pt):
        x, y = pt; c = False
        for i in range(len(poly)):
            (x1, y1), (x2, y2) = poly[i], poly[(i + 1) % len(poly)]
            if (y1 > y) != (y2 > y) and x < (x2 - x1) * (y - y1) / (y2 - y1) + x1: c = not c
        return c
    return f

def offset_line(p, q, d, ins):
    """Line p-q moved by d away from the inside test ins."""
    dx, dy = q[0] - p[0], q[1] - p[1]; L = math.hypot(dx, dy); nx, ny = -dy / L, dx / L
    if ins(((p[0] + q[0]) / 2 + nx * 3, (p[1] + q[1]) / 2 + ny * 3)): nx, ny = -nx, -ny
    return (p[0] + nx * d, p[1] + ny * d), (q[0] + nx * d, q[1] + ny * d)

def cross(l1, l2):
    (x1, y1), (x2, y2) = l1; (x3, y3), (x4, y4) = l2
    den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
    t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den
    return (x1 + t * (x2 - x1), y1 + t * (y2 - y1))

def grow(poly, d):
    """Every side moved outward by d (mitred corners)."""
    ins = inside(poly); n = len(poly)
    ls = [offset_line(poly[i], poly[(i + 1) % n], d, ins) for i in range(n)]
    return [cross(ls[i - 1], ls[i]) for i in range(n)]

def svg_points(pts, ox, oy, s):
    """mm (y up) -> SVG (y down) at scale s px/mm from the origin (ox, oy)."""
    return " ".join(f"{ox + x * s:.1f},{oy - y * s:.1f}" for x, y in pts)
