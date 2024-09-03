import { LightningElement, wire, track } from 'lwc';
import getInventoryData from '@salesforce/apex/InventoryDashboard.getInventoryData';
const COLUMNS = [
    { label: 'Inventory Name', fieldName: 'InventoryName' },
    { label: 'Product Name', fieldName: 'productName' },
    { label: 'Warehouse', fieldName: 'warehouseName' },
    { label: 'Quantity in Stock', fieldName: 'quantityInStock'},
    { label: 'Reorder Status', fieldName: 'reorderStatus' },
];

export default class InventoryDashboard extends LightningElement {
    @track inventoryData = [];
    @track lowStockAlert = false;
    lowStockMessage = '';
    columns = COLUMNS;

    @wire(getInventoryData)
    wiredInventoryData({ error, data }) {
        if (data) {
            this.inventoryData = data.map(item => {
                const productName = item.Product__r ;
                const warehouseName = item.Warehouse__r ;
                return {
                    id: item.Id,
                    InventoryName:item.Name,
                    productName: productName,
                    warehouseName: warehouseName,
                    quantityInStock: item.Quantity_in_Stock__c,
                    reorderStatus: item.Reorder_Status__c
                };   
            });
            // Low stock alert logic
            const lowStockItems = this.inventoryData.filter(item => item.reorderStatus === 'Reorder Needed');
            if (lowStockItems.length > 0) {
                this.lowStockAlert = true;
                this.lowStockMessage = `There are ${lowStockItems.length} products with low stock. Please review the inventory.`;
            } else {
                this.lowStockAlert = false;
            }
        } else if (error) {
            console.error('Error fetching Inventory data:', error);
        }
    }
}
