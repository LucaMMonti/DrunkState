// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Car"
{
	Properties
	{
		_Car_lambert3_BaseColor("Car_lambert3_BaseColor", 2D) = "white" {}
		_Car_lambert3_Emissive("Car_lambert3_Emissive", 2D) = "white" {}
		_Car_lambert3_Metallic("Car_lambert3_Metallic", 2D) = "white" {}
		_Car_lambert3_Normal("Car_lambert3_Normal", 2D) = "bump" {}
		_Car("Car", Color) = (1,0,0,0)
		_Windows("Windows", Color) = (0.1741278,0.6928278,0.8584906,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Car_lambert3_Normal;
		uniform float4 _Car_lambert3_Normal_ST;
		uniform sampler2D _Car_lambert3_BaseColor;
		uniform float4 _Car_lambert3_BaseColor_ST;
		uniform float4 _Windows;
		uniform float4 _Car;
		uniform sampler2D _Car_lambert3_Emissive;
		uniform float4 _Car_lambert3_Emissive_ST;
		uniform sampler2D _Car_lambert3_Metallic;
		uniform float4 _Car_lambert3_Metallic_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Car_lambert3_Normal = i.uv_texcoord * _Car_lambert3_Normal_ST.xy + _Car_lambert3_Normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Car_lambert3_Normal, uv_Car_lambert3_Normal ) );
			float2 uv_Car_lambert3_BaseColor = i.uv_texcoord * _Car_lambert3_BaseColor_ST.xy + _Car_lambert3_BaseColor_ST.zw;
			float4 tex2DNode1 = tex2D( _Car_lambert3_BaseColor, uv_Car_lambert3_BaseColor );
			o.Albedo = saturate( ( ( ( 1.0 - tex2DNode1.g ) * _Windows ) + ( tex2DNode1 * _Car ) ) ).rgb;
			float2 uv_Car_lambert3_Emissive = i.uv_texcoord * _Car_lambert3_Emissive_ST.xy + _Car_lambert3_Emissive_ST.zw;
			o.Emission = tex2D( _Car_lambert3_Emissive, uv_Car_lambert3_Emissive ).rgb;
			float2 uv_Car_lambert3_Metallic = i.uv_texcoord * _Car_lambert3_Metallic_ST.xy + _Car_lambert3_Metallic_ST.zw;
			o.Metallic = tex2D( _Car_lambert3_Metallic, uv_Car_lambert3_Metallic ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
1084;69;1103;639;302.6674;240.4077;1;False;False
Node;AmplifyShaderEditor.SamplerNode;1;-580.7814,-62.52429;Inherit;True;Property;_Car_lambert3_BaseColor;Car_lambert3_BaseColor;0;0;Create;True;0;0;0;False;0;False;-1;ab994f234b309104491cb016636db6f2;ab994f234b309104491cb016636db6f2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;7;-244.6509,-271.956;Inherit;False;Property;_Windows;Windows;6;0;Create;True;0;0;0;False;0;False;0.1741278,0.6928278,0.8584906,0;0.1741278,0.6928278,0.8584906,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;29;-167.7502,-88.09174;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;17;-130.5722,91.88429;Inherit;False;Property;_Car;Car;5;0;Create;True;0;0;0;False;0;False;1,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;176.3596,62.51028;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;67.07425,-234.111;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;456.1861,-103.8975;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-593.7807,128.5755;Inherit;True;Property;_Car_lambert3_Emissive;Car_lambert3_Emissive;1;0;Create;True;0;0;0;False;0;False;-1;ffeaa475826f94f4498c5d6ef3e3fea1;ffeaa475826f94f4498c5d6ef3e3fea1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-577.5354,326.0242;Inherit;True;Property;_Car_lambert3_Height;Car_lambert3_Height;2;0;Create;True;0;0;0;False;0;False;-1;6ec8b948f2a686245a0abc675254deae;6ec8b948f2a686245a0abc675254deae;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;15;704.3861,19.09435;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;4;-577.4227,524.3729;Inherit;True;Property;_Car_lambert3_Metallic;Car_lambert3_Metallic;3;0;Create;True;0;0;0;False;0;False;-1;0e193421efcc4e74d884a7284cda2c9f;0e193421efcc4e74d884a7284cda2c9f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-588.7462,731.8901;Inherit;True;Property;_Car_lambert3_Normal;Car_lambert3_Normal;4;0;Create;True;0;0;0;False;0;False;-1;2c218283f95769040904b7310e212147;2c218283f95769040904b7310e212147;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;685.2599,404.6798;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Car;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;29;0;1;2
WireConnection;16;0;1;0
WireConnection;16;1;17;0
WireConnection;6;0;29;0
WireConnection;6;1;7;0
WireConnection;13;0;6;0
WireConnection;13;1;16;0
WireConnection;15;0;13;0
WireConnection;0;0;15;0
WireConnection;0;1;5;0
WireConnection;0;2;2;0
WireConnection;0;3;4;0
ASEEND*/
//CHKSM=13EFAB16A05B01DB623665CFFA12B7AB6EA9CE44