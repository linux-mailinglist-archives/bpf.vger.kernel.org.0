Return-Path: <bpf+bounces-56885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ED6AA0004
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 04:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3D53BFB69
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 02:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E780F29CB46;
	Tue, 29 Apr 2025 02:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr4HUOq2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE662FB2
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 02:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745894520; cv=none; b=eooqSGFMJveykkqAZpJ7ZUv+mvMK/snomAmvv33LI+XJXfqmq2kj/umb1UsO+C7COwFwcgbU8ZYD60jQwOg1AbYIPo0/jXeglIfcuDXowJuzPK0RW7V/QgsGFsfcekM782RSnuXC7dcUEj/rOB20w8X1q8yknZRNeiwJC9Q938k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745894520; c=relaxed/simple;
	bh=za58V2Pl6ftvGqrFY9n3E3nQv++wuW5DOIHUwF6t17o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KN+d0oQpyGJazeN0CSq7u5xD4oeko0fME9/4tTUDhlrg2CdAvDu/pb7azhewvclRgkWl0aJneoYda7KeujmJIuk4O/ffLq7QevFbgFXx7LHt190h7o552DUWK9xT+M3Gr7TnmTTZo9EhY+lkm7taoEvaxeWw2J/1oZPeYe35ZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vr4HUOq2; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b03bc416962so3887155a12.0
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 19:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745894518; x=1746499318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMlfBv7ehWo9ML1TAQYATjMzwAhnS+aQgMUHEMppoaQ=;
        b=Vr4HUOq2VplEL6HRjnuhn1ncxaOgseigCjdcw5MZXvzd8uF9di8OEXK6D2BS1qzw61
         hF/9HA3DXBUvjU4zglcLAu7zrtK2YFXesP809+mvJRiAOfptgKn4iK80EzK2gO+pntB1
         obU7/hIPyMHFhSlZbSRGJW6H1REVHpqJrJmQP326alZKpGFn5Pw7HoTdTfdpmHY6eTH4
         d7sBrSOC0YTz9n/6oVICCQt5nJ6TiGSd2OZJhviF7iCPLLCTF8vbos/j/6Lxq0WAl5kY
         14BUnv5A6UUEtE7QvkAdxfHItYHA4kU5/3TNKurOxWM7vkW73g/fZ+2i0kSHm0Ef/OM/
         LhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745894518; x=1746499318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMlfBv7ehWo9ML1TAQYATjMzwAhnS+aQgMUHEMppoaQ=;
        b=EsPqowR1ikvLnW/gylujOH+Ny6A2DDYL7AB6LiBBIiU1PF1u2G/SxQ0MIg9ljyanWX
         1WIP+L2/p5vML6enV9a9tk6MM2WaaH0wq0PBpvxNByq1Y7frMrgKsuUA6DMLoMzuPkQZ
         2ax906LpAtJQRYvxOW9kl4w1R4fxxp9jsEtYFfkknv2bH/qim8495JXucGS5Umlbnv4a
         bOPNSjtnV1E0k2YxHwAlfs7IWDKLVsS+J8Rf8qmPfQnUXkJnSmBY1cLaoZ8EWtCJrfyZ
         jP487TC50RTtUZzPHa/uTOrYt0RCZv39MzfbM0KvANmDlQRqgJ62OSqjVcwpZWXSAMpZ
         hM5A==
X-Gm-Message-State: AOJu0YxTRiJNQfLaXWlGmuMRpDW4s+fBc1pz1QT8+JuFm2WlJ6JigLDS
	hvXSAhLGWthZymcaeamArQKz6WTxntVxGbicc8LjZySOWIWkr8sJ4E6NrQjdDMs=
X-Gm-Gg: ASbGnctoLQa1IYuGyFFNbV67dK27Lv6zVtxUA5qNFAiF665xESei4Tt1gtDLfhbco9r
	XE8nGvsD59OppYwwBg3lwgXJJ3TseLDDhcwmoQ1DIgRQZmGgdswLgRcEJnGUZwF9HM02XFgLd7J
	HhVTE/SkieKspw00tITTuvojBIFfGiNqBzw7dTdblr9WVf/beKDZUTZTqfIa6fRzjdoDVAEqahD
	8J+RnZOC/CcbmmRNVGysPk78lj6vxL10IcVyeqUioWEoxOhTV7YeHJailz0LdFRO+REMjt/JGvy
	gxRkiHNiemuCjXobucQqEXoyqLMsKSlDUxj/C9/QFK26TuNG8VDv55CBzSh4sVRIpQ==
X-Google-Smtp-Source: AGHT+IFpEzdKNSmwx6Zsi9QNnOtir9k3DmQsdl9h6etgqoHsDxYp4w6fFx196GdsAjA+ex+vxbdYtQ==
X-Received: by 2002:a17:90b:2e03:b0:2fa:1a23:c01d with SMTP id 98e67ed59e1d1-30a0132e771mr16459097a91.21.1745894518020;
        Mon, 28 Apr 2025 19:41:58 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef097cb7sm9893211a91.22.2025.04.28.19.41.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Apr 2025 19:41:57 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 2/4] mm: pass VMA parameter to hugepage_global_{enabled,always}()
