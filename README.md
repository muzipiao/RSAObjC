[![CI Status](https://img.shields.io/travis/muzipiao/RSAObjC.svg?style=flat)](https://travis-ci.org/muzipiao/RSAObjC)
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

RSA加密在iOS中经常用到，麻烦的方法是使用openssl生成所需秘钥文件，需要用到.der和.p12后缀格式的文件，其中.der格式的文件存放的是公钥（Public key）用于加密，.p12格式的文件存放的是私钥（Private key）用于解密。至于公钥和私钥的关系，有人形象的把公钥比喻为保险箱，把私钥比喻为保险箱的钥匙，保险箱我可以给任何人，也可以有多个保险箱，任何人都可以往保险箱里面放东西(机密数据)，但只有我有私钥(保险箱的钥匙)，只有我能打开保险箱。

### 常见使用场景(客户端加密`用户密码/交易密码`发送给服务器)：

客户端向服务器请求`RSA公钥`----->`服务器`----->返给客户端一个`NSString`格式的RSA公钥----->客户端用`RSA公钥字符串`加密`密码`发送给服务器----->服务器用RSA私钥解密并核对`密码`----->核对密码是否正确，并返回客户数据给客户端。

![RSA序列图](https://raw.githubusercontent.com/muzipiao/GitHubImages/master/RSAImage/RSAImg2.png)

### 关于特殊字符网络传输转义的问题

这是一串服务器生成的 RSA 公钥

> MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTbZ6cNH9
> PgdF60aQKveLz3FTalyzHQwbp601y77SzmGHX3F5NoVUZbd
> K7UMdoCLK4FBziTewYD9DWvAErXZo9BFuI96bAop8wfl1Vk
> ZyyHTcznxNJFGSQd/B70/ExMgMBpEwkAAdyUqIjIdVGh1FQ
> K/4acwS39YXwbS+IlHsPSQIDAQAB

但由于含有`/+=\n`等特殊字符串，网络传输过程中导致转义，进而导致加密解密不成功，解决办法是进行 URL 特殊符号编码解码(百分号转义)；具体示例，在 Demo 中有示例。

如果您觉得有所帮助，请在 [GitHub RSAObjC](https://github.com/muzipiao/RSAObjC) 上赏个Star ⭐️，您的鼓励是我前进的动力
