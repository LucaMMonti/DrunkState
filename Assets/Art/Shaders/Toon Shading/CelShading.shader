// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CelShading"
{
	Properties
	{
		_Step1("Step1", Range( 0 , 1)) = 0
		_Step2("Step2", Range( 0 , 1)) = 0.3823156
		_NormalMap("NormalMap", 2D) = "bump" {}
		_MainTexture("MainTexture", 2D) = "white" {}
		_HighlightColor("HighlightColor", Color) = (0,0,0,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Step3("Step3", Range( 0 , 1)) = 0.2658946
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Step4("Step4", Range( 0 , 1)) = 1
		_Step6("Step6", Range( 0 , 2)) = 1.51
		_Step7("Step7", Range( 0 , 2)) = 1.751837
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_TextureSample3("Texture Sample 3", 2D) = "white" {}
		_TextureSample4("Texture Sample 4", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _TextureSample2;
		uniform float4 _TextureSample2_ST;
		uniform sampler2D _MainTexture;
		uniform float4 _MainTexture_ST;
		uniform float _Step4;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _TextureSample3;
		uniform float4 _TextureSample3_ST;
		uniform float _Step6;
		uniform sampler2D _TextureSample4;
		uniform float4 _TextureSample4_ST;
		uniform float _Step7;
		uniform float _Step1;
		uniform float _Step3;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _Step2;
		uniform float4 _HighlightColor;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 uv_TextureSample2 = i.uv_texcoord * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
			float2 uv_MainTexture = i.uv_texcoord * _MainTexture_ST.xy + _MainTexture_ST.zw;
			float4 tex2DNode15 = tex2D( _MainTexture, uv_MainTexture );
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult2 = dot( (WorldNormalVector( i , UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) ) )) , ase_worldlightDir );
			float temp_output_38_0 = ( 1.0 - dotResult2 );
			float2 uv_TextureSample3 = i.uv_texcoord * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
			float2 uv_TextureSample4 = i.uv_texcoord * _TextureSample4_ST.xy + _TextureSample4_ST.zw;
			float4 temp_cast_2 = (step( _Step1 , dotResult2 )).xxxx;
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 temp_output_17_0 = ( ( ( ( ( ( tex2D( _TextureSample2, uv_TextureSample2 ) * tex2DNode15 ) * ( step( _Step4 , temp_output_38_0 ) * 0.7 ) ) - ( ( 1.0 - tex2D( _TextureSample3, uv_TextureSample3 ) ) * ( step( _Step6 , temp_output_38_0 ) * 0.2 ) ) ) - ( ( 1.0 - tex2D( _TextureSample4, uv_TextureSample4 ) ) * ( step( _Step7 , temp_output_38_0 ) * 0.1 ) ) ) + ( tex2DNode15 * saturate( ( ( temp_cast_2 - ( ( step( dotResult2 , _Step3 ) * 0.5 ) * ( 1.0 - tex2D( _TextureSample1, uv_TextureSample1 ) ) ) ) - ( ( 1.0 - tex2D( _TextureSample0, uv_TextureSample0 ) ) * ( step( dotResult2 , _Step2 ) * 0.5 ) ) ) ) ) ) * ase_lightColor );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV19 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode19 = ( 0.0 + 6.96 * pow( 1.0 - fresnelNdotV19, 14.48 ) );
			float4 lerpResult24 = lerp( temp_output_17_0 , _HighlightColor , ( fresnelNode19 * ase_lightAtten ));
			c.rgb = lerpResult24.rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float2 uv_TextureSample2 = i.uv_texcoord * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
			float2 uv_MainTexture = i.uv_texcoord * _MainTexture_ST.xy + _MainTexture_ST.zw;
			float4 tex2DNode15 = tex2D( _MainTexture, uv_MainTexture );
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult2 = dot( (WorldNormalVector( i , UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) ) )) , ase_worldlightDir );
			float temp_output_38_0 = ( 1.0 - dotResult2 );
			float2 uv_TextureSample3 = i.uv_texcoord * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
			float2 uv_TextureSample4 = i.uv_texcoord * _TextureSample4_ST.xy + _TextureSample4_ST.zw;
			float4 temp_cast_0 = (step( _Step1 , dotResult2 )).xxxx;
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 temp_output_17_0 = ( ( ( ( ( ( tex2D( _TextureSample2, uv_TextureSample2 ) * tex2DNode15 ) * ( step( _Step4 , temp_output_38_0 ) * 0.7 ) ) - ( ( 1.0 - tex2D( _TextureSample3, uv_TextureSample3 ) ) * ( step( _Step6 , temp_output_38_0 ) * 0.2 ) ) ) - ( ( 1.0 - tex2D( _TextureSample4, uv_TextureSample4 ) ) * ( step( _Step7 , temp_output_38_0 ) * 0.1 ) ) ) + ( tex2DNode15 * saturate( ( ( temp_cast_0 - ( ( step( dotResult2 , _Step3 ) * 0.5 ) * ( 1.0 - tex2D( _TextureSample1, uv_TextureSample1 ) ) ) ) - ( ( 1.0 - tex2D( _TextureSample0, uv_TextureSample0 ) ) * ( step( dotResult2 , _Step2 ) * 0.5 ) ) ) ) ) ) * ase_lightColor );
			o.Albedo = temp_output_17_0.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
