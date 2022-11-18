Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31E962EB60
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiKRB4U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiKRB4T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:56:19 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421DA62047
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:18 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso3706617pjc.5
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HsIj2a4UHC8HcK9aSMjeItPf/beL9i6DaBoRmlOnKAo=;
        b=kVBWdtgcHSbpR0u4AbKsPr4ygDrGfLCJdzCkDZTWfrEZqTotokcOCs2UgAv0tZlWin
         ZH6u/JQ4b8bOZz/a3TBUGBtl4MSp7ZdSODN9m+JCy0rWh5P8bBVFWoERa8MkLkT+6O/X
         1W4QnQPaTn1+5PIYZXdZDHGqPpaUUsHPnCMpLEmviHphcg0xo6DXw5VwOk+dhwMPrkqY
         kV5CBbpVcVSULRuP54tDo+3i4WRdxilT2IgLw6YXUOcMwd26D4ZCqr3qg+9cu+8LpiKt
         ylTj5cQr0x1Gkfm8tYbQUX05vn1Ear7D1OAxHT0GJHflHiUmwKpJJouQK784Y4q++2/L
         uygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsIj2a4UHC8HcK9aSMjeItPf/beL9i6DaBoRmlOnKAo=;
        b=MzBdSliswidpeZ+Cc4s7aFJMZOYguHkm14VXGPBbJh/Xkk9eK9tw87yBc2+4J+I5MQ
         dM3+XfmGtrUt87XFLIw5p066r5zqzIxWN7eYr8BeRyuVqLgGPaA7riqWuk+XQub/xGlp
         1+fNnwR10re8obupEheXvNP65Mb8obSYotcsbSnMHLj3CR3EwIKRCf5zMtE/LrD/O2Fd
         UStvwzDaJ0NzrOQQ4bZ2VWs0UiA2hNO4ssUygLyc1dcas/7vDj6YWqNPSfO3doFHczWR
         59669aRke5mZ80z4XC7uTLQ/yPY6opecD6g6guQ3dl4i353yGxBtHq7zf9Q/j1liyXcl
         BXxA==
X-Gm-Message-State: ANoB5pmuMt09hRdz3hCqf6+a0EoCuDA9ZgrxCpNs+kla4W25aYIpH/Nq
        2Bw0FPLJSk72dQTOWSmbk1SnynTRIxI=
X-Google-Smtp-Source: AA0mqf5mHxCy346OB2mHW0F8o9b2pEIH7U8ArY8pc864lP9if+NdDqhA7WGE8q9pBMgsJnmKbPEgfw==
X-Received: by 2002:a17:90a:4d08:b0:218:77d8:85c4 with SMTP id c8-20020a17090a4d0800b0021877d885c4mr4506025pjg.176.1668736577436;
        Thu, 17 Nov 2022 17:56:17 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id n65-20020a17090a2cc700b001f94d25bfabsm4180289pjd.28.2022.11.17.17.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:56:16 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 00/24] Allocated objects, BPF linked lists
Date:   Fri, 18 Nov 2022 07:25:50 +0530
Message-Id: <20221118015614.2013203-1-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12357; i=memxor@gmail.com; h=from:subject; bh=yxBTNY7o8JXQqG725rB5R7C7P8Wk+ULzt+Q+5klTxdw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXNNZhzsXhGQZuBixJyc6TmZC1NsWdiOck0UPc0 2hQaQfWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzQAKCRBM4MiGSL8Rytn0D/ 442GL4MGPwPW5StQPrqa9l2WrTvNnOOtHcVxtmPboX97Sszb5ywn//N3stqOztJ/u5fb/luq9ziHrY 9A65RdJ6FYDQXzAamkQt4kukFpHS83AL4ERZAa6kDzx0Yve3746raFKXv8Z+8N7qi90ddqEGXrTJ+6 8w+8GLoa0fRVisIBddxQ6uO/MaiLCfudI366NvoqALT7bAiwwMneNRqVWpyZcBwzo+P556BmffIilL bpSz3DkL5H6gl0LKNiGIOHR5HNQTVJPWuUWKMtc2waJtNwaxbyZpMzYCiFNUeqZ5rGn+sajwV7FOlN J/NWzahkMTymbVaqN0hXA82oQwVdUZjeJWUGlxJMOK8G74Jy6+sUpCno180uJXk61zDazqCLgVc80q cI1dzNhUBXWIT72DDsew8eVKrN/GOkjYl8VdOPL4JOtLfUJOcYu+ChUxzQaMHRZhsH/QL4xdYvgJgY F48Z/ZOU9dO8oVLyu/nWdrvfolGUwd3rLotrDGuE9+LKx8buwTwoPpa2+FkRyYbvGFBP9HJ6krqgPL 0bQ0gPFye8sZZtPe07CAjmJx4w2Ry8QQ3Igg60P2btJlcw6x+Zopo0PqvinUXjQUCtBMi1to0VwTdt g8vvui+YSpqZ7N4TsgggXrOzMHt/uu1vDBvfSZ0re/qLsf+N+9tKx4bpAosg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series introduces user defined BPF objects of a type in program
BTF. This allows BPF programs to allocate their own objects, build their
own object hierarchies, and use the basic building blocks provided by
BPF runtime to build their own data structures flexibly.

