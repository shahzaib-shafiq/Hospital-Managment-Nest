import { PrismaClient } from '@prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
import { Pool } from 'pg';

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

const adapter = new PrismaPg(pool);

const prisma = new PrismaClient({
  adapter,
});

async function main() {
  console.log("🌱 Seeding database...");

  // ----------------------------------------------------
  // 1. Departments
  // ----------------------------------------------------
  const cardiology = await prisma.department.create({
    data: {
      name: "Cardiology",
      code: "CARD",
      description: "Heart & cardiovascular treatments",
      phone: "021-111-222",
      location: "Block A, Level 2"
    }
  });

  const emergency = await prisma.department.create({
    data: {
      name: "Emergency",
      code: "ER",
      description: "24/7 Emergency",
      phone: "021-999-111",
      location: "Ground Floor"
    }
  });

  // ----------------------------------------------------
  // 2. Users (Admin, Doctor, Nurse, Patient, Technician, Pharmacist)
  // ----------------------------------------------------
  const admin = await prisma.user.create({
    data: {
      firstName: "System",
      lastName: "Admin",
      email: "admin@hms.com",
      password: "admin123",
      role: "ADMIN"
    }
  });

  const doctor = await prisma.user.create({
    data: {
      firstName: "John",
      lastName: "Doe",
      email: "doctor@hms.com",
      password: "pass123",
      role: "DOCTOR",
      departmentId: cardiology.id
    }
  });

  const nurse = await prisma.user.create({
    data: {
      firstName: "Sarah",
      lastName: "Nurse",
      email: "nurse@hms.com",
      password: "pass123",
      role: "NURSE",
      departmentId: emergency.id
    }
  });

  const patient = await prisma.user.create({
    data: {
      firstName: "Michael",
      lastName: "Scott",
      email: "patient@hms.com",
      password: "pass123",
      role: "PATIENT"
    }
  });

  const pharmacist = await prisma.user.create({
    data: {
      firstName: "Linda",
      lastName: "Pharma",
      email: "pharmacy@hms.com",
      password: "pass123",
      role: "PHARMACIST"
    }
  });

  const labTech = await prisma.user.create({
    data: {
      firstName: "Rob",
      lastName: "Tech",
      email: "lab@hms.com",
      password: "pass123",
      role: "LAB_TECHNICIAN"
    }
  });

  // ----------------------------------------------------
  // 3. Profiles
  // ----------------------------------------------------
  await prisma.doctorProfile.create({
    data: {
      userId: doctor.id,
      specialization: "CARDIOLOGY",
      licenseNumber: "DOC-12345",
      experience: 8,
      consultationFee: 1500,
      departmentId: cardiology.id
    }
  });

  await prisma.patientProfile.create({
    data: {
      userId: patient.id,
      mrn: "MRN-001",
      bloodGroup: "A_POS",
      height: 175,
      weight: 70
    }
  });

  await prisma.nurseProfile.create({
    data: {
      userId: nurse.id,
      licenseNumber: "NRS-8832",
      experience: 5
    }
  });

  await prisma.labTechnicianProfile.create({
    data: {
      userId: labTech.id,
      qualification: "BS Medical Lab Tech",
      specialty: "Hematology",
      experience: 3
    }
  });

  await prisma.pharmacistProfile.create({
    data: {
      userId: pharmacist.id,
      qualification: "Pharm-D",
      licenseNumber: "PHRM-9921",
      experience: 4
    }
  });

  // ----------------------------------------------------
  // 4. Create rooms, wards, beds
  // ----------------------------------------------------
  const wardA = await prisma.ward.create({
    data: {
      name: "Ward A",
      building: "Block B",
      rent: 800,
      floor: "1"
    }
  });

  const room101 = await prisma.room.create({
    data: {
      name: "Room 101",
      floor: "1",
      building: "Block B",
      rent: 3500,
      type: "PRIVATE",
      wardId: wardA.id
    }
  });

  const bed1 = await prisma.bed.create({
    data: {
      number: 1,
      roomId: room101.id
    }
  });

  // ----------------------------------------------------
  // 5. Admission
  // ----------------------------------------------------
  const admission = await prisma.admission.create({
    data: {
      patientId: patient.id,
      bedId: bed1.id,
      attendingDoctorId: doctor.id
    }
  });

  // ----------------------------------------------------
  // 6. Appointment
  // ----------------------------------------------------
  const appointment = await prisma.appointment.create({
    data: {
      doctorId: doctor.id,
      patientId: patient.id,
      date: new Date(),
      status: "SCHEDULED"
    }
  });

  // ----------------------------------------------------
  // 7. Vital Signs
  // ----------------------------------------------------
  await prisma.vitalSign.create({
    data: {
      patientId: patient.id,
      nurseId: nurse.id,
      temperature: 98.6,
      pulse: 78,
      respiration: 18,
      bloodPressure: "120/80"
    }
  });

  // ----------------------------------------------------
  // 8. Allergy
  // ----------------------------------------------------
  await prisma.allergy.create({
    data: {
      patientId: patient.id,
      name: "Penicillin",
      severity: "High",
      notes: "Rash and swelling"
    }
  });

  // ----------------------------------------------------
  // 9. Procedure
  // ----------------------------------------------------
  await prisma.procedure.create({
    data: {
      patientId: patient.id,
      doctorId: doctor.id,
      name: "Angiography",
      notes: "Mild blockage detected"
    }
  });

  // ----------------------------------------------------
  // 10. Medications
  // ----------------------------------------------------
  const med1 = await prisma.medication.create({
    data: {
      name: "Aspirin",
      stock: 200,
      price: 10
    }
  });

  const med2 = await prisma.medication.create({
    data: {
      name: "Atorvastatin",
      stock: 150,
      price: 25
    }
  });

  // ----------------------------------------------------
  // 11. Prescription
  // ----------------------------------------------------
  const prescription = await prisma.prescription.create({
    data: {
      doctorId: doctor.id,
      patientId: patient.id
    }
  });

  await prisma.prescriptionItem.createMany({
    data: [
      {
        prescriptionId: prescription.id,
        medicationId: med1.id,
        dosage: "75mg",
        frequency: "Once daily"
      },
      {
        prescriptionId: prescription.id,
        medicationId: med2.id,
        dosage: "20mg",
        frequency: "Once daily"
      }
    ]
  });

  // ----------------------------------------------------
  // 12. Lab Test + Result
  // ----------------------------------------------------
  const labTest = await prisma.labTest.create({
    data: {
      doctorId: doctor.id,
      patientId: patient.id,
      testType: "BLOOD_CBC",
      status: "COMPLETED",
      sampleCollectedById: labTech.id
    }
  });

  await prisma.labResult.create({
    data: {
      labTestId: labTest.id,
      result: "Hemoglobin: Normal, WBC: Normal"
    }
  });

  // ----------------------------------------------------
  // 13. Radiology Test
  // ----------------------------------------------------
  await prisma.radiologyTest.create({
    data: {
      patientId: patient.id,
      doctorId: doctor.id,
      type: "XRAY",
      status: "COMPLETED",
      resultUrl: "https://example.com/radiology/xray1.png"
    }
  });

  // ----------------------------------------------------
  // 14. Invoice + Payment
  // ----------------------------------------------------
  const invoice = await prisma.invoice.create({
    data: {
      patientId: patient.id,
      amount: 5000,
      status: "UNPAID"
    }
  });

  await prisma.billingItem.createMany({
    data: [
      {
        invoiceId: invoice.id,
        description: "Consultation Fee",
        amount: 1500
      },
      {
        invoiceId: invoice.id,
        description: "Lab Test",
        amount: 2000
      },
      {
        invoiceId: invoice.id,
        description: "Room Charges",
        amount: 1500
      }
    ]
  });

  await prisma.payment.create({
    data: {
      invoiceId: invoice.id,
      amount: 2000,
      method: "CASH"
    }
  });

  console.log("🌱 Seed completed successfully!");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
