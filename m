Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA86618840
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiKCTKe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKCTKd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:10:33 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714921D0C7
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:10:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so1323255pjs.4
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=At6CCJ5zjV25kLqUyQOCbVoPI7qxFhnOdpjXQ7jUutU=;
        b=hwcetPTYKgZ4vfCk8MPwLaUdjQHrhC/DqAE8/muXRWOvD5Gozp/8PkgArVeQT+waRR
         RRtbeji4ZcdrwGSYsEC7VXbsPoSGzdQiiNN/VaXKTuzG0UYVLyvKwWd73zWlY2jB/FSV
         Sg/cxW/6Slvwn54Fqda1Y6H4yfuRhgrLH+ozq747h25c5VG12dbQLEIrpSQ4AEAyOFwK
         0XN+uJUsP4SRvDSk0mNVKIVSY/NxkBm2HV/ExBHCzAQbsyNoo1uJkKrpHwbSFSdzYhhG
         cn0F2JRow7RD/rigPNM3+z8IbNiTAF3646c3WnXTCq6eW9VCAYn+Vt7VR5UcrnIOOK2/
         p05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=At6CCJ5zjV25kLqUyQOCbVoPI7qxFhnOdpjXQ7jUutU=;
        b=uHG12Svju3AaVpHdm1f3p6WhVtoBzR0hxlb64RwJqKNOipiLGjSQkFO0Qw3hwdP7d4
         J/6CuqxN3deUNtUE+brgs3CPj0aMVKN2Y9VSHlvVxAaNE5meSzrUPepfm0hQ9oxd/AQW
         x3APcAk3f4Fog6SVbBvMIkqzkgGC7TeTyb+GisBQVBbkF6z5JwwfGoVHOcB46al572Js
         LLuBxDfuUi6I3PVMuDxbMLKhSN6kBGkLQtR0H/TxpJ/a+S/01IZsdo0gt4G+ik/kYKe3
         oFeLIeM+71S5TVburR5/GFIBoOuAuCLFxRin1zG9G2VAbU6psDO0Yk5KnUUgC/2dAbpR
         O4kQ==
X-Gm-Message-State: ACrzQf1iMeQlUO8HxgLwVc7OYqR0isyOVLYg63mgC1ZJ4lT6LkghBs8G
        hVw7G4NHM7fCWvN2FQE6nhrkD6yDHCQlig==
X-Google-Smtp-Source: AMsMyM4agBUSmRsYR9J5CCtFowTIJzPUZZQRAtebli55XbYQJZWyuPCGwdy3UvL4fQxOYp9XcIfhRg==
X-Received: by 2002:a17:90a:de8e:b0:214:1066:9229 with SMTP id n14-20020a17090ade8e00b0021410669229mr15351569pjv.223.1667502631601;
        Thu, 03 Nov 2022 12:10:31 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id 6-20020a621606000000b0056ba7ce4d5asm1122773pfw.52.2022.11.03.12.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:10:31 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 00/24] Local kptrs, BPF linked lists
Date:   Fri,  4 Nov 2022 00:39:49 +0530
Message-Id: <20221103191013.1236066-1-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9709; i=memxor@gmail.com; h=from:subject; bh=0kPhY6z/bCyxmIZ8f8bY0z5IaMbYspgAJnLvjD/5dN0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIAsX/LzL1YfAWIWEs8X25FNo+I9kO516ZM7wIG BvnbXbOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAAAKCRBM4MiGSL8RyovYD/ 9bCPQSlL/p6qx4jFt109hluvHaSFRXfuUqQzb1W9RyPGhY7MaD7ko6XPiIfPrkz5EKICkTMhc+8RfP WnZa+/v+ptxdBnLX9FHVhYQnVUb3GsUnxD0KSTQxVm0GVE2hom6CZbt7n4T7al5dNWCjEro6UVBCY8 KKswGD7wal4Buq1c0ts7bSNPNGoDwnsNNeY4wsqXKS23vVskI3NnkcfhIVldJwa89Qj5hT9sa1pzdn t2a+OfKtg2HvSs6zkujpeKOn0tCl5C4Xga+gbp5+3L68xyk2y0iqBKHc1sszEWsBByVoU5zo8iEv6M temT7swkvHXYq8RasV7vHeCToRiqosHaSqtkZqf+kGMNxv3XxINfNJGh+nDr2yeBbxJSf76KbW94vX GG5lgOWg49fYWHH9JFT+lm9I42/4qAc4YLm7K8PbZqbrJpdu/WzIdUtx0IfI06cSyTXycOa+6U3fxc mEbUr/1oXjbQ9JmAZt/6WZzwDF9lyA44G70u2BbKxeB3Bq7bHNs2wYtNLI3p+CjN3vaGobDa13GEXO jklNOWFrt/y9awOpgYob9SAt4bRhx7u7IR+Nx79sjt5MZURiw9sCAd6FuFqsb81upA6AzPlaMsfRj4 BcnWf7l5GOdnY9lX7k9SV1kerx3/fu9R/4IAbO9De5YsSt8Z60qbCyZwSAsw==
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

