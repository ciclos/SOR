var mostrando = 0;
ejercicios = document.querySelectorAll(".ejercicio");
navegacion = document.querySelector("nav.navegacion");
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
    document.querySelector("nav.navegacion").childNodes[mostrando + 1].style.backgroundColor = "#203F68";
    mostrando = indice;
}
