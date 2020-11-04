import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.awt.image.WritableRaster;
import java.io.File;
import java.io.IOException;

public class Pixelizator {
    private static final String SAVE_DIR = "uploadFiles";
    int pixSize;
    BufferedImage img;
    String imgPath;

    public Pixelizator(int pixSize, BufferedImage img) {
        this.pixSize = pixSize;
        this.img = img;
    }

    public void pixelization(String fileName, String savePath) throws IOException {
        // Read the file as an Image
//        BufferedImage img = ImageIO.read(new File(savePath + File.separator + fileName));
// Get the raster data (array of pixels)
        assert img != null;
        Raster src = img.getData();
// Create an identically-sized output raster
        WritableRaster dest = src.createCompatibleWritableRaster();
// Loop through every PIX_SIZE pixels, in both x and y directions
        for(int y = 0; y < src.getHeight(); y += pixSize) {
            for(int x = 0; x < src.getWidth(); x += pixSize) {
                // Copy the pixel
                double[] pixel = new double[3];
                pixel = src.getPixel(x, y, pixel);
                // "Paste" the pixel onto the surrounding PIX_SIZE by PIX_SIZE neighbors
                // Also make sure that our loop never goes outside the bounds of the image
                for(int yd = y; (yd < y + pixSize) && (yd < dest.getHeight()); yd++) {
                    for(int xd = x; (xd < x + pixSize) && (xd < dest.getWidth()); xd++) {
                        dest.setPixel(xd, yd, pixel);
                    }
                }
            }
        }
// Save the raster back to the Image
        img.setData(dest);
// Write the new file
        ImageIO.write(img, "jpg", new File(savePath  + File.separator + "px_"+ fileName));

        String content = SAVE_DIR + File.separator + "px_" + fileName;
    }
    public String getPathOfImage() {
        return imgPath;
    }
}
