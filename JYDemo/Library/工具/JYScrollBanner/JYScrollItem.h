//
//  JYScrollItem.h
//  JYDemo
//
//  Created by 李佳育 on 16/8/31.
//  Copyright © 2016年 李佳育. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JYScrollItemModel;
@interface JYScrollItem : UIView


@property (nonatomic, strong) JYScrollItemModel * data;
@property (nonatomic, weak) UIImageView * imageView;
@end
