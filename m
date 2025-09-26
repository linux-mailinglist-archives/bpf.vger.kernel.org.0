Return-Path: <bpf+bounces-69817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4D1BA32BA
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 11:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C053B53A3
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373882BEFF1;
	Fri, 26 Sep 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrYUXZJs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3B2BD035
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879282; cv=none; b=QOBwlqhhoYfGKl+6EIPXjkwzPnUx7zCBPyf5udbqL/P1EczpQcvbW7fh8oH8W4hZWt5Jn0rJVmO1oW/QRN/8z7YRFf1X3I5grVvGyzgmkjCmmJ5R8Yds9Zeq0Ps8g9YmYJgR8nP4aB3bRxByA4XG1CkKO/UelUNoladIGFk/dPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879282; c=relaxed/simple;
	bh=Hma/ACUcxIvuWRcfKm0+Fz7g3KjXZp3i+HAKPNpNOmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sCgniHaGMwIgxsHuCUQGY4b86SRlQ/H746fgzJlpptx8otCczambltkXRZ12uRMZ2kVgHc6XJRMJ2H30SxlUW0gIKDHiJBingL6i7QBRSTxC74ssbTCdLTOu0ZumBTu1oaMCFeVytnTOTy/YmKkTJFK1ySECVsyOCmG4QdZpH1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrYUXZJs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so29856585ad.2
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879281; x=1759484081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcUAVjuBCwqD/o526Djm1QGIR4OCMDMMqLBu73ohlCo=;
        b=mrYUXZJs8rHPD7HirvQTBTLLXrSkbLGEe3s34QhuXZrUR5So0DuAvy3gLIl1Euq0g0
         CB+q9/AMLR+b6WtwAZN47ChdrepFj644hnSXZt5blK3BStiTovf9zQzih80++uRu/KU3
         5qgDsvUZumMVjT3g2use4odlE64/c3rFvWh0ymdNs0M4gk9lgu5/8wcgYYy39Snp6P1y
         FdOAsUocNCRhHvYiSKJsUJIAKKGnCaX7NVcw09rYZ0Sx2FBcTkMUv/ks3bYn74bfll6y
         vdQIsFVdrWIPjsxcY5xS9bU8P9dUFIIOnbadP1AkHCTbd77IXjengbXwMBl/kyuauXkv
         YIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879281; x=1759484081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcUAVjuBCwqD/o526Djm1QGIR4OCMDMMqLBu73ohlCo=;
        b=gUrUw1IVX424FrdZFuwH7g2/qGXnG35bB9p2rlIX1K1Nfffpvm6OBIO5PXMvKNMa/q
         Fxl2Y+yxM/hD7GqyA7Y8JcAjVx2eq9PToG4sYjwKf8SolIB4ta/GsgdUcfh6LtfUpY2P
         iBiyRSwMzu/rZn4gIyKPOG2JCVGL40IKabbrspZY5+n3WAMfhlP/0XiKAxreQVrXxVOj
         lD3cLJjMQpmCTz6eC/C+NWeM9SXIDjRt9g5Dh6m8z4cZ1+GZzJP83gEjUDiQWjHvKAGv
         RHhzhtbBHBtbRiyClfCF0rOAv/mUbSfPP8b1wfZPHPqHXA5xZsKV/ydRYxjL83DnAPKZ
         eSqg==
X-Gm-Message-State: AOJu0YyAKVlON3Lk/SDcOy5O34tjpae4uf6prd+2BIoa1fP2ot2JjA+y
	WdTdqiNMLxwwOF/FZfrZpy8AOq8SlzCFJD/oyAdnllaONRiHBye2A9K9
