Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B9D5AC662
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiIDUlz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiIDUlx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:41:53 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1202CDD8
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:41:51 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qh18so13444536ejb.7
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=WphmO4IcoQ/49qKsy1N0eAukHn1cQ3PnWSSxMxTscv4=;
        b=BOMAQzdScnaDOsoWcpuOkLfcr62f/PepUkTegVOGxLP3KfsSe2Vwu/5Zul74uWl24r
         i3WE25IRbjgfd46uK+/XGDUNQN4kxxlGBP5fRqhRv8EkLUit+oA2kxUvj/nxPune84sz
         vZT5kmuOWSxJN5iy3Acwwfl4U+aN5Rx32Kc0AcCa9z0Xbd0i0XYYEu6+7O6h+zbu9giZ
         CoEayPJ8VbYsppgMh/nVsZrRysxfJPnI5j2wsQZcTc7eUktiTusuiB77VWTgtRsDhsxE
         c9Iqeq+XOZLcaAW9sEe2s2ZXugdB28N75gFi57TOo1xjbNtV8XMiVvWfLx2FwIXrRROk
         ZtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=WphmO4IcoQ/49qKsy1N0eAukHn1cQ3PnWSSxMxTscv4=;
        b=6U8rmcNODjR15u2t6YETLmK5yCzmMEXNYt9fpG5CV+L7go1PcY7V52j28KnpyFUZCE
         fo9VseaOdKt7e0xahsjv2P847374PRjkK7YKo20yDnoeTyoOahHt0pYCdrFq25NI4Q2V
         kaUm0Y5lDjtrg3Z7jLO0T1m89BjQbEeSbGQYinLnz46BWS5vN24kPSOhBRnUF+s4Bd3I
         YMgbjj6FlkRpGr89W9rHo4i1p2A515b6AvsYSjpXv/vkIe0CQUMV2jzNGG2jhPbudonn
         iX7XDhqJKj/9nhrkYFzcs4pI0uHTtbFQnvxpT4VHKASWMZm1oxnOOd1OWCNbroH6+EqH
         Q7eg==
X-Gm-Message-State: ACgBeo0JkzesOycHe89bFtRWrj/MkdQUABkwoVoQSvwY599hZIILESDp
        eFzFHvS326G2EoNlQZXxvrBvzapbiDy7VA==
X-Google-Smtp-Source: AA6agR7P5E/ydpIXwMInM6fgiNc/CqK85TD0vxdoxB4xTpN7KQ1OPAZ6rR7IskOLKKziZx1Y6NKp5g==
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id nd23-20020a170907629700b0072f9aad0fcbmr33204788ejc.161.1662324109426;
        Sun, 04 Sep 2022 13:41:49 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id nd38-20020a17090762a600b007341663d7ddsm4197369ejc.96.2022.09.04.13.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:41:49 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 00/32] Local kptrs, BPF linked lists
Date:   Sun,  4 Sep 2022 22:41:13 +0200
Message-Id: <20220904204145.3089-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8842; i=memxor@gmail.com; h=from:subject; bh=ONR5P3wgbA/X1sDOuACWQRnGwqmZiigSMiZFN0mttzw=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1v+bQ6/2RwCIsVBqz1rbiggFdnL4Zjk5YUqKrY p21bTr2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNbwAKCRBM4MiGSL8RytKjD/ 4kx/GxSUbwCd3hLh/LkUQ24yrFv3goRn6xD3H3vjdPk8lz3efkCInhjbIr45pvUzFMs3VxJoEIMCVf AGoM9zuC/xNYvAhFiUDsw9hjvDV8Mc9ReaHUp5N9eyUufNSqmCVfVf3euPIMVlg/p4At5Nhhm2qkgd IzxzLBHAB6UjsGypBNBm6bn2HPA+Frqu7Q8njvRFaCXTUeSaqCF5RCRVwuzFBN85/e9Wwqr4blKXwn a/N2KswEYG08imW0qPolKqzoB0L/GApFfV4ZML5k3gKsaGmcgmyGXC5av1gvOUGZ21MJpwYXpzGkfV nF71iaVJcgM6/zATjInxxulV0FvDyzDmyPgAolaMjah3VWBxTaT6KsV547rHQKtjhViTYEI4QgLpjL xoVE64kYEXATvmUqAwnzcGz1FoA6hnYt7kPYtq8cLItlwG6hpRlDP/gczRi5VshKpPA0IdRRj0UagY Aq3c06nKNSLZG9vBbRC+1X6hXXZ1So0TdAwEvctJWnGW8XwBo89Sd4DV38QElYSn/Q+Pm3arbaKFPp XoEgSgMO15FfKcWP/RIMOWWEAge6RewnPV7sSB3ICfJSyaA2BwEIJFO1ccdXBk9bVTbd4SV5ZcZqz1 7aWJFG3ecCLtGVl9dppO2jlzfQDZp0TiNE+di7cb4qn0ZIRtvAWfcyrMETug==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

