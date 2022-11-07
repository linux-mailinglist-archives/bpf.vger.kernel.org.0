Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC14620354
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiKGXKA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiKGXJ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:09:59 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433CB2018E
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:09:58 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so16243110pjc.3
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vF06KNbBVxJp/htpITxfS+QnHFHn88RPU8DUmOJx618=;
        b=E1yerRJs8DRVeXpjXjzaCNP3GlmHZqu7PYpyVQS+9QvXhD7pUYVXObVqkRkuddCafQ
         YyYYQPWOawkvEWnDC0g5EW49xh/pCFkc8NFhgMEuj3HceG/C/KuujuOBj9d6J0qLJS8M
         gKthBMHDoCBVlggem7dOGnIS6uiMaJSuZ9TY3J51e/RWDSR9ktn1c3W33MI/yTG7B5fS
         3UpPShc6D6631F13QOpYwNJWRJ7YpJ6+wMlJlCljJFG7XsZ3SJNmLoOBWO79O1DtnZUK
         23MA8rKLw7vspOse7eAWjQ2cnzTzJ+xGNHgVopA4ABoIgwygVWLFyYUjv/mLOOBKW+Te
         L0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vF06KNbBVxJp/htpITxfS+QnHFHn88RPU8DUmOJx618=;
        b=xM4dYu77VWxhh2datznDO7h1D1Nme7j8+dik+YKnqg6PwRFvlIjjWdceAuhdlJOhyS
         sr1tFeQDpHUPs+t7UrEwhWPxPF8WMXyQprQ2LeUpeep6671a7lf/DW/PMqXkBfDkezFh
         lbXZknODfrxi85FyjBioHk6msDtiFxoPWV6b69yQ/pO6dxafc7wYghKC7l66QJzSVqC/
         G5hG9fO3q8KxUxVjl/d93U40xYLsVmi7/HJw9HMzv3g2b5/KF5YYU9YFI9IS/zJ25vms
         Orb3Y7uNrUiNLBUmJA1aKvCcf4kZrNgdB2h+Mycux0y3c2rmPelBaGUyb5YEWia6iiE+
         6Z5w==
X-Gm-Message-State: ACrzQf1vd4Qv15shACmcf+a7ISZSGRGDKU368JlpQdySCMCuSHzm5lXw
        2/bFNfoQdbLfjE3KVhUp7Kko2GFQQlbSnA==
X-Google-Smtp-Source: AMsMyM45zIbCB099O4TnJG+pvHF68K3Bckx3BYpypRb7HiptW9dPFr7dCHp8kOqI53RWvElCm93+FA==
X-Received: by 2002:a17:90b:2496:b0:213:e03d:bc30 with SMTP id nt22-20020a17090b249600b00213e03dbc30mr45412172pjb.109.1667862597422;
        Mon, 07 Nov 2022 15:09:57 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id s3-20020a17090a2f0300b0020dd9382124sm6585964pjd.57.2022.11.07.15.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:09:57 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 00/25] Local kptrs, BPF linked lists
Date:   Tue,  8 Nov 2022 04:39:25 +0530
Message-Id: <20221107230950.7117-1-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10940; i=memxor@gmail.com; h=from:subject; bh=cmdDr9ff4XC4bP0Ecj4SRy4WX9d7qCLx0yUJRXrmQuc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+1K32JcM1de59VCzKTZOiVaqgLiNs2qg8khvnS oc5S2SWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtQAKCRBM4MiGSL8Ryj7GD/ 9RceFo7HGMzCgm4keeNHR8cQy83eZSKVkQO1cdjApf+AWs05m989qbzWc3yH0Ttqp/wqOsG5d7IfZX gn2jFwfZoRFYTpDarp0jdrTERH91ncPSLD6J3Z508v2cFtGvTUrrXWN1uvs4F1uxwsUm11ZvcTsuMR M4UctvuR2agX5RTz0PXhn5VRlBXF3EC02iRCJTWK20Jm3D25/EQiyzM4grDVUo+dnTXWIf1Wew4ApU q2X2fsa3CSNVJirIMrK30cveRDOHrfGotDusrpJ3VgXt9BXOWpOvgv7Iu7PnzE2SioMcT+OS5trv4K MJmS6tV+xvqo9r3zkWSUH5RGZ1M4vYSwp3rKf24AuesQrF9qjxnztKB8mU0+9RY+j0recfDFcx0w+b WoeA3notX/A5CbEONPX+h5IMh2EQwZvTYML2DCbaSaArRn8hBJ0af6ATIjEHzd5brKpW2ww93nm1Do FogNiJIa3IV7BjGhn9HuJ5PnrP9010voYCU9fqZolyGQqsiKw/LqSLQYkys0lpng7eM//HizAnvYJo kPiFde2uk7ASTsgM4NK5eSbGvdPVdVLhPFkcUuXvXOpB5GKHO6n5WGqKmeBxav7vT1P5176op42PVh vdlbhJrCQ6MmsXA5REcTKNLchQ57Dd+BE5QbP3or7af8mrq9wOMicw9QsIgQ==
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

