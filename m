Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DBF550BF7
	for <lists+bpf@lfdr.de>; Sun, 19 Jun 2022 17:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiFSPvG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 11:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiFSPvF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 11:51:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB20CBC94
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:51:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b10so813598plg.4
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QAskb+5yNIJsaldLr50aWhyLhYS5r5QAog9O7C8QAr0=;
        b=KVtvmyag+k7GB/fCkk8AqkzTGDWXZtmlQ+PT8NnSmeq2wzVE6RIirW/ZsVSL0WWl65
         r/F0p777dkMTZPtEYW0XSiRRz5FeDX1WCndPeYgV5jvIuU4HH1HmzNOprr3x38QJih41
         /DVbvpKY2WZujqIpOlmgwxyc+85XJbvqSIsK1n2vY4Jo67si1AG5+OHzdizLQQEHW700
         uWHc1PExNAaByKT6ttxpzOxXL+OeK0CLn1S7pL0mI73iHpByUDSEephJTCx7J1VJeacY
         TTjatlqZe7ts+Vs2hs68NR/gdLC+OZnyxmvFQ2Hx3FZhcKdTpBFYsXDEU2cpSj5g5/6l
         UeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QAskb+5yNIJsaldLr50aWhyLhYS5r5QAog9O7C8QAr0=;
        b=fGDiCehYV+Xnjr17F/aLkHcNpnX3KyTgXk8G65buY1045iEuCuWQm8M2N/dWlAyY3i
         2cib4nE7WLJTGyKmlxClSWxK4uePeovil5a7o6ribgkhFGCj/Q2VyXbG80Z2ysAJ4EQF
         eJ63eKIyrMdPeDjr1nj+8lWSqO+DMwisa+OELyZW7eGRmQM05H/FInEKknCue8ulS6gO
         IskFTR7q9Jo1V9UV4OzYT13eK1lGpINggOKM1mPvJsWyUjGkXZb+BT3ngawsNna82MJk
         4wxd/CPEyn2wNbuBFYjoRJpLp2fPNwg6k/CPhH6Z4jQqsJEj3NCzy407Wah22BylMRzq
         vxFA==
X-Gm-Message-State: AJIora8/En8EXjAO0StZCtMYPKLDt81wHeGdT2Kzq3JP9qUcc8INZoVT
        2lj37IIYsIPeDTemZ/OJ4tM=
X-Google-Smtp-Source: AGRyM1tZi5Zt0G1PIz0scQfO4Nr+NU/o7ujG423ZsaI0GC2fomWJFdewsZiWfRB2CETXpaFwWsKygw==
X-Received: by 2002:a17:902:b597:b0:168:d8ce:4a63 with SMTP id a23-20020a170902b59700b00168d8ce4a63mr19745970pls.57.1655653863216;
        Sun, 19 Jun 2022 08:51:03 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:2b24:5400:4ff:fe09:b144])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709027e8a00b001690a7df347sm6381761pla.96.2022.06.19.08.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 08:51:02 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 10/10] bpf: Support recharge for hash map
Date:   Sun, 19 Jun 2022 15:50:32 +0000
Message-Id: <20220619155032.32515-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220619155032.32515-1-laoar.shao@gmail.com>
References: <20220619155032.32515-1-laoar.shao@gmail.com>
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

This patch introduces a helper to recharge pages of a hash map. We have
already known how the hash map is allocated and freed, we can also know
how to charge and uncharge the hash map.

Firstly, we need to pre charge to the new memcg, if the pre charge
successes then we uncharge from the old memcg. Finnaly we do the post
charge to the new memcg, in which we will modify the counter in memcgs.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/hashtab.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 17fb69c0e0dc..fe61976262ee 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -11,6 +11,7 @@
 #include <uapi/linux/btf.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/btf_ids.h>
+#include <linux/memcontrol.h>
 #include "percpu_freelist.h"
 #include "bpf_lru_list.h"
 #include "map_in_map.h"
@@ -1499,6 +1500,75 @@ static void htab_map_free(struct bpf_map *map)
 	kfree(htab);
 }
 
