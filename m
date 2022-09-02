Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B51C5AB9DE
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 23:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiIBVLH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 17:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIBVLG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 17:11:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9B5D8B2C
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 14:11:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso6613203pjh.5
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=rUqV8Zl9dny7abGWvPgr5U9Ev8KPWsQsQOJ66moJHg0=;
        b=CC6hquSSdYuFFXbFxEcr0dqArILdI4qqplPTo2M5TWNeXFFN3daOyOjYxDjN5OsJNO
         oD1R5jSs1Jka4V/Vwjsn8ksF9lFj/AHqrLWIpYl3xUm0ustYR8hnTL5dDdiuTPczXHDm
         fUZifBW+hUMLBeN4itj0P4OawZegxwVjvjx3TYRqTfXUsfogEKdlKIXVq6AowyXH5HSE
         9raSHO7Pa30g3PxYsVd61/lJAb091VdHjHG6M/OPeoPHlR/IhG4zKowPoqQLXmU0PmWV
         l0wcy99MmMQTV8FTGX0xrt2zrzlCw0tEESQaxkr6Z2bxeKzFlqX03H98CgRS3Jb3y9dM
         wCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=rUqV8Zl9dny7abGWvPgr5U9Ev8KPWsQsQOJ66moJHg0=;
        b=kUGG9dlunPfJfS/lznl7hy42BE89V08Pdtrh9Dt0BfsV0+l/HH6oQbjZ844l25U7eF
         wkCjtjhHchsD7v0axJM0XxjZD9EPMbNedgFJZh/zI0h14cjP1Agj13F3FDc4lGslN/w1
         6Xo/P1K3djeg/yPie+q1T+l99vjK1a9g6yLGidBgQCne7StwmCJwGg8avHXn9FTeUqIa
         af0c0RKlaxhRV+AzwSS3StRgou98TZ0mzsfkAwCt/OUZjdnXqWhwSqHacLWPHlKmybmE
         0o58ZbivcirMIS36wOOryDRbiVhkxkHteI24Pptm2HWsEYKb7azcb9vGj64CVn1TGDh8
         sZSQ==
X-Gm-Message-State: ACgBeo2O79xXHCHgmh21TeNiCAIjjbxWgliKTA4/3xing458Pl8Aky7h
        kEZ0FuZGzbZSS+rHFUumLVb6RU+2vh8=
X-Google-Smtp-Source: AA6agR48vy0phFbUYE/1jzl9Em+wciTotWfB9zReb6xfN9LWm6/7U7b1dVpV9AkdQZ0CD89PFA+J8A==
X-Received: by 2002:a17:90b:1c12:b0:1fd:b28d:a98f with SMTP id oc18-20020a17090b1c1200b001fdb28da98fmr6688613pjb.24.1662153061918;
        Fri, 02 Sep 2022 14:11:01 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::c978])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902684500b001708b189c4asm2047958pln.137.2022.09.02.14.11.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Sep 2022 14:11:01 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 00/16] bpf: BPF specific memory allocator.
Date:   Fri,  2 Sep 2022 14:10:42 -0700
Message-Id: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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

From: Alexei Starovoitov <ast@kernel.org>

Introduce any context BPF specific memory allocator.

Tracing BPF programs can attach to kprobe and fentry. Hence they
run in unknown context where calling plain kmalloc() might not be safe.
Front-end kmalloc() with per-cpu cache of free elements.
Refill this cache asynchronously from irq_work.

Major achievements enabled by bpf_mem_alloc:
- Dynamically allocated hash maps used to be 10 times slower than fully preallocated.
  With bpf_mem_alloc and subsequent optimizations the speed of dynamic maps is equal to full prealloc.
- Tracing bpf programs can use dynamically allocated hash maps.
  Potentially saving lots of memory. Typical hash map is sparsely populated.
- Sleepable bpf programs can used dynamically allocated hash maps.

v5->v6:
- Debugged the reason for selftests/bpf/test_maps ooming in a small VM that BPF CI is using.
  Added patch 16 that optimizes the usage of rcu_barrier-s between bpf_mem_alloc and
  hash map. It drastically improved the speed of htab destruction.

