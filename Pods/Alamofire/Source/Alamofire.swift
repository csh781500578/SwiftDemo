//
//  Alamofire.swift
//
//  Copyright (c) 2014-2018 Alamofire Software Foundation (http://alamofire.org/)
//
//在此，我们免费向任何获得副本的人提供许可
//本软件及其相关文档文件(下称“软件”)，以供处理
//在软件中不受限制，包括但不限于权利
//使用、复制、修改、合并、发布、分发、再许可和/或出售
//“软件”的副本，并允许“软件”的所有人使用
//提供这样做，但须符合下列条件:
//
//上述版权公告及本许可公告均应包括在内
//软件的所有拷贝或大部分。
//
//软件是“按原样”提供的，没有任何形式的明示或明示的保证
//默示，包括但不限于适销性保证，
//适用于特定目的和不侵权。在任何情况下都不能
//作者或版权持有者对任何索赔、损害赔偿或其他责任
//责任，无论在合同诉讼、侵权诉讼或其他诉讼中，
//脱离或与软件或使用或其他交易有关
//软件。
//

import Foundation

///全局命名空间，包含“默认”“会话”实例的API。
public enum AF {
    ///当前的Alamofire版本。必要的，因为SPM不使用动态库。加上这个会更准确。
    static let version = "5.0.0-rc.3"

    //标记:-数据请求
        
    ///使用“Session.default”创建一个“DataRequest”来检索指定的“url”的内容
    /// '方法'，'参数'，'编码'，和'头'提供。
    ///
    /// -参数:
    /// - url: ' URLConvertible '值。
    /// -方法:' HTTPMethod '， '。默认情况下得到的。
    /// -参数:' parameters '， ' nil '默认。
    /// -编码:' ParameterEncoding '， ' URLEncoding.default '默认。
    /// - header: ' HTTPHeaders '， ' nil '默认。
    /// -拦截器:默认为‘RequestInterceptor’，‘nil’。
    ///
    /// -返回:创建的“DataRequest”。
    public static func request(_ url: URLConvertible,
                               method: HTTPMethod = .get,
                               parameters: Parameters? = nil,
                               encoding: ParameterEncoding = URLEncoding.default,
                               headers: HTTPHeaders? = nil,
                               interceptor: RequestInterceptor? = nil) -> DataRequest {
        return Session.default.request(url,
                                       method: method,
                                       parameters: parameters,
                                       encoding: encoding,
                                       headers: headers,
                                       interceptor: interceptor)
    }

    /// Creates a ' DataRequest ' using ' Session.默认' to retrieve ' the special ' url ' using the
    ///“方法”、“parameters”、“encoding”和“headers”提供。
    ///
    /// / - Parameters: url: url敞篷车价值。- HTTPMethod。默认完成。
    /// - parameters:默认情况下的“Encodable”parameters。
    /// -编码:
    /// -标题:默认的“httpheder”，“nil”。 拦截器:默认的“拦截器”，默认的“零”。
    /// 创造“约会”。
    public static func request<Parameters: Encodable>(_ url: URLConvertible,
                                                      method: HTTPMethod = .get,
                                                      parameters: Parameters? = nil,
                                                      encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
                                                      headers: HTTPHeaders? = nil,
                                                      interceptor: RequestInterceptor? = nil) -> DataRequest {
        return Session.default.request(url,
                                       method: method,
                                       parameters: parameters,
                                       encoder: encoder,
                                       headers: headers,
                                       interceptor: interceptor)
    }

    ///使用Session.default创建一个' DataRequest '来执行指定的' urlRequest '。
    ///
    /// -参数:
    /// - urlRequest: ' URLRequestConvertible '的值。
    /// -拦截器:默认为‘RequestInterceptor’，‘nil’。
    ///
    /// -返回:创建的“DataRequest”。
    public static func request(_ urlRequest: URLRequestConvertible, interceptor: RequestInterceptor? = nil) -> DataRequest {
        return Session.default.request(urlRequest, interceptor: interceptor)
    }

    //标记:-下载请求
    
