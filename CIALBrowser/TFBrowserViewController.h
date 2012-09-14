//
//  TFBrowserViewController.h
//  
//
//  Created by 伊藤ソフトデザイン on 2012/08/22.
//
//

#import "CIALBrowserViewController.h"

@interface TFBrowserViewController : CIALBrowserViewController {
    NSInteger setAsHomeButtonIndex;
    NSInteger uiLockButtonIndex;
}

- (void)setAsHomeButtonAction:(id)sender;
- (void)uiLockAction:(id)sender;

@end
