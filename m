Return-Path: <bpf+bounces-54791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38061A72B58
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657FA1898883
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B282054ED;
	Thu, 27 Mar 2025 08:23:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF40204F96
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063781; cv=none; b=pn1KDqddWbqrjXlgHF9UrnXY50IU6Lr/kGNqlk0pTmWVf68j2PrETEIyVNVbfWjHtYmXrtxpuEdXpsm9ul5/Ipb2NKVG1B5vWHc1ylnn7SEqrd3lgEvHun/0ieS7nZyblTPK94+k8yMKpLpY/jX7CX9MvTGExtrd02L47HLLPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063781; c=relaxed/simple;
	bh=K9b6HESaDBVB5EcoK0mYstVpHc8+vb3/8Cl/x55Zr14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mBjmMZG/E9gcq2Y6jGE5Kz8+XE4FZUGPeC2pp1UHgfQvSkmSAmVYUKiHqdaRYurAeU+KwUesdQAnFwN0LhapKyZxe+TMnCDrcBUWw9hv1Lggkq9VslB+MgZ/s85VCcDnB22sWO0v7aM6bhJ+qIC/Syxp6S7dnjw0TaYAxZV2wI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8t58nqz4f3jtK
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4B3D21A083E
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S13;
	Thu, 27 Mar 2025 16:22:56 +0800 (CST)
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
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 09/16] bpf: Support basic operations for dynptr key in hash map
Date: Thu, 27 Mar 2025 16:34:48 +0800
Message-Id: <20250327083455.848708-10-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250327083455.848708-1-houtao@huaweicloud.com>
References: <20250327083455.848708-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S13
X-Coremail-Antispam: 1UD129KBjvAXoWfZFW7AFy3KryrAryDJr47Jwb_yoW8ZFyfJo
	WfW3y3CF48GF4xt3ykWFs7W3WrX345JayUJw4aqwsxWw4avr4YkryxCF43Kay5XF15tF10
	gry0y3sxur4rWr4rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOY7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
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
narrow the gap from 22%/10% to ~3%. Therefore, the patch also adds
always_inline for these two hot functions. The following lines show the
detailed performance numbers:

before patch:
0:hash_map_perf pre-alloc 716183 events per sec
0:hash_map_perf kmalloc 718449 events per sec
0:hash_lookup 96028984 lookups per sec

after patch (without always_inline):
0:hash_map_perf pre-alloc 680580 events per sec
0:hash_map_perf kmalloc 648885 events per sec
0:hash_lookup 77693901 lookups per sec

after patch:
0:hash_map_perf pre-alloc 701188 events per sec
0:hash_map_perf kmalloc 690954 events per sec
0:hash_lookup 93802965 lookups per sec

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 291 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 261 insertions(+), 30 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5a5adc66b8e22..028542c2b4237 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -105,6 +105,7 @@ struct bpf_htab {
 	u32 n_buckets;	/* number of hash buckets */
 	u32 elem_size;	/* size of each element in bytes */
 	u32 hashrnd;
+	struct bpf_mem_alloc dynptr_ma;
 };
 
 /* each htab element is struct htab_elem + key + value */
@@ -586,13 +587,55 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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
@@ -603,15 +646,68 @@ static inline struct hlist_nulls_head *select_bucket(struct bpf_htab *htab, u32
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
@@ -621,16 +717,17 @@ static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, u32 hash
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
@@ -647,6 +744,7 @@ static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *head,
 static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	const struct btf_record *record;
 	struct hlist_nulls_head *head;
 	struct htab_elem *l;
 	u32 hash, key_size;
@@ -655,12 +753,13 @@ static void *__htab_map_lookup_elem(struct bpf_map *map, void *key)
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
@@ -750,6 +849,26 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
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
@@ -804,6 +923,68 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
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
+	while (i-- > 0) {
+		field = &rec->fields[i];
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
@@ -820,12 +1001,12 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
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
@@ -865,11 +1046,27 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
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
@@ -1016,7 +1213,19 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
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
@@ -1072,7 +1281,8 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 				 u64 map_flags)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
-	struct htab_elem *l_new = NULL, *l_old;
+	const struct btf_record *key_record = map->key_record;
+	struct htab_elem *l_new, *l_old;
 	struct hlist_nulls_head *head;
 	unsigned long flags;
 	void *old_map_ptr;
@@ -1089,7 +1299,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(key, key_size, htab->hashrnd, key_record);
 
 	b = __select_bucket(htab, hash);
 	head = &b->head;
@@ -1099,7 +1309,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 			return -EINVAL;
 		/* find an element without taking the bucket lock */
 		l_old = lookup_nulls_elem_raw(head, hash, key, key_size,
-					      htab->n_buckets);
+					      htab->n_buckets, key_record);
 		ret = check_flags(htab, l_old, map_flags);
 		if (ret)
 			return ret;
