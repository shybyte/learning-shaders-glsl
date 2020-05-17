#define PI 3.14159265359
#define TWOPI 6.28318530718

// COORDINATE TRANSFORMATIONS: ROTATION
//
// Up to now, we translated to coordinate center to draw geometric
// shapes at different parts of the screen.
// Lets learn how to rotate the shapes.

// a function that draws an (anti-aliased) grid of coordinate system
float coordinateGrid(vec2 r) {
	vec3 axesCol = vec3(0.0, 0.0, 1.0);
	vec3 gridCol = vec3(0.5);
	float ret = 0.0;
	
	// Draw grid lines
	const float tickWidth = 0.1;
	for(float i=-2.0; i<2.0; i+=tickWidth) {
		// "i" is the line coordinate.
		ret += 1.-smoothstep(0.0, 0.008, abs(r.x-i));
		ret += 1.-smoothstep(0.0, 0.008, abs(r.y-i));
	}
	// Draw the axes
	ret += 1.-smoothstep(0.001, 0.015, abs(r.x));
	ret += 1.-smoothstep(0.001, 0.015, abs(r.y));
	return ret;
}
// returns 1.0 if inside circle
float disk(vec2 r, vec2 center, float radius) {
	return 1.0 - smoothstep( radius-0.005, radius+0.005, length(r-center));
}
// returns 1.0 if inside the rectangle
float rectangle(vec2 r, vec2 topLeft, vec2 bottomRight) {
	float ret;
	float d = 0.005;
	ret = smoothstep(topLeft.x-d, topLeft.x+d, r.x);
	ret *= smoothstep(topLeft.y-d, topLeft.y+d, r.y);
	ret *= 1.0 - smoothstep(bottomRight.y-d, bottomRight.y+d, r.y);
	ret *= 1.0 - smoothstep(bottomRight.x-d, bottomRight.x+d, r.x);
	return ret;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 p = vec2(fragCoord.xy / iResolution.xy);
	vec2 r =  2.0*vec2(fragCoord.xy - 0.5*iResolution.xy)/iResolution.y;
	float xMax = iResolution.x/iResolution.y;	
	
	vec3 bgCol = vec3(1.0);
	vec3 col1 = vec3(0.216, 0.471, 0.698); // blue
	vec3 col2 = vec3(1.00, 0.329, 0.298); // yellow
	vec3 col3 = vec3(0.867, 0.910, 0.247); // red
	
	vec3 ret;
	
	vec2 q;
	float angle;
	angle = 0.20*PI; // angle in radians (PI is 180 degrees)
	// q is the rotated coordinate system
	q.x =   cos(angle)*r.x + sin(angle)*r.y;
	q.y = - sin(angle)*r.x + cos(angle)*r.y;
	
	ret = bgCol;
	// draw the old and new coordinate systems
	ret = mix(ret, col1, coordinateGrid(r)*0.4 );
	ret = mix(ret, col2, coordinateGrid(q) );
	
	// draw shapes in old coordinate system, r, and new coordinate system, q
	ret = mix(ret, col1, disk(r, vec2(1.0, 0.0), 0.2));
	ret = mix(ret, col2, disk(q, vec2(1.0, 0.0), 0.2));
	ret = mix(ret, col1, rectangle(r, vec2(-0.8, 0.2), vec2(-0.5, 0.4)) );	
	ret = mix(ret, col2, rectangle(q, vec2(-0.8, 0.2), vec2(-0.5, 0.4)) );	
	// as you see both circle are drawn at the same coordinate, (1,0),
	// in their respective coordinate systems. But they appear
	// on different locations of the screen
		
	vec3 pixel = ret;
	fragColor = vec4(pixel, 1.0);
}