//
//  GuPiaoView.m
//  Kxiantu
//
//  Created by Peter on 4/20/16.
//  Copyright © 2016 Peter. All rights reserved.
//

#import "GuPiaoView.h"
#import "ShiZilayer.h"

//GuPiaoView Macro

#define padding  5
#define buttompadding  20
#define VIEW_SIZE  self.bounds.size
#define squareW  (VIEW_SIZE.width- 2 *padding) / 4
#define squareH  (VIEW_SIZE.height - 2 * padding - buttompadding) / 6
#define squareH1  (VIEW_SIZE.height - 3 * padding - buttompadding) / 5
#define color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface GuPiaoView ()

@property (nonatomic,weak) ShiZilayer * shiZiLayer;
@property (nonatomic,assign) PHChartstyle chartStyle;

#pragma mark -- 分时图属性
@property (nonatomic,strong) NSArray * zhuData;
@property (nonatomic,strong) NSArray * daZhexData;
@property (nonatomic,strong) NSArray * xiaoZhexData;


@property (nonatomic,strong) NSArray * fenShiVol;
@property (nonatomic,strong) NSArray * fenShiDaZhe;
@property (nonatomic,strong) NSArray * fenShiXiaoZhe;



@property (nonatomic,weak) UILabel * jyzl;
@property (nonatomic,weak) UILabel * zuidiB;
@property (nonatomic,weak) UILabel * zuidiL;
@property (nonatomic,weak) UILabel * zuigaoB;
@property (nonatomic,weak) UILabel * zuigaoL;
@property (nonatomic,weak) UILabel * shijian1;
@property (nonatomic,weak) UILabel * shijian2;
@property (nonatomic,weak) UILabel * shijian3;
@property (nonatomic,weak) UILabel * shijian4;
@property (nonatomic,weak) UILabel * shijian5;
@property (nonatomic,assign) CGFloat zuoShou;


#pragma mark -- 蜡烛图属性
@property (nonatomic,strong) NSArray * laZhuTuTransArray;
@property (nonatomic,strong) NSArray * volArray;
@property (nonatomic,strong) NSArray * macdArray;
@property (nonatomic,strong) NSArray * kdjArray;
@property (nonatomic,strong) NSArray * rsiArray;
@property (nonatomic,strong) NSArray * biasArray;
@property (nonatomic,strong) NSArray * dmaArray;
@property (nonatomic,strong) NSArray * obvArray;
@property (nonatomic,strong) NSArray * rocArray;
@property (nonatomic,strong) NSArray * mtmArray;
@property (nonatomic,strong) NSArray * crArray;
@property (nonatomic,strong) NSArray * dmiArray;
@property (nonatomic,strong) NSArray * brarArray;
@property (nonatomic,strong) NSArray * vrArray;
@property (nonatomic,strong) NSArray * trixArray;
@property (nonatomic,strong) NSArray * emvArray;
@property (nonatomic,strong) NSArray * wrArray;
//whitespace for cciArray
@property (nonatomic,strong) NSArray * psyArray;
@property (nonatomic,strong) NSArray * dpoArray;
//whitespace for bollArray
@property (nonatomic,strong) NSArray * asiArray;

#pragma mark -- 其它属性


@end

@implementation GuPiaoView

-(void)initWithChartStyle:(PHChartstyle)style
         isShiZiXianShown:(BOOL)shown {
    
    _chartStyle = style;
    _isShiZiXianShown = shown;
}


#pragma mark - 重绘方法

- (void)drawRect:(CGRect)rect {
    
    if( _chartStyle == PHChartStyleFenShiTu){
        
        [self setFangKuang];
        [self setBiaoQian];
        [self setVol1];
        [self setFenShiTu];
    }
    else
    {
        [self setfangkuang2];
        [self setLaZhuTu];
        
        switch(_laZhuTuSubStyle){
            case PHLaZhuTuSubstyleVOL:
                 [self setVol2];
                   break;
            case  PHLaZhuTuSubstyleMACD:
                [self setMACD];
                break;
            case PHLaZhuTuSubstyleKDJ:
                [self setKDJ];
                break;
            case PHLaZhuTuSubstyleRSI:
                [self setRSI];
                break;
            case PHLaZhuTuSubstyleBIAS:
                [self setBIAS];
                break;
            case PHLaZhuTuSubstyleDMA:
                [self setDMA];
                break;
            case PHLaZhuTuSubstyleOBV:
                [self setOBV];
                break;
            case PHLaZhuTuSubstyleROC:
                [self setROC];
                break;
            case PHLaZhuTuSubstyleMTM:
                [self setMTM];
                break;
            case PHLaZhuTuSubstyleCR:
                [self setCR];
                break;
            case PHLaZhuTuSubstyleDMI:
                [self setDMI];
                break;
            case PHLaZhuTuSubstyleBRAR:
                [self setBRAR];
                break;
            case PHLaZhuTuSubstyleVR:
                [self setVR];
                break;
            case PHLaZhuTuSubstyleTRIX:
                [self setTRIX];
                break;
            case PHLaZhuTuSubstyleEMV:
                [self setEMV];
                break;
            case PHLaZhuTuSubstyleWR:
                [self setWR];
                break;
            case PHLaZhuTuSubstyleCCI:
                [self setCCI];
                break;
            case PHLaZhuTuSubstylePSY:
                [self setVol2];
                break;
            case PHLaZhuTuSubstyleDPO:
                [self setDPO];
                break;
            case PHLaZhuTuSubstyleBOLL:
                [self setBOLL];
                break;
            case PHLaZhuTuSubstyleASI:
                [self setASI];
                break;
            case PHLaZhuTuSubstyleSAR:
                [self setSAR];
                break;
            default:
                break;
        }
    }
}

#pragma mark -- 分时图初始化方法

