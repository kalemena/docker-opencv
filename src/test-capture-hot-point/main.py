import cv2
import time

# Open Camera
camera = cv2.VideoCapture(0)

# Set definition
camera.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
camera.set(cv2.CAP_PROP_FRAME_HEIGHT, 1024)
time.sleep(2)
# camera.set(15, -8.0)

def get_image():
 retval, im = camera.read()
 return im

def get_warm_up_image():
 # Warmup
 for i in range(10):
  temp = get_image()
  # Save result
  #file = "/notebooks/test-capture-hot-point/image%d.png" % (i)
  #cv2.imwrite(file, temp)
 return get_image()

# Image to update
base_image = get_warm_up_image()

for i in range(1,6):
 time.sleep(3)
 print("Capturing image... %d" % (i))
 capture = get_warm_up_image()
 
 # Convert and process
 gray = cv2.cvtColor(capture, cv2.COLOR_BGR2GRAY)
 gray = cv2.GaussianBlur(gray, (19,19),0)

 # Find spot
 (minVal, maxVal, minLoc, maxLoc) = cv2.minMaxLoc(gray)

 # Materialize spot
 cv2.circle(base_image,(maxLoc),10,(0,255,0),-1)
 font = cv2.FONT_HERSHEY_SIMPLEX
 cv2.putText(base_image, "P%d" % (i), (maxLoc), font, 0.5, (255,0,0), 1, cv2.LINE_AA)

# Save result
file = "/notebooks/test-capture-hot-point/image.png"
cv2.imwrite(file, base_image)

# Cleanup
del(camera)