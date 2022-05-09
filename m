Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747A55207F1
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 00:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiEIWsc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 9 May 2022 18:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiEIWsb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 18:48:31 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAEC2A28C7
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 15:44:32 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 50CC6C2576C8; Mon,  9 May 2022 15:44:18 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v4 0/6] Dynamic pointers
Date:   Mon,  9 May 2022 15:42:51 -0700
Message-Id: <20220509224257.3222614-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
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
1/6 - Adds MEM_UNINIT as a bpf_type_flag
2/6 - Adds verifier support for dynptrs and implements malloc dynptrs
3/6 - Adds dynptr support for ring buffers
4/6 - Adds bpf_dynptr_read and bpf_dynptr_write
5/6 - Adds dynptr data slices (ptr to underlying dynptr memory)
6/6 - Tests to check that verifier rejects certain fail cases and passes
certain success cases

This is the first dynptr patchset in a larger series. The next series of
patches will add persisting dynamic memory allocations in maps, parsing packet
data through dynptrs, convenience helpers for using dynptrs as iterators, and
more helper functions for interacting with strings and memory dynamically.

Changelog:
----------
v4 -> v3: 
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

v3 -> v2:
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
  bpf: Add MEM_UNINIT as a bpf_type_flag
  bpf: Add verifier support for dynptrs and implement malloc dynptrs
  bpf: Dynptr support for ring buffers
  bpf: Add bpf_dynptr_read and bpf_dynptr_write
  bpf: Add dynptr data slices
  bpf: Dynptr tests

 include/linux/bpf.h                           | 107 +++-
 include/linux/bpf_verifier.h                  |  21 +
 include/uapi/linux/bpf.h                      |  96 +++
 kernel/bpf/helpers.c                          | 169 ++++-
 kernel/bpf/ringbuf.c                          |  78 +++
 kernel/bpf/verifier.c                         | 337 +++++++++-
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                |  96 +++
 .../testing/selftests/bpf/prog_tests/dynptr.c | 136 ++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 582 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 206 +++++++
 11 files changed, 1791 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_success.c

-- 
2.30.2

