Return-Path: <bpf+bounces-48054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CEDA039F7
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 09:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC98A7A2151
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 08:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F631E1C1A;
	Tue,  7 Jan 2025 08:44:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96D84CB5B;
	Tue,  7 Jan 2025 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239441; cv=none; b=fIb6HZtQz2Xywl1jQiV3529uPQxvwYw9/DQaUytgxhey7f7YmkwFfKLMCJROF1Jht8QUsM7xerxIKv7icj22hVDZGUgy9evWFJcASKVpz2RGw76MnhnCyqzlMfX1vxOP8WZgZzYdZJLfY7/b8DMD2VuL0eYlIVLhCvK7NxMsPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239441; c=relaxed/simple;
	bh=/ES1x/948moWd3wtwnhkJbZlWu73lilloOUQA1GNehc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EzrU4jnaUaD8dF7pe71C3OUaYjKkX6PGPFcVLYHdmQzwBOmaKUrsjUsVmMn3YmSpsLzHv/FvDiRl41vt8fwbyNIp60Sgn06ihzmWa/BY2fzHhXTtqutpdAgKSLsKQve3JjX99gXhYLyOS244W4sOkPKE65l7gREpkqzaTIyDypU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YS4Mc4Rx5z4f3jqL;
	Tue,  7 Jan 2025 16:43:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 94BFD1A0C57;
	Tue,  7 Jan 2025 16:43:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9E6XxnpFgeAQ--.43336S8;
	Tue, 07 Jan 2025 16:43:55 +0800 (CST)
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 4/7] bpf: Support refilling extra_elems in free_htab_elem()
Date: Tue,  7 Jan 2025 16:55:56 +0800
Message-Id: <20250107085559.3081563-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250107085559.3081563-1-houtao@huaweicloud.com>
References: <20250107085559.3081563-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl9E6XxnpFgeAQ--.43336S8
X-Coremail-Antispam: 1UD129KBjvJXoWxXry8Gr1UJry8KF4kur1UAwb_yoW5tr4UpF
	WrGr47Kw48CrsI9w45Ja10krW5J34SqryjkFy8KFWrKF98Zrn3Gw42yFn7KryrCrykZasa
	qrZFvw45GayrGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jIPfQUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

The following patch will move the invocation of check_and_free_fields()
in htab_map_update_elem() outside of the bucket lock. However, the
reason why the bucket lock is necessary is that the overwritten element
has already been stashed in htab->extra_elems when alloc_htab_elem()
returns. If invoking check_and_free_fields() after the bucket lock is
unlocked, the stashed element may be reused by concurrent update
procedure and the freeing in check_and_free_fields() will run
concurrently with the reuse and lead to bugs.

The fix breaks the reuse and stash of extra_elems into two steps:
1) reuse the per-cpu extra_elems with bucket lock being held.
2) refill per-cpu extra_elems after unlock bucket lock.

This patch adds support for stashing per-cpu extra_elems after bucket
lock is unlocked. The refill may run concurrently, therefore,
cmpxchg_release() is used. _release semantics is necessary to ensure the
freeing of ptrs or special fields in the map value is completed before
the element is reused by concurrent update process.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 903447a340d3..3c6eebabb492 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -946,14 +946,28 @@ static void dec_elem_count(struct bpf_htab *htab)
 		atomic_dec(&htab->count);
 }
 
-
-static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
+static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l, bool refill_extra)
 {
 	htab_put_fd_value(htab, l);
 
 	if (htab_is_prealloc(htab)) {
-		bpf_map_dec_elem_count(&htab->map);
 		check_and_free_fields(htab, l);
+
+		if (refill_extra) {
+			struct htab_elem **extra;
+
+			/* Use cmpxchg_release() to ensure the freeing of ptrs
+			 * or special fields in map value is completed when the
+			 * update procedure reuses the extra element. It will
+			 * pair with smp_load_acquire() when reading extra_elems
+			 * pointer.
+			 */
+			extra = this_cpu_ptr(htab->extra_elems);
+			if (cmpxchg_release(extra, NULL, l) == NULL)
+				return;
+		}
+
+		bpf_map_dec_elem_count(&htab->map);
 		pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
 		dec_elem_count(htab);
@@ -1207,7 +1221,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		if (old_map_ptr)
 			map->ops->map_fd_put_ptr(map, old_map_ptr, true);
 		if (!htab_is_prealloc(htab))
-			free_htab_elem(htab, l_old);
+			free_htab_elem(htab, l_old, false);
 	}
 	return 0;
 err:
@@ -1461,7 +1475,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	htab_unlock_bucket(htab, b, hash, flags);
 
 	if (l)
-		free_htab_elem(htab, l);
+		free_htab_elem(htab, l, false);
 	return ret;
 }
 
@@ -1677,7 +1691,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 		if (is_lru_map)
 			htab_lru_push_free(htab, l);
 		else
-			free_htab_elem(htab, l);
+			free_htab_elem(htab, l, false);
 	}
 
 	return ret;
@@ -1899,7 +1913,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		if (is_lru_map)
 			htab_lru_push_free(htab, l);
 		else
-			free_htab_elem(htab, l);
+			free_htab_elem(htab, l, false);
 	}
 
 next_batch:
-- 
2.29.2


