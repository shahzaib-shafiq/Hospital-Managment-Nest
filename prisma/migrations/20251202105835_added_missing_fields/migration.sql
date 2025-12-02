-- CreateEnum
CREATE TYPE "BedType" AS ENUM ('ICU', 'PRIVATE', 'GENERAL', 'DELUXE');

-- AlterTable
ALTER TABLE "Admission" ADD COLUMN     "attendingDoctorId" TEXT,
ADD COLUMN     "reason" TEXT;

-- AlterTable
ALTER TABLE "Appointment" ADD COLUMN     "notes" TEXT,
ADD COLUMN     "reason" TEXT;

-- AlterTable
ALTER TABLE "Bed" ADD COLUMN     "bedType" "BedType";

-- AlterTable
ALTER TABLE "DoctorProfile" ADD COLUMN     "availableFrom" TIMESTAMP(3),
ADD COLUMN     "availableTo" TIMESTAMP(3),
ADD COLUMN     "roomNumber" TEXT;

-- AlterTable
ALTER TABLE "LabTest" ADD COLUMN     "sampleCollectedById" TEXT;

-- AlterTable
ALTER TABLE "MedicalRecord" ADD COLUMN     "doctorId" TEXT;

-- AlterTable
ALTER TABLE "Medication" ADD COLUMN     "batchNo" TEXT,
ADD COLUMN     "expiryDate" TIMESTAMP(3),
ADD COLUMN     "manufacturer" TEXT;

-- AlterTable
ALTER TABLE "PatientProfile" ADD COLUMN     "alcoholUse" TEXT,
ADD COLUMN     "chronicDiseases" TEXT,
ADD COLUMN     "maritalStatus" TEXT,
ADD COLUMN     "occupation" TEXT,
ADD COLUMN     "smokingStatus" TEXT;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "avatarUrl" TEXT,
ADD COLUMN     "cnic" TEXT,
ADD COLUMN     "emergencyContactName" TEXT,
ADD COLUMN     "emergencyContactPhone" TEXT;

-- AddForeignKey
ALTER TABLE "MedicalRecord" ADD CONSTRAINT "MedicalRecord_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTest" ADD CONSTRAINT "LabTest_sampleCollectedById_fkey" FOREIGN KEY ("sampleCollectedById") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Admission" ADD CONSTRAINT "Admission_attendingDoctorId_fkey" FOREIGN KEY ("attendingDoctorId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;
