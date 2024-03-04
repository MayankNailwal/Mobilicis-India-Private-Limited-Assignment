//Used Metal Framework to fetch GPU info
//IMEI cannot be accessed however I have fetched the unique identifier
//access to serial number is restricted by apple, hence using same as IMEI
//AVFoundation was used to fetch info of camera
//for fetching the cpu information i have created a class CPUInfoViewController that has been linked to another view controller, a button to trigger the same has been placed on the app itself
  The object for the same was made inside view controller class for primary view
//To fetch the camera info a seperate class has been implemented in which i have imported the AVFoundation package
// i have added the NSCameraUsageDescription key to my app's Info.plist file to get user permission for accessing the camera hardware
//IBOutlets of most of the labels have been created
//UIDevice class has been used to get unique vendor ID in replacement of IMEI number(Non accessible)
//UIDevice class was used to fetch the battery level , model name and iOS Version using its class properties which have been provided by Apple already