Then, we introduce the support for single ownership BPF linked lists,
which can be put inside BPF maps, or allocated objects, and hold such
allocated objects as elements. It works as an instrusive collection,
which is done to allow making allocated objects part of multiple data
structures at the same time in the future.

The eventual goal of this and future patches is to allow one to do some
limited form of kernel style programming in BPF C, and allow programmers
to build their own complex data structures flexibly out of basic
building blocks.

The key difference will be that such programs are verified to be safe,
preserve runtime integrity of the system, and are proven to be bug free
as far as the invariants of BPF specific APIs are concerned.

One immediate use case that will be using the entire infrastructure this
series is introducing will be managing percpu NMI safe linked lists
inside BPF programs.

The other use case this will serve in the near future will be linking
kernel structures like XDP frame and sk_buff directly into user data
structures (rbtree, pifomap, etc.) for packet queueing. This will follow
single ownership concept included in this series.

The user has complete control of the internal locking, and hence also
the batching of operations for each critical section.

The features are:
- Allocated objects.
- bpf_obj_new, bpf_obj_drop to allocate and free them.
- Single ownership BPF linked lists.
  - Support for them in BPF maps.
  - Support for them in allocated objects.
- Global spin locks.
- Spin locks inside allocated objects.

Some other notable things:
- Completely static verification of locking.
- Kfunc argument handling has been completely reworked.
- Argument rewriting support for kfuncs.
- A new bpf_experimental.h header as a dumping ground for these APIs.

Any functionality exposed in this series is NOT part of UAPI. It is only
available through use of kfuncs, and structs that can be added to map
value may also change their size or name in the future. Hence, every
feature in this series must be considered experimental.

Follow-ups:
-----------
 * Support for kptrs (local and kernel) in local storage and percpu maps + kptr tests
 * Fixes for helper access checks rebasing on top of this series

Next steps:
-----------
 * NMI safe percpu single ownership linked lists (using local_t protection).
 * Lockless linked lists.
 * Allow RCU protected BPF allocated objects. This then allows RCU
   protected list lookups, since spinlock protection for readers does
   not scale.
 * Introduce bpf_refcount for local kptrs, shared ownership.
 * Introduce shared ownership linked lists.
 * Documentation.

