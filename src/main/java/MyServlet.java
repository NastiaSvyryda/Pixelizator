import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.awt.image.WritableRaster;
import java.io.*;
import java.net.URL;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "MyServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
        maxFileSize=1024*1024*10,      // 10MB
        maxRequestSize=1024*1024*50)   // 50MB
public class MyServlet extends HttpServlet {

    private static final String SAVE_DIR = "uploadFiles";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("doPost\n\n");
        System.out.println(request.getParameter("type"));
        System.out.println(request.getParameter("file"));
        System.out.println(request.getParameter("fileUrl"));
        System.out.println(request.getParameter("pixSize"));

        String savePath = request.getServletContext().getRealPath("") + File.separator + SAVE_DIR;
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists())
            fileSaveDir.mkdir();
        ImageController controller = new ImageController(request, savePath, request.getParameter("type"));
        BufferedImage img = controller.getImage();
        Pixelizator pixel = new Pixelizator(Integer.parseInt(request.getParameter("pixSize")), img);
        pixel.pixelization(controller.getName(), savePath);
        response.setContentType("text/plain");
        OutputStream outStream = response.getOutputStream();
        outStream.write(pixel.getPathOfImage().getBytes(StandardCharsets.UTF_8));
        outStream.flush();
        outStream.close();
    }
}
