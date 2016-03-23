ImageCache 1.0
==============

A fast reliable image cache for iOS built with NSURLSession.

1. Asynchronously loads from the fastest available source: NSCache, disk, or Internet.
1. Creates SHA1 hash of urls to use as keys.
1. Always calls completion blocks on the main queue.
1. Automatically removes old images in the background.
1. Stays out of your way.

<br>
Version Info:

1.0
 - Add nullability annotations.
 - Add @synchronized around UIImage creation.
 - Add check for error in the NSURLSession completion block.
 - Merge the JGAFSHA1 category into the main source file and remove NSString+JGAFSHA1 files.
 - Add clearAllData method.
 - Add serial queue for save to disk operations.
 - Check for available free disk space before saving to disk.
 - Add retry logic.