-(void)initWithLabel {
    //left
    UILabel *zuigaoL = [[UILabel alloc] init];
    zuigaoL.font = [UIFont systemFontOfSize:8.0];
    zuigaoL.textColor = color(166, 166, 166, 1);
    
    UILabel *zuidiL = [[UILabel alloc] init];
    zuidiL.font = [UIFont systemFontOfSize:8.0];
    zuidiL.textColor = color(166, 166, 166, 1);
    
    UILabel *jyzl = [[UILabel alloc] init];
    jyzl.font = [UIFont systemFontOfSize:8.0];
    jyzl.textColor = color(166, 166, 166, 1);
    //right
    UILabel *zuigaoB = [[UILabel alloc] init];
    zuigaoB.textAlignment = NSTextAlignmentRight;
    zuigaoB.font = [UIFont systemFontOfSize:8.0];
    zuigaoB.textColor = color(166, 166, 166, 1);

    UILabel *zuidiB = [[UILabel alloc] init];
    zuidiB.textAlignment = NSTextAlignmentRight;
    zuidiB.font = [UIFont systemFontOfSize:8.0];
    zuidiB.textColor = color(166, 166, 166, 1);
    //shijian
    UILabel *shijian1 = [[UILabel alloc] init];
    shijian1.text = @"09.30";
    shijian1.textAlignment = NSTextAlignmentLeft;
    shijian1.font = [UIFont systemFontOfSize:7.0];
    shijian1.textColor = color(166, 166, 166, 1);
    
    UILabel *shijian2 = [[UILabel alloc] init];
    shijian2.text = @"10.30";
    shijian2.textAlignment = NSTextAlignmentCenter;
    shijian2.font = [UIFont systemFontOfSize:7.0];
    shijian2.textColor = color(166, 166, 166, 1);
    
    UILabel *shijian3 = [[UILabel alloc] init];
    shijian3.text = @"11.30/13:00";
    shijian3.textAlignment = NSTextAlignmentCenter;
    shijian3.font = [UIFont systemFontOfSize:7.0];
    shijian3.textColor = color(166, 166, 166, 1);
    
    UILabel *shijian4 = [[UILabel alloc] init];
    shijian4.text = @"14:00";
    shijian4.textAlignment = NSTextAlignmentCenter;
    shijian4.font = [UIFont systemFontOfSize:7.0];
    shijian4.textColor = color(166, 166, 166, 1);
    
    UILabel *shijian5 = [[UILabel alloc] init];
    shijian5.text = @"15:00";
    shijian5.textAlignment = NSTextAlignmentRight;
    shijian5.font = [UIFont systemFontOfSize:7.0];
    shijian5.textColor = color(166, 166, 166, 1);
   
    if (self.isShiZiXianShown == YES) {
        if (!_shiZiLayer) {
            ShiZilayer *shizi = [[ShiZilayer alloc] init];
            _shiZiLayer = shizi;
            [self.layer addSublayer:shizi];
        }
        _shiZiLayer.hidden = YES;
        [_shiZiLayer initWithShiZiStyle:PHShiZiStyleFenShiTu];
    }
    
    _zuigaoL = zuigaoL;
    _zuidiL = zuidiL;
    _zuigaoB = zuigaoB;
    _zuidiB = zuidiB;
    _jyzl = jyzl;
    _shijian1 = shijian1;
    _shijian2 = shijian2;
    _shijian3 = shijian3;
    _shijian4 = shijian4;
    _shijian5 = shijian5;
    
    [self addSubview: zuigaoL];
    [self addSubview: zuidiL];
    [self addSubview: zuigaoB];
    [self addSubview: zuidiB];
    [self addSubview:jyzl];
    [self addSubview:shijian1];
    [self addSubview:shijian2];
    [self addSubview:shijian3];
    [self addSubview:shijian4];
    [self addSubview:shijian5];
}





-(void)initWithZuoShou:(CGFloat)zuoshou
                 zongL:(NSString *)zongl{
    
    _zuoShou = zuoshou;
    _jyzl.text= zongl;
}



-(void)fenShiWithDaZheData:(NSArray *)dazhe
               xiaoZheData:(NSArray *)xiaozhe
                   zhuData:(NSArray *)zhu {
    _zhuData = zhu;
    _daZhexData = dazhe;
    _xiaoZhexData = xiaozhe;
    [self transferFenShiData];
}


-(void)transferFenShiData {
    
    // find biggest offsetvalue
    CGFloat  maxOffSetValue = 0 ;
    
    for (NSNumber *num  in _daZhexData) {
        CGFloat absolutevalue = [self getAbsoluteFloatValue:([num floatValue] - _zuoShou)];
        if (maxOffSetValue < absolutevalue) maxOffSetValue = absolutevalue;
    }
    for (NSString *num  in _xiaoZhexData) {
        CGFloat absolutevalue = [self getAbsoluteFloatValue:([num floatValue] - _zuoShou)];
        if (maxOffSetValue < absolutevalue) maxOffSetValue = absolutevalue;
    }
    CGFloat high = _zuoShou + maxOffSetValue;
    CGFloat low  = _zuoShou - maxOffSetValue;
    
   // set fenshidazhexian array
    NSMutableArray *dazhe = [NSMutableArray array];
    for (NSNumber * num in  _daZhexData) {
        CGFloat temptfloat = ([num floatValue] - low)/(2 * maxOffSetValue);
        [dazhe addObject:[NSNumber numberWithFloat:temptfloat]];
    }
    _fenShiDaZhe = dazhe;
    
    // set fenshixiaozhexian array
    NSMutableArray *xiaozhe = [NSMutableArray array];
    for (NSNumber * num in  _xiaoZhexData) {
        CGFloat temptfloat = ([num floatValue] - low)/(2 * maxOffSetValue);
        [xiaozhe addObject:[NSNumber numberWithFloat:temptfloat]];
    }
    _fenShiXiaoZhe = xiaozhe;
    
    //转换分时图成交量数据
    NSMutableArray *temptarra = [NSMutableArray array];
    CGFloat _max_NUM =[ _zhuData[0][1] floatValue] ;
    
    for (NSArray * arra in  _zhuData) {
        for (NSNumber * num in arra) {
            if (_max_NUM < [num floatValue]) _max_NUM = [num floatValue];
        }
    }
    
    for (NSArray * arra in  _zhuData) {
        NSMutableArray *tempt = [NSMutableArray array];
        NSNumber *temptNumber1 = arra[0];
        NSNumber *temptNumber2 = [NSNumber numberWithFloat:(([ arra[1] floatValue])/ _max_NUM )];
        
        [tempt addObject:temptNumber1];
        [tempt addObject:temptNumber2];
        [temptarra addObject:tempt];
    }
    _fenShiVol = temptarra;
    
    //setlabel
    _zuigaoL.text = [NSString stringWithFormat:@"%.1f",high];
    _zuigaoB.text = [NSString stringWithFormat:@"%.2f%%",maxOffSetValue * 100 / _zuoShou];
    _zuidiL.text = [NSString stringWithFormat:@"%.1f",low];
    _zuidiB.text = [NSString stringWithFormat:@"-%.2f%%",maxOffSetValue  * 100 / _zuoShou];
    
    if (self.isShiZiXianShown == YES) {
        
        if (!_shiZiLayer) {
            ShiZilayer *shizi = [[ShiZilayer alloc] init];
            _shiZiLayer = shizi;
            [self.layer addSublayer:shizi];
        }
        _shiZiLayer.hidden = YES;
        [_shiZiLayer initWithShiZiStyle:PHShiZiStyleFenShiTu];
    }

}


#pragma mark - 蜡烛图初始化方法

