//
//  TestModel.swift
//  GlossExample
//
// Copyright (c) 2015 Harlan Kellaway
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Gloss

struct TestModel: Glossy {
    
    let bool: Bool?
        let boolArray: [Bool]?
    let integer: Int?
        let integerArray: [Int]?
    let float: Float?
        let floatArray: [Float]?
    let double: Double?
        let doubleArray: [Double]?
    let string: String?
        let stringArray: [String]?
    let nestedModel: TestNestedModel?
    let nestedModelArray: [TestNestedModel]?
    let enumValue: EnumValue?
    let enumValueArray: [EnumValue]?
    let date: NSDate?
    let dateISO8601: NSDate?
    let url: NSURL?
    
    enum EnumValue: String {
        case A = "A"
        case B = "B"
        case C = "C"
    }
    
    // MARK: - Deserialization
    
    static func fromJSON(json: JSON) -> TestModel {
        return TestModel(
            bool: "bool" <~~ json,
            boolArray: "boolArray" <~~ json,
            integer: "integer" <~~ json,
            integerArray: "integerArray" <~~ json,
            float: "float" <~~ json,
            floatArray: "floatArray" <~~ json,
            double: "double" <~~ json,
            doubleArray: "doubleArray" <~~ json,
            string: "string" <~~ json,
            stringArray: "stringArray" <~~ json,
            nestedModel: "nestedModel" <~~ json,
            nestedModelArray: "nestedModelArray" <~~ json,
            enumValue: "enumValue" <~~ json,
            enumValueArray: "enumValueArray" <~~ json,
            date: Decoder.decodeDate("date", dateFormatter: TestModel.dateFormatter)(json),
            dateISO8601: Decoder.decodeDateISO8601("dateISO8601")(json),
            url: "url" <~~ json
        )
    }
    
    // MARK: - Serialization
    
    func toJSON() -> JSON? {
        return jsonify([
            "bool" ~~> self.bool,
            "boolArray" ~~> self.boolArray,
            "integer" ~~> self.integer,
            "integerArray" ~~> self.integerArray,
            "float" ~~> self.float,
            "floatArray" ~~> self.floatArray,
            "double" ~~> self.double,
            "doubleArray" ~~> self.doubleArray,
            "string" ~~> self.string,
            "stringArray" ~~> self.stringArray,
            "nestedModel" ~~> self.nestedModel,
            "nestedModelArray" ~~> self.nestedModelArray,
            "enumValue" ~~> self.enumValue,
            "enumValueArray" ~~> self.enumValueArray,
            Encoder.encodeDate("date", dateFormatter: TestModel.dateFormatter)(self.date),
            Encoder.encodeDateISO8601("dateISO8601")(self.dateISO8601),
            "url" ~~> self.url
            ])
    }
    
    static var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        return dateFormatter
        }()
    
}
