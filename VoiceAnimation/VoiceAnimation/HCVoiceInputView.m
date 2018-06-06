//
//  HCVoiceInputView.m
//  VoiceAnimation
//
//  Created by Zhang Hailing on 2018/6/6.
//  Copyright © 2018年 HeeronChang. All rights reserved.
//

#import "HCVoiceInputView.h"

@interface HCVoiceInputView()

@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *fillColor;

// MARK: view
@property (nonatomic, strong) UIView *microphoneView; // 麦克风view
@property (nonatomic, strong) UIView *arcView; // 麦克风下的弧度
@property (nonatomic, strong) UIView *verticalLine; // 垂直竖线
@property (nonatomic, strong) UIView *horizontalLine; // 水平横线

@end

@implementation HCVoiceInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor filleColor:(UIColor *)fillColor {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.lineWidth = lineWidth;
        self.lineColor = lineColor;
        self.fillColor = fillColor;
        
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    // 底座（水平线）
    // 左边三分一开始，视图的1/3宽；距离底部
    self.horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/3, self.frame.size.height-10, self.frame.size.width/3, self.lineWidth)];
    self.horizontalLine.backgroundColor = self.lineColor;
    [self addSubview:self.horizontalLine];
    
    // 底座（竖线）
    self.verticalLine = [[UIView alloc] initWithFrame:CGRectMake(self.horizontalLine.center.x-self.lineWidth/2, self.horizontalLine.frame.origin.y-self.horizontalLine.frame.size.width/2, self.lineWidth, self.horizontalLine.frame.size.width/2)];
    self.verticalLine.backgroundColor = self.lineColor;
    [self addSubview:self.verticalLine];
    
    // 底座（圆弧）
    self.arcView = [[UIView alloc] initWithFrame:CGRectMake(self.horizontalLine.frame.origin.x, self.verticalLine.frame.origin.y-self.horizontalLine.frame.size.width/2, self.horizontalLine.frame.size.width, self.horizontalLine.frame.size.width/2)];
    [self.arcView.layer addSublayer:[self arcLineWithFrame:self.arcView.frame]];
    [self addSubview:self.arcView];
    
    // 麦克风
    self.microphoneView = [[UIView alloc] initWithFrame:CGRectMake(self.horizontalLine.frame.origin.x+ self.horizontalLine.frame.size.width/2-(self.horizontalLine.frame.size.width/3/2), self.verticalLine.frame.origin.y-self.arcView.frame.size.height*2-10, self.horizontalLine.frame.size.width/3, self.arcView.frame.size.height*2)];
    [self.microphoneView.layer addSublayer:[self microphoneLayerWithFrame:self.microphoneView.frame color:self.fillColor isFilled:YES]];
    [self addSubview:self.microphoneView];
//    self.microphoneView.backgroundColor = [UIColor redColor];
}

- (CAShapeLayer *)microphoneLayerWithFrame:(CGRect)frame color:(UIColor *)color isFilled:(BOOL)isFilled {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    if (isFilled) {
        layer.strokeColor = nil;
        layer.fillColor = color.CGColor;
    } else {
        layer.strokeColor = color.CGColor;
        layer.fillColor = nil;
    }
    
    layer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    layer.lineWidth = 2;
//    layer.lineCap = kCALineCapRound;
    
    layer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, frame.size.width, frame.size.height) cornerRadius:frame.size.width*0.4].CGPath;
    
    return layer;
}

- (CAShapeLayer *)arcLineWithFrame:(CGRect)frame {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.strokeColor = self.lineColor.CGColor;
    layer.fillColor = nil;
    layer.lineWidth = self.lineWidth;
    layer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2, 0) radius:frame.size.width/2 startAngle:M_PI endAngle:0 clockwise:NO].CGPath;
    
    return layer;
}

@end
