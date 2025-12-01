/*
  Warnings:

  - The values [LabTechnician,BillingStaff,CleaningStaff] on the enum `Role` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `summary` on the `User` table. All the data in the column will be lost.
  - Made the column `firstName` on table `User` required. This step will fail if there are existing NULL values in that column.
  - Made the column `lastName` on table `User` required. This step will fail if there are existing NULL values in that column.
  - Changed the type of `role` on the `User` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('ADMIN', 'DOCTOR', 'NURSE', 'RECEPTIONIST', 'LAB_TECHNICIAN', 'PHARMACIST', 'PATIENT');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE', 'OTHER');

-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('ACTIVE', 'SUSPENDED', 'ARCHIVED');

-- CreateEnum
CREATE TYPE "BloodGroup" AS ENUM ('A_POS', 'A_NEG', 'B_POS', 'B_NEG', 'AB_POS', 'AB_NEG', 'O_POS', 'O_NEG');

-- CreateEnum
CREATE TYPE "Specialization" AS ENUM ('CARDIOLOGY', 'DERMATOLOGY', 'PEDIATRICS', 'ORTHOPEDICS', 'NEUROLOGY', 'RADIOLOGY', 'ONCOLOGY', 'PSYCHIATRY', 'GENERAL_MEDICINE', 'ENT', 'GASTROENTEROLOGY', 'NEPHROLOGY', 'UROLOGY', 'OPHTHALMOLOGY', 'GYNECOLOGY', 'PULMONOLOGY', 'RHEUMATOLOGY', 'NONE');

-- AlterEnum
BEGIN;
CREATE TYPE "Role_new" AS ENUM ('ADMIN', 'Patient', 'Doctor', 'Nurse', 'Receptionist', 'Pharmacist', 'Lab_Technician', 'Billing_Staff', 'Cleaning_Staff');
ALTER TYPE "Role" RENAME TO "Role_old";
ALTER TYPE "Role_new" RENAME TO "Role";
DROP TYPE "public"."Role_old";
COMMIT;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "summary",
ADD COLUMN     "bloodGroup" "BloodGroup",
ADD COLUMN     "dateOfBirth" TIMESTAMP(3),
ADD COLUMN     "emergencyContactName" TEXT,
ADD COLUMN     "emergencyContactPhone" TEXT,
ADD COLUMN     "gender" "Gender",
ADD COLUMN     "licenseNumber" TEXT,
ADD COLUMN     "specialization" "Specialization",
ADD COLUMN     "status" "UserStatus" NOT NULL DEFAULT 'ACTIVE',
ALTER COLUMN "firstName" SET NOT NULL,
ALTER COLUMN "lastName" SET NOT NULL,
DROP COLUMN "role",
ADD COLUMN     "role" "UserRole" NOT NULL;
