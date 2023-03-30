describe("Jungle App", () => {
  beforeEach("Loads homepage", () => {
    cy.visit("/");
  });

  it("Loads product detail page when clicked", () => {
    // Clicks product on homepage
    cy.get("[alt='Scented Blade']").click();
    // Product name visible on product detail page
    cy.contains("Scented Blade");
  })
})