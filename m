Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA433550BF3
	for <lists+bpf@lfdr.de>; Sun, 19 Jun 2022 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiFSPu5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 11:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiFSPu4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 11:50:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2789BC94
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id bo5so8206190pfb.4
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 08:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQMzfPqgezzDzrRv8wh1613ZP98YLQGz+eOS2SGIRLM=;
        b=S2PD9ftCpBG9QGAr4mB7ADu83tpdlow4NteqA06BGj1jvJIQVzAOTvJlSYYGTshREd
         ytbN//cR3Cko4oTkb4pBv5/BrHknENhFGZctfFs0Qi1/gVnhHshITRo1VcjHMDlYkLn6
         nZ3e4fCEeR34zHBeLzGBpoEVYP7KOIBifF/zcGFh54GRLKBN9XKlyMZoWPEt5v7MQ7/t
         GdNhDv+p9RGJnaOAvYSAUiRKkdPlY4JTGSPMPzwRG3AzdhoyAe4NXxQ0Fmt8SEnI0ll2
         NYEpYVFgVOk6U7AMLGJXT5kvhZ9DtorIopbsQdHbxVGh0iEbAVqltUkvZBYgmFYdvaUz
         Ey2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQMzfPqgezzDzrRv8wh1613ZP98YLQGz+eOS2SGIRLM=;
        b=UUGnPyaPJ/NAyR4TZ2d6rsHrqjRfwppbnVYpjiHEP0rqVv7Uxc1ASPw0+hdkpKrCL8
         daUBCfPbbNyLSvMloP0Cf4jefkpgASRElzkCawXmdwWXel4K/T8gNU8jqJnBh9LCgFab
         HR6a3DlCmPFMCr5b02q146pjhWHokejpV0XgyE13zfzasXIwhJJENRDJMdWFeCdMmkRR
         bKv26HcT+N7Yh9NQhuw0k9LbdRmFRJSEqZ2eC8T1aMDR/jJGLSEBY4QwOTHIV/djVrKK
         pSTUdDRyKBFOZI14BW4zi8fGgIW3UNiiV7VAXxsVf0NPKluRPoc12qyi3evWtKRWtUyq
         xemg==
X-Gm-Message-State: AJIora8nvh+7MgDkl0FxTtwnOCHRI66vkw0xHszalNT/gBXg9kGlUKV1
        nyvn15hCLlkxibLn5vVAyPk=
X-Google-Smtp-Source: AGRyM1sefUlfO+kxoEWF8nnzpyg1oWx0iO3gGkduXWLQM7oyJzs209FUxi9aQRx8YGBdp74a/WvUWw==
X-Received: by 2002:a63:130f:0:b0:401:ce98:24eb with SMTP id i15-20020a63130f000000b00401ce9824ebmr18468553pgl.217.1655653855042;
        Sun, 19 Jun 2022 08:50:55 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:2b24:5400:4ff:fe09:b144])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709027e8a00b001690a7df347sm6381761pla.96.2022.06.19.08.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 08:50:54 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 06/10] mm: Add helper to recharge vmalloc'ed address
Date:   Sun, 19 Jun 2022 15:50:28 +0000
Message-Id: <20220619155032.32515-7-laoar.shao@gmail.com>
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

This patch introduces a helper to recharge the corresponding pages
of a given vmalloc'ed address. It is similar with how to recharge
a kmalloced'ed address.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/slab.h    |  1 +
 include/linux/vmalloc.h |  2 +
 mm/util.c               |  9 +++++
 mm/vmalloc.c            | 87 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 18ab30aa8fe8..e8fb0f6a3660 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -794,6 +794,7 @@ extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flag
 		      __alloc_size(3);
 extern void kvfree(const void *addr);
 extern void kvfree_sensitive(const void *addr, size_t len);
+bool kvrecharge(const void *addr, int step);
 
 unsigned int kmem_cache_size(struct kmem_cache *s);
 void __init kmem_cache_init_late(void);
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 096d48aa3437..37c6d0e7b8d5 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -162,6 +162,8 @@ extern void *vcalloc(size_t n, size_t size) __alloc_size(1, 2);
 
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
+bool vrecharge(const void *addr, int step);
+void vuncharge(const void *addr);
 
 extern void *vmap(struct page **pages, unsigned int count,
 			unsigned long flags, pgprot_t prot);
