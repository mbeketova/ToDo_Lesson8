//
//  ToDoDatailViewController.h
//  ToDo_Lesson8
//
//  Created by Admin on 22.04.15.
//  Copyright (c) 2015 Mariya Beketova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoDatailViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, assign) BOOL isNewEvent;
@property (nonatomic, strong) NSString * string_EventItem;
@property (nonatomic, strong) NSDate * date_CurrentEvent;

@end
