Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8A95A9CDB
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 18:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiIAQQU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 12:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiIAQQR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 12:16:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F124543306
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 09:16:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x19so16057340pfr.1
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YkiR1pR4pf3gc+NcW9hCzitUfw6uraWiWMrmU6Iy0/0=;
        b=f+Ls2E4aBNf/YW+LcGaS0QlAtFoaKAWpaaXhx4XMeviqrs4Tb1K1XFoYST49thzMTt
         oqpDgefScu/wrQmgC/tLTjHc8z/f6/W8I3INxxAGbNd7ZC+w7ZFNOV5FgU38G3SjbxUU
         6an5XqCzvGOoObl6JN84/nVU5AKgl8Zr0PwLhf/51KlDCr3sGKUZGkoNMWtWfQ16gb/b
         NHIsmwxvti0daoX3TNQzjaMeY7/RuaUxtZqGqLIhA2efJMhWCl9A17zpXvKC/i4MoDGY
         XkGSDPqtlhYUdJUrTwH85QX8x6kYmdRPJK19dBhX4PQKR5YGHbOpgLu6wpSn0qxLfWEl
         7Ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YkiR1pR4pf3gc+NcW9hCzitUfw6uraWiWMrmU6Iy0/0=;
        b=bSgAq7DKkMgGvR9qgo/KOVyJ0eC79uA7BMReA1YKQZHZ0n9kMPBPSq7Ww0DtsgRV+V
         JqsPq+sbk5QOTCCY6DGdXyWe+ecwGz7BoRKpj2BrZAhTKx4/T5nLnyaRArKAL3ZLg+4J
         NdX2vRZDVtbzkDcCDTb57nmFqAeAqelcNkTldpHXAwP3/dIQZr8VXuSYc3WFbPw8Gx5Z
         nhma+x7mMIFOwOXDQJWEMgk5MeahuijlzuoDp8hgytC1Qm8TF2SLW3KVXrKfphUH6u/N
         iv/6ZjrmF4Y4oWu0lYtSmkGz4OqD7qzJsnG92/CQNwCZ7VUzLS/00yBCAhMD8MrvL3x1
         ravQ==
X-Gm-Message-State: ACgBeo2iSupqD+GWDvDWURouddbrful9agVaC97J5rVJj1FpE5OW82sv
        507DU9sapvZSoA8OG48+cow=
X-Google-Smtp-Source: AA6agR764NUVqidKnV118YCUV/yNTZGH/FV1amZWfmu8tOL2fxhKLlLNH0gTMCH46VsATqBjGBtJ/w==
X-Received: by 2002:a63:3d01:0:b0:42b:d5c7:57bc with SMTP id k1-20020a633d01000000b0042bd5c757bcmr19899282pga.3.1662048974110;
        Thu, 01 Sep 2022 09:16:14 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::3:4dc5])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b00172a1e9dad9sm13887968plb.275.2022.09.01.09.16.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 09:16:13 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 06/15] bpf: Optimize element count in non-preallocated hash map.
Date:   Thu,  1 Sep 2022 09:15:38 -0700
Message-Id: <20220901161547.57722-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
References: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The atomic_inc/dec might cause extreme cache line bouncing when multiple cpus
access the same bpf map. Based on specified max_entries for the hash map
calculate when percpu_counter becomes faster than atomic_t and use it for such
maps. For example samples/bpf/map_perf_test is using hash map with max_entries
1000. On a system with 16 cpus the 'map_perf_test 4' shows 14k events per
second using atomic_t. On a system with 15 cpus it shows 100k events per second
using percpu. map_perf_test is an extreme case where all cpus colliding on
atomic_t which causes extreme cache bouncing. Note that the slow path of
percpu_counter is 5k events per secound vs 14k for atomic, so the heuristic is
necessary. See comment in the code why the heuristic is based on
num_online_cpus().

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c | 70 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 508e64351f87..36aa16dc43ad 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -101,7 +101,12 @@ struct bpf_htab {
 		struct bpf_lru lru;
 	};
 	struct htab_elem *__percpu *extra_elems;
-	atomic_t count;	/* number of elements in this hashtable */
+	/* number of elements in non-preallocated hashtable are kept
+	 * in either pcount or count
+	 */
+	struct percpu_counter pcount;
+	atomic_t count;
+	bool use_percpu_counter;
 	u32 n_buckets;	/* number of hash buckets */
 	u32 elem_size;	/* size of each element in bytes */
 	u32 hashrnd;
@@ -565,6 +570,29 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	htab_init_buckets(htab);
 
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
+ */
+#define PERCPU_COUNTER_BATCH 32
+	if (attr->max_entries / 2 > num_online_cpus() * PERCPU_COUNTER_BATCH)
+		htab->use_percpu_counter = true;
+
+	if (htab->use_percpu_counter) {
+		err = percpu_counter_init(&htab->pcount, 0, GFP_KERNEL);
+		if (err)
+			goto free_map_locked;
+	}
+
 	if (prealloc) {
 		err = prealloc_init(htab);
 		if (err)
@@ -891,6 +919,31 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
 	}
 }
 
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
+
 static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 {
 	htab_put_fd_value(htab, l);
@@ -899,7 +952,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 		check_and_free_fields(htab, l);
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
-		atomic_dec(&htab->count);
+		dec_elem_count(htab);
 		l->htab = htab;
 		call_rcu(&l->rcu, htab_elem_free_rcu);
 	}
@@ -983,16 +1036,15 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			l_new = container_of(l, struct htab_elem, fnode);
 		}
 	} else {
-		if (atomic_inc_return(&htab->count) > htab->map.max_entries)
-			if (!old_elem) {
+		if (is_map_full(htab))
+			if (!old_elem)
 				/* when map is full and update() is replacing
 				 * old element, it's ok to allocate, since
 				 * old element will be freed immediately.
 				 * Otherwise return an error
 				 */
-				l_new = ERR_PTR(-E2BIG);
-				goto dec_count;
-			}
+				return ERR_PTR(-E2BIG);
+		inc_elem_count(htab);
 		l_new = bpf_mem_cache_alloc(&htab->ma);
 		if (!l_new) {
 			l_new = ERR_PTR(-ENOMEM);
@@ -1034,7 +1086,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 	l_new->hash = hash;
 	return l_new;
 dec_count:
-	atomic_dec(&htab->count);
+	dec_elem_count(htab);
 	return l_new;
 }
 
@@ -1513,6 +1565,8 @@ static void htab_map_free(struct bpf_map *map)
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->ma);
+	if (htab->use_percpu_counter)
+		percpu_counter_destroy(&htab->pcount);
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
 		free_percpu(htab->map_locked[i]);
 	lockdep_unregister_key(&htab->lockdep_key);
-- 
2.30.2

