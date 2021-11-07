#include <DueTimer.h>
//Se definen las variables que se usarán en el programa
// Contador de muestras
double Samples = 0;
// Tiempo de muestreo para realizar cambios automáticamente
double Ts = 0.2197;
//---------------cantidad de muestras para hacer cambios de referencia---
double cambios=4/Ts;

//------------controlador a implementar------------
//        605.9 z - 131.9     U(z)
//G_cd  =  --------------- = -----
//             z - 1          E(z)
//----------ecuación en diferencia-------------
//-------u(k)= 605.9*e(k) - 131.9*e(k-1) + u(k-1)
//accion de control u(k)
double uk=0;
//accion de control pasada u(k-1)
double uk1=0;
//erro actual e(k)
double ek=0;
//error pasad e(k-1)
double ek1=0;
//salida de la planta y(k)
double yk=0;

//referencia
double rk;

//-----------implementación del controlador-----------
void controlador(){
  //-----------medir la variable del proceso----
  //-------normalmente mediante un ADC-----
  yk=Samples;
  //-------calcular el error actual----
  ek=rk-yk;
  //---------calcular acción de control---
  uk = 605.9*ek - 131.9*ek1 + uk1;
  //---------actualizo valores-----------
  uk1=uk;
  ek1=ek;
  //-----generar la salida hacia la planta---
  //-------normalmente mediante un DAC-----
  Serial.print(uk);
  Serial.print(',');
  Serial.print('\n');
}

void setup(){
  Serial.begin(115200);
  Timer3.attachInterrupt(controlador);
  //Timer3.start(50000); // Calls every 50ms
  Timer3.start(219700);
}

void loop(){
  Samples = Samples + 1;

  // Si el contador de muestras es 1 (uno) se modifica la entrada al sistema generando un número randómico
  if (Samples == 1)
  {
    //Se genera un número randómico entre -5 y 5
    rk = random(-5,5);
    Samples = Samples + 1;
  }

  // Si el contador de muestras supera un valor se resetea el contador para que se vuelva a generar una nueva entrada
  if (Samples > cambios)
  {
    Samples = 0;
  }
}