WARNING: This is an RFC. WARN_ON_ONCE is sprinkled around the code liberally
(useful while working on this stuff). I'll be doing a thorough pass and clean
all that up before sending out non-RFC v1.
TODO before non-RFC v1.
 - A lot more corner case tests, failure tests, more tests for the new local
   kptr support. I did test the basic stuff (which the verifier complained
   about when writing linked_list.c).
 - More tests for kptr support in new map types.
 - More self review.

--

This series introduces user defined BPF objects, by introducing the idea of
local kptrs. These are kptrs (strongly typed pointers) that refer to objects of
a user defined type, hence called "local" kptrs. This allows BPF programs to
allocate their own objects, build their own object hierarchies, and use the
basic building blocks provided by BPF runtime to build their own data structures
flexibly.

Then, we introduce the support for single ownership BPF linked lists, which can
be put inside BPF maps, or local kptrs, and hold such allocated local kptrs as
elements. It works as an instrusive collection, which is done to allow making
local kptrs part of multiple data structures at the same time in the future.

The eventual goal of this and future patches is to allow one to do some limited
form of kernel style programming in BPF C, and allow programmers to build their
own complex data structures flexibly out of basic building blocks.

The key difference will be that such programs are verified to be safe, preserve
runtime integrity of the system, and are proven to be bug free as far as the
invariants of BPF specific APIs are concerned.

One immediate use case that will be using the entire infrastructure this series
is introducing will be managing percpu NMI safe linked lists inside BPF
programs.

The other use case this will serve in the near future will be linking kernel
structures like XDP frame and sk_buff directly into user data structures
(rbtree, pifomap, etc.) for packet queueing. This will follow single ownership
concept included in this series.

The user has complete control of the internal locking, and hence also the
batching of operations for each critical section.

Eventually, with some more support in future patches, users will be able to
write fully concurrent RCU protected hash table using BPF_MAP_TYPE_ARRAY for
buckets and embed BPF linked lists in these buckets. All of this will be
possible in safe BPF C, which will be proven for runtime safety by the BPF
verifier.

The features, core infrastructure, and other improvements in this set are:
- Allow storing kptrs in local storage and percpu maps.
- Local kptrs - User defined kernel objects.
- bpf_kptr_alloc, bpf_kptr_free to allocate and free them.
- BPF memory object model, similar to what C and C++ abstract machines have,
  now verifier reasons about an object's lifetime, i.e. the concept of object
  lifetime, visibility, construction, destruction is reified.
  The separation of storage and object lifetime is understood by the verifier.
- Single ownership BPF linked lists.
  - Support for them in BPF maps.
  - Support for them in local kptrs.
- Global spin locks.
- Spin locks inside local kptrs.
- Allow storing local kptrs in all BPF maps with support for kernel kptrs.

Some other notable things:
- Completely static verification of locking.
- Kfunc argument handling has been completely reworked.
- Argument rewriting support for kfuncs.
  Now we can also support inlining block of BPF insns for certain kfuncs.
- Iteration over all registers in verifier state has a new lambda based
  iterator (and can be nifty or crazy - depending on your love for GNU C).
- Search pruning now understands non-size precise registers.
- A new bpf_experimental.h header as a dumping ground for these APIs.

Any functionality exposed in this series is **NOT** part of UAPI. It is only
available through use of kfuncs, and structs that can be added to map value may
also change their size or name in the future. Hence, every feature in this
series must be considered **EXPERIMENTAL**.

