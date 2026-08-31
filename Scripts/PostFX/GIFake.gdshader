shader_type canvas_item;

uniform sampler2D screen_tex : hint_screen_texture, filter_linear_mipmap;
uniform vec3 ambient_tint : source_color = vec3(0.6, 0.66, 0.8);
uniform float ambient_strength : hint_range(0.0, 1.0) = 0.22;
uniform float dark_cutoff : hint_range(0.0, 1.0) = 0.3;
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.08;

void fragment() {
	vec3 src = texture(screen_tex, SCREEN_UV).rgb;
	float lum = dot(src, vec3(0.299, 0.587, 0.114));
	float fill = (1.0 - smoothstep(0.0, dark_cutoff, lum)) * ambient_strength;
	vec3 col = mix(src, src + ambient_tint * (1.0 - src), fill * 0.55);
	float vig = 1.0 - vignette_strength * smoothstep(0.55, 0.9, distance(UV, vec2(0.5)));
	COLOR = vec4(col * vig, 1.0);
}