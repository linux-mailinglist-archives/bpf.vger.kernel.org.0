Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC098531D5A
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 23:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiEWVHo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 23 May 2022 17:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiEWVHn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 17:07:43 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91207980B
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 14:07:40 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id EBEE8CC6620B; Mon, 23 May 2022 14:07:26 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v6 0/6] Dynamic pointers
Date:   Mon, 23 May 2022 14:07:06 -0700
Message-Id: <20220523210712.3641569-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset implements the basics of dynamic pointers in bpf.

A dynamic pointer (struct bpf_dynptr) is a pointer that stores extra metadata
alongside the address it points to. This abstraction is useful in bpf given
that every memory access in a bpf program must be safe. The verifier and bpf
helper functions can use the metadata to enforce safety guarantees for things 
such as dynamically sized strings and kernel heap allocations.

From the program side, the bpf_dynptr is an opaque struct and the verifier
will enforce that its contents are never written to by the program.
It can only be written to through specific bpf helper functions.

There are several uses cases for dynamic pointers in bpf programs. Some
examples include: dynamically sized ringbuf reservations without extra
memcpys, dynamic string parsing and memory comparisons, dynamic memory
allocations that can be persisted in maps, and dynamic + ergonomic parsing of
sk_buff and xdp_md packet data.

At a high-level, the patches are as follows:
1/6 - Adds verifier support for dynptrs
2/6 - Adds bpf_dynptr_from_mem (local dynptr)
3/6 - Adds dynptr support for ring buffers
4/6 - Adds bpf_dynptr_read and bpf_dynptr_write
5/6 - Adds dynptr data slices (ptr to the dynptr data)
6/6 - Tests to check that the verifier rejects invalid cases and passes valid ones

This is the first dynptr patchset in a larger series. The next series of
patches will add dynptrs that support dynamic memory allocations that can also
be persisted in maps, support for parsing packet data through dynptrs, convenience
helpers for using dynptrs as iterators, and more helper functions for interacting
with strings and memory dynamically.

Changelog:
----------
v5 -> v6:
v5:
https://lore.kernel.org/bpf/20220520044245.3305025-1-joannelkoong@gmail.com/
* enforce PTR_TO_MAP_VALUE for bpf_dynptr_from_mem data in check_helper_call
instead of using DYNPTR_TYPE_LOCAL when checking func arg compatiblity
* remove MEM_DYNPTR modifier

v4 -> v5:
v4:
https://lore.kernel.org/bpf/20220509224257.3222614-1-joannelkoong@gmail.com/
* Remove malloc dynptr; this will be part of the 2nd patchset while we
figure out memory accounting
* For data slices, only set the register's ref_obj_id to dynptr_id (Alexei)
* Tidying (eg remove "inline", move offset checking to "check_func_arg_reg_off")
(David)
* Add a few new test cases, remove malloc-only ones.

v3 -> v4: 
v3:
https://lore.kernel.org/bpf/20220428211059.4065379-1-joannelkoong@gmail.com/
1/6 - Change mem ptr + size check to use more concise inequality expression
(David + Andrii) 
2/6 - Add check for meta->uninit_dynptr_regno not already set (Andrii)
      Move DYNPTR_TYPE_FLAG_MASK to include/linux/bpf.h (Andrii) 
3/6 - Remove four underscores for invoking BPF_CALL (Andrii)
      Add __BPF_TYPE_FLAG_MAX and use it for __BPF_TYPE_LAST_FLAG (Andrii)
4/6 - Fix capacity to be bpf_dynptr size value in check_off_len (Andrii)
      Change -EINVAL to -E2BIG if len + offset is out of bounds (Andrii)
5/6 - Add check for only 1 dynptr arg for dynptr data function (Andrii)
6/6 - For ringbuf map, set max_entries from userspace (Andrii)
      Use err ?: ... for interactring with dynptr APIs (Andrii)
      Define array_map2 for add_dynptr_to_map2 test where value is a struct
with an embedded dynptr
      Remove ref id from missing_put_callback message, since on different
environments, ref id is not always = 1

v2 -> v3:
v2:
https://lore.kernel.org/bpf/20220416063429.3314021-1-joannelkoong@gmail.com/
* Reorder patches (move ringbuffer patch to be right after the verifier +
* malloc
dynptr patchset)
* Remove local type dynptrs (Andrii + Alexei)
* Mark stack slot as STACK_MISC after any writes into a dynptr instead of
* explicitly prohibiting writes (Alexei)
* Pass number of slots, not memory size to is_spi_bounds_valid (Kumar) 
* Check reference leaks by adding dynptr id to state->refs instead of checking
stack slots (Alexei)

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
    * Add __force when casting from unsigned long to void * (kernel test
    * robot)
    * Expand on docs for ringbuf dynptr APIs (Andrii)
7/7 -
    * Use table approach for defining test programs and error messages
    * (Andrii)
    * Print out full log if there’s an error (Andrii)
    * Use bpf_object__find_program_by_name() instead of specifying
      program name as a string (Andrii)
    * Add 6 extra cases: invalid_nested_dynptrs1, invalid_nested_dynptrs2,
      invalid_ref_mem1, invalid_ref_mem2, zero_slice_access,
      and test_alloc_zero_bytes
    * Add checking for edge cases (eg allocing with invalid flags)

Joanne Koong (6):
  bpf: Add verifier support for dynptrs
  bpf: Add bpf_dynptr_from_mem for local dynptrs
  bpf: Dynptr support for ring buffers
  bpf: Add bpf_dynptr_read and bpf_dynptr_write
  bpf: Add dynptr data slices
  selftests/bpf: Dynptr tests

 include/linux/bpf.h                           |  42 ++
 include/linux/bpf_verifier.h                  |  20 +
 include/uapi/linux/bpf.h                      |  83 +++
 kernel/bpf/helpers.c                          | 177 ++++++
 kernel/bpf/ringbuf.c                          |  78 +++
 kernel/bpf/verifier.c                         | 267 +++++++-
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |  83 +++
 .../testing/selftests/bpf/prog_tests/dynptr.c | 137 ++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 588 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 164 +++++
 11 files changed, 1636 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_success.c

-- 
2.30.2