Changelog:
----------
 v9 -> v10
 v9: https://lore.kernel.org/bpf/20221117225510.1676785-1-memxor@gmail.com

  * Deduplicate code to find btf_record of reg (Alexei)
  * Add linked_list test to DENYLIST.aarch64 (Alexei)
  * Disable some linked list tests for now so that they compile with
    clang nightly (Alexei)

 v8 -> v9
 v8: https://lore.kernel.org/bpf/20221117162430.1213770-1-memxor@gmail.com

  * Fix up commit log of patch 2, Simplify patch 3
  * Explain the implicit requirement of bpf_list_head requiring map BTF
    to match in btf_record_equal in a separate patch.

 v7 -> v8
 v7: https://lore.kernel.org/bpf/20221114191547.1694267-1-memxor@gmail.com

  * Fix early return in map_check_btf (Dan Carpenter)
  * Fix two memory leak bugs in local storage maps, outer maps
  * Address comments from Alexei and Dave
   * More local kptr -> allocated object renaming
   * Use krealloc with NULL instead kmalloc + krealloc
   * Drop WARN_ON_ONCE for field_offs parsing
   * Combine kfunc add + remove patches into one
   * Drop STRONG suffix from KF_ARG_PTR_TO_KPTR
   * Rename is_kfunc_arg_ret_buf_size to is_kfunc_arg_scalar_with_name
   * Remove redundant check for reg->type and arg type in it
   * Drop void * ret type check
   * Remove code duplication in checks for NULL pointer with offset != 0
   * Fix two bpf_list_node typos
   * Improve log message for bpf_list_head operations
   * Improve comments for active_lock struct
   * Improve comments for Implementation details of process_spin_lock
  * Add Dave's acks

 v6 -> v7
 v6: https://lore.kernel.org/bpf/20221111193224.876706-1-memxor@gmail.com

  * Fix uninitialized variable warning (Dan Carpenter, Kernel Test Robot)
  * One more local_kptr renaming

 v5 -> v6
 v5: https://lore.kernel.org/bpf/20221107230950.7117-1-memxor@gmail.com

  * Replace (i && !off) check with next_off, include test (Andrii)
  * Drop local kptrs naming (Andrii, Alexei)
  * Drop reg->precise == EXACT patch (Andrii)
  * Add comment about ptr member of struct active_lock (Andrii)
  * Use btf__new_empty + btf__add_xxx APIs (Andrii)
  * Address other misc nits from Andrii

 v4 -> v5
 v4: https://lore.kernel.org/bpf/20221103191013.1236066-1-memxor@gmail.com

  * Add a lot more selftests (failure, success, runtime, BTF)
  * Make sure series is bisect friendly
  * Move list draining out of spin lock
    * This exposed an issue where bpf_mem_free can now be called in
      map_free path without migrate_disable, also fixed that.
  * Rename MEM_ALLOC -> MEM_RINGBUF, MEM_TYPE_LOCAL -> MEM_ALLOC (Alexei)
  * Group lock identity into a struct active_lock { ptr, id } (Dave)
  * Split set_release_on_unlock logic into separate patch (Alexei)

 v3 -> v4
 v3: https://lore.kernel.org/bpf/20221102202658.963008-1-memxor@gmail.com

  * Fix compiler error for !CONFIG_BPF_SYSCALL (Kernel Test Robot)
  * Fix error due to BUILD_BUG_ON on 32-bit platforms (Kernel Test Robot)

 v2 -> v3
 v2: https://lore.kernel.org/bpf/20221013062303.896469-1-memxor@gmail.com

  * Add ack from Dave for patch 5
  * Rename btf_type_fields -> btf_record, btf_type_fields_off ->
    btf_field_offs, rename functions similarly (Alexei)
  * Remove 'kind' component from contains declaration tag (Alexei)
  * Move bpf_list_head, bpf_list_node definitions to UAPI bpf.h (Alexei)
  * Add note in commit log about modifying btf_struct_access API (Dave)
  * Downgrade WARN_ON_ONCE to verbose(env, "...") and return -EFAULT (Dave)
  * Add type_is_local_kptr wrapper to avoid noisy checks (Dave)
  * Remove unused flags parameter from bpf_kptr_new (Alexei)
  * Rename bpf_kptr_new -> bpf_obj_new, bpf_kptr_drop -> bpf_obj_drop (Alexei)
  * Reword comment in ref_obj_id_set_release_on_unlock (Dave)
  * Fix return type of ref_obj_id_set_release_on_unlock (Dave)
  * Introduce is_bpf_list_api_kfunc to dedup checks (Dave)
  * Disallow BPF_WRITE to untrusted local kptrs
  * Add details about soundness of check_reg_allocation_locked logic
  * List untrusted local kptrs for PROBE_MEM handling

 v1 -> v2
 v1: https://lore.kernel.org/bpf/20221011012240.3149-1-memxor@gmail.com

  * Rebase on bpf-next to resolve merge conflict in DENYLIST.s390x
  * Fix a couple of mental lapses in bpf_list_head_free

 RFC v1 -> v1
 RFC v1: https://lore.kernel.org/bpf/20220904204145.3089-1-memxor@gmail.com

  * Mostly a complete rewrite of BTF parsing, refactor existing code (Kartikeya)
  * Rebase kfunc rewrite for bpf-next, add support for more changes
  * Cache type metadata in BTF to avoid recomputation inside verifier (Kartikeya)
  * Remove __kernel tag, make things similar to map values, reserve bpf_ prefix
  * bpf_kptr_new, bpf_kptr_drop
  * Rename precision state enum values (Alexei)
  * Drop explicit constructor/destructor support (Alexei)
  * Rewrite code for constructing/destructing objects and offload to runtime
  * Minimize duplication in bpf_map_value_off_desc handling (Alexei)
  * Expose global memory allocator (Alexei)
  * Address other nits from Alexei
  * Split out local kptrs in maps, more kptrs in maps support into a follow up

