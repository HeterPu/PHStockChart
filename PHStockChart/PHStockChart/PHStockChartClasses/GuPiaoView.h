//
//  GuPiaoView.h
//  Kxiantu
//
//  Created by Peter on 5/09/16.
//  Copyright © 2016 Peter. All rights reserved.
//


#import <UIKit/UIKit.h>


/**
 *  选择绘制图表的样式
 */
typedef NS_ENUM(NSUInteger, PHChartstyle) {
    /**
     *  绘制分时图
     */
    PHChartStyleFenShiTu = 1,
    /**
     *  绘制蜡烛图
     */
    PHChartStyleLaZhuTu = 2
};



/**
 *  绘制蜡烛图子视图的样式
 */
typedef NS_ENUM(NSUInteger, PHLaZhuTuSubstyle) {
    /**
     *  交易量样式
     */
    PHLaZhuTuSubstyleVOL = 1,
    /**
     *  MACD样式
     */
    PHLaZhuTuSubstyleMACD,
    /**
     *  KDJ样式
     */
    PHLaZhuTuSubstyleKDJ,
    /**
     *  RSI样式
     */
    PHLaZhuTuSubstyleRSI,
    /**
     *  BIAS样式
     */
    PHLaZhuTuSubstyleBIAS,
    /**
     *  DMA样式
     */
    PHLaZhuTuSubstyleDMA,
    /**
     *  OBV样式
     */
    PHLaZhuTuSubstyleOBV,
    /**
     *  ROC样式
     */
    PHLaZhuTuSubstyleROC,
    /**
     *  MTM样式
     */
    PHLaZhuTuSubstyleMTM,
    /**
     *  CR样式
     */
    PHLaZhuTuSubstyleCR,
    /**
     *  DMI样式
     */
    PHLaZhuTuSubstyleDMI,
    /**
     *  BRAR样式
     */
    PHLaZhuTuSubstyleBRAR,
    /**
     *  VR样式
     */
    PHLaZhuTuSubstyleVR,
    /**
     *  TRIX样式
     */
    PHLaZhuTuSubstyleTRIX,
    /**
     *  EMV样式
     */
    PHLaZhuTuSubstyleEMV,
    /**
     *  WR样式
     */
    PHLaZhuTuSubstyleWR,
    /**
     *  CCI样式
     */
    PHLaZhuTuSubstyleCCI,
    /**
     *  PSY样式
     */
    PHLaZhuTuSubstylePSY,
    /**
     *  DPO样式
     */
    PHLaZhuTuSubstyleDPO,
    /**
     *  BOLL样式
     */
    PHLaZhuTuSubstyleBOLL,
    /**
     *  ASI样式
     */
    PHLaZhuTuSubstyleASI,
    /**
     *  SAR样式
     */
    PHLaZhuTuSubstyleSAR,
};



@interface GuPiaoView : UIView





/**
 *  初始化绘制图表的样式
 *
 *  @param style 绘制分时图或者蜡烛图
 */
-(void)initWithChartStyle:(PHChartstyle) style;


/**
 *  设置蜡烛图的子视图，只对蜡烛图有用
 */
@property (nonatomic,assign) PHLaZhuTuSubstyle laZhuTuSubStyle ;



/**
 *  视图的显示模式，正常模式或者放大显示模式
 */
@property (nonatomic,assign) BOOL isZoomMode;

/**
 *  是否显示十字线
 */
@property (nonatomic,assign) BOOL  isShiZiXianShown;




#pragma mark - 分时图初始化方法
/**
 *  初始化固定的文本标签
 */
-(void)initWithLabel;

/**
 *  初始化标签数据
 *
 *  @param zuoshou 昨日收盘的股指
 *  @param zongl   实时成交的交易量
 */
-(void)initWithZuoShou:(CGFloat)zuoshou zongL:(NSString *)zongl;

/**
 *  初始化数据数组
 *
 *  @param dazhe   大折线数组
 *  @param xiaozhe 小折线数组
 *  @param zhu     交易量数组
 */
-(void)fenShiWithDaZheData:(NSArray *)dazhe xiaoZheData:(NSArray *)xiaozhe zhuData:(NSArray *)zhu ;




#pragma mark - 蜡烛图初始化方法
/**
 *  初始化蜡烛图的数组
 *
 *  @param lztarray 蜡烛图数组
 */
-(void)initWithLZTarray:(NSArray *)lztarray;


/**
 *  初始化成交量的数组
 *
 *  @param volarray 成交量数组
 */
-(void)initWithVol:(NSArray *) volarray;


/**
 *  初始化MACD数组
 *
 *  @param volarray MACD数组
 */
-(void)initWithMACD:(NSArray *) macdarray;


/**
 *  初始化KDJ数组
 *
 *  @param kdjarray KDJ数组
 */
-(void)initWithKDJ:(NSArray *) kdjarray;



@end
