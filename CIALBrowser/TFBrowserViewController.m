//
//  TFBrowserViewController.m
//  
//
//  Created by 伊藤ソフトデザイン on 2012/08/22.
//
//

#import "TFBrowserViewController.h"
#import "CIALBrowser.h"

@interface TFBrowserViewController ()

@end

@implementation TFBrowserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layoutSubviewsIfNeeds];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(adjustSizeAfterApper) withObject:nil afterDelay:0.1];
}

- (void)adjustSizeAfterApper
{
    UIApplication *app = [UIApplication sharedApplication];
    [self didRotateFromInterfaceOrientation:app.statusBarOrientation];
}

- (BOOL)isOS7
{
    return  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
}

- (void)layoutSubviewsIfNeeds
{
    if (!self.isOS7) return;

    CGRect frame;
    
    frame = webView.frame;
    if (frame.origin.y != 20) {
        frame.origin.y = 20;
        frame.size.height -= 20;
        webView.frame = frame;

        frame = navigationBar.frame;
        frame.origin.y += 20;
        navigationBar.frame = frame;
    }
}

// Create the actionSheet or make it disappear if needed
- (void)prepareActionSheet
{
    if (!self.actionActionSheet) {
        self.actionActionSheet = [[UIActionSheet alloc] initWithTitle:[_urlToHandle.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                                                         delegate:self
                                                cancelButtonTitle:nil
                                           destructiveButtonTitle:nil
                                                otherButtonTitles:nil];
        self.actionActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        
        copyButtonIndex = -1;
        openLinkButtonIndex = -1;
        
        setAsHomeButtonIndex = [self.actionActionSheet addButtonWithTitle:CIALBrowserLocalizedString(@"Set as Home",nil)];
        
        addBookmarkButtonIndex = [self.actionActionSheet addButtonWithTitle:CIALBrowserLocalizedString(@"Add bookmark",nil)];
        
        if (self.enabledSafari) {
            openWithSafariButtonIndex = [self.actionActionSheet addButtonWithTitle:CIALBrowserLocalizedString(@"Open with Safari",@"")];
        } else {
            openWithSafariButtonIndex = -1;
        }
        
        if ([MFMailComposeViewController canSendMail]) {
            sendUrlButtonIndex = [self.actionActionSheet addButtonWithTitle:CIALBrowserLocalizedString(@"Mail Link to this Page",@"")];
        }
        
        Class printInteractionController = NSClassFromString(@"UIPrintInteractionController");
        if ((printInteractionController != nil) && [printInteractionController isPrintingAvailable]) {
            printButtonIndex = [self.actionActionSheet addButtonWithTitle:CIALBrowserLocalizedString(@"Print",@"")];
        } else {
            printButtonIndex = -1;
        }
        
        uiLockButtonIndex = [self.actionActionSheet addButtonWithTitle:CIALBrowserLocalizedString(@"UI Lock")];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.actionActionSheet.cancelButtonIndex = -1;
        } else {
            self.actionActionSheet.cancelButtonIndex = [_actionActionSheet addButtonWithTitle:CIALBrowserLocalizedString(@"Cancel",@"")];
        }
    }
}

- (void)setAsHomeButtonAction:(id)sender
{
}

- (void)uiLockAction:(id)sender
{
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (self.isOS7 == NO) {
        [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    } else {
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
            if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
                webView.frame = CGRectMake(0, navigationBar.frame.size.height + 20, self.view.frame.size.width, self.view.frame.size.height - navigationBar.frame.size.height - toolBar.frame.size.height - 20);
            } else {
                webView.frame = CGRectMake(0, navigationBar.frame.size.height + 20, self.view.frame.size.height, self.view.frame.size.width - navigationBar.frame.size.height - toolBar.frame.size.height - 20);
            }
        }
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (setAsHomeButtonIndex == buttonIndex) {
        [self setAsHomeButtonAction:actionSheet];
    } else
    if (uiLockButtonIndex == buttonIndex) {
        [self uiLockAction:actionSheet];
    } else {
        [super actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
    }
}

@end
