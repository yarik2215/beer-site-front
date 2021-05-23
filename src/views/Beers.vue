<template>
  <div class="container">
    <!-- <button type="button" class="btn" @click="showModal">Open Modal!</button> -->

    <BeerModal v-bind:beer="modalData" v-show="isModalVisible" @close="closeModal" />

    <select v-model="order" v-on:change="getBeers(true)">
      <option selected="selected" value="-updated_at">date</option>
      <option value="-price">price from high</option>
      <option value="price">price from low</option>
      <option value="-mark">mark from high</option>
      <option value="mark">mark from low</option>
    </select>

    <li>
      <ul v-for="beer in beers" :key="beer.id">
        <div class="hov_container" @click="showModal(beer)">
          <h3>{{ beer.name }}</h3>
          <img :src="beer.image" alt="beer_img" class="small_image" />
          <p>mark: {{ beer.mark }}</p>
          <p>price: {{ beer.price }}</p>
          <p>rating: {{ beer.rating }}</p>
        </div>
      </ul>
    </li>
    <p>{{ count }} / {{ maxCount }}</p>
    <button
      v-on:click="getBeers"
      v-if="count < maxCount"
      type="button"
      class="btn btn-primary"
    >
      Load more
    </button>
  </div>
</template>

<script>
import axios from 'axios';
import BeerModal from '../components/BeerModal.vue';

export default {
  components: {
    BeerModal,
  },
  data() {
    return {
      beers: [],
      count: 0,
      order: '-updated_at',
      maxCount: 0,
      isModalVisible: false,
      modalData: null,
    };
  },
  methods: {
    getBeers(rewrite = false) {
      console.log('Get beers');
      if (rewrite === true) {
        this.beers = [];
        this.count = 0;
        this.maxCount = 0;
      }
      const path = `${process.env.VUE_APP_API_URL}/beers`;
      const params = {
        offset: this.count,
        order: this.order,
      };
      axios
        .get(path, { params })
        .then((res) => {
          this.beers = this.beers.concat(res.data.results);
          this.maxCount = res.data.count;
          this.count += res.data.results.length;
        })
        .catch((error) => {
          console.error(error);
        });
    },
    showModal(beer) {
      this.modalData = beer;
      this.isModalVisible = true;
    },
    closeModal() {
      this.isModalVisible = false;
    },
  },
  created() {
    this.getBeers();
  },
};
</script>
