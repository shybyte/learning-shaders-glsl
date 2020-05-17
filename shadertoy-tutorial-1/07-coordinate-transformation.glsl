void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 r = vec2(fragCoord.x / iResolution.x, fragCoord.y / iResolution.y);

  vec3 color1 = vec3(0.841, 0.582, 0.594);
  vec3 color2 = vec3(0.884, 0.850, 0.648);
  vec3 color3 = vec3(0.348, 0.555, 0.641);
  vec3 pixel;

  if (r.x < 1.0 / 3.0) {
    pixel = color1;
  } else if (r.x < 2.0 / 3.0) {
    pixel = color2;
  } else {
    pixel = color3;
  }

  fragColor = vec4(pixel, 1.0);
}
