//
//  OATurnDrawable.m
//  OsmAnd
//
//  Created by Alexey Kulish on 02/11/2017.
//  Copyright © 2017 OsmAnd. All rights reserved.
//

#import "OATurnDrawable.h"
#import "OAUtilities.h"
#import "OAColors.h"

@implementation OATurnDrawable
{
    BOOL _mini;
    UIColor *_routeDirectionColor;
}

- (instancetype) initWithMini:(BOOL)mini
{
    self = [super init];
    if (self)
    {
        _mini = mini;
        _pathForTurn = [UIBezierPath bezierPath];
        _pathForTurnOutlay = [UIBezierPath bezierPath];
        _pathForTurnOutlay.lineWidth = 2.5f;
        _pathForTurn.lineWidth = 2.5f;

        [self setClr:UIColorFromRGB(color_nav_arrow)];
    }
    return self;
}

- (void) setClr:(UIColor *)clr
{
    if (![clr isEqual:_clr])
    {
        _clr = clr;
        _routeDirectionColor = clr;
    }
}

- (void) layoutSubviews
{
    float scaleX = self.bounds.size.width / 72.f;
    float scaleY = self.bounds.size.height / 72.f;
    CGAffineTransform m = CGAffineTransformMakeScale(scaleX, scaleY);
    [_pathForTurn applyTransform:m];
    [_pathForTurnOutlay applyTransform:m];
}

- (void) setTurnImminent:(int)turnImminent deviatedFromRoute:(BOOL)deviatedFromRoute
{
    //if user deviates from route that we should draw grey arrow
    _turnImminent = turnImminent;
    _deviatedFromRoute = deviatedFromRoute;
    if (deviatedFromRoute)
        _routeDirectionColor = UIColorFromRGB(color_nav_arrow_distant);
    else if (turnImminent > 0)
        _routeDirectionColor = UIColorFromRGB(color_nav_arrow);
    else if (turnImminent == 0)
        _routeDirectionColor = UIColorFromRGB(color_nav_arrow_imminent);
    else
        _routeDirectionColor = UIColorFromRGB(color_nav_arrow_distant);

    [self setNeedsDisplay];
}

- (BOOL) setTurnType:(std::shared_ptr<TurnType>)turnType
{
    if (turnType != _turnType)
    {
        _turnType = turnType;
        [OATurnPathHelper calcTurnPath:_pathForTurn outlay:_pathForTurnOutlay turnType:_turnType transform:CGAffineTransformIdentity center:CGPointZero mini:_mini];
        [self setNeedsLayout];
        return true;
    }
    return false;
}

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(context, true);
    //CGContextSetLineWidth(context, 2.5f);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(context, _routeDirectionColor.CGColor);

    //CGContextTranslateCTM(aRef, 50, 50);
    [_pathForTurnOutlay stroke];
    [_pathForTurn fill];
    [_pathForTurn stroke];
    
    if (_turnType && !_mini && _turnType->getExitOut() > 0)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        NSMutableDictionary<NSAttributedStringKey, id> *attributes = [NSMutableDictionary dictionary];
        attributes[NSParagraphStyleAttributeName] = paragraphStyle;
        attributes[NSForegroundColorAttributeName] = _textColor;
        attributes[NSFontAttributeName] = _textFont;
        
        [[NSString stringWithFormat:@"%d", _turnType->getExitOut()] drawInRect:self.bounds withAttributes:attributes];
    }
}

@end