//
//  ViewController.m
//  CoreSpotlightDemo
//
//  Created by Zen3 on 16/5/19.
//  Copyright © 2016年 Zen3. All rights reserved.
//

#import "MovieTablePage.h"

@interface MovieTablePage () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_contacts;
    UITableView *_tableView;
}

@end

@implementation MovieTablePage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title  = @"电影";
    
    [self initData];
    
    [self setupSearchableContent];
    
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    

}

-(void)initData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MovieContentsList" ofType:@"plist"];
    _contacts = [[NSArray alloc] initWithContentsOfFile:plistPath];

}

-(void)setupSearchableContent
{
    NSMutableArray *seachableItems = [NSMutableArray new];
    
    for (int i = 0; i < _contacts.count; i++)
    {
        NSDictionary *temp = _contacts[i];
        
        CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString *)kUTTypeImage];
        
        attributeSet.title = temp[@"tittle"];                // 标题
        attributeSet.keywords = [temp[@"category"] componentsSeparatedByString:@"/"];                  // 关键字,NSArray格式
        attributeSet.contentDescription = temp[@"description"];    // 描述
        attributeSet.thumbnailData = UIImagePNGRepresentation([UIImage imageNamed:temp[@"image"]]);        // 图标, NSData格式
        
        CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:[NSString stringWithFormat:@"%d",i] domainIdentifier:@"Zen3.CoreSpotlightDemo" attributeSet:attributeSet];
        NSLog(@"%@",[NSString stringWithFormat:@"%d",i]);
        [seachableItems addObject:item];
        
    }
    
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:seachableItems completionHandler:^(NSError * error) {
        if (error) {
            NSLog(@"indexSearchableItems Error:%@",error.localizedDescription);
            
        }
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_contacts != NULL)
    {
        return  _contacts.count;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 123.00;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey";
    
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell= [[[NSBundle mainBundle]loadNibNamed:@"MovieCell" owner:nil options:nil] firstObject];
    }
    
    NSDictionary* temp = [_contacts objectAtIndex:indexPath.row];
    
    UIImageView *icon =(UIImageView*)[cell viewWithTag:1];
    UILabel *tittle = (UILabel*)[cell viewWithTag:2];
    UILabel *dlrector = (UILabel*)[cell viewWithTag:3];
    UILabel *rating = (UILabel*)[cell viewWithTag:4];
    
    icon.image = [UIImage imageNamed:temp[@"image"]];
    tittle.text = temp[@"tittle"];
    dlrector.text = [NSString stringWithFormat:@"导演:%@",temp[@"dlrector"]];
    rating.text = [NSString stringWithFormat:@"评分:%@",temp[@"rating"]];
    
    return cell;
}



#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailPage* detailPage = [[MovieDetailPage alloc] init];
    detailPage.numberOfMovie = indexPath.row;
    [self.navigationController pushViewController: detailPage animated:true];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
