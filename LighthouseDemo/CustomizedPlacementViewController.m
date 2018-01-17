//
//  CustomizedPlacementViewController.m
//  LighthouseDemo
//
//  Created by Kai Lu on 12/01/2018.
//  Copyright © 2018 Adirects. All rights reserved.
//

#import "CustomizedPlacementViewController.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import <Lighthouse_SDK/Adirects_SDK.h>

@interface CustomizedPlacementViewController () <LighthouseInterstailAdDelegate >
{
    int _count;
}
@property (nonatomic, strong) LighthouseInterstailAd *lighthouseAd;

@property (weak, nonatomic) IBOutlet UIButton *preloadBtn;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;
@property (weak, nonatomic) IBOutlet UILabel *placementLabel;

@property (weak, nonatomic) IBOutlet UITextField *publisherId;
@property (weak, nonatomic) IBOutlet UITextField *placementId;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView1;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView2;

@property (nonatomic) UITapGestureRecognizer * tapRecognizer;

//@property (nonatomic, strong) UIButton *playBtn2;

@end

@implementation CustomizedPlacementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     _count = 0;
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    self.tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:self.tapRecognizer];
    
    
    [self.playBtn addTarget:self action:@selector(playAds) forControlEvents:UIControlEventTouchUpInside];
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

/**
 广告展示成功
 
 @param lighthouseAd 主类
 */
- (void)lighthouseAdDidFinishShow:(LighthouseInterstailAd *)lighthouseAd {
    NSLog(@"广告展示成功");
}


-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [self.publisherId resignFirstResponder];
    [self.placementId resignFirstResponder];
}

/**
 广告展示失败
 
 @param lighthouseAd 主类
 @param error error
 */
- (void)lighthouseAd:(LighthouseInterstailAd *)lighthouseAd didFailShowWithError:(NSError *)error {
    NSLog(@"广告展示失败");
}

/**
 广告开始展示
 
 @param lighthouseAd 主类
 */
- (void)lighthouseAdDidStartShow:(LighthouseInterstailAd *)lighthouseAd {
    NSLog(@"广告开始展示");
}

/**
 广告点击关闭
 
 @param lighthouseAd 主类
 */
- (void)lighthouseAdDidClickClose:(LighthouseInterstailAd *)lighthouseAd {
    NSLog(@"广告点击关闭");
}

/**
 广告点击下载
 
 @param interstitialAd 主类
 */
- (void)lighthouseAdDidClickDownload:(LighthouseInterstailAd *)interstitialAd {
    NSLog(@"广告点击下载");
}

/**
 预加载单条视频失败
 
 @param lighthouseAd 主类
 @param error error
 */
- (void)lighthouseAd:(LighthouseInterstailAd *)lighthouseAd didFailPreloadWithError:(NSError *)error withPlacementId:(NSString *)placementId {
    NSLog(@"预加载视频失败");
    _preloadBtn.userInteractionEnabled = YES;
    [_activityIndicatorView1 removeFromSuperview];
    [_activityIndicatorView2 removeFromSuperview];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = [NSString stringWithFormat:@"%@ : %@",placementId,error.localizedDescription];
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    hud.contentColor = [UIColor redColor];
    [hud hideAnimated:YES afterDelay:5.f];
    
}


- (IBAction)preloadAds:(id)sender {
    _count = 0;
    self.preloadBtn.userInteractionEnabled = NO;
    self.playBtn.userInteractionEnabled = NO;
    
    [self.activityIndicatorView1 removeFromSuperview];
    [self.activityIndicatorView2 removeFromSuperview];
  
   
    NSString * publisher_id = self.publisherId.text;
    NSString * placement_id = self.placementId.text;
    
    NSArray* placementIDsArray = @[placement_id];
    _lighthouseAd = [LighthouseInterstailAd initialize:publisher_id withPlacements:placementIDsArray delegate:self];
    
    _activityIndicatorView1 = [[UIActivityIndicatorView alloc] init];

    _activityIndicatorView1.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;

    [self.view addSubview:_activityIndicatorView1];

    [_activityIndicatorView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.placementLabel.mas_right).offset(20);
        make.centerY.equalTo(self.placementLabel);
    }];
    
    [_activityIndicatorView1 startAnimating];

}

#pragma 获取url中的appid
- (NSString *)getIDWithString:(NSString *)string {
    
    NSArray *array = [string componentsSeparatedByString:@":"];
    
    return array[1];
}


/**
 预加载多条视频广告条目完成
 
 @param lighthouseAd 主类
 @param placementId 对应广告视频的广告位id
 */
- (void)lighthouseAdsReady:(LighthouseInterstailAd *)lighthouseAd withPlacementId:(NSString *)placementId {
    NSLog(@"预加载视频完成id = %@",placementId);
    if ([self.placementId.text isEqualToString:placementId]) {
        [_activityIndicatorView1 removeFromSuperview];
        
        self.playBtn.userInteractionEnabled = YES;
    
    }

    _count ++;
    if (_count == 2) {
        self.preloadBtn.userInteractionEnabled = YES;
    }
}

- (void)playAds{
    NSString *placementId = self.placementId.text;
    if ([_lighthouseAd isReady:placementId]) {
        [_lighthouseAd showWithplacementId:placementId];
    }
}




@end
