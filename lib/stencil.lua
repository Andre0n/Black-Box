local stencil, gr = {}, love.graphics
local pi, sin, cos, floor = math.pi, math.sin, math.cos, math.floor

stencil.create = function( a )
	local poly = stencil.newPoly( a.x, a.y, a.w, a.h, a.sides )
	function stencilfunction()
		gr.polygon( 'fill', poly )
		end
	return poly
	end

stencil.shape = function( fn, par )
	function stencilfunction()
		fn( 'fill', unpack( par ) )
		end
	end

stencil.draw = function( mode, func, ... )
	gr.stencil( stencilfunction, action, 1 )
	if mode == 'outside' then
		gr.setStencilTest( 'less', 1 )		-- outside area
		elseif mode == 'inside' then
		gr.setStencilTest( 'greater', 0 )	-- inside area
		end
	func( ... )					-- pass params to func[tion]
	gr.setStencilTest()
	end
	
stencil.newPoly = function( x, y, rx, ry, s, a )	-- center x&y, radii(x,y), # sides, angle offset
	local tab, a = {}, a or 0
	local a = a + 1.5 * pi
	for i = 0, 2 * pi*(1 - 1/ (s+1)), 2 * pi / s do
		tab[#tab+1] = floor(rx  * cos(i+a) + x)
		tab[#tab+1] = floor(ry  * sin(i+a) + y)
		end
	return tab
	end

stencil.newEllipse = function( x, y, rx, ry, an, res )
	local res	= res or 32
	local an		= an or 0
	local tab	= {}
	local s, c	= sin( an + pi ), cos( an + pi )
	for i = 0, 2 * pi - 2 * pi / res, 2 * pi / res do
		dx = rx * cos(i)
		dy = ry * sin(i)
		tab[#tab+1] = c * dx - s * dy + x
		tab[#tab+1] = s * dx + c * dy + y
		end
	return tab	-- ellipse vertices needed for gr.polygon
	end

stencil.newRectangle = function( x, y, w, h, a )	-- rotation around center
	local tab = {}
	local l, r = x - w / 2, x + w / 2
	local t, b = y + h / 2, y - h / 2
	local a = a or 0
	tab[1], tab[2] = stencil.rotatePoint( l, t, a, x, y )
	tab[3], tab[4] = stencil.rotatePoint( r, t, a, x, y )
	tab[5], tab[6] = stencil.rotatePoint( r, b, a, x, y )
	tab[7], tab[8] = stencil.rotatePoint( l, b, a, x, y )
	return tab	-- vertices needed for gr.polygon
	end

stencil.rotatePoint = function( px, py, an, cx, cy )	-- x,y rotated around cx,cy
	local c, s = cos( an ), sin( an )
	return c * ( px-cx ) - s * ( py-cy ) + cx, s * ( px-cx ) + c * ( py-cy ) + cy
	end

return stencil