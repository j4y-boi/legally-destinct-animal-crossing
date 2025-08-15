shader_type spatial;

uniform sampler2D grayscaleTexture;
uniform sampler2D filter_off : filter_nearest;
uniform vec4 lowColor = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 midColor = vec4(0.0, 1.0, 0.0, 1.0);
uniform vec4 highColor = vec4(0.0, 0.0, 1.0, 1.0);

void fragment() {
    // Sample the texture
    vec4 texColor = texture(grayscaleTexture, UV);

    // Convert to grayscale
    float gray = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));

    // Interpolate between low, mid, high colors
    vec4 color = mix(lowColor, midColor, gray);
    color = mix(color, highColor, pow(gray, 1.0));

    // Output final color
    ALBEDO = color.rgb;
    ALPHA = texColor.a;
}