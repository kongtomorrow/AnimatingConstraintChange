//
//  ViewController.m
//  AnimatingConstriantChange
//
//  Created by Ken Ferry on 10/18/13.
//  Copyright (c) 2013 kenferry. All rights reserved.
//

#import "ViewController.h"

typedef enum {
    Left,
    Right
} Alignment;

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *xConstraints;
@property (nonatomic) Alignment alignment;
@property (strong, nonatomic) IBOutlet UIView *alignedView;
@end

@implementation ViewController

- (IBAction)toggleAlignment:(id)sender {
    NSArray *newXConstraints;
    if ([self alignment] == Left) {
        [self setAlignment:Right];
        newXConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[_alignedView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_alignedView)];
    } else {
        [self setAlignment:Left];
        newXConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_alignedView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_alignedView)];
    }
    
    [[self view] layoutIfNeeded]; // flush out frames. not needed in this case, but correct in general. You'd need this if you wanted to add a view to the window offscreen and then animate it onscreen. This would flush the view's frame out so that the initial position would be offscreen.
    [UIView animateWithDuration:0.5 animations:^{
        [[self view] removeConstraints:[self xConstraints]];
        [self setXConstraints:newXConstraints];
        [[self view] addConstraints:newXConstraints];
        [[self view] layoutIfNeeded]; // flush out frames, so that setFrame: is called from within animation block.
    }];
}

@end