    ///创建一个' DownloadRequest '，使用' Session.default '将指定的' url '的内容下载到
    ///提供的“目的地”使用“方法”，“参数”，“编码”，和“头”提供。
    ///
    ///如果没有指定“destination”，下载将被移动到Alamofire确定的临时位置。
    ///
    /// -参数:
    /// - url: ' URLConvertible '值。
    /// -方法:' HTTPMethod '， '。默认情况下得到的。
    /// -参数:' parameters '， ' nil '默认。
    /// -编码:' ParameterEncoding '， ' URLEncoding.default '默认。
    /// - header: ' HTTPHeaders '， ' nil '默认。
    /// -拦截器:默认为‘RequestInterceptor’，‘nil’。
    /// -下载请求。“目的地”的闭包使用“确定目的地”的
    ///下载文件。默认“零”。
    ///
    /// -返回:创建的“下载请求”。
    public static func download(_ url: URLConvertible,
                                method: HTTPMethod = .get,
                                parameters: Parameters? = nil,
                                encoding: ParameterEncoding = URLEncoding.default,
                                headers: HTTPHeaders? = nil,
                                interceptor: RequestInterceptor? = nil,
                                to destination: DownloadRequest.Destination? = nil) -> DownloadRequest {
        return Session.default.download(url,
                                        method: method,
                                        parameters: parameters,
                                        encoding: encoding,
                                        headers: headers,
                                        interceptor: interceptor,
                                        to: destination)
    }

    ///创建一个' DownloadRequest '，使用' Session.default '将指定的' url '的内容下载到
    ///使用“方法”提供“目的地”，提供可编码的“参数”、“编码器”和“头文件”。
    ///
    /// -注意:如果没有指定“destination”，下载将被移动到由
    /// Alamofire。
    ///
    /// -参数:
    /// - url: ' URLConvertible '值。
    /// -方法:' HTTPMethod '， '。默认情况下得到的。
    /// -参数:“可编码的”参数，默认为“nil”。
    /// -编码器:' ParameterEncoder '， ' URLEncodedFormParameterEncoder.default '默认。
    /// - header: ' HTTPHeaders '， ' nil '默认。
    /// -拦截器:默认为‘RequestInterceptor’，‘nil’。
    /// -下载请求。“目的地”的闭包使用“确定目的地”的
    ///下载文件。默认“零”。
    ///
    /// -返回:创建的“下载请求”。
    public static func download<Parameters: Encodable>(_ url: URLConvertible,
                                                       method: HTTPMethod = .get,
                                                       parameters: Parameters? = nil,
                                                       encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
                                                       headers: HTTPHeaders? = nil,
                                                       interceptor: RequestInterceptor? = nil,
                                                       to destination: DownloadRequest.Destination? = nil) -> DownloadRequest {
        return Session.default.download(url,
                                        method: method,
                                        parameters: parameters,
                                        encoder: encoder,
                                        headers: headers,
                                        interceptor: interceptor,
                                        to: destination)
    }

    // MARK: URLRequest

    /// Creates a `DownloadRequest` using `Session.default` to execute the specified `urlRequest` and download
    /// the result to the provided `destination`.
    ///
    /// - Parameters:
    ///   - urlRequest:    The `URLRequestConvertible` value.
    ///   - interceptor:   The `RequestInterceptor`, `nil` by default.
    ///   - destination:   The `DownloadRequest.Destination` closure used the determine the destination of the
    ///                    downloaded file. `nil` by default.
    ///
    /// - Returns: The created `DownloadRequest`.
    public static func download(_ urlRequest: URLRequestConvertible,
                                interceptor: RequestInterceptor? = nil,
                                to destination: DownloadRequest.Destination? = nil) -> DownloadRequest {
        return Session.default.download(urlRequest, interceptor: interceptor, to: destination)
    }

    // MARK: Resume Data

