Return-Path: <bpf+bounces-72220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 109B0C0A5C4
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 11:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A626F18A0AFD
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B6D257836;
	Sun, 26 Oct 2025 10:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoF0hkf+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC753BA3D
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761472958; cv=none; b=BJdryyWO5stzNSRU55afilHBpZqMMhvx4dl9B9zdole9eZ8zeDrFUgH5zOMKKMy10FbdNZzO/zlfw3q4IGhoyfR4XzSejhw4JWHMliUuasx6JIFWddeaXFCOEsOS2y6hfEtY2wx0tUSoAnvwEOEatKMbdG5l2zMqshDO0z1VTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761472958; c=relaxed/simple;
	bh=uP05oCSwmgkqCuJVUstHuz8JEsKWJRhfXo9pxha8M1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NqarGELnRNd+amZC1aAsXa0iDry49yLsfZfolV3IYriqVETJF80B7sjemWZyoj3OMX7IHKJT0Ie0IXlrvDwNhLpSrLQ3Iv3UcjLFDtgMQz4kgKkivX69x3YF1H0OTVA4biFoMw4qJ2+WjbSTc7mHIsa4EQPcfPv/4Nh94qW41J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoF0hkf+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6cf3174ca4so2430571a12.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761472956; x=1762077756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbVnVGaHqrFJdCRV6n+ajqt/xC8SgFU/Fr8dYnGkmL4=;
        b=GoF0hkf+GMPTFz+7PYhusrb5LAu9camI9C8vGi5Qv04qnonKmtRXXJLCh+/hC6w0X0
         NWhRw0pnc8XteLREvBnsaxSTg0BNcaM8TCD1LX79cKYcd6qCSyF/wxVgs97HPkV5+Pd+
         TH/vpqOAsVkVPNdmJy499zDWBhnX/W75h22l7qzk8/vtOm+tjs5a3F4Bde9mynmG4qCb
         /cpUSGXeJDmw/69VQNmHRaFcce4CA5Ll7Hl8X8GXle8bPnfjOC7HUSA/tfmQDfpLb5Da
         tSdnkIeN/l3FqWf/3SmV/eIO+AtVK70JBiDoXewiISy+iujfdMt8z3kCECKZhbrW8pZE
         mQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761472956; x=1762077756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbVnVGaHqrFJdCRV6n+ajqt/xC8SgFU/Fr8dYnGkmL4=;
        b=NXIwR3rVIEziqjOmk/lywHlB+hSb0xb2TpsUiH1tDu0PBvbzZk184q7tA2bI/lUNcz
         EYV64TXdPPGHCi0W9Z+Jl3rFFOpcSTQ5jr8JqAmoi2d0xGQrRWZ1uZVK8PYMA0t5VkeC
         NokoB8zkEKrNqFoSiGxUS48bFQr0xYKMLYiLpOsUVy/2W/jgc+zfEmLN+UQ8+m1kcFKj
         uTjv7TcpZ+Mpb4Nddxub859iJ5EXR9xLalyPaWr8B6PphM7yuGaVMQyQsxselx21Hxvm
         y4c3cQqBG/xiejT658v4SXv918r43CqmAAp6bG3lMUXanVSgkd2eUmSkQY+rm80yfanI
         Q7tg==
X-Forwarded-Encrypted: i=1; AJvYcCXf74AGcVofHwPmq7yTVk8bq2BnUuvYrdLHT0SI8cRHfDeUalSW5JxM33ebcCmxPdEYcvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlh+df0qlgO9QW05q5GloMBmZ/RcJz9FFalSGhTaaLmbLuokbb
	MRT5xLTHdiZKZ5TqMIvuoQ/AOwxEXOEzMkGygS2CSShSh0N/HM0RgLYW
