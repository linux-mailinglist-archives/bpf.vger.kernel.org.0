Return-Path: <bpf+bounces-69816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4753CBA32B4
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 11:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B7318899C6
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 09:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D2229BD9C;
	Fri, 26 Sep 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkHWKu80"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1C29DB96
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879275; cv=none; b=W4bY3kwkbzBlHNuf01wO/lFF1SM8ngLlMlHDPXmAwWYXvLaVAAokE5Z42AjOhqLe5z69EZ3rbwxnWX/WB/7bPZmvJ1WW972u+tIYB2AuSgNAaqwOsZt/aVzm4jKUMdQ1aZBYeQG/bNUkr3Y0f8B7y30kJk10R7Dn7bbDRL1z2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879275; c=relaxed/simple;
	bh=G79GhmKfwmtyN9keftelYbHeQuJsfIzIt4OFiFUwKJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XeyXJH9i/vZtM6RJrpBElrntWfFQlOqHUn1v05A0f3Qc4E/OF6qCb9f8ZJAG19c9KrZkVYz1dwQ3uDVINQn0+KvEyH39H6kzKXx3Fxh9XNca+XCm6eGzNem+0M80aiQKZnWQcQsN8jJXshZa5R3m1jgBX7H1ZEvqH+VyH1nAuUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkHWKu80; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27c369f8986so19552305ad.3
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 02:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879273; x=1759484073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSK3xayS0nafPEeCs+qk2zDDE4HBGPMWnEY1k1aBfXw=;
        b=AkHWKu80T6YW8vrCbkrpBFtda+9rCwvb3mhCI4KNhy7DFXeryvcgRhApSzom69xkHw
         KqcJ0lAQWg6HWi4Kvhl2bfGbKwuqM+yMiXHsVTvixVcN1Tg5rBWFUvVIv1CZIeZxnbzw
         iku9uanBLdufuWfCmIfIS84AsRuolEq5rTiDXX/siHqbOWxe0HX+zE5kOlTyOoNED8q3
         aBsZ5TrEStgEVi8YmlGd9mLf7F3ufCdLONuc1Yhp63mo1UctZeRA6RM7WUeyHjqdqv8t
         ecHAZMzi2iWTI6h6G7a1bzF6mq+808qpVGDziGhReorIq1kJ706ZsGQewNdxPakyMq48
         fWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879273; x=1759484073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSK3xayS0nafPEeCs+qk2zDDE4HBGPMWnEY1k1aBfXw=;
        b=S10oDHKfZlxU4112SQXBce6fi5r/UvhfWQgsC4TegBkFF2OV1yz4TFKz9VOZy1e1iH
         0tcp3fqoyVfE26Np6yIZuZ1orwhGfdNwcdSRyZAA9sYizj/867JgMeSSRMaMV2Pe5Lyl
         zzjnLY8xVLKkxf12Pu3rzclxalLRu93FwK4I4Dd94rxCDR+aGL/nVJUvnBP7pK0qntVJ
         izCjLpIyNU27wAdjj4Ova/4j79lpBPhEuuAMSabizls3ekeArZpGHfwaIDH76kKti5o6
         qeHJFCwU+HdwMnpB+LIbvUIZjPuoRkCBPLKorbuWSIaC+o+h4zNpvBT4bj4HB01ZsOhI
         SeZQ==
X-Gm-Message-State: AOJu0YwN5GTLGJCU4Cf1EhjlHUjnYTxxXRGWEcYrR4wk/h/qkNuL16fg
	udtP4xWT7SjyamRY1+SLqjrLZ+GyaTneRvSj42SFAB8rzqYOfkVMbrDr
X-Gm-Gg: ASbGncvQ0Nq/5uMC6mDU9bgDHfd6p5HPp80/jKurXEKgCwa0b8b7bQ62PzLBzYyC4BL
	5D7njW4yYjRPa/RByY+I41LR6DsZ1tN8I5Fa0ioCHh7YkdzAnNDhApPx8Bfn+CxTWBGch0HUG7A
	ubP+HMcfvP51rFhzEuFDKKPxjpLRCLglKmSSu5vCtD9VxFm4LVQ2KI/+jB5oxZ044ep+XtH2SeR
	hFnBnoi4E2Mq5pNZ5GW1Co2dTFBY2GjRxDN55poDXp2WA9LH+xfLYOZQtna96K88KMEKpMOpdD3
	IEqFn+oQTPVww9ZrfkQl18gEEF/J7S26tPTcH49hc3Nr6ZsCL0tbLRM+qC93VPCuQ5ybkzMmRmY
	xCtWE7UW97aFBy2cSNww/+rN+i1IVeO8VzX/NsXrHRUHigWlhpPcsHh/CcMhCPRqlT8EnD3VJVC
	DnCl3WvJ8IKfit7E3GYrEa5G8=
X-Google-Smtp-Source: AGHT+IHJHzJfJKSauriL7OPkevf//sVckJLTHFgqvaZTWYLp0JaZgp87Bhu+TeYvdzgl9+yv9HKXcQ==
X-Received: by 2002:a17:903:faf:b0:27e:f201:ec94 with SMTP id d9443c01a7336-27ef201f0bcmr18530145ad.18.1758879273495;
        Fri, 26 Sep 2025 02:34:33 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1c21:566:e1d1:c082:790c:7be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm49247475ad.25.2025.09.26.02.34.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:34:32 -0700 (PDT)
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
Subject: [PATCH v8 mm-new 05/12] mm: thp: decouple THP allocation between swap and page fault paths
Date: Fri, 26 Sep 2025 17:33:36 +0800
Message-Id: <20250926093343.1000-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250926093343.1000-1-laoar.shao@gmail.com>
References: <20250926093343.1000-1-laoar.shao@gmail.com>
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
Cc: Barry Song <21cnbao@gmail.com>
---
 include/linux/huge_mm.h | 3 ++-
 mm/huge_memory.c        | 2 +-
 mm/memory.c             | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fea94c059bed..bd30694f6a9c 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -97,9 +97,10 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 
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
index 1ac476fe6dc5..08372dfcb41a 100644
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
index cd04e4894725..58ea0f93f79e 100644
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


