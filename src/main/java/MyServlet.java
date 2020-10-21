
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
import java.net.URL;

@WebServlet(name = "MyServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
        maxFileSize=1024*1024*10,      // 10MB
        maxRequestSize=1024*1024*50)   // 50MB
public class MyServlet extends HttpServlet {

    private static final String SAVE_DIR = "uploadFiles";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                String fileName = null;
        // gets absolute path of the web application
        String appPath = request.getServletContext().getRealPath("");
        // constructs path of the directory to save uploaded file
        String savePath = appPath + File.separator + SAVE_DIR;
        // creates the save directory if it does not exists
        File fileSaveDir = new File(savePath);

        if (!fileSaveDir.exists())
            fileSaveDir.mkdir();
        if (request.getParameter("text").length() == 0) {
            System.out.println("file\n\n");
            for (Part part : request.getParts()) {
                if (extractFileName(part).length() != 0) {
                    fileName = extractFileName(part);
                    System.out.println(fileName);
                    // refines the fileName in case it is an absolute path
                    fileName = new File(fileName).getName();
                    part.write(savePath + File.separator + fileName);
                }
            }
        }
        else {
            BufferedImage image = null;
            System.out.println("url\n\n");
            URL url = new URL(request.getParameter("text"));
            System.out.println(request.getParameter("text"));
            image = ImageIO.read(url);
            fileName = "pix.jpg";
            System.out.println(savePath + File.separator + fileName);
            ImageIO.write(image, "jpg",new File(savePath + File.separator + fileName));
        }

//        final int PIX_SIZE = 10;
//// Read the file as an Image
//        BufferedImage img = ImageIO.read(new File(savePath + File.separator + fileName));
//// Get the raster data (array of pixels)
//        Raster src = img.getData();
//// Create an identically-sized output raster
//        WritableRaster dest = src.createCompatibleWritableRaster();
//// Loop through every PIX_SIZE pixels, in both x and y directions
//        for(int y = 0; y < src.getHeight(); y += PIX_SIZE) {
//            for(int x = 0; x < src.getWidth(); x += PIX_SIZE) {
//                // Copy the pixel
//                double[] pixel = new double[3];
//                pixel = src.getPixel(x, y, pixel);
//                // "Paste" the pixel onto the surrounding PIX_SIZE by PIX_SIZE neighbors
//                // Also make sure that our loop never goes outside the bounds of the image
//                for(int yd = y; (yd < y + PIX_SIZE) && (yd < dest.getHeight()); yd++) {
//                    for(int xd = x; (xd < x + PIX_SIZE) && (xd < dest.getWidth()); xd++) {
//                        dest.setPixel(xd, yd, pixel);
//                    }
//                }
//            }
//        }
//// Save the raster back to the Image
//        img.setData(dest);
//// Write the new file
//        ImageIO.write(img, "jpg", new File(savePath  + File.separator + "px_"+ fileName));
//        request.setAttribute("path", SAVE_DIR + File.separator + "px_" + fileName);
//        getServletContext().getRequestDispatcher("/index.jsp").forward(
//                request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Enter doGet");
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private String extractFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename"))
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
        }
        return "";
    }
}
