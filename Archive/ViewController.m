//
//  ViewController.m
//  Archive
//
//  Created by roya-7 on 15/4/14.
//  Copyright (c) 2015年 化召鹏. All rights reserved.
//

#import "ViewController.h"
#import "ZipArchive.h"
#import "NSString+FilePath.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    //可以在沙盒根目录拖入一个文件夹,进行测试
    NSString *myDirectory = [@"" filePathOfDocuments];
    NSString *zipPath=[@"test.zip" filePathOfCaches];
//    NSArray *d=[fileManager directoryContentsAtPath:myDirectory];
    NSArray *file = [fileManager subpathsOfDirectoryAtPath: myDirectory error:nil];
    ZipArchive* zipFile = [[ZipArchive alloc] init];
    [zipFile CreateZipFile2:[@"test.zip" filePathOfCaches]];
//    bRet = [zip CreateZipFile2:sZipPath];
    for (NSString *str in file) {
        NSLog(@"%@",str);
        
        NSString *lastStr=[str lastPathComponent];
        
        if (lastStr &&lastStr.length>0 && [[lastStr substringToIndex:1] isEqualToString:@"."]) {
            //过滤隐藏文件,如.svn等
            continue;
        }
        NSString *path=[myDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@",str]];
        BOOL rec=NO;
        
        [fileManager fileExistsAtPath:path isDirectory:&rec];
        if (rec) {
            //要过滤掉文件夹,因为获取到的数组中包含本身文件夹的对象
            continue;
        }
        NSLog(@"%@,%@",path,rec?@"文件夹":@"文件");
//        if (rec) {
//            [str stringByAppendingString:@"/"];
//        }
        BOOL rect=[zipFile addFileToZip:path newname:str];
        NSLog(@"添加%@",rect?@"成功":@"失败");
    }
    [zipFile CloseZipFile2];
//    [zipFile ];
}
@end
