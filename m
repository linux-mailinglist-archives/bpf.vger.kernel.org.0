Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B56864976A
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 01:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiLLAh6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 19:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiLLAh6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 19:37:58 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315C12628
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:37:57 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u5so10270966pjy.5
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHvieJOPfKU228A/FcGpl6NQ2QtETLo/uwnKW3/KnGM=;
        b=R1Dq44NIQGVO0+qq21tEHH6CncuZ3dTgE2cbw8HLO8saI8/5z0r/X0CECMdjYOgRv5
         SMjSPHWZ8K2mAGRes/5tIu7FBuiyDmZfqOd6zZtvSmpU2LipHlsLhWkPY4mEV5JoKNRi
         BpaWYokf6VLHMRv8IXvOqTUQ1BqQZlb6F1ZsovRUuujPt0efJ9O2cbw3ryYciICij6gR
         W2NclCv2pqtr7MdFxnuVO1kO83DIlfndrqXivZo6F/9XzBbyauW/h1+LcLsNpSphAhP/
         WgRcDWX/f/2LzKBVFNKMEqblIw2fLaqSAgkzDYeF1+tSuC9j2136W3PmA2kqcTyA5rAL
         3iEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHvieJOPfKU228A/FcGpl6NQ2QtETLo/uwnKW3/KnGM=;
        b=ERF/xgCwTidx+4Ptn28+HX0h8ImwdJfUHlpehCXr3NlxJ225N/8G7Tiu8Zr+bT2o2g
         NSr7g6j1SaKsr96uU921meUu5VkUlOXY1zrMH3j8T4s7+wOtkYnqYfsv1LzYvrPj/hjq
         QL9CLTQlE10/t1VbeUEIEQshp7tgs4ywWgURf28Y+ytNlwpBx1rmJf5TpTnNQ/r2kB/c
         VYC5XmlnmBAfi0e9Dk7TlaK/5MEoGR6PA+3J7jTNxPygY7pPw+i7K27S/41Kt3FV5Fgo
         GCPawbrpmKF3mJOBbZtaAMFyGqOY+YhTTGj5NpfN7s+GFHuty+n8knzQWblOYqZATTjr
         jfpg==
X-Gm-Message-State: ANoB5pkoMG8VV0axlU4kl3NrsSowqdU6OuU1KRnOmcKIGEWrX/5XBA7G
        JODPVZwE9w5DzU2uMSifPtwxbIeM01ULjGHK2Xs=
X-Google-Smtp-Source: AA0mqf6GDUpbXr/OdqXwQUyMcN2xVFgzoCfs01LkdidF7uxzxZaISdRKNaWHUuHKNdtKC3oYE3Ycsg==
X-Received: by 2002:a17:902:c14c:b0:189:9733:59d3 with SMTP id 12-20020a170902c14c00b00189973359d3mr14030488plj.29.1670805476623;
        Sun, 11 Dec 2022 16:37:56 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7002:8c7:5400:4ff:fe3d:656a])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902e88900b00177fb862a87sm4895960plg.20.2022.12.11.16.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 16:37:55 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 4/9] mm: slab: Account active vm for slab
Date:   Mon, 12 Dec 2022 00:37:06 +0000
Message-Id: <20221212003711.24977-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221212003711.24977-1-laoar.shao@gmail.com>
References: <20221212003711.24977-1-laoar.shao@gmail.com>
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

When a slab object is allocated, we will mark this object in this
slab and check it at slab object freeing. That said we need extra memory
to store the information of each object in a slab. The information of
each object in a slab can be stored in the new introduced page extension
active_vm, so a new member is added into struct active_vm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/active_vm.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++
 mm/active_vm.h |  16 +++++++
 mm/slab.h      |   7 ++++
 mm/slub.c      |   2 +
 4 files changed, 136 insertions(+)

diff --git a/mm/active_vm.c b/mm/active_vm.c
index 541b2ba22da9..ee38047a4adc 100644
--- a/mm/active_vm.c
+++ b/mm/active_vm.c
@@ -1,6 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
 #include <linux/page_ext.h>
 #include <linux/active_vm.h>
+#include <linux/slab.h>
+
+#include "active_vm.h"
+#include "slab.h"
 
 static bool __active_vm_enabled __initdata =
 				IS_ENABLED(CONFIG_ACTIVE_VM);
@@ -28,7 +33,12 @@ static void __init init_active_vm(void)
 	static_branch_disable(&active_vm_disabled);
 }
 
+struct active_vm {
+	int *slab_data;     /* for slab */
+};
+
 struct page_ext_operations active_vm_ops = {
+	.size = sizeof(struct active_vm),
 	.need = need_active_vm,
 	.init = init_active_vm,
 };
@@ -54,3 +64,104 @@ long active_vm_item_sum(int item)
 
 	return sum;
 }
