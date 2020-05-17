float linearstep(float edge0, float edge1, float x) {
  float t = (x - edge0) / (edge1 - edge0);
  return clamp(t, 0.0, 1.0);
}
float smootherstep(float edge0, float edge1, float x) {
  float t = (x - edge0) / (edge1 - edge0);
  float t1 = t * t * t * (t * (t * 6. - 15.) + 10.);
  return clamp(t1, 0.0, 1.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 r = 2.0 * vec2(fragCoord.xy - 0.5 * iResolution.xy) / iResolution.y;
  float xMax = iResolution.x / iResolution.y;

  vec3 bgCol = vec3(0.3);
  vec3 col1 = vec3(0.216, 0.471, 0.698); // blue
  vec3 col2 = vec3(1.00, 0.329, 0.298);  // yellow
  vec3 col3 = vec3(0.867, 0.910, 0.247); // red

  vec3 pixel = bgCol;
  float m;

  float radius = 0.4;      // increase this to see the effect better
  if (r.x < -0.5 * xMax) { // Part I
    // no interpolation, yes aliasing
    m = step(radius, length(r - vec2(-0.5 * xMax - 0.4, 0.0)));
    // if the distance from the center is smaller than radius,
    // then mix value is 0.0
    // otherwise the mix value is 1.0
    pixel = mix(col1, bgCol, m);
  } else if (r.x < -0.0 * xMax) { // Part II
    // linearstep (first order, linear interpolation)
    m = linearstep(radius - 0.005, radius + 0.005,
                   length(r - vec2(-0.0 * xMax - 0.4, 0.0)));
    // mix value is linearly interpolated when the distance to the center
    // is 0.005 smaller and greater than the radius.
    pixel = mix(col1, bgCol, m);
  } else if (r.x < 0.5 * xMax) { // Part III
    // smoothstep (cubical interpolation)
    m = smoothstep(radius - 0.005, radius + 0.005,
                   length(r - vec2(0.5 * xMax - 0.4, 0.0)));
    pixel = mix(col1, bgCol, m);
  } else if (r.x < 1.0 * xMax) { // Part IV
    // smootherstep (sixth order interpolation)
    m = smootherstep(radius - 0.005, radius + 0.005,
                     length(r - vec2(1.0 * xMax - 0.4, 0.0)));
    pixel = mix(col1, bgCol, m);
  }

  fragColor = vec4(pixel, 1.0);
}