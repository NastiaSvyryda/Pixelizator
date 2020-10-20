import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.awt.image.WritableRaster;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "MyServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
        maxFileSize=1024*1024*10,      // 10MB
        maxRequestSize=1024*1024*50)   // 50MB
public class MyServlet extends HttpServlet {

    private static final String SAVE_DIR = "uploadFiles";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Enter doPost");
        String fileName = null;
        // gets absolute path of the web application
        String appPath = request.getServletContext().getRealPath("");
        // constructs path of the directory to save uploaded file
        String savePath = appPath + File.separator + SAVE_DIR;
        // creates the save directory if it does not exists
        File fileSaveDir = new File(appPath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }

        for (Part part : request.getParts()) {
            fileName = extractFileName(part);
            // refines the fileName in case it is an absolute path
            fileName = new File(fileName).getName();
            part.write(savePath + File.separator + fileName);
        }

        final int PIX_SIZE = 10;

// Read the file as an Image
        BufferedImage img = ImageIO.read(new File(savePath + File.separator + fileName));

// Get the raster data (array of pixels)
        Raster src = img.getData();

// Create an identically-sized output raster
        WritableRaster dest = src.createCompatibleWritableRaster();

// Loop through every PIX_SIZE pixels, in both x and y directions
        for(int y = 0; y < src.getHeight(); y += PIX_SIZE) {
            for(int x = 0; x < src.getWidth(); x += PIX_SIZE) {

                // Copy the pixel
                double[] pixel = new double[3];
                pixel = src.getPixel(x, y, pixel);

                // "Paste" the pixel onto the surrounding PIX_SIZE by PIX_SIZE neighbors
                // Also make sure that our loop never goes outside the bounds of the image
                for(int yd = y; (yd < y + PIX_SIZE) && (yd < dest.getHeight()); yd++) {
                    for(int xd = x; (xd < x + PIX_SIZE) && (xd < dest.getWidth()); xd++) {
                        dest.setPixel(xd, yd, pixel);
                    }
                }
            }
        }

// Save the raster back to the Image
        img.setData(dest);

// Write the new file
        ImageIO.write(img, "jpg", new File(savePath  + File.separator + "px_"+ fileName));
        request.setAttribute("path", SAVE_DIR + File.separator + "px_" + fileName);
        getServletContext().getRequestDispatcher("/index.jsp").forward(
                request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Enter doGet");
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length()-1);
            }
        }
        return "";
    }
}
