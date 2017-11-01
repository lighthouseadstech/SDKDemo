//
//  LighthouseErrorCodes.h
//  AdirectsSDKProject
//
//  Created by hbc on 2017/10/1.
//  Copyright © 2017年 Adirects. All rights reserved.
//

#ifndef LighthouseErrorCodes_h
#define LighthouseErrorCodes_h

/// 请求成功,服务器成功返回广告
#define kLighthourseErrorCodeRequestSuccess  0

/// 更新publisher/投放单数据失败
#define kLighthourseErrorCodePublisherFailed  -1

/// SDK竞价请求json格式错误
#define kLighthourseErrorCodeJsonFormatError  1001

/// SDK竞价json字段缺少
#define kLighthourseErrorCodeJsonFieldMissing  1002

/// 竞价json字段类型错误
#define kLighthourseErrorCodeJsonFieldError  1003

/// 无效文件
#define kLighthourseErrorCodeFileInvalid  1100

/// 无效配置文件
#define kLighthourseErrorCodeFileConfigInvalid  1101

/// 文件node侦测初始化失败
#define kLighthourseErrorCodeNodeinitError  1102

/// 配置项错误
#define kLighthourseErrorCodeConfigError  1103

/// 配置项缺少
#define kLighthourseErrorCodeConfigLack  1104

/// 配置项无效
#define kLighthourseErrorCodeConfigInvalid  1105

/// 初始化日志失败
#define kLighthourseErrorCodeInitLogFailed  1106

/// 订单匹配失败
#define kLighthourseErrorCodeOrdermatchFailed  1107

/// 无效曝光请求
#define kLighthourseErrorCodeExposureinvalid   1108

/// 曝光过期
#define kLighthourseErrorCodeExposureexpire   1109

/// 匹配pub失败
#define kLighthourseErrorCodePubmatchFailed  1110

/// 存储曝光数据失败
#define kLighthourseErrorCodeExposureFailed   1111

/// 无效点击
#define kLighthourseErrorCodeTouchInvalid   1112

/// 存储点击数据失败
#define kLighthourseErrorCodeTouchdownFailed   1113

/// 匹配pub的Pkg包失败
#define kLighthourseErrorCodePkgmatchFailed    1114

#endif /* LighthouseErrorCodes_h */
