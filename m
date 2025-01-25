Return-Path: <bpf+bounces-49799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3134A1C2DD
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 11:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492363AA54F
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FD12080C6;
	Sat, 25 Jan 2025 10:59:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD4F2080D5
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802759; cv=none; b=aUlYhuIDZbsODxcXFirYR+vTvp1btoAJDY0NgJd5Wd4bucnaP9OgVLdXTWIGYzg3nn2tpWdZzMhh5TmmU+7DaLKv17nvEQF7FKoE0bvUMRjgMzGjtZgaK+t+xq7gX2W1q9ik4fsqPk967h4naMU2WXwOfZYGC3QdzmIBoPfSi+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802759; c=relaxed/simple;
	bh=C7E77lpN0p3OmwTwsJjbKwwA8xf2a4zDSTlEkugFLBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Co0SNibn2ZMoaU7UDMAgiLT8/3P4oujHpXkBdE75qj0l5ah+G+60wiqPOJmBrPE1/EMIxJ26T6d9+dC2UGuwmuFG5PdobxunFMgz4TqraC1xW4s1dvGCw0xosJuhY1bvMLDWacRvI3iubDpPjIKh4jhJOcGFmCCPG6QxCo0koH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YgBWF0J3Qz4f3kvf
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0F5F51A1085
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S17;
	Sat, 25 Jan 2025 18:59:10 +0800 (CST)
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
	Dan Carpenter <dan.carpenter@linaro.org>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next v2 13/20] bpf: Support basic operations for dynptr key in hash map
Date: Sat, 25 Jan 2025 19:11:02 +0800
Message-Id: <20250125111109.732718-14-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250125111109.732718-1-houtao@huaweicloud.com>
References: <20250125111109.732718-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S17
X-Coremail-Antispam: 1UD129KBjvAXoWfZFWrAr48JF4fKF4Dur47twb_yoW8ur1xto
	WfW3y3CFW8GF4xt3ykWFs2g3WkX3WDJayUJw4aqrs8Wa1a9r4YkryxCF4fKay5XF15tF10
	g340yasxur4rXr4rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOY7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU1aLvJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

The patch supports lookup, update, delete and lookup_delete operations
for hash map with dynptr map. There are two major differences between
the implementation of normal hash map and dynptr-keyed hash map:

1) dynptr-keyed hash map doesn't support pre-allocation.
The reason is that the dynptr in map key is allocated dynamically
through bpf mem allocator. The length limitation for these dynptrs is
4088 bytes now. Because there dynptrs are allocated dynamically, the
consumption of memory will be smaller compared with normal hash map when
there are big differences between the length of these dynptrs.

2) the freed element in dynptr-key map will not be reused immediately
For normal hash map, the freed element may be reused immediately by the
newly-added element, so the lookup may return an incorrect result due to
element deletion and element reuse. However dynptr-key map could not do
that, there are pointers (dynptrs) in the map key and the updates of
these dynptrs are not atomic: both the address and the length of the
dynptr will be updated. If the element is reused immediately, the access
of the dynptr in the freed element may incur invalid memory access due
to the mismatch between the address and the size of dynptr, so reuse the
freed element after one RCU grace period.

Beside the differences above, dynptr-keyed hash map also needs to handle
the maybe-nullified dynptr in the map key.

After the support of dynptr key in hash map, the performance of lookup
and update/delete operations in map_perf_test degrades a lot. Marking
lookup_nulls_elem_raw() and lookup_elem_raw() as always_inline will
narrow the gap from 21%/7% to 4%/2%. Therefore, the patch also adds
always_inline for these two hot functions. The following lines show the
detailed performance numbers:

before patch:
0:hash_map_perf kmalloc 693450 events per sec
0:hash_lookup 89366531 lookups per sec

after patch (without always_inline):
0:hash_map_perf kmalloc 650396 events per sec
0:hash_lookup 73961003 lookups per sec

