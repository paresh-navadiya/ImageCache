//
//  UIImageView+ImageCache.m
//  Din Aker Brygge
//
//  Created by Paresh on 12/04/16.
//  Copyright © 2016 Dynamic Elements. All rights reserved.
//

#import "UIImageView+ImageCache.h"
#import "objc/runtime.h"

const char *keyForImageURL = "imageURL";

@implementation UIImageView (ImageCache)

- (NSURL *)imageURL
{
    return objc_getAssociatedObject(self, keyForImageURL);
}

- (void)setImageURL:(NSURL *)urlImage
{
    objc_setAssociatedObject(self, keyForImageURL, urlImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setImageWithURL:(NSURL * _Nullable)url
{
    [self setImageWithURL:url placeholderImage:nil completion:nil];
}
- (void)setImageWithURL:(NSURL * _Nullable)url placeholderImage:(UIImage * _Nullable)placeholder
{
    [self setImageWithURL:url placeholderImage:placeholder completion:nil];
}
- (void)setImageWithURL:(NSURL * _Nullable)url completion:(void (^ __nullable)( UIImage * __nullable image))completion
{
    [self setImageWithURL:url placeholderImage:nil completion:completion];
}
- (void)setImageWithURL:(NSURL * _Nullable)url placeholderImage:(UIImage * _Nullable)placeholder completion:(void (^ __nullable)( UIImage * __nullable image))completion
{
    self.imageURL = url;
    
    if (placeholder){
        self.image = placeholder;
    }
    else{
        self.image = nil;
    }
    
    if (url) {
        
        __weak __typeof(self)wself = self;
        [[ImageCache sharedInstance] imageForURL:url completion:^(UIImage * _Nullable image,NSURL * __nullable imgURL)
        {
            if (!wself) return;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (image && completion)
                {
                    if (imgURL == wself.imageURL)
                    {
                        wself.image = image;
                        [wself setNeedsLayout];
                    }
                    
                    completion(image);
                    return;
                }
                else if (image) {
                    
                    if (imgURL == wself.imageURL)
                    {
                        wself.image = image;
                        [wself setNeedsLayout];
                    }
                    return;
                } else {
                    if (completion) {
                        completion(nil);
                        return;
                    }
                }
            });
        }];
        
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (completion) {
                completion(nil);
                return;
            }
        });
    }

}

@end
