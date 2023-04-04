--Create database
createdb med_clinic

--Acces to database
psql -d med_clinic

CREATE TABLE patients(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    PRIMARY KEY (id));

 CREATE TABLE medical_histories(
    id INT,
    admitted_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    patient_id INT NOT NULL,
    status VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_medical_histories_patients FOREIGN KEY (patient_id) REFERENCES patients (id));

CREATE TABLE invoices(
    id INT GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL(8,4) NOT NULL,
    generated_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    payed_at TIMESTAMP(0) WITHOUT TIME ZONE,
    medical_histories_id INT NOT NULL,
    PRIMARY KEY (id),                                                                       CONSTRAINT fk_invoices_medical_histories FOREIGN KEY (medical_histories_id) REFERENCES medical_histories (id));

 CREATE TABLE treatments(
    id INTEGER NOT NULL,
    type VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id));

 CREATE TABLE medical_histories_treatments(
    medical_history_id INT NOT NULL,
    treatment_id INT NOT NULL,
    CONSTRAINT fk_medical_histories_treatments_medical_histories 
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id),
    CONSTRAINT fk_medical_histories_treatments_treatments 
    FOREIGN KEY (treatment_id) REFERENCES treatments (id));      

 CREATE TABLE invoice_items(
    id INT GENERATED ALWAYS AS IDENTITY,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    invoice_id INT NOT NULL,
    treatment_id INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_invoice_items_invoices FOREIGN KEY (invoice_id) REFERENCES invoices (id),
    CONSTRAINT fk_invoice_items_treatments FOREIGN KEY (treatment_id) REFERENCES treatments (id));    

    
   
