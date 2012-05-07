//
//  GCCourseDetailViewController.m
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

#import "GCCourseDetailViewController.h"
#import "GCAppDelegate.h"
#import "GCCourse+Customization.h"

@interface GCCourseDetailViewController ()

@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet UISegmentedControl *typeControl;
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end

@implementation GCCourseDetailViewController

@synthesize nameField = _nameField;
@synthesize typeControl = _typeControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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

- (void)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)done:(id)sender
{
    GCCourse *newCourse = [NSEntityDescription insertNewObjectForEntityForName:kGCCourseEntityName inManagedObjectContext:self.managedObjectContext];
    newCourse.name = self.nameField.text;
    newCourse.gradingStyle = [NSNumber numberWithInt:(self.typeControl.selected == 0 ? GCCourseGradingStylePointTotal : GCCourseGradingStyleWeightedPercentages)];
    [self dismissModalViewControllerAnimated:YES];
}

@end
