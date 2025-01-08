Return-Path: <bpf+bounces-48194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6956DA04E64
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 01:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9461887F07
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 00:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7870189913;
	Wed,  8 Jan 2025 00:55:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204B1537C8;
	Wed,  8 Jan 2025 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736297732; cv=none; b=MNC2aqH3Ej1eSy2O7OsixJDhT/WOkoR9rl8fu0IHbRy/6H6pF3T9q/hII1aaPoBxYZMm2U5Lmz3ODDeB/T0uhkSrbVSz0ay1CSYx5gdEs75fQUDFWcI0HQ9sH2ug9DyrTZwEZwRkVovSezeGeLess4CuDvXH+uQxUfdSlR4rNX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736297732; c=relaxed/simple;
	bh=XtHrEAjL9x0aDru3BlUpWNR+oMiZdt44IU2CAZCd14c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QTgGit5kBPk0eY6z7g9pk3XcUSqWHszKzDJAd2m8ciTn39ZAi8prLpU36HocLELPKK63HKUAL8it7qrxVkcB/mR8eXGitjhqORzTg4YSzperjXK1kpmx8otEoear2SrlJuY7tzFAgHZvclb2b0+5446iFmh4RgyE8w527sQzbM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YSTwV5KhVz4f3jsH;
	Wed,  8 Jan 2025 08:55:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DEC6F1A0D7B;
	Wed,  8 Jan 2025 08:55:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHq1_1zH1nBtZdAQ--.51859S14;
	Wed, 08 Jan 2025 08:55:26 +0800 (CST)
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
Subject: [PATCH bpf-next v2 10/16] bpf: Disable migration before calling ops->map_free()
Date: Wed,  8 Jan 2025 09:07:22 +0800
Message-Id: <20250108010728.207536-11-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250108010728.207536-1-houtao@huaweicloud.com>
References: <20250108010728.207536-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHq1_1zH1nBtZdAQ--.51859S14
X-Coremail-Antispam: 1UD129KBjvJXoWxCw15ArW3AFWfGFyUGFyDKFg_yoWrWF45pF
	Z3Gry8Kr40qFn7urs3Xw4xAry3Aw45W34akayvk34SvrsxZr90qw1IvFyrXFya9r1ktr1S
	vFn0gw1jyw48uFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

The freeing of all map elements may invoke bpf_obj_free_fields() to free
the special fields in the map value. Since these special fields may be
allocated from bpf memory allocator, migrate_{disable|enable} pairs are
necessary for the freeing of these special fields.

To simplify reasoning about when migrate_disable() is needed for the
freeing of these special fields, let the caller to guarantee migration
is disabled before invoking bpf_obj_free_fields(). Therefore, disabling
migration before calling ops->map_free() to simplify the freeing of map
values or special fields allocated from bpf memory allocator.

After disabling migration in bpf_map_free(), there is no need for
additional migration_{disable|enable} pairs in these ->map_free()
callbacks. Remove these redundant invocations.

The migrate_{disable|enable} pairs in the underlying implementation of
bpf_obj_free_fields() will be removed by the following patch.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/bpf_local_storage.c | 8 ++------
 kernel/bpf/hashtab.c           | 6 ++----
 kernel/bpf/range_tree.c        | 2 --
 kernel/bpf/syscall.c           | 8 +++++++-
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 615a3034baeb5..12cf6382175e1 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -905,15 +905,11 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 		while ((selem = hlist_entry_safe(
 				rcu_dereference_raw(hlist_first_rcu(&b->list)),
 				struct bpf_local_storage_elem, map_node))) {
-			if (busy_counter) {
-				migrate_disable();
+			if (busy_counter)
 				this_cpu_inc(*busy_counter);
-			}
 			bpf_selem_unlink(selem, true);
-			if (busy_counter) {
+			if (busy_counter)
 				this_cpu_dec(*busy_counter);
-				migrate_enable();
-			}
 			cond_resched_rcu();
 		}
 		rcu_read_unlock();
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 7f09943c6ee22..772304f9519ba 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1519,10 +1519,9 @@ static void delete_all_elements(struct bpf_htab *htab)
 {
 	int i;
 
-	/* It's called from a worker thread, so disable migration here,
-	 * since bpf_mem_cache_free() relies on that.
+	/* It's called from a worker thread and migration has been disabled,
+	 * therefore, it is OK to invoke bpf_mem_cache_free() directly.
 	 */
-	migrate_disable();
 	for (i = 0; i < htab->n_buckets; i++) {
 		struct hlist_nulls_head *head = select_bucket(htab, i);
 		struct hlist_nulls_node *n;
@@ -1534,7 +1533,6 @@ static void delete_all_elements(struct bpf_htab *htab)
 		}
 		cond_resched();
 	}
-	migrate_enable();
 }
 
 static void htab_free_malloced_timers_and_wq(struct bpf_htab *htab)
diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 5bdf9aadca3a6..37b80a23ae1ae 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -259,9 +259,7 @@ void range_tree_destroy(struct range_tree *rt)
 
 	while ((rn = range_it_iter_first(rt, 0, -1U))) {
 		range_it_remove(rn, rt);
-		migrate_disable();
 		bpf_mem_free(&bpf_global_ma, rn);
-		migrate_enable();
 	}
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e88797fdbebb..5d24204929461 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -835,8 +835,14 @@ static void bpf_map_free(struct bpf_map *map)
 	struct btf_record *rec = map->record;
 	struct btf *btf = map->btf;
 
-	/* implementation dependent freeing */
+	/* implementation dependent freeing. Disabling migration to simplify
+	 * the free of values or special fields allocated from bpf memory
+	 * allocator.
+	 */
+	migrate_disable();
 	map->ops->map_free(map);
+	migrate_enable();
+
 	/* Delay freeing of btf_record for maps, as map_free
 	 * callback usually needs access to them. It is better to do it here
 	 * than require each callback to do the free itself manually.
-- 
2.29.2