+#ifdef CONFIG_MEMCG_KMEM
+static bool htab_map_memcg_recharge(struct bpf_map *map)
+{
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	struct mem_cgroup *old = map->memcg;
+	int i;
+
+	/*
+	 * Although the bpf map's offline memcg has been reparented, there
+	 * is still reference on it, so it is safe to be accessed.
+	 */
+	if (!old)
+		return false;
+
+	/* Pre charge to the new memcg */
+	if (!krecharge(htab, MEMCG_KMEM_PRE_CHARGE))
+		return false;
+
+	if (!kvrecharge(htab->buckets, MEMCG_KMEM_PRE_CHARGE))
+		goto out_k;
+
+	if (!recharge_percpu(htab->extra_elems, MEMCG_KMEM_PRE_CHARGE))
+		goto out_kv;
+
+	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++) {
+		if (!recharge_percpu(htab->map_locked[i], MEMCG_KMEM_PRE_CHARGE))
+			goto out_p;
+	}
+
+	/* Uncharge from the old memcg. */
+	krecharge(htab, MEMCG_KMEM_UNCHARGE);
+	kvrecharge(htab->buckets, MEMCG_KMEM_UNCHARGE);
+	recharge_percpu(htab->extra_elems, MEMCG_KMEM_UNCHARGE);
+	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
+		recharge_percpu(htab->map_locked[i], MEMCG_KMEM_UNCHARGE);
+
+	/* Release the old memcg */
+	bpf_map_release_memcg(map);
+
+	/* Post charge to the new memcg */
+	krecharge(htab, MEMCG_KMEM_POST_CHARGE);
+	kvrecharge(htab->buckets, MEMCG_KMEM_POST_CHARGE);
+	recharge_percpu(htab->extra_elems, MEMCG_KMEM_POST_CHARGE);
+	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
+		recharge_percpu(htab->map_locked[i], MEMCG_KMEM_POST_CHARGE);
+
+	/* Save the new memcg */
+	bpf_map_save_memcg(map);
+
+	return true;
+
+out_p:
+	for (; i > 0; i--)
+		recharge_percpu(htab->map_locked[i], MEMCG_KMEM_CHARGE_ERR);
+	recharge_percpu(htab->extra_elems, MEMCG_KMEM_CHARGE_ERR);
+out_kv:
+	kvrecharge(htab->buckets, MEMCG_KMEM_CHARGE_ERR);
+out_k:
+	krecharge(htab, MEMCG_KMEM_CHARGE_ERR);
+
+	return false;
+}
+#else
+static bool htab_map_memcg_recharge(struct bpf_map *map)
+{
+	return true;
+}
+#endif
+
 static void htab_map_seq_show_elem(struct bpf_map *map, void *key,
 				   struct seq_file *m)
 {
@@ -2152,6 +2222,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_alloc_check = htab_map_alloc_check,
 	.map_alloc = htab_map_alloc,
 	.map_free = htab_map_free,
+	.map_memcg_recharge = htab_map_memcg_recharge,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_release_uref = htab_map_free_timers,
 	.map_lookup_elem = htab_map_lookup_elem,
@@ -2172,6 +2243,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
 	.map_alloc_check = htab_map_alloc_check,
 	.map_alloc = htab_map_alloc,
 	.map_free = htab_map_free,
+	.map_memcg_recharge = htab_map_memcg_recharge,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_release_uref = htab_map_free_timers,
 	.map_lookup_elem = htab_lru_map_lookup_elem,
@@ -2325,6 +2397,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
 	.map_alloc_check = htab_map_alloc_check,
 	.map_alloc = htab_map_alloc,
 	.map_free = htab_map_free,
+	.map_memcg_recharge = htab_map_memcg_recharge,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_percpu_map_lookup_elem,
 	.map_lookup_and_delete_elem = htab_percpu_map_lookup_and_delete_elem,
@@ -2344,6 +2417,7 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
 	.map_alloc_check = htab_map_alloc_check,
 	.map_alloc = htab_map_alloc,
 	.map_free = htab_map_free,
+	.map_memcg_recharge = htab_map_memcg_recharge,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_lru_percpu_map_lookup_elem,
 	.map_lookup_and_delete_elem = htab_lru_percpu_map_lookup_and_delete_elem,
-- 
2.17.1

