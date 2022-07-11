shader_type canvas_item;

void fragment () {
	COLOR = vec4(0, 0.5 + UV.y, 0, 1);
}

void vertex() {
	VERTEX = vec2(VERTEX.x + sin(TIME * 9.0) * UV.y, VERTEX.y);
}