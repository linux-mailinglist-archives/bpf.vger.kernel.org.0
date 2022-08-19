Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2F559A7DB
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 23:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiHSVmh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 17:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiHSVmh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 17:42:37 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388BE10DCD5
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:42:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pm17so5773046pjb.3
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=7jTncCP3gpKHpe57rhmgpXAMVQKK9cKnka9R7CTzW2g=;
        b=QHPjB8vDaUiTYmuDa8xTiCrnplv95FKWpcW6k3WiVSmilGkLZMb3wEb58UfpBCf66E
         0aWDxosl7WO0QGu7dsBU4dyoOX8OOo7BFMQlxEHHpNk6W4oTCj9K0gMRtXL5TT/Wpibf
         eITb8JGOQsV5q7hj/H3LSa3nDgQBNtQtUdiBRrDoRywR8uXouXybbd/jCgc18smBYeQr
         13PnXK37i7EJgsiY857PSosrvSsuaiip4dAOhGTRlMAiAR3oB0+Ny+1KN5KPRSoSgphO
         r5gicpBhVigX+F/kKTUHLjIDiacSaFHOtE7/OOtGkktP/3MuBuD38JokyfzeBdrRNhb4
         uSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7jTncCP3gpKHpe57rhmgpXAMVQKK9cKnka9R7CTzW2g=;
        b=bh8VK9fqPah3xZnwIRrSGdKKEt9L0mkMcs+K2oco6xBCeewLlTrDs4RwQBCgtFrNVl
         Ii2aIW/y6sVB60hiWObjn5Dc81iQvEfLC31Jo7bNZO0FBdTLirlJf+6TrQnWI6BZdJe+
         z+MBeydd+zXVlM9ko6bOC3NmjzWFvPiMVPFdugG9CX0K0QZYy7HbLPdqh9F7hDExAUnf
         4KMxAOB6cUKnV2WNSBc5GXMhc2dWMwYsXU315R0IoGJeH91JwOTgHXtjg0BiSmzWaSRb
         uhOPZVYWmEfk4xYFDCDwU5QX9NYQp3nVzYqEDNxrhhpx6hXgFYTYK7WDZUBe/KzyHqNr
         Hdmw==
X-Gm-Message-State: ACgBeo0NnfJLu3gK24oKJWVSQtandsXAgWNUxmdEaM845jyASf+867IO
        Lg0nFQhLsnW/14wf9+yjeR1tQpeGt6E=
X-Google-Smtp-Source: AA6agR6UdhvPRirGbZJ6jl4RZSLcjjAZ3qP2kz39Lpe5AKQUtOVK57dDRLoRK7mvMZP0V+Jq9T+LpA==
X-Received: by 2002:a17:903:4ce:b0:171:2cbb:ba27 with SMTP id jm14-20020a17090304ce00b001712cbbba27mr9308071plb.72.1660945355566;
        Fri, 19 Aug 2022 14:42:35 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id g29-20020aa796bd000000b00535e46171c1sm3227303pfk.117.2022.08.19.14.42.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 14:42:35 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 00/15] bpf: BPF specific memory allocator.
Date:   Fri, 19 Aug 2022 14:42:17 -0700
Message-Id: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
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
  bpf: Introduce sysctl kernel.bpf_force_dyn_alloc.

 include/linux/bpf_mem_alloc.h             |  26 +
 include/linux/filter.h                    |   2 +
 kernel/bpf/Makefile                       |   2 +-
 kernel/bpf/core.c                         |   2 +
 kernel/bpf/hashtab.c                      | 132 +++--
 kernel/bpf/memalloc.c                     | 601 ++++++++++++++++++++++
 kernel/bpf/syscall.c                      |  14 +-
 kernel/bpf/verifier.c                     |  52 --
 samples/bpf/map_perf_test_kern.c          |  44 +-
 samples/bpf/map_perf_test_user.c          |   2 +-
 tools/testing/selftests/bpf/progs/timer.c |  11 -
 tools/testing/selftests/bpf/test_maps.c   |  38 +-
 12 files changed, 795 insertions(+), 131 deletions(-)
 create mode 100644 include/linux/bpf_mem_alloc.h
 create mode 100644 kernel/bpf/memalloc.c

-- 
2.30.2

