Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2C85A9CDE
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 18:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbiIAQQE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 12:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiIAQPy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 12:15:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473EC32BB1
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 09:15:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h11-20020a17090a470b00b001fbc5ba5224so3127074pjg.2
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 09:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=I0zzBiCghT7bwa1INgy+ajatlkYqLStYBAGSsh2QGUg=;
        b=pUoVG+hDVirJbhVl6NE7ufWSXXiDEA72kNyZ5IjiAFZa8wZ7XpS5EkwLfeAowlUd8b
         KT7LUb75zs3r0YGHXcVBck8AaVk91rH8KU8b6ftiuVwf8GMIeIepQ7uvsyan+dk7UsGq
         APRdBlL42shs19hKUhwG051Y/H1RRrlJZ9xhAFXLQijDi73Zb7Xv4q1xW4tUedjdZJSG
         k6lbYXuwwukQMhsd8rSAWz5VuZBqUma3gTRMNeXjdb7S7FuEKwtoMyBj0by+XIZv8Tcn
         pxzks3QySovZqRxO32ggkcuvk+lO5XFKqosiUiXnKF72/mpNbViN6YU/GzzR428RK9WO
         yYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=I0zzBiCghT7bwa1INgy+ajatlkYqLStYBAGSsh2QGUg=;
        b=sYmCA8IsFk+XhTc70/UXIu2BDIY/N1C22UJ9nJ/52H3Px2kLMzPBZ8ITt5CvNyqv4U
         kRs+vNEJHRHkwRXSxuQan0PD9fp8E7+bgVyZby7iJDYS8/QahOLpCaOACavD9Q5K0rX3
         U2Vy/CAH45YnbnOlmqw8DkVFynZ9YneNGXdx6TjAUxG54hCGMHmF0069yb25KtTDuS/h
         XncNtw+9sy2xi53mdLWrAs7ac3rHzkMj3r86VMzoUDfpiDCFgo/5CiEYxuyniReWkZ87
         3XzRtMs8WEdMATr8YqkeqYodp/YNgpOaCFuFVpR6UeztyV1xUyTiEOITBb4MKtva9yM6
         iSig==
X-Gm-Message-State: ACgBeo2EvJ+FOp4I4b7Pt8vxhczG/+GLzP2oNpFpGk2+D5JMtexyI30D
        G5riRQVjYDVTzp5pI7RePkM=
X-Google-Smtp-Source: AA6agR4inzFCgYr4/1hRPNkUP0p2nwhLoBKPvzHfxZMWrL6wBECEwmjB5RTrHb60lzYa7IIz9Cr+cQ==
X-Received: by 2002:a17:90b:4c52:b0:1f5:5129:af1a with SMTP id np18-20020a17090b4c5200b001f55129af1amr9241632pjb.202.1662048951512;
        Thu, 01 Sep 2022 09:15:51 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::3:4dc5])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902e74700b00172bf229dfdsm14186623plf.97.2022.09.01.09.15.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 09:15:50 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 00/15] bpf: BPF specific memory allocator.
Date:   Thu,  1 Sep 2022 09:15:32 -0700
Message-Id: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
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

Alexei Starovoitov (15):
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

 include/linux/bpf_mem_alloc.h             |  26 +
 kernel/bpf/Makefile                       |   2 +-
 kernel/bpf/hashtab.c                      | 132 +++--
 kernel/bpf/memalloc.c                     | 584 ++++++++++++++++++++++
 kernel/bpf/syscall.c                      |   5 +-
 kernel/bpf/verifier.c                     |  52 --
 samples/bpf/map_perf_test_kern.c          |  44 +-
 samples/bpf/map_perf_test_user.c          |   2 +-
 tools/testing/selftests/bpf/progs/timer.c |  11 -
 tools/testing/selftests/bpf/test_maps.c   |  38 +-
 10 files changed, 765 insertions(+), 131 deletions(-)
 create mode 100644 include/linux/bpf_mem_alloc.h
 create mode 100644 kernel/bpf/memalloc.c

-- 
2.30.2

