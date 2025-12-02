/*
  Warnings:

  - You are about to drop the column `type` on the `LabTest` table. All the data in the column will be lost.
  - Added the required column `testType` to the `LabTest` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "LabTestType" AS ENUM ('BLOOD_CBC', 'LIPID_PROFILE', 'URINE_EXAM', 'XRAY', 'MRI', 'CT_SCAN', 'COVID_PCR');

-- AlterTable
ALTER TABLE "LabTest" DROP COLUMN "type",
ADD COLUMN     "completedAt" TIMESTAMP(3),
ADD COLUMN     "notes" TEXT,
ADD COLUMN     "requestedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "testType" "LabTestType" NOT NULL;
