
float checker(vec2 uv, float repeats) {
  float cx = floor(repeats * uv.x);
  float cy = floor(repeats * uv.y);
  float result = mod(cx + cy, 2.0);
  return sign(result);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 r = vec2(fragCoord.xy - 0.5 * iResolution.xy);
  r = 2.0 * r.xy / iResolution.y;

  float red = checker(r + vec2(iTime * 0.1, sin(iTime) * 0.1), 16.0) * 0.3;
  float green = checker(r + vec2(iTime * 0.2, sin(iTime) * 0.11), 8.0) * 0.6;
  float blue = checker(r * (sin(iTime) * 0.5 + 1.0 + 0.3*sin(iTime + r.y * 2.6)) +
                           vec2(iTime * 0.4, 0.0),
                       4.0);

  vec3 pixel = vec3(red, green, blue);

  fragColor = vec4(pixel, 1.0);
}