This series introduces user defined BPF objects, by introducing local
kptrs. These are kptrs (strongly typed pointers) that refer to objects
of a user defined type, hence called "local" kptrs. This allows BPF
programs to allocate their own objects, build their own object
hierarchies, and use the basic building blocks provided by BPF runtime
to build their own data structures flexibly.

Then, we introduce the support for single ownership BPF linked lists,
which can be put inside BPF maps, or local kptrs, and hold such
allocated local kptrs as elements. It works as an instrusive collection,
which is done to allow making local kptrs part of multiple data
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
- Local kptrs - User defined kernel objects.
- bpf_obj_new, bpf_obj_drop to allocate and free them.
- Single ownership BPF linked lists.
  - Support for them in BPF maps.
  - Support for them in local kptrs.
- Global spin locks.
- Spin locks inside local kptrs.

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
 * Allow RCU protected local kptrs. This then allows RCU protected list
   lookups, since spinlock protection for readers does not scale.
 * Introduce bpf_refcount for local kptrs, shared ownership.
 * Introduce shared ownership linked lists.
 * Documentation.

Changelog:
----------
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

Kumar Kartikeya Dwivedi (25):
  bpf: Remove BPF_MAP_OFF_ARR_MAX
  bpf: Fix copy_map_value, zero_map_value
  bpf: Support bpf_list_head in map values
  bpf: Rename RET_PTR_TO_ALLOC_MEM
  bpf: Rename MEM_ALLOC to MEM_RINGBUF
  bpf: Introduce local kptrs
  bpf: Recognize bpf_{spin_lock,list_head,list_node} in local kptrs
  bpf: Verify ownership relationships for user BTF types
  bpf: Allow locking bpf_spin_lock in local kptr
  bpf: Allow locking bpf_spin_lock global variables
  bpf: Allow locking bpf_spin_lock in inner map values
  bpf: Rewrite kfunc argument handling
  bpf: Drop kfunc bits from btf_check_func_arg_match
  bpf: Support constant scalar arguments for kfuncs
  bpf: Teach verifier about non-size constant arguments
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

 Documentation/bpf/kfuncs.rst                  |   30 +
 include/linux/bpf.h                           |  113 +-
 include/linux/bpf_verifier.h                  |   24 +-
 include/linux/btf.h                           |   67 +-
 include/linux/filter.h                        |    8 +-
 include/uapi/linux/bpf.h                      |   10 +
 kernel/bpf/btf.c                              |  808 +++++-----
 kernel/bpf/core.c                             |   16 +
 kernel/bpf/helpers.c                          |  143 +-
 kernel/bpf/map_in_map.c                       |    5 -
 kernel/bpf/ringbuf.c                          |    6 +-
 kernel/bpf/syscall.c                          |   30 +-
 kernel/bpf/verifier.c                         | 1346 +++++++++++++++--
 net/bpf/bpf_dummy_struct_ops.c                |   14 +-
 net/core/filter.c                             |   34 +-
 net/ipv4/bpf_tcp_ca.c                         |   13 +-
 net/netfilter/nf_conntrack_bpf.c              |   17 +-
 tools/include/uapi/linux/bpf.h                |   10 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |    1 +
 .../testing/selftests/bpf/bpf_experimental.h  |   68 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |    2 +-
 .../bpf/prog_tests/kfunc_dynptr_param.c       |    2 +-
 .../selftests/bpf/prog_tests/linked_list.c    |  524 +++++++
 .../selftests/bpf/prog_tests/spin_lock.c      |  133 ++
 .../selftests/bpf/prog_tests/spinlock.c       |   45 -
 .../testing/selftests/bpf/progs/linked_list.c |  370 +++++
 .../testing/selftests/bpf/progs/linked_list.h |   56 +
 .../selftests/bpf/progs/linked_list_fail.c    |  581 +++++++
 .../selftests/bpf/progs/test_spin_lock.c      |    4 +-
 .../selftests/bpf/progs/test_spin_lock_fail.c |  204 +++
 tools/testing/selftests/bpf/verifier/calls.c  |    2 +-
 .../selftests/bpf/verifier/ref_tracking.c     |    4 +-
 .../testing/selftests/bpf/verifier/ringbuf.c  |    2 +-
 .../selftests/bpf/verifier/spill_fill.c       |    2 +-
 34 files changed, 4012 insertions(+), 682 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_experimental.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_list.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/spin_lock.c
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/spinlock.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list.h
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_spin_lock_fail.c


base-commit: 25906092edb4bcf94cb669bd1ed03a0ef2f4120c
prerequisite-patch-id: c763e9eecf8258840e7db20e4475c26f4c7800bc
prerequisite-patch-id: 553e0a3f3035d36a96bdcc798793cbecc519d3e7
-- 
2.38.1

