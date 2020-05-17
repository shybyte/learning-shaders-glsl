void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 r = vec2(fragCoord.xy / iResolution.xy);

  vec3 backgroundColor = vec3(1.0);
  vec3 color1 = vec3(0.216, 0.471, 0.698);
  vec3 color2 = vec3(1.00, 0.329, 0.298);
  vec3 color3 = vec3(0.867, 0.910, 0.247);

  vec3 pixel = backgroundColor;

  float leftCoord = 0.54;
  float rightCoord = 0.55;
  if (r.x < rightCoord && r.x > leftCoord)
    pixel = color1;

  float lineCoordinate = 0.4;
  float lineThickness = 0.003;
  if (abs(r.x - lineCoordinate) < lineThickness)
    pixel = color2;

  if (abs(r.y - 0.6) < 0.01)
    pixel = color3;

  fragColor = vec4(pixel, 1.0);
}