    /// Creates a `DownloadRequest` using the `Session.default` from the `resumeData` produced from a previous
    /// `DownloadRequest` cancellation to retrieve the contents of the original request and save them to the `destination`.
    ///
    /// - Note: If `destination` is not specified, the download will be moved to a temporary location determined by
    ///         Alamofire.
    ///
    /// - Note: On some versions of all Apple platforms (iOS 10 - 10.2, macOS 10.12 - 10.12.2, tvOS 10 - 10.1, watchOS 3 - 3.1.1),
    /// `resumeData` is broken on background URL session configurations. There's an underlying bug in the `resumeData`
    /// generation logic where the data is written incorrectly and will always fail to resume the download. For more
    /// information about the bug and possible workarounds, please refer to the [this Stack Overflow post](http://stackoverflow.com/a/39347461/1342462).
    ///
    /// - Parameters:
    ///   - resumeData:    The resume `Data`. This is an opaque blob produced by `URLSessionDownloadTask` when a task is
    ///                    cancelled. See [Apple's documentation](https://developer.apple.com/documentation/foundation/urlsessiondownloadtask/1411634-cancel)
    ///                    for more information.
    ///   - interceptor:   The `RequestInterceptor`, `nil` by default.
    ///   - destination:   The `DownloadRequest.Destination` closure used to determine the destination of the downloaded
    ///                    file. `nil` by default.
    ///
    /// - Returns:         The created `DownloadRequest`.
    public static func download(resumingWith resumeData: Data,
                                interceptor: RequestInterceptor? = nil,
                                to destination: DownloadRequest.Destination? = nil) -> DownloadRequest {
        return Session.default.download(resumingWith: resumeData, interceptor: interceptor, to: destination)
    }

    // MARK: - Upload Request

    // MARK: Data

    /// Creates an `UploadRequest` for the given `Data`, `URLRequest` components, and `RequestInterceptor`.
    ///
    /// - Parameters:
    ///   - data:        The `Data` to upload.
    ///   - convertible: `URLConvertible` value to be used as the `URLRequest`'s `URL`.
    ///   - method:      `HTTPMethod` for the `URLRequest`. `.post` by default.
    ///   - headers:     `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///   - interceptor: `RequestInterceptor` value to be used by the returned `DataRequest`. `nil` by default.
    ///   - fileManager: `FileManager` instance to be used by the returned `UploadRequest`. `.default` instance by
    ///                  default.
    ///
    /// - Returns:       The created `UploadRequest`.
    public static func upload(_ data: Data,
                              to convertible: URLConvertible,
                              method: HTTPMethod = .post,
                              headers: HTTPHeaders? = nil,
                              interceptor: RequestInterceptor? = nil,
                              fileManager: FileManager = .default) -> UploadRequest {
        return Session.default.upload(data,
                                      to: convertible,
                                      method: method,
                                      headers: headers,
                                      interceptor: interceptor,
                                      fileManager: fileManager)
    }

    /// Creates an `UploadRequest` for the given `Data` using the `URLRequestConvertible` value and `RequestInterceptor`.
    ///
    /// - Parameters:
    ///   - data:        The `Data` to upload.
    ///   - convertible: `URLRequestConvertible` value to be used to create the `URLRequest`.
    ///   - interceptor: `RequestInterceptor` value to be used by the returned `DataRequest`. `nil` by default.
    ///   - fileManager: `FileManager` instance to be used by the returned `UploadRequest`. `.default` instance by
    ///                  default.
    ///
    /// - Returns:       The created `UploadRequest`.
    public static func upload(_ data: Data,
                              with convertible: URLRequestConvertible,
                              interceptor: RequestInterceptor? = nil,
                              fileManager: FileManager = .default) -> UploadRequest {
        return Session.default.upload(data, with: convertible, interceptor: interceptor, fileManager: fileManager)
    }

    // MARK: File

    /// Creates an `UploadRequest` for the file at the given file `URL`, using a `URLRequest` from the provided
    /// components and `RequestInterceptor`.
    ///
    /// - Parameters:
    ///   - fileURL:     The `URL` of the file to upload.
    ///   - convertible: `URLConvertible` value to be used as the `URLRequest`'s `URL`.
    ///   - method:      `HTTPMethod` for the `URLRequest`. `.post` by default.
    ///   - headers:     `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///   - interceptor: `RequestInterceptor` value to be used by the returned `UploadRequest`. `nil` by default.
    ///   - fileManager: `FileManager` instance to be used by the returned `UploadRequest`. `.default` instance by
    ///                  default.
    ///
    /// - Returns:       The created `UploadRequest`.
    public static func upload(_ fileURL: URL,
                              to convertible: URLConvertible,
                              method: HTTPMethod = .post,
                              headers: HTTPHeaders? = nil,
                              interceptor: RequestInterceptor? = nil,
                              fileManager: FileManager = .default) -> UploadRequest {
        return Session.default.upload(fileURL,
                                      to: convertible,
                                      method: method,
                                      headers: headers,
                                      interceptor: interceptor,
                                      fileManager: fileManager)
    }

