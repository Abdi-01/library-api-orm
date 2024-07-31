-- CreateTable
CREATE TABLE `BookLibrary` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `bookId` INTEGER NOT NULL,
    `libraryId` INTEGER NOT NULL,
    `copies` INTEGER NOT NULL,

    UNIQUE INDEX `id`(`id`),
    INDEX `book_library_fk1`(`bookId`),
    INDEX `book_library_fk2`(`libraryId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Book` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `bookcode` VARCHAR(255) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `author` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `publishedAt` DATE NOT NULL,
    `category` VARCHAR(255) NOT NULL,
    `createdAt` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id`(`id`),
    UNIQUE INDEX `bookcode`(`bookcode`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Library` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `library_code` VARCHAR(255) NOT NULL,
    `library_address` TEXT NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `createdAt` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id`(`id`),
    UNIQUE INDEX `library_code`(`library_code`),
    UNIQUE INDEX `email`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MemberActivity` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `staffId` INTEGER NOT NULL,
    `activity` ENUM('VISIT', 'BORROW', 'RETURN') NOT NULL DEFAULT 'VISIT',
    `createdAt` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id`(`id`),
    INDEX `member_activity_fk1`(`userId`),
    INDEX `member_activity_fk2`(`staffId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Shift` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `start` TIME(0) NOT NULL,
    `end` TIME(0) NOT NULL,
    `createdAt` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id`(`id`),
    UNIQUE INDEX `title`(`title`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `StaffDetail` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `position` VARCHAR(255) NOT NULL,
    `salary` VARCHAR(255) NOT NULL,
    `shiftId` INTEGER NOT NULL,

    UNIQUE INDEX `id`(`id`),
    INDEX `staff_detail_fk1`(`userId`),
    INDEX `staff_detail_fk4`(`shiftId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TransactionDetail` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `transactionId` INTEGER NOT NULL,
    `bookLibraryId` INTEGER NOT NULL,
    `qty` INTEGER NOT NULL,

    UNIQUE INDEX `id`(`id`),
    INDEX `transaction_detail_fk1`(`transactionId`),
    INDEX `transaction_detail_fk2`(`bookLibraryId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Transaction` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `transactionCode` VARCHAR(255) NOT NULL,
    `userId` INTEGER NOT NULL,
    `date` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `due_date` DATETIME(0) NOT NULL,
    `memberActivityId` INTEGER NOT NULL,

    UNIQUE INDEX `id`(`id`),
    UNIQUE INDEX `transactionCode`(`transactionCode`),
    INDEX `transactions_fk2`(`userId`),
    INDEX `transactions_fk5`(`memberActivityId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `usercode` VARCHAR(255) NOT NULL,
    `libraryId` INTEGER NOT NULL,
    `fullname` VARCHAR(255) NOT NULL,
    `noTelp` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `role` ENUM('MEMBER', 'STAFF') NOT NULL DEFAULT 'MEMBER',
    `createdAt` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id`(`id`),
    UNIQUE INDEX `usercode`(`usercode`),
    UNIQUE INDEX `noTelp`(`noTelp`),
    UNIQUE INDEX `email`(`email`),
    INDEX `user_fk2`(`libraryId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `BookLibrary` ADD CONSTRAINT `book_library_fk1` FOREIGN KEY (`bookId`) REFERENCES `Book`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `BookLibrary` ADD CONSTRAINT `book_library_fk2` FOREIGN KEY (`libraryId`) REFERENCES `Library`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `MemberActivity` ADD CONSTRAINT `member_activity_fk1` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `MemberActivity` ADD CONSTRAINT `member_activity_fk2` FOREIGN KEY (`staffId`) REFERENCES `User`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `StaffDetail` ADD CONSTRAINT `staff_detail_fk1` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `StaffDetail` ADD CONSTRAINT `staff_detail_fk4` FOREIGN KEY (`shiftId`) REFERENCES `Shift`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `TransactionDetail` ADD CONSTRAINT `transaction_detail_fk1` FOREIGN KEY (`transactionId`) REFERENCES `Transaction`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `TransactionDetail` ADD CONSTRAINT `transaction_detail_fk2` FOREIGN KEY (`bookLibraryId`) REFERENCES `BookLibrary`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `transactions_fk2` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `transactions_fk5` FOREIGN KEY (`memberActivityId`) REFERENCES `MemberActivity`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `user_fk2` FOREIGN KEY (`libraryId`) REFERENCES `Library`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
