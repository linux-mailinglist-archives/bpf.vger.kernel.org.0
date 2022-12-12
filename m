Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA43564976B
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 01:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiLLAiE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 19:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiLLAiD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 19:38:03 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491092657
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:38:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so13888145pjp.1
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNKI7Uo9ceKwdJtylngktQ/nCvprH/we2VJP8jXRS4g=;
        b=P7L3A8LSQ6EuBchoo9o72G0HR9beI6ptksZv7pGabGWc21e5bYToqayU6KK7gpv+KW
         LNO60GB0maoylCFzxuy7ZqsXKuIBcgvGt+apx8Tmq/mfpL7XtcE8QC5AuyQB0bUSs4CV
         t+qTZt3ykBrEDsJ1dX7EGsQMucv4KFNDm9W2KRsa9nhIYqiyhZdcTkwfdZP9jue72YQF
         xGaOwfN8haEgmbtswwr6QpNh82Qg3XEOAMM94W24qrBtb/wUM72Uhhj+8XRzzxb1Zvkn
         tyjFOn5ZuO/uYxaYuu58vwbl3foO3tgwR9ZUZGqgmrQiON9ADCHjs8LsgoZ4WmuB+Zj+
         YhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNKI7Uo9ceKwdJtylngktQ/nCvprH/we2VJP8jXRS4g=;
        b=N5nrPCjKiXC5oy+cR6cgYhw5mdtUpWhGhKWwWEM+c8BRxVyn69wkBJEIxoXyvF1M0Z
         FCGEDlLqHvn5iL8TKXisuRXNhBBRUsMfVpvX9JrheupSMOpTXoJ91Iq3OIzcNVGrqHba
         RbAGPoZuKtqpVuPZdueWdZVvpMAP9tqYJ9NmM3ZVxEIDJxpy7AMxjInX01KckN/WsCS3
         sChJshCaPDKqPUCMiwGsc4LYrkihVkSkdRj38bTavRLiH9Sseyb1O0UhOTOOLSoSN6Ar
         iiXCqDnYPfQwYElqEdBDEFviKpZZO5x+UiIEpT1jUXtlR9ZNyTaF/C3uQD9eHxMQL40b
         zAwA==
X-Gm-Message-State: ANoB5pksRh35+5Epj2WbJE0CcoUr6EoGyMlM3XcN4f5Gb3/VXkgT0moU
        Q+nV4Onh64+KuXPIMTEVBGM=
X-Google-Smtp-Source: AA0mqf6gVkVR/BLhx3chzrF6SJRugCJ3u+HzeGV/gLvVMYMtlhxlpXYv9UYQhE7PhTOyWjPolnJ7Mw==
X-Received: by 2002:a17:902:7c8c:b0:185:4421:72ed with SMTP id y12-20020a1709027c8c00b00185442172edmr14327503pll.50.1670805481847;
        Sun, 11 Dec 2022 16:38:01 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7002:8c7:5400:4ff:fe3d:656a])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902e88900b00177fb862a87sm4895960plg.20.2022.12.11.16.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 16:38:01 -0800 (PST)
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
Subject: [RFC PATCH bpf-next 5/9] mm: Account active vm for page
Date:   Mon, 12 Dec 2022 00:37:07 +0000
Message-Id: <20221212003711.24977-6-laoar.shao@gmail.com>
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

Account active vm for page allocation and unaccount then page is freed.
We can reuse the slab_data in struct active_vm to store the information
of page allocation.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/page_ext.h |  1 +
 mm/active_vm.c           | 38 +++++++++++++++++++++++++++++++++++++-
 mm/active_vm.h           | 12 ++++++++++++
 mm/page_alloc.c          | 14 ++++++++++++++
 4 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 22be4582faae..5d02f939d5df 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/stacktrace.h>
 #include <linux/stackdepot.h>
+#include <linux/active_vm.h>
 
 struct pglist_data;
 struct page_ext_operations {
diff --git a/mm/active_vm.c b/mm/active_vm.c
index ee38047a4adc..a06987639e00 100644
--- a/mm/active_vm.c
+++ b/mm/active_vm.c
@@ -34,7 +34,10 @@ static void __init init_active_vm(void)
 }
 
 struct active_vm {
-	int *slab_data;     /* for slab */
+	union {
+		int *slab_data;     /* for slab */
+		unsigned long page_data;	/* for page */
+	}
 };
 
 struct page_ext_operations active_vm_ops = {
@@ -165,3 +168,36 @@ void active_vm_slab_sub(struct kmem_cache *s, struct slab *slab, void **p, int c
 	}
 	page_ext_put(page_ext);
 }
