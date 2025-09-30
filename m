Return-Path: <bpf+bounces-70000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04603BAB9C0
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 07:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8F5A4E22DD
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 05:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85A828151E;
	Tue, 30 Sep 2025 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lst4y7dB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931228000B
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211968; cv=none; b=Po8XX1rXS7Y5yX3UksC14ho31r0wcLamxTbibA3Zf0Uwd8pWMAcUFu54pucaKeaDdelHYuR6rn1AYxQNFifclrQGVAFBNegcoHPf9exPO19naXY/oJQNWbZus2XPs6IfWyleM7PH1VE70Hc8cI2wPcQLpK07ZNrE1htQN6lL6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211968; c=relaxed/simple;
	bh=4VkQKrS6FikymCfZ1+5puhT+uYYqYYXhQgE3Hi/wt0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbjsBILYdq13lz2BpkJocpALlciLTndfF5LRWoHUtjt5JHJgyKEbqtZrsmoXObFfbcwDm/3Y9jys9u8MGk/Ln5z0Ukg4x3ZCtFRzx8FiPEb45YDr1M/3Uw8W+ZU1I2C8IC5I4m8kA/7NbV/SDM2oaE+eRLwIt/6IOX9nE1ewSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lst4y7dB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2897522a1dfso19069865ad.1
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 22:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759211966; x=1759816766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj30sQDVRkZpxPh0yEwciSjpXqkKKqMqk3AWrRPDElU=;
        b=Lst4y7dBYV6F49SB2gq8lqFojT9lOwA0/hTZKSmEvuQxysLhsV87b7g4LJefLfElOB
         sfhPeAqdMCa1mim0Pfbs57Tk1l7c/VUSNt6X7NoAAPi5IIeqQXjfLk3w+ae4psFPhEGc
         7fEDbFZMOUoUE1TNywu5tJ3vHacVJLuQ/2K/2fLOgTY+fbx4zEr4mEiU3zie2+h6UPB7
         JdQk4E1JmNrQaFaRWjvljdbEhFHg/0cXIzzAuRfz3RVSka5W3bjfvHKfwzJPRiw3iXga
         gkcaWuah+0QBWekZGSJu9z11IsewWc1eWQ5f8tAfE7wjkVwoKxFwOjskdL4mAMqN1jlF
         djVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211966; x=1759816766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bj30sQDVRkZpxPh0yEwciSjpXqkKKqMqk3AWrRPDElU=;
        b=wAxLsAfuk5GjnTWlOxwDSjMUIJbe4OMVvR/Yng5t29FfvqXAFlGoGFf0lcyqmmlRrJ
         7qI+mkYkKarqSZA0RvuGLVvXwTh1re9hlGvS8eb7nwNGjV4/+6O40dCLTvcVCypXQ8JV
         /fa3MHGCdPFM9a8+Xe0yL8NABf1UZeybUfSxMnuJISQdcwn7fws1TESg+mPbVBkXqQoy
         IZ9ppnGApdgnLbWvUHndriy4gn6EqZZIRovRIkO8UDFPFJ6JvzYkUpgECGpOQE94tEyy
         IJVdIPPigQDiRK/UVxJntwUjPBfZ3JH0fMrYKrePISr9dWgAj2mEsLRCp/uwMArKwsEb
         TxVw==
X-Gm-Message-State: AOJu0YxfCcpSY2A99Zd7fVokbuIvux3d1qdIeTH8LWVJoJ0u5B2QQ6kQ
	au3sc7dE5aSsUMxwT7a64Sj2f8TUogs+crMOMKTf9XGiaBXvuaBrHyVx
X-Gm-Gg: ASbGncvcEroFVUdrVhvdaQC4AiS0wvSHJm2G082qdRCICcFLp0w7MAHQBByFvXX73rS
	+9OWVhTjS1phxy/TeQf1eiW4tZJD0SpaXaYA+DuWrq8CBSuw6WURjDaycoAqPDQ7PqdQjfIylNs
	HTFE7pmAM6L9zkZdp2Db/6x19Bu9qedkREUoG5xakBfYndhFMT1PuLsVGMfGxvql+KidPrX/Sip
	HGsNHsdlxwG+ua1IQiceHBrwVS3j3dYjSMHdX+EHkE8A9ythNU/42ymypQe0LSxMcDwmD5ir4J8
	/LA0ntH3MJIU8j/akgz8r0STZwrB/j0LKs3L/ZQmoK7lfpXppGFN4m2MdwB2HYS8wcYdA3LXvtH
	1LGNS7YZFS160uNa4iKKtI2K+xl2MbJU0Ql1Z9AEZiSikD9Ooq6jxKd9NLs2PXbXfQ9Jl0jf4zr
	8KvMij7DE+W/TX7neWpNsL5/8yQqpgSDw+WGkbLQ==
X-Google-Smtp-Source: AGHT+IEmo2u/7V63Fa+4aKjEO7zXO6V10zopA5XEUoYxrgliFdmiMUfOOebvAfkXMDqtGOOwYbddwQ==
X-Received: by 2002:a17:902:fc86:b0:269:8407:5ae3 with SMTP id d9443c01a7336-27ed4a60923mr250920865ad.54.1759211966029;
        Mon, 29 Sep 2025 22:59:26 -0700 (PDT)
Received: from localhost.localdomain ([61.171.228.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm148834065ad.9.2025.09.29.22.59.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 22:59:25 -0700 (PDT)
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
Subject: [PATCH v9 mm-new 04/11] mm: thp: decouple THP allocation between swap and page fault paths
Date: Tue, 30 Sep 2025 13:58:19 +0800
Message-Id: <20250930055826.9810-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250930055826.9810-1-laoar.shao@gmail.com>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
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
index 02055cc93bfe..9b9dfe646daa 100644
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


