-- CreateEnum
CREATE TYPE "RoomType" AS ENUM ('Single', 'Double', 'Triple', 'Quadraple');

-- CreateTable
CREATE TABLE "Admission" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "bedId" TEXT,
    "admittedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dischargedAt" TIMESTAMP(3),

    CONSTRAINT "Admission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ward" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "floor" TEXT,
    "gender" "Gender",
    "building" TEXT NOT NULL,
    "rent" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "Ward_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Room" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "floor" TEXT,
    "gender" "Gender",
    "building" TEXT NOT NULL,
    "rent" DOUBLE PRECISION NOT NULL,
    "type" "RoomType" NOT NULL,
    "wardId" TEXT NOT NULL,

    CONSTRAINT "Room_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bed" (
    "id" TEXT NOT NULL,
    "roomId" TEXT NOT NULL,
    "number" INTEGER NOT NULL,
    "occupied" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Bed_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Admission" ADD CONSTRAINT "Admission_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Admission" ADD CONSTRAINT "Admission_bedId_fkey" FOREIGN KEY ("bedId") REFERENCES "Bed"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Room" ADD CONSTRAINT "Room_wardId_fkey" FOREIGN KEY ("wardId") REFERENCES "Ward"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bed" ADD CONSTRAINT "Bed_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "Room"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
