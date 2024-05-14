uniform vec2 uResolution;
uniform sampler2D uPictureTexture;
uniform sampler2D uDisplacementTexture;
varying vec3 vColor;
attribute float aIntensity;
attribute float aAngle;
void main()
{      
    vec3 newposition = position;
    float displacementintensity = texture(uDisplacementTexture,uv).r;
    displacementintensity = smoothstep(0.1,0.5,displacementintensity);
    vec3 displacement = vec3(
        cos(aAngle)*0.2,
        sin(aAngle)*0.2,
        1.0
    );
    displacement = normalize(displacement);
    displacement*=displacementintensity;
    displacement *= (3.0*aIntensity);
    newposition +=displacement ;
    // Final position
    vec4 modelPosition = modelMatrix * vec4(newposition, 1.0);
    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;
    gl_Position = projectedPosition;
    
    float pictureIntensity = texture(uPictureTexture,uv).r;

    // Point size
    gl_PointSize = 0.15 *pictureIntensity* uResolution.y;
    gl_PointSize *= (1.0 / - viewPosition.z);

    vColor = vec3(pow(pictureIntensity,2.0));
}