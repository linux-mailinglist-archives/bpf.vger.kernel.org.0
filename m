Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C8F550BF2
	for <lists+bpf@lfdr.de>; Sun, 19 Jun 2022 17:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiFSPuz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiFSPuy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 11:50:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698BFBCB3
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:53 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso10524623pjb.0
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nnh4T4SgR/gW+b4BUtX1sa65JkL4/iwCexxQ6cEBZbc=;
        b=lq1nH/bYPC7duqDClETgEfZ7OE6F+xkpRcqocCJ/GrXekZW96wX4D7QC6CL0SDMQdb
         +FtNyN0D5mFC/MpqRtckmw2IGiaIue5QZVxiT3LG2ig1yEV/rMfSIW30ZRqkBs50a5x3
         5zC+YcMCSjZjk0kZSWD3lqERf7kOjQg3EYRqTnOKVOmKB0IqOiR+27y5FXRnkPaOB+MY
         RFGpBS8GBE1JNuB7EdwrfI/7sNVIpZvMyWwzW4boOiU8pq4vCQ9fEIq+tm43dfAEhAKW
         EclyeeUGkwPoimSQxiZ1VUd5+ZHtzKleSs9So4zgUWqecwReWqilJIzbUGrD8vJzxaW6
         XXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nnh4T4SgR/gW+b4BUtX1sa65JkL4/iwCexxQ6cEBZbc=;
        b=ab2/v0ZcO5MYXwD0R3rCGwqKtozeKYrZR5WDCciSTypx4GWWPn++nJZCLMMsBYnUPu
         xXdolz2o6IRQezWnorJBNQdrzAOlXkdu+ZB7OJzYirHH0GO3h7qEhM34i//mN96rDVBM
         TviZ/8GdTdmNL70SqmHku+SOYzFZdxPOVAQSOpIBFC5aMtyl+XUgQxTyOiuHeHvt0h5P
         bCVcw0Yj29efmPQ4dKQdEsEgGFYMxwOUgyCDh4KF5Z57eGxOa168ABgot0Nzx7LklblN
         PWk5qiBcjHsK5evy+pZGb//ofB99WSIgjvJNYuPgJMC6OOJOT/LDk02KdLaRQk9TuYj5
         RdaA==
X-Gm-Message-State: AJIora/iw/hUT5qnMgO68nYKsxYevXmpsxwgzdcTMpx/oLWxa69XMYDR
        Gm2qKUTnIjFkr/XLCn3fNJY=
X-Google-Smtp-Source: AGRyM1u7nD+7X0UghJbd7/MLvgdOfAhOJLKxy2iGHckStcQblFZ3VTGbP3YeL6rPM8st9nF1xiP8zg==
X-Received: by 2002:a17:902:9041:b0:16a:aef:7b84 with SMTP id w1-20020a170902904100b0016a0aef7b84mr10956835plz.124.1655653852872;
        Sun, 19 Jun 2022 08:50:52 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:2b24:5400:4ff:fe09:b144])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709027e8a00b001690a7df347sm6381761pla.96.2022.06.19.08.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 08:50:52 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 05/10] mm: Add helper to recharge kmalloc'ed address
Date:   Sun, 19 Jun 2022 15:50:27 +0000
Message-Id: <20220619155032.32515-6-laoar.shao@gmail.com>
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

This patch introduces a helper to recharge the corresponding pages of a
given kmalloc'ed address. The recharge is divided into three steps,
  - pre charge to the new memcg
    To make sure once we uncharge from the old memcg, we can always charge
    to the new memcg succeesfully. If we can't pre charge to the new memcg,
    we won't allow it to be uncharged from the old memcg.
  - uncharge from the old memcg
    After pre charge to the new memcg, we can uncharge from the old memcg.
  - post charge to the new memcg
    Modify the counters of the new memcg.

Sometimes we may want to recharge many kmalloc'ed addresses to the same
memcg, in that case we should pre charge all these addresses first, then
do the uncharge and finnally do the post charge. But it may happens that
after succeesfully pre charge some address we fail to pre charge a new
address, then we have to cancel the finished pre charge, so charge err is
introduced for this purpose.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/slab.h |  17 ++++++
 mm/slab.c            |  85 +++++++++++++++++++++++++++++
 mm/slob.c            |   7 +++
 mm/slub.c            | 125 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 234 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0fefdf528e0d..18ab30aa8fe8 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -194,6 +194,23 @@ bool kmem_valid_obj(void *object);
 void kmem_dump_obj(void *object);
 #endif
 
