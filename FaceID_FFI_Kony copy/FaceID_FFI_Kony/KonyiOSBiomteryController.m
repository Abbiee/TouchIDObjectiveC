//
//  KonyiOSBiomteryController.m
//  FaceID_FFI_Kony
//
//  Created by Abbie on 25/10/20.
//

#import "KonyiOSBiomteryController.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface KonyiOSBiomteryController ()

@end

@implementation KonyiOSBiomteryController
+(id)sharedManager{
    static KonyiOSBiomteryController *sharedManager = nil;
    sharedManager = [[KonyiOSBiomteryController alloc]init];
    return sharedManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)authenicateButtonTapped{
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Touch ID Test";
    myContext.localizedFallbackTitle = @"";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
            NSLog(@"success");
            
            if (success) {
                NSString *str = @"You are the owner of device";
                NSArray * result = [[NSArray alloc] initWithObjects:str,nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //  executeClosure(callBack, result, NO);
                });
            } else {
                switch (error.code) {
                    case LAErrorAuthenticationFailed:
                        NSLog(@"Authentication Failed");
                        break;
                        
                    case LAErrorUserCancel:
                        NSLog(@"User pressed Cancel button");
                        break;
                        
                    case LAErrorUserFallback:
                        NSLog(@"User pressed Enter Password");
                        break;
                        
                    case LAErrorPasscodeNotSet:
                        NSLog(@"Passcode Not Set");
                        break;
                        
                    case LAErrorBiometryNotAvailable:
                        NSLog(@"Touch ID not available");
                        break;
                        
                    case LAErrorBiometryNotEnrolled:
                        NSLog(@"Touch ID not Enrolled or configured");
                        break;
                        
                    default:
                        NSLog(@"Touch ID is not configured");
                        break;
                }
                NSArray * result = [[NSArray alloc] initWithObjects:error.localizedDescription,nil];
                NSLog(@"Failure error: %@", result);
                NSLog(@"biometry disabled Error code %ld", (long)error.code);
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //  executeClosure(callBack, result, NO);
                    // Rather than show a UIAlert here, use the error to determine if you should push to a keypad for PIN entry.
                    [self presentAlertControllerWithMessage:error.localizedDescription];
                });
            }
        }];
    } else {
        NSArray * result = [[NSArray alloc] initWithObjects:authError.localizedDescription,nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Failure when biometry hardware not there%@",result);
            NSLog(@"biometry hardware Error code %@", authError);
            //   executeClosure(callBack, result, NO);
            // Rather than show a UIAlert here, use the error to determine if you should push to a keypad for PIN entry.
            [self presentAlertControllerWithMessage:authError.localizedDescription];
        });
        
    }
}

// Alert view controller handling 
-(void) presentAlertControllerWithMessage:(NSString *) message{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Touch ID" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    UIViewController *test = [self topViewController];
    [test presentViewController:alertController animated:YES completion:nil];
    
}

// Finding top view controller

- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

-(UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}
@end
