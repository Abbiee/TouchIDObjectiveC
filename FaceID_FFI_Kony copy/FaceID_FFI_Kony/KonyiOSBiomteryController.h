//
//  KonyiOSBiomteryController.h
//  FaceID_FFI_Kony
//
//  Created by Abbie on 25/10/20.
//

#import <UIKit/UIKit.h>
//#import "lglobals.h"
NS_ASSUME_NONNULL_BEGIN

@interface KonyiOSBiomteryController : UIViewController
- (void)authenicateButtonTapped;
+(id)sharedManager;

@end

NS_ASSUME_NONNULL_END
