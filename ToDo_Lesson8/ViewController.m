//
//  ViewController.m
//  ToDo_Lesson8
//
//  Created by Admin on 22.04.15.
//  Copyright (c) 2015 Mariya Beketova. All rights reserved.
//

#import "ViewController.h"
#import "ToDoDatailViewController.h"


@interface ViewController ()

@property (strong, nonatomic) NSMutableArray * array_Events;
- (IBAction)add_Event:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self show_Notifications];
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show_Notifications) name:@"NewEvent" object:nil];
    
}




- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void) show_Notifications {
    //создаем массив нотификаций (сообщений):
    
    [self.array_Events removeAllObjects];
    [self reloadTableView];
    NSArray * arrayN = [[UIApplication sharedApplication] scheduledLocalNotifications];
    self.array_Events = [[NSMutableArray alloc] initWithArray:arrayN];

    

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array_Events.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * identifier = @"Cell";
    UITableViewCell * cell = [tableView  dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    UILocalNotification * notif = [self.array_Events objectAtIndex:indexPath.row];
    cell.textLabel.text = [notif.userInfo objectForKey:@"event"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[notif.userInfo objectForKey:@"data_event"]];
   
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    //данная процедура позволяет редактировать таблицу
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //этот метод будет срабатывать, если стиль редактирования: удалить
    if (editingStyle ==  UITableViewCellEditingStyleDelete) {
         UILocalNotification * notif = [self.array_Events objectAtIndex:indexPath.row];
        [self.array_Events removeObjectAtIndex:indexPath.row];
        [[UIApplication sharedApplication] cancelLocalNotification:notif];
        [self reloadTableView];
    }
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UILocalNotification * notif = [self.array_Events objectAtIndex:indexPath.row];
    
    ToDoDatailViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    
    detail.isNewEvent = NO;
    
    detail.string_EventItem = [notif.userInfo objectForKey:@"event"];
    detail.date_CurrentEvent = notif.fireDate;
    
    [self.navigationController pushViewController:detail animated:YES];
    
}


- (IBAction)add_Event:(id)sender {
//метод на срабатывание кнопки "Добавить"
    ToDoDatailViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    detail.isNewEvent = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

//метод, который перезагружает таблицу в текущем окне:
- (void) reloadTableView {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
