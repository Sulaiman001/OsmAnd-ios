//
//  OATargetMenuViewController.m
//  OsmAnd
//
//  Created by Alexey Kulish on 29/05/15.
//  Copyright (c) 2015 OsmAnd. All rights reserved.
//

#import "OATargetMenuViewController.h"
#import "OAUtilities.h"
#import "OsmAndApp.h"
#import "Localization.h"

@implementation OATargetMenuViewControllerState

@end

@interface OATargetMenuViewController ()

@end

@implementation OATargetMenuViewController

- (void) setLocation:(CLLocationCoordinate2D)location
{
    _location = location;
    _formattedCoords = [[[OsmAndApp instance] locationFormatterDigits] stringFromCoordinate:location];
}

- (BOOL) needAddress
{
    return YES;
}

- (NSString *) getTypeStr
{
    return [self getCommonTypeStr];
}

- (NSString *) getCommonTypeStr
{
    return OALocalizedString(@"sett_arr_loc");
}

- (NSAttributedString *) getAttributedTypeStr
{
    return nil;
}

- (NSAttributedString *) getAttributedCommonTypeStr
{
    return nil;
}

- (NSAttributedString *)getAttributedTypeStr:(NSString *)group
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:15.0];
    
    NSMutableAttributedString *stringGroup = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  %@", group]];
    NSTextAttachment *groupAttachment = [[NSTextAttachment alloc] init];
    groupAttachment.image = [OAUtilities tintImageWithColor:[UIImage imageNamed:@"map_small_group.png"] color:UIColorFromRGB(0x727272)];
    
    NSAttributedString *groupStringWithImage = [NSAttributedString attributedStringWithAttachment:groupAttachment];
    [stringGroup replaceCharactersInRange:NSMakeRange(0, 1) withAttributedString:groupStringWithImage];
    [stringGroup addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithFloat:-2.0] range:NSMakeRange(0, 1)];
    
    [string appendAttributedString:stringGroup];
    
    [string addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    
    return string;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    _navBar.hidden = YES;
    _actionButtonPressed = NO;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction) buttonOKPressed:(id)sender
{
    _actionButtonPressed = YES;
    [self okPressed];
}

- (IBAction) buttonCancelPressed:(id)sender
{
    _actionButtonPressed = YES;
    [self cancelPressed];
}

- (void) okPressed
{
    // override
}

- (void) cancelPressed
{
    // override
}

- (BOOL) hasContent
{
    return YES; // override
}

- (CGFloat) contentHeight
{
    return 0.0; // override
}

- (void) setContentBackgroundColor:(UIColor *)color
{
    _contentView.backgroundColor = color;
}

- (BOOL) hasInfoView
{
    return [self hasInfoButton] || [self hasRouteButton];
}

- (BOOL) hasInfoButton
{
    return [self hasContent] && ![self isLandscape];
}

- (BOOL) hasRouteButton
{
    return YES;
}

- (BOOL) showTopControls
{
    return NO;
}

- (BOOL) supportMapInteraction
{
    return NO; // override
}

- (BOOL) showNearestWiki;
{
    return NO; // override
}

- (BOOL) supportFullMenu
{
    return YES; // override
}

- (BOOL) supportFullScreen
{
    return NO; // override
}

- (BOOL) fullScreenWithoutHeader
{
    return NO; // override
}

- (void) goHeaderOnly
{
    // override
}

- (void) goFull
{
    // override
}

- (void) goFullScreen
{
    // override
}

- (BOOL) hasTopToolbar
{
    return NO; // override
}

- (BOOL) shouldShowToolbar:(BOOL)isViewVisible;
{
    return NO; // override
}

- (void) useGradient:(BOOL)gradient
{
    if (self.titleGradient && gradient)
    {
        self.titleGradient.hidden = NO;
        self.navBarBackground.hidden = YES;
    }
    else
    {
        self.titleGradient.hidden = YES;
        self.navBarBackground.hidden = NO;
    }
}

- (BOOL) disablePanWhileEditing
{
    return NO; // override
}

- (BOOL) supportEditing
{
    return NO; // override
}

- (void) activateEditing
{
    // override
}

- (BOOL) commitChangesAndExit
{
    return YES; // override
}

- (BOOL) preHide
{
    return YES; // override
}

- (id) getTargetObj
{
    return nil; // override
}

- (OATargetMenuViewControllerState *)getCurrentState
{
    return nil; // override
}

- (BOOL) isLandscape
{
    return DeviceScreenWidth > 470.0 && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

@end