912;81;1086;640;2041.117;209.2828;1;False;False
Node;AmplifyShaderEditor.SamplerNode;12;-1619.708,-44.43846;Inherit;True;Property;_NormalMap;NormalMap;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;3;-1293.395,-40.72483;Inherit;True;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;1;-1270.376,233.873;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;29;-502.0264,695.1849;Inherit;False;Property;_Step3;Step3;7;0;Create;True;0;0;0;False;0;False;0.2658946;0.333;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;2;-900.0325,25.99456;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;33;-158.7142,923.3415;Inherit;True;Property;_TextureSample1;Texture Sample 1;8;0;Create;True;0;0;0;False;0;False;-1;9e3e4a7db488cf444b326485ab8cb5fc;9e3e4a7db488cf444b326485ab8cb5fc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;30;-165.7574,691.4547;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-531.1444,257.2111;Inherit;False;Property;_Step2;Step2;2;0;Create;True;0;0;0;False;0;False;0.3823156;0.64;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;38;-452.3479,-359.8837;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;36;144.3933,947.9769;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-179.9683,-272.9149;Inherit;False;Property;_Step4;Step4;9;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-328.5429,-43.75029;Inherit;False;Property;_Step1;Step1;1;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;6;-241.2218,238.5996;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;27;-239.6306,477.778;Inherit;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;0;False;0;False;-1;8bcd871eaf81c3244901dc97f029cf7b;8bcd871eaf81c3244901dc97f029cf7b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;74.96894,695.8745;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-185.5032,-869.5084;Inherit;False;Property;_Step6;Step6;10;0;Create;True;0;0;0;False;0;False;1.51;1.365;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;28;74.04269,479.875;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;39;173.6219,-385.735;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;15;760.2129,-56.09997;Inherit;True;Property;_MainTexture;MainTexture;4;0;Create;True;0;0;0;False;0;False;-1;555b6a287b4121b479d412e6ea92bb2e;555b6a287b4121b479d412e6ea92bb2e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;54;134.5852,-879.6194;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;224.6296,-645.0692;Inherit;True;Property;_TextureSample2;Texture Sample 2;12;0;Create;True;0;0;0;False;0;False;-1;f3d16c85fabf700408875d904bf5346d;f3d16c85fabf700408875d904bf5346d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-2.052223,233.9078;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;322.7292,691.6517;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;69;-303.0267,-828.5467;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;4;-9.926062,-8.371132;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;57;77.57095,-1096.985;Inherit;True;Property;_TextureSample3;Texture Sample 3;13;0;Create;True;0;0;0;False;0;False;-1;f3d16c85fabf700408875d904bf5346d;f3d16c85fabf700408875d904bf5346d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;61;-317.5919,-1340.873;Inherit;False;Property;_Step7;Step7;11;0;Create;True;0;0;0;False;0;False;1.751837;1.58;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;539.2094,-570.412;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;62;60.54131,-1331.609;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;35;469.373,4.612281;Inherit;True;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;58;433.3004,-1028.962;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;63;51.10223,-1566.949;Inherit;True;Property;_TextureSample4;Texture Sample 4;14;0;Create;True;0;0;0;False;0;False;-1;3e7a850c94a134d438ad84111d892365;3e7a850c94a134d438ad84111d892365;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;430.5582,-397.9592;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;260.7502,247.3627;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;398.0675,-885.1073;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;719.054,-395.838;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;659.3978,-900.3923;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;65;434.8098,-1541.232;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;8;724.6248,186.8112;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;315.2363,-1347.371;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;60;1018.8,-397.477;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;608.3043,-1344.981;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;11;1039.399,178.2089;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;67;1323.332,-403.9152;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;1278.603,43.64931;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;51;1572.469,-64.08301;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;13;1634.651,177.2523;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.LightAttenuation;18;1582.604,692.1904;Inherit;True;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;19;1537.469,396.5054;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;6.96;False;3;FLOAT;14.48;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;1880.154,63.58515;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;1904.109,543.425;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;25;1851.309,306.8202;Inherit;False;Property;_HighlightColor;HighlightColor;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StickyNoteNode;68;-581.5422,-1659.234;Inherit;False;2145.004;1525.851;Parte Oscura;;1,1,1,1;;0;0
Node;AmplifyShaderEditor.StickyNoteNode;70;-586.0582,-111.5254;Inherit;False;2052.693;1246.865;Parte Iluminada;;1,1,1,1;;0;0
Node;AmplifyShaderEditor.LerpOp;24;2162.854,283.7329;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2597.957,58.97586;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;CelShading;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;12;0
WireConnection;2;0;3;0
WireConnection;2;1;1;0
WireConnection;30;0;2;0
WireConnection;30;1;29;0
WireConnection;38;0;2;0
WireConnection;36;0;33;0
WireConnection;6;0;2;0
WireConnection;6;1;7;0
WireConnection;34;0;30;0
WireConnection;28;0;27;0
WireConnection;39;0;40;0
WireConnection;39;1;38;0
WireConnection;54;0;55;0
WireConnection;54;1;38;0
WireConnection;9;0;6;0
WireConnection;32;0;34;0
WireConnection;32;1;36;0
WireConnection;69;0;38;0
WireConnection;4;0;5;0
WireConnection;4;1;2;0
WireConnection;74;0;45;0
WireConnection;74;1;15;0
WireConnection;62;0;61;0
WireConnection;62;1;69;0
WireConnection;35;0;4;0
WireConnection;35;1;32;0
WireConnection;58;0;57;0
WireConnection;44;0;39;0
WireConnection;26;0;28;0
WireConnection;26;1;9;0
WireConnection;56;0;54;0
WireConnection;52;0;74;0
WireConnection;52;1;44;0
WireConnection;59;0;58;0
WireConnection;59;1;56;0
WireConnection;65;0;63;0
WireConnection;8;0;35;0
WireConnection;8;1;26;0
WireConnection;64;0;62;0
WireConnection;60;0;52;0
WireConnection;60;1;59;0
WireConnection;66;0;65;0
WireConnection;66;1;64;0
WireConnection;11;0;8;0
WireConnection;67;0;60;0
WireConnection;67;1;66;0
WireConnection;16;0;15;0
WireConnection;16;1;11;0
WireConnection;51;0;67;0
WireConnection;51;1;16;0
WireConnection;17;0;51;0
WireConnection;17;1;13;0
WireConnection;22;0;19;0
WireConnection;22;1;18;0
WireConnection;24;0;17;0
WireConnection;24;1;25;0
WireConnection;24;2;22;0
WireConnection;0;0;17;0
WireConnection;0;13;24;0
ASEEND*/
//CHKSM=EB7DA09E533162ADC7BD1D5A86BFEAC7DF93AA58