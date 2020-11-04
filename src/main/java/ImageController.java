import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

public class ImageController {
    private BufferedImage img;
    private String fileName;
    private final String savePath;

    public ImageController(HttpServletRequest request,String savePath, String type) throws IOException, ServletException {
        this.savePath = savePath;
        if (type.equals("file"))
            makeImage(request.getPart("file"));
        else if (type.equals("url"))
            makeImage(request.getParameter("fileUrl"));
    }

    private void makeImage(Part part) throws IOException {
        System.out.println("file\n\n");
        fileName = extractFileName(part);
        System.out.println(fileName);
        fileName = new File(fileName).getName();
        part.write(savePath + File.separator + fileName);
        img = ImageIO.read(new File(savePath + File.separator + fileName));
    }

    private void makeImage(String imgUrl) throws IOException {
        fileName = "pixel.jpg";
        System.out.println("url\n\n");
        URL url = new URL(imgUrl);
        System.out.println(imgUrl);
        img = ImageIO.read(url);
    }

    public BufferedImage getImage() {
        return img;
    }
    public String getName() {
        return fileName;
    }

    private String extractFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename"))
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
        }
        return "";
    }
}
