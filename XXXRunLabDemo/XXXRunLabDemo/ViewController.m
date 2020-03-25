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
    runLab.top = 100;
    runLab.text = @"默认滚动";
    runLab.textFont = [UIFont systemFontOfSize:50];
    runLab.height = runLab.runLabHeight;
    runLab.textColor = UIColor.blackColor;
    runLab.speed = 200;
    runLab.backgroundColor = UIColor.redColor;
    runLab.itemSpace = 30;
    [runLab runFun];
    
    
    
    
    XXXRunLab *runLab1 = XXXRunLab.new;
    [self.view addSubview:runLab1];
    runLab1.left = 10;
    runLab1.width = UIScreen.mainScreen.bounds.size.width-10*2;
    runLab1.top = 155;
    runLab1.text = @"文本长度小于XXXRunLab宽度 居左展示不滚动";
    runLab1.textFont = [UIFont systemFontOfSize:14];
    runLab1.height = 50;
    runLab1.backgroundColor = UIColor.redColor;
    runLab1.showType = XXXRunLabShowLeftType;
    [runLab1 runFun];
    
    
    
    XXXRunLab *runLab2 = XXXRunLab.new;
    [self.view addSubview:runLab2];
    runLab2.left = 10;
    runLab2.width = UIScreen.mainScreen.bounds.size.width-10*2;
    runLab2.top = 300;
    runLab2.text = @"文本长度小于XXXRunLab宽度 居中展示不滚动";
    runLab2.textFont = [UIFont systemFontOfSize:14];
    runLab2.height = 50;
    runLab2.backgroundColor = UIColor.redColor;
    runLab2.showType = XXXRunLabShowCenterType;
    [runLab2 runFun];
    
    
    
   
    
    
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

