shader_type canvas_item;
uniform float time_amp = 1;
uniform float scale = 1;
uniform float freq = 2;
uniform float amp = 0.05;
uniform float sp_scale = 1;
uniform float sl_sizemultiplier = 2;
uniform float sl_amp = 1;
uniform vec4 color: hint_color;
uniform sampler2D tex;

void fragment() {
	vec2 modUV = UV/sp_scale;
	vec2 sinedistort = vec2(amp * sin(freq * modUV.y + scale * (TIME*time_amp)), 0.);
	vec2 scanlinedistort = vec2(mod(FRAGCOORD.y/sl_sizemultiplier, 2.0), 0) * sl_amp;
	COLOR = texture(tex, modUV+sinedistort+scanlinedistort)*color;
}