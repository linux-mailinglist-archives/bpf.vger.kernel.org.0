Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABFC556F77
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 02:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiFWAco (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 20:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbiFWAcn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 20:32:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40A241635
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 17:32:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x4so11228647pfq.2
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 17:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9T9NR4nKlMACX3pxYCOfVfWAzLl4l8l5nSD0Zg/WaoU=;
        b=pyzTNfUB8mPg3XTU36LXo5D980GccTgJD/KYvoii7Sro0X0gY7GqCtE3pl40Kye2Qr
         unHDj9dxMALP1/BgCj7tCoKRbLOzrStCOAwlcG3UcfJ7fAj5TMTnKlHUbPD4i+F/uClR
         kPsxJUpkgF2gdHS5w55+0RbMcFlqNGL3MDjVinJ6OHiFa7cDh+MAZoIzBMUUHCvAGnam
         +ymboXyzI5vTjl37P+TYRwOjldY9vUFGKS4lzkWgB6OKCfCkBi4s7yEe4CisA/EUmbD6
         rr6ZHEULWByOOx0BdRAI81Dk6bPb2cKV6+J8WCoouYOXSCL8eegC6oCRwmnwK8dLDQT9
         BRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9T9NR4nKlMACX3pxYCOfVfWAzLl4l8l5nSD0Zg/WaoU=;
        b=JszxqLIN4VqRIf4zJHuox+AZNnfMNBZpSmsS9jDn4Le4dAjVnd0kf7x7CMu2qEoNzn
         pBm8Dxsqcstxi8KXs1ZWqmVpUg8LMAaDhJjQUgoaIkqeUPVDDYrAhWNCaU0aL5vO5ivz
         K+DOE3GNe7VVDI/4NHMf08O6IUptO5/kVWl44DDYRw4UuKIL0ah7gCMYfTmDJiJplWF6
         wsH6ItqF70ho8T6Yr/3N5bgKyE1W/BmzQ592dy0ypfJbj0tj9hqv5o1G6Fy8VOjPD83G
         zvLNmahpMc7y21046X+T8Cyekj4sVwbUjjJPWcvDqFz2kz2EGLqdd7lwZ0efbNgbmqe5
         q8iw==
X-Gm-Message-State: AJIora/NDEEO68hS7SkJYby5knh0BEiMTaTWmIXViWHF3ixdz3TltfI6
        9HhIrVDwA/L+qkdDpZsBh6Y=
X-Google-Smtp-Source: AGRyM1tWu/A2obwa/13PSfMz3DGE6J0rTR7f/gaJAT3x7rYk4yylYTjSMLywyXNyU2w3g3lC3xJXAg==
X-Received: by 2002:a05:6a00:234f:b0:525:1f7c:f2bf with SMTP id j15-20020a056a00234f00b005251f7cf2bfmr20455740pfj.14.1655944362381;
        Wed, 22 Jun 2022 17:32:42 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:29cb])
        by smtp.gmail.com with ESMTPSA id mv24-20020a17090b199800b001d954837197sm389339pjb.22.2022.06.22.17.32.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jun 2022 17:32:41 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        kafai@fb.com, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 2/5] bpf: Convert hash map to bpf_mem_alloc.
Date:   Wed, 22 Jun 2022 17:32:27 -0700
Message-Id: <20220623003230.37497-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
References: <20220623003230.37497-1-alexei.starovoitov@gmail.com>
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
index 17fb69c0e0dc..62b7b6e6751b 100644
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
@@ -554,6 +556,10 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	htab_init_buckets(htab);
 
+	err = bpf_mem_alloc_init(&htab->ma, htab->elem_size);
+	if (err)
+		goto free_map_locked;
+
 	if (prealloc) {
 		err = prealloc_init(htab);
 		if (err)
@@ -577,6 +583,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
 		free_percpu(htab->map_locked[i]);
 	bpf_map_area_free(htab->buckets);
+	bpf_mem_alloc_destroy(&htab->ma);
 free_htab:
 	lockdep_unregister_key(&htab->lockdep_key);
 	kfree(htab);
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
-					     GFP_ATOMIC | __GFP_NOWARN,
-					     htab->map.numa_node);
+		l_new = bpf_mem_cache_alloc(&htab->ma);
 		if (!l_new) {
 			l_new = ERR_PTR(-ENOMEM);
 			goto dec_count;
@@ -998,7 +1003,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			pptr = bpf_map_alloc_percpu(&htab->map, size, 8,
 						    GFP_ATOMIC | __GFP_NOWARN);
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

