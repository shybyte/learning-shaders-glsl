void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec3 color1 = vec3(0.741, 0.635, 0.471);
  vec3 color2 = vec3(0.192, 0.329, 0.439);
  vec3 pixel;

  pixel = (fragCoord.x > iResolution.x / 2.0) ? color1 : color2;

  fragColor = vec4(pixel, 1.0);
}