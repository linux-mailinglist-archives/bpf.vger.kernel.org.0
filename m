Return-Path: <bpf+bounces-1502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AC9717D96
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 13:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2C628140B
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 11:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D2DC8E5;
	Wed, 31 May 2023 11:04:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9DC8C8
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 11:04:56 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A4C183
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 04:04:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso5578919f8f.0
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 04:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1685531069; x=1688123069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKqW90tEGzJhO8gTI+1JKAbI0vUvAAG3XX/zWwWhBQ8=;
        b=X8GzSD6WMRV18auhbmujp/TrfqJX0uzA1ckrSD+wWpL+fasv4fL1yKNsNoCInPFRtL
         WbY2KwT3kuJESindt1P18P/Ab/ve4EsYoZnjjqI11ARAkFlMiPiHVFvbyLBjewI1PAmO
         phcN3VRQetDyTiHfSyBw1GBIE2XHak7KENGKCMvFJ24topi0YPxgrgPO0IhVlLaxGjSU
         eKXdN3WhB6Q5vNRURp5A2ppB3YmfN2loY10BhrN7RfUmGkDL3bdS8UTBp2EaHEVebpkd
         9fGvtYNU7E+nSjfD52C8A1Y95XeaMncV+HwB9lsun4PJOroUxC7qKJScSjtov9TOJDcs
         cMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685531069; x=1688123069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKqW90tEGzJhO8gTI+1JKAbI0vUvAAG3XX/zWwWhBQ8=;
        b=B9hFTw7K/mHpuLE8bSus4K7iW6YhW2n+OIohsxiCaSVRFGsOstfDT9CPQK/GNunZc5
         lEOtZglDeydwdNE8yUZXqVD3rSOrPKFXbBTRXn+hVkl/Xz/8YiuZqKKa9M2U6bT9uYF4
         ZH7TmTY1U5aeMzZH/fajkh2FIjhDd+GtFgY71R+NZklKHqe+FVu3olpq6q6cOZzA1Cd0
         mWYNITeeJX/lr135jkB4RvHt3Rj/VTjeyAteGmNIIWFOPLznh9IF8p02YMx4qoaMaqUC
         OdUKKLc9AsV1mzSycj5WzgZYKnhCzf60X7LGkn0oHp9jG+DTDyyAY5GoiKzjz0FmP+GQ
         j0uA==
X-Gm-Message-State: AC+VfDwT2AmV0RmRNoAG/Mx0NVnBLciDSoLZ1473nMQjs/uxJifgeCav
	XbAE8hUm7qtDChDTsD2SI2wwJ9NrrPxP1YzZqRvh/E3Y
X-Google-Smtp-Source: ACHHUZ7xJSi0BwwNhBMrORYUIB+8vRZHDPszk/1s1a5EXJf+1hj2V9MHCdYGDjchpmzLBULJ1Nqr2Q==
X-Received: by 2002:a5d:67c5:0:b0:306:3ec8:289d with SMTP id n5-20020a5d67c5000000b003063ec8289dmr4006912wrw.46.1685531069507;
        Wed, 31 May 2023 04:04:29 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id b9-20020adfe309000000b003079986fd71sm6536029wrj.88.2023.05.31.04.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 04:04:29 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Joe Stringer <joe@isovalent.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
Date: Wed, 31 May 2023 11:05:10 +0000
Message-Id: <20230531110511.64612-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531110511.64612-1-aspsk@isovalent.com>
References: <20230531110511.64612-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a new map ops named map_pressure to return map's "raw pressure". This value
is to be defined per map type, but in most cases this would be just the number
of elements currently present in the map: the more it grows, the more the
pressure is. (For array-based maps it seems right to set it to 0, i.e.,
"there's no pressure".)

By analogy with the 'max_entries' field the pressure value is a u32 integer.
The primary API to read it from userspace is via the map proc entry, where it
is reported in the "raw_pressure" filed, e.g., for an example map we have

    # echo -e `strace -e bpf,openat,read -s 1024 bpftool map show id 202 2>&1 | grep -A1 '/proc/self/fdinfo' | head -2 | tail -1 | cut -f2 -d' '`
    "pos:   0
    flags:  02000002
    mnt_id: 15
    ino:    18958
    map_type:       1
    key_size:       8
    value_size:     8
    max_entries:    1224
    map_flags:      0x1
    map_extra:      0x0
    memlock:        69632
    raw_pressure:   500
    map_id: 202
    frozen: 0
    ",