+/*
+ * The recharge will be separated into three steps:
+ *	MEMCG_KMEM_PRE_CHARGE  : pre charge to the new memcg
+ *	MEMCG_KMEM_UNCHARGE    : uncharge from the old memcg
+ *	MEMCG_KMEM_POST_CHARGE : post charge to the new memcg
+ * and an error handler:
+ *	MEMCG_KMEM_CHARGE_ERR  : in pre charge state, we may succeed to
+ *	                         charge some objp's but fail to charge
+ *	                         a new one, then in this case we should
+ *	                         uncharge the already charged objp's.
+ */
+#define MEMCG_KMEM_PRE_CHARGE	0
+#define MEMCG_KMEM_UNCHARGE	1
+#define MEMCG_KMEM_POST_CHARGE	2
+#define MEMCG_KMEM_CHARGE_ERR	3
+bool krecharge(const void *objp, int step);
+
 /*
  * Some archs want to perform DMA into kmalloc caches and need a guaranteed
  * alignment larger than the alignment of a 64-bit integer.
diff --git a/mm/slab.c b/mm/slab.c
index f8cd00f4ba13..4795014edd30 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3798,6 +3798,91 @@ void kfree(const void *objp)
 }
 EXPORT_SYMBOL(kfree);
 
+bool krecharge(const void *objp, int step)
+{
+	void *object = (void *)objp;
+	struct obj_cgroup *objcg_old;
+	struct obj_cgroup *objcg_new;
+	struct obj_cgroup **objcgs;
+	struct kmem_cache *s;
+	struct slab *slab;
+	unsigned long flags;
+	unsigned int off;
+
+	WARN_ON(!in_task());
+
+	if (unlikely(ZERO_OR_NULL_PTR(objp)))
+		return true;
+
+	if (!memcg_kmem_enabled())
+		return true;
+
+	local_irq_save(flags);
+	s = virt_to_cache(objp);
+	if (!s)
+		goto out;
+
+	if (!(s->flags & SLAB_ACCOUNT))
+		goto out;
+
+	slab = virt_to_slab(object);
+	if (!slab)
+		goto out;
+
+	objcgs = slab_objcgs(slab);
+	if (!objcgs)
+		goto out;
+
+	off = obj_to_index(s, slab, object);
+	objcg_old = objcgs[off];
+	if (!objcg_old && step != MEMCG_KMEM_POST_CHARGE)
+		goto out;
+
+	/*
+	 *  The recharge can be separated into three steps,
+	 *  1. Pre charge to the new memcg
+	 *  2. Uncharge from the old memcg
+	 *  3. Charge to the new memcg
+	 */
+	switch (step) {
+	case MEMCG_KMEM_PRE_CHARGE:
+		/* Pre recharge */
+		objcg_new = get_obj_cgroup_from_current();
+		WARN_ON(!objcg_new);
+		if (obj_cgroup_charge(objcg_new, GFP_KERNEL, obj_full_size(s))) {
+			obj_cgroup_put(objcg_new);
+			local_irq_restore(flags);
+			return false;
+		}
+		break;
+	case MEMCG_KMEM_UNCHARGE:
+		/* Uncharge from the old memcg */
+		obj_cgroup_uncharge(objcg_old, obj_full_size(s));
+		objcgs[off] = NULL;
+		mod_objcg_state(objcg_old, slab_pgdat(slab), cache_vmstat_idx(s),
+				-obj_full_size(s));
+		obj_cgroup_put(objcg_old);
+		break;
+	case MEMCG_KMEM_POST_CHARGE:
+		/* Charge to the new memcg */
+		objcg_new = obj_cgroup_from_current();
+		objcgs[off] = objcg_new;
+		mod_objcg_state(objcg_new, slab_pgdat(slab), cache_vmstat_idx(s), obj_full_size(s));
+		break;
+	case MEMCG_KMEM_CHARGE_ERR:
+		objcg_new = obj_cgroup_from_current();
+		obj_cgroup_uncharge(objcg_new, obj_full_size(s));
+		obj_cgroup_put(objcg_new);
+		break;
+	}
+
+out:
+	local_irq_restore(flags);
+
+	return true;
+}
+EXPORT_SYMBOL(krecharge);
+
 /*
  * This initializes kmem_cache_node or resizes various caches for all nodes.
  */
diff --git a/mm/slob.c b/mm/slob.c
index f47811f09aca..6d68ad57b4a2 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -574,6 +574,13 @@ void kfree(const void *block)
 }
 EXPORT_SYMBOL(kfree);
 
+/* kmemcg is no supported for SLOB */
+bool krecharge(const void *block, int step)
+{
+	return true;
+}
+EXPORT_SYMBOL(krecharge);
+
 /* can't use ksize for kmem_cache_alloc memory, only kmalloc */
 size_t __ksize(const void *block)
 {
diff --git a/mm/slub.c b/mm/slub.c
index e5535020e0fd..ef6475ed6407 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4556,6 +4556,131 @@ void kfree(const void *x)
 }
 EXPORT_SYMBOL(kfree);
 
