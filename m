Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA6259788D
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242269AbiHQVEz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242284AbiHQVEq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:04:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B13AAB41F
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r69so12972975pgr.2
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1DZ3i2bbkc3eTrJ/YvjarNAdlh/YgPZTxrhVDFxf0vQ=;
        b=O2oXhew5JiBi3bP9J6m/k7tE2dafEvAM/6B5hr+5iROIDquBiUTfxxeajve9s5fWqG
         wj8zhx1RmWLM+I96Lh+vrK8vurZa4TTqxZMt9EYbNqIHkmT74gLXfhDb6R8FGZz37fNL
         ImkQGrK9EQ+ETzgk7gEQRsOF5ya8U3/DZtlRf7R50awNPoGsSSh1qpympx3DNlR7fQzT
         NX0bA+e3YJqiBWvqCICAMDJsIUr7MQ5SNDu4Fk4PPYstEql3nAU2OOVfLmJN5ZKoN1L1
         mOvePRVcU58g4mO9CRIjP/9H3JYTEc13VKgwwnVSEvnzPnD09B3wBWmLm823PavK0skX
         21DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1DZ3i2bbkc3eTrJ/YvjarNAdlh/YgPZTxrhVDFxf0vQ=;
        b=GVSrOqrVNj6lLVHft6idXcNxwZi+RpK8MvQuIQHdE/IYxz5QmrZhDEgo70Iom7Z9Ky
         7VEpnTJipX63TXMf+cLjr9Gl0rHwNt01kBbLERYVueJlCEveTUmgMATISgPEjp5IY8ZG
         56Y5vVgEtwbiJAvLZCdwEFCeDV7C2kAWO3697/iSDpPE1t+vyQ10cF7vKNRyrCR7NB5v
         846SMgG/H41W10oyFUaG50FdyLRGk48Uu5TDxLFBI+sPWwiQEAwFKPblgQowk2D6W9xL
         aBheK2SIxtI8A+WH6xtGvW0nUJtKSpI6pe0+LExwP1BpN15/BeAIKq5EvJrBZq4jBYl3
         mGTA==
X-Gm-Message-State: ACgBeo3TFeU2zh77AIt1SLg/WkeAWybAliPjVX38f/LBnLICMvoBS0FK
        DzBz1Oic934zlhh3bPIFdmA=
X-Google-Smtp-Source: AA6agR5ZXTfkc32b+ie7Gu+KRGH8xSXKaoIu4ajEMJHyyrfMuIggVVP0qg+DGC2trYE7cpazwq6ihw==
X-Received: by 2002:a63:e448:0:b0:429:f52a:3ad2 with SMTP id i8-20020a63e448000000b00429f52a3ad2mr74547pgk.138.1660770284799;
        Wed, 17 Aug 2022 14:04:44 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:ccd6])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902dcd400b0016cd74e5f87sm335557pll.240.2022.08.17.14.04.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Aug 2022 14:04:44 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 06/12] bpf: Optimize element count in non-preallocated hash map.
Date:   Wed, 17 Aug 2022 14:04:13 -0700
Message-Id: <20220817210419.95560-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
References: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c | 70 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 6c0db430507a..65ebe5a719f5 100644
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
@@ -556,6 +561,29 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
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
@@ -882,6 +910,31 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
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
@@ -890,7 +943,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 		check_and_free_fields(htab, l);
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
-		atomic_dec(&htab->count);
+		dec_elem_count(htab);
 		l->htab = htab;
 		call_rcu(&l->rcu, htab_elem_free_rcu);
 	}
@@ -974,16 +1027,15 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
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
@@ -1025,7 +1077,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 	l_new->hash = hash;
 	return l_new;
 dec_count:
-	atomic_dec(&htab->count);
+	dec_elem_count(htab);
 	return l_new;
 }
 
@@ -1499,6 +1551,8 @@ static void htab_map_free(struct bpf_map *map)
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