//初始化蜡烛图
-(void)initWithLZTarray:(NSArray *)lztarray    {
    
    if (self.isShiZiXianShown == YES) {
        
        if (!_shiZiLayer) {
            ShiZilayer *shizi = [[ShiZilayer alloc] init];
            _shiZiLayer = shizi;
           [self.layer addSublayer:shizi];
        }
            _shiZiLayer.hidden = YES;
            [_shiZiLayer initWithShiZiStyle:PHShiZiStyleLaZhuTu];
    }
    
    NSMutableArray *temptarra = [NSMutableArray array];
    
    CGFloat _max_NUM = [lztarray[0][0] floatValue];
    CGFloat  _min_NUM = [lztarray[0][0] floatValue];
    
    for (NSArray * arra in  lztarray) {
        for (int i = 0; i < 7; i++) {
            NSNumber *num = arra[i];
            if (_max_NUM < [num floatValue]) _max_NUM = [num floatValue];
            if (_min_NUM > [num floatValue]) _min_NUM = [num floatValue];
  }
}
    _max_NUM -= _min_NUM;
    for (NSArray * arra in  lztarray) {
        NSMutableArray *tempt = [NSMutableArray array];
        for (NSNumber *num in arra) {
            NSNumber *temptNumber = [NSNumber numberWithFloat:(([ num floatValue] - _min_NUM )/ _max_NUM )];
            [tempt addObject:temptNumber];
    }
            [temptarra addObject:tempt];
  }
    _laZhuTuTransArray = temptarra;
}


//初始化成交量
-(void)initWithVol:(NSArray *) volarray {
    
    NSMutableArray *temptarra = [NSMutableArray array];
    CGFloat _max_NUM =[ volarray[0][1] floatValue] ;
    for (NSArray * arra in  volarray) {
        for (NSNumber * num in arra) {
            if (_max_NUM < [num floatValue]) _max_NUM = [num floatValue];
  }
}
    for (NSArray * arra in  volarray) {
        NSMutableArray *tempt = [NSMutableArray array];
        NSNumber *temptNumber1 = arra[0];
        NSNumber *temptNumber2 = [NSNumber numberWithFloat: (([ arra[1] floatValue])/ _max_NUM )];

        [tempt addObject:temptNumber1];
        [tempt addObject:temptNumber2];
        [temptarra addObject:tempt];
  }
    _volArray = temptarra;
}


//初始化macd
-(void)initWithMACD:(NSArray *)macdarray {
    
    CGFloat _max_NUM = 0;
    for (NSArray *arra in macdarray) {
        CGFloat ema12 = [arra[0] floatValue];
        CGFloat ema26 = [arra[1] floatValue];
        CGFloat dif = ema12 - ema26;
        
        if (_max_NUM < [self getAbsoluteFloatValue:ema12] ) _max_NUM = [self getAbsoluteFloatValue:ema12];
        if (_max_NUM < [self getAbsoluteFloatValue:ema26] ) _max_NUM = [self getAbsoluteFloatValue:ema26];
        if (_max_NUM < [self getAbsoluteFloatValue:dif] ) _max_NUM = [self getAbsoluteFloatValue:dif];
}
    NSMutableArray *temptarra = [NSMutableArray array];
    for (NSArray * arra in macdarray) {
        NSMutableArray *temptarray = [NSMutableArray array];
        CGFloat ema12 = [arra[0] floatValue] / (_max_NUM * 1.1);
        CGFloat ema26 = [arra[1] floatValue] / (_max_NUM * 1.1);
        CGFloat delta = (ema12 - ema26) * 2 ;
        
        [temptarray addObject:[NSNumber numberWithFloat:ema12]];
        [temptarray addObject:[NSNumber numberWithFloat:ema26]];
        [temptarray addObject:[NSNumber numberWithFloat:delta]];
        
        [temptarra addObject:temptarray];
  }
    _macdArray = temptarra;
}


-(void)initWithKDJ:(NSArray *)kdjarray {
    
    _kdjArray = [self getLineArray:kdjarray];
}


-(void)initWithRSI:(NSArray *)rsiarray {
    
    _rsiArray = [self rsiArray];
}


-(void)initWithBIAS:(NSArray *)biasarray {

    _biasArray = [self getLineArray:biasarray];
}


-(void)initWithDMA:(NSArray *)dmaarray {
    
    _dmaArray = [self getLineArray:dmaarray];
}


-(void)initWithOBV:(NSArray *)obvarray {
    
    _obvArray = [self getLineArray:obvarray];
}


-(void)initWithROC:(NSArray *)rocarray {
    
    _rocArray = [self getLineArray:rocarray];
}


-(void)initWithMTM:(NSArray *)mtmarray {
    
    CGFloat _MAX_NUM = [mtmarray[0][0] floatValue];
    CGFloat _MIN_NUM = [mtmarray[0][0] floatValue];
    
    for (NSArray *arra in mtmarray) {
        CGFloat MTM1value = [arra[0] floatValue];
        CGFloat MTM2value = [arra[1] floatValue];
        
        if (_MAX_NUM < MTM1value ) _MAX_NUM = MTM1value;
        if (_MAX_NUM < MTM2value ) _MAX_NUM = MTM2value;
        
        if (_MIN_NUM > MTM1value ) _MIN_NUM = MTM1value;
        if (_MIN_NUM > MTM2value ) _MIN_NUM = MTM2value;
    }
    
    CGFloat delta = _MAX_NUM - _MIN_NUM;
    
    NSMutableArray *temptarra = [NSMutableArray array];
    for (NSArray *arra in mtmarray) {
        NSMutableArray *temptarray = [NSMutableArray array];
        CGFloat mtm1newvalue = ([arra[0] floatValue] - _MIN_NUM) / delta;
        CGFloat mtm2newvalue = ([arra[1] floatValue] - _MIN_NUM) / delta;
        [temptarray addObject: [NSNumber numberWithFloat:mtm1newvalue]];
        [temptarray addObject: [NSNumber numberWithFloat:mtm2newvalue]];
        [temptarra addObject:temptarray];
    }
    _mtmArray = temptarra;
}


-(void)initWithCR:(NSArray *)crarray {
    
        _crArray = [self getLineArray:crarray];
}


-(void)initWithDMI:(NSArray *)dmiarray {
    
       _dmiArray = [self getLineArray:dmiarray];
    
}


-(void)initWithBRAR:(NSArray *)brararray {
    
    CGFloat _MAX_NUM = [brararray[0][0] floatValue];
    CGFloat _MIN_NUM = [brararray[0][0] floatValue];
    
    for (NSArray *arra in brararray) {
        CGFloat brar1value = [arra[0] floatValue];
        CGFloat brar2value = [arra[1] floatValue];
        
        if (_MAX_NUM < brar1value ) _MAX_NUM = brar1value;
        if (_MAX_NUM < brar2value ) _MAX_NUM = brar2value;
        
        if (_MIN_NUM > brar1value ) _MIN_NUM = brar1value;
        if (_MIN_NUM > brar2value ) _MIN_NUM = brar2value;
    }
    
    CGFloat delta = _MAX_NUM - _MIN_NUM;
    
    NSMutableArray *temptarra = [NSMutableArray array];
    for (NSArray *arra in brararray) {
        NSMutableArray *temptarray = [NSMutableArray array];
        CGFloat brar1newvalue = ([arra[0] floatValue] - _MIN_NUM) / delta;
        CGFloat brar2newvalue = ([arra[1] floatValue] - _MIN_NUM) / delta;
        [temptarray addObject: [NSNumber numberWithFloat:brar1newvalue]];
        [temptarray addObject: [NSNumber numberWithFloat:brar2newvalue]];
        [temptarra addObject:temptarray];
    }
    _brarArray = temptarra;
}



