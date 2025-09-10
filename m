Return-Path: <bpf+bounces-67974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 985C5B50BBD
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED5D1612A8
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E27A24E4C6;
	Wed, 10 Sep 2025 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isIYQj+t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7A3FFD;
	Wed, 10 Sep 2025 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472327; cv=none; b=NOvzhKKnDSBOTSZNuu6HFzjwr61zgGae7RM0E07YnnuGty5RVKYB7CCnZR/qxpnjElvXg0psTLld0MR24pb7Dt9iXTEixkqnLBICNu9zcHL8G5/U8qAi52DzwNPgcEojtS4VZNpUK0KFBAwe+NbhaWbRPJHgFYf58q0j9Ln/ZOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472327; c=relaxed/simple;
	bh=2CJI1xBRGscFttYA5K98E5IuZfgjF0AikkTPSFj7fKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLD8ZE5sD5kACyNqDa/Aza7PT7MqZoWVYsh+dgDt/s1osmJn7WDh8P5dSe17d+pEATEzfbY1haeBBy90FIb1C77rkChTYC6j0V6ycrZhxaTh5gI2YY4yUcZ2z7sqoTo+9cfyxdtGqJWPlF7o8NRbSFpbYeW5PdNLgZTudBDMgY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isIYQj+t; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32b5d3e1762so5049946a91.3;
        Tue, 09 Sep 2025 19:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472325; x=1758077125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHBVvY3x6e21mIrkyJqNXh0k7BoUcob+yy1n12vnZEU=;
        b=isIYQj+tPSrPI/n3pfKx8Q7NAk9tbwujaJgsBfpxGR5K6v48SFxzUlQ/NsycAXcFkW
         7VwVTQ9y0UW4SBVZfCpNP7hwuc9WhppBbIs7HXhsAQAMBYP/iObHzBmFFUHMZVOlWwn4
         QcoRqRTHEjzbr71Y65UR8PQVL4XdudlB7bq5zrblBKg5RulkuapVcuo099BCfasQ3erd
         Yd6Awm06socgY21oBn8phcLYvOdw3nsDXcWuqIxY7AImOjhxSlz1qjtvOzaWXrnCvy4r
         9NcObproZl4eHicMyvoo5pnMfxVnB+MITvpr5gUOHCXk9/n7fskPG0rxFgoVML+OZJNI
         ORog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472325; x=1758077125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHBVvY3x6e21mIrkyJqNXh0k7BoUcob+yy1n12vnZEU=;
        b=WjaioVXmyx8oX5BfkkGWzuhclNwm+pjlC+vsC3XvZHRSFIa69h3IRDpBYyGpXMDRGj
         53+sTMbuVCuu908iGoPVp2KRyYSCwiIl+n3WgHchxePQYyrVHMfSEx3AKWnrwBuJOWT9
         0mVacHzzkikXl103EbpoDEAbN66thQSatHRLolm+RBTCoxxIXFPHwArq291UW5coGGUU
         XrflIHcG3fbVAhUTod4KnAdzFuzxf6QRCxImNksIQugdf15fbXHSbwaFCeZOG+2eqIB1
         tZ8J5mEwtiox8+TfZqqKdpBqpFvt6GpDav6DuTwj8ZFogUqLrAPNxSxaVztGM23FvRee
         uj4g==
X-Forwarded-Encrypted: i=1; AJvYcCXhFQ5Oftvs2LrfVRRLVeyWswFgBBPJBBYzkaY8SRKtCoS1xW16tF+47jqN8EpPCC/gEoNSuB+RcmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVBnAJQUnc75c9fG4I7RfQszHviFmn6FAjb3yZE/QdhDvg1h6x
	JsRbLNlnSFmiDrSOwyuH1D7uMegaC1u6mIrXFzkh6CJ7HzwM1/Irc4Bv
X-Gm-Gg: ASbGncvRDz3KgbuFvGu2N0xuA7UR/wU2kYqe28CbLocjYTaJ31XfE/KMOgkWXVrgHPq
	ius6wWbdMfostdmVD5PqdJjNMUqMcpee0iaioKpdlG79ZBCOsEpYCbLURD/ZxfUqj1+d4ii/O0B
	Vh+tRm7guqDBl4ILSmxYW70sQaugFoSTA0MykSLJY1iaFlOW4gZxakFBNMwvqOjs7D2ukadh+hX
	LbujxJObQF2l0w34IsdM5wW4GcIbQZB3eQJ6bcx/mLpmZ6FsYde6Fv9Lzr0FDNVCwG5VArCanHX
	l+kdETpUgrkdc1FcvGJaK2H86+LeUppEVt+khV50IMgiphNc9OYYGAAguqqOMX3u9HgiEYEz580
	AL7m6N80i9t2DeB2dmB2ftl+yc8Jtr8I2sgx/1er5SHoDDX0oQeXM3zOMXR9oox5ekKEA2VdRQs
	GO7/pY2eICj+zNAA==
