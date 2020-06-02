async function print(message) {
  const { default: print } = await import(
    /* webpackChunkName: "print" */ "./print"
  );
  print(message);
}

const ButtonHook = {
  async mounted() {
    this.el.addEventListener("click", async () => {
      print("clicked");
    });
  },
};

export default ButtonHook;
