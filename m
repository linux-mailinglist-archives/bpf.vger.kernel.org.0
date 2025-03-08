Return-Path: <bpf+bounces-53649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335AFA57A8F
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 14:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7041A16BD20
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A741E1D5CEE;
	Sat,  8 Mar 2025 13:39:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E861C9DE5
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441159; cv=none; b=K919W3hGThDqdyMkPmlz4R7E+s1qRbe2vRckH4ce7xRYsuNtzs07NzQ0fTWbGFNDNPSiJEWZ8KFO0KT49DGcyR1L8fE9xPpkGD0+BgHnlh+/7mzVYfdDP1Btj5m5O8v5sdYOtCI0RpodxCN1QB30AkLMuEvncR8V31NPhm2GIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441159; c=relaxed/simple;
	bh=euqcHyUpq+wNGA6ZhacV2+AvFCj/uPCw35Q7fC+it0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJ2jzGgjVfdC9tao9k1fN40Pk4CprPQnuoxTDQ49ca9lIPAIs1A0sBMoBVABOV6c8yMl4ffOuwluXg+g3yb0QoCs1KQhMZrUpJFVP+IPBZ4ul+jywTTFbxboLpba11vOufxoFlZPBgF/Iu7saeNWJc41miOE+NJqaDjjG2wnv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z944N0LFSz4f3jcp
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 21:38:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4A0B91A06DC
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 21:39:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl91SMxn+YeeFw--.42876S5;
	Sat, 08 Mar 2025 21:39:06 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
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
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Zvi Effron <zeffron@riotgames.com>,
	Cody Haas <chaas@riotgames.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v2 1/6] bpf: Factor out htab_elem_value helper()
Date: Sat,  8 Mar 2025 21:51:05 +0800
Message-Id: <20250308135110.953269-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250308135110.953269-1-houtao@huaweicloud.com>
References: <20250308135110.953269-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnSl91SMxn+YeeFw--.42876S5
X-Coremail-Antispam: 1UD129KBjvJXoW3XrWfKFyfWrW3Aw4UXw48Xrb_yoWftw4DpF
	WrWw1xCw48Zr4qq3y5tw40ka95J34Utr1jkas8ta4FkFn8Gr9xJ3WxAF9FgrZ8AF1vyrn5
	trWvqaySqayxCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	W8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jqYL9U
	UUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

All hash maps store map key and map value together. The relative offset
of the map value compared to the map key is round_up(key_size, 8).
Therefore, factor out a common helper htab_elem_value() to calculate the
address of the map value instead of duplicating the logic.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 64 +++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c308300fc72f6..0df86845c8472 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -195,20 +195,25 @@ static bool htab_is_percpu(const struct bpf_htab *htab)
 		htab->map.map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH;
 }
 
+static inline void *htab_elem_value(struct htab_elem *l, u32 key_size)
+{
+	return l->key + round_up(key_size, 8);
+}
+
 static inline void htab_elem_set_ptr(struct htab_elem *l, u32 key_size,
 				     void __percpu *pptr)
 {
-	*(void __percpu **)(l->key + roundup(key_size, 8)) = pptr;
+	*(void __percpu **)htab_elem_value(l, key_size) = pptr;
 }
 
 static inline void __percpu *htab_elem_get_ptr(struct htab_elem *l, u32 key_size)
 {
-	return *(void __percpu **)(l->key + roundup(key_size, 8));
+	return *(void __percpu **)htab_elem_value(l, key_size);
 }
 
 static void *fd_htab_map_get_ptr(const struct bpf_map *map, struct htab_elem *l)
 {
-	return *(void **)(l->key + roundup(map->key_size, 8));
+	return *(void **)htab_elem_value(l, map->key_size);
 }
 
 static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
@@ -235,10 +240,10 @@ static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
 		elem = get_htab_elem(htab, i);
 		if (btf_record_has_field(htab->map.record, BPF_TIMER))
 			bpf_obj_free_timer(htab->map.record,
-					   elem->key + round_up(htab->map.key_size, 8));
+					   htab_elem_value(elem, htab->map.key_size));
 		if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
 			bpf_obj_free_workqueue(htab->map.record,
-					       elem->key + round_up(htab->map.key_size, 8));
+					       htab_elem_value(elem, htab->map.key_size));
 		cond_resched();
 	}
 }
