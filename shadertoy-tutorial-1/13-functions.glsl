void disk(vec2 r, vec2 center, float radius, vec3 color, inout vec3 pixel) {
	if( length(r-center) < radius) {
		pixel = color;
	}
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 r =  2.0*vec2(fragCoord.xy - 0.5*iResolution.xy)/iResolution.y;
	
	vec3 bgCol = vec3(0.3);
	vec3 col1 = vec3(0.216, 0.471, 0.698); // blue
	vec3 col2 = vec3(1.00, 0.329, 0.298); // yellow
	vec3 col3 = vec3(0.867, 0.910, 0.247); // red

	vec3 pixel = bgCol;
	
	disk(r, vec2(0.1, 0.3), 0.5, col3, pixel);
	disk(r, vec2(-0.8, -0.6), 1.5, col1, pixel);
	disk(r, vec2(0.8, 0.0), .15, col2, pixel);
	
	fragColor = vec4(pixel, 1.0);
}