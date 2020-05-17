// BUILT-IN FUNCTIONS: STEP
//
// "step" function is the Heaviside step function :-)
// http://en.wikipedia.org/wiki/Heaviside_step_function
// 
// f(x0, x) = {1 x>x0, 
//            {0 x<x0
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 r = 2.0 * vec2(fragCoord.xy - 0.5 * iResolution.xy) / iResolution.y;
  float xMax = iResolution.x / iResolution.y;

  vec3 bgCol = vec3(0.0);                // black
  vec3 col1 = vec3(0.216, 0.471, 0.698); // blue
  vec3 col2 = vec3(1.00, 0.329, 0.298);  // yellow
  vec3 col3 = vec3(0.867, 0.910, 0.247); // red

  vec3 pixel = bgCol;

  float edge, variable, ret;

  // divide the screen into five parts horizontally
  // for different examples
  if (r.x < -0.6 * xMax) { // Part I
    variable = r.y;
    edge = 0.2;
    if (variable > edge) { // if the "variable" is greater than "edge"
      ret = 1.0;           // return 1.0
    } else {               // if the "variable" is less than "edge"
      ret = 0.0;           // return 0.0
    }
  } else if (r.x < -0.2 * xMax) { // Part II
    variable = r.y;
    edge = -0.2;
    ret = step(edge, variable);  // step function is equivalent to the
                                 // if block of the Part I
  } else if (r.x < 0.2 * xMax) { // Part III
    // "step" returns either 0.0 or 1.0.
    // "1.0 - step" will inverse the output
    ret = 1.0 - step(0.5, r.y);  // Mirror the step function around edge
  } else if (r.x < 0.6 * xMax) { // Part IV
    // if y-coordinate is smaller than -0.4 ret is 0.3
    // if y-coordinate is greater than -0.4 ret is 0.3+0.5=0.8
    ret = 0.3 + 0.5 * step(-0.4, r.y);
  } else { // Part V
    // Combine two step functions to create a gap
    ret = step(-0.3, r.y) * (1.0 - step(0.2, r.y));
    // "1.0 - ret" will create a gap
  }

  pixel = vec3(ret); // make a color out of return value.
  fragColor = vec4(pixel, 1.0);
}