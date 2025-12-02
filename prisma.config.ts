import { defineConfig } from '@prisma/config';
import * as dotenv from 'dotenv';

dotenv.config(); // load .env manually

export default defineConfig({
  schema: './prisma/schema.prisma',

  datasource: {
    url: process.env.DATABASE_URL!,
  },

  migrations: {
    seed: 'ts-node ./prisma/seed.ts',
  },
});
