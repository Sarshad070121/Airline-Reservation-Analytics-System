# ✈️ Airline Reservation Analytics System

## 📌 Project Overview
The **Airline Reservation Analytics System** demonstrates **data modelling, cleaning, and advanced SQL analytics** applied to airline operations.  
It leverages structured datasets—including **airports, flights, passengers, reservations, and payments**—to uncover actionable insights through more than **20 SQL queries** covering ranking, CTEs, aggregations, and data quality checks.  

The system is designed as a **complete analytical solution** that enables efficient data handling and decision support for the aviation sector.  

---

## 🎯 Key Features
- **Comprehensive Data Model** covering airports, flights, reservations, payments, and passengers.  
- **Advanced SQL Queries** for:
  - Passenger spending behavior  
  - Flight delays and operational efficiency  
  - Route profitability and revenue tracking  
- **Data Quality Checks** to validate and ensure dataset integrity.  
- **Scalability & Extensibility**, allowing further enhancements for aviation-related analytics.  
- **Synthetic Data Generation** using the **Faker** package for realistic, privacy-safe test data.  

---

## 🗺️ Data Model

The system comprises the following primary tables:  

### **1. Airport**
| Column         | Description                               |
|----------------|-------------------------------------------|
| `airport_id` (PK) | Unique identifier for the airport        |
| `airport_name` | Name of the airport                       |
| `airport_city` | City where the airport is located          |
| `airport_country` | Country where the airport is located     |

### **2. Flights**
| Column         | Description                               |
|----------------|-------------------------------------------|
| `flight_id` (PK) | Unique identifier for the flight          |
| `airline`      | Airline operating the flight               |
| `origin_id` (FK → Airport) | Departure airport ID           |
| `destination_id` (FK → Airport) | Arrival airport ID        |
| `departure_time` | Scheduled departure time                 |
| `status`       | Flight status (e.g., *On Time*, *Delayed*) |

### **3. Passengers**
| Column         | Description                               |
|----------------|-------------------------------------------|
| `passenger_id` (PK) | Unique identifier for the passenger    |
| `first_name`   | Passenger's first name                     |
| `last_name`    | Passenger's last name                      |

### **4. Reservation**
| Column         | Description                               |
|----------------|-------------------------------------------|
| `reservation_id` (PK) | Unique reservation identifier        |
| `passenger_id` (FK → Passengers) | Passenger who booked     |
| `flight_id` (FK → Flights) | Reserved flight                |
| `status`       | Reservation status (*Confirmed*, *Cancelled*) |
| `seat_no`      | Assigned seat number                      |
| `booking_date` | Reservation booking date                   |

### **5. Payments**
| Column         | Description                               |
|----------------|-------------------------------------------|
| `payment_id` (PK) | Unique payment identifier               |
| `reservation_id` (FK → Reservation) | Linked reservation    |
| `amount`       | Payment amount                            |
| `method`       | Payment method (*Credit Card*, *PayPal*)  |
| `payment_date` | Date of payment                           |

---

## 📊 Analytics & Insights
- **Revenue Analysis**: Evaluate total and per-route income.  
- **Passenger Behavior**: Identify top-spending passengers and booking trends.  
- **Flight Efficiency**: Detect airlines/routes with recurring delays.  
- **Operational Trends**: Determine busiest routes and peak booking times.  

---

## 🛠️ Technology Stack
- **SQL** (Core Data Processing & Analytics)  
- **Faker** (Synthetic Data Generation)  
- **CSV / Relational DBs** (Data Storage & Testing)  

---