after patch:
0:hash_map_perf kmalloc 665317 events per sec
0:hash_lookup 87842644 lookups per sec

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 288 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 259 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bb64eb83ec608..f3ec2b32b59b8 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -88,6 +88,7 @@ struct bpf_htab {
 	struct bpf_map map;
 	struct bpf_mem_alloc ma;
 	struct bpf_mem_alloc pcpu_ma;
+	struct bpf_mem_alloc dynptr_ma;
 	struct bucket *buckets;
 	void *elems;
 	union {
@@ -425,6 +426,7 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	bool percpu_lru = (attr->map_flags & BPF_F_NO_COMMON_LRU);
 	bool prealloc = !(attr->map_flags & BPF_F_NO_PREALLOC);
 	bool zero_seed = (attr->map_flags & BPF_F_ZERO_SEED);
+	bool dynptr_in_key = (attr->map_flags & BPF_INT_F_DYNPTR_IN_KEY);
 	int numa_node = bpf_map_attr_numa_node(attr);
 
 	BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=
@@ -438,6 +440,14 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	    !bpf_map_flags_access_ok(attr->map_flags))
 		return -EINVAL;
 
+	if (dynptr_in_key) {
+		if (percpu || lru || prealloc || !attr->map_extra)
+			return -EINVAL;
+		if ((attr->map_extra >> 32) || bpf_dynptr_check_size(attr->map_extra) ||
+		    bpf_mem_alloc_check_size(percpu, attr->map_extra))
+			return -E2BIG;
+	}
+
 	if (!lru && percpu_lru)
 		return -EINVAL;
 
@@ -482,6 +492,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	 */
 	bool percpu_lru = (attr->map_flags & BPF_F_NO_COMMON_LRU);
 	bool prealloc = !(attr->map_flags & BPF_F_NO_PREALLOC);
+	bool dynptr_in_key = (attr->map_flags & BPF_INT_F_DYNPTR_IN_KEY);
 	struct bpf_htab *htab;
 	int err, i;
 
@@ -598,6 +609,11 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 			if (err)
 				goto free_map_locked;
 		}
+		if (dynptr_in_key) {
+			err = bpf_mem_alloc_init(&htab->dynptr_ma, 0, false);
+			if (err)
+				goto free_map_locked;
+		}
 	}
 
 	return &htab->map;
@@ -610,6 +626,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
 		free_percpu(htab->map_locked[i]);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->dynptr_ma);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
 free_elem_count:
@@ -620,13 +637,55 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	return ERR_PTR(err);
 }
 
-static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
+static inline u32 __htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
 {
 	if (likely(key_len % 4 == 0))
 		return jhash2(key, key_len / 4, hashrnd);
 	return jhash(key, key_len, hashrnd);
 }
 