X-Gm-Gg: ASbGncuVAgs3Ew9F91LOAn2yWaUUh3SAGG70Oyvr8q+UtrpvtPC1vWbzhnxvBso3DdC
	5eCRLCt0a5f+VQ0z8H6UeODOz8j9xxtYOf04neiX9vrIAHZNqA0jl6GfdwWaYiLs8+pcX92jxPb
	xVbIMXUhnGDoeaN56uDkCvoNdNqfZafPwIMe+tueMFaaJTCt5KBxc2eyZhyrZ4Yl1qz12Qc8dGE
	c0rJz9i5TwEFeae0ElDQt4HFP3fAbQFaeZum8sBolMzn/neEItZ8wKI7Zhwvy8eWruQbUgSOavW
	rf05bkegFgo2QasiPH0++vwYW9k/inxlmepHDRaR/hfxUs1yw8b6lMssZ4tWs/I2dbeKJM8jRBP
	PBYdPRobaqi58bhSGtkaIDpgzMk1Jmo2ZPeD1AYChW4jXm8jvwhSbrwr6o01SRx28N5xU5W7eTR
	Dwmv2rPGr4DO4TuzLEe2CdE7RRIHOmoIAzEJZk5oyAKAkF8g==
X-Google-Smtp-Source: AGHT+IEHiAf1xhYPZcQXWWYJYlUb8+VjgEsLLSD4AaSTvlXk3s9NkaWuatTzU3JvxHW3wsUmkhjPBA==
X-Received: by 2002:a17:903:2f8c:b0:293:97f:208f with SMTP id d9443c01a7336-293097f223bmr176009695ad.45.1761472955908;
        Sun, 26 Oct 2025 03:02:35 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1a84:d:452e:d344:ffb:662b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm4824966a91.5.2025.10.26.03.02.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 03:02:35 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	ziy@nvidia.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev,
	rdunlap@infradead.org,
	clm@meta.com,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v12 mm-new 02/10] mm: thp: remove vm_flags parameter from thp_vma_allowable_order()
Date: Sun, 26 Oct 2025 18:01:51 +0800
Message-Id: <20251026100159.6103-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251026100159.6103-1-laoar.shao@gmail.com>
References: <20251026100159.6103-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because all calls to thp_vma_allowable_order() pass vma->vm_flags as the
vma_flags argument, we can remove the parameter and have the function
access vma->vm_flags directly.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Usama Arif <usamaarif642@gmail.com>
---
 fs/proc/task_mmu.c      |  3 +--
 include/linux/huge_mm.h | 16 ++++++++--------
 mm/huge_memory.c        |  4 ++--
 mm/khugepaged.c         | 18 +++++++++---------
 mm/memory.c             | 11 +++++------
 mm/shmem.c              |  2 +-
 6 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fc35a0543f01..e713d1905750 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1369,8 +1369,7 @@ static int show_smap(struct seq_file *m, void *v)
 	__show_smap(m, &mss, false);
 
 	seq_printf(m, "THPeligible:    %8u\n",
-		   !!thp_vma_allowable_orders(vma, vma->vm_flags, TVA_SMAPS,
-					      THP_ORDERS_ALL));
+		   !!thp_vma_allowable_orders(vma, TVA_SMAPS, THP_ORDERS_ALL));
 
 	if (arch_pkeys_enabled())
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 4b2773235041..f73c72d58620 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -101,8 +101,8 @@ enum tva_type {
 	TVA_FORCED_COLLAPSE,	/* Forced collapse (e.g. MADV_COLLAPSE). */
 };
 
-#define thp_vma_allowable_order(vma, vm_flags, type, order) \
-	(!!thp_vma_allowable_orders(vma, vm_flags, type, BIT(order)))
+#define thp_vma_allowable_order(vma, type, order) \
+	(!!thp_vma_allowable_orders(vma, type, BIT(order)))
 
 #define split_folio(f) split_folio_to_list(f, NULL)
 
@@ -271,14 +271,12 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
 }
 
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
-					 vm_flags_t vm_flags,
 					 enum tva_type type,
 					 unsigned long orders);
 
 /**
  * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
  * @vma:  the vm area to check
- * @vm_flags: use these vm_flags instead of vma->vm_flags
  * @type: TVA type
  * @orders: bitfield of all orders to consider
  *
@@ -292,10 +290,11 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
  */
 static inline
 unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
