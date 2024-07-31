import dotenv from "dotenv";
dotenv.config();
import express, { Express, Request, Response } from "express";
import cors from "cors";
import { PrismaClient } from "@prisma/client";

const PORT = process.env.PORT;

class App {
  readonly app: Express;

  constructor() {
    this.app = express();
    this.configure();
    this.routes();
  }

  //   configure methode
  private configure(): void {
    this.app.use(cors());
    this.app.use(express.json());
  }

  //   To define routes or controllers config api
  private routes(): void {
    this.app.get("/api", (req: Request, res: Response) => {
      return res.status(200).send("<h1>Welcome to Library API</h1>");
    });

    // instance prismaClient
    const prisma = new PrismaClient();

    this.app.get("/api/books", async (req: Request, res: Response) => {
      try {
        const books = await prisma.book.findMany({
          include: {
            book_library: {
              select: {
                copies: true,
                library: {
                  select: {
                    id: true,
                    library_code: true,
                    library_address: true,
                  },
                },
              },
            },
          },
        });

        return res.status(200).send({
          success: true,
          result: books,
        });
      } catch (error) {
        console.log(error);
      }
    });
  }

  public async start(): Promise<void> {
    this.app.listen(PORT, () =>
      console.log(
        `PRISMA API for LIBRARY APP RUNNING : http://localhost:${PORT}`
      )
    );
  }
}

export default App;
