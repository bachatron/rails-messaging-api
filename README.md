# Messaging API

Backend API for a real-time messaging platform built with Ruby on Rails and PostgreSQL.

This project provides authentication, messaging and user management features through a RESTful API architecture designed to be consumed by a separate frontend client.

## Features

- User authentication
- Secure API endpoints
- Real-time messaging architecture
- Conversations and private messages
- PostgreSQL database integration
- JSON-based API responses
- Backend validation and error handling

## Tech Stack

- Ruby
- Ruby on Rails
- PostgreSQL
- JWT Authentication
- REST API

## Frontend Client

This API is designed to work together with the frontend client:

- [messaging-client](YOUR_LINK_HERE)

## Installation

Clone the repository:

```bash
git clone https://github.com/bachatron/messaging-api.git
cd messaging-api
```

Install dependencies:

```bash
bundle install
```

Setup the database:

```bash
rails db:create
rails db:migrate
rails db:seed
```

Start the server:

```bash
rails server
```

## Environment Variables

Create a `.env` file and configure the required environment variables:

```env
DATABASE_URL=
JWT_SECRET=
```

## API Endpoints

Example endpoints:

```text
POST   /login
POST   /signup
GET    /messages
POST   /messages
```

## Future Improvements

- WebSocket support
- Notifications
- Group conversations
- Message attachments
- Docker deployment

## Author

bachatron
