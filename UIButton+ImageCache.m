//
//  UIButton+ImageCache.m
//  Din Aker Brygge
//
//  Created by Paresh on 12/04/16.
//  Copyright © 2016 Dynamic Elements. All rights reserved.
//

#import "UIButton+ImageCache.h"
#import "objc/runtime.h"

const char *keyForButtonImageURL = "imageURL";

@implementation UIButton (ImageCache)

- (NSURL *)imageURL
{
    return objc_getAssociatedObject(self, keyForButtonImageURL);
}

- (void)setImageURL:(NSURL *)urlImage
{
    objc_setAssociatedObject(self, keyForButtonImageURL, urlImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setImageWithURL:(NSURL * _Nullable)url forState:(UIControlState)state
{
    [self setImageWithURL:url  forState:state placeholderImage:nil completion:nil];
}
- (void)setImageWithURL:(NSURL * _Nullable)url forState:(UIControlState)state placeholderImage:(UIImage * _Nullable)placeholder
{
    [self setImageWithURL:url forState:state placeholderImage:placeholder completion:nil];
}
- (void)setImageWithURL:(NSURL * _Nullable)url forState:(UIControlState)state completion:(void (^ __nullable)( UIImage * __nullable image))completion
{
    [self setImageWithURL:url forState:state placeholderImage:nil completion:completion];
}
- (void)setImageWithURL:(NSURL * _Nullable)url forState:(UIControlState)state placeholderImage:(UIImage * _Nullable)placeholder completion:(void (^ __nullable)( UIImage * __nullable image))completion
{
    self.imageURL = url;
    
    if (placeholder){
        [self setImage:placeholder forState:state];
    }
    else{
        [self setImage:nil forState:state];
    }
    
    if (url) {
        
        __weak __typeof(self)wself = self;
        [[ImageCache sharedInstance] imageForURL:url completion:^(UIImage * _Nullable image,NSURL * __nullable imgURL) {
            if (!wself) return;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (!wself) return;
                if (image && completion)
                {
                    if (imgURL == wself.imageURL)
                    {
                        [wself setImage:image forState:state];
                        [wself setNeedsLayout];
                    }
                    
                    completion(image);
                    return;
                }
                else if (image) {
                    if (imgURL == wself.imageURL)
                    {
                        [wself setImage:image forState:state];
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
