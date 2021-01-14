import { LightningElement} from 'lwc';
export default class RecordEditFormCreateExampleLWC extends LightningElement {
    selectedFields = [NAME, EMAIL];

    handleSuccess(event) {
        console.log('onsuccess event recordEditForm',event.detail.id)
    }
    handleSubmit(event) {
        console.log('onsubmit event recordEditForm'+ event.detail.fields);
    }
}