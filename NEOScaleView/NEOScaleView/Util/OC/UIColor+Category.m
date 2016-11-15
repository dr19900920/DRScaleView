//
//  UIColor+Category.m
//  MBSocial
//
//  Created by dengrui on 15/12/31.
//  Copyright © 2015年 dengrui. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

//hex:#ff0000 return:[UIColor redColor];
+ (UIColor *)colorWithHEX:(NSString *)hex{
    if ([hex hasPrefix:@"#"]) {
        
        //#format color : #f00 --> #ff0000;
        if (hex.length == 4) {
            hex = [NSString stringWithFormat:@"#%c%c%c%c%c%c",
                   [hex characterAtIndex:1],
                   [hex characterAtIndex:1],
                   [hex characterAtIndex:2],
                   [hex characterAtIndex:2],
                   [hex characterAtIndex:3],
                   [hex characterAtIndex:3]];
        }
        
        const char* color = [[hex substringFromIndex:1] UTF8String];
        int xColor;
        if (sscanf(color, "%x",&xColor) == 1) {
            int r = (xColor >> 16) & 0xFF;
            int g = (xColor >> 8) & 0xFF;
            int b = (xColor) & 0xFF;
            return [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:1.0f];
        }
    }
    return [UIColor clearColor];
}

+ (UIColor *)randomColor {
    return [UIColor colorWithRed:arc4random_uniform(256) / 256.0 green:arc4random_uniform(256) / 256.0 blue:arc4random_uniform(256) / 256.0 alpha:1.0];
}
@end
