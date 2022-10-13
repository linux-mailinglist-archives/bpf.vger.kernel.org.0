Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AB15FD4AA
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJMGXO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMGXN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:23:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9EB120BF2
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f193so805718pgc.0
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pYL0hIlGGom/gyKspkiSHFAbG+mfCuIMaZyW204mIzM=;
        b=IWi42QdMnFo0mlzBekj6GcclkG+84XwZNNYqrnn9LvtyvTDq9qH5dI1URgezCFLlHw
         I3QIp5DM4HaTS7/OtgRXNKIhMpLt7aiO8weTcmcVH59M5rQ4a8N7CtnWGxzY7W0eLF0K
         Hd/XLBTsv/fnmKwY4Xsqdc8buazz1YcbkcNknJFQAcp3T1sQub0lEWkFuJV9aND+9RPb
         MSqtfh8UFnzrTYCBJIYbZshk15b8Nwhm9flbehhEZDjHGsbBK53gGdj3cG2eJ4rF/x3t
         JV/6Y3bRt2NwRJ/1g/CLlvEI7B8bBNjwD6u2jcdm/vJbdoGbwGyywQ7S6RcNyyQOsAWz
         /GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYL0hIlGGom/gyKspkiSHFAbG+mfCuIMaZyW204mIzM=;
        b=ToovSyBZ05JUtiNTa+19L33pP7lY9QHixpRqRX3SK8PEpIYXKdqB+ChoJZcqjqlUKT
         GgNbSFMUzuuRs+QrPl8bpUYQIcTqJ9I1M6b6hq9osw487r/6HSaMjIQMb7VAUXZ6w/a+
         EiaiW1v2iykrP1iEcVj6+/uyZ0UEgM/8t9shCNuT6JgrGmxM7CamW05eu9S/Ee3YaKkO
         hbKhjNDIgs+JQ2eCFjCpFJzfjQdZBJ1PWF89hDIB60ruVshJMrDYWFJIqo2EzlPP3H63
         TEjUB8qR/pX8/YkMrv8jMIcfHKxjMwM30b0k0jB3J1l62JshSA8+Lo7eRJQEWWley5FX
         L6zg==
X-Gm-Message-State: ACrzQf2KsMjgiaTIdNPEqVIz+PY2ouwrxbHhRqOjfI7km4PiWfcVwkqv
        PY4EroqQ2e9C+XFWNWcjVH9ufTRWaf8=
X-Google-Smtp-Source: AMsMyM4F4zaM5vueYpcE12XRia4NUltTyVYEZ6vVTmKALwKbU8W/C1Dyb4ehyKEB92Kkl9grNmYPXA==
X-Received: by 2002:a63:1a53:0:b0:44d:e5ba:5acf with SMTP id a19-20020a631a53000000b0044de5ba5acfmr27937957pgm.461.1665642191232;
        Wed, 12 Oct 2022 23:23:11 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id bc8-20020a656d88000000b0043a1c0a0ab1sm10424467pgb.83.2022.10.12.23.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:23:10 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 00/25] Local kptrs, BPF linked lists
Date:   Thu, 13 Oct 2022 11:52:38 +0530
Message-Id: <20221013062303.896469-1-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8911; i=memxor@gmail.com; h=from:subject; bh=FriY+DYFoUKhSQZuFADgZFWv7TEHltp+cPaQgRB84d0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67Cpbs6DdajBvpNnfHE0OprazPjrN1cs6WF8qKg HFHb4cCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euwgAKCRBM4MiGSL8Ryk+TD/ 9fjbOocTtV8NsGaQ9OKnSLD21Cl1KCCSbk2O15VmupG8cGJWGW1FpGNWGgXcfxTRBTY/eV6R9G/oIE UdwruMjUThA39AWCH5kON+EmkkyJc0elrCwkOhaRvWTouZnolCJwv7HaLOIW7EcwFBq+Wy0fYHdjIa wQjcCNWoORMWA0JwOmI/b7jIqNpilWKvDmFqo6lLAQ2maEPq/BeVEfP5ZcAN93ZGXx4z+4fR8+OMhr FOHBbji7ixl+UZwMJpP/SuVneqnrbUFouwesZeAMWekmXIBPCbk6S2rpTM7EDt5iCJlZO7W5J3aWhD yDy/0AFs0IxVVYtx+PYrYRi/30LGZKiqdHFlg/uQCevKTv/I//XrjHCqSmqxUmslyrBPv96NlOR7Fp Ghc7yTNKEvqQuPgXq4RArHJwTL8UrkWQgM1kQfiOAEYI/zvFKW8sJ9t6/yIpy+LdYuV8wK+vBa4iJz 7qDDmgd6VqSUgmr9hnJcAJDGadY087sIQML55s5Gd5uVxzcFxo8lym+j2PNH+aXvBG3i/DRJAjVs7+ cCR+I+nrekTHsArtE4OBkw/3cfiDdrTcr4nZUEY0BY647VF2qR7W2pIl3IuULGze00my3BBnwDLVSm qSrXpdo9aRgg8ElWOgBtuRBX/gniwD2IXdGKoJiM3P31npKAep9WQ8FuOa0Q==
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

