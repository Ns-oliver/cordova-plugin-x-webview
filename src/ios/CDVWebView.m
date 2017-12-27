//
//  CDVVolume.m
//  CDVVol
//
//  Created by Wilson on 2017/8/10.
//
//

#import "CDVWebView.h"
#import "WebViewController.h"

@interface CDVWebView ()

@end

@implementation CDVWebView

- (void)webViewWith:(CDVInvokedUrlCommand *)command {
    CDVPluginResult * pluginResult = nil;

    NSLog(@"command.arguments == %@",[command argumentAtIndex:0]);
    //url
    NSString * url = [command argumentAtIndex:0];
    //标题
    NSString * title = [command argumentAtIndex:1];
    
    if(url != nil && [url length] > 0) {
        //初始化webview
        [self initWebViewWithURL:url title:title];
        //成功后回调
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:url];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//初始化webview
- (void)initWebViewWithURL:(NSString *)url title:(NSString *)title {
    if(!url || !url.length) {
        //如果url不存在，则不访问
        return;
    }
    WebViewController * webViewController = [WebViewController new];
    webViewController.url = url;
    webViewController.course_title = title;
    
    //创建导航栏
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:webViewController];
    
    self.viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.viewController presentViewController:nav animated:YES completion:nil];
}


@end
