//
//  ViewController.m
//  XXXRunLabDemo
//
//  Created by Z on 2020/3/12.
//  Copyright © 2020 Z. All rights reserved.
//  https://github.com/xxxIxxxx/XXXRunLab

#import "ViewController.h"
#import "XXXRunLab.h"
@interface ViewController ()
@property (nonatomic, strong) XXXRunLab *runLab;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
        
    XXXRunLab *runLab = XXXRunLab.new;
    [self.view addSubview:runLab];
    runLab.left = 80;
    runLab.width = UIScreen.mainScreen.bounds.size.width-80*2;
    runLab.top = 200;
    runLab.text = @"0123456789";
    runLab.textFont = [UIFont systemFontOfSize:40];
    runLab.height = runLab.runLabHeight;
    runLab.textColor = UIColor.blackColor;
    runLab.speed = 200;
    runLab.itemSpace = 30;
    self.runLab = runLab;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"touch will run" forState:UIControlStateNormal];
    [btn setTitle:@"touch will stop" forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = UIColor.blueColor;
    btn.left = 0;
    btn.top = runLab.bottom;
    btn.width = UIScreen.mainScreen.bounds.size.width;
    btn.height = 50;
    
    
}

- (void)btnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self.runLab runFun];
    }else{
        [self.runLab stop];
    }
}




@end

