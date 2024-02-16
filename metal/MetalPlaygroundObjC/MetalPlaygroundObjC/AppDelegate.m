//
//  AppDelegate.m
//  MetalPlaygroundObjC
//
//  Created by Garrett Wininger on 2/15/24.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate {
    NSWindow *window;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    window = [
        [NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 480, 270)
            styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable | NSWindowStyleMaskMiniaturizable
            backing:NSBackingStoreBuffered
            defer:NO
    ];
    
    [window center];
    window.title = @"Objective-C Metal Playground";
    window.contentViewController = [ViewController new];
    [window makeKeyAndOrderFront:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {}

- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}

@end
