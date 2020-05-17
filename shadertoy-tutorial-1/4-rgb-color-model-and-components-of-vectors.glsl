void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  float redAmount = 0.8;
  float greenAmount = 0.4;
  float blueAmount = 0.0;

  // "vec3(x)" is equivalent to vec3(x, x, x);
  vec3 color = vec3(0.0);

  color.x = redAmount;
  color.y = greenAmount;
  color.z = blueAmount;

  float alpha = 1.0;
  vec4 pixel = vec4(color, alpha);
  fragColor = pixel;
}
