Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C6D6AB897
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 09:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjCFImi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 03:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCFImh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 03:42:37 -0500
Received: from out-63.mta1.migadu.com (out-63.mta1.migadu.com [IPv6:2001:41d0:203:375::3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D640821290
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 00:42:34 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678092152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H0tjZxHSIenkCMxroKXaD1TZE7KTaX/TYk+Lcyq7c7Q=;
        b=Swi/M+x2erBjEXCu5KBeEl706ZE/ABCITT8E6bdAQr1YawnjP5SA+mRcJbvH0B2hMcVrof
        dXFWe9uUJOqrCAamG34gNdPqba+LVCkfoSM9D8EgYaobDTs7VO+LxWE+Enz1wNcXMBqY1E
        6/osFgnWAjjBBPN196W1pBAra82KR4s=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH bpf-next 00/16] bpf: Use bpf_mem_cache_alloc/free in bpf_local_storage
Date:   Mon,  6 Mar 2023 00:42:00 -0800
Message-Id: <20230306084216.3186830-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Patch 12 to 13 is to use bpf_mem_cache_alloc/free.

The remaining patches are selftests and benchmark.

[1]: https://lore.kernel.org/bpf/20221118190109.1512674-1-namhyung@kernel.org/

Martin KaFai Lau (16):
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
  bpf: Use bpf_mem_cache_alloc/free in bpf_selem_alloc/free
  bpf: Use bpf_mem_cache_alloc/free for bpf_local_storage
  selftests/bpf: Replace CHECK with ASSERT in test_local_storage
  selftests/bpf: Check freeing sk->sk_local_storage with
    sk_local_storage->smap is NULL
  selftests/bpf: Add local-storage-create benchmark

 include/linux/bpf_local_storage.h             |  22 +-
 include/linux/bpf_mem_alloc.h                 |   5 +
 kernel/bpf/bpf_cgrp_storage.c                 |  11 +-
 kernel/bpf/bpf_inode_storage.c                |  10 +-
 kernel/bpf/bpf_local_storage.c                | 292 ++++++++++--------
 kernel/bpf/bpf_task_storage.c                 |  11 +-
 net/core/bpf_sk_storage.c                     |  12 +-
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   2 +
 .../bpf/benchs/bench_local_storage_create.c   | 141 +++++++++
 .../bpf/prog_tests/test_local_storage.c       |  49 ++-
 .../bpf/progs/bench_local_storage_create.c    |  57 ++++
 .../selftests/bpf/progs/local_storage.c       |  29 +-
 13 files changed, 429 insertions(+), 214 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
 create mode 100644 tools/testing/selftests/bpf/progs/bench_local_storage_create.c

-- 
2.30.2

