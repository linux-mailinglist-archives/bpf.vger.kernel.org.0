Return-Path: <bpf+bounces-72219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C84C0A5C1
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 11:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F4854E3ADA
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA56425785E;
	Sun, 26 Oct 2025 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBBHCMXu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6A3BA3D
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761472948; cv=none; b=lLIle2Rm9FctE4mxqoD4hUXf9DZRStbTXxD50VzaMN9DqYkpjsO9fjG23x5mO4jC6sDmJvNp0kD9RDQLtiWgrzBxQsq/U5fi1YFQMKD7sRs8eUObpj8DzwX+0oJmkWJqRYXgt421pBxfdxWU3WJrgSUmM+Lv5MFcnzGFSyIXgxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761472948; c=relaxed/simple;
	bh=0xyTgKakH3C9h8/AC463iMeIxMyfjPW460wuhaCFBIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eGCmWdmtzGfW3pGr46aDExMO6+nBX4V0OrrU3EZpyIPY91nMeC2LtMwCPkXxLCPOXmBfOM3Q3yHKAyEzfL3NIRmCgqi1JJE+QHal4uO/fTGQwCEEXZsT9vMTGnWnk3dEb4lKLSy58hg9T4MpkvnaY2v72m0vYtbnYkn8qjpNjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBBHCMXu; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b593def09e3so2183306a12.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761472946; x=1762077746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwGSchT18d8qNcK6ftYzJtYNcHfYL/3EORdpk4nxKdU=;
        b=EBBHCMXuhhyhWPYPZH3oVKbcSuzc4gtCForS/pQkvoGcaxqOUEiD5COjv2mZJerZmm
         DUU6iRYNA1E3+ctx4sh3OTkEj6awo2/r6dwSURP+TyCel9L/sda75kahneljV3AOZlqf
         Y4byAtuB69K6+ykSU55HBt5RsFBgk0IRdPNXCu9YoJ6q+J7t656yN1PV+ira1v+OhVd4
         OJUWGJR+rHjplAOhKi9MssV51JJUm8oFYJQeG6brkQD+yQqYDjL9skmCukIYTP2ylNj0
         GS5B3axflqp4T9fOfc1SutxB3hn1kGCHJ5FyPFsIlTlQoDXUL20odFLwxQoSiDw3QrCo
         MuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761472946; x=1762077746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwGSchT18d8qNcK6ftYzJtYNcHfYL/3EORdpk4nxKdU=;
        b=i/obw0KdkTcPPMyproOa6h53Qv+d301E596m3b4p/JJVj/dZvfb+md/lcYzj7TxB5N
         lXgYyz7w66ME7/oA/+I0jFgrxrfG7IpyG9hPOkwDVX7ZmgXP2Rq+FFc4cWD+xm6OaF8x
         bCtXCZvRtWRaWy4wl+rNa8LNIHcHWKufpgjorHGuma1fek9gUz70FN+NDOlyqJZdy6n/
         bW/Yh9kTF8qSzbmKiyEBh8fF0uz+VtGZ7yU5F7a9VzDomsGGWI8PQHmztT8V32e0yR5S
         ojDwQQb6kZMicYX+CnvJTy2kBFaLBSYsd18lK7OC5O8zVVONk01Q6rTfGDYdYmK/eD5c
         Yjbw==
X-Forwarded-Encrypted: i=1; AJvYcCWTK2fmMz35HY9ve22WZ41UEknO9JaGs1CpJc8lFrUHusBn/lDu3wla5Hwj+XO1L/tqSxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCrlg/viTzzlTR4LTw6Smx+Me0v9UmBE2E4NBDSYn2gayMSl0
	k94cvoSO2xsRxfOKWYZxECghJCRJ87pqIL8+oZwUhaUUEpAWsOBtHnQd
X-Gm-Gg: ASbGncvqe/NwCjF7HSDF4pvgGaItoivi3faLzbiuriE5WCm/1IffVnNKRv+AacXNJIL
	oTdMADT5g6C/vN8M8dT/sJiLYS5JmGY7GE5a+vjxTaH7cpqJC2DrgfYgxi4BY+UEBK6zY1xLwTu
	YDwB01hvffqc4U38q8Dqtnoaf3kWp9mVeFrBrpy0Xu+qbW77edm2uapHH0QfVqlJp6wBZCkHhqi
	ocyePTkALKek/HIEbyDavVNaHpYk/y06gxVKg6jWA44aNRzz96pq5hU64RMAM7DWGqOrKg8tsoU
	C55QzoqQJ/U54dyTkh6wZtWn3OWi38lzrhz3YKE6VT/SfX4OjOpkIrUugZKON1epl1Cytet5Eag
	caDOX01iX8sQgHRKNk/43o75msMebY/RKeBnfIMTuq3WIo2VIzQhT7kUtnWNhvtsudev3L84bkc
	OlUK3tWKeNdDFMfwJ/OTV+6uak0gMctjx7h7E=
X-Google-Smtp-Source: AGHT+IGuJ84bU5ooLGoiNi0u5x/Ollkx2KP02O/Hek3R52H05y4BEGNapVukKfR1o3GdEw6baOphkA==
X-Received: by 2002:a17:903:4407:b0:27e:ef27:1e52 with SMTP id d9443c01a7336-290ca1218dfmr405991515ad.35.1761472946089;
        Sun, 26 Oct 2025 03:02:26 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1a84:d:452e:d344:ffb:662b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm4824966a91.5.2025.10.26.03.02.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 03:02:25 -0700 (PDT)
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
	Yafang Shao <laoar.shao@gmail.com>,
	Yang Shi <shy828301@gmail.com>
