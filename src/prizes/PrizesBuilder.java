package prizes;

public class PrizesBuilder {
String name;
String image;
String price;
String description;
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getImage() {
	return image;
}
public void setImage(String image) {
	this.image = image;
}
public String getPrice() {
	return price;
}
public void setPrice(String price) {
	this.price = price;
}
public String getDescription() {
	return description;
}
public void setDescription(String description) {
	this.description = description;
}
public PrizesBuilder(String name, String image, String price, String description) {
	super();
	this.name = name;
	this.image = image;
	this.price = price;
	this.description = description;
}
	

}
