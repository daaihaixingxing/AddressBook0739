//
//  UIImage+Scale.m
//  UITableViewEdit
//
//  Created by lanouhn on 15/9/11.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

- (UIImage *)scaleToSize:(CGSize)size {
    //创建一个bitmap的context，并指定为当前所使用的context；
    UIGraphicsBeginImageContext(size);
    //绘制改变大小后的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //从当前的context获取改变大小之后的图片
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    //使当前的context出栈
    UIGraphicsEndImageContext();
    //返回改变大小后的图片
    return scaleImage;
}

@end
