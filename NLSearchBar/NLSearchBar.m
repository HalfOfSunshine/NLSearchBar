//
//  NLSearchBar.m
//  nineteenlou
//
//  Created by kkmm on 2020/1/8.
//  Copyright © 2020 qiu . All rights reserved.
//

#import "NLSearchBar.h"

#define UIColorFromRGBA(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface NLSearchBar(){
    NSDictionary *cancelBtnLayout;
    NSArray *bgConstraints1;
    NSLayoutConstraint *cancelBtnLeft;
    NSLayoutConstraint *cancelBtnWidth;
    NSLayoutConstraint *cancelBtnRight;
    NSLayoutConstraint *textFieldBGConstraintX;
}

@end
@implementation NLSearchBar
@synthesize showsCancelButton = _showsCancelButton;
@synthesize placeholder = _placeholder;
@synthesize text = _text;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoShowsCancelButton = NO;
        _viewInterval = 10;
        _edgeInterval = 10;
        self.textFieldBackground.backgroundColor = UIColorFromRGBA(0x8E8E93, 0.08);
        self.textFieldBackground.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.textFieldBackground];
        
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.cancelButton];
        textFieldBGConstraintX = [NSLayoutConstraint constraintWithItem:_textFieldBackground attribute:NSLayoutAttributeLeft relatedBy:0 toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:_edgeInterval];
        [self addConstraint:textFieldBGConstraintX];

        cancelBtnLeft = [NSLayoutConstraint constraintWithItem:_textFieldBackground attribute:NSLayoutAttributeRight relatedBy:0 toItem:_cancelButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-_edgeInterval];
        [self addConstraint:cancelBtnLeft];
        
        cancelBtnWidth = [NSLayoutConstraint constraintWithItem:_cancelButton attribute:NSLayoutAttributeWidth relatedBy:0 toItem:nil attribute:0 multiplier:1.0 constant:0];
        [self addConstraint:cancelBtnWidth];

        cancelBtnRight = [NSLayoutConstraint constraintWithItem:_cancelButton attribute:NSLayoutAttributeRight relatedBy:0 toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        [self addConstraint:cancelBtnRight];
        
        NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_textFieldBackground(==36)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textFieldBackground)];
        [self addConstraints:constraints1];
        
        NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_cancelButton(==36)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cancelButton)];
        [self addConstraints:constraints2];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_textFieldBackground attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_cancelButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];

        self.icon.translatesAutoresizingMaskIntoConstraints = NO;
        [self.textFieldBackground addSubview:self.icon];
        
        self.textField.translatesAutoresizingMaskIntoConstraints = NO;
        [self.textFieldBackground addSubview:self.textField];
        
        NSArray *bgConstraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_icon(==16)]-10-[_textField]-10-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_icon,_textField)];
        [self.textFieldBackground addConstraints:bgConstraints1];
        
        NSArray *bgConstraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_icon(==16)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_icon)];
        [self.textFieldBackground addConstraints:bgConstraints2];

        NSArray *bgConstraints3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_textField(==30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textField)];
        [self.textFieldBackground addConstraints:bgConstraints3];
        
        [self.textFieldBackground addConstraint:[NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.textFieldBackground attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [self.textFieldBackground addConstraint:[NSLayoutConstraint constraintWithItem:_icon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.textFieldBackground attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    }
    return self;
}

#pragma mark =============== UITextFieldDelegate ===============
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (self.autoShowsCancelButton) [self setShowsCancelButton:YES animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(NLSearchBarShouldBeginEditing:)]) {
        [self.delegate NLSearchBarShouldBeginEditing:self];
    }
    
    return YES;
}
    
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(NLSearchBarTextDidBeginEditing:)]) {
        [self.delegate NLSearchBarTextDidBeginEditing:self];
    }
}
    
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (self.delegate && [self.delegate respondsToSelector:@selector(NLSearchBarTextDidChange:text:)]){
        [self.delegate NLSearchBarTextDidChange:self text:newString];
    }
    
    return YES;
}
    
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField.text.length <= 0) {
        if (self.autoShowsCancelButton) [self setShowsCancelButton:NO animated:YES];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(NLSearchBarShouldEndEditing:)]) {
        [self.delegate NLSearchBarShouldEndEditing:self];
    }
    return YES;
}
    
    
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(NLSearchBarSearchButtonClicked:)]) {
        [self.delegate NLSearchBarSearchButtonClicked:self];
    }else{
        [self.textField resignFirstResponder];
    }
    return YES;
}
    
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(NLSearchBarTextDidEndEditing:)]) {
        [self.delegate NLSearchBarTextDidEndEditing:self];
    }
}

#pragma mark =============== Action ===============
- (void)cancelAction:(id) sender{
    self.textField.text = @"";
    if (!self.textField.isFirstResponder) {
       if (self.autoShowsCancelButton) [self setShowsCancelButton:NO animated:YES];
    }
    [self.textField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(NLSearchBarCancelButtonClicked:)]) {
        [self.delegate NLSearchBarCancelButtonClicked:self];
    }
}

#pragma mark =============== 属性设置 ===============
- (NSString *)placeholder{
    return self.textField.placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder{
	if (self.textField.placeholder != placeholder) {
		self.textField.placeholder = placeholder;
	}
}

- (NSString *)text{
    return self.textField.text;
}

- (void)setText:(NSString *)text{
	if (self.textField.text != text) {
		self.textField.text = text;
	}
}


- (void)setShowsCancelButton:(BOOL)showsCancelButton{
    [self setShowsCancelButton:showsCancelButton animated:NO];
}

- (BOOL)showsCancelButton{
    return _showsCancelButton;
}

- (void)setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated{
    _showsCancelButton = showsCancelButton;
    textFieldBGConstraintX.constant = _edgeInterval;
    if (_showsCancelButton) {
        cancelBtnWidth.constant = 35;
        cancelBtnRight.constant = -_edgeInterval;//-10
        cancelBtnLeft.constant = -_viewInterval;
    }else{
        cancelBtnLeft.constant = -_edgeInterval;
        cancelBtnWidth.constant = 0;
        cancelBtnRight.constant = 0;
    }
    
    if (animated) {
         [UIView animateWithDuration:0.15 animations:^{
             [self layoutIfNeeded];
         }];
    }else{
         [self layoutIfNeeded];
    }
}

#pragma mark =============== lazyLoad ===============
- (void)setViewInterval:(CGFloat)viewInterval{
    if (_viewInterval != viewInterval) {
        _viewInterval = viewInterval;
        [self setShowsCancelButton:_showsCancelButton];
    }
}
- (void)setEdgeInterval:(CGFloat)edgeInterval{
    if (_edgeInterval != edgeInterval) {
        _edgeInterval = edgeInterval;
    }
    [self setShowsCancelButton:_showsCancelButton];
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.image = [UIImage imageNamed:@"NLSearchBarIcon"];
    }
    return _icon;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField new];
        _textField.placeholder = @"搜索";
        _textField.delegate = (id)self;
        _textField.font = [UIFont systemFontOfSize:14.];
        _textField.textColor = UIColorFromRGB(0x303133);
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        [_textField setReturnKeyType:UIReturnKeySearch];
        _textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton new];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:UIColorFromRGB(0x303133) forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15.];
        [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (UIView *)textFieldBackground{
    if (!_textFieldBackground) {
        _textFieldBackground = [UIView new];
        _textFieldBackground.layer.cornerRadius = 18.;
    }
    return _textFieldBackground;
}

- (BOOL)becomeFirstResponder{
    return [self.textField becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    return [self.textField resignFirstResponder];
}
@end
