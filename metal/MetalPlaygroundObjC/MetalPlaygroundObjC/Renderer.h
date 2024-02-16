//
//  Renderer.h
//  MetalPlaygroundObjC
//
//  Created by Garrett Wininger on 2/15/24.
//

#import <MetalKit/MetalKit.h>

@interface Renderer: NSObject <MTKViewDelegate>

@property (readonly, nonatomic, nonnull) MTKView *mtkView;

- (nullable instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithMtkView:(nonnull MTKView *)mtkView NS_DESIGNATED_INITIALIZER;

@end
