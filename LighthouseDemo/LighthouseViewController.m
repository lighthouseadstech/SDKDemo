//
//  LighthouseViewController.m
//  LighthouseDemo
//
//  Created by hbc on 2017/10/31.
//  Copyright © 2017年 Adirects. All rights reserved.
//

#import "LighthouseViewController.h"
#import <Adirects_SDK/Adirects_SDK.h>
#import "Masonry.h"
#import "MBProgressHUD.h"

@interface LighthouseViewController () <LighthouseInterstailAdDelegate>
{
    int _count;
}
@property (nonatomic, strong) LighthouseInterstailAd *lighthouseAd;

@property (weak, nonatomic) IBOutlet UIButton *preloadBtn;
@property (weak, nonatomic) IBOutlet UILabel *placementID1;
@property (weak, nonatomic) IBOutlet UILabel *placementID2;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView1;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView2;

@property (nonatomic, strong) UIButton *playBtn1;
@property (nonatomic, strong) UIButton *playBtn2;

@end

@implementation LighthouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _count = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)preloadAds:(id)sender {
    _count = 0;
    self.preloadBtn.userInteractionEnabled = NO;
    [self.activityIndicatorView1 removeFromSuperview];
    [self.activityIndicatorView2 removeFromSuperview];
    [self.playBtn1 removeFromSuperview];
    [self.playBtn2 removeFromSuperview];
    
    NSArray* placementIDsArray = @[@"176-10011",@"176-10012"];
    _lighthouseAd = [LighthouseInterstailAd initialize:@"3-10008" withPlacements:placementIDsArray delegate:self];
    
    _activityIndicatorView1 = [[UIActivityIndicatorView alloc] init];
    _activityIndicatorView2 = [[UIActivityIndicatorView alloc] init];
    _activityIndicatorView1.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activityIndicatorView2.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:_activityIndicatorView1];
    [self.view addSubview:_activityIndicatorView2];
    [_activityIndicatorView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_placementID1.mas_right).offset(20);
        make.centerY.equalTo(_placementID1);
    }];
    [_activityIndicatorView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_placementID2.mas_right).offset(20);
        make.centerY.equalTo(_placementID2);
    }];
    [_activityIndicatorView1 startAnimating];
    [_activityIndicatorView2 startAnimating];
}

/**
 预加载多条视频广告条目完成
 
 @param lighthouseAd 主类
 @param placementId 对应广告视频的广告位id
 */
- (void)lighthouseAdsReady:(LighthouseInterstailAd *)lighthouseAd withPlacementId:(NSString *)placementId {
    NSLog(@"预加载视频完成id = %@",placementId);
    if ([[self getIDWithString:_placementID1.text] isEqualToString:placementId]) {
        [_activityIndicatorView1 removeFromSuperview];
        _playBtn1 = [[UIButton alloc] init];
        [_playBtn1 setTitle:NSLocalizedString(@"finished to play", nil) forState:UIControlStateNormal];
        [_playBtn1 setBackgroundColor:[UIColor orangeColor]];
        [_playBtn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_playBtn1 addTarget:self action:@selector(playAds1) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_playBtn1];
        [_playBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.placementID1.mas_right).offset(20);
            make.centerY.equalTo(self.placementID1);
        }];
    }
    if ([[self getIDWithString:_placementID2.text] isEqualToString:placementId]) {
        [_activityIndicatorView2 removeFromSuperview];
        _playBtn2 = [[UIButton alloc] init];
        [_playBtn2 setTitle:NSLocalizedString(@"finished to play", nil) forState:UIControlStateNormal];
        [_playBtn2 setBackgroundColor:[UIColor orangeColor]];
        [_playBtn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_playBtn2 addTarget:self action:@selector(playAds2) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_playBtn2];
        [_playBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.placementID2.mas_right).offset(20);
            make.centerY.equalTo(self.placementID2);
        }];
    }
    _count ++;
    if (_count == 2) {
        self.preloadBtn.userInteractionEnabled = YES;
    }
}

- (void)playAds1 {
    if ([_lighthouseAd isReady:@"176-10011"]) {
        [_lighthouseAd showWithplacementId:@"176-10011"];
    }
}
- (void)playAds2 {
    if ([_lighthouseAd isReady:@"176-10012"]) {
        [_lighthouseAd showWithplacementId:@"176-10012"];
    }
}

#pragma 获取url中的appid
- (NSString *)getIDWithString:(NSString *)string {
    
    NSArray *array = [string componentsSeparatedByString:@":"];
    
    return array[1];
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

/**
 广告展示成功
 
 @param lighthouseAd 主类
 */
- (void)lighthouseAdDidFinishShow:(LighthouseInterstailAd *)lighthouseAd {
    NSLog(@"广告展示成功");
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


@end
