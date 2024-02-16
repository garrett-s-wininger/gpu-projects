//
//  Renderer.m
//  MetalPlaygroundObjC
//
//  Created by Garrett Wininger on 2/15/24.
//

#import "Renderer.h"

@implementation Renderer {
    id<MTLDevice> device;
    id<MTLCommandQueue> commandQueue;
}

- (nullable instancetype)initWithMtkView:(MTKView *)mtkView {
    if (self = [super init]) {
        self->_mtkView = mtkView;
        device = self.mtkView.device;
        
        if (!(commandQueue = [device newCommandQueue])) {
            NSLog(@"Unable to create Command Queue from device.");
            return nil;
        }
    }
    
    return self;
}

- (void)drawInMTKView:(nonnull MTKView *)view { 
    MTLRenderPassDescriptor *descriptor = self.mtkView.currentRenderPassDescriptor;
    
    if (!descriptor) {
        NSLog(@"View's current render pass descriptor is unavailable.");
        return;
    }
    
    descriptor.colorAttachments[0].clearColor = MTLClearColorMake(0.0, 0.0, 0.0, 1.0);
    
    @autoreleasepool {
        id<MTLCommandBuffer> buffer;
        
        if (!(buffer = [commandQueue commandBuffer])) {
            NSLog(@"Failed to create buffer from command queue");
            return;
        }
        
        id<MTLRenderCommandEncoder> encoder;
        
        if (!(encoder = [buffer renderCommandEncoderWithDescriptor:descriptor])) {
            NSLog(@"Failed to create command encoder from command buffer");
            return;
        }
        
        [encoder endEncoding];
        [buffer presentDrawable:view.currentDrawable];
        [buffer commit];
    }
}

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size {}

@end