    /// Creates an `UploadRequest` for the file at the given file `URL` using the `URLRequestConvertible` value and
    /// `RequestInterceptor`.
    ///
    /// - Parameters:
    ///   - fileURL:     The `URL` of the file to upload.
    ///   - convertible: `URLRequestConvertible` value to be used to create the `URLRequest`.
    ///   - interceptor: `RequestInterceptor` value to be used by the returned `DataRequest`. `nil` by default.
    ///   - fileManager: `FileManager` instance to be used by the returned `UploadRequest`. `.default` instance by
    ///                  default.
    ///
    /// - Returns:       The created `UploadRequest`.
    public static func upload(_ fileURL: URL,
                              with convertible: URLRequestConvertible,
                              interceptor: RequestInterceptor? = nil,
                              fileManager: FileManager = .default) -> UploadRequest {
        return Session.default.upload(fileURL, with: convertible, interceptor: interceptor, fileManager: fileManager)
    }

    // MARK: InputStream

    /// Creates an `UploadRequest` from the `InputStream` provided using a `URLRequest` from the provided components and
    /// `RequestInterceptor`.
    ///
    /// - Parameters:
    ///   - stream:      The `InputStream` that provides the data to upload.
    ///   - convertible: `URLConvertible` value to be used as the `URLRequest`'s `URL`.
    ///   - method:      `HTTPMethod` for the `URLRequest`. `.post` by default.
    ///   - headers:     `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///   - interceptor: `RequestInterceptor` value to be used by the returned `DataRequest`. `nil` by default.
    ///   - fileManager: `FileManager` instance to be used by the returned `UploadRequest`. `.default` instance by
    ///                  default.
    ///
    /// - Returns:       The created `UploadRequest`.
    public static func upload(_ stream: InputStream,
                              to convertible: URLConvertible,
                              method: HTTPMethod = .post,
                              headers: HTTPHeaders? = nil,
                              interceptor: RequestInterceptor? = nil,
                              fileManager: FileManager = .default) -> UploadRequest {
        return Session.default.upload(stream,
                                      to: convertible,
                                      method: method,
                                      headers: headers,
                                      interceptor: interceptor,
                                      fileManager: fileManager)
    }

    /// Creates an `UploadRequest` from the provided `InputStream` using the `URLRequestConvertible` value and
    /// `RequestInterceptor`.
    ///
    /// - Parameters:
    ///   - stream:      The `InputStream` that provides the data to upload.
    ///   - convertible: `URLRequestConvertible` value to be used to create the `URLRequest`.
    ///   - interceptor: `RequestInterceptor` value to be used by the returned `DataRequest`. `nil` by default.
    ///   - fileManager: `FileManager` instance to be used by the returned `UploadRequest`. `.default` instance by
    ///                  default.
    ///
    /// - Returns:       The created `UploadRequest`.
    public static func upload(_ stream: InputStream,
                              with convertible: URLRequestConvertible,
                              interceptor: RequestInterceptor? = nil,
                              fileManager: FileManager = .default) -> UploadRequest {
        return Session.default.upload(stream, with: convertible, interceptor: interceptor, fileManager: fileManager)
    }

    // MARK: MultipartFormData

    /// Creates an `UploadRequest` for the multipart form data built using a closure and sent using the provided
    /// `URLRequest` components and `RequestInterceptor`.
    ///
    /// It is important to understand the memory implications of uploading `MultipartFormData`. If the cumulative
    /// payload is small, encoding the data in-memory and directly uploading to a server is the by far the most
    /// efficient approach. However, if the payload is too large, encoding the data in-memory could cause your app to
    /// be terminated. Larger payloads must first be written to disk using input and output streams to keep the memory
    /// footprint low, then the data can be uploaded as a stream from the resulting file. Streaming from disk MUST be
    /// used for larger payloads such as video content.
    ///
    /// The `encodingMemoryThreshold` parameter allows Alamofire to automatically determine whether to encode in-memory
    /// or stream from disk. If the content length of the `MultipartFormData` is below the `encodingMemoryThreshold`,
    /// encoding takes place in-memory. If the content length exceeds the threshold, the data is streamed to disk
    /// during the encoding process. Then the result is uploaded as data or as a stream depending on which encoding
    /// technique was used.
    ///
    /// - Parameters:
    ///   - multipartFormData:       `MultipartFormData` building closure.
    ///   - convertible:             `URLConvertible` value to be used as the `URLRequest`'s `URL`.
    ///   - encodingMemoryThreshold: Byte threshold used to determine whether the form data is encoded into memory or
    ///                              onto disk before being uploaded. `MultipartFormData.encodingMemoryThreshold` by
    ///                              default.
    ///   - method:                  `HTTPMethod` for the `URLRequest`. `.post` by default.
    ///   - headers:                 `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///   - interceptor:             `RequestInterceptor` value to be used by the returned `DataRequest`. `nil` by default.
    ///   - fileManager:             `FileManager` to be used if the form data exceeds the memory threshold and is
    ///                              written to disk before being uploaded. `.default` instance by default.
    ///
    /// - Returns:                   The created `UploadRequest`.
    public static func upload(multipartFormData: @escaping (MultipartFormData) -> Void,
                              to url: URLConvertible,
                              usingThreshold encodingMemoryThreshold: UInt64 = MultipartFormData.encodingMemoryThreshold,
                              method: HTTPMethod = .post,
                              headers: HTTPHeaders? = nil,
                              interceptor: RequestInterceptor? = nil,
                              fileManager: FileManager = .default) -> UploadRequest {
        return Session.default.upload(multipartFormData: multipartFormData,
                                      to: url,
                                      usingThreshold: encodingMemoryThreshold,
                                      method: method,
                                      headers: headers,
                                      interceptor: interceptor,
                                      fileManager: fileManager)
    }

