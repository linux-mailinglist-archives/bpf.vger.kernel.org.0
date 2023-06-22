Return-Path: <bpf+bounces-3130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69797739DC3
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 11:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4041C210A7
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB9B15ACD;
	Thu, 22 Jun 2023 09:52:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21455689
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 09:52:40 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0FAE57
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 02:52:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-987accb4349so842002666b.0
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687427557; x=1690019557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVQa5WOs7mJWnqHaHkY9ND5deT3RSOw+ABvXr+yhfJU=;
        b=Gs3GG6SFR6QVYAelvHG8slhck3BNt7WRJq2KYpo1FCl7U7dNXBlyNvBUr+gFPMhVwC
         q1YB0q6MBxiNPFQ01Z0q6apD4G4J3bCjuDgJBkr5YG/EPmmGy23Jm/7TiBqt5S9Opbxt
         KsFjY3E1/ww3AmymYzWrvUKCgswY3rovVct91/bZ2VngLeQdkQlK3oq9yKfAyFf3bNgI
         RjXemVygrR/wuFdQOV70O0Hro+4dKSGG6Gdh3aytvsVLrnwskcYU1Gqn3TFAJPzJ049G
         HtSt9uw+TWkcIv67ebfc5iCsv0YhrEncBocuEgMn29km931sYNmyS7xNkCxVYdwAUdh/
         EqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687427557; x=1690019557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVQa5WOs7mJWnqHaHkY9ND5deT3RSOw+ABvXr+yhfJU=;
        b=DEm7mJWU8iLG/b1TI6b7UtNnAGIMZ2sGLaPMBI965qeuuRtWjFBJXf+DT7P6ziyoJQ
         kgRbnQnXMrIlvZdxJJiKdJMF6Y1wry2+Ck0m1d4b1iXVevyOQoJhtlZF0vbezitjtVjw
         UXXzHsIyRWr7k9+tHDaUE/RhHqrA23K9ffm60Y8QT+EDfTqRlFj5Hrqv7T52TBkaTQqs
         V+TgTp4hJWSOJjzZxVph40XOG6xE+CQ7iAZ+qD1G/QQlq4FAHJ495MXF0I5q1MjPpDg2
         Xj0QvE/XP+ZQq9C6fUji5g3DhqvL8HZ9PYQ/+nh+2irC2xQVgEsTU711asUmCZfv6eGX
         ng+w==
X-Gm-Message-State: AC+VfDw51fb4Sw22qLA7pWV6xuoND0Ux4X2mRe47UBRWCtzeUmT00byd
	Q2mOa7GLr3Q7QaxxhFm2d2zHig==
X-Google-Smtp-Source: ACHHUZ5o0k4XCi3lv+l8k4dofuwdLTLqfIPrM6bFMf8fR8lKxj6GjIBUXnOvA2hXcxhHiwd05VAp9Q==
X-Received: by 2002:a17:907:7e8b:b0:988:fafd:d93a with SMTP id qb11-20020a1709077e8b00b00988fafdd93amr8584553ejc.70.1687427557405;
        Thu, 22 Jun 2023 02:52:37 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090614cc00b0098951bb4dc3sm3387985ejc.184.2023.06.22.02.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:52:37 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [RFC v2 PATCH bpf-next 2/4] bpf: populate the per-cpu insertions/deletions counters for hashmaps
Date: Thu, 22 Jun 2023 09:53:28 +0000
Message-Id: <20230622095330.1023453-3-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622095330.1023453-1-aspsk@isovalent.com>
References: <20230622095330.1023453-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Initialize and utilize the per-cpu insertions/deletions counters for hash-based
maps. The non-trivial changes only apply to the preallocated maps for which the
inc_elem_count/dec_elem_count functions were not called before.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/hashtab.c | 102 +++++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 42 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9901efee4339..0b4a2d61afa9 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -217,6 +217,49 @@ static bool htab_has_extra_elems(struct bpf_htab *htab)
 	return !htab_is_percpu(htab) && !htab_is_lru(htab);
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
+ */
+#define PERCPU_COUNTER_BATCH 32
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
+	bpf_map_inc_elements_counter(&htab->map);
+
+	if (htab->use_percpu_counter)
+		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
+	else
+		atomic_inc(&htab->count);
+}
+
+static void dec_elem_count(struct bpf_htab *htab)
+{
+	bpf_map_dec_elements_counter(&htab->map);
+
+	if (htab->use_percpu_counter)
+		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
+	else
+		atomic_dec(&htab->count);
+}
+
 static void htab_free_prealloced_timers(struct bpf_htab *htab)
 {
 	u32 num_entries = htab->map.max_entries;
@@ -539,20 +582,6 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
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
 	if (attr->max_entries / 2 > num_online_cpus() * PERCPU_COUNTER_BATCH)
 		htab->use_percpu_counter = true;
 
@@ -587,8 +616,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 		}
 	}
 
+	err = bpf_map_init_elements_counter(&htab->map);
+	if (err)
+		goto free_extra_elements;
+
 	return &htab->map;
 
+free_extra_elements:
+	free_percpu(htab->extra_elems);
 free_prealloc:
 	prealloc_destroy(htab);
 free_map_locked:
@@ -810,6 +845,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 		if (l == tgt_l) {
 			hlist_nulls_del_rcu(&l->hash_node);
 			check_and_free_fields(htab, l);
+			dec_elem_count(htab);
 			break;
 		}
 
@@ -896,40 +932,16 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
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
@@ -1006,6 +1018,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			if (!l)
 				return ERR_PTR(-E2BIG);
 			l_new = container_of(l, struct htab_elem, fnode);
+			inc_elem_count(htab);
 		}
 	} else {
 		if (is_map_full(htab))
@@ -1227,9 +1240,11 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
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
 
@@ -1357,6 +1372,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 		pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
 				value, onallcpus);
 		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+		inc_elem_count(htab);
 		l_new = NULL;
 	}
 	ret = 0;
@@ -1443,9 +1459,10 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 
 	l = lookup_elem_raw(head, hash, key, key_size);
 
-	if (l)
+	if (l) {
+		dec_elem_count(htab);
 		hlist_nulls_del_rcu(&l->hash_node);
-	else
+	} else
 		ret = -ENOENT;
 
 	htab_unlock_bucket(htab, b, hash, flags);
@@ -1529,6 +1546,7 @@ static void htab_map_free(struct bpf_map *map)
 		prealloc_destroy(htab);
 	}
 
+	bpf_map_free_elements_counter(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
-- 
2.34.1


