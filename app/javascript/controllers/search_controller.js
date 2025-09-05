import { Controller } from "@hotwired/stimulus";

/*export default class SearchController extends Controller {
  //static targets = ["input", "clearSearch"];

  connect() {
   // this.toggleClearButton();
   console.log("SearchController connected");
  }

  toggleClearButton() {
    //this.clearButtonTarget.classList.toggle("hidden", this.inputTarget.value.trim() === "");
    console.log("Input value:", this.inputTarget.value);
  }

  clearSearch() {
    this.inputTarget.value = "";
    this.toggleClearButton();
  }
}*/

class SearchController extends Controller {

    static targets = ["searchInput", "clearSearch"];

    toggleClearButton() {
        if (this.searchInputTarget.value) {
            this.clearSearchTarget.classList.remove("hidden");
        } else {
            this.clearSearchTarget.classList.add("hidden");
        }
    }
}

export default SearchController;