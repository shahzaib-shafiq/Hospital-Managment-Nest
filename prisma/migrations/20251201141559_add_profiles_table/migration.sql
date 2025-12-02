/*
  Warnings:

  - You are about to drop the column `bloodGroup` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `emergencyContactName` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `emergencyContactPhone` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `licenseNumber` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `specialization` on the `User` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "NurseShift" AS ENUM ('MORNING', 'EVENING', 'NIGHT');

-- AlterTable
ALTER TABLE "User" DROP COLUMN "bloodGroup",
DROP COLUMN "emergencyContactName",
DROP COLUMN "emergencyContactPhone",
DROP COLUMN "licenseNumber",
DROP COLUMN "specialization";

-- CreateTable
CREATE TABLE "DoctorProfile" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "specialization" "Specialization" NOT NULL,
    "licenseNumber" TEXT,
    "experience" INTEGER,
    "consultationFee" DOUBLE PRECISION,
    "departmentId" TEXT,

    CONSTRAINT "DoctorProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PatientProfile" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "mrn" TEXT NOT NULL,
    "bloodGroup" "BloodGroup",
    "height" DOUBLE PRECISION,
    "weight" DOUBLE PRECISION,
    "allergies" TEXT,

    CONSTRAINT "PatientProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NurseProfile" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "licenseNumber" TEXT,
    "shift" "NurseShift",
    "experience" INTEGER,

    CONSTRAINT "NurseProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LabTechnicianProfile" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "qualification" TEXT,
    "specialty" TEXT,
    "experience" INTEGER,

    CONSTRAINT "LabTechnicianProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PharmacistProfile" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "licenseNumber" TEXT,
    "qualification" TEXT,
    "experience" INTEGER,

    CONSTRAINT "PharmacistProfile_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "DoctorProfile_userId_key" ON "DoctorProfile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "PatientProfile_userId_key" ON "PatientProfile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "PatientProfile_mrn_key" ON "PatientProfile"("mrn");

-- CreateIndex
CREATE UNIQUE INDEX "NurseProfile_userId_key" ON "NurseProfile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "LabTechnicianProfile_userId_key" ON "LabTechnicianProfile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "PharmacistProfile_userId_key" ON "PharmacistProfile"("userId");

-- AddForeignKey
ALTER TABLE "DoctorProfile" ADD CONSTRAINT "DoctorProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DoctorProfile" ADD CONSTRAINT "DoctorProfile_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "Department"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PatientProfile" ADD CONSTRAINT "PatientProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NurseProfile" ADD CONSTRAINT "NurseProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTechnicianProfile" ADD CONSTRAINT "LabTechnicianProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PharmacistProfile" ADD CONSTRAINT "PharmacistProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
