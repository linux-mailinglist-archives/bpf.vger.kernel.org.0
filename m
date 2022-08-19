Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D6259A7F3
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 23:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiHSVnU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 17:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbiHSVnS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 17:43:18 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E672DCE
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w138so2772156pfc.10
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=W43Nyf7DOecFDBnlT5N/MtBJxTqydKGvqtvjlb9SmvI=;
        b=Xt7Q5IfeDwF0iF0l5X2gYqx3a7MU/52LJ3FXuy8D7md2G+9wc401eu9P9mNfbcHcfH
         eEkai+QrPtyJfFlD7J+9cZrc1b16Bgyxm4TMp4f+kEzGLmQJD3jKMGGhYXEA+LbwVUD1
         2JltVfG0aXMWUHJGyu9Rxsl60crrTrEhjZ+watrDfzxBoPVamMIO56jvuuhuNqNfQFeR
         kOh+cVRmQQG8h32yrtUUGah3S9UU0UWwhwpCNn7XpGzRBJ9ynDdO+vdSGkRQPORGeKp2
         YZeHw4PZ0WJnxfAGXNvuO67mVWBqNCGsB7n5SxI2QdI6TlX2BQvEwWQGo0V1LKZgjgg5
         4Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=W43Nyf7DOecFDBnlT5N/MtBJxTqydKGvqtvjlb9SmvI=;
        b=0x5KubsxYwyxtaZ6GcrWtavEAB9vAMvGiIRfnTCnMGOc0i+G8K15JOhBE8LfSXeNm8
         /CHaBFT1Ao2VmSWSg2021b9cVodV2l9hSld2syoP3F2SMYjvog7ChzA9h1pd1l2u0Mrt
         27fJL4AlBi2AzuQGnIro9MG7Xq3WnMw4f6eiZBRPAVwMui7KI3S27Tazrt3p8DnNKHR7
         jvxVKvG16LFP0GkH/bjpdN4fcKshtEk4qzENVEdH6KF6zbknagFySCzR471BPduQWT8A
         TWs3pJGuU95D0tX5avITVZ34v6JVOshJ4UKqH5r4oiPScsSFmYD1B1bmbuQZOQSk/s3z
         BYfQ==
X-Gm-Message-State: ACgBeo3pUITCBxmrXrLAYmFj2v3aaa5fwgCg4tdxU3tEjzasC4Vwx4J6
        U2JuOzwydyMpwTREi5K5oeI=
X-Google-Smtp-Source: AA6agR7I1Wxd+o9NTQ/+nSz8ZI/dZ7eFMEtjoRW2LrBgT9NV57WIdWDB6Ouz5GrJ2m+cY0OdANJT/w==
X-Received: by 2002:a65:6216:0:b0:41d:8248:3d05 with SMTP id d22-20020a656216000000b0041d82483d05mr8149260pgv.36.1660945395427;
        Fri, 19 Aug 2022 14:43:15 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b0016dd6929af5sm3618454pln.206.2022.08.19.14.43.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 14:43:14 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 11/15] bpf: Convert percpu hash map to per-cpu bpf_mem_alloc.
Date:   Fri, 19 Aug 2022 14:42:28 -0700
Message-Id: <20220819214232.18784-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
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

