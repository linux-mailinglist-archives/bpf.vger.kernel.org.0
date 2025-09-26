Return-Path: <bpf+bounces-69813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F2EBA3296
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 11:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71F33B70D4
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 09:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5D62BDC1D;
	Fri, 26 Sep 2025 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRoARfqg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D029B8DD
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879253; cv=none; b=LAWid9cp3kjj1z3ZLNkRq7yLMuKGwK1NusV4l4UNHuESLrZx9GXxmkv26bmjeDvQB5S+evU9mh7GdftakwGhWbdPvDSH4xWrVrryRuLgcGdtO/cE4dKhKILTPQlAqNom2sXhe7sH2p+XHm7pUn+A22zK4Fq7xpfhABARGG5Fdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879253; c=relaxed/simple;
	bh=WFo9LyAeEaA81byOzYYPzk59eC4wRmtclcHVMsp5+Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GmqX+MSWMLbWCqDb2KY3Jp5956+nDbDKIszKvdcn1K2J2cIXQx7ivvda5JQYshKChGb0IlG4GM7kjJA9AEkgnwDJmeTV9uQQr32PIUE2sg+8CH/7zu6u8WH7bB7MhjLCv+/5E9TiEEyAypA4tX9M3QCb8OjGcYwu8OW4rrT+N8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRoARfqg; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5565f0488bso1374090a12.2
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 02:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879251; x=1759484051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZMgKn0wKQ/oqMfqx0uxt+uUc993BOebahb39/puGXY=;
        b=gRoARfqgFRk9vKKDfTDHsOLPvYzTwN6afyYUYiCLeT1GbcywDbz/MPpntwXtHcENN/
         VYxy/1MuXNLOj9hCpHaF7ThKXVZ4nNMMBphsAIM7VqxXChxprufykq4jWiWuZD6jt5o2
         B7DABBqZ/ollBxGZuZcLBLxUgajWBFAjqM9UgiO/TpaIKFVj0xHIJ/Fre9Kkh8vJMEHq
         PpjupUm4OavdoR7/jqB59cQhLQG6OVn7tpEOz9C/4+EgJvCXorAuBDtL3eXpdArbRfh8
         hWyH8zKnfd/ySA16aZTWci+D3OtWSeMhVRnkBhUItH5xouE1pLKwJHdZnAVMgAl0xqEB
         wD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879251; x=1759484051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZMgKn0wKQ/oqMfqx0uxt+uUc993BOebahb39/puGXY=;
        b=mp65Tv6nTnVbMxRNOX0y0FgmLcnw4nujVhA9zPPWiQM2353DOZZJ7oZEnzi0faq02r
         DL2dw/WH1RD1Gd74B+uHfPjhw2zgs4Q31xgU9djmujGP5LNE9TnndsLL96MXCuIe0jqZ
         5tZRRfGmY49TEHzyvhziphC46v7LuHXntQeDExuM7Smrd+1+ddBLC0xinsrj7WdcWggx
         4cK0p6M4Pqqd9NTZCd11YqVNHjrKycawbk8p0BSpx672789LfF2nV0b/9mpLQUWYS9Q3
         794nlvNN2OocNAB/YPdem0/FN+Hn5gQ05s/xWH03aRsnsn6om1W9dp6ec/7wCo9UKuFl
         FsBw==
X-Gm-Message-State: AOJu0Yxvg9Q7sruSv/D/SQ8qSUFT6BMe8nxgUyR9CCtlfxJvN6amgoFJ
	jOxvWYAFqcSDPDePb85h5GJP7dedNSNPe8LSBEmxcwhTHXR7nfDBSgOy
X-Gm-Gg: ASbGncvF52shoPBcfjnf9xpBgNZHYI2uDOo33srB3h3T0UW9ApuSm9rySmNdUE4hREg
	XvwN3zIS/kHYurf9t59vjJWRkDRK9V11PKGKK8dtm61qX0aKVT2+4EffTeV6bpYHr/IIE6N4ocr
	I71umwsQVBtcbGbFuSZrzcTi6jxLtkS9kuFVDV2QIw00Z9zhNPDOXMxCf7q7IKTIGfJR2cz9Exe
	CwFadfX/4bGd9Wl7bSsDILw2GOW0wYKmEansTVolRpr6iedJ0bJ7U8enL2pMI7FoBvPTMPVu01N
	JrT5HnrtO1kOe7E0EUoUI568g65+QXBtkss56C06qZHA0sBohRs18BlhktW4MV8uw+zfHJfxaH2
	nirB27TxAjivhI9X5naxZ78uMyqicEQahYr2mCU8qODiQDh0QApy66jhBm35RYU/QaTNhXmZJqE
	7AjLVgeM6m9okv
X-Google-Smtp-Source: AGHT+IE8m06qLCI0fDHhVvccWM4X7VzASHCAmPvCMmQy9qW9LwLNoLvpBo8EtHPcpGLM28ZdNvKrWw==
X-Received: by 2002:a17:903:b06:b0:276:d3e:6844 with SMTP id d9443c01a7336-27ed4a7e7d9mr64071655ad.33.1758879251420;
        Fri, 26 Sep 2025 02:34:11 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1c21:566:e1d1:c082:790c:7be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm49247475ad.25.2025.09.26.02.34.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:34:10 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Yang Shi <shy828301@gmail.com>
