Return-Path: <bpf+bounces-72222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF518C0A5CA
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 11:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67D23ABFC3
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C1C26ED56;
	Sun, 26 Oct 2025 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxqzz0/T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3176D25291B
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761472976; cv=none; b=fNjIToQOxwW0N1tKHGeXaOSlAOMbToD8JFzoXpzcZ+e7U8jIUh8Fk4VpCWuU3Yjx+j2UF+OqAGJpcyQaHxoSXsWbpLcBIQDm4yp1GN0V518SvzYnjoGsNW3qJ8a0GKx2+QgxuinbJHWfQufJs2bPYf2r3hxMsAn1O3CSbW4GwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761472976; c=relaxed/simple;
	bh=4YhZymquuTX13qHV4SQFr/XJ5ItM0RjEEkSEVQx60l8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmbW96AGAJ3dq1+LbhgSnQTXAXD0vM/7/8doX2SqyPYVzyC3+OnfnbjkQmZEkzPb6CTGVPtwzChC4MwyEztvCliXgMMPJ1d7NR+JawtYq48XcRUViKM3dofWef+Z453KuWxTa+F+eXHA0IV91yMmyNiDM1eCDCFwj6jlG+9rwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qxqzz0/T; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so1398793b3a.1
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761472974; x=1762077774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SChmisoCdyUpnp2jLZohE0/Y9AXNpvewUbNpv8hnnzw=;
        b=Qxqzz0/TdzfZehCxPGVQJ6Cke715hSv8QTgFhrv4duHP3OOLRUa++Oz7WpaBOl6IdT
         EAtIpImPD1DrdAwWt+onTW5D4uG983sRt2jtJAicVavBOs0tRyfGdBIrSVOE+vg6nj9T
         fTKDwDtap78Wy6pfw9M2NHFFG5SfzTWjBP9R/3D6trGQLr+WtgJIFQaxrsmbtiKIkpEg
         pIR+vukgPsRQvrFuYmy093RcgtcYir87nR+o1FCyCFyd+dtu1iZwT6MPPhb7Uw9jGUi+
         dtnPub33p+qvQiYDrMJUxOTxcBvIgOpJMyZcx0URfXftpS6QKcdA9/1qAsBmGVQlJQ/x
         GjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761472974; x=1762077774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SChmisoCdyUpnp2jLZohE0/Y9AXNpvewUbNpv8hnnzw=;
        b=iQTp4PEZqUIA8edSUCtFt1fVsfvcST22cSE4cARQekiLdc9qXXEsoj+UzBDZIR1NZU
         HX9OSNP7VkOjoZx+dBw/HxrdryIFmL215UFGMcexSGNdbcmxvQtgTslx/M1fpOQI5m8h
         x5Gj4DgEX7fb+CAohGy3xpF1y0iAHXuVhAMObEZK2gGndsvMszGUOJxib5nFYFijXXKN
         nAmdIOzcaWUYbfngBocDidxpXlgjgx+5Czo8ftPF22z4AdsuWuGfnGWEQy30PjThZEpa
         im6VlyM9yqNhBwhUrCBr9KlTDTlTjM76ZXW9o2tL/vUI3E7YreioLKPLqLFB0OQ2uKK4
         daUg==
X-Forwarded-Encrypted: i=1; AJvYcCVT7FEdLwP6o+e1tmcUTYiqQJtO0HfNok/KeLxt4eXJH97/6ziij06hEiQk1VbzA8xA7FY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF4HddeUhYDdJZ8NeWikv9WYgHlfeSi1WBpNFFpDSjmsdBXTar
	qj/TeBI0uOHQxuwPQGrTp6gbyVzAwzmY5Yxy39qA18HjujYRUJBED1yB
