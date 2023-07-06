Return-Path: <bpf+bounces-4248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A18749DEF
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 15:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708221C20D3A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 13:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655B6945F;
	Thu,  6 Jul 2023 13:38:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439FF9442
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 13:38:51 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA12D1BC8
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 06:38:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso7710945e9.3
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688650727; x=1691242727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zT3zxBGUbfcUoDnp5sNznxWwm+sunUs020DgMb/xHNQ=;
        b=DdP7hR6obSvbZvNa1pUgqMbTwhX0/ETW0E5mRihfe18oCfBi1dser8Mx9NcSGsWCP+
         0GV6KPioW4cz0oOUPuwjOQM16Vj3PKyYbdPLXoqNywGW53PI2zeLh8GabaamiKc3bafx
         YTEtHKUx0ivb27LicKVmEfNnbtBrWeQUraHY5iw39Wfmrpgbbx0iMoqM9l0HBE3l4I1M
         DjCK77QRKc75E7Zo+kZ/chqryrcC9irh3Jsc3QcLDBPgKDr5pxNlg/yCOCMXVz2uCoYj
         JcxV+VSnRCc1/g3YO4UqRE+sGgjYpxqNgG5XWTNvq0ArQ/zj5+14+5x6jgI/D5ipglpL
         SMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688650727; x=1691242727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zT3zxBGUbfcUoDnp5sNznxWwm+sunUs020DgMb/xHNQ=;
        b=dFcmXqSAKYMJICZcpwq4SbJAjKxU9uA/O7gzjVW+d17qassvtvO7P8YBLrPtvRnniv
         DboLE0pdKTeWf73PLd/8hxDrItSvx35IuT2UTaPRftC2zM2qXefBAYX70WEFZITu4RDu
         Lfn95wIYIrvUd9ayto4hVWoKW2nDn6XRlVw8I/DWJQGuTTjXrWJGFlQydkUE7IX74+Qm
         MjpOjgaNvK0ifDR9ZxkFm7eEaB1fTsuGtloEb0E9Ffm8a81H894qkUr7yGqHPPDR2G1M
         lJLLj/aHO93svwrDfdYTZCl3dnRxVtlu+UVFz0r6LwEVzkUFQqsn5sz+n3tvAgl5Uo1T
         8zFQ==
X-Gm-Message-State: ABy/qLaSfHEFY/zWeXctRLeyG9gH+VaQLjpwHRxoq+rncezDO8baLpTe
	yhb5MFGT6hDwC0XF/r1A9zAZgtkfPol1uurpHA+OKw==
X-Google-Smtp-Source: APBJJlFknuYL0A0Y1uKTueEeb07qnef2THnvypNgrP2aMqx2bwRd1sYstN0khc9dgEg1cxJbbCm2pA==
X-Received: by 2002:a05:600c:2192:b0:3fb:d72b:b2a0 with SMTP id e18-20020a05600c219200b003fbd72bb2a0mr1423192wme.6.1688650727355;
        Thu, 06 Jul 2023 06:38:47 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003f9b3829269sm6754524wmo.2.2023.07.06.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:38:46 -0700 (PDT)
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
	Hou Tao <houtao1@huawei.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v5 bpf-next 3/5] bpf: populate the per-cpu insertions/deletions counters for hashmaps
Date: Thu,  6 Jul 2023 13:39:30 +0000
Message-Id: <20230706133932.45883-4-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706133932.45883-1-aspsk@isovalent.com>
References: <20230706133932.45883-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
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
 kernel/bpf/hashtab.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 56d3da7d0bc6..a8c7e1c5abfa 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -302,6 +302,7 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
 	struct htab_elem *l;
 
 	if (node) {
+		bpf_map_inc_elem_count(&htab->map);
 		l = container_of(node, struct htab_elem, lru_node);
 		memcpy(l->key, key, htab->map.key_size);
 		return l;
@@ -510,12 +511,16 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	    htab->n_buckets > U32_MAX / sizeof(struct bucket))
 		goto free_htab;
 
+	err = bpf_map_init_elem_count(&htab->map);
+	if (err)
+		goto free_htab;
+
 	err = -ENOMEM;
 	htab->buckets = bpf_map_area_alloc(htab->n_buckets *
 					   sizeof(struct bucket),
 					   htab->map.numa_node);
 	if (!htab->buckets)
-		goto free_htab;
+		goto free_elem_count;
 
 	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++) {
 		htab->map_locked[i] = bpf_map_alloc_percpu(&htab->map,
@@ -593,6 +598,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
+free_elem_count:
+	bpf_map_free_elem_count(&htab->map);
 free_htab:
 	lockdep_unregister_key(&htab->lockdep_key);
 	bpf_map_area_free(htab);
@@ -804,6 +811,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 		if (l == tgt_l) {
 			hlist_nulls_del_rcu(&l->hash_node);
 			check_and_free_fields(htab, l);
+			bpf_map_dec_elem_count(&htab->map);
 			break;
 		}
 
@@ -900,6 +908,8 @@ static bool is_map_full(struct bpf_htab *htab)
 
 static void inc_elem_count(struct bpf_htab *htab)
 {
+	bpf_map_inc_elem_count(&htab->map);
+
 	if (htab->use_percpu_counter)
 		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
 	else
@@ -908,6 +918,8 @@ static void inc_elem_count(struct bpf_htab *htab)
 
 static void dec_elem_count(struct bpf_htab *htab)
 {
+	bpf_map_dec_elem_count(&htab->map);
+
 	if (htab->use_percpu_counter)
 		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
 	else
@@ -920,6 +932,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 	htab_put_fd_value(htab, l);
 
 	if (htab_is_prealloc(htab)) {
+		bpf_map_dec_elem_count(&htab->map);
 		check_and_free_fields(htab, l);
 		__pcpu_freelist_push(&htab->freelist, &l->fnode);
 	} else {
@@ -1000,6 +1013,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			if (!l)
 				return ERR_PTR(-E2BIG);
 			l_new = container_of(l, struct htab_elem, fnode);
+			bpf_map_inc_elem_count(&htab->map);
 		}
 	} else {
 		if (is_map_full(htab))
@@ -1168,6 +1182,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
 {
 	check_and_free_fields(htab, elem);
+	bpf_map_dec_elem_count(&htab->map);
 	bpf_lru_push_free(&htab->lru, &elem->lru_node);
 }
 
@@ -1357,8 +1372,10 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
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
 
@@ -1523,6 +1540,7 @@ static void htab_map_free(struct bpf_map *map)
 		prealloc_destroy(htab);
 	}
 
+	bpf_map_free_elem_count(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
-- 
2.34.1


