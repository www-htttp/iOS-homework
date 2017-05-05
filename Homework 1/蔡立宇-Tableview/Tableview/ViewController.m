//
//  ViewController.m
//  Tableview
//
//  Created by john on 5/2/17.
//  Copyright © 2017 john. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "TextViewController.h"
@interface ViewController ()
@property NSMutableArray *userNotes;
@end

@implementation ViewController

#pragma mark - View Life Cycle

- (void)loadView{
    self.view = [UITableView new];//do i need to set self as the table view's delegate or datasource manually here?
    //set navigation bar title,edit button,add button and back button.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = @"My Notes";
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Notes" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //build modal
    self.userNotes = [NSMutableArray new];
    self.userNotes[0] = @"my first row";
    
}

#pragma mark - Add row

- (void)addItem{
    TextViewController *textViewController = [TextViewController new];
    ((UITextView*)textViewController.view).delegate = self;
    [self.navigationController pushViewController:textViewController animated:YES];
}

#pragma mark - UITableViewDateSource

/*
 There is no need to implement numberOfSectionsInTableView: because there's only one section and the method defaults to returning 1.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userNotes.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.editing = YES;
    }
    
        cell.textLabel.text = self.userNotes[indexPath.row];

    return cell;
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - Manageing Selections

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //creat a view controller containg a text view
    TextViewController *textViewController = [TextViewController new];
    ((UITextView*)textViewController.view).text = self.userNotes[indexPath.row];
    //pass the indexpath to textviewcontroller and set self as its delegate for later communication
    textViewController.indexPath = indexPath;
    ((UITextView*)textViewController.view).delegate = self;
    [self.navigationController pushViewController:textViewController animated:NO];
}

#pragma mark - inserting and deleting 

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [(UITableView*)self.view setEditing:editing animated:animated];
    if (editing) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }else {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //if row is deleted,remove it from the datasource
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.userNotes removeObjectAtIndex:indexPath.row];
        [(UITableView*)self.view deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - MyTextViewDelegate

- (void)textViewWillDisappearWithText:(NSString *)text AtIndexPath:(NSIndexPath *)indexPath{
    //update data
    if ([self isNotEmpty:text]) {
        if (indexPath != nil) {
            self.userNotes[indexPath.row] = text;
        }
        //add a new note at the first row
        else [self.userNotes insertObject:text atIndex:0];
        
        [self.tableView reloadData];
    }
}

//to determine whether the user has only inputed whitespaces or newlines
- (BOOL)isNotEmpty:(NSString*)string{
    NSCharacterSet* set = [[NSCharacterSet whitespaceAndNewlineCharacterSet]invertedSet];
    NSRange range = [string rangeOfCharacterFromSet:set];
    return (range.location != NSNotFound);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
