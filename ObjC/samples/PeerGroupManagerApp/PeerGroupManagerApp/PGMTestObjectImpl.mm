////////////////////////////////////////////////////////////////////////////////
//
//  ALLJOYN MODELING TOOL - GENERATED CODE
//
//  This is an autogenerated or copied file which the AllSeen Alliance
//  as author hereby dedicates to the public domain.  Additionally, THIS
//  SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND ANY CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE,
//  AND OF GOOD TITLE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
//  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
//  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
//  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
//  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
////////////////////////////////////////////////////////////////////////////////
//
//  DO NOT EDIT
//
//  Add a category or subclass in separate .h/.m files to extend these classes
//
////////////////////////////////////////////////////////////////////////////////
//
//  PGMTestObjectImpl.mm
//
////////////////////////////////////////////////////////////////////////////////

#import <alljoyn/BusAttachment.h>
#import <alljoyn/BusObject.h>
#import "AllJoynFramework/AJNBusObjectImpl.h"
#import "AllJoynFramework/AJNInterfaceDescription.h"
#import "AllJoynFramework/AJNMessageArgument.h"
#import "AllJoynFramework/AJNSignalHandlerImpl.h"

#import "PGMTestObjectImpl.h"

using namespace ajn;


@interface AJNMessageArgument(Private)

/**
 * Helper to return the C++ API object that is encapsulated by this objective-c class
 */
@property (nonatomic, readonly) MsgArg *msgArg;


@end


////////////////////////////////////////////////////////////////////////////////
//
//  C++ Bus Object class declaration for TestObjectImpl
//
////////////////////////////////////////////////////////////////////////////////
class TestObjectImpl : public AJNBusObjectImpl
{
private:
    
    //TODO Workaround for the "AJNBusObjectImpl constructor requires a bus attachment" problem
    static BusAttachment& getDummyBusAttachment()
    {
        static BusAttachment* dummyBusAttachment = NULL;
        
        if (dummyBusAttachment == NULL)
        {
            dummyBusAttachment = new BusAttachment("");
        }
        
        return *dummyBusAttachment;
    }

public:
    TestObjectImpl(const char *path, id<TestDelegate> aDelegate);

    TestObjectImpl(BusAttachment &bus, const char *path, id<TestDelegate> aDelegate);

    virtual QStatus InitializeBusInterface(BusAttachment &bus);
    
    
    
    // methods
    //
    void Echo(const InterfaceDescription::Member* member, Message& msg);

    
    // signals
    //
    
};
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  C++ Bus Object implementation for TestObjectImpl
//
////////////////////////////////////////////////////////////////////////////////

TestObjectImpl::TestObjectImpl(const char *path, id<TestDelegate> aDelegate) :
    AJNBusObjectImpl(getDummyBusAttachment(),path,aDelegate)
{
    // Intentionally empty
}

TestObjectImpl::TestObjectImpl(BusAttachment &bus, const char *path, id<TestDelegate> aDelegate) :
    AJNBusObjectImpl(bus,path,aDelegate)
{
    //TODO Workaround for the "AJNBusObjectImpl constructor ignoring the bus attachment" problem
    this->bus = &bus;
    
    InitializeBusInterface(bus);
}

QStatus TestObjectImpl::InitializeBusInterface(BusAttachment &bus)
{
    const InterfaceDescription* interfaceDescription = NULL;
    QStatus status;
    status = ER_OK;
    
    
    // Add the org.alljoyn.bus.samples.testInterface interface to this object
    //
    interfaceDescription = bus.GetInterface("org.alljoyn.bus.samples.testInterface");
    assert(interfaceDescription);
    status = AddInterface(*interfaceDescription);

    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred while adding the interface org.alljoyn.bus.samples.testInterface. %@", [AJNStatus descriptionForStatusCode:status]);
    }
    
    
    // Register the method handlers for interface TestDelegate with the object
    //
    const MethodEntry methodEntriesForTestDelegate[] = {

        {
			interfaceDescription->GetMember("Echo"), static_cast<MessageReceiver::MethodHandler>(&TestObjectImpl::Echo)
		}
    
    };
    
    status = AddMethodHandlers(methodEntriesForTestDelegate, sizeof(methodEntriesForTestDelegate) / sizeof(methodEntriesForTestDelegate[0]));
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred while adding method handlers for interface org.alljoyn.bus.samples.testInterface to the interface description. %@", [AJNStatus descriptionForStatusCode:status]);
    }
    

    return status;
}


void TestObjectImpl::Echo(const InterfaceDescription::Member *member, Message& msg)
{
    @autoreleasepool {
    
    
    
    
    // get all input arguments
    //
    
    qcc::String inArg0 = msg->GetArg(0)->v_string.str;
        
    // declare the output arguments
    //
    
	NSString* outArg0;

    
    // call the Objective-C delegate method
    //
    
	outArg0 = [(id<TestDelegate>)delegate echoString:[NSString stringWithCString:inArg0.c_str() encoding:NSUTF8StringEncoding] fromSender:[[[AJNMessage alloc] initWithHandle:&msg] senderName]];
    
        
    // formulate the reply
    //
    MsgArg outArgs[1];
    
    outArgs[0].Set("s", [outArg0 UTF8String]);

    QStatus status = MethodReply(msg, outArgs, 1);
    if (ER_OK != status) {
        NSLog(@"ERROR: An error occurred when attempting to send a method reply for Echo. %@", [AJNStatus descriptionForStatusCode:status]);
    }        
    
    
    }
}



