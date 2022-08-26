Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AD25A1F06
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244859AbiHZCoq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244745AbiHZCoo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:44:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80E8CCE34
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:44:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p185so294857pfb.13
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+2AV05bdm8xkQpoMCJUPIxLKxzKU4IZaOb+/PeeE9PY=;
        b=mApOc90L16vuczykhMzLUoCjA8f2iPH3BzfoU0N5IE+LdM22Dc0Gf3KYBlCU1rdV8A
         LyFIojC2pyWfiab+IlwL6FkedJFe2QC8LQ5EelGv2vuIUXI6Gc7WGrFn6mmIyl3WEoMr
         wE50BS5y1Y/5o57WY+RKrjyorT6tYqi42m4+02csRgbkfPa85LYhla4h2b4vFdnogwRY
         qFcuUhYAgrK79nXrrjnb1FtkxC6YMwvwuN0XIK2vVWGATqBFVzrmjLuM5xECbB3Tu1e0
         iFQK0JSMJaJoAgdGO/FdcCI/GKXlXQZTv6uP8JNQ0k3q+JBYW4oXHsxSnZnygMBzAzBZ
         XOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+2AV05bdm8xkQpoMCJUPIxLKxzKU4IZaOb+/PeeE9PY=;
        b=yqDrCqpxqb44nydkjbg0Wyh9HXhUa7Jf25oRPdlvOUnM+9StbxliooSvna51WRxyyV
         k9bhJeVT9UzfOxfzhADbNnFhWG3S++BAHh10RZj8OV8b7TS4v9kSkFMqznLy9XgVrDOA
         FFY+wIdTw79pnR2v9WqdkjbNvMb+Engjze49oVW73suYfaAiuAw7/aDMDYeTEzsY17D8
         PQO/BHMysXo2Bxv6crulChXDCNsVmLioAOxPscLBOGFPqAUFel7mjkwmxAAIKMPogZUz
         v/E1IYXzEoPB33Ex+cy8gBIbeXiO8UUxm6sPyOPCrLIlxML0cAXk7B1/pufWYi1c2TtT
         qnQw==
X-Gm-Message-State: ACgBeo2ED9MBR0ZFekTVn6zli2bXeclbAFknFuOkL83h+4mjQoNVD6yx
        q8ZQnP3pHdwAk1yfFO7dv8k=
X-Google-Smtp-Source: AA6agR50gs0JWpOYm9NYHwfXNq0iozZ2+2uX/n9WINT9+ttn6xBahC1wKowr+Ulul7NEIVpMqwyFcA==
X-Received: by 2002:a63:491f:0:b0:41d:89d5:b3e7 with SMTP id w31-20020a63491f000000b0041d89d5b3e7mr1588144pga.18.1661481882140;
        Thu, 25 Aug 2022 19:44:42 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:15dc])
        by smtp.gmail.com with ESMTPSA id 201-20020a6217d2000000b0052d50e14f1dsm365800pfx.78.2022.08.25.19.44.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 19:44:41 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 02/15] bpf: Convert hash map to bpf_mem_alloc.
Date:   Thu, 25 Aug 2022 19:44:17 -0700
Message-Id: <20220826024430.84565-3-alexei.starovoitov@gmail.com>
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

Convert bpf hash map to use bpf memory allocator.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index b301a63afa2f..bd23c8830d49 100644
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
@@ -563,6 +565,10 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 			if (err)
 				goto free_prealloc;
 		}
+	} else {
+		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size);
+		if (err)
+			goto free_map_locked;
 	}
 
 	return &htab->map;
@@ -573,6 +579,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
 		free_percpu(htab->map_locked[i]);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->ma);
 free_htab:
 	lockdep_unregister_key(&htab->lockdep_key);
 	bpf_map_area_free(htab);
@@ -849,7 +856,7 @@ static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
 		free_percpu(htab_elem_get_ptr(l, htab->map.key_size));
 	check_and_free_fields(htab, l);
-	kfree(l);
+	bpf_mem_cache_free(&htab->ma, l);
 }
 
 static void htab_elem_free_rcu(struct rcu_head *head)
@@ -973,9 +980,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
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
@@ -994,7 +999,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			pptr = bpf_map_alloc_percpu(&htab->map, size, 8,
 						    GFP_NOWAIT | __GFP_NOWARN);
 			if (!pptr) {
-				kfree(l_new);
+				bpf_mem_cache_free(&htab->ma, l_new);
 				l_new = ERR_PTR(-ENOMEM);
 				goto dec_count;
 			}
@@ -1489,6 +1494,7 @@ static void htab_map_free(struct bpf_map *map)
 	bpf_map_free_kptr_off_tab(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->ma);
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
 		free_percpu(htab->map_locked[i]);
 	lockdep_unregister_key(&htab->lockdep_key);
-- 
2.30.2

