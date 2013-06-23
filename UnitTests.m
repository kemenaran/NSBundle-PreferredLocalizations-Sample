//
//  UnitTests.m
//  UnitTests
//
//  Created by Pierre de La Morinerie on 23/06/2013.
//
//

#import <SenTestingKit/SenTestingKit.h>

@interface UnitTests : SenTestCase
@end

@implementation UnitTests

- (void)testExample
{
    // Some passing tests
    STAssertEqualObjects([NSBundle preferredLocalizationsFromArray:(@[@"de", @"en"]) forPreferences:@[@"en"]], @[@"en"],
                         @"A generic language matches the same generic language");

    STAssertEqualObjects([NSBundle preferredLocalizationsFromArray:(@[@"de", @"en-GB"]) forPreferences:@[@"en-GB"]], @[@"en-GB"],
                         @"A country variant matches the same country variant");
    
    STAssertEqualObjects([NSBundle preferredLocalizationsFromArray:(@[@"de", @"en"]) forPreferences:@[@"en-GB"]], @[@"en"],
                         @"A country variant in the preferences array fallbacks on the generic language");
    
    // Some failing tests, that IMHO should pass
    STAssertEqualObjects([NSBundle preferredLocalizationsFromArray:(@[@"de", @"en-GB"]) forPreferences:@[@"en-CA"]], @[@"en-GB"],
                         @"A unavailable country variant should fallback on another country variant of the same language"); // returns "de" (unexpected)
    
    STAssertEqualObjects([NSBundle preferredLocalizationsFromArray:(@[@"de", @"en-GB"]) forPreferences:@[@"en"]], @[@"en-GB"],
                         @"An unavailable generic language should fallback on a country variant"); // returns "de" (unexpected)
    
    STAssertEquals([[[NSBundle preferredLocalizationsFromArray:(@[@"de", @"en-US"]) forPreferences:@[@"en"]] objectAtIndex:0] hasPrefix:@"en"],
                   [[[NSBundle preferredLocalizationsFromArray:(@[@"de", @"en-CA"]) forPreferences:@[@"en"]] objectAtIndex:0] hasPrefix:@"en"],
                   @"The behavior should be consistent between the en-US locale and the other locales"); // (unexpected)
}

@end
