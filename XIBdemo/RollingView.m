//
//  RollingView.m
//  XIBdemo
//
//  Created by 峯峯 on 2021/7/13.
//

#import "RollingView.h"
@interface RollingView()

@property (weak, nonatomic) IBOutlet UILabel *lblUp;
@property (weak, nonatomic) IBOutlet UILabel *lblDown;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constaintRollingViewBottom;

@property (weak, nonatomic) IBOutlet UIStackView *vRollingStack;

@end

@implementation RollingView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.lblUp.font = [UIFont boldSystemFontOfSize:32];
    self.lblDown.font = [UIFont boldSystemFontOfSize:32];
    self.lblUp.textColor = [UIColor whiteColor];
    self.lblDown.textColor = [UIColor whiteColor];
    self.clipsToBounds = YES;

}

-(void)setText:(NSString *)text
{
    _text = text;
    self.lblUp.text = text;
    [self syncToDownLable];
}

-(void)syncToDownLable
{
    if ([self.text isEqualToString:self.lblDown.text] == NO) {
        [UIView animateWithDuration:.25 animations:^{
            self.constaintRollingViewBottom.constant = -self.frame.size.height;
            [self setNeedsLayout];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (finished) {
                self.lblDown.text = self.text;
                self.constaintRollingViewBottom.constant = 0;
                [self setNeedsLayout];
                [self layoutIfNeeded];
            }
        }];
        
    }
}
@end
