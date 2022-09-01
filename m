Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8C45A9CD6
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 18:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiIAQQG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 12:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbiIAQQB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 12:16:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC213C8FD
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 09:15:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso2929999pjk.0
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Ga0Nwt5Zi5Wm2Kkt3SbRcQrpwa6IAGB0M+wlcmjeY9w=;
        b=nWj8xtovNxnToI65F02+lMStzi08h3Vfb8Hlqm/P/qDpJUAGiVvgLujS2txPE83BJG
         OJ6iLWh2nH7xvvIeikFp+AqEJ2N5V7k6VuJBgfVEc7lOy+zPql6nkKkVykOHqm5UZLzG
         LwTIXuaq8pz60Qg1MCK3VqgtZfekqK/hoZM6GOBlarLzGDy5o4gNAFVNfAICmONL7gd6
         OE9Bvyja+wiB/5Sftnhw54lWAKedp9r0ZCWwh9Zsx09b377Gtsz/YM0T2AeLiIAtI32W
         FU4v9JLYNl8lgTULJPOK/kt1tbmxw0Iw9oHipAn45DTzXWFwV9hHS3atkCbItGkr88J3
         VqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Ga0Nwt5Zi5Wm2Kkt3SbRcQrpwa6IAGB0M+wlcmjeY9w=;
        b=25hGszqWovF9okv4Mi5rsVvpdL/g3kMZAY1o5d5jk7wutiW9gMNIsWq3ugZmybuxah
         1j+2swLHX1hHfB2XBI2SV+4XqM+MA0iwz2+buqVmFIp1hgVwLBvs8EQm7ygCpI0VePHg
         a/xtgCkN6ZfTT9xIxPKYeQiuWXeEpV/8a+FRolXZu9Vj3N1FAkN558Yj1gbp4n2//DmP
         knqwkZT+SS4GlN20Wles0XIX9Pz+9vRHMUSziDv5AuKs5WGxzEBlSr4AqdJD8T7gCfKm
         DdApTpjbs+GdkTV5/bCf5qL3An2ewrVnBB+L/Rn8xk/EAjHE8tUUuaiBxwNkj9p5hI+f
         XrWA==
X-Gm-Message-State: ACgBeo1IdjnFYtkUnrrT+JosTzAj0YLW/EpUZ+hWSn/iz2boEMpyIVP4
        bHB++idkpQ4X4nwtTa2wj5Q=
X-Google-Smtp-Source: AA6agR47a1KSz7llECCn+O+oZVaQn5Qfp0qmyRn8bPy/B3mcLMozcBxo0iQsF9ul02mGSEd4HLiAbw==
X-Received: by 2002:a17:90a:d585:b0:1f4:f9a5:22a9 with SMTP id v5-20020a17090ad58500b001f4f9a522a9mr9490389pju.49.1662048958991;
        Thu, 01 Sep 2022 09:15:58 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::3:4dc5])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b0016a058b7547sm13972047pli.294.2022.09.01.09.15.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 09:15:58 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 02/15] bpf: Convert hash map to bpf_mem_alloc.
Date:   Thu,  1 Sep 2022 09:15:34 -0700
Message-Id: <20220901161547.57722-3-alexei.starovoitov@gmail.com>
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

