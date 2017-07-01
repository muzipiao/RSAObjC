//
//  NSString+Encode.m
//
//  Created by PacteraLF on 17/1/12.
//
//

#import "NSString+Encode.h"

@implementation NSString (Encode)



#pragma mark - Base64编码
/**
 *  对字符串进行base64编码
 *  @return 返回编码之后的字符串
 */
- (NSString *)base64Encode
{
    if(self == nil || [self length] == 0){
        return @"";
    }
    // 编码是针对二进制数据的
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    // 对字符串的二进制数据进行Base64编码,返回编码之后的字符串
    NSString *result = [data base64EncodedStringWithOptions:0];
    
    return result;
}

#pragma mark - Base64解码
/**
 *  对编码之后的字符串进行解码
 *  @return 返回解码之后的字符串
 */
- (NSString *)base64Decode
{
    // 提示 : 不能对空字符串解码
    if(self == nil || [self length] == 0){
        return @"";
    }
    
    // 把编码之后的字符串解码成二进制
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    // 把解码之后的二进制转成解码之后的字符串
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"ree = %@",result);
    
    return result;
}


/**
 url编码
 
 @param characterSetStr 需要转义的特殊字符，例如@"/+=\n"
 @return 返回编码后的字符串
 */
-(NSString *)urlEncodeWithCharacterSet:(NSString *)characterSetStr{
    if(self == nil || [self length] == 0){
        return @"";
    }
    
    //设置需要转义的特殊字符，例如@"/+=\n"
    NSCharacterSet *URLBase64CharacterSet = [[NSCharacterSet characterSetWithCharactersInString:characterSetStr] invertedSet];
    //返回转义后的字符串
    return [self stringByAddingPercentEncodingWithAllowedCharacters:URLBase64CharacterSet];
}


/**
 url解码
 
 @return 解码后字符串
 */
-(NSString *)urlDecode{
    if(self == nil || [self length] == 0){
        return @"";
    }
    
    return self.stringByRemovingPercentEncoding;
}


@end