For old kernels and when the ->map_pressure map operation is not defined the
'raw_pressure' field is absent from the list.

The second way to get the raw_pressure is via BPF_OBJ_GET_INFO_BY_FD, where a
previously unused field in the struct bpf_map_info is now used to return this
value.

The patch adds relatively small amount of logic due to the fact that for most
maps the number of elements was already computed to provide the map memory
usage API, just not exported.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/linux/bpf.h            |   1 +
 include/uapi/linux/bpf.h       |   2 +-
 kernel/bpf/hashtab.c           | 118 ++++++++++++++++++++-------------
 kernel/bpf/lpm_trie.c          |   8 +++
 kernel/bpf/syscall.c           |  15 +++++
 tools/include/uapi/linux/bpf.h |   2 +-
 6 files changed, 99 insertions(+), 47 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830ada..4d33fc6ed2ea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -162,6 +162,7 @@ struct bpf_map_ops {
 				     void *callback_ctx, u64 flags);
 
 	u64 (*map_mem_usage)(const struct bpf_map *map);
+	u32 (*map_pressure)(const struct bpf_map *map);
 
 	/* BTF id of struct allocated by map_alloc */
 	int *map_btf_id;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9273c654743c..99580f2d006b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6363,7 +6363,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
-	__u32 :32;	/* alignment pad */
+	__u32 raw_pressure;
 	__u64 map_extra;
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9901efee4339..331a923e29d5 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -133,6 +133,63 @@ static inline bool htab_is_prealloc(const struct bpf_htab *htab)
 	return !(htab->map.map_flags & BPF_F_NO_PREALLOC);
 }
 
+/* compute_batch_value() computes batch value as num_online_cpus() * 2
+ * and __percpu_counter_compare() needs
+ * htab->max_entries - cur_number_of_elems to be more than batch * num_online_cpus()
+ * for percpu_counter to be faster than atomic_t. In practice the average bpf
+ * hash map size is 10k, which means that a system with 64 cpus will fill
+ * hashmap to 20% of 10k before percpu_counter becomes ineffective. Therefore
+ * define our own batch count as 32 then 10k hash map can be filled up to 80%:
+ * 10k - 8k > 32 _batch_ * 64 _cpus_
+ * and __percpu_counter_compare() will still be fast. At that point hash map
+ * collisions will dominate its performance anyway. Assume that hash map filled
+ * to 50+% isn't going to be O(1) and use the following formula to choose
+ * between percpu_counter and atomic_t.
+ *
+ * For preallocated maps we only increase/decrease counters on adding/removing
+ * an element to be later fetched by htab_map_pressure, so we always enable the
+ * per-cpu version in favor of atomic
+ */
+#define PERCPU_COUNTER_BATCH 32
+static bool htab_use_percpu_counter(union bpf_attr *attr)
+{
+	return (attr->max_entries / 2 > num_online_cpus() * PERCPU_COUNTER_BATCH ||
+		!(attr->map_flags & BPF_F_NO_PREALLOC));
+}
+
+static bool is_map_full(struct bpf_htab *htab)
+{
+	if (htab->use_percpu_counter)
+		return __percpu_counter_compare(&htab->pcount, htab->map.max_entries,
+						PERCPU_COUNTER_BATCH) >= 0;
+	return atomic_read(&htab->count) >= htab->map.max_entries;
+}
+
+static void inc_elem_count(struct bpf_htab *htab)
+{
+	if (htab->use_percpu_counter)
+		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
+	else
+		atomic_inc(&htab->count);
+}
+
+static void dec_elem_count(struct bpf_htab *htab)
+{
+	if (htab->use_percpu_counter)
+		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
+	else
+		atomic_dec(&htab->count);
+}
+
+static u32 htab_map_pressure(const struct bpf_map *map)
+{
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+
+	if (htab->use_percpu_counter)
+		return __percpu_counter_sum(&htab->pcount);
+	return atomic_read(&htab->count);
+}
+
 static void htab_init_buckets(struct bpf_htab *htab)
 {
 	unsigned int i;
@@ -539,23 +596,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	htab_init_buckets(htab);
 
-/* compute_batch_value() computes batch value as num_online_cpus() * 2
- * and __percpu_counter_compare() needs
- * htab->max_entries - cur_number_of_elems to be more than batch * num_online_cpus()
- * for percpu_counter to be faster than atomic_t. In practice the average bpf
- * hash map size is 10k, which means that a system with 64 cpus will fill
- * hashmap to 20% of 10k before percpu_counter becomes ineffective. Therefore
- * define our own batch count as 32 then 10k hash map can be filled up to 80%:
- * 10k - 8k > 32 _batch_ * 64 _cpus_
- * and __percpu_counter_compare() will still be fast. At that point hash map
- * collisions will dominate its performance anyway. Assume that hash map filled
- * to 50+% isn't going to be O(1) and use the following formula to choose
- * between percpu_counter and atomic_t.
- */
-#define PERCPU_COUNTER_BATCH 32
-	if (attr->max_entries / 2 > num_online_cpus() * PERCPU_COUNTER_BATCH)
-		htab->use_percpu_counter = true;
-
+	htab->use_percpu_counter = htab_use_percpu_counter(attr);
 	if (htab->use_percpu_counter) {
 		err = percpu_counter_init(&htab->pcount, 0, GFP_KERNEL);
 		if (err)
@@ -810,6 +851,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 		if (l == tgt_l) {
 			hlist_nulls_del_rcu(&l->hash_node);
 			check_and_free_fields(htab, l);
+			dec_elem_count(htab);
 			break;
 		}
 
@@ -896,40 +938,16 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
 	}
 }
 
