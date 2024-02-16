//
//  Renderer.m
//  MetalPlaygroundObjC
//
//  Created by Garrett Wininger on 2/15/24.
//

#import "Renderer.h"
#import "ShaderData.h"

@implementation Renderer {
    MTKView *mtkView;
    id<MTLDevice> device;
    id<MTLCommandQueue> commandQueue;
    id<MTLBuffer> vertexBuffer;
}

- (nullable instancetype)initWithMtkView:(MTKView *)mtkView {
    if (self = [super init]) {
        self->mtkView = mtkView;
        self->device = self->mtkView.device;
        
        if (!(commandQueue = [device newCommandQueue])) {
            NSLog(@"Unable to create Command Queue from device.");
            return nil;
        }
        
        Vertex verticies[3] = {
            {.color = simd_make_float4(1, 0, 0, 1), .pos = simd_make_float2(-1, -1)},
            {.color = simd_make_float4(0, 1, 0, 1), .pos = simd_make_float2(0, 1)},
            {.color = simd_make_float4(0, 0, 1, 1), .pos = simd_make_float2(1, -1)}
        };
        
        self->vertexBuffer = [device newBufferWithBytes:verticies length:sizeof(verticies) options:MTLResourceCPUCacheModeDefaultCache | MTLResourceStorageModeShared | MTLResourceHazardTrackingModeDefault];
    }
    
    return self;
}

- (void)drawInMTKView:(nonnull MTKView *)view {
    MTLRenderPassDescriptor* renderPassDescriptor = self->mtkView.currentRenderPassDescriptor;
    
    if (!renderPassDescriptor) {
        NSLog(@"View's current render pass descriptor is unavailable.");
        return;
    }
     
    renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0.0, 0.0, 0.0, 1.0);
    
    id<MTLLibrary> library = [device newDefaultLibrary];
    
    if (!library) {
        NSLog(@"Unable to get the default library for the selected GPU device.");
        return;
    }
    
    MTLRenderPipelineDescriptor* pipelineDescriptor = [MTLRenderPipelineDescriptor new];
    
    if (!pipelineDescriptor) {
        NSLog(@"Initialization of the render pipeline descriptor failed.");
        return;
    }
    
    pipelineDescriptor.vertexFunction = [library newFunctionWithName:@"vertexShader"];
    
    if (!pipelineDescriptor.vertexFunction) {
        NSLog(@"Could not generate the Metal function for the vertex shader.");
        return;
    }
    
    pipelineDescriptor.fragmentFunction = [library newFunctionWithName:@"fragmentShader"];
    
    if (!pipelineDescriptor.fragmentFunction) {
        NSLog(@"Could not generate the Metal function for the fragement shader.");
        return;
    }
    
    pipelineDescriptor.colorAttachments[0].pixelFormat = mtkView.colorPixelFormat;
    id<MTLRenderPipelineState> pipelineState = [device newRenderPipelineStateWithDescriptor:pipelineDescriptor error:nil];
    
    if (!pipelineState) {
        NSLog(@"Pipeline state could not be  produced");
        return;
    }
    
    id<MTLCommandBuffer> buffer;
    
    if (!(buffer = [commandQueue commandBuffer])) {
        NSLog(@"Failed to create buffer from command queue");
        return;
    }
    
    id<MTLRenderCommandEncoder> encoder;
    
    if (!(encoder = [buffer renderCommandEncoderWithDescriptor:renderPassDescriptor])) {
        NSLog(@"Failed to create command encoder from command buffer");
        return;
    }
    
    [encoder setRenderPipelineState:pipelineState];
    [encoder setVertexBuffer:self->vertexBuffer offset:0 atIndex:0];
    [encoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart: 0 vertexCount: 3];
    [encoder endEncoding];

    [buffer presentDrawable:view.currentDrawable];
    [buffer commit];
}

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size {}

@end
