# XXXRunLab 跑马灯 滚动文字

##### ⚠️仅支持单行文字从右往左滚动⚠️


- 支持富文本



```

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
    [runLab runFun];

```

如有其他需求可以自己改一下～

