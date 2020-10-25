//
//  FirstViewController.m
//  FaceID_FFI_Kony
//
//  Created by Abbie on 20/10/20.
//

#import "FirstViewController.h"
#import "KonyiOSBiomteryController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)clickAction:(id)sender {
    [[KonyiOSBiomteryController sharedManager]authenicateButtonTapped];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
