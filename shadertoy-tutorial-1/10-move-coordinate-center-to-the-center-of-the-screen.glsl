void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 r = vec2( fragCoord.xy - 0.5*iResolution.xy );
	// [0, iResolution.x] -> [-0.5*iResolution.x, 0.5*iResolution.x]
	// [0, iResolution.y] -> [-0.5*iResolution.y, 0.5*iResolution.y]
	r = 2.0 * r.xy / iResolution.xy;
	// [-0.5*iResolution.x, 0.5*iResolution.x] -> [-1.0, 1.0]
	
	vec3 backgroundColor = vec3(1.0);
	vec3 axesColor = vec3(0.0, 0.0, 1.0);
	vec3 gridColor = vec3(0.5);

	// start by setting the background color. If pixel's value
	// is not overwritten later, this color will be displayed.
	vec3 pixel = backgroundColor;
	
	// Draw the grid lines
	// This time instead of going over a loop for every pixel
    // we'll use mod operation to achieve the same result
    // with a single calculation (thanks to mikatalk)
	const float tickWidth = 0.1;
	if( mod(r.x, tickWidth) < 0.008 ) pixel = gridColor;
    if( mod(r.y, tickWidth) < 0.008 ) pixel = gridColor;
    // Draw the axes
	if( abs(r.x)<0.006 ) pixel = axesColor;
	if( abs(r.y)<0.007 ) pixel = axesColor;
	
	fragColor = vec4(pixel, 1.0);
}