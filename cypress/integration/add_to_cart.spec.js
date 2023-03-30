describe("Jungle App", () => {
  beforeEach("Loads homepage", () => {
    cy.visit("/");
  });

  it("Cart displays quantity of zero", () => {
    cy.contains("My Cart (0)");
  });

  it("Cart displays quantity of one after adding to cart", () => {
    // Add product to cart
    cy.get("form.button_to").first().submit();
    // Check for updated quantity on cart
    cy.contains("My Cart (1)");
  });
})