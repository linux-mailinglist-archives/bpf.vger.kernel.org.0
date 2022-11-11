Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E73E6261F4
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiKKTcg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiKKTcf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:32:35 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D21F787B6
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:32:34 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o13so5117124pgu.7
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svT6hxxvLoNqAnu7mNpdnleWhMevJhBaj8ySfbivMSc=;
        b=kx28rHn8aLlxnZ2CGXgS+cWSopEj9fiseGhbWGz8EQKV4MHt4nAKaHpM84YwSUs0rk
         X9kMbfpjHHxs5qjrbPUbN7jMJc/ONavVRyCdqRRaw9Z+F95VLZViLmyKxALROOBEzh6f
         x3VsWElIL56b+BAWjR14/JaacJuRloqAyJjiYBxZjsBod2Kng7R63S4+7rUHm8DT8EEE
         NQTWVFxCqpy2/+0/k571A/uhDkXh4EEpy1+xNJtZPjXY9zS4HRjggs/HG9lTC4xATL3p
         BYpj7EsQlBsEKvkAqCsiGvL7o9tBymtQoyv+A+eVZKWudrdYAuS+ZzfkGnJWMpLopDLI
         QzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svT6hxxvLoNqAnu7mNpdnleWhMevJhBaj8ySfbivMSc=;
        b=KeKgn9h2rUsIsNcsDj8S6ZLOGo/Hc7Gw8ANJG0kKIo0AFgbVGnLOfaiN1bvGxXRUx/
         dTPcPiFp4z4GqET+KUuvE1RIQUb9oqf3dMmKlpwvVKIi0lHQfOu7Tby2JckLoVcpiDMf
         5G/ixl8/C+L/C4V4TsUaz0XH881wYk0t9ZzeReNaYwjTGcIstKCHUOL9YHK11LzUem59
         SlDe4mAa29vQ4+rlzJC8SGtxYg6oLoQ7qY/fMTHzo690bf7ZGIMf7vmG3WMQGkAYskKS
         Y9b0PpN/IZ0P2T4Vd8fH5OzXjFR3sE7Frfth5QNaOLRdvt45B50ZIRsVeXbKr3i5UytC
         Pd6w==
X-Gm-Message-State: ANoB5pkOz9sDtNyqUAxTM7RQYmXOai8CvdIXGM6phkx1QhhvIWEhrM3Q
        UOg+EnVw7ygfDaBP60JfAZOCeCeoZMjDPw==
X-Google-Smtp-Source: AA0mqf7jiHKPleKU3NFozZLjOvWQ0fn9NboWCkSG7btMbSws7SpwY4BZDp0EaCp5m7qVzkGJ1lyaOQ==
X-Received: by 2002:a63:4f25:0:b0:460:633b:5702 with SMTP id d37-20020a634f25000000b00460633b5702mr2987272pgb.9.1668195153273;
        Fri, 11 Nov 2022 11:32:33 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id h7-20020a635747000000b0046ff3634a78sm1684448pgm.71.2022.11.11.11.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:32:32 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 00/26] Allocated objects, BPF linked lists
Date:   Sat, 12 Nov 2022 01:01:58 +0530
Message-Id: <20221111193224.876706-1-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11344; i=memxor@gmail.com; h=from:subject; bh=qLqNx6TQel1LjCQHlnUw3hw5f0F/91vZHrmsMqp3Hs4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqInpx8vcmSJVbMkAJbI0dAE+3d+mise1kP6es8W 2bKdxmKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iJwAKCRBM4MiGSL8RyjKCD/ wLlwiGSdYa+5yxWfTno3TBu1y415xoZskDxaHCdoYrR+m3NBxrqgmZ7UjUVQ3/FrmN1gTkQ3lWLfdW Hzu9HR/N5fLWqnCzsCx2Pf1czm/iGlM+4C3dfh/vtRDJVTuISXhz1UjM7JqC+ve5X0z2+3FD7ggO19 56iWahpTJ9l429QgKwa7YXXo+K480jxUHijyhCrVF8lhRP+vHarULx0Nv0Jm1NwYq7FIZSqJ50kWNK pvnkZ9gHm9MowQXnvlOdHe9HsQ3limmjCHUGge+lw+dRj8R1HTL21kzN7ObmkZq6m2Y45HMvC5if6V UxoZYMfw5rwR+hJ9AlDV2YXizYdDU8O/XJrlqibBG08P9Csg93n7iSakzfL3msjycwxTkeifWXWXMF 1ElkDBIBfb2rwdx+hQlwwZ0AyJdhUnstBtZ4uxFc0d2vOwQuRKK8AIZBR0GsKAREqD2s8wVbdgcpoV +ZvXTliyNNF1NycgZpz5SSIY8rYnP4JS2Hdtm2Hgd7TIvieDSS9LkVMFLwYkdRjkXafbyFOTcI2fXt OXGfWVamvHoGtdrg0KUWwAeqZY+pIRucdjUIRy56CjHYV7ti75eLFPd6Hht4bGdXGx1pWqFE6BRhf0 iT/F9zdDhpe/Fyk2XWTavAELbeYJPHG6LoFeabttImC9sORFlTHhFspWSSYg==
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
- Search pruning now understands non-size precise registers.
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

