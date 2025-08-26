Return-Path: <bpf+bounces-66519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E91A3B3558A
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2858B1895B1B
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08532D0C63;
	Tue, 26 Aug 2025 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnN8OSzx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D5928A1F1;
	Tue, 26 Aug 2025 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192912; cv=none; b=PSFcu/1LQdAbYDWPjpfHBleJ/Qivefwotq5WC3s71HM0J0ulIZbBOh5d8+tXjec4JT1CR9sVZjDu0J7g4rrZM8Jyw5ovvuM9HjlzV/wB8hhoB/4b1LPxb5pHNzdhKMdZS7YsfW1z9EspTxFvhYuAMj0IEKl34k4KPAqGgCo1jnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192912; c=relaxed/simple;
	bh=3DRVri6R6o8lkzsMBbKU5fHO/R7iLByDPyAx0y1tlA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDafFuDEflh7ynMu3zfrz2UuptH1oSnZ/nm4yYr/brfPT/CSjC54GNLxHoTA8wxdPZwzRKTA2caj4nFYcIDq1kltnGN8pUKeM7L8qk23xmN/mrxA94Hrzqthmo7xuQvAY9XG3Xvglfobii6JFbp+c+i4pPuUJFhB8qpm4JUArUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnN8OSzx; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso1944309b3a.2;
        Tue, 26 Aug 2025 00:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756192910; x=1756797710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t13H33qD8qLpbmeE54fNLyxvfIEhKYRpPw50c6x9IkI=;
        b=WnN8OSzxf5Pv9068TPdExQSJ4GAG7rDopM0K8bLN6Wmfl5sWCZXQ0zJpTKyiyxs8dd
         BfvAl0JLlHfR3HH/Sv9ANGPAgDeQskTJsvdYdPfcn7AbokoNOFaWwL+jIxathGuwVKdo
         FbZ5tgaZFBB/YXqrSJXgQjQT4lJjlslMH3+h7n9/CvtHjIuWBR6+7HcqFXCDfPExbRZU
         F4JIDDQAfLf71/0RMA62lNBhwjEiMgNrqydJ1cChuxY8iG/itLLo5ckK2yZcgxZ2YATj
         gyTL+2CEtxIZq7lXFfg1sWwyhBUGK/URy1K1wLIU5a3Ii9IJX5pEyeYMhQN6s6hDGpbC
         pY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192910; x=1756797710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t13H33qD8qLpbmeE54fNLyxvfIEhKYRpPw50c6x9IkI=;
        b=NvuiDQcaw4Yo5ncyzJ1KF/rzYPv3+OgErEIIhPqMh4CtDHIShEb447MkfY25vbJotg
         f5FXwmx+y5+I7tOaCEZPkO7qE2Jzb8Y685nYN/1VzSKKrZXXzy3ehFy+uv+oiD9R6vzC
         nXNFlFmLiamKir9mA73CTNARA+/aNyCmybvWibPlvxWHJszHFgeYAgAYxLTUBlDikBFP
         2+/jxlKK0KdXFExPAfBpt0mKOK4el+oLXlbagDPi4L3bBuhPwNLv0S3VtgsSL53tos2F
         d4i50hj+A7AdZ+UrkAFwCeuQKUL4SheBx/Vs33t+w57Bipa4+eHmpEBCVe8qwdxo/o1w
         BM+A==
X-Forwarded-Encrypted: i=1; AJvYcCW8K3fYS9NzfFkOGgnJ6vmjcgAuAqQNdq7UL/uii549JoxccC8KvgYHcNI7PClEgP6QqyVddhPIoqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3rpvd/2gEfB/9FfpNoov3D6H+KN31smeQM8TMzcd1npVdNwdp
	z43JsyY4hcE66FBlpLjKWvAbORSfpTcDBGjbQ41wbrsW+sb85om2nSZy
