//
//  ViewController.m
//  MetalPlaygroundObjC
//
//  Created by Garrett Wininger on 2/15/24.
//

#import "Renderer.h"
#import "ViewController.h"

@implementation ViewController {
    MTKView *mtkView;
    Renderer *renderer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    mtkView = [[MTKView alloc] init];
    
    if (!mtkView) {
        NSLog(@"Failed to create MetalKit view");
        return;
    }
    
    mtkView.device = MTLCreateSystemDefaultDevice();
    
    if (!(mtkView.device = MTLCreateSystemDefaultDevice())) {
        NSLog(@"Failed to identify system default Metal device.");
        return;
    }
    
    if (!(renderer = [[Renderer alloc] initWithMtkView:mtkView])) {
        NSLog(@"Failed to initilize application renderer.");
        return;
    }
    
    mtkView.delegate = renderer;
    mtkView.frame = NSMakeRect(0, 0, 480, 270);
    self.view = mtkView;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

@end
