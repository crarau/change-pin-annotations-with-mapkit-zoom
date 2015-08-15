//
//  UIImage+Resize.h
//  EverLocation
//
//  Created by Chip on 2014-05-07.
//  Copyright (c) 2014 Ciprian Rarau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)
- (UIImage*) scaledToWidth: (float) i_width;
- (UIImage *) scaledToMaxWidth:(CGFloat)width maxHeight:(CGFloat)height;
- (UIImage *) scaledToSize:(CGSize)size;
-(NSUInteger)calculatedSize;
-(UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;
@end
