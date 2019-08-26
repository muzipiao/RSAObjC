[![CI Status](https://img.shields.io/travis/muzipiao/RSAObjC.svg?style=flat)](https://travis-ci.org/muzipiao/RSAObjC)
[![codecov](https://codecov.io/gh/muzipiao/RSAObjC/branch/master/graph/badge.svg)](https://codecov.io/gh/muzipiao/RSAObjC)
[![Version](https://img.shields.io/cocoapods/v/RSAObjC.svg?style=flat)](https://cocoapods.org/pods/RSAObjC)
[![License](https://img.shields.io/cocoapods/l/RSAObjC.svg?style=flat)](https://cocoapods.org/pods/RSAObjC)
[![Platform](https://img.shields.io/cocoapods/p/RSAObjC.svg?style=flat)](https://cocoapods.org/pods/RSAObjC)

RSA 可以说是 iOS 端使用最多最广泛的**非对称加密算法**了，虽然近年来国家基于安全和宏观战略考虑，推出我国自主知识产权的**非对称加密算法** SM2，但使用率和广泛性还远远不及 RSA，国密 SM2 加解密参考另一项目  [GMObjC](https://github.com/muzipiao/GMObjC)。

## 快速开始

在终端运行以下命令，可查看 Demo:

```ruby
git clone https://github.com/muzipiao/RSAObjC.git

cd RSAObjC/Example

pod install

open RSAObjC.xcworkspace
```

## 集成

### CocoaPods

CocoaPods 是最简单方便的集成方法，编辑 Podfile 文件，添加

```ruby
pod 'RSAObjC'
```

然后执行 `pod install` 即可。

### 直接集成

从 Git 下载最新代码，找到和 README 同级的 RSAObjC 文件夹，将 RSAObjC 文件夹拖入项目，并在项目中添加 Security.framework 框架，在需要使用的地方导入头文件 `RSAObjC.h` 即可使用 RSA 加解密。

## 用法

最常用的就是后台返回公钥字符串，加密密码后返回给后台，使用工具类加解密都很简单。

```objc
//----------------------RSA 加密示例------------------------
// 原始数据，要加密的字符串
NSString *originalString = @"这是一段将要使用'秘钥字符串'进行加密的字符串!";

// RSA 加密，使用字符串格式的公钥私钥加密解密, RSAPublickKey  为公钥字符串(NSString 格式)
NSString *encryptStr = [RSAObjC encrypt:originalString PublicKey:RSAPublickKey];
NSLog(@"加密后:%@", encryptStr);

// RSA 解密，用私钥解密，RSAPrivateKey 为私钥字符串(NSString 格式)
NSString *decryptStr = [RSAObjC decrypt:encryptStr PrivateKey:RSAPrivateKey];
NSLog(@"解密后:%@",decryptStr);
```

## 其他

RSA 加密在 iOS 中经常用到，麻烦的方法是使用 openssl 生成所需秘钥文件，需要用到 .der 和 .p12 后缀格式的文件，其中 .der 格式的文件存放的是公钥（Public key）用于加密，.p12 格式的文件存放的是私钥（Private key）用于解密。

公钥和私钥的关系，有人形象的把公钥比喻为保险箱，把私钥比喻为保险箱的钥匙，保险箱我可以给任何人，也可以有多个保险箱，任何人都可以往保险箱里面放东西(机密数据)，但只有我有私钥(保险箱的钥匙)，只有我能打开保险箱。

### 常用场景

最常见的场景就是客户端向服务端上送密码的场景，客户端先从服务端获取公钥，加密密码后上送。

![常用场景](https://raw.githubusercontent.com/muzipiao/GitHubImages/master/RSAImage/RSAImg2.png)

如下一个密码校验流程，iPhone 表示客户端， Server 表示服务端。

```sequence
iPhone->Server: 客户端向服务请求 RSA 公钥
Server: 服务端保留 RSA 私钥
Server-->iPhone: 服务端将 RSA 公钥发送给客户端
iPhone: 客户端使用 RSA 公钥加密密码
iPhone->Server: 客户端将加密后的密文发送给服务器
Server: 服务端使用 RSA 私钥解密校验密码
Server-->iPhone: 服务端将密码校验结果发送给客户端
```

### 关于特殊字符网络传输转义的问题

这是一串服务器生成的 RSA 公钥，可以看到由z数字字母及 `+/` 组成。

```
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTbZ6cNH9
PgdF60aQKveLz3FTalyzHQwbp601y77SzmGHX3F5NoVUZbd
K7UMdoCLK4FBziTewYD9DWvAErXZo9BFuI96bAop8wfl1Vk
ZyyHTcznxNJFGSQd/B70/ExMgMBpEwkAAdyUqIjIdVGh1FQ
K/4acwS39YXwbS+IlHsPSQIDAQAB
```

由于含有`/+=\n`等特殊字符串，网络传输过程中导致转义，进而导致加解密不成功，解决办法是进行 URL 特殊符号编码解码（百分号转义），如下所示，将除字母数字外，全部进行 URLEncode 编码。

```objc 
/**
 * self.gPubkey 是如上所示公钥
 * alphanumericCharacterSet 表示字母数字字符集
 */
NSString *encodePubKey = [self.gPubkey stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.alphanumericCharacterSet];

// 解码更简单，stringByRemovingPercentEncoding 即可 URLDecode
NSString *decodePubKey = encodePubKey.stringByRemovingPercentEncoding;
```

编码后如下所示，除了字母数字外，其他符号都变成了 URLEncode 形式，解码后和原文相同。

```
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTbZ6cNH9
PgdF60aQKveLz3FTalyzHQwbp601y77SzmGHX3F5NoVUZbdK7U
MdoCLK4FBziTewYD9DWvAErXZo9BFuI96bAop8wfl1VkZyyHTczn
xNJFGSQd%2FB70%2FExMgMBpEwkAAdyUqIjIdVGh1FQK%2F4
acwS39YXwbS%2BIlHsPSQIDAQAB
```

### OpenSSL 生成公私钥

在 Mac 上使用 OpenSSL 生成公私钥测试，位数可选 1024、2048、4096 等，位数越大，生成的公私钥越长，安全性越高，但加解密速度也会越慢。注意，如果传入 PEM 格式公私钥，私钥必须为 PKCS8 格式。

```ruby
# 生成 2048 位 RSA 私钥
openssl genrsa -out rsa_private_key.pem 2048

# 生成成对的 2048 位 RSA 公钥
openssl rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem

# 将 RSA 私钥转换为 PKCS8 格式
openssl pkcs8 -topk8 -inform PEM -in rsa_private_key.pem -outform PEM -nocrypt > rsa_private_key_pkcs8.pem
```
然后就可以使用公钥文件 rsa_public_key.pem 和私钥文件 rsa_private_key_pkcs8.pem 进行加解密了。

如果您觉得有所帮助，请在 [GitHub RSAObjC](https://github.com/muzipiao/RSAObjC) 上赏个Star ⭐️，您的鼓励是我前进的动力