X-Google-Smtp-Source: AGHT+IE89MbDZsiF2EM0+8r+zHCzXP/nYgqEenaQV9tVgYO62q4iIad10FdDLTg1m3xXXaOsQhx59A==
X-Received: by 2002:a17:90b:4c12:b0:329:f110:fe9e with SMTP id 98e67ed59e1d1-32d43f5bc76mr18858970a91.17.1757472325096;
        Tue, 09 Sep 2025 19:45:25 -0700 (PDT)
Received: from localhost.localdomain ([101.82.183.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb314bcesm635831a91.12.2025.09.09.19.45.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Sep 2025 19:45:24 -0700 (PDT)
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
Subject: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP order selection
Date: Wed, 10 Sep 2025 10:44:39 +0800
Message-Id: <20250910024447.64788-3-laoar.shao@gmail.com>
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

This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
THP tuning. It includes a hook bpf_hook_thp_get_order(), allowing BPF
programs to influence THP order selection based on factors such as:
- Workload identity
  For example, workloads running in specific containers or cgroups.
- Allocation context
  Whether the allocation occurs during a page fault, khugepaged, swap or
  other paths.
- VMA's memory advice settings
  MADV_HUGEPAGE or MADV_NOHUGEPAGE
- Memory pressure
  PSI system data or associated cgroup PSI metrics

The kernel API of this new BPF hook is as follows,

/**
 * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation
 * @vma: vm_area_struct associated with the THP allocation
 * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
 *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
 *            neither is set.
 * @tva_type: TVA type for current @vma
 * @orders: Bitmask of requested THP orders for this allocation
 *          - PMD-mapped allocation if PMD_ORDER is set
 *          - mTHP allocation otherwise
 *
 * Return: The suggested THP order from the BPF program for allocation. It will
 *         not exceed the highest requested order in @orders. Return -1 to
 *         indicate that the original requested @orders should remain unchanged.
 */
typedef int thp_order_fn_t(struct vm_area_struct *vma,
			   enum bpf_thp_vma_type vma_type,
			   enum tva_type tva_type,
			   unsigned long orders);

Only a single BPF program can be attached at any given time, though it can
be dynamically updated to adjust the policy. The implementation supports
anonymous THP, shmem THP, and mTHP, with future extensions planned for
file-backed THP.

This functionality is only active when system-wide THP is configured to
madvise or always mode. It remains disabled in never mode. Additionally,
if THP is explicitly disabled for a specific task via prctl(), this BPF
functionality will also be unavailable for that task.

This feature requires CONFIG_BPF_GET_THP_ORDER (marked EXPERIMENTAL) to be
enabled. Note that this capability is currently unstable and may undergo
significant changes—including potential removal—in future kernel versions.

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 MAINTAINERS             |   1 +
 include/linux/huge_mm.h |  26 ++++-
 mm/Kconfig              |  12 ++
 mm/Makefile             |   1 +
 mm/huge_memory_bpf.c    | 243 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 280 insertions(+), 3 deletions(-)
 create mode 100644 mm/huge_memory_bpf.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8fef05bc2224..d055a3c95300 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16252,6 +16252,7 @@ F:	include/linux/huge_mm.h
 F:	include/linux/khugepaged.h
 F:	include/trace/events/huge_memory.h
 F:	mm/huge_memory.c
+F:	mm/huge_memory_bpf.c
 F:	mm/khugepaged.c
 F:	mm/mm_slot.h
 F:	tools/testing/selftests/mm/khugepaged.c
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 23f124493c47..f72a5fd04e4f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -56,6 +56,7 @@ enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
 	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
+	TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached */
 };
 
 struct kobject;
@@ -270,6 +271,19 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 enum tva_type type,
 					 unsigned long orders);
 
