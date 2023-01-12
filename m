Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1F667A2C
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 17:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjALQBM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 11:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjALQAo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 11:00:44 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29776262
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:37 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id a25so9626912qto.10
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVUzU5Lm9v4TwCr8MR19Sbma13E60mByaOAa7yrtf24=;
        b=ALz+sfZNfS4qifRdKVjJ8liTZOnDRU+va/zE0oxhTHHmiy4uVJp/MTYMO3s8HKBBX7
         kfY7l06ClrnXzuJ7SwOeoV5XP8m4rE/PpAwk2M/ze8SKWK3++rl0/fpfL9a1+7NncPo/
         SsTYC3AIuXIEEPnYcGdNOIgGgXh6MnLjg7cFUrFJw3+s5Pzcdcwez0u3SEm8SWfVa8SI
         lV3T8Y6TP2pAb72E04aXg+cxHgxvtBaUv2MNbXhHDcG968NZCThz/0JKKSqupM5LkS5s
         bzBoNfaoCpdlDpOHwABYaSzg706CqymnvMJ07sqq4vcd/D+PIpKMKMaWwx7WypE2pfis
         NrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVUzU5Lm9v4TwCr8MR19Sbma13E60mByaOAa7yrtf24=;
        b=UMkJtSaGFuo+57DS5ovt76zX/TXD9k/3qgQfvy3huzEMTn0TEpCFw+goNP1qHj8NBH
         Kfzw+Gh2k1ZgijNrAxmEa6yzjT3RZt8lD6ONrJnEdeyWg0k5Ybqum7sRNYiW8iuGo4AA
         CdDwNQDLv1N5m4awem+/q69m/fAitheSFa8S272Ww+Q4zfXeasjDm1fMBsO9ItFP4oMe
         RU4oJCwudrnaH239y8HkDwqOe986orYyrxdIfFwghGs3KyRlrIysBP+7B42lk/hOWi8n
         EiITgsZwoFbaKqCyghTnH+NLwYCuHE6gfVMgAneNmI09arAqKpyDT0j7FwHIG/PY5sFg
         QRXQ==
X-Gm-Message-State: AFqh2koWbA2s60ND0ZzScro8+hsKG1/c+HuWEEq92qXd614h2XRQERzq
        Y4RMX6uMaFob4oKzotS0ss4=
X-Google-Smtp-Source: AMrXdXsF0qX10TMukl4qhalYqOJc8cvWNp4i4Otvd5G6MW0t1u1Ue6UiuE5Z2o4FUsT/NSZGV/wCPQ==
X-Received: by 2002:ac8:6c7:0:b0:3a7:f424:d1bb with SMTP id j7-20020ac806c7000000b003a7f424d1bbmr14664614qth.21.1673538817402;
        Thu, 12 Jan 2023 07:53:37 -0800 (PST)
Received: from vultr.guest ([173.199.122.241])
        by smtp.gmail.com with ESMTPSA id l17-20020ac848d1000000b003ab43dabfb1sm9280836qtr.55.2023.01.12.07.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:53:36 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     42.hyeyoo@gmail.com, vbabka@suse.cz, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 03/11] mm: slab: rename obj_full_size()
Date:   Thu, 12 Jan 2023 15:53:18 +0000
Message-Id: <20230112155326.26902-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230112155326.26902-1-laoar.shao@gmail.com>
References: <20230112155326.26902-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The helper obj_full_size() is a little misleading, because it is only
valid when kmemcg is enabled. Meanwhile it is only used when kmemcg is
enabled currently, so we just need to rename it to a more meaningful name.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/slab.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 7cc4329..35e0b3b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -467,7 +467,10 @@ static inline void memcg_free_slab_cgroups(struct slab *slab)
 	slab->memcg_data = 0;
 }
 
-static inline size_t obj_full_size(struct kmem_cache *s)
+/*
+ * This helper is only valid when kmemcg isn't disabled.
+ */
+static inline size_t obj_kmemcg_size(struct kmem_cache *s)
 {
 	/*
 	 * For each accounted object there is an extra space which is used
@@ -508,7 +511,7 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
 			goto out;
 	}
 
-	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s)))
+	if (obj_cgroup_charge(objcg, flags, objects * obj_kmemcg_size(s)))
 		goto out;
 
 	*objcgp = objcg;
@@ -537,7 +540,7 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 			if (!slab_objcgs(slab) &&
 			    memcg_alloc_slab_cgroups(slab, s, flags,
 							 false)) {
-				obj_cgroup_uncharge(objcg, obj_full_size(s));
+				obj_cgroup_uncharge(objcg, obj_kmemcg_size(s));
 				continue;
 			}
 
@@ -545,9 +548,9 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 			obj_cgroup_get(objcg);
 			slab_objcgs(slab)[off] = objcg;
 			mod_objcg_state(objcg, slab_pgdat(slab),
-					cache_vmstat_idx(s), obj_full_size(s));
+					cache_vmstat_idx(s), obj_kmemcg_size(s));
 		} else {
-			obj_cgroup_uncharge(objcg, obj_full_size(s));
+			obj_cgroup_uncharge(objcg, obj_kmemcg_size(s));
 		}
 	}
 	obj_cgroup_put(objcg);
@@ -576,9 +579,9 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 			continue;
 
 		objcgs[off] = NULL;
-		obj_cgroup_uncharge(objcg, obj_full_size(s));
+		obj_cgroup_uncharge(objcg, obj_kmemcg_size(s));
 		mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
-				-obj_full_size(s));
+				-obj_kmemcg_size(s));
 		obj_cgroup_put(objcg);
 	}
 }
-- 
1.8.3.1