This series introduces user defined BPF objects, by introducing the idea
of local kptrs. These are kptrs (strongly typed pointers) that refer to
objects of a user defined type, hence called "local" kptrs. This allows
BPF programs to allocate their own objects, build their own object
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
available through use of kfuncs, and structs that can be added to map value may
also change their size or name in the future. Hence, every feature in this
series must be considered experimental.

Follow-ups:
-----------
 * Support for kptrs (local and kernel) in local storage and percpu maps + kptr tests
 * Fixes for helper access checks rebasing on top of this series

Next steps:
-----------
 * NMI safe percpu single ownership linked lists (using local_t protection).
 * Lockless linked lists.
 * Allow RCU protected local kptrs. This then allows RCU protected list lookups,
   since spinlock protection for readers does not scale.
 * Introduce explicit RCU read sections (using kfuncs).
 * Introduce bpf_refcount for local kptrs, shared ownership.
 * Introduce shared ownership linked lists.
 * Documentation.

Changelog:
----------
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
  bpf: Document UAPI details for special BPF types
  bpf: Allow specifying volatile type modifier for kptrs
  bpf: Clobber stack slot when writing over spilled PTR_TO_BTF_ID
  bpf: Fix slot type check in check_stack_write_var_off
  bpf: Drop reg_type_may_be_refcounted_or_null
  bpf: Refactor kptr_off_tab into btf_record
  bpf: Consolidate spin_lock, timer management into btf_record
  bpf: Refactor map->off_arr handling
  bpf: Support bpf_list_head in map values
  bpf: Introduce local kptrs
  bpf: Recognize bpf_{spin_lock,list_head,list_node} in local kptrs
  bpf: Verify ownership relationships for user BTF types
  bpf: Support locking bpf_spin_lock in local kptr
  bpf: Allow locking bpf_spin_lock global variables
  bpf: Rewrite kfunc argument handling
  bpf: Drop kfunc bits from btf_check_func_arg_match
  bpf: Support constant scalar arguments for kfuncs
  bpf: Teach verifier about non-size constant arguments
  bpf: Introduce bpf_obj_new
  bpf: Introduce bpf_obj_drop
  bpf: Permit NULL checking pointer with non-zero fixed offset
  bpf: Introduce single ownership BPF linked list API
  selftests/bpf: Add __contains macro to bpf_experimental.h
  selftests/bpf: Add BPF linked list API tests

 Documentation/bpf/bpf_design_QA.rst           |   44 +
 Documentation/bpf/kfuncs.rst                  |   30 +
 include/linux/bpf.h                           |  256 ++-
 include/linux/bpf_verifier.h                  |   22 +-
 include/linux/btf.h                           |   77 +-
 include/linux/filter.h                        |    8 +-
 include/uapi/linux/bpf.h                      |   10 +
 kernel/bpf/arraymap.c                         |   30 +-
 kernel/bpf/bpf_local_storage.c                |    2 +-
 kernel/bpf/btf.c                              | 1205 +++++++------
 kernel/bpf/core.c                             |   16 +
 kernel/bpf/hashtab.c                          |   38 +-
 kernel/bpf/helpers.c                          |  141 +-
 kernel/bpf/local_storage.c                    |    2 +-
 kernel/bpf/map_in_map.c                       |   19 +-
 kernel/bpf/syscall.c                          |  401 +++--
 kernel/bpf/verifier.c                         | 1504 ++++++++++++++---
 net/bpf/bpf_dummy_struct_ops.c                |   14 +-
 net/core/bpf_sk_storage.c                     |    4 +-
 net/core/filter.c                             |   34 +-
 net/ipv4/bpf_tcp_ca.c                         |   13 +-
 net/netfilter/nf_conntrack_bpf.c              |   17 +-
 tools/include/uapi/linux/bpf.h                |   10 +
 tools/testing/selftests/bpf/DENYLIST.s390x    |    1 +
 .../testing/selftests/bpf/bpf_experimental.h  |   63 +
 .../bpf/prog_tests/kfunc_dynptr_param.c       |    2 +-
 .../selftests/bpf/prog_tests/linked_list.c    |   79 +
 .../testing/selftests/bpf/progs/linked_list.c |  330 ++++
 tools/testing/selftests/bpf/verifier/calls.c  |    4 +-
 .../selftests/bpf/verifier/ref_tracking.c     |    4 +-
 30 files changed, 3190 insertions(+), 1190 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_experimental.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c


base-commit: d9095f92950bd16745b9ec24ebebc12d14b3a3e8
-- 
2.38.1

