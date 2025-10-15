Return-Path: <bpf+bounces-71005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A90BDEF6F
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC1C19A1584
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 14:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A80259C9F;
	Wed, 15 Oct 2025 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX+JnIV5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F5E25CC74
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537888; cv=none; b=YIhvIUsta/T5fyAUeswFxT59fNG2RL3m+cc5HRxYgSzkk3wa3id46CHY4kU2gmZul8AhoDt0z1wWRQ7HS9SixA4cI476MjYIDqAy+owlO2G7BLPtkuta5CxZxqEpKyPWvozLqXet3h8LPCpbCazfAxnQR9Svghh+yZ6Z1MMEJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537888; c=relaxed/simple;
	bh=KluHk1QWZzn5NMc+VsC+MNBgvBYeQNDP8rGgjwP2v0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ja0Kc5FoNm2KVR5frYEC9TEhIKrFXAzCQ3TwGqazff7etR+AWELR5dsSHXP6jBaTTNGfb1skeGJA2OamA5CNcigvv8rqT9AFcYiVp8r2u/pSqFs2Bf6RL8XSBhUT5nqWvyxQDmY9GU6jmyhGCuH4sCo38fHXkvHLCcNJ7SA/DBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jX+JnIV5; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33292adb180so6397186a91.3
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760537885; x=1761142685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnem9WQoa9CrDKPFqRiLEj1JeBs2tMhwu9umKx+yfco=;
        b=jX+JnIV5GL0SE3y5tfD5skoaSosu6/cBMWqlGllqhw/tgO8dvEBy7xyclqP6r9TE4R
         /tQ7vJVtyOkCmn4vZj0Cu/DrJtY1sRH2zFJeOGlDDhX2LxZ5oJJe04neWEvuUnt3rr+P
         /3FuBGifhT0kPtk7H+GHrokCfnS6VAOiO1QVKI6BbkCz12kbQ0liP9n2n/mKW77tDoEy
         0koGJLi5tLHl2qekZTCCIQnnhFocuo0/cI/JUJuG9Fvws5C/5z7BtHUQqekn5cp20snx
         oYpLBgAtrpLe7NRj+PzqHdKE2ioGazp+541HGq/3PcY+3aR4F55wbYf3cjjCfk9DUs8K
         Hgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537885; x=1761142685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnem9WQoa9CrDKPFqRiLEj1JeBs2tMhwu9umKx+yfco=;
        b=VtBaaH/8Yt/Di/oGfQpqhOxDQ25QyF61+iQD9lUjxlDX8bhoBKuxmpoR4/sL1eiEvS
         PLtXYMQoWr7wk26JYjyCq6gogpgqd0X6zmVB2dL9+1q7IdDkt0xm8jxJxRaVs2IQ1kSj
         ukF0dX8JPgC9AiQFDeQI/h6UYfDpw8S9XjMNGnlH3vOj/ZhaE/BFmxnGDzAgxJMxtKH3
         nXnhIfzEf7bHONuKqa5r9xqovRXNhj/s7z5+hjFzR6ttul0z7DoCSrP4FiqQusmJnETm
         edvneJTKxa0M1YPZmdY4vZvrqcamRzmJde/yDA/2K9dFYgRGemfVed1nZ/koi315YycT
         Q0ig==
X-Gm-Message-State: AOJu0YysBa9QGSqSJ37clKFesHUjBpYOOu2PW/Ut8pqcVfMqQHDjmzpM
	33byxHtiNKrPfEWNQuvILBXMv4X+rzNmIa5/10dNWX2j/NJvToDMce0X
X-Gm-Gg: ASbGnct4elkp850/enPdF7byk+WhcDuXO9yaITki7D9dQTO5zpQy42fnWK1qGERkmjN
	nevcBld4VftS1OerVRE1PMjPwqC6ZXgXiJ4SDXAeTERm5psIqS6f463e0QoC8xuGZV8tH51dHHa
	da4/+Bdmxu1k+JzUAnaRnzLNGJUkYoz2xbWOuDHndPmFJ2Y1vQ8u+GrxNQoXHj6RSADVwF2Y7Ch
	J17Vi4yLM6foP9Q6d/aUoXy2CkXZHCu4QoqFqG2CpjCQjSfTUEOsazLtoZVbbEO82mHD0V8nNWm
	1MSTEJHL0iR2VLdNaC+SIsdjTchQWa1iQaSLb18HQk4gDVPC4vJ5/JXdvrUXLV9UXmj1wg0hRi2
	vXUtyODkXgnZ1K0FXSZmyjwvRG9LdsR3dBpShacT8BrKVUIuxYGAHvqcesuJK4BdJ+qrRMfun+b
	7yhWVfuA==
X-Google-Smtp-Source: AGHT+IH94/LKl7eMp9XLhTF4MNSw5y/puAoaithR0MMgu0BDg3idBsTz0DwsyFW6zRb6V4pYAII+Og==
X-Received: by 2002:a17:902:e54f:b0:28d:18d3:46bc with SMTP id d9443c01a7336-2902723d619mr412289645ad.19.1760537884479;
        Wed, 15 Oct 2025 07:18:04 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1b80:80c6:cd21:3ff9:2bca:36d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f32d6fsm199561445ad.96.2025.10.15.07.17.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Oct 2025 07:18:03 -0700 (PDT)
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
Subject: [RFC PATCH v10 mm-new 4/9] mm: thp: decouple THP allocation between swap and page fault paths
Date: Wed, 15 Oct 2025 22:17:11 +0800
Message-Id: <20251015141716.887-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251015141716.887-1-laoar.shao@gmail.com>
References: <20251015141716.887-1-laoar.shao@gmail.com>
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
index 5ecc95f35453..9e4088ae0a32 100644
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


