package com.example.firstweb;

import com.example.firstweb.Car;
import com.sun.xml.internal.bind.v2.runtime.reflect.Lister;

public class Packet {
    private String packet_ID;
    private String packet_Name;
    private String sender;
    private String receiver;
    private String i_phone_Number;
    private String o_phone_number;
    private Car car_Info;
    private String weight;
    private String volume;
    private int status;

    // Packet status: 0 -> 未发货, 1 -> 已发货, 2 -> 已收货

    public Packet(){}

    public Packet(String pid, String pnm, String sd, String rc, String ipn, String opn, Car c, String wt, String vl) {
        this.packet_ID = pid;
        this.packet_Name = pnm;
        this.sender = sd;
        this.receiver = rc;
        this.i_phone_Number = ipn;
        this.o_phone_number = opn;
        this.car_Info = c;
        this.weight = wt;
        this.volume = vl;
    }
    public int getStatus() { return status; }

    public void setStatus(int status) { this.status = status; }

    public String getVolume() {
        return volume;
    }

    public void setVolume(String volume) {
        this.volume = volume;
    }

    public String getWeight() {
        return this.weight;
    }

    public void setWeight(String weight) {
        this.weight = weight;
    }

    public void setPacket_ID(String Packet_ID) { this.packet_ID = Packet_ID; }

    public String getPacket_ID() {
        return this.packet_ID;
    }

    public void setPacket_Name(String packet_Name) {
        this.packet_Name = packet_Name;
    }

    public String getPacket_Name() {
        return this.packet_Name;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getSender() {
        return this.sender;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getReceiver() {
        return this.receiver;
    }

    public void setI_Phone_Number(String phone_Number) {
        this.i_phone_Number = phone_Number;
    }

    public String getI_Phone_Number() {
        return this.i_phone_Number;
    }

    public void setO_phone_number(String phone_number) {
        this.o_phone_number = phone_number;
    }

    public String getO_phone_number() {
        return this.o_phone_number;
    }

    public void setCar_Info(Car car_Info) {
        this.car_Info = car_Info;
    }

    public Car getCar_Info() {
        return this.car_Info;
    }
}
