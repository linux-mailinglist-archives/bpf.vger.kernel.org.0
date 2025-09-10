Return-Path: <bpf+bounces-67975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC76B50BBF
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A5A160F24
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE650233D7B;
	Wed, 10 Sep 2025 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE+jcp/b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF63FFD;
	Wed, 10 Sep 2025 02:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472336; cv=none; b=th3I7lMAj8SORNkcysPKvp2vmZiR0q2yatB5P20iYZpQa0WlXULVuyJvO8ASG8fbovhKygFJc1nsu34rDVpIdk4S+VCmLIo61Aj/uCGF34fVymCuBWpZz0EmSEWfHpOUqINMfxSRKkB9VOmXJHsz5q8CkPXkDHuXbrXMMp9Y7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472336; c=relaxed/simple;
	bh=yJtWsSQr0vr9Uuow2KDLDZcyK3wV7Td6qGCL5Mo+z4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJ7Lc0de5x2OBuE3ruC5UYC3+f3YpPLzlsLSSxh8fs3Ve7cTBFQajNdRX1gEyHPQi9xJkZov+yaydGLI96C7i7MwrtjRF3s2leWc2bt22oLEefbXTacJHSrA5oaNyrwft/8MXE3GjQMc+yXdQMl6o6Wd4PTpnE4xiDTuqg83eH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BE+jcp/b; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so3934272a12.2;
        Tue, 09 Sep 2025 19:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472334; x=1758077134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynOs6k0nDqBEUqYqBnSm01F3FVZyuHDqWUtbeZyhsAI=;
        b=BE+jcp/bzTCfwvF5tlePVihpMOENCqW3he/YnofOoEIU65Gd0Jsu+yuGoJStbEzQzj
         RSK4z79f4R6UpfUysIcqBg0cw+q0HUMVzpDZ3l9G+e7KgRtnobdQUJeUOzMOHahfUZac
         npmt0xZbc93WQZZJa+yPc5eLZG5rhVm01OPovtIlerSHSaPkWI96jecZfHhqRvO/9Tg+
         zxtRE8IUA7VHW9gzE3H7nDuTiSBLfJpIQ0TEFSB8eZn/yPGTVhQ8ejuGA3S2F/LvOyYs
         7sJNSQ+2VO4kS98c+vjtaH6Aq7LMEYr5Pq4M7r62851K63nPPg56Q6sF8SMpQz6O98Up
         oMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472334; x=1758077134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynOs6k0nDqBEUqYqBnSm01F3FVZyuHDqWUtbeZyhsAI=;
        b=nH+YhSIWXyFn+9n4C1sKhS6a3CPTnVWtpq1K5VK2EwyD7b8T1dmsPdGVDDC095bn+g
         7ny3gRzro3Igus9BMrNI3r0l+KpAt0CGuD8z6DiTF1zI1Yh3IhScpwg/jFfiTMTtIWKl
         SO4kace4Xy8nK234r9j429kf3ZWI/5lQinJkBFt6itirwNwEscu788l43YEDVhk5pv+c
         L6dcFKdOv7UySwAj+K/KXqpqfjldDmiQ1sxjYBnKK6xYv+IM1pr/a4wySTo4tiJWjEh8
         obW7nRhbTQ3O8s24UTEkwO9/paZz+54esmoGUBbvVLeQpqfgBVYYq7crVJnkzWOgUv6b
         ihZA==
X-Forwarded-Encrypted: i=1; AJvYcCVQClRRif5KRtEQ5/XUK2QwGhNuDxC2Kj8KOjRZx265ozpW6kL1/bPtxaKU4B0uQwgq5tuk24SudcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAyV6xjLDE+7BE3DvbyyTRMcXIvs6601yA3Nf/fMJI6uidNHr+
	6KfYsQ23VPvVOcvbT0zsp+zdXSGhvNtwQV07Zmy+VH/EVQbYnNRxGoww
X-Gm-Gg: ASbGnct9OfiNtV7CgasMzJ916fbzKYGVJ0jcYchgd27SP6lyYhBQOZYci+5nf+cJJGn
	piV4wunpi+Wt/gjQNNBt9bHFRdCVtfpdsZiKSZN2zMR+me/miLrtPxwZfwC46ZyW/HfkYcn76qB
	BiCiRLEuZ42eAemdhSMG3uzHeus0aobDOUHm2hdPJq3oFlG/Dea4F+9U5wjNdVj/Zn4jNeMT7rk
	Ln8cnNRtLGsicDqga7s3JqhmZ0wUoRk6COEEdckxVy6BxUi7nIxMmWYavJeQboVewSHaRuE9ITY
	pi6TumhMfkLOFS6ql2MBYqLp6Bvd4zTsD565fcJJ1+cA7LIcINpp37FEaIrzAkQ7Wcz4kwBo/P4
	OjSDpB9IE+h8BErzpR5zNmBESWmCy8KMB8aiOIYKxL5SPosC9X2kTC67wp5M7rqUiszF5zNJjmJ
	zBuoXS38b3ouP3pg==
X-Google-Smtp-Source: AGHT+IG9wjHHm9F1qs6Hj5CY79GIA8nP9/1uv27gdyTOHKSsWrRfFyC/XUADgHH+wq4e30aKmqCKiw==
X-Received: by 2002:a17:90b:3f8c:b0:32b:be68:bb30 with SMTP id 98e67ed59e1d1-32d440d2749mr18927508a91.37.1757472334133;
        Tue, 09 Sep 2025 19:45:34 -0700 (PDT)
Received: from localhost.localdomain ([101.82.183.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb314bcesm635831a91.12.2025.09.09.19.45.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Sep 2025 19:45:33 -0700 (PDT)
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
	shakeel.butt@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 mm-new 03/10] mm: thp: decouple THP allocation between swap and page fault paths
Date: Wed, 10 Sep 2025 10:44:40 +0800
Message-Id: <20250910024447.64788-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250910024447.64788-1-laoar.shao@gmail.com>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
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
Cc: Barry Song <21cnbao@gmail.com>
---
 include/linux/huge_mm.h | 3 ++-
 mm/huge_memory.c        | 2 +-
 mm/memory.c             | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f72a5fd04e4f..b9742453806f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -97,9 +97,10 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 
 enum tva_type {
 	TVA_SMAPS,		/* Exposing "THPeligible:" in smaps. */
-	TVA_PAGEFAULT,		/* Serving a page fault. */
+	TVA_PAGEFAULT,		/* Serving a non-swap page fault. */
 	TVA_KHUGEPAGED,		/* Khugepaged collapse. */
 	TVA_FORCED_COLLAPSE,	/* Forced collapse (e.g. MADV_COLLAPSE). */
+	TVA_SWAP,		/* Serving a swap */
 };
 
 #define thp_vma_allowable_order(vma, vm_flags, type, order) \
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 26cedfcd7418..523153d21a41 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -103,7 +103,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long orders)
 {
 	const bool smaps = type == TVA_SMAPS;
-	const bool in_pf = type == TVA_PAGEFAULT;
+	const bool in_pf = (type == TVA_PAGEFAULT || type == TVA_SWAP);
 	const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
 	unsigned long supported_orders;
 
diff --git a/mm/memory.c b/mm/memory.c
index d9de6c056179..d8819cac7930 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4515,7 +4515,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
 	 * and suitable for swapping THP.
 	 */
-	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
+	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_SWAP,
 					  BIT(PMD_ORDER) - 1);
 	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
 	orders = thp_swap_suitable_orders(swp_offset(entry),
-- 
2.47.3


