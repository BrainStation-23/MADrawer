# MADrawer

MADrawer is a customized view that appears and disappears from the left edge of the screen by smoothly animating in and out. Initially it emerges upon hitting the drawer button at the top of the Navigation Bar but once created, it can be unveiled by swiping towards the right edge and concealed by swiping towards the left edge of the screen.
MADrawer is designed as a view rather than a controller, so that it can be incorporated in any type of controller, that way, users aren’t restricted to subclass any particular controller.

## Screenshots

### Simple Drawer Style
<img src="https://github.com/BrainStation-23/MADrawer/raw/master/ScreenShots/Simple_Style.png" style="height:200px;width:120px" />

### Grouped Drawer Style
<img src="https://github.com/BrainStation-23/MADrawer/raw/master/ScreenShots/Grouped_Style.png" style="height:200px;width:120px" />

### Round-Edged Drawer Style
<img src="https://github.com/BrainStation-23/MADrawer/raw/master/ScreenShots/Round-Edged_Style.png" style="height:200px;width:120px" />


## Target

**MADrawer** supports any iOS version greater than or equals to 6.0. The library is designed for both iPhone and iPad.

## Requirements

Other than the usual frameworks that come with any projects that is created in xCode, it requires following Apple Frameworks-
* **CoreGraphics.framework**
* **QuartzCore.framework**


## Getting The MADrawer Source Files
1.	Download the latest code version.
2.	Open the Project directory and drag and drop all the files from the “Class” and “Icon” folders. Make sure, you select the “Copy items if needed” option while the pop-up appears.

## Usage
Incorporating the `MADrawer` to your Project is very easy. The only constrain, you have to maintain is that your View Controller (where the drawer will be added) should be embedded in a Navigation Controller.
So, go to your storyboard, select the View Controller and then select **Editor=>Embed In=>Navigation Controller**.


## Adding MADrawer To Your Project

Include the `MADrawerManagerView` class in your View Controller Class. Also you must include `MADrawerManagerViewDelegate` in your protocol list as it has a required delegate method.

**Sample code snippet:**

```objective-c
#import <UIKit/UIKit.h>
#import "MADrawerManagerView.h"

@interface ViewController : UIViewController <MADrawerManagerViewDelegate>

@property(nonatomic, strong) MADrawerManagerView *drawerViewManager;

@end
```
Adding the drawer is very easy. You just have to add your `drawerViewManager` and while initializing, you will set the frame for your drawer’s button.

Though initialization can happen in the `viewDidLoad` method, you need to add the drawer in the `viewWillAppear` method.

**Sample code snippet:**

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    self.drawerViewManager = [[MADrawerManagerView alloc]initWithFrame:CGRectMake((self.navigationController.navigationBar.bounds.origin.x + 10), (self.navigationController.navigationBar.bounds.origin.y+10), 40, 20)];
self.drawerViewManager.delegate=self;
}

-(void)viewWillAppear:(BOOL)animated{  
    [self.navigationController.navigationBar addSubview:self.drawerViewManager];
}
```

## Required and Optional Protocol

All the customizations or features that can be exploited come through the `MADrawerManagerViewDelegate`.
There is only one required delegate method, and others are optional. `setParent` is the required delegate method through which the `MADrawerManager` knows where to create or show the drawer View.

Simply do in the View Controller where you want your drawer navigator-

```objective-c
-(UIViewController*)setParent{
    return self;
}
```

## Features and Supports

1.	`MADrawer` provides support for any kind of View Controller starting from Table view Controller to Tab Bar Controller. You can have your own custom View Controller and still use it.
2.	It provides smooth fly in and fly out animation by pressing the drawer button or by swiping left and right.
3.	It provides three different kinds of drawer style.

If you have a long way in your project and without changing the structure, you want to incorporate a Drawer feature; MADrawer should be able to help you. You can treat MADrawer like any other view.

## Customization

### Choosing Style:

You can choose the drawer style. By default, it is plain. If you don’t specify anything, the default style will be loaded
 To choose a style, you need to implement the `setDrawerStyle` delegate method.

**Sample code snippet for plain style:**

```objective-c
-(NSInteger)setDrawerStyle{ //for default or plain style
	return MADrawerStylePlain;
}
```

**Sample code snippet for round edged style:**

```objective-c
-(NSInteger)setDrawerStyle{ //for round edged style
	return MADrawerStyleRoundEdged;
}
```

### Setting Drawer Items:

You can add as many items as you want to your drawer.
Use the `setItems` method to set your drawer Items. Depending on the drawer’s style, either you would want to send an array of strings where these strings will represent individual drawer cells or an array of array of strings where each array object inside the container array will represent a group of drawer items.

**Sample code snippet for plain or round edged style:**
```objective-c

-(NSMutableArray*)setItems{
	NSMutableArray *items =[[NSMutableArray alloc]initWithObjects:@"Home", @"Gallary", @"Contacts", nil];
	return items;
}
```

**Sample code snippet for grouped style-**

```objective-c
-(NSMutableArray*)setItems{

	//Container array to hold the different groups
	NSMutableArray *itemGroups=[[NSMutableArray alloc]init];

	//Add the groups as arrays to the Container Array array(itemGroups)
	NSArray *list;
	list =[[NSArray alloc]initWithObjects:@"Note", @"Reminder", @"Calculator", nil];
	[itemGroups addObject:list];
	list =[[NSArray alloc]initWithObjects:@"Audio Player", @"Video Player", nil];
	[itemGroups addObject:list];
	return itemGroups;
}
```

**Warning:** For Grouped Style, if the array is not sent as an array of array/arrays, the app will crash. Make sure that you add the array as an object to the container array, even if there is only one group.



### Setting Group Title:
Users can set the title for each group for the grouped style Drawer through the `setHeaderTitles` delegate method.

**Sample Code Snippet-**

```objective-c
-(NSMutableArray*)setHeaderTitles{
    NSMutableArray *headerTitles=[[NSMutableArray alloc]initWithObjects:@"Tools", @"Entertainment", nil];
    return headerTitles;
}
```
### Performing Actions:
User has the total access to the drawer elements. They can choose to update the view or load another view Controller through the `performActionForItem:withItemNumber:inGroup:` delegate method.

**Sample Code Snippet-**

```objective-c
-(void)performActionForItem:(id)sender withItemNumber:(NSInteger)itemNumber inGroup:(NSInteger)groupNumber{

    UIViewController *vc = [[UIViewController alloc]init];
    MADrawerPlainCell *item = (MADrawerPlainCell*)sender;

    vc.title = item.itemLabel.text;

    if(itemNumber==0 ){
        vc.view.backgroundColor = [UIColor greenColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (itemNumber==1){
        vc.view.backgroundColor = [UIColor blueColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (itemNumber==2){
        vc.view.backgroundColor = [UIColor purpleColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        vc.view.backgroundColor = [UIColor cyanColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
```

## Advice For Proper Integration

1.	Don’t forget to embed your View Controller in a Navigation Controller.
2.	Rather than adding the drawer manager in your `viewDidLoad` method, add it in your `viewWillAppear` method.
3.	Don’t forget to implement the required delegate method.


## Credit
Developed by [BrainStation-23](http://www.brainstation-23.com)

## Contributor
[Mahjabin Alam](https://github.com/mahjabinalam)

## License
This application is released under the [**MIT License**](http://www.opensource.org/licenses/MIT)