@@ -265,7 +270,8 @@ static void htab_free_prealloced_fields(struct bpf_htab *htab)
 				cond_resched();
 			}
 		} else {
-			bpf_obj_free_fields(htab->map.record, elem->key + round_up(htab->map.key_size, 8));
+			bpf_obj_free_fields(htab->map.record,
+					    htab_elem_value(elem, htab->map.key_size));
 			cond_resched();
 		}
 		cond_resched();
@@ -704,7 +710,7 @@ static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
 	struct htab_elem *l = __htab_map_lookup_elem(map, key);
 
 	if (l)
-		return l->key + round_up(map->key_size, 8);
+		return htab_elem_value(l, map->key_size);
 
 	return NULL;
 }
@@ -743,7 +749,7 @@ static __always_inline void *__htab_lru_map_lookup_elem(struct bpf_map *map,
 	if (l) {
 		if (mark)
 			bpf_lru_node_set_ref(&l->lru_node);
-		return l->key + round_up(map->key_size, 8);
+		return htab_elem_value(l, map->key_size);
 	}
 
 	return NULL;
@@ -794,7 +800,7 @@ static void check_and_free_fields(struct bpf_htab *htab,
 		for_each_possible_cpu(cpu)
 			bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
 	} else {
-		void *map_value = elem->key + round_up(htab->map.key_size, 8);
+		void *map_value = htab_elem_value(elem, htab->map.key_size);
 
 		bpf_obj_free_fields(htab->map.record, map_value);
 	}
@@ -1070,11 +1076,9 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			htab_elem_set_ptr(l_new, key_size, pptr);
 	} else if (fd_htab_map_needs_adjust(htab)) {
 		size = round_up(size, 8);
-		memcpy(l_new->key + round_up(key_size, 8), value, size);
+		memcpy(htab_elem_value(l_new, key_size), value, size);
 	} else {
-		copy_map_value(&htab->map,
-			       l_new->key + round_up(key_size, 8),
-			       value);
+		copy_map_value(&htab->map, htab_elem_value(l_new, key_size), value);
 	}
 
 	l_new->hash = hash;
@@ -1137,7 +1141,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		if (l_old) {
 			/* grab the element lock and update value in place */
 			copy_map_value_locked(map,
-					      l_old->key + round_up(key_size, 8),
+					      htab_elem_value(l_old, key_size),
 					      value, false);
 			return 0;
 		}
@@ -1165,7 +1169,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		 * and update element in place
 		 */
 		copy_map_value_locked(map,
-				      l_old->key + round_up(key_size, 8),
+				      htab_elem_value(l_old, key_size),
 				      value, false);
 		ret = 0;
 		goto err;
@@ -1251,8 +1255,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	l_new = prealloc_lru_pop(htab, key, hash);
 	if (!l_new)
 		return -ENOMEM;
-	copy_map_value(&htab->map,
-		       l_new->key + round_up(map->key_size, 8), value);
+	copy_map_value(&htab->map, htab_elem_value(l_new, map->key_size), value);
 
 	ret = htab_lock_bucket(htab, b, hash, &flags);
 	if (ret)
@@ -1531,10 +1534,10 @@ static void htab_free_malloced_timers_and_wq(struct bpf_htab *htab)
 			/* We only free timer on uref dropping to zero */
 			if (btf_record_has_field(htab->map.record, BPF_TIMER))
 				bpf_obj_free_timer(htab->map.record,
-						   l->key + round_up(htab->map.key_size, 8));
+						   htab_elem_value(l, htab->map.key_size));
 			if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
 				bpf_obj_free_workqueue(htab->map.record,
-						       l->key + round_up(htab->map.key_size, 8));
+						       htab_elem_value(l, htab->map.key_size));
 		}
 		cond_resched_rcu();
 	}