Kumar Kartikeya Dwivedi (26):
  bpf: Remove local kptr references in documentation
  bpf: Remove BPF_MAP_OFF_ARR_MAX
  bpf: Fix copy_map_value, zero_map_value
  bpf: Support bpf_list_head in map values
  bpf: Rename RET_PTR_TO_ALLOC_MEM
  bpf: Rename MEM_ALLOC to MEM_RINGBUF
  bpf: Refactor btf_struct_access
  bpf: Introduce allocated objects support
  bpf: Recognize lock and list fields in allocated objects
  bpf: Verify ownership relationships for user BTF types
  bpf: Allow locking bpf_spin_lock in allocated objects
  bpf: Allow locking bpf_spin_lock global variables
  bpf: Allow locking bpf_spin_lock in inner map values
  bpf: Rewrite kfunc argument handling
  bpf: Drop kfunc bits from btf_check_func_arg_match
  bpf: Support constant scalar arguments for kfuncs
  bpf: Introduce bpf_obj_new
  bpf: Introduce bpf_obj_drop
  bpf: Permit NULL checking pointer with non-zero fixed offset
  bpf: Introduce single ownership BPF linked list API
  bpf: Add 'release on unlock' logic for bpf_list_push_{front,back}
  selftests/bpf: Add __contains macro to bpf_experimental.h
  selftests/bpf: Update spinlock selftest
  selftests/bpf: Add failure test cases for spin lock pairing
  selftests/bpf: Add BPF linked list API tests
  selftests/bpf: Add BTF sanity tests

 Documentation/bpf/bpf_design_QA.rst           |   11 +-
 Documentation/bpf/kfuncs.rst                  |   22 +
 include/linux/bpf.h                           |  113 +-
 include/linux/bpf_verifier.h                  |   19 +-
 include/linux/btf.h                           |   67 +-
 include/linux/filter.h                        |    8 +-
 include/uapi/linux/bpf.h                      |   10 +
 kernel/bpf/btf.c                              |  810 +++++------
 kernel/bpf/core.c                             |   16 +
 kernel/bpf/helpers.c                          |  143 +-
 kernel/bpf/map_in_map.c                       |    5 -
 kernel/bpf/ringbuf.c                          |    6 +-
 kernel/bpf/syscall.c                          |   30 +-
 kernel/bpf/verifier.c                         | 1239 +++++++++++++++--
 net/bpf/bpf_dummy_struct_ops.c                |   14 +-
 net/core/filter.c                             |   34 +-
 net/ipv4/bpf_tcp_ca.c                         |   13 +-
 net/netfilter/nf_conntrack_bpf.c              |   17 +-
 tools/include/uapi/linux/bpf.h                |   10 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |    1 +
 .../testing/selftests/bpf/bpf_experimental.h  |   68 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |    2 +-
 .../bpf/prog_tests/kfunc_dynptr_param.c       |    2 +-
 .../selftests/bpf/prog_tests/linked_list.c    |  738 ++++++++++
 .../selftests/bpf/prog_tests/spin_lock.c      |  136 ++
 .../selftests/bpf/prog_tests/spinlock.c       |   45 -
 .../testing/selftests/bpf/progs/linked_list.c |  370 +++++
 .../testing/selftests/bpf/progs/linked_list.h |   56 +
 .../selftests/bpf/progs/linked_list_fail.c    |  581 ++++++++
 .../selftests/bpf/progs/test_spin_lock.c      |    4 +-
 .../selftests/bpf/progs/test_spin_lock_fail.c |  204 +++
 tools/testing/selftests/bpf/verifier/calls.c  |    2 +-
 .../selftests/bpf/verifier/ref_tracking.c     |    4 +-
 .../testing/selftests/bpf/verifier/ringbuf.c  |    2 +-
 .../selftests/bpf/verifier/spill_fill.c       |    2 +-
 35 files changed, 4160 insertions(+), 644 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_experimental.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_list.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/spin_lock.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/spinlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list.h
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_spin_lock_fail.c


base-commit: e5659e4e19e49f1eac58bb07ce8bc2d78a89fe65
--
2.38.1

