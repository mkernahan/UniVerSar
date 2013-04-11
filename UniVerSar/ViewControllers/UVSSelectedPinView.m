//
//  UVSSelectedPinView.m
//  UniVerSar
//
//  Created by Michael Kernahan on 2013-04-10.
//  Copyright (c) 2013 redshirtlabs. All rights reserved.
//

#import "UVSSelectedPinView.h"

@implementation UVSSelectedPinView

- (id) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed: @"UVSSelectedPinView"
                                      owner: self
                                    options: nil];
        self.contentView.frame = self.bounds;
        // do extra loading here
        [self addSubview: self.contentView];
    }
    return self;
}

- (void) didMoveToSuperview {
    [self.superview bringSubviewToFront:self];
}

@end
