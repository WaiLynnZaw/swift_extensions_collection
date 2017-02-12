import Foundation
extension String {
    var makemd5: String! {
            let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
            let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
            let digestLen = Int(CC_MD5_DIGEST_LENGTH)
            let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)

            CC_MD5(str!, strLen, result)

            let hmacData = NSData(bytes: result, length: digestLen)
            let hmacBase64 = hmacData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))

            result.dealloc(digestLen)
            let signature = String(hmacBase64)
            return signature

    }

    var makemd5Hex: String! {
        var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
        if let data = self.dataUsingEncoding(NSUTF8StringEncoding) {
            CC_MD5(data.bytes, CC_LONG(data.length), &digest)
        }
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        return digestHex

    }

    func hmac(keyString: String) -> String {
        let key = keyString.dataUsingEncoding(NSUTF8StringEncoding)
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)

        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), key!.bytes, key!.length, str!, strLen, result)

        let hmacData = NSData(bytes: result, length: digestLen)
        let hmacBase64 = hmacData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))

        result.dealloc(digestLen)

        let signature = String(hmacBase64)
        return signature
    }

    func hmacHex(key: String) -> String {
            let cKey = key.cStringUsingEncoding(NSUTF8StringEncoding)
            let cData = self.cStringUsingEncoding(NSUTF8StringEncoding)
            var result = [CUnsignedChar](count: Int(CC_SHA256_DIGEST_LENGTH), repeatedValue: 0)
            let length: Int = Int(strlen(cKey!))
            let data: Int = Int(strlen(cData!))
            CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), cKey!, length, cData!, data, &result)

            let hmacData: NSData = NSData(bytes: result, length: (Int(CC_SHA256_DIGEST_LENGTH)))

            var bytes = [UInt8](count: hmacData.length, repeatedValue: 0)
            hmacData.getBytes(&bytes, length: hmacData.length)

            var hexString = ""
            for byte in bytes {
                hexString += String(format:"%02hhx", UInt8(byte))
            }
            return hexString
        }
}