-(void)initWithVR:(NSArray *)vrarray {
    
    _vrArray = [self getLineArray:vrarray];
}



-(void)initWithTRIX:(NSArray *)trixarray {
    
    _trixArray = [self getLineArray:trixarray];
}


-(void)initWithEMV:(NSArray *)emvarray {
    
    _emvArray = [self getLineArray:emvarray];
}


-(void)initWithWR:(NSArray *)wrarray {
    
    _wrArray = [self getLineArray:wrarray];
}


-(void)initWithCCI:(NSArray *)cciarray {
    
}

-(void)initWithPSY:(NSArray *)psyarray {
    
    _psyArray = [self getLineArray:psyarray];
}


-(void)initWithDPO:(NSArray *)dpoarray {
    
    _dpoArray = [self getLineArray:dpoarray];
}


-(void)initWithBOLL:(NSArray *)bollarray {
    
}


-(void)initWithASI:(NSArray *)asiarray {
    
    _asiArray = [self getLineArray:asiarray];
}


-(void)initWithSAR:(NSArray *)sararray {
    
}


#pragma mark -- 分时图绘图

// 设置框线
- (void)setFangKuang {
    
    CGContextRef  ctxSK =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxSK, padding, padding);
    CGContextAddLineToPoint(ctxSK, VIEW_SIZE.width - padding, padding);
    CGContextAddLineToPoint(ctxSK, VIEW_SIZE.width - padding, padding + 4*squareH);
    CGContextAddLineToPoint(ctxSK, padding, padding + 4*squareH);
    CGContextClosePath(ctxSK);
    CGContextSetLineWidth(ctxSK, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxSK);
    
    CGContextRef  ctxxK =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxxK, padding, 2*padding + 4*squareH);
    CGContextAddLineToPoint(ctxxK, VIEW_SIZE.width - padding, 2 * padding + 4*squareH);
    CGContextAddLineToPoint(ctxxK, VIEW_SIZE.width - padding, VIEW_SIZE.height - buttompadding);
    CGContextAddLineToPoint(ctxxK, padding, VIEW_SIZE.height - buttompadding);
    CGContextClosePath(ctxxK);
    CGContextSetLineWidth(ctxxK, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxxK);
    //1coloum
    CGContextRef  ctxc11 =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxc11, padding + squareW, padding);
    CGContextAddLineToPoint(ctxc11, padding + squareW, padding + 4*squareH);
    CGContextSetLineWidth(ctxc11, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxc11);
    
    CGContextRef  ctxc12 =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxc12, padding + 2*squareW, padding);
    CGContextAddLineToPoint(ctxc12, padding + 2*squareW, padding + 4*squareH);
    CGContextSetLineWidth(ctxc12, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxc12);
    
    CGContextRef  ctxc13 =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxc13, padding + 3*squareW, padding);
    CGContextAddLineToPoint(ctxc13, padding + 3*squareW, padding + 4*squareH);
    CGContextSetLineWidth(ctxc13, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxc13);
    //1row
    CGContextRef  ctxr11 =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxr11, padding, padding + squareH * 1 );
    CGContextAddLineToPoint(ctxr11,VIEW_SIZE.width - padding, padding + squareH * 1 );
    CGContextSetLineWidth(ctxr11, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxr11);
    
    CGContextRef  ctxr13 =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxr13, padding, padding + squareH * 3 );
    CGContextAddLineToPoint(ctxr13,VIEW_SIZE.width - padding, padding + squareH * 3 );
    CGContextSetLineWidth(ctxr13, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxr13);
    //2colum
    CGContextRef  ctxc21 =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxc21, padding + squareW, 2 * padding + 4 * squareH);
    CGContextAddLineToPoint(ctxc21, padding + squareW, VIEW_SIZE.height - buttompadding);
    CGContextSetLineWidth(ctxc21, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxc21);
    
    CGContextRef  ctxc22 =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxc22, padding + 2*squareW, 2 * padding + 4 * squareH);
    CGContextAddLineToPoint(ctxc22, padding + 2*squareW, VIEW_SIZE.height - buttompadding);
    CGContextSetLineWidth(ctxc22, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxc22);
    
    CGContextRef  ctxc23 =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxc23, padding + 3*squareW, 2 * padding + 4 * squareH);
    CGContextAddLineToPoint(ctxc23, padding + 3*squareW, VIEW_SIZE.height - buttompadding);
    CGContextSetLineWidth(ctxc23, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxc23);
    //2row
    CGContextRef  ctxr21 =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxr21, padding, 2 * padding + squareH * 5 );
    CGContextAddLineToPoint(ctxr21,VIEW_SIZE.width - padding, 2 * padding + squareH * 5 );
    CGContextSetLineWidth(ctxr21, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxr21);
}





// 标签和时间

- (void) setBiaoQian {
//left
    _zuigaoL.frame = CGRectMake( padding + 1, padding + 1, 50, 15);
    _zuidiL.frame =  CGRectMake(padding + 1, padding + 4 * squareH - 15, 50, 15);
    _jyzl.frame =  CGRectMake(padding + 1, 2 * padding + 4 * squareH , 50, 15);
//right
    _zuigaoB.frame =  CGRectMake( VIEW_SIZE.width -padding - 51, padding + 1, 50, 15);
    _zuidiB.frame = CGRectMake(VIEW_SIZE.width -padding - 51, padding + 4 * squareH - 15, 50, 15);
//shijian
    _shijian1.frame = CGRectMake( padding , VIEW_SIZE.height - 20, 50, 15);
    _shijian2.frame = CGRectMake( padding + squareW - 25 , VIEW_SIZE.height - 20, 50, 15);
    _shijian3.frame = CGRectMake( padding + 2 * squareW - 25 , VIEW_SIZE.height - 20, 50, 15);
    _shijian4.frame = CGRectMake( padding + 3 * squareW - 25 , VIEW_SIZE.height - 20, 50, 15);
    _shijian5.frame = CGRectMake( VIEW_SIZE.width - 56 , VIEW_SIZE.height - 20, 50, 15);

    if (self.isShiZiXianShown == YES) {
        _shiZiLayer.frame = CGRectMake(0, 0, VIEW_SIZE.width, VIEW_SIZE.height);
       [_shiZiLayer setNeedsDisplay];
  }
}

