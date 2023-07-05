Return-Path: <bpf+bounces-4074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6727488CE
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 18:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391A3281083
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3B912B98;
	Wed,  5 Jul 2023 16:01:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7105125CC
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 16:01:15 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECDE19BC
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 09:00:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso71098235e9.3
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688572841; x=1691164841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVdaR0Z+YxZJOY5L6bhrExui3LGBisUcNZVmScyeu20=;
        b=J4tWjC2IXCGe8UoJgR96qrnvn1eqNLrEIeNnpWr09OOtVvNva2+cYq+hoX4PuasE6v
         /+zdiAl5928PAfu5jN49YO4zwkDY6YQkrXfN8vcTwDmiz17x//lN14vv83ySgytz0I95
         1kxQt+zTSdqpEwlLMbK1eQmhssOF6LXzXr0W+tznBS4rROxiLtF16DFu9L6E9wxngeuq
         kbYe5Yi4zXPaGnbe500jrkDzXGSF+E46smFxKcEK/DPuclj8yRZKWOn3e3GaJ+P0gIDM
         YKamodLOiSTZpaenLOB2BRVhYoCx40N2dvabscVih+nDPIKXPunxVr634qnVonmItL8o
         63MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572841; x=1691164841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVdaR0Z+YxZJOY5L6bhrExui3LGBisUcNZVmScyeu20=;
        b=W6837IERDThXsW+aryZD7vt7D6qodArd+T+S1rWfIqPZTWClqTATUSGoTWBSEW4YI3
         cCZrMUMOha4JuEuQSmmpGmtNZlrDe30dOLKcFEgMY5WkJvNmr+V19TmYZY5SAXT9y7Gb
         N8n6R/mb+5NisL6J+cWK1lJUte+gKl6uJb/y25F+01NYa9fc3JFP6mRAWVofrp2Is1/H
         UsqhuhDmWv7rHj6TwF/zBvH1H9Lp3mgVbSTCgAH2qBcWEV0ZJAWWRdD1E2KsIcUZi1ok
         /WP5xC523ntrJFYwfpa/3gajPFGYl07jTGUBEIHXEHvW+8SIVe/Gxod1iLM9sKt7bb5y
         4ORg==
X-Gm-Message-State: ABy/qLYum3AlLYwvB2/t3e8qi9iibq3VOlq+5sut3A2ABrxXZGufiHt3
	6cgkyv0vfin6AKAJS4MqPFA1smQxzpT62jmVuOTW1Q==
X-Google-Smtp-Source: APBJJlGfBGAFpwEplWWHfu4kStztIKzVPbATfcWQYfCO/phzOCa68PUxotmzUydtMx1UD/euyqNKKw==
X-Received: by 2002:a05:6000:545:b0:30e:3caa:971b with SMTP id b5-20020a056000054500b0030e3caa971bmr14553760wrf.51.1688572841644;
        Wed, 05 Jul 2023 09:00:41 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00314172ba213sm16861950wrn.108.2023.07.05.09.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:00:41 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 3/6] bpf: populate the per-cpu insertions/deletions counters for hashmaps
Date: Wed,  5 Jul 2023 16:01:36 +0000
Message-Id: <20230705160139.19967-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705160139.19967-1-aspsk@isovalent.com>
References: <20230705160139.19967-1-aspsk@isovalent.com>
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
maps. Non-trivial changes apply to preallocated maps for which the
{inc,dec}_elem_count functions are not called, as there's no need in counting
elements to sustain proper map operations.

To increase/decrease percpu counters for preallocated hash maps we add raw
calls to the bpf_map_{inc,dec}_elem_count functions so that the impact is
minimal. For dynamically allocated maps we add corresponding calls to the
existing {inc,dec}_elem_count functions.

For LRU maps bpf_map_{inc,dec}_elem_count added to the lru pop/free helpers.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/hashtab.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 56d3da7d0bc6..c23557bf9a1a 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -302,6 +302,7 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
 	struct htab_elem *l;
 
 	if (node) {
+		bpf_map_inc_elem_count(&htab->map);
 		l = container_of(node, struct htab_elem, lru_node);
 		memcpy(l->key, key, htab->map.key_size);
 		return l;
@@ -581,10 +582,17 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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
-	prealloc_destroy(htab);
+	if (prealloc)
+		prealloc_destroy(htab);
 free_map_locked:
 	if (htab->use_percpu_counter)
 		percpu_counter_destroy(&htab->pcount);
@@ -804,6 +812,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 		if (l == tgt_l) {
 			hlist_nulls_del_rcu(&l->hash_node);
 			check_and_free_fields(htab, l);
+			bpf_map_dec_elem_count(&htab->map);
 			break;
 		}
 
@@ -900,6 +909,8 @@ static bool is_map_full(struct bpf_htab *htab)
 
 static void inc_elem_count(struct bpf_htab *htab)
 {
+	bpf_map_inc_elem_count(&htab->map);
+
 	if (htab->use_percpu_counter)
 		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
 	else
@@ -908,6 +919,8 @@ static void inc_elem_count(struct bpf_htab *htab)
 
 static void dec_elem_count(struct bpf_htab *htab)
 {
+	bpf_map_dec_elem_count(&htab->map);
+
 	if (htab->use_percpu_counter)
 		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
 	else
@@ -920,6 +933,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 	htab_put_fd_value(htab, l);
 
 	if (htab_is_prealloc(htab)) {
+		bpf_map_dec_elem_count(&htab->map);
 		check_and_free_fields(htab, l);
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
@@ -1000,6 +1014,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			if (!l)
 				return ERR_PTR(-E2BIG);
 			l_new = container_of(l, struct htab_elem, fnode);
+			bpf_map_inc_elem_count(&htab->map);
 		}
 	} else {
 		if (is_map_full(htab))
@@ -1168,6 +1183,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
 {
 	check_and_free_fields(htab, elem);
+	bpf_map_dec_elem_count(&htab->map);
 	bpf_lru_push_free(&htab->lru, &elem->lru_node);
 }
 
@@ -1357,8 +1373,10 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
 err_lock_bucket:
-	if (l_new)
+	if (l_new) {
+		bpf_map_dec_elem_count(&htab->map);
 		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
+	}
 	return ret;
 }
 
@@ -1523,6 +1541,7 @@ static void htab_map_free(struct bpf_map *map)
 		prealloc_destroy(htab);
 	}
 
+	bpf_map_free_elem_count(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
-- 
2.34.1


