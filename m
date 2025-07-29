Return-Path: <bpf+bounces-64598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B774BB14B07
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 11:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71641AA2752
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 09:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9549F22A4D5;
	Tue, 29 Jul 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj/Inpya"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4652A2673B9
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780717; cv=none; b=S5loWUps/gaq0kmMvsdeNPl0hTvCMymOQD2f1j7YlEMJHQWWAqKf49JR4xwI94TNNwsAw9aXePeurGn+Lmrd7B0CYC8AcVCvJXeKeociTPeJuX6TJhExNLKGE5JJYpo+IPft9npL9THjSntKpgyGnQjGpQBe0YaZP3c9BeLUiTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780717; c=relaxed/simple;
	bh=JZVjsSUade7rBcIDK+10beZwrdavESPX7XDSVypDqZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVCKdgQMN2BjymAdvTMRQGpOsvurti6Rshodsbt740GTutUdOlzL7oRrSd10ik0FSc2aBt/Rt5+5cc8GbVL4poIOun4lgIleP01cRlsU1al+9KRTIKD2vade1r2RkK1uCsBfJQ7XVu3BOvC3Qo5aD7p4q4QBA/dP7ZccqnmHOJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj/Inpya; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23fd3fe0d81so24665915ad.3
        for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 02:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780713; x=1754385513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppiLymWvZQZKoAHwo2gHS7E6txIDm0zCCExLuiUeMEc=;
        b=jj/Inpya5/tsypEwGqtgFqZQ+us8yQnnFnD7Yq6j8y1XsphW1fgxPTW/M8ajZz6ds2
         5eZdxse8JL0wt3QRgngxQx4SFcfU03pDmCp1L+dqzJ/1ex/taJumUYKcAsaHC84j1DR7
         0zZzuQ9aUB7MWgpC03/aNwS0Z7orNi1REAd/HtIfnQ7kzibGns9ILXrX2FeuVXF5AQOd
         RCwrnjjPmjyESyHprYPMxRsrzXN8sxLjIw5+bI5sayWHJVxKH62Tq4g2ZupwJTji2hoY
         qfwuSnyUStFp/A3TnFtZk1Pplxtb1GrMvFdJg5A5EZR1x3fBTw4rPzumKMXT2CC4VJh9
         eGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780713; x=1754385513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppiLymWvZQZKoAHwo2gHS7E6txIDm0zCCExLuiUeMEc=;
        b=wZHVm9ZeFQTDUKhVu7hDAJB48FOi2WUfmizo7J9MJOsnVkyjnwI3ffLVwTessqBdxQ
         CuyTKr74tUr9sGxcoabDt71UsIAHA8i1svuu+pOLbL3Oz0rRgcSLl02uS+ktGRpTKuju
         1DRouVHrHU1i72LiJ//W0gJHSkCnMNViYAymPetdlUvkHCl8UahiWSOKhg/zgcjq7I8w
         sgpd2Zv1qNfSUbXc7Lobbhfhb3HSGxc/9coN9chcGQcuwWMWCpq17K7wYh3SjbYe3r0F
         R+ume4ktcYCTxZ/BY8ZLYDb2QF7ItkKlPc0OUdKRtHWrjmqNaL5PWIJvU3sfIDqPp100
         qZBA==
X-Gm-Message-State: AOJu0YyUYyTfbpgiovcZCcpat0wGhpmPaoO1FdndQLKj/Sy8n+AIZYHf
	cqmtg8j9K553Xxt53/FZ3m3FiI2EqRMq8Tto1Ws4oZuqveJ/soOdoChN
X-Gm-Gg: ASbGnctg4EI6jRkEb2IUellIM/5JddTTlmqOaHRoyAfPtoRhQnXLLRpmHpBTVjwxFhk
	XgPBlfMX7WhCtgXV1LcqoeVBnI5cVkyPEEu7hqsGWp/TGcf2cd/ZqIfPrjU2IIXo309PesaWW9h
	adXSB63xhIcK0UPy+0cGAWvjfdQyaXJeeggMEMhZKkTexl2xLg/tFGGU8Le6hmg7Rgcm3z98SJp
	mViRzr6ADjAAMBgFlJer6l8DB4w/duMjpVM08Oi6ASHwYwJowOEPJg80knpCcNqnAhXT4SdOpyj
	jDoOt2tPP7MjZutFhcliJMhWmy5HgUjJ/vo1LqXSXHtUW2wrmrYVxcEu7KLxMBKPc4DAKNaCqoV
	C4msH882SqVLfTUGkMQwCTcS1zRwKLUlu9txnovy2BfpZj1I3
