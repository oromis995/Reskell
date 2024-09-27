// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.09407263,fgcg:0.09715396,fgcb:0.1320755,fgca:1,fgde:0.06,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9785,x:33175,y:32690,varname:node_9785,prsc:2|diff-3758-RGB,emission-7051-OUT;n:type:ShaderForge.SFN_Vector3,id:2390,x:31986,y:32710,varname:node_2390,prsc:2,v1:0,v2:0,v3:1;n:type:ShaderForge.SFN_Transform,id:5432,x:32164,y:32714,varname:node_5432,prsc:2,tffrom:3,tfto:0|IN-2390-OUT;n:type:ShaderForge.SFN_NormalVector,id:7004,x:32163,y:32921,prsc:2,pt:True;n:type:ShaderForge.SFN_Dot,id:6949,x:32353,y:32815,varname:node_6949,prsc:2,dt:3|A-5432-XYZ,B-7004-OUT;n:type:ShaderForge.SFN_OneMinus,id:981,x:32535,y:32815,varname:node_981,prsc:2|IN-6949-OUT;n:type:ShaderForge.SFN_Power,id:9232,x:32703,y:32892,varname:node_9232,prsc:2|VAL-981-OUT,EXP-635-OUT;n:type:ShaderForge.SFN_Slider,id:635,x:32334,y:33051,ptovrint:False,ptlb:Amount,ptin:_Amount,varname:node_635,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.848739,max:10;n:type:ShaderForge.SFN_Color,id:4277,x:32621,y:32610,ptovrint:False,ptlb:Fresnel Color,ptin:_FresnelColor,varname:node_4277,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_ValueProperty,id:1950,x:32621,y:32521,ptovrint:False,ptlb:Emissive Intensity,ptin:_EmissiveIntensity,varname:node_1950,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:7051,x:32886,y:32697,varname:node_7051,prsc:2|A-4277-RGB,B-9232-OUT,C-1950-OUT;n:type:ShaderForge.SFN_Color,id:3758,x:32854,y:32494,ptovrint:False,ptlb:Diffuse Color,ptin:_DiffuseColor,varname:node_3758,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:635-4277-1950-3758;pass:END;sub:END;*/

Shader "Unlit/Fresnel" {
    Properties {
        _Amount ("Amount", Range(0, 10)) = 1.848739
        _FresnelColor ("Fresnel Color", Color) = (0.5,0.5,0.5,1)
        _EmissiveIntensity ("Emissive Intensity", Float ) = 1
        _DiffuseColor ("Diffuse Color", Color) = (0.5,0.5,0.5,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        LOD 100
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _LightColor0;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _Amount)
                UNITY_DEFINE_INSTANCED_PROP( float4, _FresnelColor)
                UNITY_DEFINE_INSTANCED_PROP( float, _EmissiveIntensity)
                UNITY_DEFINE_INSTANCED_PROP( float4, _DiffuseColor)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float4 _DiffuseColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DiffuseColor );
                float3 diffuseColor = _DiffuseColor_var.rgb;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float4 _FresnelColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FresnelColor );
                float _Amount_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Amount );
                float _EmissiveIntensity_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EmissiveIntensity );
                float3 emissive = (_FresnelColor_var.rgb*pow((1.0 - abs(dot(mul( float4(float3(0,0,1),0), UNITY_MATRIX_V ).xyz.rgb,normalDirection))),_Amount_var)*_EmissiveIntensity_var);
/// Final Color:
                float3 finalColor = diffuse + emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _LightColor0;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _Amount)
                UNITY_DEFINE_INSTANCED_PROP( float4, _FresnelColor)
                UNITY_DEFINE_INSTANCED_PROP( float, _EmissiveIntensity)
                UNITY_DEFINE_INSTANCED_PROP( float4, _DiffuseColor)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
                UNITY_FOG_COORDS(4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float4 _DiffuseColor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _DiffuseColor );
                float3 diffuseColor = _DiffuseColor_var.rgb;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
