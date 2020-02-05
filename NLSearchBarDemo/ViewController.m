//
//  ViewController.m
//  NLSearchBarDemo
//
//  Created by kkmm on 2020/2/5.
//  Copyright © 2020 kkmm. All rights reserved.
//

#import "ViewController.h"
#import "NLSearchBar.h"
@interface ViewController ()<NLSearchBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
   NLSearchBar *searchBar = [[NLSearchBar alloc]initWithFrame:CGRectMake(0, 88, [UIScreen mainScreen].bounds.size.width, 44)];
//	searchBar.backgroundColor = [UIColor yellowColor];
    searchBar.delegate = (id)self;
    searchBar.autoShowsCancelButton = YES;
//	searchBar.viewInterval = 10.;
//    searchBar.edgeInterval = 0.;
	[self.view addSubview:searchBar];
	// Do any additional setup after loading the view.
}

- (void)NLSearchBarSearchButtonClicked:(NLSearchBar * _Nonnull)searchBar{
	NSLog(@"对应UISearchBarSearchButtonClicked");
}

- (void)NLSearchBarCancelButtonClicked:(NLSearchBar * _Nonnull)searchBar{
	NSLog(@"对应UISearchBarCancelButtonClicked");
}

- (BOOL)NLSearchBarShouldBeginEditing:(NLSearchBar * _Nonnull)searchBar{
	NSLog(@"对应UISearchBarShouldBeginEditing");
	return YES;
}

- (void)NLSearchBarTextDidBeginEditing:(NLSearchBar * _Nonnull)searchBar{
	NSLog(@"对应UISearchBarTextDidBeginEditing");
}

- (BOOL)NLSearchBarShouldEndEditing:(NLSearchBar * _Nonnull)searchBar{
	NSLog(@"对应UISearchBarShouldEndEditing");
	return YES;
}

- (void)NLSearchBarTextDidEndEditing:(NLSearchBar * _Nonnull)searchBar{
	NSLog(@"对应UISearchBarTextDidEndEditing");
}

- (void)NLSearchBarTextDidChange:(NLSearchBar * _Nonnull)searchBar text:(NSString * _Nonnull)searchText{
	NSLog(@"对应UISearchBarTextDidChange");

}
@end