    /// Creates an `UploadRequest` using a `MultipartFormData` building closure, the provided `URLRequestConvertible`
    /// value, and a `RequestInterceptor`.
    ///
    /// It is important to understand the memory implications of uploading `MultipartFormData`. If the cumulative
    /// payload is small, encoding the data in-memory and directly uploading to a server is the by far the most
    /// efficient approach. However, if the payload is too large, encoding the data in-memory could cause your app to
    /// be terminated. Larger payloads must first be written to disk using input and output streams to keep the memory
    /// footprint low, then the data can be uploaded as a stream from the resulting file. Streaming from disk MUST be
    /// used for larger payloads such as video content.
    ///
    /// The `encodingMemoryThreshold` parameter allows Alamofire to automatically determine whether to encode in-memory
    /// or stream from disk. If the content length of the `MultipartFormData` is below the `encodingMemoryThreshold`,
    /// encoding takes place in-memory. If the content length exceeds the threshold, the data is streamed to disk
    /// during the encoding process. Then the result is uploaded as data or as a stream depending on which encoding
    /// technique was used.
    ///
    /// - Parameters:
    ///   - multipartFormData:       `MultipartFormData` building closure.
    ///   - request:                 `URLRequestConvertible` value to be used to create the `URLRequest`.
    ///   - encodingMemoryThreshold: Byte threshold used to determine whether the form data is encoded into memory or
    ///                              onto disk before being uploaded. `MultipartFormData.encodingMemoryThreshold` by
    ///                              default.
    ///   - interceptor:             `RequestInterceptor` value to be used by the returned `DataRequest`. `nil` by default.
    ///   - fileManager:             `FileManager` to be used if the form data exceeds the memory threshold and is
    ///                              written to disk before being uploaded. `.default` instance by default.
    ///
    /// - Returns:                   The created `UploadRequest`.
    public static func upload(multipartFormData: @escaping (MultipartFormData) -> Void,
                              with request: URLRequestConvertible,
                              usingThreshold encodingMemoryThreshold: UInt64 = MultipartFormData.encodingMemoryThreshold,
                              interceptor: RequestInterceptor? = nil,
                              fileManager: FileManager = .default) -> UploadRequest {
        return Session.default.upload(multipartFormData: multipartFormData,
                                      with: request,
                                      usingThreshold: encodingMemoryThreshold,
                                      interceptor: interceptor,
                                      fileManager: fileManager)
    }