Convert dynamic allocations in percpu hash map from alloc_percpu() to
bpf_mem_cache_alloc() from per-cpu bpf_mem_alloc. Since bpf_mem_alloc frees
objects after RCU gp the call_rcu() is removed. pcpu_init_value() now needs to
zero-fill per-cpu allocations, since dynamically allocated map elements are now
similar to full prealloc, since alloc_percpu() is not called inline and the
elements are reused in the freelist.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c | 45 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 8daa1132d43c..89f26cbddef5 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -94,6 +94,7 @@ struct bucket {
 struct bpf_htab {
 	struct bpf_map map;
 	struct bpf_mem_alloc ma;
+	struct bpf_mem_alloc pcpu_ma;
 	struct bucket *buckets;
 	void *elems;
 	union {
@@ -121,14 +122,14 @@ struct htab_elem {
 		struct {
 			void *padding;
 			union {
-				struct bpf_htab *htab;
 				struct pcpu_freelist_node fnode;
 				struct htab_elem *batch_flink;
 			};
 		};
 	};
 	union {
-		struct rcu_head rcu;
+		/* pointer to per-cpu pointer */
+		void *ptr_to_pptr;
 		struct bpf_lru_node lru_node;
 	};
 	u32 hash;
@@ -435,8 +436,6 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	bool zero_seed = (attr->map_flags & BPF_F_ZERO_SEED);
 	int numa_node = bpf_map_attr_numa_node(attr);
 
-	BUILD_BUG_ON(offsetof(struct htab_elem, htab) !=
-		     offsetof(struct htab_elem, hash_node.pprev));
 	BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=
 		     offsetof(struct htab_elem, hash_node.pprev));
 
@@ -597,6 +596,12 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false);
 		if (err)
 			goto free_map_locked;
+		if (percpu) {
+			err = bpf_mem_alloc_init(&htab->pcpu_ma,
+						 round_up(htab->map.value_size, 8), true);
+			if (err)
+				goto free_map_locked;
+		}
 	}
 
 	return &htab->map;
@@ -607,6 +612,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
 		free_percpu(htab->map_locked[i]);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
 free_htab:
 	lockdep_unregister_key(&htab->lockdep_key);
@@ -882,19 +888,11 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 {
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
-		free_percpu(htab_elem_get_ptr(l, htab->map.key_size));
+		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
 	check_and_free_fields(htab, l);
 	bpf_mem_cache_free(&htab->ma, l);
 }
 
-static void htab_elem_free_rcu(struct rcu_head *head)
-{
-	struct htab_elem *l = container_of(head, struct htab_elem, rcu);
-	struct bpf_htab *htab = l->htab;
-
-	htab_elem_free(htab, l);
-}
-
 static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
 {
 	struct bpf_map *map = &htab->map;
@@ -940,12 +938,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
 		dec_elem_count(htab);
-		if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH) {
-			l->htab = htab;
-			call_rcu(&l->rcu, htab_elem_free_rcu);
-		} else {
-			htab_elem_free(htab, l);
-		}
+		htab_elem_free(htab, l);
 	}
 }
 
@@ -970,13 +963,12 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 			    void *value, bool onallcpus)
 {
-	/* When using prealloc and not setting the initial value on all cpus,
-	 * zero-fill element values for other cpus (just as what happens when
-	 * not using prealloc). Otherwise, bpf program has no way to ensure
+	/* When not setting the initial value on all cpus, zero-fill element
+	 * values for other cpus. Otherwise, bpf program has no way to ensure
 	 * known initial values for cpus other than current one
 	 * (onallcpus=false always when coming from bpf prog).
 	 */
-	if (htab_is_prealloc(htab) && !onallcpus) {
+	if (!onallcpus) {
 		u32 size = round_up(htab->map.value_size, 8);
 		int current_cpu = raw_smp_processor_id();
 		int cpu;
@@ -1047,18 +1039,18 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 
 	memcpy(l_new->key, key, key_size);
 	if (percpu) {
-		size = round_up(size, 8);
 		if (prealloc) {
 			pptr = htab_elem_get_ptr(l_new, key_size);
 		} else {
 			/* alloc_percpu zero-fills */
-			pptr = bpf_map_alloc_percpu(&htab->map, size, 8,
-						    GFP_NOWAIT | __GFP_NOWARN);
+			pptr = bpf_mem_cache_alloc(&htab->pcpu_ma);
 			if (!pptr) {
 				bpf_mem_cache_free(&htab->ma, l_new);
 				l_new = ERR_PTR(-ENOMEM);
 				goto dec_count;
 			}
+			l_new->ptr_to_pptr = pptr;
+			pptr = *(void **)pptr;
 		}
 
 		pcpu_init_value(htab, pptr, value, onallcpus);
@@ -1550,6 +1542,7 @@ static void htab_map_free(struct bpf_map *map)
 	bpf_map_free_kptr_off_tab(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
 	if (htab->use_percpu_counter)
 		percpu_counter_destroy(&htab->pcount);
-- 
2.30.2

