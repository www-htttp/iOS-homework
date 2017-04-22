//
//  ViewController.m
//  Calculate
//
//  Created by miracle on 2017/4/17.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "ViewController.h"

#import "JZCCalculateTool.h"
#import "JZCHistoryRecordTableViewController.h"

//button tag
#define kEqual 120
#define kAC 118
#define kBack 119

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic, copy) NSString *temStr;//计算式
@property (nonatomic, strong) JZCCalculateTool *calculateTool;
@property (nonatomic, copy) NSString *lastResult;//上一次计算的结果
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *historyBtn = [[UIBarButtonItem alloc] initWithTitle:@"历史记录" style:UIBarButtonItemStylePlain target:self action:@selector(moveToHistroyRecord)];
    self.navigationItem.rightBarButtonItem = historyBtn;
    
    self.lastResult = @"";
}

- (void)moveToHistroyRecord {
    JZCHistoryRecordTableViewController *recordVC = [[JZCHistoryRecordTableViewController alloc] init];
    recordVC.dataArr = self.calculateTool.records;
    [self.navigationController pushViewController:recordVC animated:YES];
}

- (IBAction)tap:(id)sender {
    NSInteger tag = ((UIButton *)sender).tag;
    NSString *title = ((UIButton *)sender).titleLabel.text;
    
    if (tag == kEqual) {
        JZCCalculateTool *tool = [[JZCCalculateTool alloc] init];
        self.calculateTool = tool;
        NSString *result = @"";
        if (self.temStr) {
            result = [self.calculateTool calculateWithString:self.temStr andLastResult:self.lastResult];
        }
        
        if (self.calculateTool.isCorrected) {
            self.lastResult = result;
        } else {
            self.lastResult = @"";
        }
        self.resultLabel.text = result;
        self.temStr = nil;
    } else if (tag == kAC) {
        self.resultLabel.text = @"";
        self.temStr = nil;
        self.lastResult = @"";
    } else if (tag == kBack) {
        if (self.temStr.length > 1) {
            self.temStr = [self.temStr substringToIndex:self.temStr.length - 1];
            self.resultLabel.text = self.temStr;
        } else {
            self.resultLabel.text = @"";
            self.temStr = nil;
        }
    } else {
        if (!self.temStr) {
            self.temStr = [[NSString alloc] initWithString:title];
        } else {
            self.temStr = [self.temStr stringByAppendingString:title];
        }
        self.resultLabel.text = self.temStr;
    }
}


@end
