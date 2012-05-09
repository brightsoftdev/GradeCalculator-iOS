//
//  GCComponentListViewController.m
//  Weighted Grade Calculator
//
//  Copyright (C) 2012 Jimmy Theis. Licensed under the MIT License:
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "GCComponentListViewController.h"
#import "GCAppDelegate.h"
#import "GCComponentDetailViewController.h"
#import "GCCourse.h"
#import "GCPointTotalGradeComponent+Customization.h"
#import "GCPercentageGradeComponent+Customization.h"

#define kCourseDetailSegueIdentifier @"ComponentListToCourseDetailSegue"
#define kEditComponentDetailSegueIdentifier @"ComponentListToEditComponentDetailSegue"
#define kAddComponentDetailSegueIdentifier @"ComponentListToAddComponentDetailSegue"

#define kComponentCellIdentifier @"CourseDetailGradeComponentCell"
#define kNewComponentCellIdentifier @"CourseDetailNewComponentCell"


@interface GCComponentTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property (nonatomic, weak) IBOutlet UILabel *detailLabel;

@property (nonatomic, weak) IBOutlet UISlider *gradeSlider;

@end


@implementation GCComponentTableViewCell

@synthesize nameLabel = _nameLabel;
@synthesize detailLabel = _detailLabel;
@synthesize gradeSlider = _gradeSlider;

@end


@interface GCComponentListViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

@end

@implementation GCComponentListViewController

@synthesize tableView = _tableView;
@synthesize course = _course;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = self.course.name;
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kAddComponentDetailSegueIdentifier]) {
        GCComponentDetailViewController *componentDetail = segue.destinationViewController;
        
        if (self.course.gradingStyleValue == GCCourseGradingStylePointTotal) {
            GCPointTotalGradeComponent *newComponent = [NSEntityDescription insertNewObjectForEntityForName:kGCPointTotalGradeComponentEntityName inManagedObjectContext:self.managedObjectContext];
            newComponent.course = self.course;
            componentDetail.gradeComponent = newComponent;
            
            // TODO: Fix this when it's fixed
            NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.course.gradeComponents];
            [tempSet addObject:newComponent];
            self.course.gradeComponents = tempSet;
            
        } else {
            GCPercentageGradeComponent *newComponent = [NSEntityDescription insertNewObjectForEntityForName:kGCPercentageGradeComponentEntityName inManagedObjectContext:self.managedObjectContext];
            newComponent.course = self.course;
            componentDetail.gradeComponent = newComponent;
            
            // TODO: Fix this when it's fixed
            NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.course.gradeComponents];
            [tempSet addObject:newComponent];
            self.course.gradeComponents = tempSet;
        }
        
        NSLog(@"Components: %d", self.course.gradeComponents.count);
        
    } else if ([segue.identifier isEqualToString:kEditComponentDetailSegueIdentifier]) {
        GCComponentDetailViewController *componentDetail = segue.destinationViewController;
        componentDetail.gradeComponent = [self.course.gradeComponents objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    }
}

- (NSManagedObjectContext *)managedObjectContext
{
    return [(GCAppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.course.gradeComponents.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.course.gradeComponents.count) {
        return [tableView dequeueReusableCellWithIdentifier:kNewComponentCellIdentifier];
    }
    
    GCComponentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kComponentCellIdentifier];
    
    GCGradeComponent *currentComponent = [self.course.gradeComponents objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = currentComponent.name;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.course.gradeComponents.count) {
        return 44;
    }
    
    return 114;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
