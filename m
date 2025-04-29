Return-Path: <bpf+bounces-56886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F892AA0005
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 04:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68A35A5897
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 02:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF8D29CB4A;
	Tue, 29 Apr 2025 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIS2QbN9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C4929CB41
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745894525; cv=none; b=ImkWnniJk8dimuOczf6zg+yghs+FiOSFS81x9zELqexkJSm9c8kZk0zTwwE4/YyPxHKGuAXEEcRrD3iq8UMfsXvYAc5SJrJhoBdey7DBZA0Z2TRrE3Mv3rtqabmEoqkOJexuxempIVteDyVNYDNFfH5gbWYQYhQ7QtWxq1eiCLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745894525; c=relaxed/simple;
	bh=VfeBVHMdKgH1lYIZ+gtMkYvDKCeJ+iEid7vvRL/rt4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AodvlR4qiWbT2MAhay2i6mBfuTxjkoVSe2PEmSfdqgv5D26djpjAKBxlDZw75nODmZE/9OdWXSgqvlGFZjEqYM8zPE38QZvjGVHITY2D+p3b51lJ5yM6PZGCXQ1KTZUrj63vLcHGrmi6a7EP9s4cLcl7UEOA7UbbUQLtEMGPU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIS2QbN9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22423adf751so55249245ad.2
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 19:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745894523; x=1746499323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqeGyt7gPoidax5gVsRj8CtbtpGY7PbbgW35mARwMvU=;
        b=lIS2QbN93Jt6sNldM1Njtb7aciNYwr0XFVBkMF0JkRZPNoIQIHMwcZrq22DmvJ8JIP
         AaMcDb/fatv/rNvq8gyZX1wtnSSMUCoZfZWVoArT/16TqXVmYrTa2vuWSHvQbpz/zfn8
         WFvKCEkOiUqG15OkJc6Oii61IJltsyiysMxATojxasgnQhYhVmxWsoK1iZOvD3p6xdEX
         44OLM8U0VjmVt6jHcbDXiQXX1wtWzkPtEtruhFy2CEoEuad/o46qu+TbuJYzttoIantW
         r9Ek2ZzdIYJdebr5DGwQ2BHorRMSLdzrORIOFLL7p+nMkZSkKt8qWP8K9yIR+KC2qJnj
         +qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745894523; x=1746499323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqeGyt7gPoidax5gVsRj8CtbtpGY7PbbgW35mARwMvU=;
        b=pEiMm4iz1fgD0IGSGv0rmwWdhrteEKfxtiFldQau3Mia7JQUTtbLVfs3jAj43AMGA4
         kHuzCevATwXVKz+t+JLATDQtGklHzb2EqbmJzgTtugD4iBkYlqs+4jL7EsNyKwo71qkK
         Hv3TxUu0Ii91ud2VsMAJGv9m4DmuyRZGYMS1CP7e85ybOsWBiCiHvO7LAxQh2SScRjv4
         Ed5atAk6/Bz2a5QeEh0GIBwBv60QMnmjCDq/fCvL65a6Pw96RXbYH9xUhOfo4GD+/QfX
         LzI0Q/p5P4vSxqnqKkK4VZfUEz8TUVn5iJGI1TEJ1/Z6OebJi11PEDjaQbkwO22hM+23
         /+WQ==
X-Gm-Message-State: AOJu0YxtJiI9Iw7LYsO86Fr1kMBZPZ/fbU000E2hlctt8MtQu3i3bRfv
	MfsESWklFmPMOAJwCwswwmjGMOpTT8bcPIM14fhKCzcY63neDPwZ
X-Gm-Gg: ASbGncu5/ZYV7DgsNx4IGRpSDTb++OJq9HR1GvyA42fTe9kv2B19bzd48Pr7WKojX00
	Gy1YdVjpiQsjBuMADCCUUed2rLYmIVvPUKWuRrXERVGT20SkoXXQmaKDetJTOeaMb8pg0mrvoZe
	ModDDa19az/Ps7H8LdPhuQUCmqOmH0ctDSnEYmIOS+cTPYUpYgQDC7uHjNJ2u+XFggWezA9GPLP
	RWOhbORt3AXPuY5Vx4TnQ8zNnnZwSPlX1/nDT0p1QpOD1Zrzw4ziezHBxjnzLy53jgZe4BvTSHl
	DhOIk0DtWmSuonWvP0t1tSCuD0hORDv8DMMd3Q4sUmdbXsGWeeJF+yOOCGrB1tb8ew==
