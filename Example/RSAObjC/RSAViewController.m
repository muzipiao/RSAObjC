//
//  RSAViewController.m
//  RSAObjC
//
//  Created by 李飞 on 08/24/2019.
//  Copyright (c) 2019 李飞. All rights reserved.
//

#import "RSAViewController.h"
#import "RSAObjC.h"

@interface RSAViewController ()

@property (nonatomic, copy) NSString *gPwd;
@property (nonatomic, copy) NSString *gPubkey; // 公钥
@property (nonatomic, copy) NSString *gPrikey; // 私钥
@property (nonatomic, strong) UITextView *gTextView; // 显示

@end

@implementation RSAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.gTextView = [[UITextView alloc]initWithFrame:self.view.bounds];
    self.gTextView.editable = NO;
    self.gTextView.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:self.gTextView];
    self.gPwd = @"123456";  // 测试用密码
    [self initValues]; // 初始化公私钥
    [self testRSAEncrypt];    // 测试 RSA 加解密
}

- (void)testRSAEncrypt{
    // RSA 加密
    NSString *encryptStr = [RSAObjC encrypt:self.gPwd PublicKey:self.gPubkey];
    // RSA 解密
    NSString *decryptStr = [RSAObjC decrypt:encryptStr PrivateKey:self.gPrikey];
    
    NSMutableString *mStr = [NSMutableString stringWithString:self.gTextView.text];
    [mStr appendFormat:@"\nRSA公钥：\n%@\nRSA私钥：\n%@\nRSA加密密文：\n%@\nRSA解密结果：\n%@", self.gPubkey, self.gPrikey, encryptStr, decryptStr];
    self.gTextView.text = mStr;
}

- (void)initValues{
    /*
     * 在线获取任意的公钥私钥字符串http://www.bm8.com.cn/webtool/rsa/
     * 注意：由于公钥私钥里面含有`/+=\n`等特殊字符串
     * 网络传输过程中导致转义，进而导致加密解密不成功，
     * 解决办法是传输前进行 URL 特殊符号编码解码(URLEncode 百分号转义)
     */
    self.gPubkey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTbZ6cNH9PgdF60aQKveLz3FTalyzHQwbp601y77SzmGHX3F5NoVUZbdK7UMdoCLK4FBziTewYD9DWvAErXZo9BFuI96bAop8wfl1VkZyyHTcznxNJFGSQd/B70/ExMgMBpEwkAAdyUqIjIdVGh1FQK/4acwS39YXwbS+IlHsPSQIDAQAB";
    //私钥
    self.gPrikey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANNtnpw0f0+B0XrRpAq94vPcVNqXLMdDBunrTXLvtLOYYdfcXk2hVRlt0rtQx2gIsrgUHOJN7BgP0Na8AStdmj0EW4j3psCinzB+XVWRnLIdNzOfE0kUZJB38HvT8TEyAwGkTCQAB3JSoiMh1UaHUVAr/hpzBLf1hfBtL4iUew9JAgMBAAECgYA1tGeQmAkqofga8XtwuxEWDoaDS9k0+EKeUoXGxzqoT/GyiihuIafjILFhoUA1ndf/yCQaG973sbTDhtfpMwqFNQq13+JAownslTjWgr7Hwf7qplYW92R7CU0v7wFfjqm1t/2FKU9JkHfaHfb7qqESMIbO/VMjER9o4tEx58uXDQJBAO0O4lnWDVjr1gN02cqvxPOtTY6DgFbQDeaAZF8obb6XqvCqGW/AVms3Bh8nVlUwdQ2K/xte8tHxjW9FtBQTLd8CQQDkUncO35gAqUF9Bhsdzrs7nO1J3VjLrM0ITrepqjqtVEvdXZc+1/UrkWVaIigWAXjQCVfmQzScdbznhYXPz5fXAkEAgB3KMRkhL4yNpmKRjhw+ih+ASeRCCSj6Sjfbhx4XaakYZmbXxnChg+JB+bZNz06YBFC5nLZM7y/n61o1f5/56wJBALw+ZVzE6ly5L34114uG04W9x0HcFgau7MiJphFjgUdAtd/H9xfgE4odMRPUD3q9Me9LlMYK6MiKpfm4c2+3dzcCQQC8y37NPgpNEkd9smMwPpSEjPW41aMlfcKvP4Da3z7G5bGlmuICrva9YDAiaAyDGGCK8LxC8K6HpKrFgYrXkRtt";
    
    
    //----------------URL编码解码，解决特殊符号问题----------------
    // 服务器传输过来的公钥字符串可能是这样的
    NSString *RSAPublickKeyFromServer = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTbZ6cNH9PgdF60aQKveLz3FTalyzHQwbp601y77SzmGHX3F5NoVUZbdK7UMdoCLK4FBziTewYD9DWvAErXZo9BFuI96bAop8wfl1VkZyyHTcznxNJFGSQd%2FB70%2FExMgMBpEwkAAdyUqIjIdVGh1FQK%2F4acwS39YXwbS%2BIlHsPSQIDAQAB";
    // RSAPublickKeyFromServer URLDecode解码后应该和 gPubkey 相同
    NSString *urlDecodePublicKey = RSAPublickKeyFromServer.stringByRemovingPercentEncoding;
    if ([urlDecodePublicKey isEqualToString:self.gPubkey]) {
        NSLog(@"解码后和标准公钥一致");
    }else{
        NSLog(@"解码后和标准公钥不一致");
    }
    // URLEncode，除数字字母外的符号都进行 URLEncode
    NSString *urlEncodePublicKey = [self.gPubkey stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.alphanumericCharacterSet];
    if ([urlEncodePublicKey isEqualToString:RSAPublickKeyFromServer]) {
        NSLog(@"编码后和服务器传过来的一致");
    }else{
        NSLog(@"编码后和服务器传过来的不一致");
    }
}

@end