Links:
------
 * Dave's BPF RB-Tree RFC series
   v1 (Discussion thread)
     https://lore.kernel.org/bpf/20220722183438.3319790-1-davemarchevsky@fb.com
   v2 (With support for static locks)
     https://lore.kernel.org/bpf/20220830172759.4069786-1-davemarchevsky@fb.com
 * BPF Linked Lists Discussion
   https://lore.kernel.org/bpf/CAP01T74U30+yeBHEgmgzTJ-XYxZ0zj71kqCDJtTH9YQNfTK+Xw@mail.gmail.com
 * BPF Memory Allocator from Alexei
   https://lore.kernel.org/bpf/20220902211058.60789-1-alexei.starovoitov@gmail.com
 * BPF Memory Allocator UAPI Discussion
   https://lore.kernel.org/bpf/d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com

Kumar Kartikeya Dwivedi (24):
  bpf: Fix early return in map_check_btf
  bpf: Do btf_record_free outside map_free callback
  bpf: Free inner_map_meta when btf_record_dup fails
  bpf: Populate field_offs for inner_map_meta
  bpf: Introduce allocated objects support
  bpf: Recognize lock and list fields in allocated objects
  bpf: Verify ownership relationships for user BTF types
  bpf: Allow locking bpf_spin_lock in allocated objects
  bpf: Allow locking bpf_spin_lock global variables
  bpf: Allow locking bpf_spin_lock in inner map values
  bpf: Rewrite kfunc argument handling
  bpf: Support constant scalar arguments for kfuncs
  bpf: Introduce bpf_obj_new
  bpf: Introduce bpf_obj_drop
  bpf: Permit NULL checking pointer with non-zero fixed offset
  bpf: Introduce single ownership BPF linked list API
  bpf: Add 'release on unlock' logic for bpf_list_push_{front,back}
  bpf: Add comments for map BTF matching requirement for bpf_list_head
  selftests/bpf: Add __contains macro to bpf_experimental.h
  selftests/bpf: Update spinlock selftest
  selftests/bpf: Add failure test cases for spin lock pairing
  selftests/bpf: Add BPF linked list API tests
  selftests/bpf: Add BTF sanity tests
  selftests/bpf: Temporarily disable linked list tests

 Documentation/bpf/kfuncs.rst                  |   24 +
 include/linux/bpf.h                           |   51 +-
 include/linux/bpf_verifier.h                  |   25 +-
 include/linux/btf.h                           |   67 +-
 kernel/bpf/arraymap.c                         |    1 -
 kernel/bpf/btf.c                              |  656 ++++-----
 kernel/bpf/core.c                             |   16 +
 kernel/bpf/hashtab.c                          |    1 -
 kernel/bpf/helpers.c                          |  115 +-
 kernel/bpf/map_in_map.c                       |   48 +-
 kernel/bpf/syscall.c                          |   42 +-
 kernel/bpf/verifier.c                         | 1220 +++++++++++++++--
 tools/testing/selftests/bpf/DENYLIST.aarch64  |    1 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |    1 +
 .../testing/selftests/bpf/bpf_experimental.h  |   68 +
 .../bpf/prog_tests/kfunc_dynptr_param.c       |    2 +-
 .../selftests/bpf/prog_tests/linked_list.c    |  747 ++++++++++
 .../selftests/bpf/prog_tests/spin_lock.c      |  136 ++
 .../selftests/bpf/prog_tests/spinlock.c       |   45 -
 .../testing/selftests/bpf/progs/linked_list.c |  379 +++++
 .../testing/selftests/bpf/progs/linked_list.h |   58 +
 .../selftests/bpf/progs/linked_list_fail.c    |  581 ++++++++
 .../selftests/bpf/progs/test_spin_lock.c      |    4 +-
 .../selftests/bpf/progs/test_spin_lock_fail.c |  204 +++
 tools/testing/selftests/bpf/verifier/calls.c  |    2 +-
 .../selftests/bpf/verifier/ref_tracking.c     |    4 +-
 26 files changed, 3931 insertions(+), 567 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_experimental.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_list.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/spin_lock.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/spinlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list.h
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_spin_lock_fail.c


base-commit: 98b2afc8a67f651ed01fc7d5a7e2528e63dd4e08
-- 
2.38.1

