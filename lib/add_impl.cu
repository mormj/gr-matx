/* -*- c++ -*- */
/*
 * Copyright 2021 Josh Morman.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#include "add_impl.h"
#include <gnuradio/io_signature.h>
#include <gnuradio/cuda/cuda_buffer.h>

#include "matx.h"

namespace gr {
namespace matx {

using input_type = float;
using output_type = float;
add::sptr add::make() { return gnuradio::make_block_sptr<add_impl>(); }

/*
 * The private constructor
 */
add_impl::add_impl()
    : gr::sync_block("add",
                     gr::io_signature::make(
                         1, 1, sizeof(input_type), gr::cuda_buffer::type),
                     gr::io_signature::make(
                         1, 1, sizeof(output_type), gr::cuda_buffer::type))
{
}

/*
 * Our virtual destructor.
 */
add_impl::~add_impl() {}

int add_impl::work(int noutput_items,
                   gr_vector_const_void_star& input_items,
                   gr_vector_void_star& output_items)
{
    auto in = static_cast<const input_type*>(input_items[0]);
    auto out = static_cast<output_type*>(output_items[0]);


    // Tell runtime system how many output items we produced.
    return noutput_items;
}

} /* namespace matx */
} /* namespace gr */
