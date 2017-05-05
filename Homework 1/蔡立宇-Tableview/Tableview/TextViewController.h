//
//  TextViewController.h
//  Tableview
//
//  Created by john on 5/3/17.
//  Copyright © 2017 john. All rights reserved.
//

#ifndef TextViewController_h
#define TextViewController_h


#endif /* TextViewController_h */
#import <UIKit/UIKit.h>
@interface TextViewController: UIViewController
@property(nonatomic) NSIndexPath* indexPath;
@end
@protocol MyTextViewProtocol <UITextViewDelegate>
- (void)textViewWillDisappearWithText:(NSString*)text AtIndexPath:(NSIndexPath*)indexPath;
@end