-static bool is_map_full(struct bpf_htab *htab)
-{
-	if (htab->use_percpu_counter)
-		return __percpu_counter_compare(&htab->pcount, htab->map.max_entries,
-						PERCPU_COUNTER_BATCH) >= 0;
-	return atomic_read(&htab->count) >= htab->map.max_entries;
-}
-
-static void inc_elem_count(struct bpf_htab *htab)
-{
-	if (htab->use_percpu_counter)
-		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
-	else
-		atomic_inc(&htab->count);
-}
-
-static void dec_elem_count(struct bpf_htab *htab)
-{
-	if (htab->use_percpu_counter)
-		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
-	else
-		atomic_dec(&htab->count);
-}
-
-
 static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 {
 	htab_put_fd_value(htab, l);
 
+	dec_elem_count(htab);
+
 	if (htab_is_prealloc(htab)) {
 		check_and_free_fields(htab, l);
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
-		dec_elem_count(htab);
 		htab_elem_free(htab, l);
 	}
 }
@@ -1006,6 +1024,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			if (!l)
 				return ERR_PTR(-E2BIG);
 			l_new = container_of(l, struct htab_elem, fnode);
+			inc_elem_count(htab);
 		}
 	} else {
 		if (is_map_full(htab))
@@ -1227,9 +1246,11 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	 * concurrent search will find it before old elem
 	 */
 	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+	inc_elem_count(htab);
 	if (l_old) {
 		bpf_lru_node_set_ref(&l_new->lru_node);
 		hlist_nulls_del_rcu(&l_old->hash_node);
+		dec_elem_count(htab);
 	}
 	ret = 0;
 
@@ -1357,6 +1378,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 		pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
 				value, onallcpus);
 		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+		inc_elem_count(htab);
 		l_new = NULL;
 	}
 	ret = 0;
@@ -1443,9 +1465,10 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 
 	l = lookup_elem_raw(head, hash, key, key_size);
 
-	if (l)
+	if (l) {
+		dec_elem_count(htab);
 		hlist_nulls_del_rcu(&l->hash_node);
-	else
+	} else
 		ret = -ENOENT;
 
 	htab_unlock_bucket(htab, b, hash, flags);
@@ -2249,6 +2272,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
 	.map_mem_usage = htab_map_mem_usage,
+	.map_pressure = htab_map_pressure,
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2271,6 +2295,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
 	.map_mem_usage = htab_map_mem_usage,
