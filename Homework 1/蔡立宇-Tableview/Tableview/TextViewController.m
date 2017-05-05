//
//  TextViewController.m
//  Tableview
//
//  Created by john on 5/3/17.
//  Copyright © 2017 john. All rights reserved.
//

#import "TextViewController.h"
#import "ViewController.h"
@implementation TextViewController
- (void)loadView{
    self.view = [UITextView new] ;
}
- (void)viewDidLoad{
    //set navigation item
    //self.navigationItem.rightBarButtonItem =
    
}
- (void)viewWillDisappear:(BOOL)animated{
    UITextView *textView =(UITextView*)self.view;
    [(ViewController*)textView.delegate textViewWillDisappearWithText:textView.text AtIndexPath:self.indexPath];
}
@end