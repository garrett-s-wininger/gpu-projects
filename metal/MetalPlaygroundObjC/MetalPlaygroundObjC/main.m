//
//  main.m
//  MetalPlaygroundObjC
//
//  Created by Garrett Wininger on 2/15/24.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    NSApplication *app = NSApplication.sharedApplication;
    AppDelegate *delegate = [AppDelegate new];
    app.delegate = delegate;

    return NSApplicationMain(argc, argv);
}
