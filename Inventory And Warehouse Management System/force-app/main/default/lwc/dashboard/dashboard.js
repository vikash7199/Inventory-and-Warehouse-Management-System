import { LightningElement,api , wire } from 'lwc';
import getInventoryLevels from '@salesforce/apex/InventoryDashboard.getInventoryData';

export default class Dashboard extends LightningElement {
    @api inventories;

    @wire(getInventoryLevels)
    wiredInventories({ error, data }) {
        if (data) {
            this.inventories = data;
        } else if (error) {
            console.error(error);
        }
    }
}