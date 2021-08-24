
<!--# quec-app-advanced-baidu-map-->

## 网络请求SDK

### 一、组件功能列表

|功能	|功能说明	|实现版本	|微服务版本号|
| --- | --- | --- | --- |
|网络请求相关	| 常见接口请求、文件上传、文件下载 |	1.0.0	| |


### 二、设计接口/属性


### QuecNetworkManager 属性

|Prop	|Type	|是否必填	|Description| Remarks |
|  ----  | ----  |  ----  | ----  | ----  |
|timeoutInterval	|NSInteger|	否	|请求超时时间，默认是30s||
|baseUrl|	NSString 	| 否	|base url | |
|httpHeaderFields	|NSDictionary	|否	|http headers|  |


### QuecNetworkManager 方法

#### 获取单例对象
```
+ (instancetype)shared;

```

#### 获取网络连接状态
```
+ (BOOL)networkEnable;

```

#### 设置 Http Header

```
- (void)setHttpHeaderWithKey:(NSString *)key value:(NSString *)value

```

|参数|	说明|	
| --- | --- | 
|key|	Http Header key，如 “Content-Type”	| 
|value|	Http Header value，如 “application/json”	| 

#### 接口请求

```
- (void)requestWithUrlString:(NSString *)urlString params:(NSDictionary *)params requestType:(QuecNetworkRequestType)requestType success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure

```

|参数|	说明|	
| --- | --- | 
| urlString |	请求地址，如果不是完整的地址将自动添加 baseUrl	| 
| params |	请求参数	| 
| requestType |	请求类型，GET、POST、PUT、DELETE	| 
| success |	接口请求成功回调	| 
| failure |	接口请求失败回调	| 

#### 文件上传

```
- (void)requestUploadDataWithUrlString:(NSString *)urlString params:(NSDictionary *)params data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure

```

|参数|	说明|	
| --- | --- | 
| urlString |	请求地址，如果不是完整的地址将自动添加 baseUrl	| 
| params |	请求参数	| 
| data |	文件数据	| 
| name |	和 data 关联的文件名称	| 
| fileName |	和 data 关联的文件名称	| 
| mimeType |	data 类型，如 multipart/form-data，image/jpeg	| 
| success |	接口请求成功回调	| 
| failure |	接口请求失败回调	| 

#### 文件下载

```
- (void)requestDownLoadDataWithUrlString:(NSString *)urlString filePath:(NSString *)filePath progress:(void(^)(NSProgress *progress))progress success:(void(^)(NSString *filePath))success failure:(void(^)(NSError *error))failure;

```

|参数|	说明|	
| --- | --- | 
| urlString |	请求地址，如果不是完整的地址将自动添加 baseUrl	| 
| filePath |	文件存储路径	| 
| progress |	下载进度	| 
| success |	接口请求成功回调	| 
| failure |	接口请求失败回调	| 


#### 设置拦截器

```
- (void)setInterceptor:(id <QuecNetworkInterceptProtocol>)interceptor

```

|参数|	说明|	
| --- | --- | 
| interceptor |	遵循拦截器协议的对象	| 



#### 拦截器协议

```
@protocol QuecNetworkInterceptProtocol <NSObject>

@required
- (NSInteger)interceptCode;
- (void)notifIntercepted;

@end
```

#### 获取当前网络状态

```
typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
    AFNetworkReachabilityStatusUnknown          = -1,
    AFNetworkReachabilityStatusNotReachable     = 0,
    AFNetworkReachabilityStatusReachableViaWWAN = 1,
    AFNetworkReachabilityStatusReachableViaWiFi = 2,
};
- (AFNetworkReachabilityStatus)getNetworkStatus
```

#### 开启关闭网络监听

```

/**
 开启网络监听,开启监听以后，网络状态发生改变会发送通知 AFNetworkingReachabilityDidChangeNotification
 */
- (void)startMonitoring;

- (void)stopMonitoring;
```


## 三、使用步骤

### 集成

#### 使用 CocoaPods 快速集成

```
source 'https://github.com/BeHigher/IoTPublicSpeces.git'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      target.build_settings(config.name)['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
    end
  end
end

target 'Your_Project_Name' do
	pod "QuecNetworkChannelKit"
end
```

### 使用

```
[[QuecNetworkManager shared] requestWithUrlString:@"" params:@{} requestType:QuecNetworkRequestTypeGet success:^(NSDictionary * _Nonnull response) {
            
        } failure:^(NSError * _Nonnull error) {
            
        }];
        
```

### 具体API用法可以参考[demo](http://192.168.23.184:8108/frontend/app/business/quec-app-business-baidu-map-demo)。