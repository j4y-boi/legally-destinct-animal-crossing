shader_type spatial;

uniform sampler2D grayscaleTexture;
uniform vec4 lowColor = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 midColor = vec4(0.0, 1.0, 0.0, 1.0);
uniform vec4 highColor = vec4(0.0, 0.0, 1.0, 1.0);

void fragment() {
    // Get the texture size
    ivec2 texSize = textureSize(grayscaleTexture, 0);

    // Convert UV to integer pixel coordinates
    ivec2 pixelCoord = ivec2(UV * vec2(texSize));

    // Sample exact pixel (nearest-neighbor)
    vec4 texColor = texelFetch(grayscaleTexture, pixelCoord, 0);

    // Convert to grayscale
    float gray = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));

    // Interpolate between low, mid, high colors
    vec4 color = mix(lowColor, midColor, gray);
    color = mix(color, highColor, pow(gray, 1.0));

    ALBEDO = color.rgb;
    ALPHA = texColor.a;
}
// shader was largely written with a tutorial, gpt used for nearest pixels... sorry :c