v4->v5:
- Fixed missing migrate_disable in hash tab free path (Daniel)
- Replaced impossible "memory leak" with WARN_ON_ONCE (Martin)
- Dropped sysctl kernel.bpf_force_dyn_alloc patch (Daniel)
- Added Andrii's ack
- Added new patch 15 that removes kmem_cache usage from bpf_mem_alloc.
  It saves memory, speeds up map create/destroy operations
  while maintains hash map update/delete performance.

v3->v4:
- fix build issue due to missing local.h on 32-bit arch
- add Kumar's ack
- proposal for next steps from Delyan:
https://lore.kernel.org/bpf/d3f76b27f4e55ec9e400ae8dcaecbb702a4932e8.camel@fb.com/

v2->v3:
- Rewrote the free_list algorithm based on discussions with Kumar. Patch 1.
- Allowed sleepable bpf progs use dynamically allocated maps. Patches 13 and 14.
- Added sysctl to force bpf_mem_alloc in hash map even if pre-alloc is
  requested to reduce memory consumption. Patch 15.
- Fix: zero-fill percpu allocation
- Single rcu_barrier at the end instead of each cpu during bpf_mem_alloc destruction

v2 thread:
https://lore.kernel.org/bpf/20220817210419.95560-1-alexei.starovoitov@gmail.com/

v1->v2:
- Moved unsafe direct call_rcu() from hash map into safe place inside bpf_mem_alloc. Patches 7 and 9.
- Optimized atomic_inc/dec in hash map with percpu_counter. Patch 6.
- Tuned watermarks per allocation size. Patch 8
- Adopted this approach to per-cpu allocation. Patch 10.
- Fully converted hash map to bpf_mem_alloc. Patch 11.
- Removed tracing prog restriction on map types. Combination of all patches and final patch 12.

v1 thread:
https://lore.kernel.org/bpf/20220623003230.37497-1-alexei.starovoitov@gmail.com/

LWN article:
https://lwn.net/Articles/899274/

Future work:
- expose bpf_mem_alloc as uapi FD to be used in dynptr_alloc, kptr_alloc
- convert lru map to bpf_mem_alloc
- further cleanup htab code. Example: htab_use_raw_lock can be removed.

Alexei Starovoitov (16):
  bpf: Introduce any context BPF specific memory allocator.
  bpf: Convert hash map to bpf_mem_alloc.
  selftests/bpf: Improve test coverage of test_maps
  samples/bpf: Reduce syscall overhead in map_perf_test.
  bpf: Relax the requirement to use preallocated hash maps in tracing
    progs.
  bpf: Optimize element count in non-preallocated hash map.
  bpf: Optimize call_rcu in non-preallocated hash map.
  bpf: Adjust low/high watermarks in bpf_mem_cache
  bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.
  bpf: Add percpu allocation support to bpf_mem_alloc.
  bpf: Convert percpu hash map to per-cpu bpf_mem_alloc.
  bpf: Remove tracing program restriction on map types
  bpf: Prepare bpf_mem_alloc to be used by sleepable bpf programs.
  bpf: Remove prealloc-only restriction for sleepable bpf programs.
  bpf: Remove usage of kmem_cache from bpf_mem_cache.
  bpf: Optimize rcu_barrier usage between hash map and bpf_mem_alloc.

 include/linux/bpf_mem_alloc.h             |  28 +
 kernel/bpf/Makefile                       |   2 +-
 kernel/bpf/hashtab.c                      | 138 +++--
 kernel/bpf/memalloc.c                     | 634 ++++++++++++++++++++++
 kernel/bpf/syscall.c                      |   5 +-
 kernel/bpf/verifier.c                     |  52 --
 samples/bpf/map_perf_test_kern.c          |  44 +-
 samples/bpf/map_perf_test_user.c          |   2 +-
 tools/testing/selftests/bpf/progs/timer.c |  11 -
 tools/testing/selftests/bpf/test_maps.c   |  38 +-
 10 files changed, 820 insertions(+), 134 deletions(-)
 create mode 100644 include/linux/bpf_mem_alloc.h
 create mode 100644 kernel/bpf/memalloc.c

-- 
2.30.2

