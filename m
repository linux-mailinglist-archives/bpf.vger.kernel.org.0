Return-Path: <bpf+bounces-71006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ADABDEF8A
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B154850A5
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE7026CE25;
	Wed, 15 Oct 2025 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jODZ0Lda"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFC134BA37
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537896; cv=none; b=Qf0x6xcC50W6YFnMPXrW0SjXwItzs8fjlGRvQpZ93N9fHmNqJIzKA5sTY2wDRp+9R48cQZp8HTmrGKWYY++w/Cl9wAxUbo8xS/nmz16CRFpomQyEdJh8DnYlSYT3wNNukfajigrIeTvSHrZi7Ezm0kWCIStk9MxjrjG7rOk/FNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537896; c=relaxed/simple;
	bh=PdHzrFnTfY/BX2nYC+VH4KXSooOxeg+vmzUyNWX3Omw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TXb8IiQiVfei+uuWWGUEd6atZYmeW3HLx5eIgX/lc7pDdn/7vmporVnuuzSNxkHSk9ddlkicxkOJwvISDHrXCXW9pXQDAsH7ktuvKXP+o2IFHojGK8KINFaVG7MVipcP0o+m63eghbWzbn8KJ/DCMgA3iS1tZbB44EUX9PJbLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jODZ0Lda; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so748584a12.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760537894; x=1761142694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tfnp2VgNI7X5NDB06OaZAZrurrAWQnxjDDxodnKF9g=;
        b=jODZ0LdaRXSqRmVsN3wl29fRoNLR5YwDPATJ1b/tmu4g7l8urBKSWHxYKpJiJFS9b3
         PlszC92aOlK+wlqG1SFa/Fcpm37CXqaUkTZrkB8fpzxaKqowDXslaJ0HssoP8Yfk/YNy
         lsYcQXJtOC2LXk6BMQt+u0uVSBJypBbfX+gaBoGXgfYdN34GW1fTu0uNgqVSWE2oci42
         wcZau7CMC9bFPzuCncX87W0P182DFOvkZaG/8Yjz2xFaRKnIsNBdyJKWDYgLw5SQda/Y
         IRIlujW9vBJtafcH5vrDm7UAGmrnPVIYm2xSNUFUkZRHwRiY2KOh3iteJmATm0SCQOuF
         yfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537894; x=1761142694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tfnp2VgNI7X5NDB06OaZAZrurrAWQnxjDDxodnKF9g=;
        b=mabrQv5uYhCDSxcFgGZ4v1Z6b1/TvVid/+zLOzkse2BC1KNoRNp06WXNxbQsNUYewl
         TqttBvC29nwtVCEKnLuz+4WW97VwFxLV1iKEz94dI+TyuXTHCpLm0tZeYHMcdGCrpPx9
         Cc7lyEtdTBiJtDJRGRkht+19iq4BCNzMs6p2OXorGi6xl5iZzwN1O2RXydgYJg84tW9+
         Sam+E57f9Q3XWqeXF6TjNRz4rUPHCF+TlxG2ZULDUsDcwj31TnTBcXhcyQ9QHCA6oF2c
         X/96w4AwH+LZcJbdemZLhEhzYnS/+IOfmmjb4t74UC/fwWYJjkTzydeweeNH96I7/CYy
         Nieg==
X-Gm-Message-State: AOJu0YzGe2i/x21v4EVv2jX6ktu8GjkwCVIsCGcd6g9yfPXzwq/9iag0
	RjVnVCR9Qh3zPKjJVg2LQoN5pe+VfWXquSwXJCrsYKKByYiBsKNcveLo
X-Gm-Gg: ASbGnctlMAHoAlj2cfa9v6/WC9cL3eZKPP6YHU9ZZW9cxv5EW30+IxX58mIvZhqcEZm
	Eeg7Son5YLuQXuG1PPiNAUYNcFCsel0dUseubfX+aFp2s6QpF3gAhXTr9ZmmehAJ5sSM3P2yksM
	Hd1agx/xfKqnXKuynyfrmmbmEgXJIhApvZqvTjfd6zY58oKU3GUSSVA3GYnEgaGKHPHc0QZsW9E
	X2hmzki26XUfgsZQZoAKQza0lAfb0g3UxW92iY9laFP/9OusjTK/cVSk41WajMrQjgF6vkR3eTw
	CrmvMlRI6H94TAQehu2xXtChYoqu6qUqxmRrwm32rBgDRHeHpSE6tCWjwXG5Qjb82Vdxgc0sJGO
	+WTtoYhx118NKC2dw7ydHWEmFjI+/H92BYURpI+ZDfBj0vhUBLFgcedXl2TS6LH1JQIFNt+u1Yj
	t00V9ZNxnLieKkxIWx
X-Google-Smtp-Source: AGHT+IGaH4Q7yuB3UefbX6fUnOF0Cq4qxYjfR/YqrSeLwExSFoNCC9hfKuz5SVL5H702WlYSyJC/fw==
X-Received: by 2002:a17:902:ecc2:b0:281:fd60:807d with SMTP id d9443c01a7336-290919d5389mr3536805ad.2.1760537894159;
        Wed, 15 Oct 2025 07:18:14 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1b80:80c6:cd21:3ff9:2bca:36d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f32d6fsm199561445ad.96.2025.10.15.07.18.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Oct 2025 07:18:12 -0700 (PDT)
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
Subject: [RFC PATCH v10 mm-new 5/9] mm: thp: enable THP allocation exclusively through khugepaged
Date: Wed, 15 Oct 2025 22:17:12 +0800
Message-Id: <20251015141716.887-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251015141716.887-1-laoar.shao@gmail.com>
References: <20251015141716.887-1-laoar.shao@gmail.com>
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