@@ -1120,7 +1330,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(head, hash, key, key_size, key_record);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1207,7 +1417,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = __htab_map_hash(key, key_size, htab->hashrnd);
 
 	b = __select_bucket(htab, hash);
 	head = &b->head;
@@ -1227,7 +1437,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	if (ret)
 		goto err_lock_bucket;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(head, hash, key, key_size, NULL);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1276,7 +1486,7 @@ static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = __htab_map_hash(key, key_size, htab->hashrnd);
 
 	b = __select_bucket(htab, hash);
 	head = &b->head;
@@ -1285,7 +1495,7 @@ static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(head, hash, key, key_size, NULL);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1331,7 +1541,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(key, key_size, htab->hashrnd, NULL);
 
 	b = __select_bucket(htab, hash);
 	head = &b->head;
@@ -1351,7 +1561,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	if (ret)
 		goto err_lock_bucket;
 
-	l_old = lookup_elem_raw(head, hash, key, key_size);
+	l_old = lookup_elem_raw(head, hash, key, key_size, NULL);
 
 	ret = check_flags(htab, l_old, map_flags);
 	if (ret)
@@ -1397,6 +1607,7 @@ static long htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 static long htab_map_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	const struct btf_record *key_record = map->key_record;
 	struct hlist_nulls_head *head;
 	struct bucket *b;
 	struct htab_elem *l;
@@ -1409,7 +1620,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(key, key_size, htab->hashrnd, key_record);
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
@@ -1417,7 +1628,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(head, hash, key, key_size, key_record);
 	if (l)
 		hlist_nulls_del_rcu(&l->hash_node);
 	else
@@ -1445,7 +1656,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 
 	key_size = map->key_size;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = __htab_map_hash(key, key_size, htab->hashrnd);
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
@@ -1453,7 +1664,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(head, hash, key, key_size, NULL);
 
 	if (l)
 		hlist_nulls_del_rcu(&l->hash_node);
@@ -1547,6 +1758,7 @@ static void htab_map_free(struct bpf_map *map)
 	bpf_map_free_elem_count(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->dynptr_ma);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
 	if (htab->use_percpu_counter)
@@ -1580,6 +1792,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 					     bool is_percpu, u64 flags)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	const struct btf_record *key_record;
 	struct hlist_nulls_head *head;
 	unsigned long bflags;
 	struct htab_elem *l;
@@ -1588,8 +1801,9 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	int ret;
 
 	key_size = map->key_size;
+	key_record = map->key_record;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	hash = htab_map_hash(key, key_size, htab->hashrnd, key_record);
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
@@ -1597,7 +1811,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	if (ret)
 		return ret;
 
-	l = lookup_elem_raw(head, hash, key, key_size);
+	l = lookup_elem_raw(head, hash, key, key_size, key_record);
 	if (!l) {
 		ret = -ENOENT;
 		goto out_unlock;
@@ -2251,6 +2465,22 @@ static u64 htab_map_mem_usage(const struct bpf_map *map)
 	return usage;
 }
 
+static int htab_map_check_btf(const struct bpf_map *map, const struct btf *btf,
+			      const struct btf_type *key_type, const struct btf_type *value_type)
+{
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+
+	/* Only support non-preallocated map */
+	if (bpf_map_has_dynptr_key(map)) {
+		if (htab_is_prealloc(htab))
+			return -EINVAL;
+
+		return bpf_mem_alloc_init(&htab->dynptr_ma, 0, false);
+	}
+
+	return 0;
+}
+
 BTF_ID_LIST_SINGLE(htab_map_btf_ids, struct, bpf_htab)
 const struct bpf_map_ops htab_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -2264,6 +2494,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_update_elem = htab_map_update_elem,
 	.map_delete_elem = htab_map_delete_elem,
 	.map_gen_lookup = htab_map_gen_lookup,
+	.map_check_btf = htab_map_check_btf,
 	.map_seq_show_elem = htab_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
-- 
2.29.2


