Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA416AFF34
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 08:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCHHAC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 02:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCHHAB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:01 -0500
Received: from out-9.mta1.migadu.com (out-9.mta1.migadu.com [IPv6:2001:41d0:203:375::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B51EA18AC
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 22:59:59 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678258797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6BAme+vrjJyVkRViHzF1pK/6JT5gm8TfZt5eYxAgcRE=;
        b=mvScnlmtG81iQfICTp+mmdJ9TITJh+1g4AXcJKef2ZYt3n4b4uJhu4y8JD2IhmIvnOd0oJ
        veOOw7vZdsXef3RTRe8AauidEauqq1p8Jyk/EkJkJXYl2c8SRa6coBAhEEAEdEOg8B0cwe
        4qPmNSnPYNdM4SP4YxmroBDosVd1B3c=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v2 bpf-next 00/17] bpf: Use bpf_mem_cache_alloc/free in bpf_local_storage
Date:   Tue,  7 Mar 2023 22:59:19 -0800
Message-Id: <20230308065936.1550103-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This set is to use bpf_mem_cache_alloc/free in bpf_local_storage.
The primary motivation is to solve the deadlock/recursion issue
when bpf_task_storage is used in a bpf tracing prog [1]. This set
also comes with a micro-benchmark to test the storage creation.

Patch 1 to 4 are some general cleanup after bpf_local_storage
has been extended to multiple kernel objects (sk, task, inode,
and then cgrp).

Patch 5 to 11 is to refactor the memory free logic into the new
bpf_selem_free() and bpf_local_storage_free() functions. Together
with the existing bpf_selem_alloc() and bpf_local_storage_alloc(),
it should provide an easier way to change the alloc/free path in
the future.

Patch 12 to 14 is to use bpf_mem_cache_alloc/free.

The remaining patches are selftests and benchmark.

[1]: https://lore.kernel.org/bpf/20221118190109.1512674-1-namhyung@kernel.org/

v2:
- Added bpf_mem_cache_alloc_flags() and bpf_mem_cache_raw_free()
  to hide the internal data structure of the bpf allocator.
- Fixed a typo bug in bpf_selem_free()
- Simplified the test_local_storage test by directly using
  err returned from libbpf

Martin KaFai Lau (17):
  bpf: Move a few bpf_local_storage functions to static scope
  bpf: Refactor codes into bpf_local_storage_destroy
  bpf: Remove __bpf_local_storage_map_alloc
  bpf: Remove the preceding __ from __bpf_selem_unlink_storage
  bpf: Remember smap in bpf_local_storage
  bpf: Repurpose use_trace_rcu to reuse_now in bpf_local_storage
  bpf: Remove bpf_selem_free_fields*_rcu
  bpf: Add bpf_selem_free_rcu callback
  bpf: Add bpf_selem_free()
  bpf: Add bpf_local_storage_rcu callback
  bpf: Add bpf_local_storage_free()
  bpf: Add a few bpf mem allocator functions
  bpf: Use bpf_mem_cache_alloc/free in bpf_selem_alloc/free
  bpf: Use bpf_mem_cache_alloc/free for bpf_local_storage
  selftests/bpf: Replace CHECK with ASSERT in test_local_storage
  selftests/bpf: Check freeing sk->sk_local_storage with
    sk_local_storage->smap is NULL
  selftests/bpf: Add local-storage-create benchmark

 include/linux/bpf_local_storage.h             |  21 +-
 include/linux/bpf_mem_alloc.h                 |   2 +
 kernel/bpf/bpf_cgrp_storage.c                 |  11 +-
 kernel/bpf/bpf_inode_storage.c                |  10 +-
 kernel/bpf/bpf_local_storage.c                | 279 ++++++++++--------
 kernel/bpf/bpf_task_storage.c                 |  11 +-
 kernel/bpf/memalloc.c                         |  42 ++-
 net/core/bpf_sk_storage.c                     |  12 +-
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   2 +
 .../bpf/benchs/bench_local_storage_create.c   | 141 +++++++++
 .../bpf/prog_tests/test_local_storage.c       |  47 ++-
 .../bpf/progs/bench_local_storage_create.c    |  57 ++++
 .../selftests/bpf/progs/local_storage.c       |  29 +-
 14 files changed, 446 insertions(+), 220 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
 create mode 100644 tools/testing/selftests/bpf/progs/bench_local_storage_create.c

-- 
2.34.1

