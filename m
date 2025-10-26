Return-Path: <bpf+bounces-72223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A538DC0A5CD
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 11:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D6484E45A9
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9D27CB02;
	Sun, 26 Oct 2025 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2rr1M7H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532FB25291B
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761472985; cv=none; b=XxEU2fg+tC8n/3LDVtovI4V4f4vJhnp5pZPUiaRcPTtEnpz//TrGKk/qC6qfIoY7Os6cFqcRxoRx9Lv+OwgAPq0UNgC4HXVcI9xNCjzUjEh8S3abjnrHRCbkcfJSXyzgXhgWU6zW3hd694sWgYUsPSIbj0Ax0SWS5Lq/Q6BjmXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761472985; c=relaxed/simple;
	bh=A8AHhpIAh+oOymQSLSvqS2TuS8sm5z7QRGja9ZPh/70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8b56iBy1lkw8rU6CVj3C9lz/pFx4qYi5WLT/ha9LM0uUR8qwjsCJZfjXOXOlLk5SatuQ4w1vbOuyAsd0Zro3GbbCUg31KQhGxtCyRVWxcFAJstM8QQB/JwssF5ZdicyrPzX2SO3j/h9x4fS8YyrZW9N9lHMfTLvzIyCqPpdpA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2rr1M7H; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33bafd5d2adso3455473a91.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761472984; x=1762077784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qv3xbgzWscSD1bGLEjSMP2LBFninQO/a156OhJUr9XU=;
        b=W2rr1M7Hoz3ASG1e+jC6f3iM0P48krP/dN0/0n7i0Bd1tzSKN0NqMi3tH9yjrmnpsH
         KNKi0j5Bg9OKZ4OgNlC/OqKQj/zl7azvTcSPmHLHnqnHCoSN+N/h4Ove3KHSnMKEnjwb
         ktk/6Mtizxb4Royd/bajfUkn2D9CYDTnDwP+FlyFAG7lmMgB64bStm2rSUkOlRBqPTcf
         0aGjjkaVlNWa2NolfHfKR1AFtlnihXXFZVv6yyA7uqtKiwNiVzDYlx1V6J8psBs3a7C5
         cVF7uDLFJchC6D8h2KHQSvKV0MOzn7PTqrGGIHZv4s+iRCfQQtVo9kKfE58NRvozGvw6
         lEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761472984; x=1762077784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qv3xbgzWscSD1bGLEjSMP2LBFninQO/a156OhJUr9XU=;
        b=aM0oCAhRWDzAOfsoOeJPV+T37b9NQGJEH38adRXEWGQ015FjXrp+6cYFnFL+9RJ1CO
         GEkNJeKJcT7x1YK3YoMeRQlMKNcwKs1CoqU/qp1wcLZAdNnnJxqGyfJozCJBnbHgOtRn
         TT3DdC6Yh5MeTumhnQrHELHFTWEAC2dMKkcQ2MjvsooVUqXD6EeyYoCGRwGY6arT2amY
         qtDBCHpo/Pp1+3iiChL15GOIHlCJhWBp0H0Oz7qTXh69ihz0AU4PdFAHAJuWOW0jF1Xk
         0mb+Y0LNo60FQLmzCsK3MWoYdXcc8KSOSEOGbEsEDxVkPcDWQvu1YnJrOuToH29Z36pI
         dt6g==
X-Forwarded-Encrypted: i=1; AJvYcCVJAYiw9xglhuQ6G6DkEQNPXEFKSzkE/C3ChRL9IwfE3Lu/BXN58+m6xIo82XgDOM+tlj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/wlLartF2Hr99WVftkoPnKmS+zhbrsrwyMtEinTPAFxxaG6K
	bLbWD9CTee1V/m3+KmFIfbtjKEVcx97R2lcjz7PsCGWI5xglb50kSo1r
X-Gm-Gg: ASbGnctxVNhxAXU5qWpHLiVkcv31hGmFoIOF3+kCqIvSH1ermoHcTiWa3jwjLXQSjOT
	I1lcQnTsxGsujtqG1fcC1Xp32OyOQ8qRcH9w9IdwmskmTVuzlfOWZCLrrj2zVDjXdc8lAqYdFYy
	3T+NtloFDSkdQNTWcecQ6m3mcP04kLulb3BXu6dEj1amPp3BnhB6uiMr2NXyZP8ZwID+QEhZOl8
	TLhB5x4SePHsN1E6S5gZtq75XbIDyTSlbbkOE550bVbau6agEEENd7ChfEHDgrt6gtGBEsTFiZp
	m508XRz43IZOoTCn3nNA1Ur/a1IyHrVuzlyA61gRtQLD80rqPAvjfFT87wlJyJoSATDKs351vFj
	3zDjB9/a6AIi8m9IaJl8UfCBNAjvixe+WrZMH4DvGx8A//7N2ib/+O6mqUL9WjEqtVv/5Wcp49F
	n9PHEWxXygzL6x3V0LsiYhd/h6UBjBu/lqjvo=
X-Google-Smtp-Source: AGHT+IHumIu4Yiorz3nhZEBFgPf6IDz83EuHAByQ4wLOjx+CQb65VNu5bzBy24T85rvogYoDnqvUKA==
X-Received: by 2002:a17:90b:1dc6:b0:339:a4ef:c8b1 with SMTP id 98e67ed59e1d1-33bcf8f7802mr42446552a91.22.1761472983515;
        Sun, 26 Oct 2025 03:03:03 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1a84:d:452e:d344:ffb:662b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm4824966a91.5.2025.10.26.03.02.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 03:03:03 -0700 (PDT)
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
Subject: [PATCH v12 mm-new 05/10] mm: thp: enable THP allocation exclusively through khugepaged
Date: Sun, 26 Oct 2025 18:01:54 +0800
Message-Id: <20251026100159.6103-6-laoar.shao@gmail.com>
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
index 0bfbb672a559..b675c9041c0f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1476,7 +1476,6 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	ret = vmf_anon_prepare(vmf);
 	if (ret)
 		return ret;
-	khugepaged_enter_vma(vma);
 
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm) &&
diff --git a/mm/memory.c b/mm/memory.c
index c6a766b271ef..3e2857b30f3b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6336,11 +6336,14 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
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