-(void) setFenShiTu {
    
//zhexiantianchong
    CGContextRef  dazhexianY=  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(dazhexianY, padding, padding + 4 * squareH);

    int count1 = (int) _fenShiDaZhe.count;
    for (int i = 0; i < count1; i++) {
        NSNumber  *percentage = _fenShiDaZhe[i];
        CGFloat x = padding + i * squareW / 60 ;
        CGFloat y = padding + 4 * squareH * (1 - [percentage floatValue]);
        CGContextAddLineToPoint(dazhexianY, x, y);
   }
    float  lastPointX = padding + count1 * squareW / 60 ;
    CGContextAddLineToPoint(dazhexianY, lastPointX, padding + 4 * squareH);
    [color(229, 241, 250, 1) set ];
    CGContextSetLineJoin(dazhexianY, kCGLineJoinRound);
    CGContextClosePath(dazhexianY);
    CGContextFillPath(dazhexianY);
//dazhexian
    CGContextRef  dazhexian=  UIGraphicsGetCurrentContext();

        for (int i = 0; i < count1; i++) {
            NSNumber *percentage = _fenShiDaZhe[i];
            CGFloat x = padding + i * squareW / 60 ;
            CGFloat y = padding + 4 * squareH * (1 - [percentage floatValue]);
            
            if (i == 0) {
                CGContextMoveToPoint(dazhexian, x , y );
            }
            else
            {
            CGContextAddLineToPoint(dazhexian, x, y);
            }
}
    [color(152, 168, 191, 1) set ];
    CGContextSetLineJoin(dazhexian, kCGLineJoinRound);
    CGContextStrokePath(dazhexian);
//xiaozhexian
    CGContextRef  xiaozhexian=  UIGraphicsGetCurrentContext();
    
            int count2 = (int)_fenShiXiaoZhe.count;
            for (int i = 0; i < count2; i++) {
                NSString  *percentage = _fenShiXiaoZhe[i];
                CGFloat x = padding + i * squareW / 60 ;
                CGFloat y = padding + 4 * squareH * (1 - percentage.floatValue);
                if (i == 0) {
                    CGContextMoveToPoint(xiaozhexian, x , y );
                }
                else
                {
                CGContextAddLineToPoint(xiaozhexian, x, y);
                }
            }
    [color(252, 197, 152, 1) set ];
    CGContextSetLineJoin(xiaozhexian, kCGLineJoinRound);
    CGContextStrokePath(xiaozhexian);
//虚线
    CGFloat lengths[] = {4,4};
    CGContextRef  ctxr12 =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxr12, padding, padding + squareH * 2 );
    CGContextAddLineToPoint(ctxr12,VIEW_SIZE.width - padding, padding + squareH * 2 );
    CGContextSetLineDash(ctxr12, 5.0f, lengths, sizeof(lengths)/sizeof(lengths[0]));
    CGContextSetLineWidth(ctxr12, 1);
    [color(143, 243, 249, 1) set];
    CGContextStrokePath(ctxr12);
}

// 柱状图
-(void) setVol1 {
    
    int count  = (int) _fenShiVol.count;
    for (int i = 0; i < count ; i++) {
        NSNumber *redorblue = _fenShiVol[i][0];
        NSNumber *percentage = _fenShiVol[i][1];
        [self zhutu1Index:i redOrBlue:[redorblue boolValue] percenttage:[NSNumber numberWithFloat:[percentage floatValue]]];
  }
}


-(void)zhutu1Index:(NSInteger)index
         redOrBlue:(BOOL)redOrBlue
       percenttage:(NSNumber *)percentage {

    CGFloat startPointX = padding  + squareW / 60 * index;
    CGFloat startPointY = VIEW_SIZE.height - buttompadding;
    CGFloat endPointX = padding  + squareW / 60 * index;
    CGFloat endPointY = VIEW_SIZE.height  - buttompadding -  2 * squareH  * [percentage floatValue] ;
    
    CGContextRef  ctx=  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, startPointX, startPointY);
    CGContextAddLineToPoint(ctx, endPointX, endPointY);
    UIColor *color = redOrBlue ? color(236, 86, 85, 1) : color(30, 170, 94, 1);
    [color set ];
    CGContextStrokePath(ctx);
}


#pragma mark --绘制蜡烛图

//绘制方框
- (void)setfangkuang2 {
    
    CGContextRef  ctxSK =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxSK, padding, padding);
    CGContextAddLineToPoint(ctxSK, VIEW_SIZE.width - padding, padding);
    CGContextAddLineToPoint(ctxSK, VIEW_SIZE.width - padding, padding + 4*squareH1);
    CGContextAddLineToPoint(ctxSK, padding, padding + 4*squareH1);
    CGContextClosePath(ctxSK);
    CGContextSetLineWidth(ctxSK, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxSK);
    
    CGContextRef  ctxxK =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxxK, padding, 2*padding + buttompadding + 4*squareH1);
    CGContextAddLineToPoint(ctxxK, VIEW_SIZE.width - padding, 2*padding + buttompadding + 4*squareH1);
    CGContextAddLineToPoint(ctxxK, VIEW_SIZE.width - padding, VIEW_SIZE.height - padding);
    CGContextAddLineToPoint(ctxxK, padding, VIEW_SIZE.height - padding);
    CGContextClosePath(ctxxK);
    CGContextSetLineWidth(ctxxK, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxxK);
    
    CGFloat lengths[] = {2,2};
    CGContextRef  ctxr11 =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxr11, padding, padding + squareH1 * 1 );
    CGContextAddLineToPoint(ctxr11,VIEW_SIZE.width - padding, padding + squareH1 * 1 );
    CGContextSetLineDash(ctxr11, 5.0f, lengths, sizeof(lengths)/sizeof(lengths[0]));
    CGContextSetLineWidth(ctxr11, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxr11);
    
    CGContextRef  ctxr12 =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxr12, padding, padding + squareH1 * 2 );
    CGContextAddLineToPoint(ctxr12,VIEW_SIZE.width - padding, padding + squareH1 * 2 );
    CGContextSetLineWidth(ctxr12, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxr12);
    
    CGContextRef  ctxr13 =  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctxr13, padding, padding + squareH1 * 3 );
    CGContextAddLineToPoint(ctxr13,VIEW_SIZE.width - padding, padding + squareH1 * 3 );
    CGContextSetLineWidth(ctxr13, 1);
    [color(239, 243, 244, 1) set];
    CGContextStrokePath(ctxr13);
    
    if(_isZoomMode == NO) {
//ROW HIDE
        CGContextRef  ctxrH1 =  UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctxrH1, padding, padding + squareH1 / 2 * 1 );
        CGContextAddLineToPoint(ctxrH1,VIEW_SIZE.width - padding, padding + squareH1 / 2 * 1 );
        CGContextSetLineWidth(ctxrH1, 1);
        [color(239, 243, 244, 1) set];
        CGContextStrokePath(ctxrH1);
        
        CGContextRef  ctxrH2 =  UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctxrH2, padding, padding + squareH1 / 2 * 3 );
        CGContextAddLineToPoint(ctxrH2,VIEW_SIZE.width - padding, padding + squareH1 / 2 * 3 );
        CGContextSetLineWidth(ctxrH2, 1);
        [color(239, 243, 244, 1) set];
        CGContextStrokePath(ctxrH2);
        
        CGContextRef  ctxrH3 =  UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctxrH3, padding, padding + squareH1 / 2 * 5 );
        CGContextAddLineToPoint(ctxrH3,VIEW_SIZE.width - padding, padding + squareH1 / 2 * 5 );
        CGContextSetLineWidth(ctxrH3, 1);
        [color(239, 243, 244, 1) set];
        CGContextStrokePath(ctxrH3);
        
        CGContextRef  ctxrH4 =  UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctxrH4, padding, padding + squareH1 / 2 * 7 );
        CGContextAddLineToPoint(ctxrH4,VIEW_SIZE.width - padding, padding + squareH1 / 2 * 7 );
        CGContextSetLineWidth(ctxrH4, 1);
        [color(239, 243, 244, 1) set];
        CGContextStrokePath(ctxrH4);
