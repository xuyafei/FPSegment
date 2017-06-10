//
//  FPSegmentViewTitleItem.h
//  FPSegment
//
//  Created by polycom on 2017/6/10.
//  Copyright © 2017年 com.polycom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPSegmentViewTitleItem : UIView

@property(nonatomic, copy) NSString *title;

@property(nonatomic, strong) UIColor *normalColor;
@property(nonatomic, strong) UIColor *highlightColor;

@property(nonatomic, strong) UIFont *font;

@property(nonatomic, assign) CGFloat space;
@property(nonatomic, assign, getter=isHighlight) BOOL highlight;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
- (void)addTarget:(id)target action:(nonnull SEL)action;
+ (CGFloat)calcuWidth:(NSString *)title;

@end
