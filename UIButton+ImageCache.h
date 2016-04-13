//
//  UIButton+ImageCache.h
//  Din Aker Brygge
//
//  Created by Paresh on 12/04/16.
//  Copyright © 2016 Dynamic Elements. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCache.h"

@interface UIButton (ImageCache)
@property (nonatomic) NSURL *imageURL;

/**
 * Set the imageView `image` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url The url for the image.
 */
- (void)setImageWithURL:(NSURL * _Nullable)url forState:(UIControlState)state;

/**
 * Set the imageView `image` with an `url` and a placeholder.
 *
 * The download is asynchronous and cached.
 *
 * @param url         The url for the image.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @see sd_setImageWithURL:placeholderImage:options:
 */
- (void)setImageWithURL:(NSURL * _Nullable)url forState:(UIControlState)state placeholderImage:(UIImage * _Nullable)placeholder;

/**
 * Set the imageView `image` with an `url`.
 *
 * The download is asynchronous and cached.
 *
 * @param url            The url for the image.
 * @param completion     A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
- (void)setImageWithURL:( NSURL * _Nullable )url forState:(UIControlState)state completion:(void (^ __nullable)( UIImage * __nullable image))completion;

/**
 * Set the imageView `image` with an `url`, placeholder and custom options.
 *
 * The download is asynchronous and cached.
 *
 * @param url         The url for the image.
 * @param placeholder The image to be set initially, until the image request finishes.
 * @param completion     A block called when operation has been completed. This block has no return value
 *                       and takes the requested UIImage as first parameter. In case of error the image parameter
 *                       is nil and the second parameter may contain an NSError. The third parameter is a Boolean
 *                       indicating if the image was retrieved from the local cache or from the network.
 *                       The fourth parameter is the original image url.
 */
- (void)setImageWithURL:(NSURL * _Nullable)url forState:(UIControlState)state placeholderImage:(UIImage * _Nullable)placeholder completion:(void (^ __nullable)( UIImage * __nullable image))completion;
@end
