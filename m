Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D3950348C
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 08:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiDPGza convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 16 Apr 2022 02:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDPGza (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 02:55:30 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CA210EC46
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 23:52:58 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id D4E74B1DE613; Fri, 15 Apr 2022 23:35:38 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, memxor@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, toke@redhat.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v2 0/7] Dynamic pointers
Date:   Fri, 15 Apr 2022 23:34:22 -0700
Message-Id: <20220416063429.3314021-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset implements the basics of dynamic pointers in bpf.

A dynamic pointer (struct bpf_dynptr) is a pointer that stores extra metadata
alongside the address it points to. This abstraction is useful in bpf, given
that every memory access in a bpf program must be safe. The verifier and bpf
helper functions can use the metadata to enforce safety guarantees for things 
such as dynamically sized strings and kernel heap allocations.

From the program side, the bpf_dynptr is an opaque struct and the verifier
will enforce that its contents are never written to by the program.
It can only be written to through specific bpf helper functions.

There are several uses cases for dynamic pointers in bpf programs. A list of
some are: dynamically sized ringbuf reservations without any extra memcpys,
dynamic string parsing and memory comparisons, dynamic memory allocations that
can be persisted in a map, and dynamic parsing of sk_buff and xdp_md packet
data.

At a high-level, the patches are as follows:
1/7 - Adds MEM_UNINIT as a bpf_type_flag
2/7 - Adds MEM_RELEASE as a bpf_type_flag
3/7 - Adds bpf_dynptr_from_mem, bpf_dynptr_alloc, and bpf_dynptr_put
4/7 - Adds bpf_dynptr_read and bpf_dynptr_write
5/7 - Adds dynptr data slices (ptr to underlying dynptr memory)
6/7 - Adds dynptr support for ring buffers
7/7 - Tests to check that verifier rejects certain fail cases and passes
certain success cases

This is the first dynptr patchset in a larger series. The next series of
patches will add persisting dynamic memory allocations in maps, parsing packet
data through dynptrs, dynptrs to referenced objects, convenience helpers for
using dynptrs as iterators, and more helper functions for interacting with
strings and memory dynamically.

Changelog:
----------
v1 -> v2:
v1: https://lore.kernel.org/bpf/20220402015826.3941317-1-joannekoong@fb.com/

1/7 -
    * Remove ARG_PTR_TO_MAP_VALUE_UNINIT alias and use
      ARG_PTR_TO_MAP_VALUE | MEM_UNINIT directly (Andrii)
    * Drop arg_type_is_mem_ptr() wrapper function (Andrii)

2/7 - 
    * Change name from MEM_RELEASE to OBJ_RELEASE (Andrii)
    * Use meta.release_ref instead of ref_obj_id != 0 to determine whether
      to release reference (Kumar)
    * Drop type_is_release_mem() wrapper function (Andrii) 
	
3/7 -
    * Add checks for nested dynptrs edge-cases, which could lead to corrupt
    * writes of the dynptr stack variable.
    * Add u64 flags to bpf_dynptr_from_mem() and bpf_dynptr_alloc() (Andrii)
    * Rename from bpf_malloc/bpf_free to bpf_dynptr_alloc/bpf_dynptr_put
      (Alexei)
    * Support alloc flag __GFP_ZERO (Andrii) 
    * Reserve upper 8 bits in dynptr size and offset fields instead of
      reserving just the upper 4 bits (Andrii)
    * Allow dynptr zero-slices (Andrii) 
    * Use the highest bit for is_rdonly instead of the 28th bit (Andrii)
    * Rename check_* functions to is_* functions for better readability
      (Andrii)
    * Add comment for code that checks the spi bounds (Andrii)

4/7 -
    * Fix doc description for bpf_dynpt_read (Toke)
    * Move bpf_dynptr_check_off_len() from function patch 1 to here (Andrii)

5/7 -
    * When finding the id for the dynptr to associate the data slice with,
      look for dynptr arg instead of assuming it is BPF_REG_1.

6/7 -
    * Add __force when casting from unsigned long to void * (kernel test robot)
    * Expand on docs for ringbuf dynptr APIs (Andrii)

7/7 -
    * Use table approach for defining test programs and error messages (Andrii)
    * Print out full log if there’s an error (Andrii)
    * Use bpf_object__find_program_by_name() instead of specifying
      program name as a string (Andrii)
    * Add 6 extra cases: invalid_nested_dynptrs1, invalid_nested_dynptrs2,
      invalid_ref_mem1, invalid_ref_mem2, zero_slice_access,
      and test_alloc_zero_bytes
    * Add checking for edge cases (eg allocing with invalid flags)

Joanne Koong (7):
  bpf: Add MEM_UNINIT as a bpf_type_flag
  bpf: Add OBJ_RELEASE as a bpf_type_flag
  bpf: Add bpf_dynptr_from_mem, bpf_dynptr_alloc, bpf_dynptr_put
  bpf: Add bpf_dynptr_read and bpf_dynptr_write
  bpf: Add dynptr data slices
  bpf: Dynptr support for ring buffers
  bpf: Dynptr tests

 include/linux/bpf.h                           | 109 ++-
 include/linux/bpf_verifier.h                  |  33 +-
 include/uapi/linux/bpf.h                      | 110 +++
 kernel/bpf/bpf_lsm.c                          |   4 +-
 kernel/bpf/btf.c                              |   3 +-
 kernel/bpf/cgroup.c                           |   4 +-
 kernel/bpf/helpers.c                          | 212 +++++-
 kernel/bpf/ringbuf.c                          |  75 +-
 kernel/bpf/stackmap.c                         |   6 +-
 kernel/bpf/verifier.c                         | 538 +++++++++++++--
 kernel/trace/bpf_trace.c                      |  30 +-
 net/core/filter.c                             |  28 +-
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                | 110 +++
 .../testing/selftests/bpf/prog_tests/dynptr.c | 138 ++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 643 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 217 ++++++
 17 files changed, 2148 insertions(+), 114 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_success.c

-- 
2.30.2