////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  Objective-C Bus Object implementation for AJNTestObject
//
////////////////////////////////////////////////////////////////////////////////

@interface AJNTestObject()

/**
 * The bus attachment this object is associated with.
 */
@property (nonatomic, weak) AJNBusAttachment *bus;

@end

@implementation AJNTestObject

@dynamic handle;
@synthesize bus = _bus;



- (TestObjectImpl*)busObject
{
    return static_cast<TestObjectImpl*>(self.handle);
}

- (QStatus)registerInterfacesWithBus:(AJNBusAttachment *)busAttachment
{
    QStatus status;

    status = [self activateInterfacesWithBus: busAttachment];

    self.busObject->InitializeBusInterface(*((ajn::BusAttachment*)busAttachment.handle));
    
    return status;
}

- (QStatus)activateInterfacesWithBus:(AJNBusAttachment *)busAttachment
{
    QStatus status;

    status = ER_OK;
    
    AJNInterfaceDescription *interfaceDescription;
    
    
        //
        // TestDelegate interface (org.alljoyn.bus.samples.testInterface)
        //
        // create an interface description, or if that fails, get the interface as it was already created
        //
        interfaceDescription = [busAttachment createInterfaceWithName:@"org.alljoyn.bus.samples.testInterface"];
        
    
        // add the methods to the interface description
        //
    
        status = [interfaceDescription addMethodWithName:@"Echo" inputSignature:@"s" outputSignature:@"s" argumentNames:[NSArray arrayWithObjects:@"str",@"outStr", nil]];
        
        if (status != ER_OK && status != ER_BUS_MEMBER_ALREADY_EXISTS) {
            @throw [NSException exceptionWithName:@"BusObjectInitFailed" reason:@"Unable to add method to interface: Echo" userInfo:nil];
        }

    
        [interfaceDescription activate];

    
    self.bus = busAttachment;

    return status;
}

- (id)initWithPath:(NSString *)path
{
    self = [super initWithPath:path];
    if (self) {

        // create the internal C++ bus object
        //
        TestObjectImpl *busObject = new TestObjectImpl([path UTF8String], (id<TestDelegate>)self);
        
        self.handle = busObject;
    }
    return self;
}

- (id)initWithBusAttachment:(AJNBusAttachment *)busAttachment onPath:(NSString *)path
{
    self = [super initWithBusAttachment:busAttachment onPath:path];
    if (self) {
        [self activateInterfacesWithBus: busAttachment];
        
        // create the internal C++ bus object
        //
        TestObjectImpl *busObject = new TestObjectImpl(*((ajn::BusAttachment*)busAttachment.handle), [path UTF8String], (id<TestDelegate>)self);
        
        self.handle = busObject;
    }
    return self;
}

- (void)dealloc
{
    TestObjectImpl *busObject = [self busObject];
    delete busObject;
    self.handle = nil;
}

    
- (NSString*)echoString:(NSString*)str fromSender:(NSString *)sender
{
    //
    // GENERATED CODE - DO NOT EDIT
    //
    // Create a category or subclass in separate .h/.m files
    @throw([NSException exceptionWithName:@"NotImplementedException" reason:@"You must override this method in a subclass" userInfo:nil]);
}


@end

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  Objective-C Proxy Bus Object implementation for TestObject
//
////////////////////////////////////////////////////////////////////////////////

@interface TestObjectProxy(Private)

@property (nonatomic, strong) AJNBusAttachment *bus;

- (ProxyBusObject*)proxyBusObject;

@end

@implementation TestObjectProxy
    
- (NSString*)echoString:(NSString*)str
{
    [self addInterfaceNamed:@"org.alljoyn.bus.samples.testInterface"];
    
    // prepare the input arguments
    //
    
    Message reply(*((BusAttachment*)self.bus.handle));    
    MsgArg inArgs[1];
    
    inArgs[0].Set("s", [str UTF8String]);
        

    // make the function call using the C++ proxy object
    //
    
    QStatus status = self.proxyBusObject->MethodCall("org.alljoyn.bus.samples.testInterface", "Echo", inArgs, 1, reply, 5000);
    if (ER_OK != status) {
        NSLog(@"ERROR: ProxyBusObject::MethodCall on org.alljoyn.bus.samples.testInterface failed. %@", [AJNStatus descriptionForStatusCode:status]);
        
        return nil;
            
    }

    
    // pass the output arguments back to the caller
    //
    
        
    return [NSString stringWithCString:reply->GetArg()->v_string.str encoding:NSUTF8StringEncoding];
        

}

@end

////////////////////////////////////////////////////////////////////////////////