X-Gm-Gg: ASbGncuxa6UMgE2qY18FUhfH3JfKtZ4OAdhTbyEpocjPubFTQwEID6dPQuX/lL9VhOi
	+9d6t8zK2VFGvKDq63S9S1MsdZO2g9Tn41ltfGKeeI7xXkKm4RHjtNmAGf2teflwM9KMuGj++T1
	MkxJ0PxmO748/kpiL/QBQpQQUMCyTI+YGKIa5UsfwvFYkEeiHQTmYhrF4YyKDBHFYXBosR8bGq8
	EGhl1G2NaXquKAoidFgXujSm3OSLxOnNoRRbk4vOOse32cVmnlpbufoyo/fsj8lyIiC5f58/3ev
	OIDoSJN04QAU+SomvEl2vonapElfS0lPly9CREyl9AQrorm5LggoCi+CPAYRy+EjXbAMBu4Tfgk
	UJ14puy6MNxFhnm6dtmMz+UKgMxmi9reAfMDBtP6cP0Tu+wugmMbkk6A1UssSHIL/2+A0LllKUA
	qx8tsksIsLWIxW
X-Google-Smtp-Source: AGHT+IHpTOJHleE7ACdFvjLA52er0X3g6rm9mXYHGB20zbDxAkuQgTkRYnpRqU5bnQ67XgLmD1Xa5Q==
X-Received: by 2002:a17:903:19e6:b0:266:f01a:98c4 with SMTP id d9443c01a7336-27ed49dece8mr69854105ad.13.1758879280625;
        Fri, 26 Sep 2025 02:34:40 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1c21:566:e1d1:c082:790c:7be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm49247475ad.25.2025.09.26.02.34.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:34:40 -0700 (PDT)
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
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 mm-new 06/12] mm: thp: enable THP allocation exclusively through khugepaged
Date: Fri, 26 Sep 2025 17:33:37 +0800
Message-Id: <20250926093343.1000-7-laoar.shao@gmail.com>
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

khugepaged_enter_vma() ultimately invokes any attached BPF function with
the TVA_KHUGEPAGED flag set when determining whether or not to enable
khugepaged THP for a freshly faulted in VMA.

Currently, on fault, we invoke this in do_huge_pmd_anonymous_page(), as
invoked by create_huge_pmd() and only when we have already checked to
see if an allowable TVA_PAGEFAULT order is specified.

Since we might want to disallow THP on fault-in but allow it via
khugepaged, we move things around so we always attempt to enter
khugepaged upon fault.

This change is safe because:
- the checks for thp_vma_allowable_order(TVA_KHUGEPAGED) and
  thp_vma_allowable_order(TVA_PAGEFAULT) are functionally equivalent
- khugepaged operates at the MM level rather than per-VMA. The THP
  allocation might fail during page faults due to transient conditions
  (e.g., memory pressure), it is safe to add this MM to khugepaged for
  subsequent defragmentation.

While we could also extend prctl() to utilize this new policy, such a
change would require a uAPI modification to PR_SET_THP_DISABLE.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Lance Yang <lance.yang@linux.dev>
---
 mm/huge_memory.c |  1 -
 mm/memory.c      | 13 ++++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 08372dfcb41a..2b155a734c78 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1346,7 +1346,6 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	ret = vmf_anon_prepare(vmf);
 	if (ret)
 		return ret;
-	khugepaged_enter_vma(vma);
 
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm) &&
diff --git a/mm/memory.c b/mm/memory.c
index 58ea0f93f79e..64f91191ffff 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6327,11 +6327,14 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	if (pud_trans_unstable(vmf.pud))
 		goto retry_pud;
 
-	if (pmd_none(*vmf.pmd) &&
-	    thp_vma_allowable_order(vma, TVA_PAGEFAULT, PMD_ORDER)) {
-		ret = create_huge_pmd(&vmf);
-		if (!(ret & VM_FAULT_FALLBACK))
-			return ret;
+	if (pmd_none(*vmf.pmd)) {
+		if (vma_is_anonymous(vma))
+			khugepaged_enter_vma(vma);
+		if (thp_vma_allowable_order(vma, TVA_PAGEFAULT, PMD_ORDER)) {
+			ret = create_huge_pmd(&vmf);
+			if (!(ret & VM_FAULT_FALLBACK))
+				return ret;
+		}
 	} else {
 		vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
 
-- 
2.47.3