-				       vm_flags_t vm_flags,
 				       enum tva_type type,
 				       unsigned long orders)
 {
+	vm_flags_t vm_flags = vma->vm_flags;
+
 	/*
 	 * Optimization to check if required orders are enabled early. Only
 	 * forced collapse ignores sysfs configs.
@@ -314,7 +313,7 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 			return 0;
 	}
 
-	return __thp_vma_allowable_orders(vma, vm_flags, type, orders);
+	return __thp_vma_allowable_orders(vma, type, orders);
 }
 
 struct thpsize {
@@ -334,8 +333,10 @@ struct thpsize {
  * through madvise or prctl.
  */
 static inline bool vma_thp_disabled(struct vm_area_struct *vma,
-		vm_flags_t vm_flags, bool forced_collapse)
+				    bool forced_collapse)
 {
+	vm_flags_t vm_flags = vma->vm_flags;
+
 	/* Are THPs disabled for this VMA? */
 	if (vm_flags & VM_NOHUGEPAGE)
 		return true;
@@ -564,7 +565,6 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
 }
 
 static inline unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
-					vm_flags_t vm_flags,
 					enum tva_type type,
 					unsigned long orders)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bcbc1674f3d3..db9a2a24d58c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -98,7 +98,6 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 }
 
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
-					 vm_flags_t vm_flags,
 					 enum tva_type type,
 					 unsigned long orders)
 {
@@ -106,6 +105,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	const bool in_pf = type == TVA_PAGEFAULT;
 	const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
 	unsigned long supported_orders;
+	vm_flags_t vm_flags = vma->vm_flags;
 
 	/* Check the intersection of requested and supported orders. */
 	if (vma_is_anonymous(vma))
@@ -122,7 +122,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	if (!vma->vm_mm)		/* vdso */
 		return 0;
 
-	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags, forced_collapse))
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma, forced_collapse))
 		return 0;
 
 	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d517659d905f..d70e1d4be3f2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -499,13 +499,13 @@ static unsigned int collapse_max_ptes_none(unsigned int order, bool full_scan)
 
 /* Check what orders are allowed based on the vma and collapse type */
 static unsigned long collapse_allowable_orders(struct vm_area_struct *vma,
-			vm_flags_t vm_flags, bool is_khugepaged)
+					       bool is_khugepaged)
 {
-	enum tva_type tva_flags = is_khugepaged ? TVA_KHUGEPAGED : TVA_FORCED_COLLAPSE;
+	enum tva_type tva_type = is_khugepaged ? TVA_KHUGEPAGED : TVA_FORCED_COLLAPSE;
 	unsigned long orders = is_khugepaged && vma_is_anonymous(vma) ?
 				THP_ORDERS_ALL_ANON : BIT(HPAGE_PMD_ORDER);
 
-	return thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
+	return thp_vma_allowable_orders(vma, tva_type, orders);
 }
 
 void khugepaged_enter_mm(struct mm_struct *mm)
@@ -520,7 +520,7 @@ void khugepaged_enter_mm(struct mm_struct *mm)
 
 void khugepaged_enter_vma(struct vm_area_struct *vma)
 {
-	if (!collapse_allowable_orders(vma, vma->vm_flags, true))
+	if (!collapse_allowable_orders(vma, TVA_KHUGEPAGED))
 		return;
 	khugepaged_enter_mm(vma->vm_mm);
 }
@@ -992,7 +992,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	/* Always check the PMD order to ensure its not shared by another VMA */
 	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
 		return SCAN_ADDRESS_RANGE;
