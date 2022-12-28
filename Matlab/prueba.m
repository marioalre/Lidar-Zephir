% Cargar datos
datos = readtable("Datos\Wind10_732@Y2022_M04_D04.CSV");

% Eliminar ultima fina de datos
datos(:, end) = [];

% Eliminar columnas de la tabla
datos.Reference = [];
datos.Timestamp_s_ = [];
datos.Info_Flags = [];

% Creación de tabla con parámetros de funcinamiento del sensor
StatusFlags = datos.StatusFlags;
Battery_V_ = datos.Battery_V_;
Generator_V_ = datos.Generator_V_;
UpperTemp__C_ = datos.UpperTemp__C_;
LowerTemp__C_ = datos.LowerTemp__C_;
PodHumidity___ = datos.PodHumidity___;
GPS = datos.GPS;

datos_funcionamiento = table(StatusFlags, Battery_V_, Generator_V_, ...
    UpperTemp__C_, LowerTemp__C_, PodHumidity___, GPS);

datos.StatusFlags = [];
datos.Battery_V_ = [];
datos.Generator_V_ = [];
datos.UpperTemp__C_ = [];
datos.LowerTemp__C_ = [];
datos.PodHumidity___ = [];

long = zeros(1, length(datos_funcionamiento.GPS));
lat = zeros(1, length(datos_funcionamiento.GPS));
for i = 1:length(datos_funcionamiento.GPS)
    coor = datos_funcionamiento.GPS{i};
    contador = 1;
    for s = coor

        if s == " "

            long(i) = str2double(coor(1 : contador-1));
            lat(i) = str2double(coor(contador+1 : end));
        end
    contador = 1 + contador;
    end
end