X-Google-Smtp-Source: AGHT+IEmJR2qDv7n2cDcVzpa6jNA35+tHW9Bqxks2Hupnyp8O0mzOmJEtUetiEJoH+weAU1qoN50AA==
X-Received: by 2002:a17:903:1b6d:b0:23e:ea0:63c0 with SMTP id d9443c01a7336-23fb30e5e90mr226336635ad.41.1753780713322;
        Tue, 29 Jul 2025 02:18:33 -0700 (PDT)
Received: from localhost.localdomain ([101.82.174.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30be01sm74337015ad.39.2025.07.29.02.18.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Jul 2025 02:18:32 -0700 (PDT)
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
	ameryhung@gmail.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v4 1/4] mm: thp: add support for BPF based THP order selection
Date: Tue, 29 Jul 2025 17:18:04 +0800
Message-Id: <20250729091807.84310-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250729091807.84310-1-laoar.shao@gmail.com>
References: <20250729091807.84310-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
THP tuning. It includes a hook get_suggested_order() [0], allowing BPF
programs to influence THP order selection based on factors such as:
- Workload identity
  For example, workloads running in specific containers or cgroups.
- Allocation context
  Whether the allocation occurs during a page fault, khugepaged, or other
  paths.
- System memory pressure
  (May require new BPF helpers to accurately assess memory pressure.)

Key Details:
- Only one BPF program can be attached at a time, but it can be updated
  dynamically to adjust the policy.
- Supports automatic mTHP order selection and per-workload THP policies.
- Only functional when THP is set to madise or always.

Experimental Status:
- Requires CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION to enable. [1]
- This feature is unstable and may evolve in future kernel versions.

Link: https://lwn.net/ml/all/9bc57721-5287-416c-aa30-46932d605f63@redhat.com/ [0]
Link: https://lwn.net/ml/all/dda67ea5-2943-497c-a8e5-d81f0733047d@lucifer.local/ [1]

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/huge_mm.h    |  13 +++
 include/linux/khugepaged.h |  12 ++-
 mm/Kconfig                 |  12 +++
 mm/Makefile                |   1 +
 mm/bpf_thp.c               | 172 +++++++++++++++++++++++++++++++++++++
 mm/huge_memory.c           |   9 ++
 mm/khugepaged.c            |  18 +++-
 mm/memory.c                |  14 ++-
 8 files changed, 244 insertions(+), 7 deletions(-)
 create mode 100644 mm/bpf_thp.c

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2f190c90192d..5a1527b3b6f0 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -6,6 +6,8 @@
 
 #include <linux/fs.h> /* only for vma_is_dax() */
 #include <linux/kobject.h>
+#include <linux/pgtable.h>
+#include <linux/mm.h>
 
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -54,6 +56,7 @@ enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
 	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
+	TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached */
 };
 
 struct kobject;
@@ -190,6 +193,16 @@ static inline bool hugepage_global_always(void)
 			(1<<TRANSPARENT_HUGEPAGE_FLAG);
 }
 
+#ifdef CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION
+int get_suggested_order(struct mm_struct *mm, unsigned long tva_flags, int order);
+#else
+static inline int
+get_suggested_order(struct mm_struct *mm, unsigned long tva_flags, int order)
+{
+	return order;
+}
+#endif
+
 static inline int highest_order(unsigned long orders)
 {
 	return fls_long(orders) - 1;
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index b8d69cfbb58b..e0242968a020 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_KHUGEPAGED_H
 #define _LINUX_KHUGEPAGED_H
 
+#include <linux/huge_mm.h>
+
 extern unsigned int khugepaged_max_ptes_none __read_mostly;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern struct attribute_group khugepaged_attr_group;
@@ -20,7 +22,15 @@ extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 
 static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
+	/*
+	 * THP allocation policy can be dynamically modified via BPF. If a
+	 * long-lived task was previously allowed to allocate THP but is no
+	 * longer permitted under the new policy, we must ensure its forked
+	 * child processes also inherit this restriction.
+	 * The MMF_VM_HUGEPAGE flag will be cleared by khugepaged.
+	 */
+	if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags) &&
+	    get_suggested_order(mm, 0, PMD_ORDER) == PMD_ORDER)
 		__khugepaged_enter(mm);
 }
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 781be3240e21..5d05a537ecde 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -908,6 +908,18 @@ config NO_PAGE_MAPCOUNT
 
 	  EXPERIMENTAL because the impact of some changes is still unclear.
 
