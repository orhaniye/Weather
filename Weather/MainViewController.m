//
//  MainViewController.m
//  Weather
//
//  Created by Zoltan on 03/11/14.
//  Copyright (c) 2014 ING Bank NV. All rights reserved.
//

#import "MainViewController.h"
#import "Weather-Swift.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (nonatomic, strong) NSDictionary * cityDescriptions;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (nonatomic, strong) Forecast * forecast;
@property (nonatomic, strong) DetailViewController * detailViewController;
@end

@implementation MainViewController

- (void) viewDidLoad {
    
    self.cityDescriptions = @{ @"Amsterdam": @"52.369476,4.897587",
                                @"Cluj": @"46.766667,23.583333",
                                @"Budapest": @"47.497912,19.040235" };
    
    _forecast = [[Forecast alloc] init];
    
    self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    [self.view addSubview:self.detailViewController.view];
    
    self.detailViewController.view.frame = self.detailView.frame;
    
    [self.detailView removeFromSuperview];
    
    [self loadPageData];
    
    [super viewDidLoad];
}

- (IBAction)pageChanged:(id)sender {
    [self loadPageData];
}

- (IBAction)rightPageGesture:(id)sender {
    
    if (self.pageControl.currentPage == 0)
        return;
    
    self.pageControl.currentPage --;
    [self loadPageData];
}

- (IBAction)leftPageGesture:(id)sender {
    
    if (self.pageControl.numberOfPages - 1 == self.pageControl.currentPage)
        return;
    
    self.pageControl.currentPage ++;
    [self loadPageData];
}

- (void) loadPageData {
    
    NSString * city = [self.cityDescriptions.allKeys objectAtIndex:self.pageControl.currentPage];
    NSString * coordinates = [self.cityDescriptions objectForKey:city];
    
    [self.city setText:city];

    void (^displayDataWhenAvailable)(Current *, NSError *) = ^void(Current * item, NSError * error) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.detailViewController loadData:item error:error];
            
            [self.detailViewController updateActivityIndicator:NO];
        });
    };
    
    [self.detailViewController updateActivityIndicator:YES];
    
    [self.forecast forecastForLocation:coordinates callback:displayDataWhenAvailable];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
