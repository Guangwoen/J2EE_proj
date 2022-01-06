package com.example.firstweb;

public class Car {
    private String driver;
    private String car_Number;
    private int status;

    /* Status: 0 -> available, 1 -> not available. */

    public void setStatus(int status) { this.status = status; }

    public int getStatus() {return this.status; }

    public void setDriver(String driver) {
        this.driver = driver;
    }

    public String getDriver() {
        return this.driver;
    }

    public void setCar_Number(String car_Number) {
        this.car_Number = car_Number;
    }

    public String getCar_Number() {
        return this.car_Number;
    }
}