+static u32 htab_map_dynptr_hash(const void *key, u32 key_len, u32 hashrnd,
+				const struct btf_record *rec)
+{
+	unsigned int i, cnt = rec->cnt;
+	unsigned int hash = hashrnd;
+	unsigned int offset = 0;
+
+	for (i = 0; i < cnt; i++) {
+		const struct btf_field *field = &rec->fields[i];
+		const struct bpf_dynptr_kern *kptr;
+		unsigned int len;
+
+		if (field->type != BPF_DYNPTR)
+			continue;
+
+		/* non-dynptr part ? */
+		if (offset < field->offset)
+			hash = jhash(key + offset, field->offset - offset, hash);
+
+		/* Skip nullified dynptr */
+		kptr = key + field->offset;
+		if (kptr->data) {
+			len = __bpf_dynptr_size(kptr);
+			hash = jhash(__bpf_dynptr_data(kptr, len), len, hash);
+		}
+		offset = field->offset + field->size;
+	}
+
+	if (offset < key_len)
+		hash = jhash(key + offset, key_len - offset, hash);
+
+	return hash;
+}
+
+static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd,
+				const struct btf_record *rec)
+{
+	if (likely(!rec))
+		return __htab_map_hash(key, key_len, hashrnd);
+	return htab_map_dynptr_hash(key, key_len, hashrnd, rec);
+}
+
 static inline struct bucket *__select_bucket(struct bpf_htab *htab, u32 hash)
 {
 	return &htab->buckets[hash & (htab->n_buckets - 1)];
@@ -637,15 +696,68 @@ static inline struct hlist_nulls_head *select_bucket(struct bpf_htab *htab, u32
 	return &__select_bucket(htab, hash)->head;
 }
 
+static bool is_same_dynptr_key(const void *key, const void *tgt, unsigned int key_size,
+			       const struct btf_record *rec)
+{
+	unsigned int i, cnt = rec->cnt;
+	unsigned int offset = 0;
+
+	for (i = 0; i < cnt; i++) {
+		const struct btf_field *field = &rec->fields[i];
+		const struct bpf_dynptr_kern *kptr, *tgt_kptr;
+		const void *data, *tgt_data;
+		unsigned int len;
+
+		if (field->type != BPF_DYNPTR)
+			continue;
+
+		if (offset < field->offset &&
+		    memcmp(key + offset, tgt + offset, field->offset - offset))
+			return false;
+
+		/*
+		 * For a nullified dynptr in the target key, __bpf_dynptr_size()
+		 * will return 0, and there will be no match for the target key.
+		 */
+		kptr = key + field->offset;
+		tgt_kptr = tgt + field->offset;
+		len = __bpf_dynptr_size(kptr);
+		if (len != __bpf_dynptr_size(tgt_kptr))
+			return false;
+
+		data = __bpf_dynptr_data(kptr, len);
+		tgt_data = __bpf_dynptr_data(tgt_kptr, len);
+		if (memcmp(data, tgt_data, len))
+			return false;
+
+		offset = field->offset + field->size;
+	}
+
+	if (offset < key_size &&
+	    memcmp(key + offset, tgt + offset, key_size - offset))
+		return false;
+
+	return true;
+}
+
+static inline bool htab_is_same_key(const void *key, const void *tgt, unsigned int key_size,
+				    const struct btf_record *rec)
+{
+	if (likely(!rec))
+		return !memcmp(key, tgt, key_size);
+	return is_same_dynptr_key(key, tgt, key_size, rec);
+}
+
 /* this lookup function can only be called with bucket lock taken */
-static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, u32 hash,
-					 void *key, u32 key_size)
+static __always_inline struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, u32 hash,
+							 void *key, u32 key_size,
+							 const struct btf_record *record)
 {
 	struct hlist_nulls_node *n;
 	struct htab_elem *l;
 
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
-		if (l->hash == hash && !memcmp(&l->key, key, key_size))
+		if (l->hash == hash && htab_is_same_key(l->key, key, key_size, record))
 			return l;
 
 	return NULL;
@@ -655,16 +767,17 @@ static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, u32 hash
  * the unlikely event when elements moved from one bucket into another
  * while link list is being walked
  */
-static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
-					       u32 hash, void *key,
-					       u32 key_size, u32 n_buckets)
+static __always_inline struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
+							       u32 hash, void *key,
+							       u32 key_size, u32 n_buckets,
+							       const struct btf_record *record)
 {
 	struct hlist_nulls_node *n;
 	struct htab_elem *l;
 
 again:
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
-		if (l->hash == hash && !memcmp(&l->key, key, key_size))
+		if (l->hash == hash && htab_is_same_key(l->key, key, key_size, record))
 			return l;
 
 	if (unlikely(get_nulls_value(n) != (hash & (n_buckets - 1))))
@@ -681,6 +794,7 @@ static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
 static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	const struct btf_record *record;
 	struct hlist_nulls_head *head;
 	struct htab_elem *l;
 	u32 hash, key_size;
@@ -689,12 +803,13 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 		     !rcu_read_lock_bh_held());
 
 	key_size = map->key_size;
+	record = map->key_record;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(key, key_size, htab->hashrnd, record);
 
 	head = select_bucket(htab, hash);
 
-	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
+	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets, record);
 
 	return l;
 }