X-Gm-Gg: ASbGncs3PdT2XyqaUAHAMzRZAgfwJcyOn71hfBuDYa6ELwYRZwW5gyqWeD0o74N3kV0
	n6K6AjjbWJ0e/ui/vp5SDUee8i4DOSIl2QCr2mu9kWeT7w9AlvPuJSiaKXunOC3PNjmoHbsbj+z
	Ob2kgz5khoRQctjJvXtVbOK4C+73a2bUrzlUaMqqMkh9WO3FF6pswZ/Xhr/JlEG8S7qcGZ8vfGu
	rVsuQ5m1nDRbs7gajPJOAkDdJuZRl2VSuQ6Ulaz2PCN7Vu1elFDQid+ZCVqjxM1MEFQUvEVYNSQ
	4IJD84XSQKBQD9CXqR9yIxtugjVvlMwIJxOu698UYjo84KaBiWf1MTq956N8Q5vigwe65283cng
	SoHrCvrOYkdsCwi+CIOEu8YtH1Sj8Lyw4AiqZJjoH221OkLwixN1cluCAG8rhOKEyNUxAx5QgTN
	x9DCk=
X-Google-Smtp-Source: AGHT+IEu2b0RM+dE+zHiTagKiYCBPegaYQagDUGzf74IowO/NX6e+8Qmik0yxURJXoig5rjUT1KdPg==
X-Received: by 2002:a05:6a20:a110:b0:240:763:797e with SMTP id adf61e73a8af0-24340b8a6a0mr22053427637.25.1756192910180;
        Tue, 26 Aug 2025 00:21:50 -0700 (PDT)
Received: from localhost.localdomain ([101.82.213.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm9686052b3a.75.2025.08.26.00.21.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 00:21:49 -0700 (PDT)
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
	corbet@lwn.net
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 mm-new 09/10] Documentation: add BPF-based THP adjustment documentation
Date: Tue, 26 Aug 2025 15:19:47 +0800
Message-Id: <20250826071948.2618-10-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250826071948.2618-1-laoar.shao@gmail.com>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the documentation.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index a16a04841b96..1725b89426a9 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -734,3 +734,50 @@ support enabled just fine as always. No difference can be noted in
 hugetlbfs other than there will be less overall fragmentation. All
 usual features belonging to hugetlbfs are preserved and
 unaffected. libhugetlbfs will also work fine as usual.
+
+BPF-based THP adjustment
+========================
+
+Overview
+--------
+
+When the system is configured with "always" or "madvise" THP mode, a BPF program
+can be used to adjust THP allocation policies dynamically. This enables
+fine-grained control over THP decisions based on various factors including
+workload identity, allocation context, and system memory pressure.
+
+Program Interface
+-----------------
+
+This feature implements a struct_ops BPF program with the following interface::
+
+  int (*get_suggested_order)(struct mm_struct *mm,
+                             struct vm_area_struct *vma__nullable,
+                             u64 vma_flags, enum tva_type tva_flags, int orders)
+
+Parameters::
+
+  @mm:  mm_struct associated with the THP allocation
+  @vma__nullable: vm_area_struct associated with the THP allocation (may be NULL)
+                  When NULL, the decision should be based on @mm (i.e., when
+                  triggered from an mm-scope hook rather than a VMA-specific
+                  context)
+                  Must belong to @mm (guaranteed by the caller).
+  @vma_flags: use these vm_flags instead of @vma->vm_flags (0 if @vma is NULL)
+  @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
+  @orders: Bitmask of requested THP orders for this allocation
+           - PMD-mapped allocation if PMD_ORDER is set
+           - mTHP allocation otherwise
+
+Return value::
+
+  Bitmask of suggested THP orders for allocation. The highest suggested order
+  will not exceed the highest requested order in @orders.
+
+Implementation Notes
+--------------------
+
+This is currently an experimental feature.
+CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION must be enabled to use it.
+Only one BPF program can be attached at a time, but the program can be updated
+dynamically to adjust policies without requiring affected tasks to be restarted.
-- 
2.47.3


