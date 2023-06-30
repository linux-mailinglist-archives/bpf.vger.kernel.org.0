Return-Path: <bpf+bounces-3763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A68743704
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22E51C20B08
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC59FBE4;
	Fri, 30 Jun 2023 08:24:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C1E55E
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 08:24:23 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC303583
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 01:24:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fa9850bfebso16780805e9.1
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 01:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688113459; x=1690705459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amlpCgJzx5rSxoJN7QUz28WPyqibs0iWhYHEZ64qSgg=;
        b=fHCd6xxAEz3x1dXerVdDYkCGe06eSZg8rzUQ11MnrqzcQxROmmS5kcpyxhgv19keWW
         vcDaUVQ9eYX+6GkVzaB2zQ1Kgs8vzywM9iwl+oLxfUbG364uv4/heP8TsAUoOkzRvzld
         AHCaQy/IuRPsTOeEkV0gdaKXJTkPmv7eNXElySWdsjBH0hfZdolj9fZsiqlGfVXuxYh0
         HMllsYtEL1NqLGPnPVSFxbAYVrlM4g6NaBJt+hyOYwqQXKGk+3NscwVZ40ZaupDBG0a3
         OyfUI9TWUanb4h8FVesFGKmYuH8a3BGSlqdX2D1imwJsKR7TovsIQ2UbHLCvUy1WT916
         j5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688113459; x=1690705459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amlpCgJzx5rSxoJN7QUz28WPyqibs0iWhYHEZ64qSgg=;
        b=XqZVvkc1dYl8mOAqfSwpPz+UcKwZfXTPeQedgt49WJuV9wrWgiLgtOzlD+huKMJlUg
         I9rJjDIeXuv2cXwRJC4ZXNV8sJGaG2vDzrsWgobkU+w+6QFeYNyLBOjPr7DhaF98zYqP
         mXTQEg5hfY1VrjrWKdPk90BBLvgrIbP+L85V/iZJadg4IGvSHDBOfiTyuM5hCuz9HB66
         VpVvNRU2wtmdH9zlKcjd0JYUc52lL7Pjmf7+BY4yyzaEQx1PidFLf+Rt0YB9QZynz7pf
         9xkv5g38NdFPPyzZfO6oAi6UNEl9+1jUcsFQxDiq0J/YHl1el3gs5AS2nQ5a0wYr+acF
         mFog==
X-Gm-Message-State: AC+VfDxqmBQlSlK0RyUQX4f0dgMyU6SAwEWc/0TLtjUX1aUzmQFDbN1Z
	njww67LN0AtcOUL36gsi6dPoUg==
X-Google-Smtp-Source: ACHHUZ7A6uBWBo1UOVDd890fh/GpokZvYrO9turGwEQv3IaLEKJzjVbLlUudYOdzJqtqlbvzIDewgg==
X-Received: by 2002:a05:600c:2114:b0:3fa:8874:fe69 with SMTP id u20-20020a05600c211400b003fa8874fe69mr1537273wml.29.1688113459727;
        Fri, 30 Jun 2023 01:24:19 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003fa74bff02asm18189941wmb.26.2023.06.30.01.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:24:19 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [v3 PATCH bpf-next 3/6] bpf: populate the per-cpu insertions/deletions counters for hashmaps
Date: Fri, 30 Jun 2023 08:25:13 +0000
Message-Id: <20230630082516.16286-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630082516.16286-1-aspsk@isovalent.com>
References: <20230630082516.16286-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Initialize and utilize the per-cpu insertions/deletions counters for hash-based
maps. Non-trivial changes only apply to the preallocated maps for which the
{inc,dec}_elem_count functions are not called, as there's no need in counting
elements to sustain proper map operations.

To increase/decrease percpu counters for preallocated maps we add raw calls to
the bpf_map_{inc,dec}_elem_count functions so that the impact is minimal. For
dynamically allocated maps we add corresponding calls to the existing
{inc,dec}_elem_count functions.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/hashtab.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 56d3da7d0bc6..faaef4fd3df0 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -581,8 +581,14 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 		}
 	}
 
+	err = bpf_map_init_elem_count(&htab->map);
+	if (err)
+		goto free_extra_elements;
+
 	return &htab->map;
 
+free_extra_elements:
+	free_percpu(htab->extra_elems);
 free_prealloc:
 	prealloc_destroy(htab);
 free_map_locked:
@@ -804,6 +810,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 		if (l == tgt_l) {
 			hlist_nulls_del_rcu(&l->hash_node);
 			check_and_free_fields(htab, l);
+			bpf_map_dec_elem_count(&htab->map);
 			break;
 		}
 
@@ -900,6 +907,8 @@ static bool is_map_full(struct bpf_htab *htab)
 
 static void inc_elem_count(struct bpf_htab *htab)
 {
+	bpf_map_inc_elem_count(&htab->map);
+
 	if (htab->use_percpu_counter)
 		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
 	else
@@ -908,6 +917,8 @@ static void inc_elem_count(struct bpf_htab *htab)
 
 static void dec_elem_count(struct bpf_htab *htab)
 {
+	bpf_map_dec_elem_count(&htab->map);
+
 	if (htab->use_percpu_counter)
 		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
 	else
@@ -920,6 +931,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 	htab_put_fd_value(htab, l);
 
 	if (htab_is_prealloc(htab)) {
+		bpf_map_dec_elem_count(&htab->map);
 		check_and_free_fields(htab, l);
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
@@ -1000,6 +1012,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			if (!l)
 				return ERR_PTR(-E2BIG);
 			l_new = container_of(l, struct htab_elem, fnode);
+			bpf_map_inc_elem_count(&htab->map);
 		}
 	} else {
 		if (is_map_full(htab))
@@ -1224,7 +1237,8 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	if (l_old) {
 		bpf_lru_node_set_ref(&l_new->lru_node);
 		hlist_nulls_del_rcu(&l_old->hash_node);
-	}
+	} else
+		bpf_map_inc_elem_count(&htab->map);
 	ret = 0;
 
 err:
@@ -1351,6 +1365,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 		pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
 				value, onallcpus);
 		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+		bpf_map_inc_elem_count(&htab->map);
 		l_new = NULL;
 	}
 	ret = 0;
@@ -1437,9 +1452,10 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 
 	l = lookup_elem_raw(head, hash, key, key_size);
 
-	if (l)
+	if (l) {
+		bpf_map_dec_elem_count(&htab->map);
 		hlist_nulls_del_rcu(&l->hash_node);
-	else
+	} else
 		ret = -ENOENT;
 
 	htab_unlock_bucket(htab, b, hash, flags);
@@ -1523,6 +1539,7 @@ static void htab_map_free(struct bpf_map *map)
 		prealloc_destroy(htab);
 	}
 
+	bpf_map_free_elem_count(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
-- 
2.34.1