+	.map_pressure = htab_map_pressure,
 	BATCH_OPS(htab_lru),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2423,6 +2448,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
 	.map_mem_usage = htab_map_mem_usage,
+	.map_pressure = htab_map_pressure,
 	BATCH_OPS(htab_percpu),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2443,6 +2469,7 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
 	.map_mem_usage = htab_map_mem_usage,
+	.map_pressure = htab_map_pressure,
 	BATCH_OPS(htab_lru_percpu),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2581,6 +2608,7 @@ const struct bpf_map_ops htab_of_maps_map_ops = {
 	.map_gen_lookup = htab_of_map_gen_lookup,
 	.map_check_btf = map_check_no_btf,
 	.map_mem_usage = htab_map_mem_usage,
+	.map_pressure = htab_map_pressure,
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
 };
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index e0d3ddf2037a..24ff5feb07ca 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -730,6 +730,13 @@ static u64 trie_mem_usage(const struct bpf_map *map)
 	return elem_size * READ_ONCE(trie->n_entries);
 }
 
+static u32 trie_map_pressure(const struct bpf_map *map)
+{
+	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
+
+	return READ_ONCE(trie->n_entries);
+}
+
 BTF_ID_LIST_SINGLE(trie_map_btf_ids, struct, lpm_trie)
 const struct bpf_map_ops trie_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -744,5 +751,6 @@ const struct bpf_map_ops trie_map_ops = {
 	.map_delete_batch = generic_map_delete_batch,
 	.map_check_btf = trie_check_btf,
 	.map_mem_usage = trie_mem_usage,
+	.map_pressure = trie_map_pressure,
 	.map_btf_id = &trie_map_btf_ids[0],
 };
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 92a57efc77de..6ea30a24f057 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -794,6 +794,13 @@ static fmode_t map_get_sys_perms(struct bpf_map *map, struct fd f)
 	return mode;
 }
 
+static u32 bpf_map_pressure(const struct bpf_map *map)
+{
+	if (map->ops->map_pressure)
+		return map->ops->map_pressure(map);
+	return 0;
+}
+
 #ifdef CONFIG_PROC_FS
 /* Show the memory usage of a bpf map */
 static u64 bpf_map_memory_usage(const struct bpf_map *map)
@@ -804,6 +811,7 @@ static u64 bpf_map_memory_usage(const struct bpf_map *map)
 static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 {
 	struct bpf_map *map = filp->private_data;
+	char map_pressure_buf[36] = "";
 	u32 type = 0, jited = 0;
 
 	if (map_type_contains_progs(map)) {
@@ -813,6 +821,10 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 		spin_unlock(&map->owner.lock);
 	}
 
+	if (map->ops->map_pressure)
+		snprintf(map_pressure_buf, sizeof(map_pressure_buf),
+			 "raw_pressure:\t%u\n", map->ops->map_pressure(map));
+
 	seq_printf(m,
 		   "map_type:\t%u\n"
 		   "key_size:\t%u\n"
@@ -821,6 +833,7 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 		   "map_flags:\t%#x\n"
 		   "map_extra:\t%#llx\n"
 		   "memlock:\t%llu\n"
+		   "%s"
 		   "map_id:\t%u\n"
 		   "frozen:\t%u\n",
 		   map->map_type,
@@ -830,6 +843,7 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 		   map->map_flags,
 		   (unsigned long long)map->map_extra,
 		   bpf_map_memory_usage(map),
+		   map_pressure_buf,
 		   map->id,
 		   READ_ONCE(map->frozen));
 	if (type) {
@@ -4275,6 +4289,7 @@ static int bpf_map_get_info_by_fd(struct file *file,
 	info.value_size = map->value_size;
 	info.max_entries = map->max_entries;
 	info.map_flags = map->map_flags;
+	info.raw_pressure = bpf_map_pressure(map);
 	info.map_extra = map->map_extra;
 	memcpy(info.name, map->name, sizeof(map->name));
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 9273c654743c..99580f2d006b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6363,7 +6363,7 @@ struct bpf_map_info {
 	__u32 btf_id;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
-	__u32 :32;	/* alignment pad */
+	__u32 raw_pressure;
 	__u64 map_extra;
 } __attribute__((aligned(8)));
 
-- 
2.34.1


