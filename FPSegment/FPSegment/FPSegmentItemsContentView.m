//
//  FPSegmentItemsContentView.m
//  FPSegment
//
//  Created by polycom on 2017/6/10.
//  Copyright © 2017年 com.polycom. All rights reserved.
//

#import "FPSegmentItemsContentView.h"
#import "FPSegmentViewTitleItem.h"

@interface FPSegmentItemsContentView() {
    CGFloat _buttonWidthSUM;
    FPSegmentViewTitleItem *_currentItem;
}

@property(nonatomic, strong) UIView *buttonContentView;
@property(nonatomic, strong) UIView *line;

@property(nonatomic, strong) NSMutableArray *buttonArray;
@property(nonatomic, strong) NSMutableArray *buttonWidths;
@property(nonatomic, strong) NSArray *items;

@end

@implementation FPSegmentItemsContentView

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles {
    if(self = [super initWithFrame:frame]) {
        self.items = [titles copy];
        [self setupAllButtons];
    }
    
    return self;
}

- (void)setupAllButtons {
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.buttonContentView = [[UIView alloc] initWithFrame:CGRectZero];
    self.buttonContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.buttonContentView];
    
    self.line = [[UIView alloc] initWithFrame:CGRectZero];
    self.line.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.line];
    
    for(NSString *title in self.items) {
        FPSegmentViewTitleItem *item = [[FPSegmentViewTitleItem alloc] initWithFrame:CGRectZero title:title];
        CGFloat width = [FPSegmentViewTitleItem calcuWidth:title];
        [self.buttonArray addObject:item];
        [item addTarget:self action:@selector(buttonAction:)];
        [self.buttonWidths addObject:[NSNumber numberWithDouble:width]];
        _buttonWidthSUM += width;
        [self.buttonContentView addSubview:item];
        
        if(_currentItem == nil) {
            _currentItem = item;
            item.highlight = YES;
        }
    }
}

- (void)layoutSubviews {
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    
    self.buttonContentView.frame = CGRectMake(0, 0, width, height - 2);
    CGFloat spacing = 0;
    if(_buttonWidthSUM >= width) {
        spacing = 0;
    } else {
        spacing = (width - _buttonWidthSUM) / (_buttonWidths.count + 1);
    }
    
    for(int x = 0; x < self.buttonArray.count; x++) {
        FPSegmentViewTitleItem *item = self.buttonArray[x];
        CGFloat buttonWidth = [self.buttonWidths[x] doubleValue];
        
        if(x == 0) {
            item.frame = CGRectMake(spacing, 0, buttonWidth, _buttonContentView.bounds.size.height);
        } else {
            FPSegmentViewTitleItem *lastItem = self.buttonArray[x - 1];
            item.frame = CGRectMake(spacing + lastItem.frame.origin.x + lastItem.frame.size.width, 0, buttonWidth, _buttonContentView.bounds.size.height);
        }
    }
    self.line.frame = CGRectMake(_currentItem.frame.origin.x, self.buttonContentView.bounds.size.height, _currentItem.bounds.size.width, 2);
}

- (void)buttonAction:(FPSegmentViewTitleItem *)sender {
    NSInteger index = [self.buttonArray indexOfObject:sender];
    [self setPage:index];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectedButtonAtIndex:)]) {
        [self.delegate didSelectedButtonAtIndex:index];
    }
}

- (void)setPage:(NSInteger)page {
    if(_page == page) {
        return;
    }
    
    _page = page;
    [self moveToPage:page];
}

- (void)moveToPage:(NSInteger)page {
    if(page > self.buttonArray.count) {
        return;
    }
    
    FPSegmentViewTitleItem *item = self.buttonArray[page];
    _currentItem.highlight = NO;
    _currentItem = item;
    item.highlight = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect buttonFrame = item.frame;
        CGRect lineFrame = self.line.frame;
    }];
}

@end
