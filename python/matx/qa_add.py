#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright 2021 Josh Morman.
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

from gnuradio import gr, gr_unittest
from gnuradio import blocks
try:
    from gnuradio.matx import add
except ImportError:
    import os
    import sys
    dirname, filename = os.path.split(os.path.abspath(__file__))
    sys.path.append(os.path.join(dirname, "bindings"))
    from gnuradio.matx import add

class qa_add(gr_unittest.TestCase):

    def setUp(self):
        self.tb = gr.top_block()

    def tearDown(self):
        self.tb = None

    def test_instance(self):
        # FIXME: Test will fail until you pass sensible arguments to the constructor
        instance = add()

    def test_001_descriptive_test_name(self):
        # set up fg
        input_data = list(range(100))
        expected_output = [x+x for x in input_data]
        src1 = blocks.vector_source_f(input_data)
        src2 = blocks.vector_source_f(input_data)
        op = add()
        snk = blocks.vector_sink_f()

        self.tb.connect(src1,(op,0))
        self.tb.connect(src2,(op,1))
        self.tb.connect(op,snk)

        self.tb.run()
        
        print(snk.data())


if __name__ == '__main__':
    gr_unittest.run(qa_add)