    /// Creates an `UploadRequest` for the prebuilt `MultipartFormData` value using the provided `URLRequest` components
    /// and `RequestInterceptor`.
    ///
    /// It is important to understand the memory implications of uploading `MultipartFormData`. If the cumulative
    /// payload is small, encoding the data in-memory and directly uploading to a server is the by far the most
    /// efficient approach. However, if the payload is too large, encoding the data in-memory could cause your app to
    /// be terminated. Larger payloads must first be written to disk using input and output streams to keep the memory
    /// footprint low, then the data can be uploaded as a stream from the resulting file. Streaming from disk MUST be
    /// used for larger payloads such as video content.
    ///
    /// The `encodingMemoryThreshold` parameter allows Alamofire to automatically determine whether to encode in-memory
    /// or stream from disk. If the content length of the `MultipartFormData` is below the `encodingMemoryThreshold`,
    /// encoding takes place in-memory. If the content length exceeds the threshold, the data is streamed to disk
    /// during the encoding process. Then the result is uploaded as data or as a stream depending on which encoding
    /// technique was used.
    ///
    /// - Parameters:
    ///   - multipartFormData:       `MultipartFormData` instance to upload.
    ///   - url:                     `URLConvertible` value to be used as the `URLRequest`'s `URL`.
    ///   - encodingMemoryThreshold: Byte threshold used to determine whether the form data is encoded into memory or
    ///                              onto disk before being uploaded. `MultipartFormData.encodingMemoryThreshold` by
    ///                              default.
    ///   - method:                  `HTTPMethod` for the `URLRequest`. `.post` by default.
    ///   - headers:                 `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///   - interceptor:             `RequestInterceptor` value to be used by the returned `DataRequest`. `nil` by default.
    ///   - fileManager:             `FileManager` to be used if the form data exceeds the memory threshold and is
    ///                              written to disk before being uploaded. `.default` instance by default.
    ///
    /// - Returns:                   The created `UploadRequest`.
    public static func upload(multipartFormData: MultipartFormData,
                              to url: URLConvertible,
                              usingThreshold encodingMemoryThreshold: UInt64 = MultipartFormData.encodingMemoryThreshold,
                              method: HTTPMethod = .post,
                              headers: HTTPHeaders? = nil,
                              interceptor: RequestInterceptor? = nil,
                              fileManager: FileManager = .default) -> UploadRequest {
        return Session.default.upload(multipartFormData: multipartFormData,
                                      to: url,
                                      usingThreshold: encodingMemoryThreshold,
                                      method: method,
                                      headers: headers,
                                      interceptor: interceptor,
                                      fileManager: fileManager)
    }

    /// Creates an `UploadRequest` for the prebuilt `MultipartFormData` value using the providing `URLRequestConvertible`
    /// value and `RequestInterceptor`.
    ///
    /// It is important to understand the memory implications of uploading `MultipartFormData`. If the cumulative
    /// payload is small, encoding the data in-memory and directly uploading to a server is the by far the most
    /// efficient approach. However, if the payload is too large, encoding the data in-memory could cause your app to
    /// be terminated. Larger payloads must first be written to disk using input and output streams to keep the memory
    /// footprint low, then the data can be uploaded as a stream from the resulting file. Streaming from disk MUST be
    /// used for larger payloads such as video content.
    ///
    /// The `encodingMemoryThreshold` parameter allows Alamofire to automatically determine whether to encode in-memory
    /// or stream from disk. If the content length of the `MultipartFormData` is below the `encodingMemoryThreshold`,
    /// encoding takes place in-memory. If the content length exceeds the threshold, the data is streamed to disk
    /// during the encoding process. Then the result is uploaded as data or as a stream depending on which encoding
    /// technique was used.
    ///
    /// - Parameters:
    ///   - multipartFormData:       `MultipartFormData` instance to upload.
    ///   - request:                 `URLRequestConvertible` value to be used to create the `URLRequest`.
    ///   - encodingMemoryThreshold: Byte threshold used to determine whether the form data is encoded into memory or
    ///                              onto disk before being uploaded. `MultipartFormData.encodingMemoryThreshold` by
    ///                              default.
    ///   - interceptor:             `RequestInterceptor` value to be used by the returned `DataRequest`. `nil` by default.
    ///   - fileManager:             `FileManager` instance to be used by the returned `UploadRequest`. `.default` instance by
    ///                              default.
    ///
    /// - Returns:                   The created `UploadRequest`.
    public static func upload(multipartFormData: MultipartFormData,
                              with request: URLRequestConvertible,
                              usingThreshold encodingMemoryThreshold: UInt64 = MultipartFormData.encodingMemoryThreshold,
                              interceptor: RequestInterceptor? = nil,
                              fileManager: FileManager = .default) -> UploadRequest {
        return Session.default.upload(multipartFormData: multipartFormData,
                                      with: request,
                                      usingThreshold: encodingMemoryThreshold,
                                      interceptor: interceptor,
                                      fileManager: fileManager)
    }
}
