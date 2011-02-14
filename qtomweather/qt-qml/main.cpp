#include <QApplication>
#include <QGraphicsView>
#include <QGraphicsScene>
#include <QGraphicsWidget>
#include <QGraphicsLinearLayout>
#include <QDeclarativeComponent>
#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#include <QDeclarativeView>
#include <QTranslator>
#include <QHash>
#include <QGraphicsGridLayout>
#include <exception>
#include <iostream>

#include "core.h"
#include "dataqml.h"
#include "configqml.h"
#include "qmllayoutitem.h"
#include "dataitem.h"
#include "datamodel.h"
#include "parserqt.h"
#include "databasesqlite.h"
#include "abstractconfig.h"

#include <QtDebug>

#include <libintl.h>
#include <locale.h>

#define _(String) gettext(String)


QHash<char*, char*> *translating_hash;

void g_hash_table_insert(QHash<char*, char*> *h,   void* key,  char *value){
    h->insert(((char*)key), ((char*)value));
}

QHash<char*, char*>*
fill_hash(void){
      QHash<char*, char*> *hash;
      hash = new QHash<char*, char*>;
#include "../meego-mpl/hash.data"
    return hash;
}

ConfigQml *
create_and_fill_config(){
    ConfigQml *config;

    std::cerr<<"Create Config class: " <<std::endl;
    try{
        config = new ConfigQml(Core::AbstractConfig::getConfigPath()+
                               "config.xml",
                               Core::AbstractConfig::prefix+
                               Core::AbstractConfig::schemaPath+
                               "config.xsd");
        std::cerr << config->stationsList().size() << std::endl;
    }
    catch(const std::string &str){
        std::cerr<<"Error in Config class: "<< str <<std::endl;
        config = new ConfigQml();
    }
    catch(const char *str){
        std::cerr<<"Error in Config class: "<< str <<std::endl;
        config = new ConfigQml();
    }
    //std::cerr<<"End of creating Config class: " <<std::endl;
    //config->saveConfig();
    std::cerr<<"End of creating Config class: " <<std::endl;

    return config;
}
//////////////////////////////////////////////////////////////////////////////
bool
update_weather_forecast1(std::vector<Core::Station*> StationsList){
    int i;
    Core::Station* station;
    for (i=0; i<StationsList.size();i++){
        station = StationsList.at(i);
     //   std::cerr<<"yyyyyy    "<< station->forecastURL()<<std::endl;
    }
    return true;
}
bool
update_weather_forecast(Core::Config *config){
    int i;
    int success = 0;
    Core::Station* station;

    for (i=0; i < config->stationsList().size();i++){
        station = config->stationsList().at(i);
        if (station->updateData(true)){
            success ++;

        }
    }

    return true;
}
  

int main(int argc, char* argv[])
{
    QApplication::setGraphicsSystem("native");
    QApplication app(argc, argv);
    
   // bindtextdomain("omweather");
    textdomain("omweather");
    translating_hash = fill_hash();
/*
    //Set up a graphics scene with a QGraphicsWidget and Layout
    QGraphicsView view;
    QGraphicsScene scene;
    QGraphicsWidget *widget = new QGraphicsWidget();
    QGraphicsGridLayout *layout = new QGraphicsGridLayout;
    layout->setSpacing(0);
    widget->setLayout(layout);
    scene.addItem(widget);
    view.setScene(&scene);
*/

    //Add the QML snippet into the layout

/*
    Core::DatabaseSqlite *db = new Core::DatabaseSqlite("weather.com.db");

    db->open_database();
    Core::listdata * list = db->create_stations_list(18);
    Core::listdata::iterator cur;
    for (cur=list->begin(); cur<list->end(); cur++)
        std::cerr << (*cur).first << " - " << (*cur).second << std::endl;
    return 0;
*/
    ConfigQml *config;
    DataItem *forecast_data = NULL;

    //Core::DataList data_list;
    //QmlLayoutItem* qml_layout_item;
    Core::DataParser* dp = NULL;
    Core::Data *temp_data = NULL;
    int i;

    std::vector<Core::Station*> StationsList;

    config = create_and_fill_config();
    std::cerr<<"iconpath = "<<config->prefix_path()<<std::endl;
    StationsList = config->stationsList();
    std::cerr<<"size "<<StationsList.size()<<std::endl;
    //update_weather_forecast(config);

    try{
       if (config->current_station_id() != INT_MAX && config->stationsList().at(config->current_station_id()))
           dp = new Core::DataParser(config->stationsList().at(config->current_station_id())->fileName(),
                                     Core::AbstractConfig::sharePath+Core::AbstractConfig::schemaPath+"data.xsd");
    }
    catch(const std::string &str){
        std::cerr<<"Error in DataParser class: "<< str <<std::endl;
        dp = new Core::DataParser();
        //return -1;
    }
    catch(const char *str){
        std::cerr<<"Error in DataParser class: "<< str <<std::endl;
        dp = new Core::DataParser();
        //return -1;
    }

    DataModel *model = new DataModel(new DataItem, qApp);
    i = 0;
    while  (temp_data = dp->data().GetDataForTime(time(NULL) + i)) {
        i = i + 3600*24;
        forecast_data = new DataItem(temp_data);
        forecast_data->Text(_(forecast_data->Text().c_str()));
        model->appendRow(forecast_data);

    }

    QTranslator translator;
    translator.load("ru.qml", "i18n");
    app.installTranslator(&translator);

    QDeclarativeView qview;

    //qview.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    /*
    if (forecast_data){
        qview.rootContext()->setContextProperty("Forecast", forecast_data);
    }*/
    //std::cout << "temp = " << model->getRow(2) << std::endl;
    //qview.setGeometry(100, 100, 200, 200);
    qview.rootContext()->setContextProperty("Forecast_model", model);
    qview.rootContext()->setContextProperty("Config", config);
    qview.setSource(QUrl(QString::fromStdString(Core::AbstractConfig::layoutqml)));
    qview.show();

/*
    qml_layout_item = new QmlLayoutItem(config, forecast_data);
    layout->addItem(&qml_layout_item->obj(),0,0);

    forecast_data =  create_and_fill_class_data_for_day_forecast();
    qml_layout_item = new QmlLayoutItem(config, forecast_data);
    layout->addItem(&qml_layout_item->obj(),0,1);



    widget->setGeometry(QRectF(0,0, 800,400));



    view.show();
*/

    return app.exec();
}
