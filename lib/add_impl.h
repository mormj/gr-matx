/* -*- c++ -*- */
/*
 * Copyright 2021 Josh Morman.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#ifndef INCLUDED_MATX_ADD_IMPL_H
#define INCLUDED_MATX_ADD_IMPL_H

#include <gnuradio/matx/add.h>

namespace gr {
namespace matx {

class add_impl : public add
{
private:
    // Nothing to declare in this block.

public:
    add_impl();
    ~add_impl();

    // Where all the action really happens
    int work(int noutput_items,
             gr_vector_const_void_star& input_items,
             gr_vector_void_star& output_items);
};

} // namespace matx
} // namespace gr

#endif /* INCLUDED_MATX_ADD_IMPL_H */