+config EXPERIMENTAL_BPF_ORDER_SELECTION
+	bool "BPF-based THP order selection (EXPERIMENTAL)"
+	depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
+
+	help
+	  Enable dynamic THP order selection using BPF programs. This
+	  experimental feature allows custom BPF logic to determine optimal
+	  transparent hugepage allocation sizes at runtime.
+
+	  Warning: This feature is unstable and may change in future kernel
+	  versions.
+
 endif # TRANSPARENT_HUGEPAGE
 
 # simple helper to make the code a bit easier to read
diff --git a/mm/Makefile b/mm/Makefile
index 1a7a11d4933d..562525e6a28a 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
+obj-$(CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION) += bpf_thp.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
new file mode 100644
index 000000000000..10b486dd8bc4
--- /dev/null
+++ b/mm/bpf_thp.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/huge_mm.h>
+#include <linux/khugepaged.h>
+
+struct bpf_thp_ops {
+	/**
+	 * @get_suggested_order: Get the suggested highest THP order for allocation
+	 * @mm: mm_struct associated with the THP allocation
+	 * @tva_flags: TVA flags for current context
+	 *             %TVA_IN_PF: Set when in page fault context
+	 *             Other flags: Reserved for future use
+	 * @order: The highest order being considered for this THP allocation.
+	 *         %PUD_ORDER for PUD-mapped allocations
+	 *         %PMD_ORDER for PMD-mapped allocations
+	 *         %PMD_ORDER - 1 for mTHP allocations
+	 *
+	 * Rerurn: Suggested highest THP order to use for allocation. The returned
+	 * order will never exceed the input @order value.
+	 */
+	int (*get_suggested_order)(struct mm_struct *mm, unsigned long tva_flags, int order) __rcu;
+};
+
+static struct bpf_thp_ops bpf_thp;
+static DEFINE_SPINLOCK(thp_ops_lock);
+
+int get_suggested_order(struct mm_struct *mm, unsigned long tva_flags, int order)
+{
+	int (*bpf_suggested_order)(struct mm_struct *mm, unsigned long tva_flags, int order);
+	int suggested_order = order;
+
+	/* No BPF program is attached */
+	if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
+		      &transparent_hugepage_flags))
+		return suggested_order;
+
+	rcu_read_lock();
+	bpf_suggested_order = rcu_dereference(bpf_thp.get_suggested_order);
+	if (!bpf_suggested_order)
+		goto out;
+
+	suggested_order = bpf_suggested_order(mm, tva_flags, order);
+	if (suggested_order > order)
+		suggested_order = order;
+
+out:
+	rcu_read_unlock();
+	return suggested_order;
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
+		&transparent_hugepage_flags)) {
+		spin_unlock(&thp_ops_lock);
+		return -EBUSY;
+	}
+	WARN_ON_ONCE(bpf_thp.get_suggested_order);
+	WRITE_ONCE(bpf_thp.get_suggested_order, ops->get_suggested_order);
+	spin_unlock(&thp_ops_lock);
+	return 0;
+}
+
+static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
+{
+	spin_lock(&thp_ops_lock);
+	clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags);
+	WARN_ON_ONCE(!bpf_thp.get_suggested_order);
+	rcu_replace_pointer(bpf_thp.get_suggested_order, NULL, lockdep_is_held(&thp_ops_lock));
+	spin_unlock(&thp_ops_lock);
+
+	synchronize_rcu();
+}
+
+static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
+{
+	struct bpf_thp_ops *ops = kdata;
+	struct bpf_thp_ops *old = old_kdata;
+
+	if (!ops || !old)
+		return -EINVAL;
+
+	spin_lock(&thp_ops_lock);
+	if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags))
+		goto out;
+	rcu_replace_pointer(bpf_thp.get_suggested_order, ops->get_suggested_order,
+			    lockdep_is_held(&thp_ops_lock));
+
+out:
+	spin_unlock(&thp_ops_lock);
+	synchronize_rcu();
+	return 0;
+}
+
+static int bpf_thp_validate(void *kdata)
+{
+	struct bpf_thp_ops *ops = kdata;
+
+	if (!ops->get_suggested_order) {
+		pr_err("bpf_thp: required ops isn't implemented\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int suggested_order(struct mm_struct *mm, unsigned long vm_flags, int order)
+{
+	return order;
+}
+
+static struct bpf_thp_ops __bpf_thp_ops = {
+	.get_suggested_order = suggested_order,
+};
+
+static struct bpf_struct_ops bpf_bpf_thp_ops = {
+	.verifier_ops = &thp_bpf_verifier_ops,
+	.init = bpf_thp_init,
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
+	int err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
+
+	if (err)
+		pr_err("bpf_thp: Failed to register struct_ops (%d)\n", err);
+	return err;
+}
+late_initcall(bpf_thp_ops_init);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d3e66136e41a..e504b601205f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1328,6 +1328,15 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 		return ret;
 	khugepaged_enter_vma(vma, vma->vm_flags);
 
+	/*
+	 * This check must occur after khugepaged_enter_vma() because:
+	 * 1. We may permit THP allocation via khugepaged
+	 * 2. While simultaneously disallowing THP allocation
+	 *    during page fault handling
+	 */
+	if (get_suggested_order(vma->vm_mm, TVA_IN_PF, PMD_ORDER) != PMD_ORDER)
+		return VM_FAULT_FALLBACK;
+
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm) &&
 			transparent_hugepage_use_zero_page()) {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 15203ea7d007..d0b6c1b20342 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -475,7 +475,8 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    hugepage_pmd_enabled()) {
 		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
-					    PMD_ORDER))
+					    PMD_ORDER) &&
+		    get_suggested_order(vma->vm_mm, 0, PMD_ORDER) == PMD_ORDER)
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
@@ -1448,6 +1449,11 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
 		/* khugepaged_mm_lock actually not necessary for the below */
 		mm_slot_free(mm_slot_cache, mm_slot);
 		mmdrop(mm);
