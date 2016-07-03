//
//  ViewController.m
//  CommentPlayer
//
//  Created by 西村友行 on 2016/07/02.
//  Copyright © 2016年 西村友行. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    webView.scalesPageToFit = YES;
    webView.opaque = NO;
    webView.backgroundColor = [UIColor clearColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"player" ofType:@"html"];
    NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    NSString *htmlString = [[NSString alloc] initWithData:[readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
    
    JWConfig *config = [[JWConfig alloc] init];
    config.file = @"https://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8";
    config.size = CGSizeMake(screenWidth, screenHeight);
    config.autostart = YES;
    
    self.player = [[JWPlayerController alloc] initWithConfig:config];
    [self.view addSubview:self.player.view];
    [self.player.view insertSubview:webView atIndex:1];
    
    [webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:path]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
