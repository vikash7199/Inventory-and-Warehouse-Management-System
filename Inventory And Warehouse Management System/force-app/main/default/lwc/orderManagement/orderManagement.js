import { LightningElement, wire, track } from 'lwc';
import getOrderData from '@salesforce/apex/OrderManagement.getOrderData';
const COLUMNS = [
    { label: 'Order Number', fieldName: 'OrderNumber' },
    { label: 'Customer Name', fieldName: 'CustomerName' },
    { label: 'Order Date', fieldName: 'OrderDate'},
    { label: 'Total Amount', fieldName: 'TotalAmount' },
    { label: 'Status' , fieldName:'Status'},
   
];

export default class OrderManagement extends LightningElement {
    @track OrderManagementData = [];
    columns = COLUMNS;

    @wire(getOrderData)
    wiredOrderData({ error, data }) {
        if (data) {          
            this.OrderManagementData = data.map(item => {
                const OrderNumber = item.Name;
                const CustomerName = item.Customer_Name__r.Name;               
                    return {
                        id: item.Id,
                        OrderNumber: OrderNumber,
                        CustomerName:CustomerName,
                        OrderDate: item.Order_Date__c,
                        TotalAmount: item.Total_Amount__c,
                        Status: item.Status__c                       
                    };                
            });           
        } else if (error) {
            console.error('Error fetching Order data:', error);
        }
    }
}