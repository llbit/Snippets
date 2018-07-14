"""Context manager for rendering simple SVG images."""
class svg:
    """width/height: canvas dimensions, xmin/xmax,ymin/ymax: drawing bounds"""
    def __init__(self, fp, width, height, xmin=0, xmax=0, ymin=0, ymax=0, pad=0):
        self.fp = fp
        self.width = width
        self.height = height
        W = xmax-xmin if xmax-xmin else width
        H = ymax-ymin if ymax-ymin else height
        pwidth = width - 2*pad
        pheight = height - 2*pad
        # Use smallest scale so that all points fit in the canvas:
        if xmax == xmin:
            xmin = 0
            xmax = width
        if ymax == ymin:
            ymin = 0
            ymax = height
        xscale = pwidth / float(xmax - xmin)
        yscale = pheight / float(ymax - ymin)
        self.scale = min(xscale, yscale)
        xpad = (width - (xmax-xmin) * self.scale) / 2
        ypad = (height - (ymax-ymin) * self.scale) / 2
        # Point mapping function for scaling points to the canvas and
        # flipping the Y axis.
        self.pmap = lambda (x,y): (xpad + (x-xmin)*self.scale, ypad + (ymax-y)*self.scale)

    def __enter__(self):
        self.fp.write('<?xml version="1.0" encoding="UTF-8" ?>\n')
        self.fp.write('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="%f" height="%f">\n' \
                % (self.width, self.height))
        return self

    def __exit__(self, etype, value, traceback):
        self.fp.write('</svg>\n')

    def rect(self, x, y, width, height, attributes=""):
        p = self.pmap((x, y))
        self.fp.write('  <rect x="%f" y="%f" width="%f" height="%f" %s/>\n' \
                % (p[0], p[1], width, height, attributes))

    def circle(self, x, y, r, attributes=""):
        p = self.pmap((x, y))
        self.fp.write('  <circle cx="%f" cy="%f" r="%f" %s/>\n' \
                % (p[0], p[1], r * self.scale, attributes))

    def path(self, points, attributes="", closed=False):
        self.fp.write('  <path d="M')
        for p in points:
            self.fp.write(' %f,%f' % self.pmap(p))
        self.fp.write(' %s" %s/>\n' % ("z" if closed else "", attributes))

if __name__ == "__main__":
    # Usage example:
    with open('test.svg', 'w') as fp:
        with svg(fp, 100, 100) as fig:
            fig.circle(70, 50, 30, 'fill="red"')
            fig.rect(50, 50, 20, 20)
            fig.path([ (0, 50), (100, 50) ], 'stroke="blue" stroke-width="2"')
            fig.path([ (50, 0), (50, 100) ], 'stroke="green" stroke-width="2"')
            fig.path([ (0, 0), (5, 5), (5, 95), (95, 95) ], 'stroke="black" stroke-width="1" fill="none"')
