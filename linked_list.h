#ifndef ASM_LINKED_LIST_H
    #define ASM_LINKED_LIST_H

    typedef struct {
        void* prev;
        void* next;
        void* data;
    } node;

    typedef struct {
        node* begin;
        node* end;
        unsigned int size;
    } list;

    list* create_list(unsigned int size);
    void delete_list(list* l);

    node* create_node(unsigned int size);
    node* delete_node(node* n);

    node* next(node* n);
    node* prev(node* n);

    void* data(node* n);
    void set_data(node* n, void* data, unsigned int size);

    node* begin(list* l);

    node* at(list* l, unsigned int at);
    
    node* end(list* l);

    node* emplace(list* l, node* at);
    // void emplace_back(node at, unsigned int size);

    // void emplace_begin(list l, unsigned int size);
    // void emplace_end(list l, unsigned int size);

#endif