diff --git a/mm/util.c b/mm/util.c
index 0837570c9225..312c05e83132 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -656,6 +656,15 @@ void kvfree(const void *addr)
 }
 EXPORT_SYMBOL(kvfree);
 
+bool kvrecharge(const void *addr, int step)
+{
+	if (is_vmalloc_addr(addr))
+		return vrecharge(addr, step);
+
+	return krecharge(addr, step);
+}
+EXPORT_SYMBOL(kvrecharge);
+
 /**
  * kvfree_sensitive - Free a data object containing sensitive information.
  * @addr: address of the data object to be freed.
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index effd1ff6a4b4..7da6e429a45f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2745,6 +2745,93 @@ void vfree(const void *addr)
 }
 EXPORT_SYMBOL(vfree);
 
+bool vrecharge(const void *addr, int step)
+{
+	struct obj_cgroup *objcg_new;
+	unsigned int page_order;
+	struct vm_struct *area;
+	struct folio *folio;
+	int i;
+
+	WARN_ON(!in_task());
+
+	if (!addr)
+		return true;
+
+	area = find_vm_area(addr);
+	if (unlikely(!area))
+		return true;
+
+	page_order = vm_area_page_order(area);
+
+	switch (step) {
+	case MEMCG_KMEM_PRE_CHARGE:
+		for (i = 0; i < area->nr_pages; i += 1U << page_order) {
+			struct page *page = area->pages[i];
+
+			WARN_ON(!page);
+			objcg_new = get_obj_cgroup_from_current();
+			WARN_ON(!objcg_new);
+			if (obj_cgroup_charge_pages(objcg_new, GFP_KERNEL,
+						    1 << page_order))
+				goto out_pre;
+			cond_resched();
+		}
+		break;
+	case MEMCG_KMEM_UNCHARGE:
+		for (i = 0; i < area->nr_pages; i += 1U << page_order) {
+			struct page *page = area->pages[i];
+			struct obj_cgroup *objcg_old;
+
+			WARN_ON(!page);
+			folio = page_folio(page);
+			WARN_ON(!folio_memcg_kmem(folio));
+			objcg_old = __folio_objcg(folio);
+
+			obj_cgroup_uncharge_pages(objcg_old, 1 << page_order);
+			/* mod memcg from page */
+			mod_memcg_state(page_memcg(page), MEMCG_VMALLOC,
+					-(1U << page_order));
+			page->memcg_data = 0;
+			obj_cgroup_put(objcg_old);
+			cond_resched();
+		}
+		break;
+	case MEMCG_KMEM_POST_CHARGE:
+		objcg_new = obj_cgroup_from_current();
+		for (i = 0; i < area->nr_pages; i += 1U << page_order) {
+			struct page *page = area->pages[i];
+
+			page->memcg_data = (unsigned long)objcg_new | MEMCG_DATA_KMEM;
+			/* mod memcg from current */
+			mod_memcg_state(page_memcg(page), MEMCG_VMALLOC,
+					1U << page_order);
+
+		}
+		break;
+	case MEMCG_KMEM_CHARGE_ERR:
+		objcg_new = obj_cgroup_from_current();
+		for (i = 0; i < area->nr_pages; i += 1U << page_order) {
+			obj_cgroup_uncharge_pages(objcg_new, 1 << page_order);
+			obj_cgroup_put(objcg_new);
+			cond_resched();
+		}
+		break;
+	}
+
+	return true;
+
+out_pre:
+	for (; i > 0; i -= 1U << page_order) {
+		obj_cgroup_uncharge_pages(objcg_new, 1 << page_order);
+		obj_cgroup_put(objcg_new);
+		cond_resched();
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(vrecharge);
+
 /**
  * vunmap - release virtual mapping obtained by vmap()
  * @addr:   memory base address
-- 
2.17.1

