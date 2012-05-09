//
//  GCComponentDetailViewController.m
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

#import "GCComponentDetailViewController.h"
#import "GCAppDelegate.h"
#import "GCPointTotalGradeComponent.h"
#import "GCPercentageGradeComponent.h"

@interface GCComponentDetailViewController ()

@property (nonatomic, weak) IBOutlet UITextField *nameField;

@property (nonatomic, weak) IBOutlet UITextField *earnedField;

@property (nonatomic, weak) IBOutlet UITextField *availableField;

@property (nonatomic, weak) IBOutlet UILabel *earnedLabel;

@property (nonatomic, weak) IBOutlet UILabel *availableLabel;

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

- (IBAction)componentDataChanged:(id)sender;

@end


@implementation GCComponentDetailViewController

@synthesize gradeComponent = _gradeComponent;
@synthesize nameField = _nameField;
@synthesize earnedField = _earnedField;
@synthesize availableField = _availableField;
@synthesize earnedLabel = _earnedLabel;
@synthesize availableLabel = _availableLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.gradeComponent.name.length == 0) {
        self.title = @"New Component";
    } else {
        self.title = self.gradeComponent.name;
    }
    
    if ([self.gradeComponent isKindOfClass:[GCPointTotalGradeComponent class]]) {
        self.earnedLabel.text = @"Points Earned";
        self.availableLabel.text = @"Points Available";
    } else {
        self.earnedLabel.text = @"Percentage Earned (%)";
        self.availableLabel.text = @"Weight (%)";
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSManagedObjectContext *)managedObjectContext
{
    return [(GCAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

#pragma mark - IBActions

- (void)componentDataChanged:(id)sender
{
    if ([self.gradeComponent isKindOfClass:[GCPointTotalGradeComponent class]]) {
        
        GCPointTotalGradeComponent *pointComponent = (GCPointTotalGradeComponent *) self.gradeComponent;
        pointComponent.name = self.nameField.text;
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        
        pointComponent.pointsEarned = [f numberFromString:self.earnedField.text];
        pointComponent.pointsAvailable = [f numberFromString:self.availableField.text];
        
        [self.managedObjectContext save:nil];
        
    } else if ([self.gradeComponent isKindOfClass:[GCPercentageGradeComponent class]]) {
        
        GCPercentageGradeComponent *percentageComponent = (GCPercentageGradeComponent *) self.gradeComponent;
        percentageComponent.name = self.nameField.text;
        
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        
        percentageComponent.percentageEarned = [f numberFromString:self.earnedField.text];
        percentageComponent.weight = [f numberFromString:self.earnedField.text];
        
        [self.managedObjectContext save:nil];
    }
}

@end