@@ -784,6 +899,26 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
 	return insn - insn_buf;
 }
 
+static void htab_free_dynptr_key(struct bpf_htab *htab, void *key)
+{
+	const struct btf_record *record = htab->map.key_record;
+	unsigned int i, cnt = record->cnt;
+
+	for (i = 0; i < cnt; i++) {
+		const struct btf_field *field = &record->fields[i];
+		struct bpf_dynptr_kern *kptr;
+
+		if (field->type != BPF_DYNPTR)
+			continue;
+
+		/* It may be accessed concurrently, so don't overwrite
+		 * the kptr.
+		 */
+		kptr = key + field->offset;
+		bpf_mem_free_rcu(&htab->dynptr_ma, kptr->data);
+	}
+}
+
 static void check_and_free_fields(struct bpf_htab *htab,
 				  struct htab_elem *elem)
 {
@@ -835,6 +970,68 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	return l == tgt_l;
 }
 
+static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void *key, u32 key_size)
+{
+	const struct btf_record *rec = htab->map.key_record;
+	struct bpf_dynptr_kern *dst_kptr;
+	const struct btf_field *field;
+	unsigned int i, cnt, offset;
+	int err;
+
+	offset = 0;
+	cnt = rec->cnt;
+	for (i = 0; i < cnt; i++) {
+		const struct bpf_dynptr_kern *kptr;
+		unsigned int len;
+		const void *data;
+		void *dst_data;
+
+		field = &rec->fields[i];
+		if (field->type != BPF_DYNPTR)
+			continue;
+
+		if (offset < field->offset)
+			memcpy(dst_key + offset, key + offset, field->offset - offset);
+
+		/* Doesn't support nullified dynptr in map key */
+		kptr = key + field->offset;
+		if (!kptr->data) {
+			err = -EINVAL;
+			goto out;
+		}
+		len = __bpf_dynptr_size(kptr);
+		data = __bpf_dynptr_data(kptr, len);
+
+		dst_data = bpf_mem_alloc(&htab->dynptr_ma, len);
+		if (!dst_data) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		memcpy(dst_data, data, len);
+		dst_kptr = dst_key + field->offset;
+		bpf_dynptr_init(dst_kptr, dst_data, BPF_DYNPTR_TYPE_LOCAL, 0, len);
+
+		offset = field->offset + field->size;
+	}
+
+	if (offset < key_size)
+		memcpy(dst_key + offset, key + offset, key_size - offset);
+
+	return 0;
+
+out:
+	for (; i > 0; i--) {
+		field = &rec->fields[i - 1];
+		if (field->type != BPF_DYNPTR)
+			continue;
+
+		dst_kptr = dst_key + field->offset;
+		bpf_mem_free(&htab->dynptr_ma, dst_kptr->data);
+	}
+	return err;
+}
+
 /* Called from syscall */
 static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 {
@@ -851,12 +1048,12 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	if (!key)
 		goto find_first_elem;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(key, key_size, htab->hashrnd, NULL);
 
 	head = select_bucket(htab, hash);
 
 	/* lookup the key */
-	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
+	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets, NULL);
 
 	if (!l)
 		goto find_first_elem;
@@ -896,11 +1093,27 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 {
+	bool dynptr_in_key = bpf_map_has_dynptr_key(&htab->map);
+
+	if (dynptr_in_key)
+		htab_free_dynptr_key(htab, l->key);
+
 	check_and_free_fields(htab, l);
 
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
 		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
-	bpf_mem_cache_free(&htab->ma, l);
+
+	/*
+	 * For dynptr key, the update of dynptr in the key is not atomic:
+	 * both the pointer and the size are updated. If the element is reused
+	 * immediately, the access of the dynptr key during lookup procedure may
+	 * incur invalid memory access due to mismatch between the size and the
+	 * data pointer, so reuse the element after one RCU GP.
+	 */
+	if (dynptr_in_key)
+		bpf_mem_cache_free_rcu(&htab->ma, l);
+	else
+		bpf_mem_cache_free(&htab->ma, l);
 }
 
 static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
