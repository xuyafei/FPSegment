//
//  FPSegmentItemsContentView.h
//  FPSegment
//
//  Created by polycom on 2017/6/10.
//  Copyright © 2017年 com.polycom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  FPSegmentItemsContentViewDelegate <NSObject>
- (void)didSelectedButtonAtIndex:(NSInteger)index;
@end

@interface FPSegmentItemsContentView : UIView

@property(nonatomic, assign) id<FPSegmentItemsContentViewDelegate> delegate;
@property(nonatomic, assign) NSInteger page;

@property(nonatomic, strong) UIColor *normalColor;
@property(nonatomic, strong) UIColor *highlightColor;
@property(nonatomic, strong) UIFont *font;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles;

@end
