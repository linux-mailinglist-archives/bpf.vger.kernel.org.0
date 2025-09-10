Return-Path: <bpf+bounces-67973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09212B50BB1
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C80B1C63DF4
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78622594BD;
	Wed, 10 Sep 2025 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjZ/zjBJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992CA254B18;
	Wed, 10 Sep 2025 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472318; cv=none; b=UNyHSpiGTNLEyBTn0ANSBabcRrxqve5OFB/1ICL24rzWdfW7Ide/buOU7O2Nt6NFz94yESsTJcEV48hjcYuXWZtcyvFYrbihXAiOpb7fBb7ePXbQci4iWAQWXptVAYlzZKhEyd1U4O9MlsPpStTGaHwwOirdI76OPCnpJmsGQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472318; c=relaxed/simple;
	bh=pcFc2gUtQLDm00dLqUkZ8NCKAJRxcGiurxms4qqEw7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iA7lUv17yiOpgAuHXL8BQwJUXbwW65thhMEajxolA8JcscUISqM23GhO+zrUIMT7Ugw20+ZcMGbfHz/j3qlJf7ujQMkHB0bxJA2u24tFjsZf3Z69czKsMnTouwdYdZnAkeVP1UvDya3OhjB/XV0SShdnUnTtPVEBMtsOwPaZQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjZ/zjBJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32b7d165dc6so5694540a91.3;
        Tue, 09 Sep 2025 19:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472315; x=1758077115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhCL43VUSjorkOuOskO9Is7n7PplBlIp0Kbwah6VXOE=;
        b=EjZ/zjBJLFZVhGiVHg9P9O6vEBPpUGrwUd0EtvSWkhB5VAuWKO87BJO0CHfT9u0oqm
         +Nv4SI+qPP8ipCXzFUYmDLfpVz21CzB1cgHZDEcHwpZ6vL9F+407cyIjTZfhdSV3LNOO
         GZDQfOrTzegb9g6s1kQIacSNPKYWa/ojJN0mXfHIdI6bd1jltnnuH2JrMmIs/4vZQAOU
         EPp4dgaMqlHFMNupW8Qx0BNLiVnMxSohYjsmCiyo1v/iuaAEI4YQvAbj/xV2HpEU4s+S
         Ab3wB9JTn+Hhg1auSkcGfkN/1AchmUTOPK3W9H9ycNEr5LqtWENoCN3x66wJW2TXL5wo
         mtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472315; x=1758077115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhCL43VUSjorkOuOskO9Is7n7PplBlIp0Kbwah6VXOE=;
        b=XGVQWWFLsf1ews3Mr+XVguwG8igVcV8uoZ9YbxlJPU3mYPw6T18SJepthGY+cQYHFo
         KtLa7T6EQiKgmLnGOW/HZKgcK/zk+8hzOJrxJcn9C8lDF+2emV1UEFaGZgnwoqS2uB9p
         I6sM3VLWfHmM5emkp9m/sNeoteIh55HmAK1U/yNfZkzVXPQY4tnCTc054wyNQdvcHYpM
         AC5eRY92IhdVC4jEKR/0toq0ng4LhKrGhOxFGSqVcsPCUIcAOG2twbUjZolrQmP2rkED
         1snQgpdQidhtqWgG9aQJYa3Z9MV9CdfwFskk/UkICVIIWi4+TwJXM1T5wNfx5nP7RNJR
         hdOw==
X-Forwarded-Encrypted: i=1; AJvYcCVjApdhAE/Ay72ZOMf/mnSXZgbapfxWMRs+4+nE14d8r4uo9G7yFUDRraChyxOyv2dFRSXsOGk+V0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeNkFcgKPr2wtW5yEuNSjjlNJ3QQYkMunfnX9MchlI6GYYd0II
	WBbhEmsUuFeJ2Hc7MahpGNCcgLTTlqKRBZgvtTu0KdrhbvpecdVgrKza
X-Gm-Gg: ASbGncsdhfbBdF4Tqn4cHgWZ3mWva2w3N7hvBlEisRqfcX1aMGNmxSZvsjFp3LWwinK
	fZz9t2IHtpoFoEMDUej34u8Suw7zf1bb2wt0Ed7Jals73vNdkRKIiNtbpRyfF/YWuB1/mQ8Arsw
	zodwatcq1Te4UTxKHAHIw/Yc8U3X8nVhwqZH3Lfv3PVgujfgQ/EWE7YUyUCppCnJjLxFFgUHzHJ
	BuRaBqFNia3Mayg8XoSkFg+wTdCtZyYw4JzWE6dPUUGcQlW3lfbnNkGmJSPT/O2qtmsTbT22Q9s
	YRL8nnEo8t7VX+wATLmRcHc8dmnYtU9EzVi+2bZHeHcDjD+xQbtWTe2tA8JEKc8qOG16MYRguXu
	PzehnEvbj7R0DzuCky7Sy+kOWkQRPZkYPmCgUiqpxWudF3dcPuom34NjghJn9i/R3Z2IQawSAN7
	OYIqc=
