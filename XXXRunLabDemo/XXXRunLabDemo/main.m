//
//  main.m
//  XXXRunLabDemo
//
//  Created by Z on 2020/3/12.
//  Copyright © 2020 Z. All rights reserved.
//  https://github.com/xxxIxxxx/XXXRunLab

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
