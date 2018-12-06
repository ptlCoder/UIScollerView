//
//  HeaderView.m
//  UIScollerView
//
//  Created by soliloquy on 2018/12/6.
//  Copyright © 2018 ptlCoder. All rights reserved.
//

#import "HeaderView.h"
#import "UIView+PTLExtension.h"
#import "PTLButton.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define sizeFont 16

@interface HeaderView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *clickBtn;
@property (nonatomic, strong) UILabel *diseaseLabel;


@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray<PTLButton *> *btnArray;
@property (nonatomic, strong) PTLButton *lastBtn;




@end

@implementation HeaderView


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.scrollView];
    [self addSubview:self.clickBtn];
    [self addSubview:self.diseaseLabel];
}



-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 10, kScreenWidth, 70);
    self.clickBtn.frame = CGRectMake(10, 100, 100, 50);
    self.diseaseLabel.frame = CGRectMake(200, 100, 100, 50);
    
    for (NSInteger i = 0; i < self.btnArray.count; i++) {
        PTLButton *btn = self.btnArray[i];
        CGFloat btnW = [self.dataArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:sizeFont]} context:nil].size.width;
        
        btn.width = btnW+10;
        btn.height = self.scrollView.height;
        btn.y = 0;
        btn.x = CGRectGetMaxX(self.lastBtn.frame)+10;
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame), self.scrollView.height);
        
        self.lastBtn = btn;
    }
    
}


- (void)clickBtnDid:(UIButton *)button {
    

    NSArray *arr = @[@"哈哈哈1", @"哈哈2", @"哈哈哈哈3", @"哈哈4", @"哈哈5", @"哈哈哈6", @"哈哈哈哈7"];
    
    NSInteger index = arc4random_uniform(arr.count);
    [self.dataArray addObject:arr[index]];
    
    [self addSubButton];

    [self setNeedsLayout];
}

#pragma mark - 切换
- (void)changeDiseaseClick:(UIButton *)button {
    
    NSInteger tag = button.tag;
    [self.dataArray removeObjectAtIndex:tag];
    [self.dataArray insertObject:self.diseaseLabel.text atIndex:tag];
    self.diseaseLabel.text = button.titleLabel.text;

    
    [self addSubButton];

    [self setNeedsLayout];
}

#pragma mark - 添加按钮
- (void)addSubButton {
    
    self.lastBtn = nil;
    [self.btnArray removeAllObjects];
    for (UIView *subView in self.scrollView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [subView removeFromSuperview];
        }
    }

    for (NSInteger i = 0; i < self.dataArray.count; i ++) {
        PTLButton *btn = [[PTLButton alloc]init];
        btn.titleLabel.font = [UIFont systemFontOfSize:sizeFont];
        [btn setTitle:self.dataArray[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_Locate"] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(changeDiseaseClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:btn];
        [self.btnArray addObject:btn];
    }
}

-(NSMutableArray<PTLButton *> *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UIButton *)clickBtn {
    if (!_clickBtn) {
        _clickBtn = [[UIButton alloc]init];
        _clickBtn.backgroundColor = [UIColor redColor];
        [_clickBtn setTitle:@"添加" forState:UIControlStateNormal];
        [_clickBtn addTarget:self action:@selector(clickBtnDid:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickBtn;
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor yellowColor];
    }
    return _scrollView;
}

-(UILabel *)diseaseLabel {
    if (!_diseaseLabel) {
        _diseaseLabel = [[UILabel alloc]init];
        _diseaseLabel.text = @"文本";
        _diseaseLabel.textAlignment = NSTextAlignmentCenter;
        _diseaseLabel.backgroundColor = [UIColor yellowColor];
        _diseaseLabel.textColor = [UIColor blackColor];
        _diseaseLabel.font = [UIFont systemFontOfSize:20];
    }
    return _diseaseLabel;
}


@end
