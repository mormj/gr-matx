/* -*- c++ -*- */
/*
 * Copyright 2021 Josh Morman.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#ifndef INCLUDED_MATX_ADD_H
#define INCLUDED_MATX_ADD_H

#include <gnuradio/matx/api.h>
#include <gnuradio/sync_block.h>

namespace gr {
namespace matx {

/*!
 * \brief <+description of block+>
 * \ingroup matx
 *
 */
class MATX_API add : virtual public gr::sync_block
{
public:
    typedef std::shared_ptr<add> sptr;

    /*!
     * \brief Return a shared_ptr to a new instance of matx::add.
     *
     * To avoid accidental use of raw pointers, matx::add's
     * constructor is in a private implementation
     * class. matx::add::make is the public interface for
     * creating new instances.
     */
    static sptr make();
};

} // namespace matx
} // namespace gr

#endif /* INCLUDED_MATX_ADD_H */
