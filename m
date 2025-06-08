Return-Path: <bpf+bounces-60004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD0AD1174
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 09:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F4216A088
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 07:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19C31F30A2;
	Sun,  8 Jun 2025 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyJnarX6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEBD1E573F
	for <bpf@vger.kernel.org>; Sun,  8 Jun 2025 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749368176; cv=none; b=vAyfV0TohlyJoz6Bpc+yNhGUBhsKhwF/KnjUWk5tIujN+ttk2XNFEJO99wy7F4GNQ9InRl0kzcx0u/9Be+WOtIg8THxkl74oQaq/YIfNvixiQ4U3vOYmN+DyW/SQbvcXkhVviUpwQG0y5eR/dgdpLoWlMdaYZTCMvdgiHRoZpys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749368176; c=relaxed/simple;
	bh=F/SWRFXb65fa6dzujgPNHqfOfvQldbWuYy0lsiwKcOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UbwWIxMOH4O+CG5+h4+X9adWYytIV+Ur2Y4ZcL4IRiohNIo62O6cpSh/UDFOcWNdrVN7zmCTXBFgXEUMDzBqBm7eY57TRm8D2RUN2kAxWuIz9Ol3libYvOCJ3VW6VGyg/4dVP1Qcg1eH9N26GV8BqMb0RMMdrM3tCWCTvQqPsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyJnarX6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-747fc77ba9eso2515195b3a.0
        for <bpf@vger.kernel.org>; Sun, 08 Jun 2025 00:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749368174; x=1749972974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhwlrZfS+jTJbx/HAziMlQRatrzHKyo8mG9zQKr4+zM=;
        b=jyJnarX6v68W1zxvKMDzep8SsWRovG69Wiuhs4j8KrcePTR1FjE8wBsLWKK2GomvKS
         dEc+6nPszJArISfmlt2DDA+Yd7DsYGyMlSMW1MiqWRyGVo4ympgJfaj5Ag772a5AChQy
         Rt2vcY7mBuRmBt3YiirYvUvqvt1c/kB0I5r93VMXoSFR1h3PNW8V7HfvWD+c4ADXzREg
         CdfeK/kr5zf6O8/bdHF549PwHAHv2/m5ZEbUBjrqHYtebLxp2t08PXamEOlOeRlAMIx6
         d41zSTefmE+Do9uidoEl9ef+qq7KW6NF7tgF/rQcIxAOz78vwC6TG+CQ0k9imzKT6GyP
         8+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749368174; x=1749972974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhwlrZfS+jTJbx/HAziMlQRatrzHKyo8mG9zQKr4+zM=;
        b=ENOOuGL2ftKJ6ZHDPQAcVoFzpVOtjV98G7TXlakyGQKBkYeM21wnUXgKAlkOsnIoWV
         n+VkQiB6XGItKfpOUCSYSUBnHtglt1IXLzHAcLcJrm1RTRhbMm2Z8SieiBXDvYSL4K4l
         5VjK8ih+txu/J6Hk6JQjvli++0+cv8Ogd992osCqVJk8qewaA7pMB19wX7SQGMMze+Zr
         NyGF0dRTaVxthNNpGsFO1+odPrSffNpnHm116pS8o//ywQ8I4ap/KXLcRl4fc7LtLavm
         eMskg1J+Gl2O6f4Ffyc8z8ZF22HBxK7gM8pfp0JA1tsomAH2dfhLrrBBIhgLnsAYfXDq
         5o7w==
X-Gm-Message-State: AOJu0Ywwy1oSCF1yVWBfQM2SB99a5Ao8/X1LRWlVfQIZgqqOD5s0N1bH
	7rvnxgG0mOQ2B2NSLT1z0cDnFR0uwezOZWXYaGlNqliAepKEg0udTyMs
X-Gm-Gg: ASbGncviv2EK62fkltjKK2buvhU34vmUlcUl4TM6eD960+f5DpGx1DRpjvTZyF4fEPo
	rPtkEbIcTEaYC1gGV2QYVj3OGeiYVd9oRNBiYExti1UduunWmRSApUJJnfsCocRObTw90JeUfrG
	/e+NBlQAKzEW0B0o0SPdQdSsBNG4NnK5LeO4KCi6f8ofGzmYrpp0RHdR/xe97Fm+U5IPS113qs8
	C9u47WPlfPZrG2r6Cpzx/kYaM0fbbKHuEEBD2oKwk2IWoy6RASrQRuo23QtsG8ZF7NtenC78W9t
	J+IjUMvi+9aPII84xevYZtbrW/aAgEMc0+PxHv2RF1/P2/wc1Do7z3hOj93zCy09CcFPmg+MZqo
	2Jgcv05KVeg==
X-Google-Smtp-Source: AGHT+IG33bUFFAFdYLo5NQBOCNp1GUuzSi0/KY61kgl3Off4HDAsj1TC5QGAugkzBjhoq8kp10T3zg==
X-Received: by 2002:a17:902:e892:b0:234:1163:ff99 with SMTP id d9443c01a7336-23601dbda63mr138307925ad.43.1749368174149;
        Sun, 08 Jun 2025 00:36:14 -0700 (PDT)
Received: from localhost.localdomain ([39.144.124.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236035069c3sm35968135ad.234.2025.06.08.00.36.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Jun 2025 00:36:13 -0700 (PDT)
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
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v3 3/5] mm, thp: add bpf thp hook to determine thp reclaimer
Date: Sun,  8 Jun 2025 15:35:14 +0800
Message-Id: <20250608073516.22415-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250608073516.22415-1-laoar.shao@gmail.com>
References: <20250608073516.22415-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new hook, bpf_thp_gfp_mask(), is introduced to determine whether memory
reclamation is being performed by the current task or by kswapd.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/huge_mm.h | 5 +++++
 mm/huge_memory.c        | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index db2eadd3f65b..6a40ebf25f5c 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -198,6 +198,11 @@ static inline int bpf_thp_allocator(unsigned long vm_flags,
 	return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
 }
 
+static inline gfp_t bpf_thp_gfp_mask(bool vma_madvised)
+{
+	return 0;
+}
+
 static inline int highest_order(unsigned long orders)
 {
 	return fls_long(orders) - 1;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d3e66136e41a..81c1711d13fa 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1280,6 +1280,11 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma)
 {
 	const bool vma_madvised = vma && (vma->vm_flags & VM_HUGEPAGE);
+	gfp_t gfp_mask;
+
+	gfp_mask = bpf_thp_gfp_mask(vma_madvised);
+	if (gfp_mask)
+		return gfp_mask;
 
 	/* Always do synchronous compaction */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
-- 
2.43.5


