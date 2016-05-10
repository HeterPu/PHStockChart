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
     *  KDJ样式  K ,D (0 - 100) J可以大于100，也可以小于0。
     */
    PHLaZhuTuSubstyleKDJ,
    /**
     *  RSI样式,值为（0 - 100）之间
     */
    PHLaZhuTuSubstyleRSI,
    /**
     *  BIAS样式,BIAS = (PRICE - DAY?AVERAGE)/AVERAGE * 100, DAY6,12,24.
     */
    PHLaZhuTuSubstyleBIAS,
    /**
     *  DMA样式,DMA = AVERAGE10 - AVERAGE50 , AMA = AVERAGE10 .
     */
    PHLaZhuTuSubstyleDMA,
    /**
     *  OBV样式,由OBV值和线两部分组成
     */
    PHLaZhuTuSubstyleOBV,
    /**
     *  ROC样式,一般有两条线组成，ROC =（tcprice - 12db_price)/12db_price *100
     */
    PHLaZhuTuSubstyleROC,
    /**
     *  MTM样式,MTM = (c + cn * 100) - 100
     */
    PHLaZhuTuSubstyleMTM,
    /**
     *  CR样式, CR = P1 / P2 * 100
     */
    PHLaZhuTuSubstyleCR,
    /**
     *  DMI样式, 由PDI,MDI,ADX,ADXR四条线组成
     */
    PHLaZhuTuSubstyleDMI,
    /**
     *  BRAR样式,情绪指标,由BR线和AR线组成
     */
    PHLaZhuTuSubstyleBRAR,
    /**
     *  VR样式,成交变异率
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


/**
 *  初始化RSI数组
 *
 *  @param rsiarray RSI数组
 */
-(void)initWithRSI:(NSArray *)rsiarray;

/**
 *  初始化BIAS数组
 *
 *  @param biasarray BIAS数组
 */
-(void)initWithBIAS:(NSArray *)biasarray;

/**
 *  初始化DMA数组
 *
 *  @param dmaarray DMA数组
 */
-(void)initWithDMA:(NSArray *)dmaarray;

/**
 *  初始化OBV数组
 *
 *  @param obvarray OBV数组
 */
-(void)initWithOBV:(NSArray *)obvarray;

/**
 *  初始化ROC数组
 *
 *  @param rocarray ROC数组
 */
-(void)initWithROC:(NSArray *)rocarray;

/**
 *  初始化MTM数组
 *
 *  @param mtmarray MTM数组
 */
-(void)initWithMTM:(NSArray *)mtmarray;


/**
 *  初始化CR数组
 *
 *  @param crarray CR数组
 */
-(void)initWithCR:(NSArray *)crarray;


/**
 *  初始化DMI数组
 *
 *  @param dmiarray DMI数组
 */
-(void)initWithDMI:(NSArray *)dmiarray;


/**
 *  初始化BRAR数组
 *
 *  @param brararray brar数组
 */
-(void)initWithBRAR:(NSArray *)brararray;


/**
 *  初始化VR数组
 *
 *  @param vrarray VR数组
 */
-(void)initWithVR:(NSArray *)vrarray;

/**
 *  初始化TRIX数组
 *
 *  @param trixarray VR数组
 */
-(void)initWithTRIX:(NSArray *)trixarray;

/**
 *  初始化EMV数组
 *
 *  @param emvarray EMV数组
 */
-(void)initWithEMV:(NSArray *)emvarray;

/**
 *  初始化WR数组
 *
 *  @param wrarray WR数组
 */
-(void)initWithWR:(NSArray *)wrarray;








/**
 *  初始化PSY数组
 *
 *  @param psyarray PSY数组
 */
-(void)initWithPSY:(NSArray *)psyarray;



/**
 *  初始化DPO数组
 *
 *  @param dpoarray DPO数组
 */
-(void)initWithDPO:(NSArray *)dpoarray;



/**
 *  初始化ASI数组
 *
 *  @param asiarray ASI数组
 */
-(void)initWithASI:(NSArray *)asiarray;






@end
