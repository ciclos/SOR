var mostrando = 0;
ejercicios = document.querySelectorAll(".ejercicio");
navegacion = document.querySelector("nav.navegacion");

if (ejercicios.length > 0) {
    ejercicios[0].style.display = "block"; // Por defecto mostramos el primer ejercicio

    for (var i = 0; i < ejercicios.length; i++) {
        navegacion.innerHTML += '<a onclick="cambiar(this)">' + (i + 1) + '</a>';

    }
    document.querySelector("nav.navegacion").childNodes[1].style.backgroundColor = "red";

    function cambiar(enlace) {
        indice = (enlace.innerHTML - 1);
        botones = document.querySelectorAll(".ejercicio a");
        ejercicios[mostrando].style.display = "none";
        ejercicios[indice].style.display = "block";
        document.querySelector("nav.navegacion").childNodes[indice + 1].style.backgroundColor = "red";
        document.querySelector("nav.navegacion").childNodes[mostrando + 1].style.backgroundColor = "#003f69";
        mostrando = indice;
    }
}


// Get the modal
var modal = document.getElementById("myModal");

// Get the image and insert it inside the modal - use its "alt" text as a caption
var img = document.getElementById("myImg");
var modalImg = document.getElementById("img01");

imagenes = document.querySelectorAll("img");

for (var i = 0; i < imagenes.length; i++) {
    imagenes[i].onclick = function(){
        modal.style.display = "block";
        modalImg.src = this.src;
    };
}

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("modal")[0];

// When the user clicks on <span> (x), close the modal
span.onclick = function() { 
  modal.style.display = "none";
}