X-Google-Smtp-Source: AGHT+IHVMJs3gjlx25QtzwLeozXSFxDxX3vomXFV/6WkSK5g41a+qiePUUHhw5pn9woB4S9xqmZy2A==
X-Received: by 2002:a17:90b:350b:b0:32b:9d3c:13c4 with SMTP id 98e67ed59e1d1-32d43f8ea76mr19311149a91.24.1757472314798;
        Tue, 09 Sep 2025 19:45:14 -0700 (PDT)
Received: from localhost.localdomain ([101.82.183.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb314bcesm635831a91.12.2025.09.09.19.45.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Sep 2025 19:45:14 -0700 (PDT)
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
	shakeel.butt@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v7 mm-new 01/10] mm: thp: remove disabled task from khugepaged_mm_slot
Date: Wed, 10 Sep 2025 10:44:38 +0800
Message-Id: <20250910024447.64788-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250910024447.64788-1-laoar.shao@gmail.com>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since a task with MMF_DISABLE_THP_COMPLETELY cannot use THP, remove it from
the khugepaged_mm_slot to stop khugepaged from processing it.

After this change, the following semantic relationship always holds:

  MMF_VM_HUGEPAGE is set     == task is in khugepaged mm_slot
  MMF_VM_HUGEPAGE is not set == task is not in khugepaged mm_slot

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Lance Yang <ioworker0@gmail.com>
---
 include/linux/khugepaged.h |  1 +
 kernel/sys.c               |  6 ++++++
 mm/khugepaged.c            | 19 +++++++++----------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index eb1946a70cff..6cb9107f1006 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -19,6 +19,7 @@ extern void khugepaged_min_free_kbytes_update(void);
 extern bool current_is_khugepaged(void);
 extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 				   bool install_pmd);
+bool hugepage_pmd_enabled(void);
 
 static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
diff --git a/kernel/sys.c b/kernel/sys.c
index a46d9b75880b..a1c1e8007f2d 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
+#include <linux/khugepaged.h>
 #include <linux/utsname.h>
 #include <linux/mman.h>
 #include <linux/reboot.h>
@@ -2493,6 +2494,11 @@ static int prctl_set_thp_disable(bool thp_disable, unsigned long flags,
 		mm_flags_clear(MMF_DISABLE_THP_COMPLETELY, mm);
 		mm_flags_clear(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
 	}
+
+	if (!mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm) &&
+	    !mm_flags_test(MMF_VM_HUGEPAGE, mm) &&
+	    hugepage_pmd_enabled())
+		__khugepaged_enter(mm);
 	mmap_write_unlock(current->mm);
 	return 0;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4ec324a4c1fe..88ac482fb3a0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -413,7 +413,7 @@ static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
 		mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
 }
 
-static bool hugepage_pmd_enabled(void)
+bool hugepage_pmd_enabled(void)
 {
 	/*
 	 * We cover the anon, shmem and the file-backed case here; file-backed
@@ -445,6 +445,7 @@ void __khugepaged_enter(struct mm_struct *mm)
 
 	/* __khugepaged_exit() must not run from under us */
 	VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
+	WARN_ON_ONCE(mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm));
 	if (unlikely(mm_flags_test_and_set(MMF_VM_HUGEPAGE, mm)))
 		return;
 
@@ -472,7 +473,8 @@ void __khugepaged_enter(struct mm_struct *mm)
 void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  vm_flags_t vm_flags)
 {
-	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
+	if (!mm_flags_test(MMF_DISABLE_THP_COMPLETELY, vma->vm_mm) &&
+	    !mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
 	    hugepage_pmd_enabled()) {
 		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
 			__khugepaged_enter(vma->vm_mm);
@@ -1451,16 +1453,13 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
 
 	lockdep_assert_held(&khugepaged_mm_lock);
 
-	if (hpage_collapse_test_exit(mm)) {
+	if (hpage_collapse_test_exit_or_disable(mm)) {
 		/* free mm_slot */
 		hash_del(&slot->hash);
 		list_del(&slot->mm_node);
 
-		/*
-		 * Not strictly needed because the mm exited already.
-		 *
-		 * mm_flags_clear(MMF_VM_HUGEPAGE, mm);
-		 */
+		/* If the mm is disabled, this flag must be cleared. */
+		mm_flags_clear(MMF_VM_HUGEPAGE, mm);
 
 		/* khugepaged_mm_lock actually not necessary for the below */
 		mm_slot_free(mm_slot_cache, mm_slot);
@@ -2507,9 +2506,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 	VM_BUG_ON(khugepaged_scan.mm_slot != mm_slot);
 	/*
 	 * Release the current mm_slot if this mm is about to die, or
-	 * if we scanned all vmas of this mm.
+	 * if we scanned all vmas of this mm, or if this mm is disabled.
 	 */
-	if (hpage_collapse_test_exit(mm) || !vma) {
+	if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
 		/*
 		 * Make sure that if mm_users is reaching zero while
 		 * khugepaged runs here, khugepaged_exit will find
-- 
2.47.3


