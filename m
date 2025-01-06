Return-Path: <bpf+bounces-47920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F78A02043
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AED163A33
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6201D90DD;
	Mon,  6 Jan 2025 08:07:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B326F1D7989;
	Mon,  6 Jan 2025 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150822; cv=none; b=KODCTM8XzYrUepLcOlhE3TKC8q/7vWSxdFFPORzGbQ06McbABrMQx5sxKvgYh3ZcKp+0Vju/fPo9Vb612zU3qqad68uRIo5wsMRUkTRZM+95HsOryZchucwpGna32l0/sbKXcZ9lGB9I8dD5gKvuCTQTsBuAhRJRwwX0+/Pa7T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150822; c=relaxed/simple;
	bh=8nDcpBJ51xyiNBLQoPdbAik1y50ruKeWL5dAvJQE0Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QCE17W9pNEhs9MVsnFVZi9Z9bSc+iVV85V8EdVfblCvY7QPRh+T5OaEpi9QSMRobcjdo/4QwVdBDbBJcjjWgVYoDG/mPmmpnAUEgJMD2QIGxwnGuXA7vDQXatWETTgWsL2Iat0KNpswic80XCTBUXDHR+fTy6UCE8XWCwmEZjwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YRRbD5wYlz4f3kvf;
	Mon,  6 Jan 2025 16:06:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1E6671A111B;
	Mon,  6 Jan 2025 16:06:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S4;
	Mon, 06 Jan 2025 16:06:51 +0800 (CST)
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
Subject: faom 13cc1d4ee0a231f81951ee87f1e55229907966ee Mon Sep 17 00:00:00 2001
Date: Mon,  6 Jan 2025 16:18:41 +0800
Message-Id: <20250106081900.1665573-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW3ArWrXry8Gw4fJFyDtrb_yoWrWry8pr
	4fK3s3Kr4UXa4Sv3ZxXw4xCFyrAw4fG347GwnrKr1rtws8Zr9xJw1xJF18ZF9xGryktryS
	qr1qqw1qkw1DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1aFAJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

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

Considering the bpf-next CI is broken, the patch set is verified by
using bpf tree. Please check the individual patches for more details.
Comments are always welcome.

[1]: https://lore.kernel.org/bpf/CAADnVQKZ3=F0L7_R_pYqu7ePzpXRwQEN8tCzmFoxjdJHamMOUQ@mail.gmail.com

Hou Tao (19):
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
  bpf: Disable migration in array_map_free()
  bpf: Disable migration in htab_map_free()
  bpf: Disable migration for bpf_selem_unlink in
    bpf_local_storage_map_free()
  bpf: Remove migrate_{disable|enable} in bpf_obj_free_fields()
  bpf: Remove migrate_{disable,enable} in bpf_cpumask_release()
  bpf: Disable migration before calling ops->map_free()
  bpf: Remove migrate_{disable|enable} from bpf_selem_alloc()
  bpf: Remove migrate_{disable|enable} from bpf_local_storage_alloc()
  bpf: Remove migrate_{disable|enable} from bpf_local_storage_free()
  bpf: Remove migrate_{disable|enable} from bpf_selem_free()

 kernel/bpf/arraymap.c          |  6 ++----
 kernel/bpf/bpf_cgrp_storage.c  | 15 +++++++-------
 kernel/bpf/bpf_inode_storage.c |  9 ++++----
 kernel/bpf/bpf_local_storage.c | 38 +++++++++++++++-------------------
 kernel/bpf/bpf_task_storage.c  | 15 +++++++-------
 kernel/bpf/cpumask.c           |  2 --
 kernel/bpf/hashtab.c           | 21 ++++++++-----------
 kernel/bpf/helpers.c           |  4 ----
 kernel/bpf/lpm_trie.c          | 24 +++++++--------------
 kernel/bpf/range_tree.c        |  2 --
 kernel/bpf/syscall.c           | 12 ++++++++---
 net/core/bpf_sk_storage.c      | 11 ++++++----
 12 files changed, 71 insertions(+), 88 deletions(-)

-- 
2.29.2