X-Gm-Gg: ASbGncsFy5tnd8gIwc/q2619OPzxgyPo7eSVtw4HRlV0DQExtgNX76F3z0Hi2iuap33
	sxkobkCatBkFGOp11bWz0XcoXF1hqK3fxJvlwZKfFBZ7mJGQZHbIW/ZYRiVc6l4g9ubNr9iFyv0
	HTWYivNDfpOloagsEA/wclpHGr6cRXBTEeKcu58sRbwbkG57iWNPyqcPdoVixXMucXE/93DRB7b
	2R6qxNJBAH+afrUg8BLvCK9cmGf/tPc4sxtH6EVMjo82UczENVoSntvcw5qcgApsr2Z0H3WF+ry
	LhcDrn8PI28I2PzgxZbrhbkfXdcI4LhBMzZGDECPjVhwow/rR9PVzxgMHdqobSwC9xRIrvgX95y
	JB04SoASDNq0vP+LYfiYyogUXhO8goAqU3nvFcfXqHGsr6//q96KIVaAVufGJ81t4xHwUcJ8IRt
	dIrtXI3bLtdhMnLGQk/kVuCOmAidZ8PkivoBUZ95tu1LNZDg==
X-Google-Smtp-Source: AGHT+IGASxBx06uCW6XVBswtwF80CA2QVkXW2h08zVRq2gdvMSBGMYG7U2JWmDZ1EeBq1W47b1EDrQ==
X-Received: by 2002:a05:6a20:6a07:b0:342:a7cd:9221 with SMTP id adf61e73a8af0-342a7cd95d9mr1256138637.20.1761472974316;
        Sun, 26 Oct 2025 03:02:54 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1a84:d:452e:d344:ffb:662b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm4824966a91.5.2025.10.26.03.02.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 03:02:53 -0700 (PDT)
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
Subject: [PATCH v12 mm-new 04/10] mm: thp: decouple THP allocation between swap and page fault paths
Date: Sun, 26 Oct 2025 18:01:53 +0800
Message-Id: <20251026100159.6103-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251026100159.6103-1-laoar.shao@gmail.com>
References: <20251026100159.6103-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The new BPF capability enables finer-grained THP policy decisions by
introducing separate handling for swap faults versus normal page faults.

As highlighted by Barry:

  We’ve observed that swapping in large folios can lead to more
  swap thrashing for some workloads- e.g. kernel build. Consequently,
  some workloads might prefer swapping in smaller folios than those
  allocated by alloc_anon_folio().

While prtcl() could potentially be extended to leverage this new policy,
doing so would require modifications to the uAPI.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Usama Arif <usamaarif642@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>
---
 include/linux/huge_mm.h | 3 ++-
 mm/huge_memory.c        | 2 +-
 mm/memory.c             | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 49050455f793..7867411b2a21 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -96,9 +96,10 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 
 enum tva_type {
 	TVA_SMAPS,		/* Exposing "THPeligible:" in smaps. */
-	TVA_PAGEFAULT,		/* Serving a page fault. */
+	TVA_PAGEFAULT,		/* Serving a non-swap page fault. */
 	TVA_KHUGEPAGED,		/* Khugepaged collapse. */
 	TVA_FORCED_COLLAPSE,	/* Forced collapse (e.g. MADV_COLLAPSE). */
+	TVA_SWAP_PAGEFAULT,	/* serving a swap page fault. */
 };
 
 #define thp_vma_allowable_order(vma, type, order) \
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index db9a2a24d58c..0bfbb672a559 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -102,7 +102,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long orders)
 {
 	const bool smaps = type == TVA_SMAPS;
-	const bool in_pf = type == TVA_PAGEFAULT;
+	const bool in_pf = (type == TVA_PAGEFAULT || type == TVA_SWAP_PAGEFAULT);
 	const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
 	unsigned long supported_orders;
 	vm_flags_t vm_flags = vma->vm_flags;
diff --git a/mm/memory.c b/mm/memory.c
index 7b52068372d8..c6a766b271ef 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4558,7 +4558,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
 	 * and suitable for swapping THP.
 	 */
-	orders = thp_vma_allowable_orders(vma, TVA_PAGEFAULT,
+	orders = thp_vma_allowable_orders(vma, TVA_SWAP_PAGEFAULT,
 					  BIT(PMD_ORDER) - 1);
 	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
 	orders = thp_swap_suitable_orders(swp_offset(entry),
-- 
2.47.3


