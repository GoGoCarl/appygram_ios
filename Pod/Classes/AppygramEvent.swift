/**
 * <p>An event for when Appygrams are sent.  This contains 
 * the original AppygramMessage sent, a success flag, and 
 * the response message, if available.</p>
 * 
 * @author Carl Scott, <a href="http://solertium.com">Solertium Corporation</a>
 *
 */
public class AppygramEvent : NSObject {
	
    var message : AppygramMessage
    var isSuccess : Bool
    var response : String?
    
    public init(_ message : AppygramMessage) {
        self.message = message
        self.isSuccess = true
        self.response = nil
    }
	
	/**
	 * The original message that was sent.
	 * @return
	 */
	public func getMessage() -> AppygramMessage {
		return message;
	}
	
    public func setSuccess(isSuccess: Bool) {
		self.isSuccess = isSuccess;
	}
	
	/**
	 * The response text given back from the Appygram server.
	 * @return
	 */
	public func getResponse() -> String? {
		return response;
    }
	
    public override var description : String {
        return "SUCCESS: \(isSuccess); RESPONSE: \(response)"
    }
    
}
