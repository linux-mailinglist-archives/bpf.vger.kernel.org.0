Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF53359788B
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbiHQVEk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242287AbiHQVEf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:04:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CBFABD66
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id jl18so5190306plb.1
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=EubkRMPFW1FZ5vCml4J7uu3XUib2x53PZwts9RYBHO8=;
        b=AAhwi0tpS4dbREsxaD/kUt5rCbyZ8yEGdUp76wDDzCpvtyVv5MYPF6RTs2SSFMmyQy
         w+H0pm9UCp9dLYVZqb3Lb3f5mucK+GbCfmbcnNPtQ90brrvmM1x/MqW8AN84Qwn4Z4ZC
         q1aHKvHw6LBUiRbNYkLeQ8AhXQ3hyjWWZ30chmXF3fbnYz+kSVsqRKzamRLsCjZtZJME
         rOD6aCHyhI2sPZTz2ajpcS7OMfmwoNJOaHCBTPplod7pedw/i5AHoSumZKffdu4ATflc
         Jo4ywTY//+WdDfcvsCfc0kiY+4JmqkMXNfeTi75wF2ZzH6btvE0zf+mV9UBZxvoEZ2Kd
         uqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EubkRMPFW1FZ5vCml4J7uu3XUib2x53PZwts9RYBHO8=;
        b=KASLbr60ebk2b796OtNkyN2BXALekwb1tNtC7W3BkBA3yMHYDjgm98si2p15ixujJC
         AGzbN3GZHLeceBgS/misrxY65sOdyI3AUZa9sTtsHtlWVUWG0NMEiykB2BmQo7OAo+9c
         9v961VCU/lCA5biprA6ZiAiYRcuaw2Cfei4fLaBOFcUDV2Vc/iOs1bF2sTcNp6S5D01X
         GK6CtSkcn4fF5MBopfSusT43sGr0nRg2ZwW38/BK6OXO1rGn3BcsEbZBOr95cKxbgCq6
         eosyZyFPOW0d+D2A5dcAqiogupj/Yl6ltVvKMlfheXbm+rN3RZmmlfLM0UwA0T/w+vGC
         icJA==
X-Gm-Message-State: ACgBeo1/Z57+fmwvFVdavkUVprnm4MY702oW2fIgQD3A0ZET5umvSHW/
        5zn9wcIxa81GVQZytAAi+AU=
X-Google-Smtp-Source: AA6agR4KFIdGL5gh6mAYPvLrDjOYiB5IktxSi6KOoCq7JQA56D/JsgK3X6oe2k+xhcAVGSxzrq0/Bg==
X-Received: by 2002:a17:90a:b703:b0:1dd:1e2f:97d7 with SMTP id l3-20020a17090ab70300b001dd1e2f97d7mr5471744pjr.62.1660770270036;
        Wed, 17 Aug 2022 14:04:30 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:ccd6])
        by smtp.gmail.com with ESMTPSA id x28-20020aa7941c000000b0052d63fb109asm10912430pfo.20.2022.08.17.14.04.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Aug 2022 14:04:29 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 02/12] bpf: Convert hash map to bpf_mem_alloc.
Date:   Wed, 17 Aug 2022 14:04:09 -0700
Message-Id: <20220817210419.95560-3-alexei.starovoitov@gmail.com>
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

Convert bpf hash map to use bpf memory allocator.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 8392f7f8a8ac..6c0db430507a 100644
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
@@ -567,6 +569,10 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 			if (err)
 				goto free_prealloc;
 		}
+	} else {
+		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size);
+		if (err)
+			goto free_map_locked;
 	}
 
 	return &htab->map;
@@ -577,6 +583,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
 		free_percpu(htab->map_locked[i]);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->ma);
 free_htab:
 	lockdep_unregister_key(&htab->lockdep_key);
 	bpf_map_area_free(htab);
@@ -853,7 +860,7 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
 		free_percpu(htab_elem_get_ptr(l, htab->map.key_size));
 	check_and_free_fields(htab, l);
-	kfree(l);
+	bpf_mem_cache_free(&htab->ma, l);
 }
 
 static void htab_elem_free_rcu(struct rcu_head *head)
@@ -977,9 +984,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
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
@@ -998,7 +1003,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			pptr = bpf_map_alloc_percpu(&htab->map, size, 8,
 						    GFP_NOWAIT | __GFP_NOWARN);
 			if (!pptr) {
-				kfree(l_new);
+				bpf_mem_cache_free(&htab->ma, l_new);
 				l_new = ERR_PTR(-ENOMEM);
 				goto dec_count;
 			}
@@ -1493,6 +1498,7 @@ static void htab_map_free(struct bpf_map *map)
 	bpf_map_free_kptr_off_tab(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->ma);
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
 		free_percpu(htab->map_locked[i]);
 	lockdep_unregister_key(&htab->lockdep_key);
-- 
2.30.2

