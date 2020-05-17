// alpha (transparancy) no effect here
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec3 color = vec3(1.0, 0.5, 0.0);
  float alpha = 1.0;

  vec4 pixel = vec4(color, alpha);
  fragColor = pixel;
}