@@ -1047,7 +1260,19 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 		}
 	}
 
-	memcpy(l_new->key, key, key_size);
+	if (bpf_map_has_dynptr_key(&htab->map)) {
+		int copy_err;
+
+		copy_err = htab_copy_dynptr_key(htab, l_new->key, key, key_size);
+		if (copy_err) {
+			bpf_mem_cache_free(&htab->ma, l_new);
+			l_new = ERR_PTR(copy_err);
+			goto dec_count;
+		}
+	} else {
+		memcpy(l_new->key, key, key_size);
+	}
+
 	if (percpu) {
 		if (prealloc) {
 			pptr = htab_elem_get_ptr(l_new, key_size);
@@ -1103,6 +1328,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 				 u64 map_flags)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	const struct btf_record *key_record = map->key_record;
 	struct htab_elem *l_new = NULL, *l_old;
 	struct hlist_nulls_head *head;
 	unsigned long flags;
@@ -1120,7 +1346,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(key, key_size, htab->hashrnd, key_record);
 
 	b = __select_bucket(htab, hash);
 	head = &b->head;
@@ -1130,7 +1356,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 			return -EINVAL;
 		/* find an element without taking the bucket lock */
 		l_old = lookup_nulls_elem_raw(head, hash, key, key_size,
-					      htab->n_buckets);
+					      htab->n_buckets, key_record);
 		ret = check_flags(htab, l_old, map_flags);
 		if (ret)
 			return ret;
@@ -1151,7 +1377,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(head, hash, key, key_size, key_record);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1238,7 +1464,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = __htab_map_hash(key, key_size, htab->hashrnd);
 
 	b = __select_bucket(htab, hash);
 	head = &b->head;
@@ -1258,7 +1484,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	if (ret)
 		goto err_lock_bucket;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(head, hash, key, key_size, NULL);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1307,7 +1533,7 @@ static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = __htab_map_hash(key, key_size, htab->hashrnd);
 
 	b = __select_bucket(htab, hash);
 	head = &b->head;
@@ -1316,7 +1542,7 @@ static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(head, hash, key, key_size, NULL);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1362,7 +1588,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(key, key_size, htab->hashrnd, NULL);
 
 	b = __select_bucket(htab, hash);
 	head = &b->head;
@@ -1382,7 +1608,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	if (ret)
 		goto err_lock_bucket;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(head, hash, key, key_size, NULL);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1428,6 +1654,7 @@ static long htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 static long htab_map_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	const struct btf_record *key_record = map->key_record;
 	struct hlist_nulls_head *head;
 	struct bucket *b;
 	struct htab_elem *l;
@@ -1440,7 +1667,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(key, key_size, htab->hashrnd, key_record);
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
@@ -1448,7 +1675,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(head, hash, key, key_size, key_record);
 	if (l)
 		hlist_nulls_del_rcu(&l->hash_node);
 	else
@@ -1476,7 +1703,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = __htab_map_hash(key, key_size, htab->hashrnd);
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
@@ -1484,7 +1711,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(head, hash, key, key_size, NULL);
 
 	if (l)
 		hlist_nulls_del_rcu(&l->hash_node);
@@ -1581,6 +1808,7 @@ static void htab_map_free(struct bpf_map *map)
 	bpf_map_free_elem_count(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->dynptr_ma);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
 	if (htab->use_percpu_counter)
@@ -1617,6 +1845,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 					     bool is_percpu, u64 flags)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	const struct btf_record *key_record;
 	struct hlist_nulls_head *head;
 	unsigned long bflags;
 	struct htab_elem *l;
@@ -1625,8 +1854,9 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	int ret;
 
 	key_size = map->key_size;
+	key_record = map->key_record;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(key, key_size, htab->hashrnd, key_record);
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
@@ -1634,7 +1864,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(head, hash, key, key_size, key_record);
 	if (!l) {
 		ret = -ENOENT;
 		goto out_unlock;
-- 
2.29.2


