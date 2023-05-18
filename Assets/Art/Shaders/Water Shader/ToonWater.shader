// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ToonWater"
{
	Properties
	{
		_FadeDistance("FadeDistance", Range( 0 , 2)) = 0
		_ShoreColor("ShoreColor", Color) = (0,0,0,0)
		_WaterColor("WaterColor", Color) = (0,0,0,0)
		_ShoreWidth("ShoreWidth", Range( 0 , 1)) = 0
		_ToonQuantity("ToonQuantity", Range( 0 , 1)) = 0
		_Color0("Color 0", Color) = (0,0,0,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_WavesLenght("WavesLenght", Range( 0 , 1)) = 0
		_FoamSpeedAndDirection("FoamSpeedAndDirection", Vector) = (1,1,1,0)
		_FoamTiling("FoamTiling", Range( 0 , 5)) = 1
		_Float1("Float 1", Float) = 0
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[HDR]_CusticColor("CusticColor", Color) = (0,0,0,0)
		_CausticQuantity("CausticQuantity", Range( 0 , 1)) = 0
		_CausticTiling("CausticTiling", Float) = 1
		_CausticTime("CausticTime", Float) = 0.1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
		};

		uniform float4 _ShoreColor;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _FadeDistance;
		uniform float4 _WaterColor;
		uniform float _ShoreWidth;
		uniform sampler2D _TextureSample0;
		uniform float _WavesLenght;
		uniform float _Float1;
		uniform float _FoamTiling;
		uniform float3 _FoamSpeedAndDirection;
		uniform float _ToonQuantity;
		uniform float4 _Color0;
		uniform sampler2D _TextureSample1;
		uniform float _CausticTiling;
		uniform float _CausticTime;
		uniform float _CausticQuantity;
		uniform float4 _CusticColor;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth2 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth2 = abs( ( screenDepth2 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _FadeDistance ) );
			float Fade8 = saturate( ( 1.0 - ( distanceDepth2 - ase_screenPosNorm.w ) ) );
			float screenDepth37 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth37 = abs( ( screenDepth37 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _WavesLenght ) );
			float temp_output_40_0 = ( 1.0 - distanceDepth37 );
			float2 temp_cast_0 = (_FoamTiling).xx;
			float2 uv_TexCoord46 = i.uv_texcoord * temp_cast_0 + ( _Time.y * _FoamSpeedAndDirection ).xy;
			float2 appendResult50 = (float2(( temp_output_40_0 * _Float1 ) , uv_TexCoord46.y));
			float4 temp_cast_2 = (saturate( _ToonQuantity )).xxxx;
			float4 temp_output_31_0 = saturate( ( ceil( ( Fade8 - saturate( _ShoreWidth ) ) ) + ceil( ( ( tex2D( _TextureSample0, appendResult50 ) * temp_output_40_0 ) - temp_cast_2 ) ) ) );
			float4 temp_cast_3 = (saturate( _CausticQuantity )).xxxx;
			float2 panner124 = ( 1.0 * _Time.y * float2( 0,0 ) + float2( 0,0 ));
			float2 uv_TexCoord123 = i.uv_texcoord * float2( 5,5 ) + panner124;
			float simplePerlin2D122 = snoise( uv_TexCoord123 );
			simplePerlin2D122 = simplePerlin2D122*0.5 + 0.5;
			o.Albedo = ( ( ( ( _ShoreColor * Fade8 ) + ( ( 1.0 - Fade8 ) * _WaterColor ) ) * ( 1.0 - temp_output_31_0 ) ) + ( ( temp_output_31_0 * _Color0 ) + ( ( 1.0 - temp_output_31_0 ) * ( ( ceil( ( tex2D( _TextureSample1, (i.uv_texcoord*_CausticTiling + ( _Time.y * _CausticTime )) ) - temp_cast_3 ) ) * pow( simplePerlin2D122 , 5.0 ) ) * _CusticColor ) ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
909;73;1094;651;1873.167;698.7946;2.432039;True;False
Node;AmplifyShaderEditor.CommentaryNode;9;-2064.816,-557.3828;Inherit;False;1449.522;383.4625;Fade;7;8;7;3;2;4;6;5;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;115;-3285.287,850.5142;Inherit;False;1705.624;607.7309;Waves;13;53;52;34;44;47;37;48;45;40;46;50;29;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-2102.816,-482.0176;Inherit;False;Property;_FadeDistance;FadeDistance;0;0;Create;True;0;0;0;False;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2560.843,1213.554;Inherit;False;Property;_WavesLenght;WavesLenght;7;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;2;-1772.053,-507.3827;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;37;-2233.176,1145.711;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;47;-3234.287,1193.665;Inherit;False;Property;_FoamSpeedAndDirection;FoamSpeedAndDirection;8;0;Create;True;0;0;0;False;0;False;1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;44;-3204.359,1101.346;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;3;-1769.031,-380.9202;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;4;-1424.149,-436.7737;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;40;-1897.283,1185.571;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-2937.548,1102.005;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-2912.605,1343.245;Inherit;False;Property;_Float1;Float 1;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-3156.973,903.1345;Inherit;False;Property;_FoamTiling;FoamTiling;9;0;Create;True;0;0;0;False;0;False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;114;-3091.202,1836.986;Inherit;False;1825.396;814.7235;Foam;17;74;73;72;76;75;71;60;63;64;62;65;66;67;123;125;126;124;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;6;-1212.948,-439.485;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-2725.264,1307.133;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-2998.202,2536.71;Inherit;False;Property;_CausticTime;CausticTime;15;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;46;-2759.109,900.5142;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;73;-3041.202,2422.71;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;50;-2410.203,939.7137;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;7;-1045.212,-414.2097;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-2809.202,2482.71;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;76;-2997.738,2105.377;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;59;-1852.85,1485.026;Inherit;False;837.4497;271.1587;para el toonlike;4;56;57;58;54;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-2975.202,2270.71;Inherit;False;Property;_CausticTiling;CausticTiling;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-2305.157,2363.796;Inherit;False;Property;_CausticQuantity;CausticQuantity;13;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;71;-2710.202,2255.71;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;29;-2067.92,912.4905;Inherit;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;0;False;0;False;-1;61a6d019b06399947b17a788ca7dd6e4;61a6d019b06399947b17a788ca7dd6e4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-2421.939,669.9013;Inherit;False;Property;_ShoreWidth;ShoreWidth;3;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;-858.2937,-414.8669;Inherit;False;Fade;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-1802.85,1641.184;Inherit;False;Property;_ToonQuantity;ToonQuantity;4;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;124;-2696.572,2521.222;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;62;-2175.786,2195.209;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;56;-1502.61,1639.036;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-1748.664,1002.237;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;22;-2140.049,673.869;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;123;-2492.028,2499.242;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;5,5;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;60;-2449.132,1886.986;Inherit;True;Property;_TextureSample1;Texture Sample 1;11;0;Create;True;0;0;0;False;0;False;-1;5fbc25f44ce4c5443918546cfd24863a;5fbc25f44ce4c5443918546cfd24863a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;18;-2196.554,548.3441;Inherit;False;8;Fade;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;19;-1973.234,603.038;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;122;-2205.183,2489.316;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;63;-1988.654,1910.195;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;57;-1339.873,1539.662;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;116;-1978.667,-155.5892;Inherit;False;1025.596;610.4522;Water;7;10;14;13;16;15;11;17;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PowerNode;126;-1953.627,2485.887;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;58;-1169.4,1535.026;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CeilOpNode;23;-1802.761,598.4011;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;64;-1746.334,1915.479;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-1525.139,606.7273;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;66;-1379.225,2289.732;Inherit;False;Property;_CusticColor;CusticColor;12;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;10;-1928.667,98.06171;Inherit;False;8;Fade;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-1628.608,2208.631;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;13;-1717.261,-105.5893;Inherit;False;Property;_ShoreColor;ShoreColor;1;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-1434.806,1959.796;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;16;-1715.893,247.8629;Inherit;False;Property;_WaterColor;WaterColor;2;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;31;-1367.276,597.8522;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;14;-1526.278,123.1433;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;113;-954.9711,1897.75;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;112;-1164.559,954.9733;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;24;-1154.262,746.8826;Inherit;False;Property;_Color0;Color 0;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1352.516,185.4713;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-1366.698,-57.74846;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-1188.071,66.17612;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;28;-1204.666,482.3682;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-954.9628,599.2948;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;-894.3882,953.8081;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;70;-691.3353,647.1877;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-950.4528,428.7189;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-595.969,454.6035;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-424.5788,453.1959;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;ToonWater;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;5;0
WireConnection;37;0;34;0
WireConnection;4;0;2;0
WireConnection;4;1;3;4
WireConnection;40;0;37;0
WireConnection;45;0;44;0
WireConnection;45;1;47;0
WireConnection;6;0;4;0
WireConnection;52;0;40;0
WireConnection;52;1;53;0
WireConnection;46;0;48;0
WireConnection;46;1;45;0
WireConnection;50;0;52;0
WireConnection;50;1;46;2
WireConnection;7;0;6;0
WireConnection;75;0;73;0
WireConnection;75;1;74;0
WireConnection;71;0;76;0
WireConnection;71;1;72;0
WireConnection;71;2;75;0
WireConnection;29;1;50;0
WireConnection;8;0;7;0
WireConnection;62;0;65;0
WireConnection;56;0;54;0
WireConnection;33;0;29;0
WireConnection;33;1;40;0
WireConnection;22;0;21;0
WireConnection;123;1;124;0
WireConnection;60;1;71;0
WireConnection;19;0;18;0
WireConnection;19;1;22;0
WireConnection;122;0;123;0
WireConnection;63;0;60;0
WireConnection;63;1;62;0
WireConnection;57;0;33;0
WireConnection;57;1;56;0
WireConnection;126;0;122;0
WireConnection;58;0;57;0
WireConnection;23;0;19;0
WireConnection;64;0;63;0
WireConnection;30;0;23;0
WireConnection;30;1;58;0
WireConnection;125;0;64;0
WireConnection;125;1;126;0
WireConnection;67;0;125;0
WireConnection;67;1;66;0
WireConnection;31;0;30;0
WireConnection;14;0;10;0
WireConnection;113;0;67;0
WireConnection;112;0;31;0
WireConnection;15;0;14;0
WireConnection;15;1;16;0
WireConnection;11;0;13;0
WireConnection;11;1;10;0
WireConnection;17;0;11;0
WireConnection;17;1;15;0
WireConnection;28;0;31;0
WireConnection;25;0;31;0
WireConnection;25;1;24;0
WireConnection;111;0;112;0
WireConnection;111;1;113;0
WireConnection;70;0;25;0
WireConnection;70;1;111;0
WireConnection;26;0;17;0
WireConnection;26;1;28;0
WireConnection;27;0;26;0
WireConnection;27;1;70;0
WireConnection;0;0;27;0
ASEEND*/
//CHKSM=C4DEB564E49C9ABF368B8DB02A676F71F2E32D3D