//2row
        CGContextRef  ctxrH5 =  UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctxrH5, padding, VIEW_SIZE.height - padding - squareH1 / 2 );
        CGContextAddLineToPoint(ctxrH5,VIEW_SIZE.width - padding, VIEW_SIZE.height - padding - squareH1 / 2 );
        CGContextSetLineWidth(ctxrH5, 1);
        [color(239, 243, 244, 1) set];
        CGContextStrokePath(ctxrH5);
    }
    
    if (self.isShiZiXianShown == YES) {
        [_shiZiLayer initWithShiZiStyle:PHShiZiStyleLaZhuTu];
        _shiZiLayer.frame = CGRectMake(0, 0, VIEW_SIZE.width, VIEW_SIZE.height);
        [_shiZiLayer setNeedsDisplay];
    }
}


//绘制蜡烛图和M5 M10 和 M20线
-(void)setLaZhuTu {
    
    CGFloat lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324;
    CGFloat lazhuCXwidth = lazhuUnitDot * 3;
    int count = (int) _laZhuTuTransArray.count;
    
    CGContextRef  ctx =  UIGraphicsGetCurrentContext();
    CGContextSetLineDash(ctx, 5.0f, 0, 0);
//蜡烛图
    for (int i = 0; i < count; i++) {
        CGFloat high  = [_laZhuTuTransArray[i][0] floatValue];
        CGFloat low   = [_laZhuTuTransArray[i][1] floatValue];
        CGFloat open  = [_laZhuTuTransArray[i][2] floatValue];
        CGFloat close = [_laZhuTuTransArray[i][3] floatValue];
        if ( close > open) {
            [color(252, 64, 69, 1) set];
        }else
        {
            [color(56, 171, 36, 1) set];
        }
        CGContextMoveToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot , padding + ( 1 - high) * 4 *squareH1 );
        CGContextAddLineToPoint(ctx,padding + (3 + 4 * i) * lazhuUnitDot, padding + ( 1 - low) * 4 *squareH1  );
        CGContextSetLineWidth(ctx, lazhuUnitDot);
        CGContextStrokePath(ctx);
    
        CGContextMoveToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, padding + ( 1 - open) * 4 *squareH1  );
        CGContextAddLineToPoint(ctx,padding + (3 + 4 * i) * lazhuUnitDot, padding + ( 1 - close) * 4 *squareH1 );
        CGContextSetLineWidth(ctx, lazhuCXwidth);
        CGContextStrokePath(ctx);
    }
//M5线
    CGContextSetLineWidth(ctx, lazhuUnitDot);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    CGFloat m5lineStart = [_laZhuTuTransArray[0][4] floatValue];
    CGFloat m10lineStart = [_laZhuTuTransArray[0][5] floatValue];
    CGFloat m20lineStart  = [_laZhuTuTransArray[0][6] floatValue];
    
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, padding + ( 1 - m5lineStart) * 4 *squareH1);
    for (int i = 1; i < count; i++) {
        CGFloat m5line = [_laZhuTuTransArray[i][4] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, padding + ( 1 - m5line) * 4 *squareH1);
    }
    [color(67, 188, 252, 1)  set];
    CGContextSetLineWidth(ctx, 0.5);
    CGContextStrokePath(ctx);
//M10线
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, padding + ( 1 - m10lineStart) * 4 *squareH1);
    for (int i = 1; i < count; i++) {
        CGFloat m10line = [_laZhuTuTransArray[i][5] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, padding + ( 1 - m10line) * 4 *squareH1);
    }
    [color(236, 194, 81, 1)  set];
    CGContextSetLineWidth(ctx, 0.5);
    CGContextStrokePath(ctx);
//M20线
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, padding + ( 1 - m20lineStart) * 4 *squareH1);
    for (int i = 1; i < count; i++) {
        CGFloat m20line  = [_laZhuTuTransArray[i][6] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, padding + ( 1 - m20line) * 4 *squareH1);
    }
    [color(224, 106, 237, 1)  set];
    CGContextSetLineWidth(ctx, 0.5);
    CGContextStrokePath(ctx);
}


//绘制成交量
-(void)setVol2 {
    
    int count  = (int) _volArray.count;
    for (int i = 0; i < count ; i++) {
        NSNumber *redorblue = _volArray[i][0];
        NSNumber *percentage = _volArray[i][1];
        [self zhutu2Index:i redOrBlue:[redorblue boolValue] percenttage:percentage];
    }
}


-(void)zhutu2Index:(NSInteger)index
         redOrBlue:(BOOL)redOrBlue
       percenttage:(NSNumber *)percentage {
    
    CGFloat lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324;
    CGFloat lazhuCXwidth = lazhuUnitDot * 3;
    
    CGFloat startPointX = padding + (3 + 4 * index) * lazhuUnitDot;
    CGFloat startPointY = VIEW_SIZE.height - padding;
    CGFloat endPointX = padding + (3 + 4 * index) * lazhuUnitDot;
    CGFloat endPointY = VIEW_SIZE.height  - padding -  squareH1  * [percentage floatValue] ;
    
    CGContextRef  ctx=  UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, startPointX, startPointY);
    CGContextAddLineToPoint(ctx, endPointX, endPointY);
    
    UIColor *color = redOrBlue ? color(236, 86, 85, 1) : color(30, 170, 94, 1);
    [color set ];
    CGContextSetLineWidth(ctx, lazhuCXwidth);
    CGContextStrokePath(ctx);
}


//绘制MACD
-(void)setMACD{
    
    CGFloat lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324;
    CGFloat startpointy = VIEW_SIZE.height - padding - squareH1 / 2;
    
    int count  = (int) _macdArray.count;
    CGContextRef  ctx =  UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
//EMA12线
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _macdArray[0][0] floatValue] * squareH1 / 2);
    for (int i = 1; i < count; i++) {
        CGFloat ema12value = [_macdArray[i][0] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 / 2 * ema12value);
}
    [color(97, 177, 209, 1)  set];
    CGContextStrokePath(ctx);
