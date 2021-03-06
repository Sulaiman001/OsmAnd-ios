//
//  OAMapPanelViewController.h
//  OsmAnd
//
//  Created by Alexey Pelykh on 8/20/13.
//  Copyright (c) 2013 OsmAnd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OAMapViewController.h"
#import "OACommonTypes.h"
#import "OATargetPointView.h"
#import "OAGPXRouteViewController.h"

@class OAFavoriteItem;
@class OAGpxWptItem;
@class OAGPX;
@class OADestination, OAPointDescription;
@class OAHistoryItem, OAAddress;
@class OAToolbarViewController;
@class OAMapActions, OAMapWidgetRegistry;
@class OAMapHudViewController;

@interface OAMapPanelViewController : UIViewController<OATargetPointViewDelegate>

- (instancetype) init;

@property (nonatomic, strong, readonly) OAMapViewController* mapViewController;
@property (nonatomic, strong, readonly) OAMapHudViewController* hudViewController;
@property (nonatomic, readonly) OAMapActions *mapActions;
@property (nonatomic, readonly) OAMapWidgetRegistry *mapWidgetRegistry;

@property (nonatomic, readonly) BOOL activeTargetActive;
@property (nonatomic, readonly) OATargetPointType activeTargetType;
@property (nonatomic, readonly) id activeTargetObj;
@property (nonatomic, readonly) id activeViewControllerState;
@property (nonatomic, readonly) BOOL activeTargetChildPushed;

- (void) prepareMapForReuse:(Point31)destinationPoint zoom:(CGFloat)zoom newAzimuth:(float)newAzimuth newElevationAngle:(float)newElevationAngle animated:(BOOL)animated;

- (void) prepareMapForReuse:(UIView *)destinationView mapBounds:(OAGpxBounds)mapBounds newAzimuth:(float)newAzimuth newElevationAngle:(float)newElevationAngle animated:(BOOL)animated;

- (void) doMapReuse:(UIViewController *)destinationViewController destinationView:(UIView *)destinationView;

- (void) modifyMapAfterReuse:(Point31)destinationPoint zoom:(CGFloat)zoom azimuth:(float)azimuth elevationAngle:(float)elevationAngle animated:(BOOL)animated;

- (void) modifyMapAfterReuse:(OAGpxBounds)mapBounds azimuth:(float)azimuth elevationAngle:(float)elevationAngle animated:(BOOL)animated;

- (BOOL) gpxModeActive;

- (void) destinationsAdded;
- (void) openDestinationCardsView;
- (void) hideDestinationCardsView;
- (void) hideDestinationCardsViewAnimated:(BOOL)animated;
- (void) openHideDestinationCardsView;

- (void) showContextMenu:(OATargetPoint *)targetPoint;
- (void) hideContextMenu;
- (BOOL) isContextMenuVisible;

- (void) closeDashboard;
- (void) closeDashboardWithDuration:(CGFloat)duration;

- (void) mapSettingsButtonClick:(id)sender;
- (void) searchButtonClick:(id)sender;
- (void) showRouteInfo;
- (void) closeRouteInfo;
- (void) showRoutePreferences;
- (void) showConfigureScreen;
- (void) setBottomControlsVisible:(BOOL)visible menuHeight:(CGFloat)menuHeight;

- (BOOL) isTopToolbarActive;

- (BOOL) isTopControlsVisible;
- (void) setTopControlsVisible:(BOOL)visible;
- (void) setTopControlsVisible:(BOOL)visible customStatusBarStyle:(UIStatusBarStyle)customStatusBarStyle;
- (void) updateOverlayUnderlayView:(BOOL)show;

- (void) openTargetViewWithFavorite:(OAFavoriteItem *)item pushed:(BOOL)pushed;
- (void) openTargetViewWithFavorite:(double)lat longitude:(double)lon caption:(NSString *)caption icon:(UIImage *)icon pushed:(BOOL)pushed;
- (void) openTargetViewWithAddress:(OAAddress *)address name:(NSString *)name typeName:(NSString *)typeName pushed:(BOOL)pushed;
- (void) openTargetViewWithHistoryItem:(OAHistoryItem *)item pushed:(BOOL)pushed;
- (void) openTargetViewWithHistoryItem:(OAHistoryItem *)item pushed:(BOOL)pushed showFullMenu:(BOOL)showFullMenu;

- (void) openTargetViewWithWpt:(OAGpxWptItem *)item pushed:(BOOL)pushed;
- (void) openTargetViewWithWpt:(OAGpxWptItem *)item pushed:(BOOL)pushed showFullMenu:(BOOL)showFullMenu;
- (void) openTargetViewWithGPX:(OAGPX *)item pushed:(BOOL)pushed;

- (void) openTargetViewWithGPXEdit:(OAGPX *)item pushed:(BOOL)pushed;

- (void) openTargetViewWithGPXRoute:(BOOL)pushed;
- (void) openTargetViewWithGPXRoute:(BOOL)pushed segmentType:(OAGpxRouteSegmentType)segmentType;
- (void) openTargetViewWithGPXRoute:(OAGPX *)item pushed:(BOOL)pushed;
- (void) openTargetViewWithGPXRoute:(OAGPX *)item pushed:(BOOL)pushed segmentType:(OAGpxRouteSegmentType)segmentType;
- (void) openTargetViewWithDestination:(OADestination *)destination;

- (void) openTargetViewWithRouteTargetSelection:(BOOL)target;

- (BOOL) hasGpxActiveTargetType;
- (void) displayGpxOnMap:(OAGPX *)item;
- (void) displayAreaOnMap:(CLLocationCoordinate2D)topLeft bottomRight:(CLLocationCoordinate2D)bottomRight zoom:(float)zoom bottomInset:(float)bottomInset leftInset:(float)leftInset;
- (BOOL) goToMyLocationIfInArea:(CLLocationCoordinate2D)topLeft bottomRight:(CLLocationCoordinate2D)bottomRight;

- (void) showCards;

- (void) showToolbar:(OAToolbarViewController *)toolbarController;
- (void) hideToolbar:(OAToolbarViewController *)toolbarController;

- (void) openSearch;
- (void) openSearch:(OAQuickSearchType)searchType;

- (void) setRouteTargetPoint:(BOOL)target latitude:(double)latitude longitude:(double)longitude pointDescription:(OAPointDescription *)pointDescription;

- (void) recreateControls;
- (void) refreshMap;
- (void) updateColors;

// Navigation
- (void) displayCalculatedRouteOnMap:(CLLocationCoordinate2D)topLeft bottomRight:(CLLocationCoordinate2D)bottomRight;

- (void) onNavigationClick:(BOOL)hasTargets;
- (void) switchToRouteFollowingLayout;
- (BOOL) switchToRoutePlanningLayout;
- (void) startNavigation;
- (void) stopNavigation;

@end
