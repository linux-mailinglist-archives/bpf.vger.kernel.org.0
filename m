Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210055A1F02
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244491AbiHZCog (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244298AbiHZCof (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:44:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F88CCD49
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:44:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e19so380719pju.1
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=0Vfugx9ZeZmqLlCmMUr+dSSSNQt1I/QhIF695C1G7bI=;
        b=FenTtXfPDRhXEeuZZwJmCW13rJvJXvccWWh1j1rcutnnW7/cVcaBG/lXrh7suUwkuN
         m+/zfREGsLP96WlDb1fCeMSzqNJ9XYL/mHk6Seuo2NiJiqfjxW2Pi3UxRIVuRkH1f7/6
         ulzE/eXuQkjVGwpJ+3PZUa3SpoB9tbpq11rbpRiBZ/XYfFnmn3TV8nN+y5lbSP6qaFb6
         c0DM+BqHyJh5QcpOcVxGNmUWyN5Tw4ielYn/2I0hQoPG0d4HrOT2blDBEm8a2aUtuhJk
         zbQL3nWUaDXhigos9PWRw/z0bnZKfYoKl6gxjvR3A1Vvag0pekaOvN/PxJFxrheO6Yu4
         xJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=0Vfugx9ZeZmqLlCmMUr+dSSSNQt1I/QhIF695C1G7bI=;
        b=YBiMXJ3TfbqLYMo5tRkx3l4bEXCtCw2TNF60klsSbiMOQ6JWviZBDtnfNak1eI4iFQ
         P/nHc9IrAaV8+Fod1Gvh37Xu4tW5fCt0abMtKgQE23Jlqow6l9Xyz1y+OUcFyS0bP7Mb
         FU7jSDjyxcpXxbblPsfaU2bMl8ZU1QTKn84p0ruj/o5AVZuhSQQ8Lu4t7sjrYEw4Gs5n
         BQwg9DFDq1kbEi8XWtHRo+RhUMYur2cI4GKEbx4QfdBoz8ighmSuo1CIB9T7AeucXIW2
         3sa6SSI/G2+WFhdZnNyfURPLgZnal6V7AhxM7tNWrl425r9DXKDr7rJ/ZjzSPMGdLO8z
         eD1g==
X-Gm-Message-State: ACgBeo0YMIs3rFzZT/buz9lyfCE2SKcqwz1nLf6I9HFVC0ofbhX5vt19
        LiCME5de7/kAPXmChW2Pzcg=
X-Google-Smtp-Source: AA6agR6XzgxYJQDzzr6z3kzzaW91eX94ZbpcSzlDfSBFxNUzEvAov+JDO6buNdUS5GkhvJMF2QkjVw==
X-Received: by 2002:a17:903:2450:b0:173:9fe:70e5 with SMTP id l16-20020a170903245000b0017309fe70e5mr1699920pls.148.1661481874186;
        Thu, 25 Aug 2022 19:44:34 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:15dc])
        by smtp.gmail.com with ESMTPSA id jo16-20020a170903055000b00172b8e60019sm260720plb.249.2022.08.25.19.44.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 19:44:33 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 00/15] bpf: BPF specific memory allocator.
Date:   Thu, 25 Aug 2022 19:44:15 -0700
Message-Id: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
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
  bpf: Introduce sysctl kernel.bpf_force_dyn_alloc.

 include/linux/bpf_mem_alloc.h             |  26 +
 include/linux/filter.h                    |   2 +
 kernel/bpf/Makefile                       |   2 +-
 kernel/bpf/core.c                         |   2 +
 kernel/bpf/hashtab.c                      | 132 +++--
 kernel/bpf/memalloc.c                     | 602 ++++++++++++++++++++++
 kernel/bpf/syscall.c                      |  14 +-
 kernel/bpf/verifier.c                     |  52 --
 samples/bpf/map_perf_test_kern.c          |  44 +-
 samples/bpf/map_perf_test_user.c          |   2 +-
 tools/testing/selftests/bpf/progs/timer.c |  11 -
 tools/testing/selftests/bpf/test_maps.c   |  38 +-
 12 files changed, 796 insertions(+), 131 deletions(-)
 create mode 100644 include/linux/bpf_mem_alloc.h
 create mode 100644 kernel/bpf/memalloc.c

-- 
2.30.2

