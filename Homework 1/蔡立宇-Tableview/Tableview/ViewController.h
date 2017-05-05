//
//  ViewController.h
//  Tableview
//
//  Created by john on 5/2/17.
//  Copyright © 2017 john. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextViewController.h"
@interface ViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource,MyTextViewProtocol>
- (void)textViewWillDisappearWithText:(NSString *)text AtIndexPath:(NSIndexPath *)indexPath;

@end

