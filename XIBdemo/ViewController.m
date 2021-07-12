//
//  ViewController.m
//  XIBdemo
//
//  Created by 峯峯 on 2021/6/29.
//

#import "ViewController.h"
#import "RollingView.h"
@interface ViewController ()
@property (nonatomic,strong) NSMutableArray *list;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"HH:mm:ss";
    NSString *time = [format stringFromDate:[NSDate date]];
    CGFloat width,height;
    width = height = 44;
    self.list = [@[] mutableCopy];
    for (int i = 0; i<time.length; i++) {
        RollingView *sub = [[[NSBundle mainBundle] loadNibNamed:@"RollingView" owner:nil options:nil] firstObject];
        CGRect frame = CGRectMake(i*width, 100, width, height);
        sub.frame = frame;
        [self.view addSubview:sub];
        [self.list addObject:sub];
        sub.text = [time substringWithRange:NSMakeRange(i, 1)];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSString  *t = [format stringFromDate:[NSDate date]];
        [self setRollingTime:t];
    }];
    return;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 44, 44);
    btn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickToChangeText:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setRollingTime:(NSString *)t
{
    for (RollingView *v in self.list) {
        v.text = [t substringWithRange:NSMakeRange([self.list indexOfObject:v], 1)];
    }
}

-(void)clickToChangeText:(UIButton *)sender
{
   RollingView *sub = [self.list lastObject];
    sender.selected = !sender.selected;
    sub.text = sender.selected?@"1":@"0";
}

@end
