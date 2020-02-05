//
//  NLSearchBar.h
//  nineteenlou
//
//  Created by kkmm on 2020/1/8.
//  Copyright © 2020 qiu . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class NLSearchBar;
@protocol NLSearchBarDelegate <NSObject>

@optional
- (void)NLSearchBarSearchButtonClicked:(NLSearchBar * _Nonnull)searchBar;
- (void)NLSearchBarCancelButtonClicked:(NLSearchBar * _Nonnull)searchBar;
- (BOOL)NLSearchBarShouldBeginEditing:(NLSearchBar * _Nonnull)searchBar;
- (void)NLSearchBarTextDidBeginEditing:(NLSearchBar * _Nonnull)searchBar;
- (BOOL)NLSearchBarShouldEndEditing:(NLSearchBar * _Nonnull)searchBar;
- (void)NLSearchBarTextDidEndEditing:(NLSearchBar * _Nonnull)searchBar;
- (void)NLSearchBarTextDidChange:(NLSearchBar * _Nonnull)searchBar text:(NSString * _Nonnull)searchText;
    
@end

/// 除 autoShowsCancelButton:自动显示隐藏取消按钮 和开放子控件之外，其他当前存在的属性/方法均与UISearchBar同名属性/方法保持一致
@interface NLSearchBar : UIView <UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIView *textFieldBackground;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *cancelButton;
@property(nullable, nonatomic,weak) id<NLSearchBarDelegate> delegate;
@property(nullable,nonatomic,copy)   NSString *text;                  // current/starting search text
@property(nullable,nonatomic,copy)   NSString *placeholder;
///水平方向视图于边界间距，默认10（UISearch为8）
@property (nonatomic, assign) CGFloat edgeInterval;
//搜索框背景与删除按钮的间距
@property (nonatomic, assign) CGFloat viewInterval;

///自动显示/隐藏取消按钮  default is NO
@property(nonatomic)BOOL autoShowsCancelButton;

@property(nonatomic)BOOL showsCancelButton;          // default is NO
- (void)setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