+	} else if (get_suggested_order(mm, 0, PMD_ORDER) != PMD_ORDER) {
+		hash_del(&slot->hash);
+		list_del(&slot->mm_node);
+		clear_bit(MMF_VM_HUGEPAGE, &mm->flags);
+		mm_slot_free(mm_slot_cache, mm_slot);
 	}
 }
 
@@ -2390,6 +2396,10 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 	 * the next mm on the list.
 	 */
 	vma = NULL;
+
+	/* If this mm is not suitable for the scan list, we should remove it. */
+	if (get_suggested_order(mm, 0, PMD_ORDER) != PMD_ORDER)
+		goto breakouterloop_mmap_lock;
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
 
@@ -2407,7 +2417,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			break;
 		}
 		if (!thp_vma_allowable_order(vma, vma->vm_flags,
-					TVA_ENFORCE_SYSFS, PMD_ORDER)) {
+					TVA_ENFORCE_SYSFS, PMD_ORDER) ||
+		    get_suggested_order(vma->vm_mm, 0, PMD_ORDER) != PMD_ORDER) {
 skip:
 			progress++;
 			continue;
@@ -2746,6 +2757,9 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	if (!thp_vma_allowable_order(vma, vma->vm_flags, 0, PMD_ORDER))
 		return -EINVAL;
 
+	if (get_suggested_order(vma->vm_mm, 0, PMD_ORDER) != PMD_ORDER)
+		return -EINVAL;
+
 	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
 	if (!cc)
 		return -ENOMEM;
diff --git a/mm/memory.c b/mm/memory.c
index b0cda5aab398..ff3e4c92a2a2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4375,6 +4375,7 @@ static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
 static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	int order, suggested_order;
 	unsigned long orders;
 	struct folio *folio;
 	unsigned long addr;
@@ -4382,7 +4383,6 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	spinlock_t *ptl;
 	pte_t *pte;
 	gfp_t gfp;
-	int order;
 
 	/*
 	 * If uffd is active for the vma we need per-page fault fidelity to
@@ -4399,13 +4399,16 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	if (!zswap_never_enabled())
 		goto fallback;
 
+	suggested_order = get_suggested_order(vma->vm_mm, TVA_IN_PF, PMD_ORDER - 1);
+	if (!suggested_order)
+		goto fallback;
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	/*
 	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
 	 * and suitable for swapping THP.
 	 */
 	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
-			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
+			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(suggested_order + 1) - 1);
 	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
 	orders = thp_swap_suitable_orders(swp_offset(entry),
 					  vmf->address, orders);
@@ -4933,12 +4936,12 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	int order, suggested_order;
 	unsigned long orders;
 	struct folio *folio;
 	unsigned long addr;
 	pte_t *pte;
 	gfp_t gfp;
-	int order;
 
 	/*
 	 * If uffd is active for the vma we need per-page fault fidelity to
@@ -4947,13 +4950,16 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	if (unlikely(userfaultfd_armed(vma)))
 		goto fallback;
 
+	suggested_order = get_suggested_order(vma->vm_mm, TVA_IN_PF, PMD_ORDER - 1);
+	if (!suggested_order)
+		goto fallback;
 	/*
 	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
 	 * for this vma. Then filter out the orders that can't be allocated over
 	 * the faulting address and still be fully contained in the vma.
 	 */
 	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
-			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
+			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(suggested_order + 1) - 1);
 	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
 
 	if (!orders)
-- 
2.43.5