X-Google-Smtp-Source: AGHT+IGD53soZVsbv8HzCNlv/Jg6Ocr9dlSnbrRgmsfIxJvtLS7McOWhLaZgNgxSsqj3V/A0kWYWEg==
X-Received: by 2002:a17:903:950:b0:223:501c:7576 with SMTP id d9443c01a7336-22de6e9edfdmr23058635ad.12.1745894522628;
        Mon, 28 Apr 2025 19:42:02 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef097cb7sm9893211a91.22.2025.04.28.19.41.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Apr 2025 19:42:02 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 3/4] mm: add BPF hook for THP adjustment
Date: Tue, 29 Apr 2025 10:41:38 +0800
Message-Id: <20250429024139.34365-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250429024139.34365-1-laoar.shao@gmail.com>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We will use the @vma parameter in BPF programs to determine whether THP can
be used. The typical workflow is as follows:

1. Retrieve the mm_struct from the given @vma.
2. Obtain the task_struct associated with the mm_struct
   It depends on CONFIG_MEMCG.
3. Adjust THP behavior dynamically based on task attributes
   E.g., based on the task’s cgroup

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/Makefile   |  3 +++
 mm/bpf.c      | 36 ++++++++++++++++++++++++++++++++++++
 mm/bpf.h      | 21 +++++++++++++++++++++
 mm/internal.h |  3 +++
 4 files changed, 63 insertions(+)
 create mode 100644 mm/bpf.c
 create mode 100644 mm/bpf.h

diff --git a/mm/Makefile b/mm/Makefile
index e7f6bbf8ae5f..97055da04746 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -99,6 +99,9 @@ obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
+ifdef CONFIG_BPF_SYSCALL
+obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += bpf.o
+endif
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
diff --git a/mm/bpf.c b/mm/bpf.c
new file mode 100644
index 000000000000..72eebcdbad56
--- /dev/null
+++ b/mm/bpf.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Yafang Shao <laoar.shao@gmail.com>
+ */
+
+#include <linux/bpf.h>
+#include <linux/mm_types.h>
+
+__bpf_hook_start();
+
+/* Checks if this @vma can use THP. */
+__weak noinline int
+mm_bpf_thp_vma_allowable(struct vm_area_struct *vma)
+{
+	/* At present, fmod_ret exclusively uses 0 to signify that the return
+	 * value remains unchanged.
+	 */
+	return 0;
+}
+
+__bpf_hook_end();
+
+BTF_SET8_START(mm_bpf_fmod_ret_ids)
+BTF_ID_FLAGS(func, mm_bpf_thp_vma_allowable)
+BTF_SET8_END(mm_bpf_fmod_ret_ids)
+
+static const struct btf_kfunc_id_set mm_bpf_fmodret_set = {
+	.owner = THIS_MODULE,
+	.set   = &mm_bpf_fmod_ret_ids,
+};
+
+static int __init bpf_mm_kfunc_init(void)
+{
+	return register_btf_fmodret_id_set(&mm_bpf_fmodret_set);
+}
+late_initcall(bpf_mm_kfunc_init);
diff --git a/mm/bpf.h b/mm/bpf.h
new file mode 100644
index 000000000000..e03a38084b08
--- /dev/null
+++ b/mm/bpf.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __MM_BPF_H
+#define __MM_BPF_H
+
+#define MM_BPF_ALLOWABLE	(1)
+#define MM_BPF_NOT_ALLOWABLE	(-1)
+
+#define MM_BPF_ALLOWABLE_HOOK(func, args...)	{	\
+	int ret = func(args);				\
+							\
+	if (ret == MM_BPF_ALLOWABLE)			\
+		return 1;				\
+	if (ret == MM_BPF_NOT_ALLOWABLE)		\
+		return 0;				\
+}
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+int mm_bpf_thp_vma_allowable(struct vm_area_struct *vma);
+#endif
+
+#endif
diff --git a/mm/internal.h b/mm/internal.h
index aa698a11dd68..c8bf405fa581 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -21,6 +21,7 @@
 
 /* Internal core VMA manipulation functions. */
 #include "vma.h"
+#include "bpf.h"
 
 struct folio_batch;
 
@@ -1632,6 +1633,7 @@ static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
  */
 static inline bool hugepage_global_enabled(struct vm_area_struct *vma)
 {
+	MM_BPF_ALLOWABLE_HOOK(mm_bpf_thp_vma_allowable, vma);
 	return transparent_hugepage_flags &
 			((1<<TRANSPARENT_HUGEPAGE_FLAG) |
 			(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG));
@@ -1639,6 +1641,7 @@ static inline bool hugepage_global_enabled(struct vm_area_struct *vma)
 
 static inline bool hugepage_global_always(struct vm_area_struct *vma)
 {
+	MM_BPF_ALLOWABLE_HOOK(mm_bpf_thp_vma_allowable, vma);
 	return transparent_hugepage_flags &
 			(1<<TRANSPARENT_HUGEPAGE_FLAG);
 }
-- 
2.43.5


