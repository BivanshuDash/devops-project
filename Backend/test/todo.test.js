import { expect } from 'chai';
import request from 'supertest';
import express from 'express';
import initApp from '../src/modules/index.router.js';

describe('Todo API', () => {
  let app;
  before(async () => {
    app = express();
    await initApp(app, express);
  });

  it('should return todos', async () => {
    const res = await request(app).get('/todos');
    expect(res.status).to.equal(200);
    expect(res.body).to.have.property('todos');
    expect(res.body).to.have.property('numOfPages');
  });
});