Botit AHK is full gui Automation tool.
holding a powerful and tiny image and pixel scanner with full background window screenshot support.
Self and auto calculation of any matched image with easy and clear control for each image and mode.

Botit ahk allow the user to build fully working bots without the need to understand code.

botit comes with:

Botit - Main automation tool with gui and self settings.
Botit Image tool - a super auto image tool allow user to crop / change / test detect / test click / auto crop / change scan area and much more..
Botit Manager - Allow user to add flows to botit. add images and functions to the flows and fully control the settings of everything on the bot. 
                manager also allow self publish with developer data per bots.


Everything is open!
all the code. all the core files are uncompiled. you can view change and add anything you like. no one is stopping ya..

some data before we start:
Botit runs on 5mb per bot. it auto support multi procs.
botit do not use mouse or keyboard. user can fully use the pc.
Botit do not use screen. you can fully turn off your screen we snap the target window to memory no screen use.
Window pos is not relavent you can free move the window botit will track the pos by title.
Window not on front? no issue! you can stack few window's and run them all we dont use mouse and screen so the bot only talk to the target window.

**window size is an issue. we cover this user error with "auto crop" on image tool. it will auto set the target window to the setting developer set on the bot build.
  so even if you lost your window size you can auto fix it by running auto crop.


So let say you are a new user with 0 understanding in code. where do you start??

1) download Botit Blank zip file or clone the repo
2) no install is needed. we run on stock autohotkey exe with uncompiled code. if you click on exe file it will run the script with the same name.
3) we start with Botit Manager.exe (it will allow us to add scan flows and images) * if you install ahk on the system you can run the .ahk file no need *.exe

![Botit_Manager_cjcztKF0G5](https://user-images.githubusercontent.com/52171360/101281147-2b111180-37d6-11eb-932e-c0cd1a1c72ab.png)

4)Delete test1 flow and add new flow with the green plus button.

![Botit_Manager_TSw5Nvp94t](https://user-images.githubusercontent.com/52171360/101281176-5c89dd00-37d6-11eb-87c1-7a055a78bc42.png)

5)after adding new flow gui will update and show the new flow you added. we can now add images to our flow.
  pick flow  -- press on the image icon under "add to mode"

![Botit_Manager_3HN1qdo7he](https://user-images.githubusercontent.com/52171360/101281250-b094c180-37d6-11eb-8760-0d3b93569faa.png)

6)on the new gui press "add new image" and enter image name.  ***do not use flow name for images

![Botit_Manager_8qIdVmnsoE](https://user-images.githubusercontent.com/52171360/101281306-e6d24100-37d6-11eb-8d13-4dde015e93a7.png)  

7)after you added the image names you want the image list will update. you can now pick the image or images and press "add image/s to mode" button. **image name can be anything but no spaces!

8)the gui and mode will self update to the new data you added. **Scan order is the order you see on flow.

9)botit manager is now showing the picked flow with the images connected to it. pressing on each object will open the data of the object.

![Botit_Manager_OOlZ7LzQHU](https://user-images.githubusercontent.com/52171360/101281461-a8895180-37d7-11eb-8998-e0b6165e2530.png)

Side menu hold data of the image correctly holding (if no image cropped yet it will show no image).

Tol = how far the user image match vs the target. range is from 0-125 golden area is 40-75. each image need TOl or match will fail!

Scan mode = allow user to pick how he wanna match the image. to the all window or just to the area image was cropped on. (botit will auto make the cords when you snap the    image)

Scan Color = how you wanna match the image. Color will use full color (faster but less accurate timer- 0.018 / grayscale is a bit slower but very accurate timer- 0.024)

Clicks = click or no click command

demo = user screen area with the target area. used by image tool to point you on what you snapped (it will auto build the demo and path when you crop)

area scan = allow you to re take the area of the image if you wanna make the area bigger or smaller.

Dont forget to save per each object.
**Any image you add will need tol to be set. it will not work if you dont save tol per the image.

after we added flow and images to our botit manager and saved our image scan data we can now start botit and use the image tool. (for testing and hot reload)
when we open botit blank 

![Bot_Blank_tgzcS9NfOB](https://user-images.githubusercontent.com/52171360/101281703-3c0f5200-37d9-11eb-9298-792872abe803.png)

we can see our new flow is already waiting for us on the menu.
we can start the test with botit or use the image tool to crop and then start botit.
for this tut we gonna open image tool first.

![ImageTool_f8RCVzThPo](https://user-images.githubusercontent.com/52171360/101281740-72e56800-37d9-11eb-97a9-94ffeae2fc90.png)

Image tool will auto show user the flow he added and the objects connected to the flow.
After picking a flow and an image a new side menu will show up with the data of the image.

![ImageTool_i9EWl5r93i](https://user-images.githubusercontent.com/52171360/101281762-9f00e900-37d9-11eb-8a9a-117cc1310fcf.png)

Afer picking a image we can Crop the image with botit tool. fallow the status tip to crop the area you want on the target.

![ImageTool_cLOPX2qD6X](https://user-images.githubusercontent.com/52171360/101281817-133b8c80-37da-11eb-848b-8f9951a8d80f.png)

after crop is done image tool will self update the data and add the area you took and the demo image of the area.
it will self fill the scan area data and any other data needed.
once image is cropped and you can see the new demo image you can test detect and click with:

![ImageTool_asG3EeKTQ4](https://user-images.githubusercontent.com/52171360/101281864-54cc3780-37da-11eb-85f1-f146ee7b1760.png)

data of the match is by what you saved on botit manager image settings. (tol , scan mode..)

after image was taken you can start botit blank and it will find and click what you made. it can run for weeks.
a video of the proc will be uploaded later on.
botit fully understand ahk and you can hook function or write functions in ahk.

function can use the image name you added from botit manager.
one line image scan. override scan data on functions to allow more control.
BotItScanner("Fail1",65,"area","G",0) ;img name "Fail1" tol - 65  scanmode - "Area"  scan color - "G"(grayscale)  click - "0" (no click)

Build Bot:
after you are done adding flows / images / testing and you happy with the output you can build a "clean" bot with more setting and data.


![Botit_Manager_YXdATm4cQA](https://user-images.githubusercontent.com/52171360/101282124-c8227900-37db-11eb-81a9-713f11e8e88f.png)


you can change the icon/builder logo
links data / youtube ... 
Auto crop settings (if you wanna let other users use your app or wanna auto settings on any other pc)

saving the data will output a new folder with your bot and all the data you added freash and clean for deploy. (you can copy botit manager to the folder if you want to keep changing the bot. else it will have botit and image tool only)

output size is 3.7mb other then the base 3.7mb you got your images and demo images. 
images sit on bot root folder "img"
demo images sit bot root folder "Image installer"
