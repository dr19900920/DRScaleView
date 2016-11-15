//
//  UIColor+Category.h
//  MBSocial
//
//  Created by dengrui on 15/12/31.
//  Copyright © 2015年 dengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#undef HEX
#define HEX(__color) [UIColor colorWithHEX:(__color)]
@interface UIColor (Category)


/**
 hex:#ff0000 return:UIDeviceRGBColorSpace 1 0 0 1
 */
+ (UIColor *)colorWithHEX:(NSString *)hex;

/**
 随机色
 */
+ (UIColor *)randomColor;


@end
