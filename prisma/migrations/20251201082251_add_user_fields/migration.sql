-- Enums
CREATE TYPE "UserRole" AS ENUM ('ADMIN', 'DOCTOR', 'NURSE', 'RECEPTIONIST', 'LAB_TECHNICIAN', 'PHARMACIST', 'PATIENT');
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE', 'OTHER');
CREATE TYPE "UserStatus" AS ENUM ('ACTIVE', 'SUSPENDED', 'ARCHIVED');
CREATE TYPE "BloodGroup" AS ENUM ('A_POS', 'A_NEG', 'B_POS', 'B_NEG', 'AB_POS', 'AB_NEG', 'O_POS', 'O_NEG');
CREATE TYPE "Specialization" AS ENUM ('CARDIOLOGY', 'DERMATOLOGY', 'PEDIATRICS', 'ORTHOPEDICS', 'NEUROLOGY', 'RADIOLOGY', 'ONCOLOGY', 'PSYCHIATRY', 'GENERAL_MEDICINE', 'ENT', 'GASTROENTEROLOGY', 'NEPHROLOGY', 'UROLOGY', 'OPHTHALMOLOGY', 'GYNECOLOGY', 'PULMONOLOGY', 'RHEUMATOLOGY', 'NONE');

-- Replace old Role enum
BEGIN;
CREATE TYPE "Role_new" AS ENUM ('ADMIN', 'Patient', 'Doctor', 'Nurse', 'Receptionist', 'Pharmacist', 'Lab_Technician', 'Billing_Staff', 'Cleaning_Staff');
ALTER TYPE "Role" RENAME TO "Role_old";
ALTER TYPE "Role_new" RENAME TO "Role";
COMMIT;

-- Drop column BEFORE dropping old enum
ALTER TABLE "User" DROP COLUMN "role";

-- Now drop old enum safely
DROP TYPE "Role_old";

-- Add new role column
ALTER TABLE "User" ADD COLUMN "role" "UserRole" NOT NULL DEFAULT 'PATIENT';

-- Rest of table modifications
ALTER TABLE "User"
    DROP COLUMN "summary",
    ADD COLUMN "bloodGroup" "BloodGroup",
    ADD COLUMN "dateOfBirth" TIMESTAMP(3),
    ADD COLUMN "emergencyContactName" TEXT,
    ADD COLUMN "emergencyContactPhone" TEXT,
    ADD COLUMN "gender" "Gender",
    ADD COLUMN "licenseNumber" TEXT,
    ADD COLUMN "specialization" "Specialization",
    ADD COLUMN "status" "UserStatus" NOT NULL DEFAULT 'ACTIVE',
    ALTER COLUMN "firstName" SET NOT NULL,
    ALTER COLUMN "lastName" SET NOT NULL;
