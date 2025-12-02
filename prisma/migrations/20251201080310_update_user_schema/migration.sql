/*
  Warnings:

  - You are about to drop the column `name` on the `User` table. All the data in the column will be lost.
  - Added the required column `role` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'Patient', 'Doctor', 'Nurse', 'Receptionist', 'Pharmacist', 'LabTechnician', 'BillingStaff', 'CleaningStaff');

-- AlterTable
ALTER TABLE "User" DROP COLUMN "name",
ADD COLUMN     "address" TEXT,
ADD COLUMN     "firstName" TEXT,
ADD COLUMN     "isDeleted" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "isVerified" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "lastName" TEXT,
ADD COLUMN     "phone" TEXT,
ADD COLUMN     "role" "Role" NOT NULL,
ADD COLUMN     "summary" TEXT;
