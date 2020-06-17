#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;


const vec4 lumcoeff = vec4(0.299, 0.587, 0.114, 0);

void main() {
  vec4 col = texture2D(texture, vertTexCoord.st);
  vec3 lum = vec3(0.299, 0.587, 0.114);
  //y = 0.299R + 0.587G + 0.114B
  gl_FragColor = vec4( vec3(dot( col.rgb, lum)), col.a);
  
}