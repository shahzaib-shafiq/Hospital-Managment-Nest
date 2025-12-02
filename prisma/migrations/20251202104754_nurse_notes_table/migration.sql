-- CreateTable
CREATE TABLE "NursingNote" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "nurseId" TEXT NOT NULL,
    "note" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "NursingNote_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "NursingNote" ADD CONSTRAINT "NursingNote_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NursingNote" ADD CONSTRAINT "NursingNote_nurseId_fkey" FOREIGN KEY ("nurseId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
