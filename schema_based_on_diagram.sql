/* Database schema to keep the structure of entire database. */

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name varchar(100),
    date_of_birth date
);

CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    admitted_at timestamp,
    patient_id integer,
    status varchar(100),
    CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    type varchar(250),
    name varchar(250)
);

CREATE TABLE invoices(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  total_amount decimal,
  generated_at timestamp,
  payed_at timestamp,
  medical_history_id integer,
  CONSTRAINT fk_history FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  unit_price decimal,
  quantity integer,
  total_price decimal,
  invoice_id integer,
  treatment_id integer,
  CONSTRAINT fk_invoice FOREIGN KEY(invoice_id) REFERENCES invoices(id),
  CONSTRAINT fk_treatment FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);

CREATE TABLE medical_histories_has_treatments (
    medical_history_id int references medical_histories(id),
    treatment_id int references treatments(id),
    CONSTRAINT fk_history FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id),
    CONSTRAINT fk_treatment FOREIGN KEY(treatment_id) REFERENCES treatments(id)
  );

-- create indexes
CREATE INDEX ON medical_histories (patient_id);
CREATE INDEX ON invoices (medical_history_id);
CREATE INDEX ON invoice_items (invoice_id);
CREATE INDEX ON invoice_items (treatment_id);
CREATE INDEX ON medical_histories_has_treatments (medical_history_id);
CREATE INDEX ON medical_histories_has_treatments (treatment_id);


