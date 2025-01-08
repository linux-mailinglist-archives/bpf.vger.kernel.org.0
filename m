Return-Path: <bpf+bounces-48184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B81A04E55
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 01:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D5A7A22D4
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 00:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2FD38DE9;
	Wed,  8 Jan 2025 00:55:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F2F70813;
	Wed,  8 Jan 2025 00:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297726; cv=none; b=hZvEsAUhHmRdBTeeRP+MM4M9xg1V70Pd7+UKqCz1pZq+ZR31ZxdGpW2y47sH8bw4ETzCipKlYQMczsq/6SbMBV1nTNO/BWQLYcUADJUghQwLiP6ZYCaQJVExZbYRIG8FE9XM+o1RF9P3EsKNjiEX19GtV5zHQGyDfhigVC4AXNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297726; c=relaxed/simple;
	bh=AC5/8Fvr4OzKfSMnb5Jw7XyTuVYpRtjGEYxMsVYr6Po=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aQqOo9SkHdWMavDbsiv502GVdWuOXzg53Q0ZpPgndz6vDfMod+xliU3WsmBCfQX1dwG+GLvZYIHigZw1zJyXLYHaw9CKRtZl7aDLuNwOw2jNhDjvKQh0L0PhC3s1ZGbvXpCuFlqBkoAM0LA0lsiaVxprc+wJDCJfzD16nWA/DVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YSTwN4KYcz4f3kFm;
	Wed,  8 Jan 2025 08:55:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BED751A16CD;
	Wed,  8 Jan 2025 08:55:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHq1_1zH1nBtZdAQ--.51859S4;
	Wed, 08 Jan 2025 08:55:19 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next v2 00/16] bpf: Reduce the use of migrate_{disable|enable}()
Date: Wed,  8 Jan 2025 09:07:12 +0800
Message-Id: <20250108010728.207536-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHq1_1zH1nBtZdAQ--.51859S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW3ArWrXry8Gw4fJFyDtrb_yoWrXryDpr
	4fK34fKr4UXa4Sv3ZxXw4xCFyrAw4fG347GrnrKr1Fqws8ur9xGw1xJF18ZFy3GryktryS
	vr1qqw1qy3WDZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUFku4UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The use of migrate_{disable|enable} pair in BPF is mainly due to the
introduction of bpf memory allocator and the use of per-CPU data struct
in its internal implementation. The caller needs to disable migration
before invoking the alloc or free APIs of bpf memory allocator, and
enable migration after the invocation.

The main users of bpf memory allocator are various kind of bpf maps in
which the map values or the special fields in the map values are
allocated by using bpf memory allocator.

At present, the running context for bpf program has already disabled
migration explictly or implictly, therefore, when these maps are
manipulated in bpf program, it is OK to not invoke migrate_disable()
and migrate_enable() pair. Howevers, it is not always the case when
these maps are manipulated through bpf syscall, therefore many
migrate_{disable|enable} pairs are added when the map can either be
manipulated by BPF program or BPF syscall.

The initial idea of reducing the use of migrate_{disable|enable} comes
from Alexei [1]. I turned it into a patch set that archives the goals
through the following three methods:

1. remove unnecessary migrate_{disable|enable} pair
when the BPF syscall path also disables migration, it is OK to remove
the pair. Patch #1~#3 fall into this category, while patch #4~#5 are
partially included.

2. move the migrate_{disable|enable} pair from inner callee to outer
   caller
Instead of invoking migrate_disable() in the inner callee, invoking
migrate_disable() in the outer caller to simplify reasoning about when
migrate_disable() is needed. Patch #4~#5 and patch #6~#19 belongs to
this category.

3. add cant_migrate() check in the inner callee
Add cant_migrate() check in the inner callee to ensure the guarantee
that migration is disabled is not broken. Patch #1~#5, #13, #16~#19 also
belong to this category.

Please check the individual patches for more details. Comments are
always welcome.

Change Log:
v2:
  * sqaush the ->map_free related patches (#10~#12, #15) into one patch
  * remove unnecessary cant_migrate() checks.

v1: https://lore.kernel.org/bpf/20250106081900.1665573-1-houtao@huaweicloud.com

Hou Tao (16):
  bpf: Remove migrate_{disable|enable} from LPM trie
  bpf: Remove migrate_{disable|enable} in ->map_for_each_callback
  bpf: Remove migrate_{disable|enable} in htab_elem_free
  bpf: Remove migrate_{disable|enable} from bpf_cgrp_storage_lock
    helpers
  bpf: Remove migrate_{disable|enable} from bpf_task_storage_lock
    helpers
  bpf: Disable migration when destroying inode storage
  bpf: Disable migration when destroying sock storage
  bpf: Disable migration when cloning sock storage
  bpf: Disable migration in bpf_selem_free_rcu
  bpf: Disable migration before calling ops->map_free()
  bpf: Remove migrate_{disable|enable} in bpf_obj_free_fields()
  bpf: Remove migrate_{disable,enable} in bpf_cpumask_release()
  bpf: Remove migrate_{disable|enable} from bpf_selem_alloc()
  bpf: Remove migrate_{disable|enable} from bpf_local_storage_alloc()
  bpf: Remove migrate_{disable|enable} from bpf_local_storage_free()
  bpf: Remove migrate_{disable|enable} from bpf_selem_free()

 kernel/bpf/arraymap.c          |  6 ++----
 kernel/bpf/bpf_cgrp_storage.c  | 15 +++++++--------
 kernel/bpf/bpf_inode_storage.c |  9 +++++----
 kernel/bpf/bpf_local_storage.c | 30 +++++++++---------------------
 kernel/bpf/bpf_task_storage.c  | 15 +++++++--------
 kernel/bpf/cpumask.c           |  2 --
 kernel/bpf/hashtab.c           | 19 +++++++------------
 kernel/bpf/helpers.c           |  4 ----
 kernel/bpf/lpm_trie.c          | 20 ++++----------------
 kernel/bpf/range_tree.c        |  2 --
 kernel/bpf/syscall.c           | 10 +++++++---
 net/core/bpf_sk_storage.c      | 11 +++++++----
 12 files changed, 55 insertions(+), 88 deletions(-)

-- 
2.29.2


