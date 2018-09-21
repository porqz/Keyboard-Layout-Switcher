/**
 * ------------------------------------------------------------------------------
 *  Input Source Switcher | Written by Alexander Belov | http://github.com/porqz
 * ------------------------------------------------------------------------------
 *
 * Run this application:
 *  — Without arguments to see index of current input source
 *  — With an index to switch current input source to input source with the index
 *
 * If you will pass an index to the application, the application will print:
 *  — Nothing (if application ended normally)
 *  — -1 (if there is no input source with the index)
 *
 */

#import <Carbon/Carbon.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CFArrayRef inputSourcesList = TISCreateInputSourceList(NULL, false);
        
        if (argc > 1) {
            int wantedInputSourceIndex = atoi(argv[1]);
            TISInputSourceRef wantedInputSource = CFArrayGetValueAtIndex(inputSourcesList, wantedInputSourceIndex);
            
            if (!wantedInputSource) {
                printf("%d", -1);
                
                return 1;
            }
            
            TISSelectInputSource(wantedInputSource);
            
            return 0;
        }
        
        // If the application was running without arguments
        TISInputSourceRef currentInputSource = TISCopyCurrentKeyboardInputSource();
        CFIndex inputSourcesCount = CFArrayGetCount(inputSourcesList);
        CFArrayRef inputSourceName = TISGetInputSourceProperty(currentInputSource, kTISPropertyLocalizedName);
        
        for (int i = 0; i < inputSourcesCount; i++)
            if (TISGetInputSourceProperty(CFArrayGetValueAtIndex(inputSourcesList, i), kTISPropertyLocalizedName) == inputSourceName) {
                printf("%d", i);
                
                return 0;
            }
    }
    
    return 0;
}
