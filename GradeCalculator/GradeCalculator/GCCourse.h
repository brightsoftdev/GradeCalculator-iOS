//
//  GCCourse.h
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

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GCGradeComponent;

@interface GCCourse : NSManagedObject

@property (nonatomic, retain) NSNumber * gradingStyle;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSOrderedSet *gradeComponents;
@end

@interface GCCourse (CoreDataGeneratedAccessors)

- (void)insertObject:(GCGradeComponent *)value inGradeComponentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromGradeComponentsAtIndex:(NSUInteger)idx;
- (void)insertGradeComponents:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeGradeComponentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInGradeComponentsAtIndex:(NSUInteger)idx withObject:(GCGradeComponent *)value;
- (void)replaceGradeComponentsAtIndexes:(NSIndexSet *)indexes withGradeComponents:(NSArray *)values;
- (void)addGradeComponentsObject:(GCGradeComponent *)value;
- (void)removeGradeComponentsObject:(GCGradeComponent *)value;
- (void)addGradeComponents:(NSOrderedSet *)values;
- (void)removeGradeComponents:(NSOrderedSet *)values;
@end
