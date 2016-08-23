//
//  PSScanViewController.m
//  PSScanViewController
//
//  Created by Ryan_Man on 16/8/23.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "PSScanViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface PSScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    
    AVCaptureDevice * _device;
    
    AVCaptureDeviceInput * _input;
    
    AVCaptureMetadataOutput * _output;
    
    AVCaptureSession * _session;
    
    
    AVCaptureVideoPreviewLayer * _preview;
    

    UIView * _backgroundView;
    
}

@end

@implementation PSScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self setupBackgroundView];
    
    [self  setupCamera];
}

- (void)setupBackgroundView
{
    
    _backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    _backgroundView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.8];
    
    UIActivityIndicatorView * indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
    
    indicatorView.center = _backgroundView.center;
    
    indicatorView.size = CGSizeMake(50, 50);
    
    [indicatorView startAnimating];
    
    
    [_backgroundView addSubview:indicatorView];
    
    [self.view addSubview:_backgroundView];
}



- (void)setupCamera
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //耗时操作
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
        
        
        _output = [AVCaptureMetadataOutput new];
        
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        
        _session = [AVCaptureSession new];
        
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        
        
        if ([_session canAddInput:_input])
        {
            [_session addInput:_input];
            
        }
        
        if ([_session canAddOutput:_output])
        {
            [_session addOutput:_output];
        }
        
        //条形码类型 AVMetadataObjectTypeQRCode
        
        //        _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _backgroundView.hidden = YES;
            
            _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
            
            _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
            
            _preview.frame = self.view.bounds;
            
            [self.view.layer insertSublayer:_preview atIndex:0];
            
            [_session startRunning];
        });
        
    });

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_session && ![_session isRunning])
    {
        [_session startRunning];
    }
}

#pragma mark - 代理 -
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString * stringValue;
    
    
    if ([metadataObjects count] > 0)
    {
        
        AVMetadataMachineReadableCodeObject * metadataObject = metadataObjects.firstObject;
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
        
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