Hi, this is the non-RFC v2. This is a major rewrite of the previous RFC set,
hence complete review of some of these patches is needed again. I have cut down
the series to only the specific pieces needed to enable other work (like Dave's
RB-Tree). The rest will come as a follow up to this.

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

The features are:
- Local kptrs - User defined kernel objects.
- bpf_kptr_new, bpf_kptr_drop to allocate and free them.
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
- Search pruning now understands non-size precise registers.
- A new bpf_experimental.h header as a dumping ground for these APIs.

Any functionality exposed in this series is NOT part of UAPI. It is only
available through use of kfuncs, and structs that can be added to map value may
also change their size or name in the future. Hence, every feature in this
series must be considered experimental.

Follow-ups:
-----------
 * Support for kptrs (local and kernel) in local storage and percpu maps + kptr tests
 * Fixes that rebase on top of refactorings in this series for dynptrs
   and helper access checks (not included since unrelated, and this is too big already)

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

Notes:
------

 * Dave's patch for libbpf sections is still needed for this to move forward.

Changelog:
----------
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
  * bpf_kptr_new, bpf_kptr_drop (Alexei)
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

Dave Marchevsky (1):
  libbpf: Add support for private BSS map section

Kumar Kartikeya Dwivedi (24):
  bpf: Document UAPI details for special BPF types
  bpf: Allow specifying volatile type modifier for kptrs
  bpf: Clobber stack slot when writing over spilled PTR_TO_BTF_ID
  bpf: Fix slot type check in check_stack_write_var_off
  bpf: Drop reg_type_may_be_refcounted_or_null
  bpf: Refactor kptr_off_tab into fields_tab
  bpf: Consolidate spin_lock, timer management into fields_tab
  bpf: Refactor map->off_arr handling
  bpf: Support bpf_list_head in map values
  bpf: Introduce local kptrs
  bpf: Recognize bpf_{spin_lock,list_head,list_node} in local kptrs
  bpf: Verify ownership relationships for owning types
  bpf: Support locking bpf_spin_lock in local kptr
  bpf: Allow locking bpf_spin_lock global variables
  bpf: Rewrite kfunc argument handling
  bpf: Drop kfunc bits from btf_check_func_arg_match
  bpf: Support constant scalar arguments for kfuncs
  bpf: Teach verifier about non-size constant arguments
  bpf: Introduce bpf_kptr_new
  bpf: Introduce bpf_kptr_drop
  bpf: Permit NULL checking pointer with non-zero fixed offset
  bpf: Introduce single ownership BPF linked list API
  selftests/bpf: Add __contains macro to bpf_experimental.h
  selftests/bpf: Add BPF linked list API tests

 Documentation/bpf/bpf_design_QA.rst           |   44 +
 Documentation/bpf/kfuncs.rst                  |   30 +
 include/linux/bpf.h                           |  238 ++-
 include/linux/bpf_verifier.h                  |   22 +-
 include/linux/btf.h                           |   76 +-
 include/linux/filter.h                        |    4 +-
 kernel/bpf/arraymap.c                         |   30 +-
 kernel/bpf/bpf_local_storage.c                |    2 +-
 kernel/bpf/btf.c                              | 1204 +++++++-------
 kernel/bpf/core.c                             |   14 +
 kernel/bpf/hashtab.c                          |   40 +-
 kernel/bpf/helpers.c                          |  141 +-
 kernel/bpf/local_storage.c                    |    2 +-
 kernel/bpf/map_in_map.c                       |   18 +-
 kernel/bpf/syscall.c                          |  381 +++--
 kernel/bpf/verifier.c                         | 1445 ++++++++++++++---
 net/bpf/bpf_dummy_struct_ops.c                |    3 +-
 net/core/bpf_sk_storage.c                     |    4 +-
 net/core/filter.c                             |   13 +-
 net/ipv4/bpf_tcp_ca.c                         |    3 +-
 net/netfilter/nf_conntrack_bpf.c              |    1 +
 tools/lib/bpf/libbpf.c                        |   65 +-
 tools/testing/selftests/bpf/DENYLIST.s390x    |    1 +
 .../testing/selftests/bpf/bpf_experimental.h  |   85 +
 .../bpf/prog_tests/kfunc_dynptr_param.c       |    2 +-
 .../selftests/bpf/prog_tests/linked_list.c    |   88 +
 .../testing/selftests/bpf/progs/linked_list.c |  325 ++++
 tools/testing/selftests/bpf/verifier/calls.c  |    4 +-
 .../selftests/bpf/verifier/ref_tracking.c     |    4 +-
 29 files changed, 3146 insertions(+), 1143 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_experimental.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c

-- 
2.38.0