Next steps:
-----------
 * NMI safe percpu single ownership linked lists (using local_t protection).
  - This enables open coded freelist use case
 * Lockless linked lists.
 * Allow RCU protected local kptrs. This then allows RCU protected list lookups,
   since spinlock protection for readers does not scale.
 * Introduce explicit RCU read sections (using kfuncs).
 * Introduce bpf_refcount for local kptrs, shared ownership.
 * Introduce shared ownership linked lists.
 * Documentation.

Notes:
------
 * Delyan's work to expose Alexei's BPF memory allocator as global allocator
   is still needed before this can be merged. For now, direct kmalloc and
   kfree is used.

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

Daniel Xu (1):
  bpf: Remove duplicate PTR_TO_BTF_ID RO check

Dave Marchevsky (1):
  libbpf: Add support for private BSS map section

Kumar Kartikeya Dwivedi (30):
  bpf: Add copy_map_value_long to copy to remote percpu memory
  bpf: Support kptrs in percpu arraymap
  bpf: Add zero_map_value to zero map value with special fields
  bpf: Support kptrs in percpu hashmap and percpu LRU hashmap
  bpf: Support kptrs in local storage maps
  bpf: Annotate data races in bpf_local_storage
  bpf: Allow specifying volatile type modifier for kptrs
  bpf: Add comment about kptr's PTR_TO_MAP_VALUE handling
  bpf: Rewrite kfunc argument handling
  bpf: Drop kfunc support from btf_check_func_arg_match
  bpf: Support constant scalar arguments for kfuncs
  bpf: Teach verifier about non-size constant arguments
  bpf: Introduce bpf_list_head support for BPF maps
  bpf: Introduce bpf_kptr_alloc helper
  bpf: Add helper macro bpf_expr_for_each_reg_in_vstate
  bpf: Introduce BPF memory object model
  bpf: Support bpf_list_node in local kptrs
  bpf: Support bpf_spin_lock in local kptrs
  bpf: Support bpf_list_head in local kptrs
  bpf: Introduce bpf_kptr_free helper
  bpf: Allow locking bpf_spin_lock global variables
  bpf: Bump BTF_KFUNC_SET_MAX_CNT
  bpf: Add single ownership BPF linked list API
  bpf: Permit NULL checking pointer with non-zero fixed offset
  bpf: Allow storing local kptrs in BPF maps
  bpf: Wire up freeing of bpf_list_heads in maps
  bpf: Add destructor for bpf_list_head in local kptr
  selftests/bpf: Add BTF tag macros for local kptrs, BPF linked lists
  selftests/bpf: Add BPF linked list API tests
  selftests/bpf: Add referenced local kptr tests

 Documentation/bpf/kfuncs.rst                  |   30 +
 include/linux/bpf.h                           |  177 +-
 include/linux/bpf_local_storage.h             |    2 +-
 include/linux/bpf_verifier.h                  |   77 +-
 include/linux/btf.h                           |   76 +-
 include/linux/poison.h                        |    3 +
 kernel/bpf/arraymap.c                         |   43 +-
 kernel/bpf/bpf_local_storage.c                |   53 +-
 kernel/bpf/btf.c                              |  727 +++---
 kernel/bpf/hashtab.c                          |   91 +-
 kernel/bpf/helpers.c                          |  137 +-
 kernel/bpf/map_in_map.c                       |    5 +-
 kernel/bpf/syscall.c                          |  231 +-
 kernel/bpf/verifier.c                         | 2084 ++++++++++++++---
 net/bpf/bpf_dummy_struct_ops.c                |    5 +-
 net/ipv4/bpf_tcp_ca.c                         |    5 +-
 tools/lib/bpf/libbpf.c                        |   65 +-
 .../testing/selftests/bpf/bpf_experimental.h  |  120 +
 .../selftests/bpf/prog_tests/linked_list.c    |   88 +
 .../selftests/bpf/prog_tests/map_kptr.c       |    2 +-
 .../testing/selftests/bpf/progs/linked_list.c |  347 +++
 tools/testing/selftests/bpf/progs/map_kptr.c  |   38 +
 tools/testing/selftests/bpf/verifier/calls.c  |    2 +-
 23 files changed, 3626 insertions(+), 782 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_experimental.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c

-- 
2.34.1

