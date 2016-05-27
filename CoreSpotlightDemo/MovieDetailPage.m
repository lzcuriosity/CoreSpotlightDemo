//
//  MovieDetailPage.m
//  CoreSpotlightDemo
//
//  Created by Zen3 on 16/5/19.
//  Copyright © 2016年 Zen3. All rights reserved.
//

#import "MovieDetailPage.h"

@interface MovieDetailPage ()
{
    NSArray *contacts;
    NSDictionary *movieInfo;
}

@end

@implementation MovieDetailPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = movieInfo[@"tittle"];
    
    [self creatMovieInfoView];
    
}

-(void)initData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MovieContentsList" ofType:@"plist"];
    contacts = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    movieInfo = [[NSDictionary alloc] init];
    movieInfo = [contacts objectAtIndex:_numberOfMovie];

}


-(void)creatMovieInfoView
{
    UITextView *movieText = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [movieText setText: movieInfo[@"description"]];
    [movieText setFont: [UIFont boldSystemFontOfSize:16]];
    [self.view addSubview:movieText];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