-	if (!thp_vma_allowable_orders(vma, vma->vm_flags, type, BIT(order)))
+	if (!thp_vma_allowable_orders(vma, type, BIT(order)))
 		return SCAN_VMA_CHECK;
 	/*
 	 * Anon VMA expected, the address may be unmapped then
@@ -1508,7 +1508,7 @@ static int collapse_scan_pmd(struct mm_struct *mm,
 	memset(cc->node_load, 0, sizeof(cc->node_load));
 	nodes_clear(cc->alloc_nmask);
 
-	enabled_orders = collapse_allowable_orders(vma, vma->vm_flags, cc->is_khugepaged);
+	enabled_orders = collapse_allowable_orders(vma, cc->is_khugepaged);
 
 	/*
 	 * If PMD is the only enabled order, enforce max_ptes_none, otherwise
@@ -1777,7 +1777,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	 * and map it by a PMD, regardless of sysfs THP settings. As such, let's
 	 * analogously elide sysfs THP settings here and force collapse.
 	 */
-	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
+	if (!thp_vma_allowable_order(vma, TVA_FORCED_COLLAPSE, PMD_ORDER))
 		return SCAN_VMA_CHECK;
 
 	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
@@ -2719,7 +2719,7 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
 			progress++;
 			break;
 		}
-		if (!collapse_allowable_orders(vma, vma->vm_flags, true)) {
+		if (!collapse_allowable_orders(vma, true)) {
 skip:
 			progress++;
 			continue;
@@ -3025,7 +3025,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 	BUG_ON(vma->vm_start > start);
 	BUG_ON(vma->vm_end < end);
 
-	if (!collapse_allowable_orders(vma, vma->vm_flags, false))
+	if (!collapse_allowable_orders(vma, false))
 		return -EINVAL;
 
 	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
diff --git a/mm/memory.c b/mm/memory.c
index 618534b4963c..7b52068372d8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4558,7 +4558,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
 	 * and suitable for swapping THP.
 	 */
-	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
+	orders = thp_vma_allowable_orders(vma, TVA_PAGEFAULT,
 					  BIT(PMD_ORDER) - 1);
 	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
 	orders = thp_swap_suitable_orders(swp_offset(entry),
@@ -5107,7 +5107,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	 * for this vma. Then filter out the orders that can't be allocated over
 	 * the faulting address and still be fully contained in the vma.
 	 */
-	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
+	orders = thp_vma_allowable_orders(vma, TVA_PAGEFAULT,
 					  BIT(PMD_ORDER) - 1);
 	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
 
@@ -5379,7 +5379,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	 * PMD mappings if THPs are disabled. As we already have a THP,
 	 * behave as if we are forcing a collapse.
 	 */
-	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags,
+	if (thp_disabled_by_hw() || vma_thp_disabled(vma,
 						     /* forced_collapse=*/ true))
 		return ret;
 
@@ -6289,7 +6289,6 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		.gfp_mask = __get_fault_gfp_mask(vma),
 	};
 	struct mm_struct *mm = vma->vm_mm;
-	vm_flags_t vm_flags = vma->vm_flags;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	vm_fault_t ret;
@@ -6304,7 +6303,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		return VM_FAULT_OOM;
 retry_pud:
 	if (pud_none(*vmf.pud) &&
-	    thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PUD_ORDER)) {
+	    thp_vma_allowable_order(vma, TVA_PAGEFAULT, PUD_ORDER)) {
 		ret = create_huge_pud(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
@@ -6338,7 +6337,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		goto retry_pud;
 
 	if (pmd_none(*vmf.pmd) &&
-	    thp_vma_allowable_order(vma, vm_flags, TVA_PAGEFAULT, PMD_ORDER)) {
+	    thp_vma_allowable_order(vma, TVA_PAGEFAULT, PMD_ORDER)) {
 		ret = create_huge_pmd(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
diff --git a/mm/shmem.c b/mm/shmem.c
index 6580f3cd24bb..5882c37fa04e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1809,7 +1809,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	vm_flags_t vm_flags = vma ? vma->vm_flags : 0;
 	unsigned int global_orders;
 
-	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, vm_flags, shmem_huge_force)))
+	if (thp_disabled_by_hw() || (vma && vma_thp_disabled(vma, shmem_huge_force)))
 		return 0;
 
 	global_orders = shmem_huge_global_enabled(inode, index, write_end,
-- 
2.47.3


