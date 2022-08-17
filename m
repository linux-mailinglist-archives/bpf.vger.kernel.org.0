Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6215978A1
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbiHQVEc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242283AbiHQVE2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:04:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B381ABD60
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso2950956pjl.1
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Cs6ZaYSOdLy0uVNOcAEYuyrIAH7fMhdm+14tTuynm/s=;
        b=pN5d0gKlMk3faOVL8p163QIYP49ZssaKhgF8GmlcN+hEvSr9FoDbJzKvfw7ECLuZSg
         ErR5J16cSFuLNIx9jrn84ZavQHz/6gkvpfu3pnHXBa3weYxco6tMchKRq5I5qLb9gWHf
         wbtFfVDeABbQRer860VZJN98Cunid31YJKMNrhgIgml8JA9EF4H8SxgEO0r5RXr5Ud8l
         lsLCShuG3gkwvzYk5HSVu33CiIQq9uZIH1GCCJG3zsi4EQPBv8tGqyK5vhBRv74QtuHP
         saWkCkh9o/3SjI6iZX/6K2eE9VgsuxnfR2H3kfilukuOxDIeGTzF0U8Tnruorvd0FTB1
         DhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Cs6ZaYSOdLy0uVNOcAEYuyrIAH7fMhdm+14tTuynm/s=;
        b=VHq1HM9JApbI7XcSH/syLn7PnIXxnlah3pmsVWFvmjzkaLPMT2nbTP6iouuJHFCTTs
         fO8QG0JDc+ZgiQu+NpQWGEs4aBuQCQmk4/4d2QrCMCgs3uRv+fS9NSoMibyX34kOhjRL
         fYc+WiO3PjR8R2xzzJrQlXmPIfemaHQ+101ZeB99jTTf91e6SSJWyoe73RfaHr4jG827
         HIRidR1VVSIkGFjok8BJ4eX7/b+GSllkRGu0WD+UgKv/Bwgko781SNOsSqHwv8K321Du
         /hdfgcIk5Q72imUGDtgAO6bV3lmA/s4pjD/MkENLueLYR9Rkz3N5W+XuFduqM1IbPNnN
         C77Q==
X-Gm-Message-State: ACgBeo3rmWH8g0oKx1fEiVTE/bangspklwwQ4eVaFqZgzN/n9JiBKvSR
        c8lf6p1r0dVc9vzaRvP+Zjc=
X-Google-Smtp-Source: AA6agR64XKxcpMiyQcC7Y5kPr+MTWmGE1PdbZe+2g7xU3EQPACQlIh3X8rfgqZlqcp1cprEbXCMIWA==
X-Received: by 2002:a17:90b:4c12:b0:1f5:958:c313 with SMTP id na18-20020a17090b4c1200b001f50958c313mr5614957pjb.6.1660770262462;
        Wed, 17 Aug 2022 14:04:22 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:ccd6])
        by smtp.gmail.com with ESMTPSA id u15-20020a170903124f00b0016c46ff9741sm375198plh.67.2022.08.17.14.04.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Aug 2022 14:04:22 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 00/12] bpf: BPF specific memory allocator.
Date:   Wed, 17 Aug 2022 14:04:07 -0700
Message-Id: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

There is a lot more work ahead, but this set is useful base.
Future work:
- allow sleepable bpf progs use dynamically allocated maps
- expose bpf_mem_alloc as uapi FD to be used in dynptr_alloc, kptr_alloc
- add sysctl to force bpf_mem_alloc in hash map when safe even if pre-alloc
  requested to reduce memory consumption
- convert lru map to bpf_mem_alloc

Alexei Starovoitov (12):
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

 include/linux/bpf_mem_alloc.h             |  26 +
 kernel/bpf/Makefile                       |   2 +-
 kernel/bpf/hashtab.c                      | 120 ++--
 kernel/bpf/memalloc.c                     | 638 ++++++++++++++++++++++
 kernel/bpf/syscall.c                      |   5 +-
 kernel/bpf/verifier.c                     |  29 -
 samples/bpf/map_perf_test_kern.c          |  44 +-
 samples/bpf/map_perf_test_user.c          |   2 +-
 tools/testing/selftests/bpf/progs/timer.c |  11 -
 tools/testing/selftests/bpf/test_maps.c   |  38 +-
 10 files changed, 811 insertions(+), 104 deletions(-)
 create mode 100644 include/linux/bpf_mem_alloc.h
 create mode 100644 kernel/bpf/memalloc.c

-- 
2.30.2

