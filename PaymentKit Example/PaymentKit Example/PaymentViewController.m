//
//  ViewController.m
//  PTKPayment Example
//
//  Created by Alex MacCaw on 1/21/13.
//  Copyright (c) 2013 Stripe. All rights reserved.
//

#import "PaymentViewController.h"

@interface PaymentViewController()

@property IBOutlet PTKView* paymentView;

@end


#pragma mark -

@implementation PaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    self.title = @"Change Card";
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    saveButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.paymentView = [[PTKView alloc] initWithFrame:CGRectMake(15, 25, 290, 45) transparentBackground:YES];
    self.paymentView.delegate = self;
    
    [self.view addSubview:self.paymentView];
    
    UIButton *fillButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 80, 290, 50)];
    [fillButton.layer setCornerRadius:3.f];
    [fillButton.layer setBorderColor:[[UIColor colorWithWhite:0.2 alpha:0.2f] CGColor]];
    [fillButton.layer setBorderWidth:1.f];
    [fillButton setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [fillButton setTitleColor:[UIColor colorWithWhite:0.2 alpha:1.f] forState:UIControlStateNormal];
    [fillButton setTitle:@"Fill Card Number Field" forState:UIControlStateNormal];
    [fillButton addTarget:self action:@selector(fill) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fillButton];
}

- (void)fill
{
    [self.paymentView setTextFieldCardNumber:@"4111111111111111"];
}

- (void) paymentView:(PTKView *)paymentView withCard:(PTKCard *)card isValid:(BOOL)valid
{
    self.navigationItem.rightBarButtonItem.enabled = valid;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender
{
    PTKCard* card = self.paymentView.card;
    
    NSLog(@"Card last4: %@", card.last4);
    NSLog(@"Card expiry: %lu/%lu", (unsigned long)card.expMonth, (unsigned long)card.expYear);
    NSLog(@"Card cvc: %@", card.cvc);
    
    [[NSUserDefaults standardUserDefaults] setValue:card.last4 forKey:@"card.last4"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