Subject: [PATCH v8 mm-new 02/12] mm: thp: remove vm_flags parameter from khugepaged_enter_vma()
Date: Fri, 26 Sep 2025 17:33:33 +0800
Message-Id: <20250926093343.1000-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250926093343.1000-1-laoar.shao@gmail.com>
References: <20250926093343.1000-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The khugepaged_enter_vma() function requires handling in two specific
scenarios:
1. New VMA creation
  When a new VMA is created, if vma->vm_mm is not present in
  khugepaged_mm_slot, it must be added. In this case,
  khugepaged_enter_vma() is called after vma->vm_flags have been set,
  allowing direct use of the VMA's flags.
2. VMA flag modification
  When vma->vm_flags are modified (particularly when VM_HUGEPAGE is set),
  the system must recheck whether to add vma->vm_mm to khugepaged_mm_slot.
  Currently, khugepaged_enter_vma() is called before the flag update, so
  the call must be relocated to occur after vma->vm_flags have been set.

Additionally, khugepaged_enter_vma() is invoked in other contexts, such as
during VMA merging. However, these calls are unnecessary because the
existing VMA already ensures that vma->vm_mm is registered in
khugepaged_mm_slot. While removing these redundant calls represents a
potential optimization, that change should be addressed separately.
Because VMA merging only occurs when the vm_flags of both VMAs are
identical (excluding special flags like VM_SOFTDIRTY), we can safely use
target->vm_flags instead.

After this change, we can further remove vm_flags parameter from
thp_vma_allowable_order(). That will be handled in a followup patch.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 include/linux/khugepaged.h |  6 ++----
 mm/huge_memory.c           |  2 +-
 mm/khugepaged.c            | 11 ++---------
 mm/madvise.c               |  7 +++++++
 mm/vma.c                   |  6 +++---
 5 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index f14680cd9854..b30814d3d665 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -13,8 +13,7 @@ extern void khugepaged_destroy(void);
 extern int start_stop_khugepaged(void);
 extern void __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
-extern void khugepaged_enter_vma(struct vm_area_struct *vma,
-				 vm_flags_t vm_flags);
+extern void khugepaged_enter_vma(struct vm_area_struct *vma);
 extern void khugepaged_enter_mm(struct mm_struct *mm);
 extern void khugepaged_min_free_kbytes_update(void);
 extern bool current_is_khugepaged(void);
@@ -39,8 +38,7 @@ static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm
 static inline void khugepaged_exit(struct mm_struct *mm)
 {
 }
-static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
-					vm_flags_t vm_flags)
+static inline void khugepaged_enter_vma(struct vm_area_struct *vma)
 {
 }
 static inline void khugepaged_enter_mm(struct mm_struct *mm)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1b81680b4225..ac6601f30e65 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1346,7 +1346,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	ret = vmf_anon_prepare(vmf);
 	if (ret)
 		return ret;
-	khugepaged_enter_vma(vma, vma->vm_flags);
+	khugepaged_enter_vma(vma);
 
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm) &&
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f47ac8c19447..04121ae7d18d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -353,12 +353,6 @@ int hugepage_madvise(struct vm_area_struct *vma,
 #endif
 		*vm_flags &= ~VM_NOHUGEPAGE;
 		*vm_flags |= VM_HUGEPAGE;
-		/*
-		 * If the vma become good for khugepaged to scan,
-		 * register it here without waiting a page fault that
-		 * may not happen any time soon.
-		 */
-		khugepaged_enter_vma(vma, *vm_flags);
 		break;
 	case MADV_NOHUGEPAGE:
 		*vm_flags &= ~VM_HUGEPAGE;
@@ -467,10 +461,9 @@ void khugepaged_enter_mm(struct mm_struct *mm)
 	__khugepaged_enter(mm);
 }
 
-void khugepaged_enter_vma(struct vm_area_struct *vma,
-			  vm_flags_t vm_flags)
+void khugepaged_enter_vma(struct vm_area_struct *vma)
 {
-	if (!thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
+	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
 		return;
 
 	khugepaged_enter_mm(vma->vm_mm);
diff --git a/mm/madvise.c b/mm/madvise.c
index 35ed4ab0d7c5..ab8b5d47badb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1425,6 +1425,13 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
 	VM_WARN_ON_ONCE(madv_behavior->lock_mode != MADVISE_MMAP_WRITE_LOCK);
 
 	error = madvise_update_vma(new_flags, madv_behavior);
+	/*
+	 * If the vma become good for khugepaged to scan,
+	 * register it here without waiting a page fault that
+	 * may not happen any time soon.
+	 */
+	if (!error && new_flags & VM_HUGEPAGE)
+		khugepaged_enter_mm(vma->vm_mm);
 out:
 	/*
 	 * madvise() returns EAGAIN if kernel resources, such as
diff --git a/mm/vma.c b/mm/vma.c
index a1ec405bda25..6a548b0d64cd 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -973,7 +973,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (err || commit_merge(vmg))
 		goto abort;
 
-	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
+	khugepaged_enter_vma(vmg->target);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
 
@@ -1093,7 +1093,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	 * following VMA if we have VMAs on both sides.
 	 */
 	if (vmg->target && !vma_expand(vmg)) {
-		khugepaged_enter_vma(vmg->target, vmg->vm_flags);
+		khugepaged_enter_vma(vmg->target);
 		vmg->state = VMA_MERGE_SUCCESS;
 		return vmg->target;
 	}
@@ -2520,7 +2520,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	 * call covers the non-merge case.
 	 */
 	if (!vma_is_anonymous(vma))
-		khugepaged_enter_vma(vma, map->vm_flags);
+		khugepaged_enter_vma(vma);
 	*vmap = vma;
 	return 0;
 
-- 
2.47.3


