//
//  RSAEncryptor.h
//  RSATEST
//
//  Created by PacteraLF on 16/10/17.
//  Copyright © 2016年 PacteraLF. All rights reserved.
// RSA 加密封装类

#import <Foundation/Foundation.h>

@interface RSAObjC : NSObject

/**
 * -------RSA 字符串公钥加密-------
 @param plaintext 明文，待加密的字符串
 @param pubKey 公钥字符串
 @return 密文，加密后的字符串
 */
+ (NSString *)encrypt:(NSString *)plaintext PublicKey:(NSString *)pubKey;

/**
 * -------RSA Der 文件公钥加密-------
 @param plaintext 明文，待加密的字符串
 @param path .der 格式的公钥文件路径
 @return 密文，加密后的字符串
 */
+ (NSString *)encrypt:(NSString *)plaintext DerFilePath:(NSString *)path;

/**
 * -------RSA 字符串私钥解密-------
 @param ciphertext 密文，需要解密的字符串
 @param privKey 私钥字符串
 @return 明文，解密后的字符串
 */
+ (NSString *)decrypt:(NSString *)ciphertext PrivateKey:(NSString *)privKey;

/**
 * -------RSA Der 文件私钥解密-------
 @param ciphertext 密文，需要解密的字符串
 @param path .der 格式的私钥文件路径
 @param pwd 私钥文件的密码
 @return 明文，解密后的字符串
 */
+ (NSString *)decrypt:(NSString *)ciphertext DerFilePath:(NSString *)path DerPwd:(NSString *)pwd;


@end