+#ifdef CONFIG_BPF_GET_THP_ORDER
+unsigned long
+bpf_hook_thp_get_orders(struct vm_area_struct *vma, vm_flags_t vma_flags,
+			enum tva_type type, unsigned long orders);
+#else
+static inline unsigned long
+bpf_hook_thp_get_orders(struct vm_area_struct *vma, vm_flags_t vma_flags,
+			enum tva_type tva_flags, unsigned long orders)
+{
+	return orders;
+}
+#endif
+
 /**
  * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
  * @vma:  the vm area to check
@@ -291,6 +305,12 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 				       enum tva_type type,
 				       unsigned long orders)
 {
+	unsigned long bpf_orders;
+
+	bpf_orders = bpf_hook_thp_get_orders(vma, vm_flags, type, orders);
+	if (!bpf_orders)
+		return 0;
+
 	/*
 	 * Optimization to check if required orders are enabled early. Only
 	 * forced collapse ignores sysfs configs.
@@ -304,12 +324,12 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
 			mask |= READ_ONCE(huge_anon_orders_inherit);
 
-		orders &= mask;
-		if (!orders)
+		bpf_orders &= mask;
+		if (!bpf_orders)
 			return 0;
 	}
 
-	return __thp_vma_allowable_orders(vma, vm_flags, type, orders);
+	return __thp_vma_allowable_orders(vma, vm_flags, type, bpf_orders);
 }
 
 struct thpsize {
diff --git a/mm/Kconfig b/mm/Kconfig
index d1ed839ca710..4d89d2158f10 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -896,6 +896,18 @@ config NO_PAGE_MAPCOUNT
 
 	  EXPERIMENTAL because the impact of some changes is still unclear.
 
+config BPF_GET_THP_ORDER
+	bool "BPF-based THP order selection (EXPERIMENTAL)"
+	depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
+
+	help
+	  Enable dynamic THP order selection using BPF programs. This
+	  experimental feature allows custom BPF logic to determine optimal
+	  transparent hugepage allocation sizes at runtime.
+
+	  WARNING: This feature is unstable and may change in future kernel
+	  versions.
+
 endif # TRANSPARENT_HUGEPAGE
 
 # simple helper to make the code a bit easier to read
diff --git a/mm/Makefile b/mm/Makefile
index 21abb3353550..f180332f2ad0 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
+obj-$(CONFIG_BPF_GET_THP_ORDER) += huge_memory_bpf.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
new file mode 100644
index 000000000000..525ee22ab598
--- /dev/null
+++ b/mm/huge_memory_bpf.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF-based THP policy management
+ *
+ * Author: Yafang Shao <laoar.shao@gmail.com>
+ */
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/huge_mm.h>
+#include <linux/khugepaged.h>
+
+enum bpf_thp_vma_type {
+	BPF_THP_VM_NONE = 0,
+	BPF_THP_VM_HUGEPAGE,	/* VM_HUGEPAGE */
+	BPF_THP_VM_NOHUGEPAGE,	/* VM_NOHUGEPAGE */
+};
+
+/**
+ * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation
+ * @vma: vm_area_struct associated with the THP allocation
+ * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
+ *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
+ *            neither is set.
+ * @tva_type: TVA type for current @vma
+ * @orders: Bitmask of requested THP orders for this allocation
+ *          - PMD-mapped allocation if PMD_ORDER is set
+ *          - mTHP allocation otherwise
+ *
+ * Return: The suggested THP order from the BPF program for allocation. It will
+ *         not exceed the highest requested order in @orders. Return -1 to
+ *         indicate that the original requested @orders should remain unchanged.
+ */
+typedef int thp_order_fn_t(struct vm_area_struct *vma,
+			   enum bpf_thp_vma_type vma_type,
+			   enum tva_type tva_type,
+			   unsigned long orders);
+
+struct bpf_thp_ops {
+	thp_order_fn_t __rcu *thp_get_order;
+};
+
+static struct bpf_thp_ops bpf_thp;
+static DEFINE_SPINLOCK(thp_ops_lock);
+
+/*
+ * Returns the original @orders if no BPF program is attached or if the
+ * suggested order is invalid.
+ */
+unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
+				      vm_flags_t vma_flags,
+				      enum tva_type tva_type,
+				      unsigned long orders)
+{
+	thp_order_fn_t *bpf_hook_thp_get_order;
+	unsigned long thp_orders = orders;
+	enum bpf_thp_vma_type vma_type;
+	int thp_order;
+
+	/* No BPF program is attached */
+	if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
+		      &transparent_hugepage_flags))
+		return orders;
+
+	if (vma_flags & VM_HUGEPAGE)
+		vma_type = BPF_THP_VM_HUGEPAGE;
+	else if (vma_flags & VM_NOHUGEPAGE)
+		vma_type = BPF_THP_VM_NOHUGEPAGE;
+	else
+		vma_type = BPF_THP_VM_NONE;
+
+	rcu_read_lock();
+	bpf_hook_thp_get_order = rcu_dereference(bpf_thp.thp_get_order);
+	if (!bpf_hook_thp_get_order)
+		goto out;
+
+	thp_order = bpf_hook_thp_get_order(vma, vma_type, tva_type, orders);
+	if (thp_order < 0)
+		goto out;
+	/*
+	 * The maximum requested order is determined by the callsite. E.g.:
+	 * - PMD-mapped THP uses PMD_ORDER
+	 * - mTHP uses (PMD_ORDER - 1)
+	 *
+	 * We must respect this upper bound to avoid undefined behavior. So the
+	 * highest suggested order can't exceed the highest requested order.
+	 */
+	if (thp_order <= highest_order(orders))
+		thp_orders = BIT(thp_order);
+
+out:
+	rcu_read_unlock();
+	return thp_orders;
+}
+
+static bool bpf_thp_ops_is_valid_access(int off, int size,
+					enum bpf_access_type type,
+					const struct bpf_prog *prog,
+					struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static const struct bpf_func_proto *
+bpf_thp_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return bpf_base_func_proto(func_id, prog);
+}
+
+static const struct bpf_verifier_ops thp_bpf_verifier_ops = {
+	.get_func_proto = bpf_thp_get_func_proto,
+	.is_valid_access = bpf_thp_ops_is_valid_access,
+};
+
+static int bpf_thp_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int bpf_thp_check_member(const struct btf_type *t,
+				const struct btf_member *member,
+				const struct bpf_prog *prog)
+{
+	/* The call site operates under RCU protection. */
+	if (prog->sleepable)
+		return -EINVAL;
+	return 0;
+}
+
+static int bpf_thp_init_member(const struct btf_type *t,
+			       const struct btf_member *member,
+			       void *kdata, const void *udata)
+{
+	return 0;
+}
+
+static int bpf_thp_reg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_thp_ops *ops = kdata;
+
+	spin_lock(&thp_ops_lock);
+	if (test_and_set_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
+			     &transparent_hugepage_flags)) {
+		spin_unlock(&thp_ops_lock);
+		return -EBUSY;
+	}
+	WARN_ON_ONCE(rcu_access_pointer(bpf_thp.thp_get_order));
+	rcu_assign_pointer(bpf_thp.thp_get_order, ops->thp_get_order);
+	spin_unlock(&thp_ops_lock);
+	return 0;
+}
+
+static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
+{
+	thp_order_fn_t *old_fn;
+
+	spin_lock(&thp_ops_lock);
+	clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags);
+	old_fn = rcu_replace_pointer(bpf_thp.thp_get_order, NULL,
+				     lockdep_is_held(&thp_ops_lock));
+	WARN_ON_ONCE(!old_fn);
+	spin_unlock(&thp_ops_lock);
+
+	synchronize_rcu();
+}
+
+static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
+{
+	thp_order_fn_t *old_fn, *new_fn;
+	struct bpf_thp_ops *old = old_kdata;
+	struct bpf_thp_ops *ops = kdata;
+	int ret = 0;
+
+	if (!ops || !old)
+		return -EINVAL;
+
+	spin_lock(&thp_ops_lock);
+	/* The prog has aleady been removed. */
+	if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
+		      &transparent_hugepage_flags)) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	new_fn = rcu_dereference(ops->thp_get_order);
+	old_fn = rcu_replace_pointer(bpf_thp.thp_get_order, new_fn,
+				     lockdep_is_held(&thp_ops_lock));
+	WARN_ON_ONCE(!old_fn || !new_fn);
+
+out:
+	spin_unlock(&thp_ops_lock);
+	if (!ret)
+		synchronize_rcu();
+	return ret;
+}
+
+static int bpf_thp_validate(void *kdata)
+{
+	struct bpf_thp_ops *ops = kdata;
+
+	if (!ops->thp_get_order) {
+		pr_err("bpf_thp: required ops isn't implemented\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int bpf_thp_get_order(struct vm_area_struct *vma,
+			     enum bpf_thp_vma_type vma_type,
+			     enum tva_type tva_type,
+			     unsigned long orders)
+{
+	return -1;
+}
+
+static struct bpf_thp_ops __bpf_thp_ops = {
+	.thp_get_order = (thp_order_fn_t __rcu *)bpf_thp_get_order,
+};
+
+static struct bpf_struct_ops bpf_bpf_thp_ops = {
+	.verifier_ops = &thp_bpf_verifier_ops,
+	.init = bpf_thp_init,
+	.check_member = bpf_thp_check_member,
+	.init_member = bpf_thp_init_member,
+	.reg = bpf_thp_reg,
+	.unreg = bpf_thp_unreg,
+	.update = bpf_thp_update,
+	.validate = bpf_thp_validate,
+	.cfi_stubs = &__bpf_thp_ops,
+	.owner = THIS_MODULE,
+	.name = "bpf_thp_ops",
+};
+
+static int __init bpf_thp_ops_init(void)
+{
+	int err;
+
+	err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
+	if (err)
+		pr_err("bpf_thp: Failed to register struct_ops (%d)\n", err);
+	return err;
+}
+late_initcall(bpf_thp_ops_init);
-- 
2.47.3