Date: Tue, 29 Apr 2025 10:41:37 +0800
Message-Id: <20250429024139.34365-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250429024139.34365-1-laoar.shao@gmail.com>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will use the new @vma parameter to determine whether THP can be used.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/huge_memory.c |  8 ++++----
 mm/internal.h    |  8 ++++++--
 mm/khugepaged.c  | 18 +++++++++---------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 39afa14af2f2..7a4a968c7874 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -176,8 +176,8 @@ static unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 		 * were already handled in thp_vma_allowable_orders().
 		 */
 		if (enforce_sysfs &&
-		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
-						    !hugepage_global_always())))
+		    (!hugepage_global_enabled(vma) || (!(vm_flags & VM_HUGEPAGE) &&
+						      !hugepage_global_always(vma))))
 			return 0;
 
 		/*
@@ -234,8 +234,8 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 
 		if (vm_flags & VM_HUGEPAGE)
 			mask |= READ_ONCE(huge_anon_orders_madvise);
-		if (hugepage_global_always() ||
-		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
+		if (hugepage_global_always(vma) ||
+		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled(vma)))
 			mask |= READ_ONCE(huge_anon_orders_inherit);
 
 		orders &= mask;
diff --git a/mm/internal.h b/mm/internal.h
index 462d85c2ba7b..aa698a11dd68 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1626,14 +1626,18 @@ static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
 #endif /* CONFIG_PT_RECLAIM */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline bool hugepage_global_enabled(void)
+/*
+ * Checks whether a given @vma can use THP. If @vma is NULL, the check is
+ * performed globally by khugepaged during a system-wide scan.
+ */
+static inline bool hugepage_global_enabled(struct vm_area_struct *vma)
 {
 	return transparent_hugepage_flags &
 			((1<<TRANSPARENT_HUGEPAGE_FLAG) |
 			(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG));
 }
 
-static inline bool hugepage_global_always(void)
+static inline bool hugepage_global_always(struct vm_area_struct *vma)
 {
 	return transparent_hugepage_flags &
 			(1<<TRANSPARENT_HUGEPAGE_FLAG);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cc945c6ab3bd..b85e36ddd7db 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -413,7 +413,7 @@ static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
 	       test_bit(MMF_DISABLE_THP, &mm->flags);
 }
 
-static bool hugepage_pmd_enabled(void)
+static bool hugepage_pmd_enabled(struct vm_area_struct *vma)
 {
 	/*
 	 * We cover the anon, shmem and the file-backed case here; file-backed
@@ -423,14 +423,14 @@ static bool hugepage_pmd_enabled(void)
 	 * except when the global shmem_huge is set to SHMEM_HUGE_DENY.
 	 */
 	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
-	    hugepage_global_enabled())
+	    hugepage_global_enabled(vma))
 		return true;
 	if (test_bit(PMD_ORDER, &huge_anon_orders_always))
 		return true;
 	if (test_bit(PMD_ORDER, &huge_anon_orders_madvise))
 		return true;
 	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
-	    hugepage_global_enabled())
+	    hugepage_global_enabled(vma))
 		return true;
 	if (IS_ENABLED(CONFIG_SHMEM) && shmem_hpage_pmd_enabled())
 		return true;
@@ -473,7 +473,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  unsigned long vm_flags)
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
-	    hugepage_pmd_enabled()) {
+	    hugepage_pmd_enabled(vma)) {
 		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
 					    PMD_ORDER))
 			__khugepaged_enter(vma->vm_mm);
@@ -2516,7 +2516,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 
 static int khugepaged_has_work(void)
 {
-	return !list_empty(&khugepaged_scan.mm_head) && hugepage_pmd_enabled();
+	return !list_empty(&khugepaged_scan.mm_head) && hugepage_pmd_enabled(NULL);
 }
 
 static int khugepaged_wait_event(void)
@@ -2589,7 +2589,7 @@ static void khugepaged_wait_work(void)
 		return;
 	}
 
-	if (hugepage_pmd_enabled())
+	if (hugepage_pmd_enabled(NULL))
 		wait_event_freezable(khugepaged_wait, khugepaged_wait_event());
 }
 
@@ -2620,7 +2620,7 @@ static void set_recommended_min_free_kbytes(void)
 	int nr_zones = 0;
 	unsigned long recommended_min;
 
-	if (!hugepage_pmd_enabled()) {
+	if (!hugepage_pmd_enabled(NULL)) {
 		calculate_min_free_kbytes();
 		goto update_wmarks;
 	}
@@ -2670,7 +2670,7 @@ int start_stop_khugepaged(void)
 	int err = 0;
 
 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_pmd_enabled()) {
+	if (hugepage_pmd_enabled(NULL)) {
 		if (!khugepaged_thread)
 			khugepaged_thread = kthread_run(khugepaged, NULL,
 							"khugepaged");
@@ -2696,7 +2696,7 @@ int start_stop_khugepaged(void)
 void khugepaged_min_free_kbytes_update(void)
 {
 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_pmd_enabled() && khugepaged_thread)
+	if (hugepage_pmd_enabled(NULL) && khugepaged_thread)
 		set_recommended_min_free_kbytes();
 	mutex_unlock(&khugepaged_mutex);
 }
-- 
2.43.5


