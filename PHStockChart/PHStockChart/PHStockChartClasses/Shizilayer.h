//
//  shizilayer.h
//  Kxiantu
//
//  Created by Peter on 4/21/16.
//  Copyright © 2016 Peter. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>

@interface ShiZilayer : CALayer



typedef NS_ENUM(NSUInteger, PHShiZiStyle) {
    /**
     *  绘制分时图十字线
     */
    PHShiZiStyleFenShiTu = 1,
    /**
     *  绘制蜡烛图十字线
     */
    PHShiZiStyleLaZhuTu = 2
};


/**
 *  初始化绘制十字线的样式
 *
 *  @param style 绘制分时图十字线或者蜡烛图十字线
 */
-(void)initWithShiZiStyle:(PHShiZiStyle) style;

/**
 *  设置十字线的X值和Y值
 *
 *  @param x 当前位置的x坐标
 *  @param y 当前位置的百分比，范围在 （0.00 - 1.00）之间
 */
-(void)setXvalue:(CGFloat) x
       andYvalue:(CGFloat) y;


/**
 *  设置十字线的线宽
 */
@property (nonatomic,assign) CGFloat lineWidth ;


@end