Subject: [PATCH v12 mm-new 01/10] mm: thp: remove vm_flags parameter from khugepaged_enter_vma()
Date: Sun, 26 Oct 2025 18:01:50 +0800
Message-Id: <20251026100159.6103-2-laoar.shao@gmail.com>
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

The khugepaged_enter_vma() function requires handling in two specific
scenarios:
1. New VMA creation
  When a new VMA is created (for anon vma, it is deferred to pagefault), if
  vma->vm_mm is not present in khugepaged_mm_slot, it must be added. In
  this case, khugepaged_enter_vma() is called after vma->vm_flags have been
  set, allowing direct use of the VMA's flags.
2. VMA flag modification
  When vma->vm_flags are modified (particularly when VM_HUGEPAGE is set),
  the system must recheck whether to add vma->vm_mm to khugepaged_mm_slot.
  Currently, khugepaged_enter_vma() is called before the flag update, so
  the call must be relocated to occur after vma->vm_flags have been set.

In the VMA merging path, khugepaged_enter_vma() is also called. For this
case, since VMA merging only occurs when the vm_flags of both VMAs are
identical (excluding special flags like VM_SOFTDIRTY), we can safely use
target->vm_flags instead. (It is worth noting that khugepaged_enter_vma()
can be removed from the VMA merging path because the VMA has already been
added in the two aforementioned cases. We will address this cleanup in a
separate patch.)

After this change, we can further remove vm_flags parameter from
thp_vma_allowable_order(). That will be handled in a followup patch.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/khugepaged.h | 10 ++++++----
 mm/huge_memory.c           |  2 +-
 mm/khugepaged.c            | 27 ++++++++++++++-------------
 mm/madvise.c               |  7 +++++++
 mm/vma.c                   |  6 +++---
 5 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 179ce716e769..b8291a9740b4 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -15,8 +15,8 @@ extern void khugepaged_destroy(void);
 extern int start_stop_khugepaged(void);
 extern void __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
-extern void khugepaged_enter_vma(struct vm_area_struct *vma,
-				 vm_flags_t vm_flags);
+extern void khugepaged_enter_vma(struct vm_area_struct *vma);
+extern void khugepaged_enter_mm(struct mm_struct *mm);
 extern void khugepaged_min_free_kbytes_update(void);
 extern bool current_is_khugepaged(void);
 extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
@@ -40,8 +40,10 @@ static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm
 static inline void khugepaged_exit(struct mm_struct *mm)
 {
 }
-static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
-					vm_flags_t vm_flags)
+static inline void khugepaged_enter_vma(struct vm_area_struct *vma)
+{
+}
+static inline void khugepaged_enter_mm(struct mm_struct *mm)
 {
 }
 static inline int collapse_pte_mapped_thp(struct mm_struct *mm,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7a0eedf5e3c8..bcbc1674f3d3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1476,7 +1476,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	ret = vmf_anon_prepare(vmf);
 	if (ret)
 		return ret;
-	khugepaged_enter_vma(vma, vma->vm_flags);
+	khugepaged_enter_vma(vma);
 
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm) &&
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8ed9f8e2d376..d517659d905f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -367,12 +367,6 @@ int hugepage_madvise(struct vm_area_struct *vma,
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
@@ -514,14 +508,21 @@ static unsigned long collapse_allowable_orders(struct vm_area_struct *vma,
 	return thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
 }
 
-void khugepaged_enter_vma(struct vm_area_struct *vma,
-			  vm_flags_t vm_flags)
+void khugepaged_enter_mm(struct mm_struct *mm)
 {
-	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
-	    hugepage_enabled()) {
-		if (collapse_allowable_orders(vma, vm_flags, true))
-			__khugepaged_enter(vma->vm_mm);
-	}
+	if (mm_flags_test(MMF_VM_HUGEPAGE, mm))
+		return;
+	if (!hugepage_enabled())
+		return;
+
+	__khugepaged_enter(mm);
+}
+
+void khugepaged_enter_vma(struct vm_area_struct *vma)
+{
+	if (!collapse_allowable_orders(vma, vma->vm_flags, true))
+		return;
+	khugepaged_enter_mm(vma->vm_mm);
 }
 
 void __khugepaged_exit(struct mm_struct *mm)
diff --git a/mm/madvise.c b/mm/madvise.c
index fb1c86e630b6..067d4c6d5c46 100644
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
+		khugepaged_enter_mm(madv_behavior->vma->vm_mm);
 out:
 	/*
 	 * madvise() returns EAGAIN if kernel resources, such as
diff --git a/mm/vma.c b/mm/vma.c
index 919d1fc63a52..519963e6f174 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -975,7 +975,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (err || commit_merge(vmg))
 		goto abort;
 
-	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
+	khugepaged_enter_vma(vmg->target);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
 
@@ -1095,7 +1095,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	 * following VMA if we have VMAs on both sides.
 	 */
 	if (vmg->target && !vma_expand(vmg)) {
-		khugepaged_enter_vma(vmg->target, vmg->vm_flags);
+		khugepaged_enter_vma(vmg->target);
 		vmg->state = VMA_MERGE_SUCCESS;
 		return vmg->target;
 	}
@@ -2506,7 +2506,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	 * call covers the non-merge case.
 	 */
 	if (!vma_is_anonymous(vma))
-		khugepaged_enter_vma(vma, map->vm_flags);
+		khugepaged_enter_vma(vma);
 	*vmap = vma;
 	return 0;
 
-- 
2.47.3


