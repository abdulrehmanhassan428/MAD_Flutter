Q1. extends vs implements
1- extends: A subclass gets the parent class's fields, methods, and implementation for free. It only needs to add or override what is necessary.
2- implements: A class must provide its own implementation of all instance methods, getters, setters, and other instance members required by the interface.

Q2. Mixin vs Abstract Parent Class
Mixin: Use it when unrelated classes, such as Book and Dvd, need the same reusable behavior, like Renewable, without sharing a parent class.
Abstract parent class: Use it when classes share a common identity, state, and base implementation, such as Book and Dvd both extending LibraryItem.


Q3. Why override hashCode when overriding ==?
If two objects are equal according to ==, they must have the same hashCode. Otherwise, collections such as Set and Map may fail to find or handle equal objects correctly.
