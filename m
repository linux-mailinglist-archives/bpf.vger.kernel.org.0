Return-Path: <bpf+bounces-70001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AADBAB9CA
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 08:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 409264E22F3
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 06:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA2D28506B;
	Tue, 30 Sep 2025 05:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYKPgaf2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE85280024
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211978; cv=none; b=pt5jT2MKQZBdPMdKTUICLJ/RIFZVUWs1GwMZ/KaTvP9+VJPMDw8eLvnv/XvvaTG1XgH4ihtzeKfQbhPslHkMag6UEx7exJaBdSkV5wvc8KLhy+tAoKl+63lONeUpgO9aUQgNDGqxoariXgAFTCMB52k3WMpj+QBhJLJhlDOIC5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211978; c=relaxed/simple;
	bh=PdHzrFnTfY/BX2nYC+VH4KXSooOxeg+vmzUyNWX3Omw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4Q+YW0GxlCaP+oqNyh6ThCfjfxQk6L4vGvAbPh2AfSDDtoaVZ4CqHnG598Pa56NYoMMEfws5ks+Anlos+W/LugFntweXbtBFhMoS17q6pihGdZOJ6t8dUIVUiOmfM23dgjMdknioqU8IAFOer/g8/IVwNneIg7IAIY8hZ5KuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYKPgaf2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27edcbbe7bfso59075075ad.0
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 22:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759211976; x=1759816776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tfnp2VgNI7X5NDB06OaZAZrurrAWQnxjDDxodnKF9g=;
        b=kYKPgaf2hBEEypXtFPz9ODbbwNAaKfrhTifLbPD/njZ1sgZk7+QkgHPfOxfUw/jmp9
         oxjW1Qv5aJ5zhXL6YTHzztPeWBLMGp6xvNtz8kDtALGI3YrzKUeVKLoVlW9pFWfFVTTL
         3TuCsb+6FGBOkPXHvu9hs/jXLVWy1+BqINpx33ua2bqLO8khlHNmmU0nt28coa5NrVeF
         Y9ciSUgrcx2WNa9usTbTc5sC+8MFE5MSADp5pyaxvqgk9GomMRuG1RAl8jXhqAEPFuug
         uZYVb/ILW+koYQxEWb2piECDxcVFFZVeQSOgrIHkqXkeg0po+z6bH3Ba1JlsH9xN2kJ7
         Hqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211976; x=1759816776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tfnp2VgNI7X5NDB06OaZAZrurrAWQnxjDDxodnKF9g=;
        b=vNsGXGLySJV7JQLAeZ0sCX6C/fHaLdANn8Ti+4P5dk+0sy7cp6J8mjBUOaitHfs1a9
         ha1a9DyvqG4TDV5fu2KZhYpEbcpSO80BUnVTmnnxBuU6YJWXaj4uA0wnu/QxskIyZuOQ
         vtzz6Q83FNADmsEUUU5dJ2A5eVnUCfzdCscW/ONFN4g7F5Yej5RtASUGHQ/WYiDWL0Kz
         pMHxje1aA1OvbXh1o/6OL+NatXTy2BSkr1vSdv7jV5S/GTDdmkOMKsjwVhvPGX8xYMMF
         huUr3R486aNk7B69dWkyF7WrNQSdwTh32gI1iM5ukza+GkMuuqgUd9XxUK80EfJ977Ow
         aKgw==
X-Gm-Message-State: AOJu0YxN6jYIKCCkBtX+R2Ayj2XeIV+eyrZQBd8lGqLdtnLWA9BHlUnq
	TQc0RHYe83zpfoZ4rT13107AxKIO9Z6/Aurn+vHu4mbP8U94L15HfHhM
X-Gm-Gg: ASbGncvRY7ZBErL+OPFYGMwnfbEuzglV48A7NXlU5fDcldMFMYTViSWNbT0SNnDugfG
	uOPBSQKYlostcAoxgHgPHoCMW/pY4r8eZLhBUy8WOkBbygiqt7Lgly09BYDVqMzIBNsMmFCq8Kd
	eC4eMSLxe3Gi9ZDgDJG8WoH6G1rAP2Kj0wXLU+o/DrHP6LtsqiHp0xZNgiYJ2KE+KXjxExfboCO
	txMQ59XGampv1J6EaX5S2aphtao5LkPw3r5dqBHFBryRQpnXAvH5XdGy2a5P55BgnNbbrfu+ENi
	Y2kCFH6dWOzBjQLYPkdfehxuXjCaR+Jh9r2eWyXZu5soFU3q0HmUUzaQGbO/tKjN3cUr4noNrzR
	n4owncbQAPRL2oRbefipA/BeQCNL16XD5o4DhWdOwJ9vvwP5oXvNtkh0xLHAMc9vW/EESU5CCfr
	2GSAmbWN50pWBCSHJu48p/iE74QJGWoAmRsMpjjg==
X-Google-Smtp-Source: AGHT+IHzK9X+Xf+bVu8Rrmbp78/kS7yuMf0wwgc2gHprT/HrnmCmly3PRVr5PnyZFdbWTIQHPwUiwA==
X-Received: by 2002:a17:903:3d0e:b0:250:bd52:4cdb with SMTP id d9443c01a7336-27ed4a3d9f5mr206668205ad.32.1759211976345;
        Mon, 29 Sep 2025 22:59:36 -0700 (PDT)
Received: from localhost.localdomain ([61.171.228.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm148834065ad.9.2025.09.29.22.59.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 22:59:35 -0700 (PDT)
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
	lance.yang@linux.dev,
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v9 mm-new 05/11] mm: thp: enable THP allocation exclusively through khugepaged
Date: Tue, 30 Sep 2025 13:58:20 +0800
Message-Id: <20250930055826.9810-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250930055826.9810-1-laoar.shao@gmail.com>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
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
- khugepaged operates at the MM level rather than per-VMA. The THP
  allocation might fail during page faults due to transient conditions
  (e.g., memory pressure), it is safe to add this MM to khugepaged for
  subsequent defragmentation.
- If __thp_vma_allowable_orders(TVA_PAGEFAULT) returns 0, then
  __thp_vma_allowable_orders(TVA_KHUGEPAGED) will also return 0.

While we could also extend prctl() to utilize this new policy, such a
change would require a uAPI modification to PR_SET_THP_DISABLE.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Lance Yang <lance.yang@linux.dev>
Cc: Usama Arif <usamaarif642@gmail.com>
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


