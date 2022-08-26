Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61625A1F0B
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244840AbiHZCpC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbiHZCpB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:45:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5C9201B9
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:44:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f12so276187plb.11
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=NXvXoD33j5kMIQZFtLrXok6Pap7LT2bzLuOd3NYTYe0=;
        b=PJWFMBiFT6pQvqyIB+tWhQApaReahJZJ4ywc6po9Bu4kohuSIv1m2BfDiz4j+WoA9J
         LqCiMNbbuApimsx0f808ZjUgpP8reoyvYHwspcV7TzHo2DrZZGk6JnSFSBSN3oi2U9Y8
         tvexFdO0VPPX/SrIt6gU7b1Lv6UlBy2/kAIJxMKCFJ6HgEwNoM97P9FtZyot1A341q/6
         Y1i/eUU/RTovPFAdT8b7a0YHU2SUtdoegCo6c2orAK7WQSVTBPu1h/pwd303TY3Pl8m0
         PC3GNFlkU3kQKbmnH5GuflvoBQ1PDcFDW6JCh9DLHqSr07NE2GarvH6v21dHtqDJjnEP
         gbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=NXvXoD33j5kMIQZFtLrXok6Pap7LT2bzLuOd3NYTYe0=;
        b=JUmBwcb9XCwlHzq+ZDaJpL/vyXBlnwjFwm9+AakUKabrAcK1c6UTjoywhNluc1wrcn
         ifcFDAt6XF5sdQ6emDDyRv12WAy7Ap0CQO0/RcWpTARtNnXJZEI/ajwm+v2KDiTEmU+6
         TXm0JSFmZksRkZ2sxe/ePwgYXblR4t0cvyZ0xiNSqQoAMTo+8qmgpO2Qq17u77a4NOHY
         mW0hya/eJgKJ8Q4LLhC4EwdVs/pGWcky/2Cx54Ld3H3tRRA834OMxfAmMLMnI0buLbxc
         g2YHcLSSy6SZ6zmC3r1z/rPuNhyD/qkeQHjg05Km4vMNET7lqYq2P04989uab8uEVaC5
         fWTA==
X-Gm-Message-State: ACgBeo1pOyUAmctsybFOskVgOYCPjF0Zu9hwxe2Sc/3SDD7kLxN1Jc1a
        sEjLlh7zx4wo2WYsrTJj6Zs=
X-Google-Smtp-Source: AA6agR4YUygGQAOZEKUf/gWaAL6wUDgorQIEpyBBHbO3JR/ETWFBvc39p9MAG/g0/OdE4hf5pecHfw==
X-Received: by 2002:a17:90b:1bce:b0:1fa:ecc3:9068 with SMTP id oa14-20020a17090b1bce00b001faecc39068mr2076479pjb.116.1661481897690;
        Thu, 25 Aug 2022 19:44:57 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:15dc])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902cf1100b0016d785ef6d2sm261394plg.223.2022.08.25.19.44.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 19:44:57 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 06/15] bpf: Optimize element count in non-preallocated hash map.
Date:   Thu, 25 Aug 2022 19:44:21 -0700
Message-Id: <20220826024430.84565-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
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
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c | 70 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bd23c8830d49..8f68c6e13339 100644
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
@@ -552,6 +557,29 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
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
@@ -878,6 +906,31 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
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
@@ -886,7 +939,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 		check_and_free_fields(htab, l);
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
-		atomic_dec(&htab->count);
+		dec_elem_count(htab);
 		l->htab = htab;
 		call_rcu(&l->rcu, htab_elem_free_rcu);
 	}
@@ -970,16 +1023,15 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
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
@@ -1021,7 +1073,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 	l_new->hash = hash;
 	return l_new;
 dec_count:
-	atomic_dec(&htab->count);
+	dec_elem_count(htab);
 	return l_new;
 }
 
@@ -1495,6 +1547,8 @@ static void htab_map_free(struct bpf_map *map)
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

