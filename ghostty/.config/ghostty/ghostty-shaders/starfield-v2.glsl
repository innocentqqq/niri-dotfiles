// transparent background
const bool transparent = true;

// terminal contents luminance threshold
const float threshold = 0.1;

// divisions of grid (fewer stars)
const float repeats = 20;

// fewer star layers
const float layers = 10;

// how much of the starfield is visible
const float EFFECT_STRENGTH = 0.2;

// star colors
const vec3 white = vec3(0.3);

float luminance(vec3 color) {
    return dot(color, vec3(0.2126, 0.7152, 0.0722));
}

float N21(vec2 p) {
    p = fract(p * vec2(233.34, 851.73));
    p += dot(p, p + 23.45);
    return fract(p.x * p.y);
}

vec2 N22(vec2 p) {
    float n = N21(p);
    return vec2(n, N21(p + n));
}

mat2 scale(vec2 _scale) {
    return mat2(_scale.x, 0.0,
                0.0, _scale.y);
}

vec3 stars(vec2 uv, float offset) {
    float timeScale = -(iTime * 0.01 + offset) / layers;
    float trans = fract(timeScale);
    float newRnd = floor(timeScale);
    vec3 col = vec3(0.);

    uv -= vec2(0.5);
    uv = scale(vec2(trans)) * uv;
    uv += vec2(0.5);

    uv.x *= iResolution.x / iResolution.y;
    uv *= repeats;

    vec2 ipos = floor(uv);
    uv = fract(uv);

    vec2 rndXY = N22(newRnd + ipos * (offset + 1.0)) * 0.9 + 0.05;
    float rndSize = N21(ipos) * 100.0 + 200.0;

    vec2 j = (rndXY - uv) * rndSize;
    float sparkle = 1.0 / dot(j, j);

    // Dimmer stars
    col += white * sparkle * 0.25;

    col *= smoothstep(1.0, 0.8, trans);

    return col;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord / iResolution.xy;

    vec3 col = vec3(0.0);

    for (float i = 0.0; i < layers; i++) {
        col += stars(uv, i);
    }

    vec4 terminalColor = texture(iChannel0, uv);

    if (transparent) {
        col += terminalColor.rgb;
    }

    float mask = 1.0 - step(threshold, luminance(terminalColor.rgb));

    vec3 blendedColor = mix(
        terminalColor.rgb,
        mix(terminalColor.rgb, col, EFFECT_STRENGTH),
        mask
    );

    fragColor = vec4(blendedColor, terminalColor.a);
}
