Return-Path: <bpf+bounces-71339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD35BEF28A
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 05:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92A13E42F2
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 03:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526242BD5B2;
	Mon, 20 Oct 2025 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBAIHLHl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA9E29D28A
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 03:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760929919; cv=none; b=HGGpbxlNoHrXrNzklYWN1jd8q/JDvI/RQY+24RApkMvZmrRptMd6YivfGSv5w2G31MIFukOfWfUVpxmeBIs1QzU6tIY82GY3CZa74Y+RgAej3WJr+a0TI3JyLiH5kG6MTrvhRe1uP3whgm+ttKDxlhgNdWchKWIjVFR3iIndgpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760929919; c=relaxed/simple;
	bh=JGxJ9EDtb9IldvkGfflzS2SW1jZFi/djNQ+FN8dfEWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQbeHYtEF5Yktx1hBFknE0v959ih9BJ8cHKzDlbrJ1WZ435dnzx1gnpmIRdYh4AeRJXZkUz7i8x8AzhTc/cYpBkPtRcPtQUkY/cjCYSUMFfgHLNtqg6jbXixum0GfTVc7Fp8U19ZdeFP66hA3bdutFForPUfHLLxF05QshGGKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBAIHLHl; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b58445361e8so3513976a12.0
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760929917; x=1761534717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYVUw+fPmZYdBu0dYV8qfxQD/UKizDlu37nXhCW5PwU=;
        b=ZBAIHLHlfEF/TOAw337lTpH3detd/t9rAmNnYSEr0ridSshdFYS5D95b/vuWcqfMoR
         Xmy8xo8GskvGVsgFBlSDyu4vZNiBmtOdc3QHvuqE+hXNZCdyHnxi14oOW+71K9EAmzC3
         ZcGHfThSWS270VtRyjO54OFNZY8wkA1D2VksSNIHA1MgjqGBycf4CLCaR0pfoJnDH7Sj
         MBXlLaaL547LjHqdCNRNFIcMojTUyAHr1rlOGfBnLg+Rx3H7p2FqrDXobiTcl5DbaHib
         6KSE7iLSpd83fR1O0fBdsY+dXz6UPLdmOVM7vcsnSc1Zd1FiULRhTbwADaPrlti6z/Pz
         uCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760929917; x=1761534717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYVUw+fPmZYdBu0dYV8qfxQD/UKizDlu37nXhCW5PwU=;
        b=gw8q26r6150Xcv3ATZzSfF7ZDpv2ruecC7V/jycVKIQaulXtb/zx+CXVyELKXsi1Jt
         Nf+p+dsYSK3F9ag3TBoD4NJfTjFydC1FLCv+lo0cTZCOjBKF7VF5M8FIAJu5CxOF4IPz
         9GUKyD8wXhrO4+FABHiv5GWSjuIS1fE4c+N3iqLw1iAnMJxMJFPfpDiW6Hlq+yuQiXi4
         A0n/zRpTDhcwP92EdkBrfQ14maxxD5bxEVV5GLY4oPJIAEOnbyIiOzfF7wCcLOesNLE2
         kTiouFkp4gENK45eSwJXvmzVIk0D/+Hujg0T6xqyg4e/Gw9AoIjWBAMeQyfVI+wk+fht
         2z8A==
X-Gm-Message-State: AOJu0Yxn4zwRQoNjyD6i2eXdMXu5FeK4qFs+gaHn1r0WuCiU/bAn12tG
	cQg7+fhyBvGsViwrpqS/vVJFn+1k+gNkn56cIHBTHJESchIfratWD76i
X-Gm-Gg: ASbGncuPmG9l6YSCo2aDfNgidEExV42E/6hMqSC/bNLS3x16QtTfShy+OpMMIRFwh36
	YxMHResAweMaatPM2Cih9ip1dkDpkH/UpW7eQSQkplvDEqtzCeLz3xXU2mlBnepKfhitmFV7aAL
	L695l3/7A7wsPG4rvDx7NMb1VBdBPJNRAar3OQON+IFTjbWCMTUh1owYF+Vx5/hKGjSoIx+rTWM
	G4yiqpJR9q6/uMiK235ImO7Bc0Sr9yE8kfiy+aPlj3odrOkyavh7Loqco1Dpdweq43R5gg1/I3B
	m7buzFPVNBz5R0Ja3RO+3sH7lJqjWHqGFHAclr+5kYCIzgQAudTUXF7PSZU/AA0im9RpZkclq3h
	GVJneMM0U6jsob1mPamb6MmGn4XHXlUy7FWRkQ3VxJRZNFIWUJOTZ9sMh3f/mfEY3zkbDM1gjdr
	FN1AR3/06apid9k0Cz+N5CIgi9KyjWRCxkwd1a5m/3
X-Google-Smtp-Source: AGHT+IF4qiKYYrriCit52NOBwzoUaKDxVA0F/Uj9jTkB91/QV6fGlsElE56OWu3htp/1+IovxbcUZw==
X-Received: by 2002:a17:902:f710:b0:271:9b0e:54ca with SMTP id d9443c01a7336-29091af4271mr204346835ad.13.1760929917575;
        Sun, 19 Oct 2025 20:11:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1da1:a41d:2120:6ebb:ce22:6a12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5794sm66007245ad.53.2025.10.19.20.11.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Oct 2025 20:11:57 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	david@redhat.com,
	ziy@nvidia.com,
	lorenzo.stoakes@oracle.com,
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
	rdunlap@infradead.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v11 mm-new 04/10] mm: thp: decouple THP allocation between swap and page fault paths
Date: Mon, 20 Oct 2025 11:10:54 +0800
Message-Id: <20251020031100.49917-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251020031100.49917-1-laoar.shao@gmail.com>
References: <20251020031100.49917-1-laoar.shao@gmail.com>
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
index 5c280ab0897d..56b360a08500 100644
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
index 2ad35e5d225e..e105604868a5 100644
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
index 8bb458de4fc0..7a242cb07d56 100644
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


