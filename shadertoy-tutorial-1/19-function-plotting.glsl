#define PI 3.14159265359
#define TWOPI 6.28318530718

// FUNCTION PLOTTING
//
// It is always useful to see the plots of functions on cartesian
// coordinate system, to understand what they are doing precisely
//
// Let's plot some 1D functions!
//
// If y value is a function f of x value, the expression of their
// relation is: y = f(x)
// in other words, the plot of a function is all points
// that satisfy the expression: y-f(x)=0
// this set has 0 thickness, and can't be seen.
// Instead use the set of (x,y) that satisfy: -d < y-f(x) < d
// in other words abs(y-f(x)) < d
// where d is the thickness. (the thickness in in y direction)
// Because of the properties of absolute function, the condition
// abs(y-f(x)) < d is equivalent to the condition:
// abs(f(x) - y) < d
// We'll use this last one for function plotting. (in the previous one
// we have to negate the function that we want to plot)
float linearstep(float edge0, float edge1, float x) {
  float t = (x - edge0) / (edge1 - edge0);
  return clamp(t, 0.0, 1.0);
}
float smootherstep(float edge0, float edge1, float x) {
  float t = (x - edge0) / (edge1 - edge0);
  float t1 = t * t * t * (t * (t * 6. - 15.) + 10.);
  return clamp(t1, 0.0, 1.0);
}

void plot(vec2 r, float y, float lineThickness, vec3 color, inout vec3 pixel) {
  if (abs(y - r.y) < lineThickness)
    pixel = color;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 r = 2.0 * vec2(fragCoord.xy - 0.5 * iResolution.xy) / iResolution.y;

  vec3 bgCol = vec3(1.0);
  vec3 axesCol = vec3(0.0, 0.0, 1.0);
  vec3 gridCol = vec3(0.5);
  vec3 col1 = vec3(0.841, 0.582, 0.594);
  vec3 col2 = vec3(0.884, 0.850, 0.648);
  vec3 col3 = vec3(0.348, 0.555, 0.641);

  vec3 pixel = bgCol;

  // Draw grid lines
  const float tickWidth = 0.1;
  for (float i = -2.0; i < 2.0; i += tickWidth) {
    // "i" is the line coordinate.
    if (abs(r.x - i) < 0.004)
      pixel = gridCol;
    if (abs(r.y - i) < 0.004)
      pixel = gridCol;
  }
  // Draw the axes
  if (abs(r.x) < 0.006)
    pixel = axesCol;
  if (abs(r.y) < 0.007)
    pixel = axesCol;

  // Draw functions
  float x = r.x;
  float y = r.y;
  // pink functions
  // y = 2*x + 5
  if (abs(2. * x + .5 - y) < 0.02)
    pixel = col1;
  // y = x^2 - .2
  if (abs(r.x * r.x - 0.2 - y) < 0.01)
    pixel = col1;
  // y = sin(PI x)
  if (abs(sin(PI * r.x) - y) < 0.02)
    pixel = col1;

  // blue functions, the step function variations
  // (functions are scaled and translated vertically)
  if (abs(0.25 * step(0.0, x) + 0.6 - y) < 0.01)
    pixel = col3;
  if (abs(0.25 * linearstep(-0.5, 0.5, x) + 0.1 - y) < 0.01)
    pixel = col3;
  if (abs(0.25 * smoothstep(-0.5, 0.5, x) - 0.4 - y) < 0.01)
    pixel = col3;
  if (abs(0.25 * smootherstep(-0.5, 0.5, x) - 0.9 - y) < 0.01)
    pixel = col3;

  // yellow functions
  // have a function that plots functions :-)
  plot(r, 0.5 * clamp(sin(TWOPI * x), 0.0, 1.0) - 0.7, 0.015, col2, pixel);
  // bell curve around -0.5
  plot(r, 0.6 * exp(-10.0 * (x + 0.8) * (x + 0.8)) - 0.1, 0.015, col2, pixel);

  fragColor = vec4(pixel, 1.0);
}
// in the future we can use this framework to see the plot of functions
// and design and find functions for our liking
// Actually using Mathematica, Matlab, matplotlib etc. to plot functions
// is much more practical. But they need a translation of functions
// from GLSL to their language. Here we can plot the native implementations
// of GLSL functions.