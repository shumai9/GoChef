'use strict';

class Carousel {
  constructor(selector, user_options = {}){
    var default_options = {delay: 3000, autoadvance: true, buttons: false, transition: 'fade'};
    this.options = Object.assign(default_options, user_options);

    this.el = document.querySelector(selector);
    this.el.classList.add('carousel');
    this.el.classList.add(this.options.transition);
    this.imgs = this.el.querySelectorAll('img');
    this.currentImg = 0;
    this.showImg();

    if(this.options.buttons){
      this.setupButtons();
    }else{
      this.el.addEventListener('click', this.advance.bind(this));
    }
    if(this.options.autoadvance){
      this.setupTimer(this.options.delay);
    }
  }

  setupButtons(){
    var prev_button = document.createElement('button');
    prev_button.innerHTML = "<<";
    prev_button.className = "prev";
    var next_button = document.createElement('button');
    next_button.innerHTML = ">>";
    next_button.className = "next";
    var controls = document.createElement('div');
    controls.className = "controls";
    controls.appendChild(prev_button);
    controls.appendChild(next_button);
    this.el.appendChild(controls);
    prev_button.addEventListener('click', this.retreat.bind(this));
    next_button.addEventListener('click', this.advance.bind(this));
  }

  setupTimer(delay){
    setInterval(this.advance.bind(this), delay);
  }

  retreat(){
    this.currentImg--;
    if(this.currentImg < 0){
      this.currentImg = this.imgs.length-1;
    }
    this.showImg();
  }

  advance(){
    this.currentImg++;
    if(this.currentImg == this.imgs.length){
      this.currentImg = 0;
    }
    this.showImg();
  }

  showImg(){
    if(this.options.transition === 'fade'){
      for(let index=0; index<this.imgs.length; index++){
        if(this.currentImg == index){
          this.imgs[index].classList.add('show');
        }else{
          this.imgs[index].classList.remove('show');
        }
      }
    }
    if(this.options.transition === 'slide'){
      for(let index=0; index<this.imgs.length; index++){
        // Remove the classes
        this.imgs[index].classList.remove('left');
        this.imgs[index].classList.remove('centre');
        this.imgs[index].classList.remove('right');
        var waiting = this.imgs[index].classList.contains('waiting');
        this.imgs[index].classList.remove('waiting');

        // Work out the next and previous images
        var prevImg = this.currentImg - 1;
        if(prevImg < 0){
          prevImg = this.imgs.length - 1;
        }

        var nextImg = this.currentImg + 1;
        if(nextImg >= this.imgs.length){
          nextImg = 0;
        }

        // Add the correct class
        if(index === this.currentImg){
          this.imgs[index].classList.remove('hidden');
          this.imgs[index].classList.add('centre');
        }else if(index == prevImg){
          if(waiting){
            this.imgs[index].classList.add('hidden');
          }
          this.imgs[index].classList.add('left');
        }else if(index == nextImg){
          this.imgs[index].classList.add('right');
        }else{
          this.imgs[index].classList.add('waiting');
        }

      }
    }

  }
}

document.addEventListener('DOMContentLoaded', function(){
  new Carousel('#gallery', {transition: 'slide', autoadvance: true, buttons: true});
});