@@ -1650,15 +1653,12 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 			off += roundup_value_size;
 		}
 	} else {
-		u32 roundup_key_size = round_up(map->key_size, 8);
+		void *src = htab_elem_value(l, map->key_size);
 
 		if (flags & BPF_F_LOCK)
-			copy_map_value_locked(map, value, l->key +
-					      roundup_key_size,
-					      true);
+			copy_map_value_locked(map, value, src, true);
 		else
-			copy_map_value(map, value, l->key +
-				       roundup_key_size);
+			copy_map_value(map, value, src);
 		/* Zeroing special fields in the temp buffer */
 		check_and_init_map_value(map, value);
 	}
@@ -1715,12 +1715,12 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 				   bool is_percpu)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
-	u32 bucket_cnt, total, key_size, value_size, roundup_key_size;
 	void *keys = NULL, *values = NULL, *value, *dst_key, *dst_val;
 	void __user *uvalues = u64_to_user_ptr(attr->batch.values);
 	void __user *ukeys = u64_to_user_ptr(attr->batch.keys);
 	void __user *ubatch = u64_to_user_ptr(attr->batch.in_batch);
 	u32 batch, max_count, size, bucket_size, map_id;
+	u32 bucket_cnt, total, key_size, value_size;
 	struct htab_elem *node_to_free = NULL;
 	u64 elem_map_flags, map_flags;
 	struct hlist_nulls_head *head;
@@ -1755,7 +1755,6 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		return -ENOENT;
 
 	key_size = htab->map.key_size;
-	roundup_key_size = round_up(htab->map.key_size, 8);
 	value_size = htab->map.value_size;
 	size = round_up(value_size, 8);
 	if (is_percpu)
@@ -1847,7 +1846,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 				off += size;
 			}
 		} else {
-			value = l->key + roundup_key_size;
+			value = htab_elem_value(l, key_size);
 			if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
 				struct bpf_map **inner_map = value;
 
@@ -2098,11 +2097,11 @@ static void *bpf_hash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 static int __bpf_hash_map_seq_show(struct seq_file *seq, struct htab_elem *elem)
 {
 	struct bpf_iter_seq_hash_map_info *info = seq->private;
-	u32 roundup_key_size, roundup_value_size;
 	struct bpf_iter__bpf_map_elem ctx = {};
 	struct bpf_map *map = info->map;
 	struct bpf_iter_meta meta;
 	int ret = 0, off = 0, cpu;
+	u32 roundup_value_size;
 	struct bpf_prog *prog;
 	void __percpu *pptr;
 
@@ -2112,10 +2111,9 @@ static int __bpf_hash_map_seq_show(struct seq_file *seq, struct htab_elem *elem)
 		ctx.meta = &meta;
 		ctx.map = info->map;
 		if (elem) {
-			roundup_key_size = round_up(map->key_size, 8);
 			ctx.key = elem->key;
 			if (!info->percpu_value_buf) {
-				ctx.value = elem->key + roundup_key_size;
+				ctx.value = htab_elem_value(elem, map->key_size);
 			} else {
 				roundup_value_size = round_up(map->value_size, 8);
 				pptr = htab_elem_get_ptr(elem, map->key_size);
@@ -2200,7 +2198,6 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 	struct hlist_nulls_head *head;
 	struct hlist_nulls_node *n;
 	struct htab_elem *elem;
-	u32 roundup_key_size;
 	int i, num_elems = 0;
 	void __percpu *pptr;
 	struct bucket *b;
@@ -2215,7 +2212,6 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 
 	is_percpu = htab_is_percpu(htab);
 
-	roundup_key_size = round_up(map->key_size, 8);
 	/* migration has been disabled, so percpu value prepared here will be
 	 * the same as the one seen by the bpf program with
 	 * bpf_map_lookup_elem().
@@ -2231,7 +2227,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 				pptr = htab_elem_get_ptr(elem, map->key_size);
 				val = this_cpu_ptr(pptr);
 			} else {
-				val = elem->key + roundup_key_size;
+				val = htab_elem_value(elem, map->key_size);
 			}
 			num_elems++;
 			ret = callback_fn((u64)(long)map, (u64)(long)key,
-- 
2.29.2


