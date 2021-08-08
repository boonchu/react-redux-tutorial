export const ADD_TO_CART = 'ADD_TO_CART'
export const DELETE_CART = 'DELETE_CART'

export function addToCart(addedProduct) {
	// payload: { id: '', title: '', price: 2, quantity: 1 }
	return {
		type: ADD_TO_CART,
		payload: addedProduct
	}
}

export function deleteCart(id) {
	return {
		type: DELETE_CART,
		payload: id
	}
}
