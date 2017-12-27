//
//  WebViewController.m
//  手机学堂
//
//  Created by Wilson on 2017/8/15.
//
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

//webview container
@property (nonatomic, weak) UIWebView * webView;
//底部控制栏
@property (nonatomic, weak) UIView * bottomControl;

@end

@implementation WebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化webview并加载
    [self initWebView];
    //加载底部控件
    [self initBottomView];
}

- (void)initWebView {
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 40)];
    webView.delegate = self;
    //通过webview访问的路径，默认是没有http://前缀的，需要判断加上
    if([self.url hasPrefix:@"http://"] || [self.url hasPrefix:@"https://"]) {
        //如果本身自带http或者https，则不需要做处理
    } else {
        //没有带https或者http头的，都无法在webview中访问，所以需要手动加上https或者http
        self.url = [NSString stringWithFormat:@"http://%@",self.url];
    }
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:webView];
}

//加载底部控件
- (void)initBottomView {
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
    [bottomView setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1]];
    [self.view addSubview:bottomView];
    self.bottomControl = bottomView;
    
    //添加返回按钮
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(10, 0, 40, 40)];
    [backBtn setImage:[UIImage imageNamed:@"webview_btn_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomControl addSubview:backBtn];
    
    //设置课程标题
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, self.view.frame.size.width - 120, 30)];
    [label setFont:[UIFont fontWithName:@"Arial" size:13]];
    [label setTextColor:[UIColor colorWithRed:35/255.0f green:35/255.0f blue:35/255.0f alpha:1]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
    [self.bottomControl addSubview:label];
    [label setText:(self.course_title && self.course_title.length) ? self.course_title : @""];
}

//返回
- (void)backAction:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webview 开始加载了");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webview 结束加载了");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
