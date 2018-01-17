//
//  LighthouseInterstailAd.h
//  Adirects_SDK
//
//  Created by hbc on 2017/10/5.
//  Copyright © 2017年 Adirects. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LighthouseInterstailAd;

@protocol LighthouseInterstailAdDelegate <NSObject>
@optional
/// 预加载video

/**
 预加载视频失败
 
 @param lighthouseAd 主类
 @param error error
 @param placementId 对应广告视频的广告位id
 */
- (void)lighthouseAd:(LighthouseInterstailAd *)lighthouseAd didFailPreloadWithError:(NSError *)error withPlacementId:(NSString *)placementId;

/**
 预加载多条视频广告条目完成

 @param lighthouseAd 主类
 @param placementId 对应广告视频的广告位id
 */
- (void)lighthouseAdsReady:(LighthouseInterstailAd *)lighthouseAd withPlacementId:(NSString *)placementId;

/// 展示

/**
 广告展示成功
 
 @param lighthouseAd 主类
 */
- (void)lighthouseAdDidFinishShow:(LighthouseInterstailAd *)lighthouseAd;

/**
 广告展示失败
 
 @param lighthouseAd 主类
 @param error error
 */
- (void)lighthouseAd:(LighthouseInterstailAd *)lighthouseAd didFailShowWithError:(NSError *)error;

/**
 广告开始展示
 
 @param lighthouseAd 主类
 */
- (void)lighthouseAdDidStartShow:(LighthouseInterstailAd *)lighthouseAd;

/**
 广告点击关闭
 
 @param lighthouseAd 主类
 */
- (void)lighthouseAdDidClickClose:(LighthouseInterstailAd *)lighthouseAd;

/**
 广告点击下载
 
 @param lighthouseAd 主类
 */
- (void)lighthouseAdDidClickDownload:(LighthouseInterstailAd *)lighthouseAd;

@end

@interface LighthouseInterstailAd : NSObject

/**
 delegate
 */
@property (nonatomic, weak) id <LighthouseInterstailAdDelegate> delegate;

/**
 初始化多条广告位广告
 
 @param pubid 应用ID
 @param placementIDsArray 广告位ID数组
 @param delegate delegate
 @return 视频加载类
 */
+ (LighthouseInterstailAd *)initialize:(NSString *)pubid withPlacements:(NSArray<NSString *> *)placementIDsArray delegate:(id <LighthouseInterstailAdDelegate>)delegate;

/**
 广告位对应的广告是否加载完成

 @param placementId 广告位id
 @return 是否加载完成
 */
- (BOOL)isReady:(NSString *)placementId;

/**
 展示加载成功广告
 
 @param placementId 广告位id
 */
- (void)showWithplacementId:(NSString *)placementId;

@end