+
+void page_set_active_vm(struct page *page, unsigned int item, unsigned int order)
+{
+	struct page_ext *page_ext = page_ext_get(page);
+	struct active_vm *av;
+
+	if (unlikely(!page_ext))
+		return;
+
+	av = (void *)(page_ext) + active_vm_ops.offset;
+	WARN_ON_ONCE(av->page_data != 0);
+	av->page_data = item;
+	page_ext_put(page_ext);
+	active_vm_item_add(item, PAGE_SIZE << order);
+}
+
+void page_test_clear_active_vm(struct page *page, unsigned int order)
+{
+	struct page_ext *page_ext = page_ext_get(page);
+	struct active_vm *av;
+
+	if (unlikely(!page_ext))
+		return;
+
+	av = (void *)(page_ext) + active_vm_ops.offset;
+	if (av->page_data <= 0)
+		goto out;
+
+	active_vm_item_sub(av->page_data, PAGE_SIZE << order);
+	av->page_data = 0;
+out:
+	page_ext_put(page_ext);
+}
diff --git a/mm/active_vm.h b/mm/active_vm.h
index cf80b35412c5..1ff27b0b5dbe 100644
--- a/mm/active_vm.h
+++ b/mm/active_vm.h
@@ -10,6 +10,8 @@ extern struct page_ext_operations active_vm_ops;
 void active_vm_slab_add(struct kmem_cache *s, gfp_t flags, size_t size, void **p);
 void active_vm_slab_sub(struct kmem_cache *s, struct slab *slab, void **p, int cnt);
 void active_vm_slab_free(struct slab *slab);
+void page_set_active_vm(struct page *page, unsigned int item, unsigned int order);
+void page_test_clear_active_vm(struct page *page, unsigned int order);
 
 static inline int active_vm_item(void)
 {
@@ -33,6 +35,7 @@ static inline void active_vm_item_sub(int item, long delta)
 	WARN_ON_ONCE(item <= 0);
 	this_cpu_sub(active_vm_stats.stat[item - 1], delta);
 }
+
 #else /* CONFIG_ACTIVE_VM */
 static inline int active_vm_item(void)
 {
@@ -58,5 +61,14 @@ static inline void active_vm_slab_sub(struct kmem_cache *s, struct slab *slab, v
 static inline void active_vm_slab_free(struct slab *slab)
 {
 }
+
+static inline void page_set_active_vm(struct page *page, int item,
+									  unsigned int order)
+{
+}
+
+static inline void page_test_clear_active_vm(struct page *page, unsigned int order)
+{
+}
 #endif /* CONFIG_ACTIVE_VM */
 #endif /* __MM_ACTIVE_VM_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6e60657875d3..deac544e9050 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -76,6 +76,8 @@
 #include <linux/khugepaged.h>
 #include <linux/buffer_head.h>
 #include <linux/delayacct.h>
+#include <linux/page_ext.h>
+#include <linux/active_vm.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -83,6 +85,7 @@
 #include "shuffle.h"
 #include "page_reporting.h"
 #include "swap.h"
+#include "active_vm.h"
 
 /* Free Page Internal flags: for internal, non-pcp variants of free_pages(). */
 typedef int __bitwise fpi_t;
@@ -1449,6 +1452,10 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		page->mapping = NULL;
 	if (memcg_kmem_enabled() && PageMemcgKmem(page))
 		__memcg_kmem_uncharge_page(page, order);
+
+	if (active_vm_enabled())
+		page_test_clear_active_vm(page, order);
+
 	if (check_free && free_page_is_bad(page))
 		bad++;
 	if (bad)
@@ -5577,6 +5584,13 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 		page = NULL;
 	}
 
+	if (active_vm_enabled() && (gfp & __GFP_ACCOUNT) && page) {
+		int active_vm = active_vm_item();
+
+		if (active_vm > 0)
+			page_set_active_vm(page, active_vm, order);
+	}
+
 	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
 	kmsan_alloc_page(page, order, alloc_gfp);
 
-- 
2.30.1 (Apple Git-130)

