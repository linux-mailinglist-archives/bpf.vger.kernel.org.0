Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04B85AB9E0
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 23:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIBVLL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 17:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIBVLK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 17:11:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E55D8E32
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 14:11:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l3so2982170plb.10
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 14:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ga0Nwt5Zi5Wm2Kkt3SbRcQrpwa6IAGB0M+wlcmjeY9w=;
        b=LT2FmVcwiQsltTeEp0hTE44aqRgd79vDL/FHer/61JBuCVzyYkfJwZf0D7Yc/BnbGN
         AxxHbrL4rhdcmr0YrHsDZDGgeYLpN92GHZa5Z8Hz2VPhg4yri592fHoEIWW0HvsuX6cc
         ayFKfJZDDSnB9CHQAxXQf8Wt55+nJgowZEIMu0aaym1TyZ9rBPLiN8fAZ6kqCorFtAiH
         QRngBbH5C+RlnH+wmUmESGzMFkkXQTxx5cY6s3ssUcemkDerW/OoCoaRVmCEUCPqeUOO
         SmcuJ1gtVens6ZxWYvP2JOJcnHxa3OMGyi3OukHYiMBs+E14gJTcJsI9g8GIWTRjC5fd
         cBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ga0Nwt5Zi5Wm2Kkt3SbRcQrpwa6IAGB0M+wlcmjeY9w=;
        b=EspQmu2B+Kfom2cqrnH08dmRzMjCQ038p0p0O9eQwNCMwscwKTOgv/rC95Xdgwh2qk
         Pc+9+HhvlwjJurZOkzQEQO24uJtwFS+/c5SdLOSOLqt6SnUnmbAZj9DzlVLxsPoK5eJ7
         ln8OeYQ9TRDvPyrQoqxpxZ5+J/C4xudxdJjCmyeWDXZpzX2hNuOj4DraVHo01ImukHCr
         Uu8sA0uPN5MNgJrhobCC2QzoaSq/9ahXMop+rcSbG0ml/nR7ojP1Yasuqe/pshbxjGUG
         14TgLvXKrf4Lh2lM2Tk3yvf7PvqldaqGQRZbARnHRVu99UzTBOBdopk7HWAi50c7MNFv
         3QKA==
X-Gm-Message-State: ACgBeo2mwpe5qfcQOhkroILuEmK2jqh5E6ozFRRWhmI208GicFbU8wSy
        vFf0PBM5TJZOtC/72Xzmu/o=
X-Google-Smtp-Source: AA6agR4leFQrfvhSUXDaX2SlYFzlzN6r/IBW2pDg7LziTKf/ZUbDHT0ZBiUqih6w333ieveTbAth4g==
X-Received: by 2002:a17:902:e5c3:b0:175:534:1735 with SMTP id u3-20020a170902e5c300b0017505341735mr21332665plf.87.1662153069480;
        Fri, 02 Sep 2022 14:11:09 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::c978])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090a520800b001fda0505eaasm1945582pjh.1.2022.09.02.14.11.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Sep 2022 14:11:09 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 02/16] bpf: Convert hash map to bpf_mem_alloc.
Date:   Fri,  2 Sep 2022 14:10:44 -0700
Message-Id: <20220902211058.60789-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
References: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
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

Convert bpf hash map to use bpf memory allocator.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index eb1263f03e9b..508e64351f87 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -14,6 +14,7 @@
 #include "percpu_freelist.h"
 #include "bpf_lru_list.h"
 #include "map_in_map.h"
+#include <linux/bpf_mem_alloc.h>
 
 #define HTAB_CREATE_FLAG_MASK						\
 	(BPF_F_NO_PREALLOC | BPF_F_NO_COMMON_LRU | BPF_F_NUMA_NODE |	\
@@ -92,6 +93,7 @@ struct bucket {
 
 struct bpf_htab {
 	struct bpf_map map;
+	struct bpf_mem_alloc ma;
 	struct bucket *buckets;
 	void *elems;
 	union {
@@ -576,6 +578,10 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 			if (err)
 				goto free_prealloc;
 		}
+	} else {
+		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size);
+		if (err)
+			goto free_map_locked;
 	}
 
 	return &htab->map;
@@ -586,6 +592,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
 		free_percpu(htab->map_locked[i]);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->ma);
 free_htab:
 	lockdep_unregister_key(&htab->lockdep_key);
 	bpf_map_area_free(htab);
@@ -862,7 +869,7 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
 		free_percpu(htab_elem_get_ptr(l, htab->map.key_size));
 	check_and_free_fields(htab, l);
-	kfree(l);
+	bpf_mem_cache_free(&htab->ma, l);
 }
 
 static void htab_elem_free_rcu(struct rcu_head *head)
@@ -986,9 +993,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 				l_new = ERR_PTR(-E2BIG);
 				goto dec_count;
 			}
-		l_new = bpf_map_kmalloc_node(&htab->map, htab->elem_size,
-					     GFP_NOWAIT | __GFP_NOWARN,
-					     htab->map.numa_node);
+		l_new = bpf_mem_cache_alloc(&htab->ma);
 		if (!l_new) {
 			l_new = ERR_PTR(-ENOMEM);
 			goto dec_count;
@@ -1007,7 +1012,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			pptr = bpf_map_alloc_percpu(&htab->map, size, 8,
 						    GFP_NOWAIT | __GFP_NOWARN);
 			if (!pptr) {
-				kfree(l_new);
+				bpf_mem_cache_free(&htab->ma, l_new);
 				l_new = ERR_PTR(-ENOMEM);
 				goto dec_count;
 			}
@@ -1429,6 +1434,10 @@ static void delete_all_elements(struct bpf_htab *htab)
 {
 	int i;
 
+	/* It's called from a worker thread, so disable migration here,
+	 * since bpf_mem_cache_free() relies on that.
+	 */
+	migrate_disable();
 	for (i = 0; i < htab->n_buckets; i++) {
 		struct hlist_nulls_head *head = select_bucket(htab, i);
 		struct hlist_nulls_node *n;
@@ -1439,6 +1448,7 @@ static void delete_all_elements(struct bpf_htab *htab)
 			htab_elem_free(htab, l);
 		}
 	}
+	migrate_enable();
 }
 
 static void htab_free_malloced_timers(struct bpf_htab *htab)
@@ -1502,6 +1512,7 @@ static void htab_map_free(struct bpf_map *map)
 	bpf_map_free_kptr_off_tab(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->ma);
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
 		free_percpu(htab->map_locked[i]);
 	lockdep_unregister_key(&htab->lockdep_key);
-- 
2.30.2

