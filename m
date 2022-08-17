Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C8B5978AB
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbiHQVFG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242278AbiHQVFF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:05:05 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA9CAB4ED
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:05:03 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id f30so13070566pfq.4
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=eyosi/ApRDmJH06E2mfAg4K+Gs7C6ov+wMXDcYoXgiA=;
        b=TBY+PoFfGdsg0yomLDUoAOGXLF9qjczt9cp0q1IiM/33m0YWNLrsV+Zbulc7dEckwd
         cO8pG7g6UMuWrw/EqWsVbyrwYIEsU+fnO8RVKKCa5iAq9EESd4TGuRszWSbOWpbyu1lU
         PmfbskvdzlxfWOaMtSzXO+DybRcIg4cf/htmkFRUUHLBBcCs0ixbHqmSVMswiqOd5SwO
         SMYeNvcUmLX2TmCB2PsmQ99VrrWyVJiAZZaRvq2azixp+l9J/tZVQ72Jh3w8xXdE7GDv
         emSmbNxl72zQYAJ2RXy0A1FMAEJQBSLKvwGO6xd7rVSTYaijbis6necH/stR9FTslGqZ
         a1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eyosi/ApRDmJH06E2mfAg4K+Gs7C6ov+wMXDcYoXgiA=;
        b=WGunUkWtcdz2StEMVv86fyqG8HooNexIMYFJvXm4ikPfwTbtOfnvogwjxNvvxIdEVg
         gs9LY48qS1smKBVAWuq+ziWZinDuH7Zqoqs1ZVQXmqFaJl1EmhE6PpLLXMpmldWilsEL
         y9XIh9bUbigEfmPmAHck6lZ2B5qnqsXhP35orDUjqI2ciJv06zi9venEpj+AdQQiFwVc
         4SZuaB0rPFvmsmLxjK+2P+EpwvozSD1zi2zj8RO4gJOLOCKb18Vot7nbkLZ++hG1rxXE
         v0AT2BvmQtA2lZGnSJN/W7AzjaDjgoQEN2ZYQOcuQnuyo+//+/rHPBn0wEFsqySDyUAc
         /u+w==
X-Gm-Message-State: ACgBeo27VlCYmERyrwi9o0ETb1PqGfZ1vJPYYHZOsZg4KARdw7rH3xkv
        ycgMksquK6/MHtQ9diqf3dw=
X-Google-Smtp-Source: AA6agR6XP65/0jbYH/wPxm3Z4T7RTZCVbt+m8h5jlW0+bxnCjWSMWGeInm1BbOsq3aGVfxvPUFZaUg==
X-Received: by 2002:a65:60d4:0:b0:419:9871:9cf with SMTP id r20-20020a6560d4000000b00419987109cfmr74148pgv.214.1660770303230;
        Wed, 17 Aug 2022 14:05:03 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:ccd6])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b0016a33177d3csm348261pln.160.2022.08.17.14.05.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Aug 2022 14:05:02 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 11/12] bpf: Convert percpu hash map to per-cpu bpf_mem_alloc.
Date:   Wed, 17 Aug 2022 14:04:18 -0700
Message-Id: <20220817210419.95560-12-alexei.starovoitov@gmail.com>
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

Convert dynamic allocations in percpu hash map from alloc_percpu() to
bpf_mem_cache_alloc() from per-cpu bpf_mem_alloc. Since bpf_mem_alloc frees
objects after RCU gp the call_rcu() is removed.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bf20c45002fe..921f6fa9dc1b 100644
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
@@ -439,8 +440,6 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	bool zero_seed = (attr->map_flags & BPF_F_ZERO_SEED);
 	int numa_node = bpf_map_attr_numa_node(attr);
 
-	BUILD_BUG_ON(offsetof(struct htab_elem, htab) !=
-		     offsetof(struct htab_elem, hash_node.pprev));
 	BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=
 		     offsetof(struct htab_elem, hash_node.pprev));
 
@@ -601,6 +600,12 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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
@@ -611,6 +616,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
 		free_percpu(htab->map_locked[i]);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
 free_htab:
 	lockdep_unregister_key(&htab->lockdep_key);
@@ -886,19 +892,11 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
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
@@ -944,12 +942,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
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
 
@@ -1051,18 +1044,18 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 
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
@@ -1554,6 +1547,7 @@ static void htab_map_free(struct bpf_map *map)
 	bpf_map_free_kptr_off_tab(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
 	if (htab->use_percpu_counter)
 		percpu_counter_destroy(&htab->pcount);
-- 
2.30.2

