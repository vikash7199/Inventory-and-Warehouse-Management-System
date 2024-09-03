import { LightningElement,track,wire } from 'lwc';

export default class WarehouseMap extends LightningElement {
    mapMarkers = [
        {
            location: {
                Latitude: '23.370249311451992',
                Longitude: '85.32493573697286',
            },
            title : 'Warehouse A',
            description : 'Current capacity - 40% and Inventory levels: 300 units.'
        },
        {    
            location: {
                Latitude: '23.37128701769631',  
                Longitude: '85.32310914573917',
            },
            title : 'Warehouse B',
            description : 'Current capacity - 60% and Inventory levels: 200 units.'
        },
    ];
    zoomLevel = 15;
}
