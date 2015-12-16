#import "SoomlaProfile.h"
#import "UserProfile.h"
#import "UserProfileStorage.h"
#import "SocialActionUtils.h"
#import "UserProfileNotFoundException.h"
#import "ProviderNotFoundException.h"
#import "UnityProfileCommons.h"
#import "UnityCommons.h"
#import "Reward.h"
#import "Leaderboard.h"
#import "Score.h"
#import "SoomlaUtils.h"
#import "UnityProfileEventDispatcher.h"
#import "NSData-Base64.h"

extern "C"{
	
    void soomlaProfile_Initialize(const char* customParamsJson) {
        LogDebug(@"SOOMLA Unity UnitySoomlaProfile", @"Initializing ProfileEventHandler and SoomlaProfile");
        
        NSString* customParamsJsonS = [NSString stringWithUTF8String:customParamsJson];
        NSDictionary* customParamsDict = [SoomlaUtils jsonStringToDict:customParamsJsonS];
        
        NSMutableDictionary *parsedCustomParams = [NSMutableDictionary dictionary];
        for (NSString* key in customParamsDict) {
            id value = customParamsDict[key];
            [parsedCustomParams setObject:value forKey:@([UserProfileUtils providerStringToEnum:key])];
        }
        
//        [SoomlaProfile usingExternalProvider:YES];
        [UnityProfileEventDispatcher initialize];
        [[SoomlaProfile getInstance] initialize:parsedCustomParams];
    }
    
    void soomlaProfile_Login(const char* sProvider, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        
        [[SoomlaProfile getInstance] loginWithProvider:[UserProfileUtils providerStringToEnum:providerIdS]
                                            andPayload:payloadS andReward:nil];
    }
    
    void soomlaProfile_Logout(const char* sProvider){
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        
        [[SoomlaProfile getInstance] logoutWithProvider:[UserProfileUtils providerStringToEnum:providerIdS]];
    }
    
    bool soomlaProfile_IsLoggedIn(const char* sProvider){
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        
        return [[SoomlaProfile getInstance] isLoggedInWithProvider:[UserProfileUtils providerStringToEnum:providerIdS]];
    }
    
    void soomlaProfile_UpdateStatus(const char* sProvider, const char* status, const char* payload, bool showConfirmation, const char* customMessage) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        NSString* statusS = [NSString stringWithUTF8String:status];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        NSString* customMessageS = customMessage ? [NSString stringWithUTF8String:customMessage] : nil;

        [[SoomlaProfile getInstance] updateStatusWithProvider:[UserProfileUtils providerStringToEnum:providerIdS]
                                                    andStatus:statusS andPayload:payloadS andReward:nil andConfirmation:showConfirmation andCustomMessage:customMessageS];
    }
    
    void soomlaProfile_UpdateStatusDialog(const char* sProvider, const char* link, const char* payload) {
        NSString *providerIdS = [NSString stringWithUTF8String:sProvider];
        NSString *linkS = [NSString stringWithUTF8String:link];
        NSString *payloadS = [NSString stringWithUTF8String:payload];
        
        [[SoomlaProfile getInstance] updateStatusWithProviderDialog:[UserProfileUtils providerStringToEnum:providerIdS] andLink:linkS andPayload:payloadS andReward:nil];
    }
    
    void soomlaProfile_UpdateStory(const char* sProvider, const char* message, const char* name,
                                   const char* caption, const char* description,
                                   const char* link, const char* pictureUrl, const char* payload, bool showConfirmation, const char* customMessage) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        NSString* messageS = [NSString stringWithUTF8String:message];
        NSString* nameS = [NSString stringWithUTF8String:name];
        NSString* captionS = [NSString stringWithUTF8String:caption];
        NSString* descriptionS = [NSString stringWithUTF8String:description];
        NSString* linkS = [NSString stringWithUTF8String:link];
        NSString* pictureUrlS = [NSString stringWithUTF8String:pictureUrl];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        NSString* customMessageS = customMessage ? [NSString stringWithUTF8String:customMessage] : nil;

        [[SoomlaProfile getInstance] updateStoryWithProvider:[UserProfileUtils providerStringToEnum:providerIdS]
                                                  andMessage:messageS andName:nameS andCaption:captionS
                                              andDescription:descriptionS andLink:linkS andPicture:pictureUrlS
                                                  andPayload:payloadS andReward:nil
                                         andShowConfirmation:showConfirmation andCustomMessage:customMessageS];
    }
    
    void soomlaProfile_UpdateStoryDialog(const char* sProvider, const char* name,
                                         const char* caption, const char* description,
                                         const char* link, const char* picture, const char* payload) {
        NSString *providerIdS = [NSString stringWithUTF8String:sProvider];
        NSString *nameS = [NSString stringWithUTF8String:name];
        NSString *captionS = [NSString stringWithUTF8String:caption];
        NSString *descriptionS = [NSString stringWithUTF8String:description];
        NSString *linkS = [NSString stringWithUTF8String:link];
        NSString *pictureS = [NSString stringWithUTF8String:picture];
        NSString *payloadS = [NSString stringWithUTF8String:payload];
        
        [[SoomlaProfile getInstance] updateStoryWithProviderDialog:[UserProfileUtils providerStringToEnum:providerIdS] andName:nameS andCaption:captionS andDescription:descriptionS andLink:linkS andPicture:pictureS andPayload:payloadS andReward:nil];
    }
    
    void soomlaProfile_UploadImage(const char* sProvider, const char* message, const char* fileName, const char *imageBase64Str, const char* payload, bool showConfirmation, const char* customMessage) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        NSString* messageS = [NSString stringWithUTF8String:message];
        NSString* fileNameS = [NSString stringWithUTF8String:fileName];
        NSString* imageBase64StrS = [NSString stringWithUTF8String:imageBase64Str];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        NSString* customMessageS = customMessage ? [NSString stringWithUTF8String:customMessage] : nil;

        NSData *imageData = [NSData dataFromBase64String_soomla:imageBase64StrS];
        [[SoomlaProfile getInstance] uploadImageWithProvider:[UserProfileUtils providerStringToEnum:providerIdS] andMessage:messageS andImageFileName:fileNameS andImageData:imageData andPayload:payloadS andReward:nil
                                         andConfirmation:showConfirmation andCustomMessage:customMessageS];
    }
    
    void soomlaProfile_GetContacts(const char* sProvider, bool fromStart, const char* payload){
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        NSString* payloadS = [NSString stringWithUTF8String:payload];

        [[SoomlaProfile getInstance] getContactsWithProvider:[UserProfileUtils providerStringToEnum:providerIdS]
                                                andFromStart:fromStart
                                                  andPayload:payloadS
                                                   andReward:nil];
    }
    
    void soomlaProfile_GetFeed(const char* sProvider, bool fromStart, const char *payload) {
        NSString *providerIdS = [NSString stringWithUTF8String:sProvider];
        NSString *payloadS = [NSString stringWithUTF8String:payload];
        
        [[SoomlaProfile getInstance] getFeedWithProvider:[UserProfileUtils providerStringToEnum:providerIdS]
                                            andFromStart:fromStart
                                              andPayload:payloadS
                                               andReward:nil];
    }
    
    void soomlaProfile_Invite(const char *sProvider, const char *inviteMessage, const char *dialogTitle, const char *payload) {
        NSString *providerIdS = [NSString stringWithUTF8String:sProvider];
        NSString *inviteMessageS = [NSString stringWithUTF8String:inviteMessage];
        NSString *dialogTitleS = [NSString stringWithUTF8String:dialogTitle];
        NSString *payloadS = [NSString stringWithUTF8String:payload];
        
        [[SoomlaProfile getInstance] inviteWithProvider:[UserProfileUtils providerStringToEnum:providerIdS]
                                          inviteMessage:inviteMessageS
                                            dialogTitle:dialogTitleS
                                                payload:payloadS
                                              andReward:nil];
    }
    
	int soomlaProfile_GetStoredUserProfile(const char* sProvider, char** json) {
        NSLog(@"SOOMLA/UNITY soomlaProfile_GetStoredUserProfile");
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
		@try {
            Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
            UserProfile* userProfile = nil;
            if ([SoomlaProfile isUsingExternalProvider]) {
                NSLog(@"SOOMLA/UNITY isUsingExternalProvider[true]");
                userProfile = [UserProfileStorage getUserProfile:provider];
                NSLog(@"SOOMLA/UNITY userProfile:%@", [userProfile debugDescription]);
                if (!userProfile) {
                    return EXCEPTION_USER_PROFILE_NOT_FOUND;
                }
            }
            else {
                NSLog(@"SOOMLA/UNITY isUsingExternalProvider[false]");
                userProfile = [[SoomlaProfile getInstance] getStoredUserProfileWithProvider:provider];
            }
            
            NSDictionary* userDict = [userProfile toDictionary];
            NSLog(@"SOOMLA/UNITY userDict:%@", userDict);
            NSString* userProfileJson = [SoomlaUtils dictToJsonString:userDict];
            *json = Soom_AutonomousStringCopy([userProfileJson UTF8String]);
		}
		
		@catch (ProviderNotFoundException* e) {
            NSLog(@"SOOMLA/UNITY Couldn't find a Provider with providerId: %@.", providerIdS);
			return EXCEPTION_PROVIDER_NOT_FOUND;
        }
        @catch (UserProfileNotFoundException* e) {
            NSLog(@"SOOMLA/UNITY Couldn't find a UserProfile for providerId %@.", providerIdS);
			return EXCEPTION_USER_PROFILE_NOT_FOUND;
        }

		return NO_ERR;
	}
    
    void soomlaProfile_SetStoredUserProfile(const char* json, BOOL notify) {
        NSString* userProfileJson = [NSString stringWithUTF8String:json];
        UserProfile* userProfile = [[UserProfile alloc] initWithDictionary:[SoomlaUtils jsonStringToDict:userProfileJson]];
        [UserProfileStorage setUserProfile:userProfile andNotify:notify];
	}
    
    void soomlaProfile_RemoveUserProfile(const char* json) {
        NSLog(@"SOOMLA/UNITY soomlaProfile_RemoveUserProfile");
        NSString* userProfileJson = [NSString stringWithUTF8String:json];
        UserProfile* userProfile = [[UserProfile alloc] initWithDictionary:[SoomlaUtils jsonStringToDict:userProfileJson]];
        [UserProfileStorage removeUserProfile:userProfile];
    }
	   
    void soomlaProfile_OpenAppRatingPage() {
        [[SoomlaProfile getInstance] openAppRatingPage];
    }
    
    void soomlaProfile_MultiShare(const char* sText, const char* sImageFilePath) {
        NSString* text = sText ? [NSString stringWithUTF8String:sText] : nullptr;
        NSString* imageFilePath = sImageFilePath ? [NSString stringWithUTF8String:sImageFilePath] : nullptr;

        [[SoomlaProfile getInstance] multiShareWithText:text andImageFilePath:imageFilePath];
    }

    void soomlaProfile_GetLeaderboards(const char *sProvider, const char *payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        NSString* payloadS = [NSString stringWithUTF8String:payload];

        [[SoomlaProfile getInstance] getLeaderboardsWithProvider:[UserProfileUtils providerStringToEnum:providerIdS]
                                                         payload:payloadS
                                                       andReward:nil];
    }

    void soomlaProfile_GetScores(const char * sProvider, const char * leaderboard, bool fromStart, const char * payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        Leaderboard *leaderboardS = [[Leaderboard alloc] initWithDictionary:[SoomlaUtils jsonStringToDict:[NSString stringWithUTF8String:leaderboard]]];

        [[SoomlaProfile getInstance] getScoresWithProvider:[UserProfileUtils providerStringToEnum:providerIdS]
                                            forLeaderboard:leaderboardS
                                                 fromStart:fromStart
                                                   payload:payloadS
                                                 andReward:nil];
    }

    void soomlaProfile_SubmitScore(const char * sProvider, const char *to, int score, const char * payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        Leaderboard *leaderboardS = [[Leaderboard alloc] initWithDictionary:[SoomlaUtils jsonStringToDict:[NSString stringWithUTF8String:to]]];

        [[SoomlaProfile getInstance] submitScoreWithProvider:[UserProfileUtils providerStringToEnum:providerIdS]
                                                       score:@(score)
                                               toLeaderboard:leaderboardS
                                                     payload:payloadS
                                                   andReward:nil];
    }

    void soomlaProfile_ShowLeaderboards(const char * sProvider, const char * payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        NSString* payloadS = [NSString stringWithUTF8String:payload];

        [[SoomlaProfile getInstance] showLeaderboardsForProvider:[UserProfileUtils providerStringToEnum:providerIdS] andPayload:payloadS];
    }

}