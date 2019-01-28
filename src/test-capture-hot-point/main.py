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
 
# Warmup
for i in range(30):
 temp = get_image()

print("Capturing image...")
camera_capture = get_image()

# Convert and process
gray = cv2.cvtColor(camera_capture, cv2.COLOR_BGR2GRAY)
gray = cv2.GaussianBlur(gray, (19,19),0)

# Find spot
(minVal, maxVal, minLoc, maxLoc) = cv2.minMaxLoc(gray)
cv2.circle(camera_capture,(maxLoc),10,(0,255,0),-1)

# Save result
file = "/notebooks/test-capture-hot-point/image"+str(i)+".png"
cv2.imwrite(file, camera_capture)

# Cleanup
del(camera)