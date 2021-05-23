import { createRouter, createWebHistory } from 'vue-router';
import Beers from '../views/Beers.vue';

const routes = [
  {
    path: '/',
    name: 'Beers',
    component: Beers,
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
