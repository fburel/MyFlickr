//
//  CityTableViewController.m
//  MyFlickr
//
//  Created by Florian BUREL on 10/07/2014.
//  Copyright (c) 2014 florian burel. All rights reserved.
//

#import "CityTableViewController.h"

@interface CityTableViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray * cities;

@end

@implementation CityTableViewController

- (IBAction)addCity:(id)sender
{
    // Inserer une nouvelle ville en base
    
    // Ajouter la ville a l'array self.cities
    
    // Rafraichir la tableView
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    
    // recuperation de la liste de ville
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int position = indexPath.row;
    
    // Recuperation de la city
    
    // Recuperation d'une cellule
    UITableViewCell * cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"CITY_CELL" forIndexPath:indexPath];
    
    // Configurer la cellule
    
    
    return cell;
}

@end
















