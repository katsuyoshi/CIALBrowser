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
