#version 410

uniform mat4 matrModel;
uniform mat4 matrVisu;

layout (std140) uniform varsUnif
{
    float tempsDeVieMax;       // temps de vie maximal (en secondes)
    float temps;               // le temps courant dans la simulation (en secondes)
    float dt;                  // intervalle entre chaque affichage (en secondes)
    float gravite;             // gravité utilisée dans le calcul de la position de la particule
    float pointsize;           // taille des points (en pixels)
};

layout(location=0) in vec4 Vertex;
layout(location=3) in vec4 Color;
layout(location=4) in vec3 vitesse;
layout(location=5) in float tempsDeVieRestant;

out Attribs {
    vec4 couleur;
    float tempsDeVieRestant;
    float sens; // du vol (partie 3)
    float hauteur; // de la particule dans le repère du monde (partie 3)
} AttribsOut;

void main( void )
{
    // transformation standard du sommet, ** sans la projection **
    gl_Position = matrVisu * matrModel * Vertex;

    // assigner le temps de vie restant à la sortie
    AttribsOut.tempsDeVieRestant = tempsDeVieRestant;

    // couleur du sommet
    AttribsOut.couleur = Color;

    // assigner la taille des points (en pixels)
    gl_PointSize = pointsize;

    // calculer la hauteur de la particule dans le repère du monde
    AttribsOut.hauteur = (matrModel * Vertex).z;

    // calculer le signe du sens selon la vitesse en y
    AttribsOut.sens = sign( vitesse.y );

}
