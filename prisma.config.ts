import { defineConfig } from '@prisma/config';
import * as dotenv from 'dotenv';

dotenv.config(); // load .env manually

export default defineConfig({
  schema: './prisma/schema.prisma',

  datasource: {
    url: process.env.DATABASE_URL!,
  },

  migrations: {
    // Prisma 7 supports only these fields
    path: './prisma/migrations',
  },
});
