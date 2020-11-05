$(document).ready(function() {
    $('form').submit(function(event) {
        event.preventDefault();
        var data = new FormData(this);
        if ($('#file').val().length !== 0)
            data.append("type", "file");
        if ($('#fileUrl').val().length !== 0)
            data.append("type", "url");
        // Calling AJAX
        $.ajax({
            url : $(this).attr('action'),
            type : $(this).attr('method'),
            data : data,
            contentType : false,
            cache : false,
            processData : false,
            success : function(response) {
                // обработка ответа от сервера
                document.getElementById("NewImg").src = response;
                document.getElementById("downloadButtons").style.display = "initial";
                var btns = document.getElementsByClassName("button");
                    for (var i = 0; i < btns.length; i++)
                        btns[i].href = response;
            }
        });
        return false;
    });

    document.getElementById("file").addEventListener('change', function() {
        if (this.files && this.files[0] && this.files[0].name.match(/\.(jpg|jpeg)$/)) {
            var image = document.getElementById("Img");  // $('img')[0]
            image.src = URL.createObjectURL(this.files[0]); // set src to blob url
            var img= this.files[0].size;
            var imgsize = img/1000000;
            document.getElementById("fileSize").innerHTML = imgsize.toFixed(3) + " MiB";
            image.onload = imageIsLoaded;
            document.getElementById("fileUrl").value = null;
            document.getElementById("divImage").style.display = "initial";
            document.getElementById("downloadButtons").style.display = "none";
        }
        else alert('This is not jpg file!');
    });

    document.getElementById("fileUrl").addEventListener('change', function() {
        var image = document.getElementById("Img");  // $('img')[0]
        var downloadingImage = new Image();
        downloadingImage.onload = function() {
            image.src = this.src;
        };
        var name = document.getElementById("fileUrl").value;
        if (name != null && name.match(/\.(jpeg|jpg)$/)) { //&& name.match(/\.(jpg|jpeg)$/)
            downloadingImage.src = name;
            document.getElementById("file").value = null;
            document.getElementById("divImage").style.display = "initial";
            document.getElementById("downloadButtons").style.display = "none";
        }
        else alert('This is not jpg file!');

        // var img = downloadingImage.files[0].size;
        // var imgsize=img/1024;
        //         // var nBytes = 0,
        //         //     oFiles = downloadingImage.src,
        //         //     nFiles = oFiles.length;
        //         // for (var nFileId = 0; nFileId < nFiles; nFileId++) {
        //         //     nBytes += oFiles[nFileId].size;
        //         // }
        // document.getElementById("fileSize").innerHTML = imgsize.toFixed(3) + " MiB";
    });
});

function imageIsLoaded() {
    alert(this.src);  // blob url
    // update width and height ...
}