const String GempaTerbaruAPI =
    "https://data.bmkg.go.id/DataMKG/TEWS/autogempa.json";

const String ShakeMapAPI = "https://data.bmkg.go.id/DataMKG/TEWS/";

const earthquakeColor1 = 0xFFf5cd79;
const earthquakeColor2 = 0xFFf19066;
const earthquakeColor3 = 0xFFe15f41;
const earthquakeColor4 = 0xFFc44569;
const earthquakeColor5 = 0xFF303952;

int getEarthquakeColor(double magnitude) {
  if (magnitude >= 5.0 && magnitude < 6.0) {
    return earthquakeColor1;
  } else if (magnitude >= 6.0 && magnitude < 7.0) {
    return earthquakeColor2;
  } else if (magnitude >= 7.0 && magnitude < 8.0) {
    return earthquakeColor3;
  } else if (magnitude >= 8.0 && magnitude < 9.0) {
    return earthquakeColor4;
  } else {
    return earthquakeColor5;
  }
}
