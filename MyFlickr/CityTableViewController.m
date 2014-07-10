//
//  CityTableViewController.m
//  MyFlickr
//
//  Created by Florian BUREL on 10/07/2014.
//  Copyright (c) 2014 florian burel. All rights reserved.
//

#import "CityTableViewController.h"
#import "City+DAO.h"
#import "PictureCarrousselViewController.h"

@interface CityTableViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray * cities;

@end

@implementation CityTableViewController

- (IBAction)addCity:(id)sender
{
    // Inserer une nouvelle ville en base
    City * c = [City new];
    
    // Ajouter la ville a l'array self.cities
    [self.cities addObject:c];
    
    // Rafraichir la tableView
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    
    // recuperation de la liste de ville
    self.cities = [[City allCities] mutableCopy];
    
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
    City * c = self.cities[position];
    
    // Recuperation d'une cellule
    UITableViewCell * cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"CITY_CELL" forIndexPath:indexPath];
    
    // Configurer la cellule
    cell.textLabel.text = c.name;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int position = indexPath.row;
    
    // Recuperation de la city
    City * c = self.cities[position];
    
    [City delete:c];
    
    [self.cities removeObject:c];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"CITY_SELECTED"])
    {
        // Recuperation de la ville
        NSIndexPath * indexPath = [self.tableView indexPathForCell:sender];
        City * c = self.cities[indexPath.row];
        
        // Passage de la ville au CarousselVC
        PictureCarrousselViewController * pvc = segue.destinationViewController;
        pvc.city = c;
    }
}
@end
















