import { defineConfig } from '@prisma/config';
import * as dotenv from 'dotenv';

// Load .env manually
dotenv.config();

console.log("DATABASE_URL =", process.env.DATABASE_URL);

export default defineConfig({
  schema: './prisma/schema.prisma',

  datasource: {
    url: process.env.DATABASE_URL!,
  },

  migrations: {
    connectionString: process.env.DATABASE_URL!,
  },
});