//EMA26线
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _macdArray[0][1] floatValue] * squareH1/2);

    for (int i = 1; i < count; i++) {
        CGFloat ema26value = [_macdArray[i][1] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 /2 * ema26value);
}
    [color(220, 200, 106, 1)  set];
     CGContextStrokePath(ctx);
//阴阳线
    for (int i = 0; i < count; i++) {
        CGContextMoveToPoint(ctx, padding + (3 + 4 * i )* lazhuUnitDot, startpointy);
        CGFloat difnumber = [_macdArray[i][2] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i )* lazhuUnitDot, startpointy - squareH1 / 2 * difnumber);
        if (difnumber < 0) {
            [color(81, 182, 64, 1) set ];
        }
        else
        {
            [color(253, 73, 83, 1) set ];
        }
        CGContextStrokePath(ctx);
    }
}

//绘制KDJ
-(void)setKDJ {
    
    CGFloat lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324;
    CGFloat startpointy = VIEW_SIZE.height - padding;
    
    int count  = (int) _kdjArray.count;
    CGContextRef  ctx =  UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
//k
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _kdjArray[0][0] floatValue] * squareH1 );
    for (int i = 1; i < count; i++) {
        CGFloat kvalue = [_kdjArray[i][0] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * kvalue);
    }
    [color(213, 145, 225, 1)  set];
    CGContextStrokePath(ctx);
//d
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _kdjArray[0][1] floatValue] * squareH1 );
    for (int i = 1; i < count; i++) {
        CGFloat dvalue = [_kdjArray[i][1] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * dvalue);
    }
    [color(83, 170, 210, 1)  set];
    CGContextStrokePath(ctx);
//j
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _kdjArray[0][2] floatValue] * squareH1 );
    for (int i = 1; i < count; i++) {
        CGFloat jvalue = [_kdjArray[i][2] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * jvalue );
    }
    [color(218, 198, 214, 1)  set];
    CGContextStrokePath(ctx);

}


//绘制RSI
-(void)setRSI {
    
    CGFloat lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324;
    CGFloat startpointy = VIEW_SIZE.height - padding;
    
    int count  = (int) _rsiArray.count;
    CGContextRef  ctx =  UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
//rsi1
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _rsiArray[0][0] floatValue] * squareH1);
    for (int i = 1; i < count; i++) {
        CGFloat rsi1value = [_rsiArray[i][0] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * rsi1value );
    }
    [color(213, 145, 225, 1)  set];
    CGContextStrokePath(ctx);
//rsi2
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _rsiArray[0][1] floatValue] * squareH1 );
    for (int i = 1; i < count; i++) {
        CGFloat rsi2value = [_rsiArray[i][1] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * rsi2value );
    }
    [color(83, 170, 210, 1)  set];
    CGContextStrokePath(ctx);
//rsi3
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _rsiArray[0][2] floatValue] * squareH1);
    for (int i = 1; i < count; i++) {
        CGFloat rsi3value = [_rsiArray[i][2] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * rsi3value );
    }
    [color(218, 198, 214, 1)  set];
    CGContextStrokePath(ctx);
}


//绘制BIAS
-(void)setBIAS{
    
    CGFloat lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324;
    CGFloat startpointy = VIEW_SIZE.height - padding;
    
    int count  = (int) _biasArray.count;
    CGContextRef  ctx =  UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
//bias1
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _biasArray[0][0] floatValue] * squareH1 );
    for (int i = 1; i < count; i++) {
        CGFloat bias1value = [_biasArray[i][0] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * bias1value );
    }
    [color(213, 145, 225, 1)  set];
    CGContextStrokePath(ctx);
//bias2
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _biasArray[0][1] floatValue] * squareH1 );
    for (int i = 1; i < count; i++) {
        CGFloat bias2value = [_biasArray[i][1] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * bias2value );
    }
    [color(83, 170, 210, 1)  set];
    CGContextStrokePath(ctx);
//bias3
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _biasArray[0][2] floatValue] * squareH1 );
    for (int i = 1; i < count; i++) {
        CGFloat bias3value = [_biasArray[i][2] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * bias3value );
    }
    [color(218, 198, 214, 1)  set];
    CGContextStrokePath(ctx);
}


//绘制DMA
-(void)setDMA{

    [self drawTwoLine:_dmaArray];
}


//绘制OBV
-(void)setOBV{
    
    [self drawTwoLine:_obvArray];
}


//绘制ROC
-(void)setROC{

    [self drawTwoLine:_rocArray];
}


//绘制MTM
-(void)setMTM{
    
    [self drawTwoLine:_mtmArray];
}


//绘制CR
-(void)setCR{
    
    CGFloat lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324;
    CGFloat startpointy = VIEW_SIZE.height - padding;
    
    int count  = (int) _crArray.count;
    CGContextRef  ctx =  UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
//cr1
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _crArray[0][0] floatValue] * squareH1 );
    for (int i = 1; i < count; i++) {
        CGFloat cr1value = [_crArray[i][0] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * cr1value );
    }
    [color(213, 145, 225, 1)  set];
    CGContextStrokePath(ctx);
//cr2
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _crArray[0][1] floatValue] * squareH1);
    for (int i = 1; i < count; i++) {
        CGFloat cr2value = [_crArray[i][1] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * cr2value);
    }
    [color(83, 170, 210, 1)  set];
    CGContextStrokePath(ctx);
//cr3
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _crArray[0][2] floatValue] * squareH1 );
    for (int i = 1; i < count; i++) {
        CGFloat cr3value = [_crArray[i][2] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * cr3value);
    }
    [color(218, 198, 214, 1)  set];
    CGContextStrokePath(ctx);
}


//绘制DMI
-(void)setDMI{
    
    CGFloat lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324;
    CGFloat startpointy = VIEW_SIZE.height - padding;
    
    int count  = (int) _dmiArray.count;
    CGContextRef  ctx =  UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
//dmi1
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _dmiArray[0][0] floatValue] * squareH1);
    for (int i = 1; i < count; i++) {
        CGFloat dmi1value = [_dmiArray[i][0] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * dmi1value );
    }
    [color(213, 145, 225, 1)  set];
    CGContextStrokePath(ctx);
//dmi2
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _dmiArray[0][1] floatValue] * squareH1);
    for (int i = 1; i < count; i++) {
        CGFloat dmi2value = [_dmiArray[i][1] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * dmi2value );
    }
    [color(83, 170, 210, 1)  set];
    CGContextStrokePath(ctx);
//dmi3
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _dmiArray[0][2] floatValue] * squareH1);
    for (int i = 1; i < count; i++) {
        CGFloat dmi3value = [_dmiArray[i][2] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * dmi3value);
    }
    [color(218, 198, 214, 1)  set];
    CGContextStrokePath(ctx);