+
+static int *active_vm_from_slab(struct page_ext *page_ext)
+{
+	struct active_vm *av;
+
+	if (static_branch_likely(&active_vm_disabled))
+		return NULL;
+
+	av = (void *)(page_ext) + active_vm_ops.offset;
+	return READ_ONCE(av->slab_data);
+}
+
+void active_vm_slab_free(struct slab *slab)
+{
+	struct page_ext *page_ext;
+	struct active_vm *av;
+	struct page *page;
+
+	page = slab_page(slab);
+	page_ext = page_ext_get(page);
+	if (!page_ext)
+		return;
+
+	av = (void *)(page_ext) + active_vm_ops.offset;
+	kfree(av->slab_data);
+	av->slab_data = NULL;
+	page_ext_put(page_ext);
+}
+
+static bool active_vm_slab_cmpxchg(struct page_ext *page_ext, int *new)
+{
+	struct active_vm *av;
+
+	av = (void *)(page_ext) + active_vm_ops.offset;
+	return cmpxchg(&av->slab_data, NULL, new) == NULL;
+}
+
+void active_vm_slab_add(struct kmem_cache *s, gfp_t flags, size_t size, void **p)
+{
+	struct page_ext *page_ext;
+	struct slab *slab;
+	struct page *page;
+	int *vec;
+	int item;
+	int off;
+	int i;
+
+	item = active_vm_item();
+	for (i = 0; i < size; i++) {
+		slab = virt_to_slab(p[i]);
+		page = slab_page(slab);
+		page_ext = page_ext_get(page);
+
+		if (!page_ext)
+			continue;
+
+		off = obj_to_index(s, slab, p[i]);
+		vec = active_vm_from_slab(page_ext);
+		if (!vec) {
+			vec = kcalloc_node(objs_per_slab(s, slab), sizeof(int),
+						flags & ~__GFP_ACCOUNT, slab_nid(slab));
+			if (!vec) {
+				page_ext_put(page_ext);
+				continue;
+			}
+
+			if (!active_vm_slab_cmpxchg(page_ext, vec)) {
+				kfree(vec);
+				vec = active_vm_from_slab(page_ext);
+			}
+		}
+
+		vec[off] = item;
+		active_vm_item_add(item, obj_full_size(s));
+		page_ext_put(page_ext);
+	}
+}
+
+void active_vm_slab_sub(struct kmem_cache *s, struct slab *slab, void **p, int cnt)
+{
+	struct page *page = slab_page(slab);
+	struct page_ext *page_ext = page_ext_get(page);
+	int *vec;
+	int off;
+	int i;
+
+	if (!page_ext)
+		return;
+
+	for (i = 0; i < cnt; i++) {
+		vec = active_vm_from_slab(page_ext);
+		if (vec) {
+			off = obj_to_index(s, slab, p[i]);
+			if (vec[off] > 0) {
+				active_vm_item_sub(vec[off], obj_full_size(s));
+				vec[off] = 0;
+			}
+		}
+	}
+	page_ext_put(page_ext);
+}
diff --git a/mm/active_vm.h b/mm/active_vm.h
index 1df088d768ef..cf80b35412c5 100644
--- a/mm/active_vm.h
+++ b/mm/active_vm.h
@@ -4,8 +4,12 @@
 
 #ifdef CONFIG_ACTIVE_VM
 #include <linux/active_vm.h>
+#include <linux/page_ext.h>
 
 extern struct page_ext_operations active_vm_ops;
+void active_vm_slab_add(struct kmem_cache *s, gfp_t flags, size_t size, void **p);
+void active_vm_slab_sub(struct kmem_cache *s, struct slab *slab, void **p, int cnt);
+void active_vm_slab_free(struct slab *slab);
 
 static inline int active_vm_item(void)
 {
@@ -42,5 +46,17 @@ static inline void active_vm_item_add(int item, long delta)
 static inline void active_vm_item_sub(int item, long delta)
 {
 }
+
+static inline void active_vm_slab_add(struct kmem_cache *s, gfp_t flags, size_t size, void **p)
+{
+}
+
+static inline void active_vm_slab_sub(struct kmem_cache *s, struct slab *slab, void **p, int cnt)
+{
+}
+
+static inline void active_vm_slab_free(struct slab *slab)
+{
+}
 #endif /* CONFIG_ACTIVE_VM */
 #endif /* __MM_ACTIVE_VM_H */
diff --git a/mm/slab.h b/mm/slab.h
index 0202a8c2f0d2..e8a4c16c29cb 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -232,6 +232,8 @@ struct kmem_cache {
 #include <linux/random.h>
 #include <linux/sched/mm.h>
 #include <linux/list_lru.h>
+#include <linux/active_vm.h>
+#include "active_vm.h"
 
 /*
  * State of the slab allocator.
@@ -644,6 +646,9 @@ static __always_inline void unaccount_slab(struct slab *slab, int order,
 	if (memcg_kmem_enabled())
 		memcg_free_slab_cgroups(slab);
 
+	if (active_vm_enabled())
+		active_vm_slab_free(slab);
+
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    -(PAGE_SIZE << order));
 }
@@ -742,6 +747,8 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 		kmsan_slab_alloc(s, p[i], flags);
 	}
 
+	if (active_vm_enabled() && (flags & __GFP_ACCOUNT) && active_vm_item() > 0)
+		active_vm_slab_add(s, flags, size, p);
 	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
 }
 
diff --git a/mm/slub.c b/mm/slub.c
index 157527d7101b..21bd714c1182 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -45,6 +45,7 @@
 #include <trace/events/kmem.h>
 
 #include "internal.h"
+#include "active_vm.h"
 
 /*
  * Lock order:
@@ -3654,6 +3655,7 @@ static __always_inline void slab_free(struct kmem_cache *s, struct slab *slab,
 				      unsigned long addr)
 {
 	memcg_slab_free_hook(s, slab, p, cnt);
+	active_vm_slab_sub(s, slab, p, cnt);
 	/*
 	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
 	 * to remove objects, whose reuse must be delayed.
-- 
2.30.1 (Apple Git-130)