+bool krecharge(const void *x, int step)
+{
+	void *object = (void *)x;
+	struct obj_cgroup *objcg_old;
+	struct obj_cgroup *objcg_new;
+	struct obj_cgroup **objcgs;
+	struct kmem_cache *s;
+	struct folio *folio;
+	struct slab *slab;
+	unsigned int off;
+
+	WARN_ON(!in_task());
+
+	if (!memcg_kmem_enabled())
+		return true;
+
+	if (unlikely(ZERO_OR_NULL_PTR(x)))
+		return true;
+
+	folio = virt_to_folio(x);
+	if (unlikely(!folio_test_slab(folio))) {
+		unsigned int order = folio_order(folio);
+		struct page *page;
+
+		switch (step) {
+		case MEMCG_KMEM_PRE_CHARGE:
+			objcg_new = get_obj_cgroup_from_current();
+			WARN_ON(!objcg_new);
+			/* Try charge current memcg */
+			if (obj_cgroup_charge_pages(objcg_new, GFP_KERNEL,
+						    1 << order)) {
+				obj_cgroup_put(objcg_new);
+				return false;
+			}
+			break;
+		case MEMCG_KMEM_UNCHARGE:
+			/* Uncharge folio memcg */
+			objcg_old = __folio_objcg(folio);
+			page = folio_page(folio, 0);
+			WARN_ON(!objcg_old);
+			obj_cgroup_uncharge_pages(objcg_old, 1 << order);
+			mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
+						-(PAGE_SIZE << order));
+			page->memcg_data = 0;
+			obj_cgroup_put(objcg_old);
+			break;
+		case MEMCG_KMEM_POST_CHARGE:
+			/* Set current memcg to folio page */
+			objcg_new = obj_cgroup_from_current();
+			page = folio_page(folio, 0);
+			page->memcg_data = (unsigned long)objcg_new | MEMCG_DATA_KMEM;
+			mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B,
+						-(PAGE_SIZE << order));
+			break;
+		case MEMCG_KMEM_CHARGE_ERR:
+			objcg_new = obj_cgroup_from_current();
+			obj_cgroup_uncharge_pages(objcg_new, 1 << order);
+			obj_cgroup_put(objcg_new);
+			break;
+		}
+		return true;
+	}
+
+	slab = folio_slab(folio);
+	if (!slab)
+		return true;
+
+	s = slab->slab_cache;
+	if (!(s->flags & SLAB_ACCOUNT))
+		return true;
+
+	objcgs = slab_objcgs(slab);
+	if (!objcgs)
+		return true;
+	off = obj_to_index(s, slab, object);
+	objcg_old = objcgs[off];
+	/* In step MEMCG_KMEM_UNCHARGE, the objcg will set to NULL. */
+	if (!objcg_old && step != MEMCG_KMEM_POST_CHARGE)
+		return true;
+
+	/*
+	 *  The recharge can be separated into three steps,
+	 *  1. Pre charge to the new memcg
+	 *  2. Uncharge from the old memcg
+	 *  3. Charge to the new memcg
+	 */
+	switch (step) {
+	case MEMCG_KMEM_PRE_CHARGE:
+		/*
+		 * Before uncharge from the old memcg, we must pre charge the new memcg
+		 * first, to make sure it always succeed to recharge to the new memcg
+		 * after uncharge from the old memcg.
+		 */
+		objcg_new = get_obj_cgroup_from_current();
+		WARN_ON(!objcg_new);
+		if (obj_cgroup_charge(objcg_new, GFP_KERNEL, obj_full_size(s))) {
+			obj_cgroup_put(objcg_new);
+			return false;
+		}
+		break;
+	case MEMCG_KMEM_UNCHARGE:
+		/* Uncharge from old memcg */
+		obj_cgroup_uncharge(objcg_old, obj_full_size(s));
+		objcgs[off] = NULL;
+		mod_objcg_state(objcg_old, slab_pgdat(slab), cache_vmstat_idx(s),
+				-obj_full_size(s));
+		obj_cgroup_put(objcg_old);
+		break;
+	case MEMCG_KMEM_POST_CHARGE:
+		/* Charge to the new memcg */
+		objcg_new = obj_cgroup_from_current();
+		objcgs[off] = objcg_new;
+		mod_objcg_state(objcg_new, slab_pgdat(slab), cache_vmstat_idx(s), obj_full_size(s));
+		break;
+	case MEMCG_KMEM_CHARGE_ERR:
+		objcg_new = obj_cgroup_from_current();
+		obj_cgroup_uncharge(objcg_new, obj_full_size(s));
+		obj_cgroup_put(objcg_new);
+		break;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(krecharge);
+
 #define SHRINK_PROMOTE_MAX 32
 
 /*
-- 
2.17.1

