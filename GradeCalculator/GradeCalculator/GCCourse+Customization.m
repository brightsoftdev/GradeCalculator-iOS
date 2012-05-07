//
//  GCCourse+Customization.m
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

#import "GCCourse+Customization.h"
#import "GCPointTotalGradeComponent.h"
#import "GCPercentageGradeComponent.h"

@implementation GCCourse (Customization)

- (GCCourseGradingStyle)gradingStyleValue
{
    return self.gradingStyle.intValue;
}

- (void)setGradingStyleValue:(GCCourseGradingStyle)gradingStyleValue
{
    self.gradingStyle = [NSNumber numberWithInt:gradingStyleValue];
}

- (NSNumber *)overallScore
{
    if (self.gradingStyleValue == GCCourseGradingStylePointTotal) {
        
        double totalEarned = 0;
        double totalAvailable = 0;
        
        for (GCPointTotalGradeComponent *component in self.gradeComponents) {
            totalEarned += component.pointsEarned.doubleValue;
            totalAvailable += component.pointsAvailable.doubleValue;
        }
        
        if (totalAvailable == 0) {
            return [NSNumber numberWithInt:0];
        }
        
        return [NSNumber numberWithDouble:totalEarned / totalAvailable];
        
    } else {
        
        double totalScore = 0;
        
        for (GCPercentageGradeComponent *component in self.gradeComponents) {
            totalScore += component.weight.doubleValue * component.percentageEarned.doubleValue;
        }
        
        return [NSNumber numberWithDouble:totalScore];
    }
}

@end
