//
//  DetailViewController.m
//  AddressBook0739
//
//  Created by lanouhn on 15/9/14.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailView.h"
#import "ContactListViewController.h"
@interface DetailViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic,retain) UIImageView *imageView;

@end

@implementation DetailViewController

//重写loadView 指定视图控制器的根视图
- (void)loadView {
    [super loadView];
    
    DetailView *detail = [[DetailView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    detail.photoView.image = [UIImage imageNamed:self.contact.photo];
    detail.nameTF.text = self.contact.name;
    detail.genderTF.text = self.contact.gender;
    detail.phoneNumTF.text = self.contact.phoneNum;
    self.view = detail;
    [detail release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizednaviBar];
    [self setNotEnable];//设置进入后控件处于不可编辑状态
    [self addTapGesture];//给头像添加轻拍手势
}

//设置不能编辑
- (void)setNotEnable {
    DetailView *detail = (DetailView *)self.view;
    detail.userInteractionEnabled = NO;
}


//配置导航条属性
- (void)customizednaviBar {
    self.navigationItem.title = @"详情";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_navigationBar_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(handleBack:)] autorelease];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//左button的点击事件   点击返回到列表界面
- (void)handleBack:(UIBarButtonItem *)item {
    ContactListViewController *contactVC = [[ContactListViewController alloc] init];
    [self.navigationController pushViewController:contactVC animated:YES];
    [contactVC release];
}

//设置编辑状态(当使用了系统的Edit时  需要重写此方法)
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    //editing  Edit --- YES（点Edit后 editing的值为YES）  Done  --- NO（点Done后 editing的值为NO）
    [super setEditing:editing animated:animated];
    //输入框进入编辑状态
    //1.
    /*
    if (editing) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
     */
    //2.
    self.view.userInteractionEnabled = editing;
    //点击Done之后 更新内容  !editing 表示编辑完成
    if (!editing) {
        [self updateData];//更新数据
    }
    
    
}

//更新数据
- (void)updateData {
    DetailView *detail = (DetailView *)self.view;
    
    self.contact.name = detail.nameTF.text;
    self.contact.gender = detail.genderTF.text;
    self.contact.phoneNum = detail.phoneNumTF.text;
    self.contact.photoVW = detail.photoView.image;
}

//添加手势的方法
- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hanleTap:)];
    //将手势添加到联系人头像上
    [((DetailView *)self.view).photoView addGestureRecognizer:tap];
    [tap release];
}

//设置或修改头像
- (void)hanleTap:(UITapGestureRecognizer *)tap {
    NSLog(@"别点我");
    //调用系统相机或者图库
    //在这里呼出下方菜单按钮项
    UIActionSheet *myActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
    [myActionSheet showInView:self.view];
    [myActionSheet release];

}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }else{
        //相机可用时初始化 pikerController为UIImagePickerControllerSourceTypeCamera
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        switch (buttonIndex)
        {
            case 0:  //打开照相机拍照
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
                
            case 1:  //打开本地相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
        }
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            //如果源类型 UIImagePickerControllerSourceTypeCamera 不可用时 设置UIImagePickerControllerSourceTypePhotoLibrary 为源类型
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];//进入照相界面或相册界面
        [picker release];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    DetailView *detail = (DetailView *)self.view;
    detail.photoView.image = [info objectForKey:UIImagePickerControllerEditedImage];//use编辑后的照片；
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.contact = nil;
    [super dealloc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
