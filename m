Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F015A9CE4
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiIAQQj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiIAQQg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 12:16:36 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348775AA01
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 09:16:33 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r69so16834793pgr.2
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 09:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1exLg6zwiw8VbHVoGF/maqudTmvyPHhqAhRpXlF+ss0=;
        b=EQZ2xzNN/0pRofenn394iYwAnngKtYZO4PkW25lRchNBqSfY53KPDiiOeBvxvvZ2Sh
         BXUEvCBjiu+lAg197XopYD4oTFaLqlxN2KbfMtcm9MEw7/Eg6rV4HkYrEQ9GoSO0WsOd
         vTos5yTnDCE8oWBmdsFxcLg7RScP2U4/3XtIKyAiB9MeFUwkpEbg/cDA1JACSQhM5ZyT
         srhMbxha1n3ZpmbtIcA+Fj4/IZC/3k/Fe0hvO/kARSJLgzQ/1nCWuhgpGWplDoXAS8su
         wAqGbvqgvWdhXM9euXA/jQsxhCCpvlFNajxML4kHDMVMLSe7PqyEgvSFzK4dLUSOWDRj
         JocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1exLg6zwiw8VbHVoGF/maqudTmvyPHhqAhRpXlF+ss0=;
        b=fZiTdDEK6pDqTZ7wkC9yi6UQcNddy+pKifmuKLUrMgJp34MkWggA0T+uFxugd1kQFG
         9XcTXFbPD1ynAULzjAj5V+MFT7mUXnp/yQTXSUXb8sfMtnZ4o/vvOCqioILPl9uPmK5e
         bRBO7UIHDPbSS+/0G3XXT2UtYBWaE8+3KcvTfdjScktYxTByCRfJDXAcv0Ot4zN9orlY
         BR49nj3uaKkOC/42Xo04SFAepf4kmc5Y/l9GIfocPHNMduZH6XtY+8OQQPl+Ru2TMojG
         aD1znHhTLMiFyz4Qsx6MolgbgKaA1Fmg5fM4vpzLeaZcwwKZ+rjCuCGQMwoJp6v3oM7g
         jTFg==
X-Gm-Message-State: ACgBeo0O+802JGOyuBGiX0QI9Bj50S96phClhmV019WEnAOD0t2XtDvs
        eM9KeiHVSEVQiWjlPIiv05U=
X-Google-Smtp-Source: AA6agR6stlm8Bfa1pY7zMhm7F5fF+hwY+KVk2t1NXgdhaVgBQk9p7W4bd5KMa4PGlvwVGZd0nkoPjA==
X-Received: by 2002:a63:2a49:0:b0:41d:95d8:3d3d with SMTP id q70-20020a632a49000000b0041d95d83d3dmr26749135pgq.43.1662048992561;
        Thu, 01 Sep 2022 09:16:32 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::3:4dc5])
        by smtp.gmail.com with ESMTPSA id 198-20020a6216cf000000b0052b84ca900csm13611271pfw.62.2022.09.01.09.16.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 09:16:32 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 11/15] bpf: Convert percpu hash map to per-cpu bpf_mem_alloc.
Date:   Thu,  1 Sep 2022 09:15:43 -0700
Message-Id: <20220901161547.57722-12-alexei.starovoitov@gmail.com>
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

Convert dynamic allocations in percpu hash map from alloc_percpu() to
bpf_mem_cache_alloc() from per-cpu bpf_mem_alloc. Since bpf_mem_alloc frees
objects after RCU gp the call_rcu() is removed. pcpu_init_value() now needs to
zero-fill per-cpu allocations, since dynamically allocated map elements are now
similar to full prealloc, since alloc_percpu() is not called inline and the
elements are reused in the freelist.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c | 45 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 70b02ff4445e..a77b9c4a4e48 100644
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
@@ -448,8 +449,6 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	bool zero_seed = (attr->map_flags & BPF_F_ZERO_SEED);
 	int numa_node = bpf_map_attr_numa_node(attr);
 
-	BUILD_BUG_ON(offsetof(struct htab_elem, htab) !=
-		     offsetof(struct htab_elem, hash_node.pprev));
 	BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=
 		     offsetof(struct htab_elem, hash_node.pprev));
 
@@ -610,6 +609,12 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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
@@ -620,6 +625,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
 		free_percpu(htab->map_locked[i]);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
 free_htab:
 	lockdep_unregister_key(&htab->lockdep_key);
@@ -895,19 +901,11 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
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
@@ -953,12 +951,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
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
 
@@ -983,13 +976,12 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
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
@@ -1060,18 +1052,18 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 
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
@@ -1568,6 +1560,7 @@ static void htab_map_free(struct bpf_map *map)
 	bpf_map_free_kptr_off_tab(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
 	if (htab->use_percpu_counter)
 		percpu_counter_destroy(&htab->pcount);
-- 
2.30.2

