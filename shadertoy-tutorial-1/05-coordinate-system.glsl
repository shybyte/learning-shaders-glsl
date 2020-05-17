void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec3 red = vec3(1, 0, 0);
  vec3 yellow = vec3(1, 1, 0);
  vec3 green = vec3(0, 1, 0);
  vec3 blue = vec3(0, 0, 1);
  vec3 pixel;

  if (fragCoord.x > 100.0) {
    pixel = fragCoord.y > 100.0 ? red : yellow;
  } else {
    pixel = fragCoord.y > 100.0 ? green : blue;
  }

  fragColor = vec4(pixel, 1.0);
}