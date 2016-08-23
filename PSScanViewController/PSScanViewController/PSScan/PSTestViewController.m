//
//  PSTestViewController.m
//  PSScanViewController
//
//  Created by Ryan_Man on 16/8/23.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSTestViewController.h"
#import "PSScanViewController.h"
@interface PSTestViewController ()

@end

@implementation PSTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"test";
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemCamera) target:self action:@selector(scanEvent:)];
    
    
    
    
}

- (void)scanEvent:(UIBarButtonItem*)sender
{
    LogFunctionName();
 
    PSScanViewController * scanVC = NewClass(PSScanViewController);
    [self.navigationController pushViewController:scanVC animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
