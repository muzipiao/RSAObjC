//
//  ViewController.m
//  RSAEncrypt
//
//  Created by PacteraLF on 16/10/17.
//  Copyright © 2016年 PacteraLF. All rights reserved.
//

#import "ViewController.h"
#import "RSAEncryptor.h"
#import "NSString+Encode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     在线获取任意的公钥私钥字符串http://www.bm8.com.cn/webtool/rsa/
     注意：由于公钥私钥里面含有`/+=\n`等特殊字符串，网络传输过程中导致转义，进而导致加密解密不成功，解决办法是传输前进行URL特殊符号编码解码(百分号转义)
     */
    //公钥
    NSString *RSAPublickKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTbZ6cNH9PgdF60aQKveLz3FTalyzHQwbp601y77SzmGHX3F5NoVUZbdK7UMdoCLK4FBziTewYD9DWvAErXZo9BFuI96bAop8wfl1VkZyyHTcznxNJFGSQd/B70/ExMgMBpEwkAAdyUqIjIdVGh1FQK/4acwS39YXwbS+IlHsPSQIDAQAB";
    //私钥
    NSString *RSAPrivateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANNtnpw0f0+B0XrRpAq94vPcVNqXLMdDBunrTXLvtLOYYdfcXk2hVRlt0rtQx2gIsrgUHOJN7BgP0Na8AStdmj0EW4j3psCinzB+XVWRnLIdNzOfE0kUZJB38HvT8TEyAwGkTCQAB3JSoiMh1UaHUVAr/hpzBLf1hfBtL4iUew9JAgMBAAECgYA1tGeQmAkqofga8XtwuxEWDoaDS9k0+EKeUoXGxzqoT/GyiihuIafjILFhoUA1ndf/yCQaG973sbTDhtfpMwqFNQq13+JAownslTjWgr7Hwf7qplYW92R7CU0v7wFfjqm1t/2FKU9JkHfaHfb7qqESMIbO/VMjER9o4tEx58uXDQJBAO0O4lnWDVjr1gN02cqvxPOtTY6DgFbQDeaAZF8obb6XqvCqGW/AVms3Bh8nVlUwdQ2K/xte8tHxjW9FtBQTLd8CQQDkUncO35gAqUF9Bhsdzrs7nO1J3VjLrM0ITrepqjqtVEvdXZc+1/UrkWVaIigWAXjQCVfmQzScdbznhYXPz5fXAkEAgB3KMRkhL4yNpmKRjhw+ih+ASeRCCSj6Sjfbhx4XaakYZmbXxnChg+JB+bZNz06YBFC5nLZM7y/n61o1f5/56wJBALw+ZVzE6ly5L34114uG04W9x0HcFgau7MiJphFjgUdAtd/H9xfgE4odMRPUD3q9Me9LlMYK6MiKpfm4c2+3dzcCQQC8y37NPgpNEkd9smMwPpSEjPW41aMlfcKvP4Da3z7G5bGlmuICrva9YDAiaAyDGGCK8LxC8K6HpKrFgYrXkRtt";
    
    
    //----------------URL编码解码，解决特殊符号问题----------------
    //服务器传输过来的公钥字符串是这个样子的
    NSString *RSAPublickKeyFromServer = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTbZ6cNH9PgdF60aQKveLz3FTalyzHQwbp601y77SzmGHX3F5NoVUZbdK7UMdoCLK4FBziTewYD9DWvAErXZo9BFuI96bAop8wfl1VkZyyHTcznxNJFGSQd%2FB70%2FExMgMBpEwkAAdyUqIjIdVGh1FQK%2F4acwS39YXwbS%2BIlHsPSQIDAQAB";
    
    //经过URL解码后和RSAPublickKey一样
    NSString *urlDecodePublicKey = RSAPublickKeyFromServer.urlDecode;
    if ([urlDecodePublicKey isEqualToString:RSAPublickKey]) {
        NSLog(@"解码后和公钥一致");
    }else{
        NSLog(@"解码后和公钥不一致");
    }
    //测试一下编码
    NSString *urlEncodePublicKey = [RSAPublickKey urlEncodeWithCharacterSet:@"/+=\n"];
    if ([urlEncodePublicKey isEqualToString:RSAPublickKeyFromServer]) {
        NSLog(@"编码后和服务器传过来的一致");
    }else{
        NSLog(@"编码后和服务器传过来的不一致");
    }
    
    //----------------------RSA加密示例------------------------
    //原始数据，要加密的字符串
    NSString *originalString = @"这是一段将要使用'秘钥字符串'进行加密的字符串!";
    
    //使用字符串格式的公钥私钥加密解密
    NSString *encryptStr = [RSAEncryptor encryptString:originalString publicKey:RSAPublickKey];
    
    NSLog(@"加密前:%@", originalString);
    NSLog(@"加密后:%@", encryptStr);
    //用私钥解密
    NSString *decryptString = [RSAEncryptor decryptString:encryptStr privateKey:RSAPrivateKey];
    
    NSLog(@"解密后:%@",decryptString);
    
}

@end
