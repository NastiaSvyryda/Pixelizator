<%--
  Created by IntelliJ IDEA.
  User: asvyryda
  Date: 10/8/20
  Time: 4:51 пп
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Hello, I am a Java web app!</title>
</head>
<body>
<h1>Simple Java Web App Demo</h1>
<input type='file' />
<br><img id="myImg" src="#" alt="your image" height=600 width=800>

<script type="text/javascript">
    window.addEventListener('load', function() {
        document.querySelector('input[type="file"]').addEventListener('change', function() {
            if (this.files && this.files[0]) {
                var img = document.querySelector('img');  // $('img')[0]
                img.src = URL.createObjectURL(this.files[0]); // set src to blob url
                img.onload = imageIsLoaded;
            }
        });
    });

    function imageIsLoaded() {
        alert(this.src);  // blob url
        // update width and height ...
    }
</script>
<%--<p>To invoke the java servlet click <a href="Pixelizator">here</a></p>--%>
</body>
</html>
