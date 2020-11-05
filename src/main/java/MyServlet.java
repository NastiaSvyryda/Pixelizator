import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "MyServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, // 2MB
        maxFileSize=1024*1024*10,      // 10MB
        maxRequestSize=1024*1024*50)   // 50MB
public class MyServlet extends HttpServlet {

    private static final String SAVE_DIR = "uploadFiles";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String savePath = request.getServletContext().getRealPath("") + File.separator + SAVE_DIR;
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists())
            fileSaveDir.mkdir();
        ImageController controller = new ImageController(request, savePath, request.getParameter("type"));
        BufferedImage img = controller.getImage();
        Pixelizator pixel = new Pixelizator(Integer.parseInt(request.getParameter("pixSize")), img);
        pixel.pixelateImg(controller.getName(), savePath);
        sendResponse(response, pixel.getPathOfImage());
    }

    private void sendResponse(HttpServletResponse response, String content) throws IOException {
        response.setContentType("text/plain");
        OutputStream outStream = response.getOutputStream();
        outStream.write(content.getBytes(StandardCharsets.UTF_8));
        outStream.flush();
        outStream.close();
    }
}
