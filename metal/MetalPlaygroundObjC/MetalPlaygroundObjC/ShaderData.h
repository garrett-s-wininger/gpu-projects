//
//  ShaderData.h
//  MetalPlaygroundObjC
//
//  Created by Garrett Wininger on 2/16/24.
//

#ifndef ShaderData_h
#define ShaderData_h

#include <simd/simd.h>

typedef struct {
    vector_float4 color;
    vector_float2 pos;
} Vertex;

#endif /* ShaderData_h */