//dmi4
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ _dmiArray[0][3] floatValue] * squareH1);
    for (int i = 1; i < count; i++) {
        CGFloat dmi4value = [_dmiArray[i][3] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * dmi4value );
    }
    [color(245, 73, 108, 1)  set];
    CGContextStrokePath(ctx);
}


//绘制BRAR
-(void)setBRAR{
  
    [self drawTwoLine:_brarArray];
}



//绘制VR
-(void)setVR{
    
    [self drawTwoLine:_vrArray];
}




//绘制TRIX
-(void)setTRIX{
   
    [self drawTwoLine:_trixArray];
}


//绘制EMV
-(void)setEMV{
    
    [self drawTwoLine:_emvArray];
}



//绘制WR
-(void)setWR{
    
    [self drawTwoLine:_wrArray];
}


//绘制CCI
-(void)setCCI{
    
    
    
}


//绘制PSY
-(void)setPSY{
    
    [self drawTwoLine:_psyArray];
    
}



//绘制DPO
-(void)setDPO{
    
    [self drawTwoLine:_dpoArray];
    
}


//绘制BOLL
-(void)setBOLL{
    
    
    
}



//绘制ASI
-(void)setASI{
    
    [self drawTwoLine:_asiArray];
    
}



//绘制SAR
-(void)setSAR{
    
    
    
}




#pragma  mark -- 触摸代理

-(void)touchesMoved:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event {
   
    
    
    NSLog(@"Touch Moves");
    _shiZiLayer.hidden = NO;
    
    
    UITouch *touch = [touches anyObject];
    CGPoint current = [touch locationInView:self];
    
    
    if( _chartStyle ==  PHChartStyleFenShiTu ) {
        
     int  xvalue = (current.x - 5)/(VIEW_SIZE.width - 10) * 240;
       if ( xvalue < 0) {
            xvalue = 0;
        }
        else if (xvalue > _fenShiDaZhe.count - 1)
        {
            xvalue =  (int) _fenShiDaZhe.count - 1;
        }
        
        NSNumber *data = _fenShiDaZhe[xvalue] ;
        
        [_shiZiLayer setXvalue:current.x andYvalue:[data floatValue]];
        [_shiZiLayer setNeedsDisplay];
        
    }
    else
    {
        int xvalue = (current.x - 5)/(VIEW_SIZE.width - 10) * 80;
        if ( xvalue < 0) {
            xvalue = 0;
        }
        else if (xvalue > _laZhuTuTransArray.count - 1)
        {
            xvalue = (int)_laZhuTuTransArray.count - 1;
        }
        
        NSNumber *data = _laZhuTuTransArray[xvalue][3] ;
        
        [_shiZiLayer setXvalue:current.x andYvalue:[data floatValue]];
        [_shiZiLayer setNeedsDisplay];
    }
}




    




#pragma mark -- utilities

-(CGFloat) getAbsoluteFloatValue:(CGFloat)inputFloat {
    
    if(inputFloat < 0) {
        
        inputFloat = -inputFloat;
    }
    
    return inputFloat;
}


-(BOOL)isShiZixianShown  {


    if (!_isShiZiXianShown) {
        
        _isShiZiXianShown = NO;
    }
    
    return _isShiZiXianShown;
}


-(BOOL)isZoomMode {
    
    if (!_isZoomMode) {
        _isZoomMode = NO;
    }
    return  _isZoomMode;
}



// 可以生成2，3，4线的数组
-(NSArray *)getLineArray:(NSArray *)array {
    
    CGFloat _MAX_NUM = [array[0][0] floatValue];
    CGFloat _MIN_NUM = [array[0][0] floatValue];
    
    for (NSArray *arra in array) {
        CGFloat line1value = [arra[0] floatValue];
        CGFloat line2value = [arra[1] floatValue];
        
        if (_MAX_NUM < line1value ) _MAX_NUM = line1value;
        if (_MAX_NUM < line2value ) _MAX_NUM = line2value;
        
        if (_MIN_NUM > line1value ) _MIN_NUM = line1value;
        if (_MIN_NUM > line2value ) _MIN_NUM = line2value;
        if (arra.count == 3) {
            CGFloat line3value = [arra[2] floatValue];
            if (_MAX_NUM < line3value ) _MAX_NUM = line3value;
            if (_MIN_NUM > line3value ) _MIN_NUM = line3value;
            if (arra.count == 4) {
                CGFloat line4value = [arra[3] floatValue];
                if (_MAX_NUM < line4value ) _MAX_NUM = line4value;
                if (_MIN_NUM > line4value ) _MIN_NUM = line4value;
            }
        }
    }
    
    CGFloat delta = _MAX_NUM - _MIN_NUM;
    
    NSMutableArray *temptarra = [NSMutableArray array];
    for (NSArray *arra in array) {
        NSMutableArray *temptarray = [NSMutableArray array];
        CGFloat vr1newvalue = ([arra[0] floatValue] - _MIN_NUM) / delta;
        CGFloat vr2newvalue = ([arra[1] floatValue] - _MIN_NUM) / delta;
        [temptarray addObject: [NSNumber numberWithFloat:vr1newvalue]];
        [temptarray addObject: [NSNumber numberWithFloat:vr2newvalue]];
        if (arra.count == 3) {
            CGFloat vr3newvalue = ([arra[2] floatValue] - _MIN_NUM) / delta;
               [temptarray addObject: [NSNumber numberWithFloat:vr3newvalue]];
            if (arra.count == 4) {
               CGFloat vr4newvalue = ([arra[3] floatValue] - _MIN_NUM) / delta;
               [temptarray addObject: [NSNumber numberWithFloat:vr4newvalue]];
            }
        }
        [temptarra addObject:temptarray];
    }
    return temptarra;
}


//画两条线，单纯的两线
-(void)drawTwoLine:(NSArray *)array {
    
    CGFloat lazhuUnitDot = (VIEW_SIZE.width - 2 * padding) / 324;
    CGFloat startpointy = VIEW_SIZE.height - padding;
    
    int count  = (int) array.count;
    CGContextRef  ctx =  UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
//line1
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ array[0][0] floatValue] * squareH1);
    for (int i = 1; i < count; i++) {
        CGFloat line1value = [array[i][0] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * line1value );
    }
    [color(250, 202, 65, 1)  set];
    CGContextStrokePath(ctx);
//line2
    CGContextMoveToPoint(ctx, padding + 3 * lazhuUnitDot, startpointy - [ array[0][1] floatValue] * squareH1);
    for (int i = 1; i < count; i++) {
        CGFloat line2value = [array[i][1] floatValue];
        CGContextAddLineToPoint(ctx, padding + (3 + 4 * i) * lazhuUnitDot, startpointy - squareH1 * line2value );
    }
    [color(83, 170, 210, 1)  set];
    CGContextStrokePath(ctx);
}



@end




