Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578246C58FF
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 22:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjCVVxB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 17:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjCVVw6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 17:52:58 -0400
Received: from out-36.mta0.migadu.com (out-36.mta0.migadu.com [IPv6:2001:41d0:1004:224b::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B5534026
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 14:52:54 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679521972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bYoWmdzl2W1pyPtN74eGSJiP1C5DmIA+BUBmi3a/gXg=;
        b=uh5CWILNCJ3nUO3boccW09eoxWY1HwNtMd60NtbyDrBsOR7kpmaUmdhO87bmvDNb3w7hZW
        KrjurmsyJy1QDqMoUM0aKDCiPxrhgolgF9QX+NI9gZS2FTFjwWI6HM9o+IMzxrG0kvodsY
        I8lfqJPL3GWWmJZFE7VN1Ux01BADHPM=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v3 bpf-next 0/5] bpf: Use bpf_mem_cache_alloc/free in bpf_local_storage
Date:   Wed, 22 Mar 2023 14:52:41 -0700
Message-Id: <20230322215246.1675516-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This set is a continuation of the effort in using
bpf_mem_cache_alloc/free in bpf_local_storage [1]

Major change is only using bpf_mem_alloc for task and cgrp storage
while sk and inode stay with kzalloc/kfree. The details is
in patch 2.

[1]: https://lore.kernel.org/bpf/20230308065936.1550103-1-martin.lau@linux.dev/

v3:
- Only use bpf_mem_alloc for task and cgrp storage.
- sk and inode storage stay with kzalloc/kfree.
- Check NULL and add comments in bpf_mem_cache_raw_free() in patch 1.
- Added test and benchmark for task storage.

v2:
- Added bpf_mem_cache_alloc_flags() and bpf_mem_cache_raw_free()
  to hide the internal data structure of the bpf allocator.
- Fixed a typo bug in bpf_selem_free()
- Simplified the test_local_storage test by directly using
  err returned from libbpf

Martin KaFai Lau (5):
  bpf: Add a few bpf mem allocator functions
  bpf: Use bpf_mem_cache_alloc/free in bpf_local_storage_elem
  bpf: Use bpf_mem_cache_alloc/free for bpf_local_storage
  selftests/bpf: Test task storage when local_storage->smap is NULL
  selftests/bpf: Add bench for task storage creation

 include/linux/bpf_local_storage.h             |   7 +-
 include/linux/bpf_mem_alloc.h                 |   2 +
 kernel/bpf/bpf_cgrp_storage.c                 |   2 +-
 kernel/bpf/bpf_inode_storage.c                |   2 +-
 kernel/bpf/bpf_local_storage.c                | 223 ++++++++++++++++--
 kernel/bpf/bpf_task_storage.c                 |   2 +-
 kernel/bpf/memalloc.c                         |  59 ++++-
 net/core/bpf_sk_storage.c                     |   2 +-
 tools/testing/selftests/bpf/bench.c           |   2 +
 .../bpf/benchs/bench_local_storage_create.c   | 151 ++++++++++--
 .../bpf/prog_tests/test_local_storage.c       |   7 +-
 .../bpf/progs/bench_local_storage_create.c    |  25 ++
 .../selftests/bpf/progs/local_storage.c       |  56 +++--
 13 files changed, 472 insertions(+), 68 deletions(-)

-- 
2.34.1

