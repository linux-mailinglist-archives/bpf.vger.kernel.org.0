Return-Path: <bpf+bounces-55032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08954A77448
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 08:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD631889996
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 06:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED501DF739;
	Tue,  1 Apr 2025 06:10:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CA51372
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743487858; cv=none; b=jWxxBahAYU8hxp4PmhCrDjyrajMX1z9S4lGb5gfhAnhEA2crlMNFfSAL7Sgq10DTkEoEsE8vnROBTVlp+ZmBSpHucIVoLkgjDoVfvJrc1H+Qus4blp1uqj3CvF8We/YhbSdKJgeVoMu4drncCdRzIV+B3Eq0Z+tIyKsFGTuqvq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743487858; c=relaxed/simple;
	bh=FbVZn5tes41i4uFQEG1qxNONyuvrUGfUbQTrlPODBiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRW7+J0lgwyI2nL9jaBFQVDjb6OWq/YThe8nMQQiavTDGsmeqXhYJUIS7RnDtNaHlRfaWK0fQJFDkOo3yJBkf1C68jDs/WEqQ1SwcGo8CtOQpu/8s1r1fO1gfbAqziDcMyIDXjFjqzvnMhfQCsqgrdjfppxj9aw/rPE1DvfHvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZRd054c26z4f3k6M
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 14:10:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 638931A0D1A
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 14:10:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl9ig+tnpa6yIA--.16784S5;
	Tue, 01 Apr 2025 14:10:47 +0800 (CST)
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
Subject: [PATCH bpf-next v3 1/6] bpf: Factor out htab_elem_value helper()
Date: Tue,  1 Apr 2025 14:22:45 +0800
Message-Id: <20250401062250.543403-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250401062250.543403-1-houtao@huaweicloud.com>
References: <20250401062250.543403-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl9ig+tnpa6yIA--.16784S5
X-Coremail-Antispam: 1UD129KBjvJXoW3XrWfKFyfWrW3Aw4UXw48Xrb_yoWfKryDpF
	WrWw1xCw48Zr4qq3y5tw40ka95J34Dtr1jkas8ta4FkFn8Jr9xJ3WxAF9FgrZ8AF1vyrn5
	trWvqaySqay8CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3cTm
	DUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

All hash maps store map key and map value together. The relative offset
of the map value compared to the map key is round_up(key_size, 8).
Therefore, factor out a common helper htab_elem_value() to calculate the
address of the map value instead of duplicating the logic.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 64 +++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5a5adc66b8e2..0bebc919bbf7 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -175,20 +175,25 @@ static bool htab_is_percpu(const struct bpf_htab *htab)
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
@@ -215,10 +220,10 @@ static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
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
@@ -245,7 +250,8 @@ static void htab_free_prealloced_fields(struct bpf_htab *htab)
 				cond_resched();
 			}
 		} else {
-			bpf_obj_free_fields(htab->map.record, elem->key + round_up(htab->map.key_size, 8));
+			bpf_obj_free_fields(htab->map.record,
+					    htab_elem_value(elem, htab->map.key_size));
 			cond_resched();
 		}
 		cond_resched();
@@ -670,7 +676,7 @@ static void *htab_map_lookup_elem(struct bpf_map *map, void *key)
 	struct htab_elem *l = __htab_map_lookup_elem(map, key);
 
 	if (l)
-		return l->key + round_up(map->key_size, 8);
+		return htab_elem_value(l, map->key_size);
 
 	return NULL;
 }
@@ -709,7 +715,7 @@ static __always_inline void *__htab_lru_map_lookup_elem(struct bpf_map *map,
 	if (l) {
 		if (mark)
 			bpf_lru_node_set_ref(&l->lru_node);
-		return l->key + round_up(map->key_size, 8);
+		return htab_elem_value(l, map->key_size);
 	}
 
 	return NULL;
@@ -763,7 +769,7 @@ static void check_and_free_fields(struct bpf_htab *htab,
 		for_each_possible_cpu(cpu)
 			bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
 	} else {
-		void *map_value = elem->key + round_up(htab->map.key_size, 8);
+		void *map_value = htab_elem_value(elem, htab->map.key_size);
 
 		bpf_obj_free_fields(htab->map.record, map_value);
 	}
@@ -1039,11 +1045,9 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
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
@@ -1106,7 +1110,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		if (l_old) {
 			/* grab the element lock and update value in place */
 			copy_map_value_locked(map,
-					      l_old->key + round_up(key_size, 8),
+					      htab_elem_value(l_old, key_size),
 					      value, false);
 			return 0;
 		}
@@ -1134,7 +1138,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		 * and update element in place
 		 */
 		copy_map_value_locked(map,
-				      l_old->key + round_up(key_size, 8),
+				      htab_elem_value(l_old, key_size),
 				      value, false);
 		ret = 0;
 		goto err;
@@ -1220,8 +1224,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	l_new = prealloc_lru_pop(htab, key, hash);
 	if (!l_new)
 		return -ENOMEM;
-	copy_map_value(&htab->map,
-		       l_new->key + round_up(map->key_size, 8), value);
+	copy_map_value(&htab->map, htab_elem_value(l_new, map->key_size), value);
 
 	ret = htab_lock_bucket(b, &flags);
 	if (ret)
@@ -1500,10 +1503,10 @@ static void htab_free_malloced_timers_and_wq(struct bpf_htab *htab)
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
@@ -1615,15 +1618,12 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
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
@@ -1680,12 +1680,12 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
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
@@ -1720,7 +1720,6 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		return -ENOENT;
 
 	key_size = htab->map.key_size;
-	roundup_key_size = round_up(htab->map.key_size, 8);
 	value_size = htab->map.value_size;
 	size = round_up(value_size, 8);
 	if (is_percpu)
@@ -1812,7 +1811,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 				off += size;
 			}
 		} else {
-			value = l->key + roundup_key_size;
+			value = htab_elem_value(l, key_size);
 			if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS) {
 				struct bpf_map **inner_map = value;
 
@@ -2063,11 +2062,11 @@ static void *bpf_hash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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
 
@@ -2077,10 +2076,9 @@ static int __bpf_hash_map_seq_show(struct seq_file *seq, struct htab_elem *elem)
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
@@ -2165,7 +2163,6 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 	struct hlist_nulls_head *head;
 	struct hlist_nulls_node *n;
 	struct htab_elem *elem;
-	u32 roundup_key_size;
 	int i, num_elems = 0;
 	void __percpu *pptr;
 	struct bucket *b;
@@ -2180,7 +2177,6 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 
 	is_percpu = htab_is_percpu(htab);
 
-	roundup_key_size = round_up(map->key_size, 8);
 	/* migration has been disabled, so percpu value prepared here will be
 	 * the same as the one seen by the bpf program with
 	 * bpf_map_lookup_elem().
@@ -2196,7 +2192,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
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


