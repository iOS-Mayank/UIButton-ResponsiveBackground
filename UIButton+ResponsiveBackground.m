//
//  UIButton+ResponsiveBackground.m
//
//  Created by Sam McEwan sammcewan@me.com on 21/10/12.
//
//
#import <objc/runtime.h>
#import "UIButton+ResponsiveBackground.h"

static char const * const NormalBackgroundKey = "NormalBackground";
static char const * const HighlightedBackgroundKey = "HighlightedBackground";

@implementation UIButton (ResponsiveBackground)

- (UIColor*)highlightedBackground
{
    return (UIColor*)objc_getAssociatedObject(self, HighlightedBackgroundKey);
}

-(void)setHighlightedBackground:(UIColor *)highlightedBackground
{
    objc_setAssociatedObject(self, HighlightedBackgroundKey, highlightedBackground, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIColor*)normalBackground
{
    return (UIColor*)objc_getAssociatedObject(self, NormalBackgroundKey);
}

-(void)setNormalBackground:(UIColor *)normalBackground
{
    objc_setAssociatedObject(self, NormalBackgroundKey, normalBackground, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Used for targets
-(void)changeButtonBackgroundColor
{
    self.backgroundColor = self.highlightedBackground;
}

- (void)resetButtonBackgroundColor
{
    self.backgroundColor = self.normalBackground;
}

- (void)setNormalBackground:(UIColor*)highlightedBackground highlightedBackground:(UIColor*)normalBackground
{
    [self setNormalBackground:normalBackground];
    self.backgroundColor = normalBackground;
    [self setHighlightedBackground:highlightedBackground];
    
    [self addTarget:self
             action:@selector(changeButtonBackgroundColor)
   forControlEvents:UIControlEventTouchDown];
    [self addTarget:self
                     action:@selector(resetButtonBackgroundColor)
           forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self
             action:@selector(resetButtonBackgroundColor)
   forControlEvents:UIControlEventTouchUpInside];
}


@end
