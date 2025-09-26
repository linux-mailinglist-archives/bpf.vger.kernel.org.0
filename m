Return-Path: <bpf+bounces-69815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45E3BA32AE
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 11:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F44189D13E
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 09:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A9C2BE05E;
	Fri, 26 Sep 2025 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmMB9PIb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279329DB64
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879268; cv=none; b=C/p1ceyqapU6Vzd6ThCyzs3AuXht0fN5epmy1HXDCYahCNyOWXJfB80EUnatnbce6QW+pkclvDWJRLzCAGjIvQ/0dU7lJ6Q3dwEz58vn+LHYmEHyWfdFSKuxPIX2xEBwSDKuppkR5y9AHlSJKnIRvqKXTZUaOKzQOhEVMl+mpa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879268; c=relaxed/simple;
	bh=4v9yMqRUMsAdx9XCDbFbul+4a5Y+QacQbFmQAXupXGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l20mLgA90Qi94MwGb1db85CnMhTHTt1JYutdaR2I4iP6Rh2ppU0/qJqqNfd8a3BFWlRrfEX6te9SqT6HBRn9P3Eed32rNdQOAS4JUNmzqOP2gbhhE4btI5C05EIvrL3MMzau6HLymC5rJVIxU0Fd4LhjncLRyPyLkUY3u4XvXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmMB9PIb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-267f0fe72a1so16102375ad.2
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 02:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879266; x=1759484066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jB3qqE2os1Bz2apgpHhR6iMBcRyPEQoOLursDIPNCnw=;
        b=TmMB9PIbLShL4fDCszXVMMe7DlT5vf8vBx1HaBP4MD0KxkDNO8FJnvEYGFfAbzlSCy
         /j9JgfhvhvaRcVPNifMM3dhlNT5hegURb9L7HlyjbAC7DyVwTk/Dq/Bgsa4pGyyGF/99
         iIfCQBPZPWBl5L428edBpFzflLAAuJaoIbs8iRaLCk1sxOC+D3LXHxA3TIVxzWaIPyUE
         DMlKYhfL1xJuFs93Y/1vdbSr4KNgd1ZOxjBDif49lDNBtUS+nUqApQ5mmxJInZYzLcM8
         7uy/sE6kY8IIvYEXEc4erURcPdmRHBYz4L+q/i24zVBaSO/E/GCX4WFKuONWo5Nuw4U6
         1KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879266; x=1759484066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jB3qqE2os1Bz2apgpHhR6iMBcRyPEQoOLursDIPNCnw=;
        b=Vvv0O/+AE4h0fWRQvVDdnuPJJatY564D2KuN9kwRaeW7mduZZ8PTq4x3BYJ5mvQRvy
         2oquCvRo31JoIhq24R2FjulIUJ5GzR+02RW/armmnriVRurzM6+XoMWr+dDNl9oMhPKT
         K//lUIMVlD9PX8E+d4SCYSTlI5905ILjG82WA3B5fB3dA1c4uegw6Q7xEIXaXVwVyVBp
         LyyZGH1rrcK/KWdnmt/oW2BHZ6JAgfLn4+P3SaMZX3nsZIM6m+E02NxpAy4uo74RVT7O
         FkEQJk5CSMhv/4sNeJCdLLJHRC8V288MQE8JCP9HnfyHbqD2lV70TW1afjCi/yg2HF4O
         YBmg==
X-Gm-Message-State: AOJu0Yw8v4LDoVZqtxxN14KtCTMEE+bpLnhmWfWqH3kih2GjvtsdDvbt
	PbtTvK2TndzZ1YEQfTUgpv93owbYNEjFy0Su5qiYLhBYB3U2XfwM6uUY
X-Gm-Gg: ASbGncsVXWuZa+holbE6jCfRGCQXV+wGQD6exStZ1lV9nKe4KRSHb98YY753ulAHLZ5
	1CfVMODLaG4eu5XCsZHqsKq5mvzDyqwQJeLKOrWhlpK3/DVmeNSusbpuyHXxF4X5zwO7n4/lU3K
	JdIHrbTaZGdsHCqNUJvRJrnhx1zoGUiiRjY+h311iN3jeak+o4mluiJgwRa2plaVVwALp11wIT5
	7YG9NJplTdSxIKTt6TSKKpDyJZSMpnKwytKqejl6gCIO/4ugfUqktUK7DO4smx2OXCBvcNuQGOH
	Smt/N/ndkpTvPOlVHUCNG/1THZu0bccS7yp/fJFx7sw8AFZVKiIAaHmigyRZIW2cfMK6C3kGIhO
	SZJVt1IL/RK3pYItptgelCOV51nR9ABcCzqOVLFWki71LpQfEamh+EVv/7fm5G6Pvc6CbnIRmYn
	2qluuMmpVvg8NhSk66SobjR/0=
X-Google-Smtp-Source: AGHT+IGHvI1bbsOR3nSZZZLQ9842geVwDh30Zh6/XJrKPJQQbUmczO+WQSUozaPrlC9pjQUW3P6u0A==
X-Received: by 2002:a17:902:f785:b0:274:6d95:99d2 with SMTP id d9443c01a7336-27ed4a2d5d2mr76014615ad.39.1758879266182;
        Fri, 26 Sep 2025 02:34:26 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1c21:566:e1d1:c082:790c:7be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm49247475ad.25.2025.09.26.02.34.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:34:25 -0700 (PDT)
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
Subject: [PATCH v8 mm-new 04/12] mm: thp: add support for BPF based THP order selection
Date: Fri, 26 Sep 2025 17:33:35 +0800
Message-Id: <20250926093343.1000-5-laoar.shao@gmail.com>
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
 * thp_order_fn_t: Get the suggested THP order from a BPF program for allocation
 * @vma: vm_area_struct associated with the THP allocation
 * @type: TVA type for current @vma
 * @orders: Bitmask of available THP orders for this allocation
 *
 * Return: The suggested THP order for allocation from the BPF program. Must be
 *         a valid, available order.
 */
typedef int thp_order_fn_t(struct vm_area_struct *vma,
			   enum tva_type type,
			   unsigned long orders);

Only a single BPF program can be attached at any given time, though it can
be dynamically updated to adjust the policy. The implementation supports
anonymous THP, shmem THP, and mTHP, with future extensions planned for
file-backed THP.

This functionality is only active when system-wide THP is configured to
madvise or always mode. It remains disabled in never mode. Additionally,
if THP is explicitly disabled for a specific task via prctl(), this BPF
functionality will also be unavailable for that task.

This BPF hook enables the implementation of flexible THP allocation
policies at the system, per-cgroup, or per-task level.

This feature requires CONFIG_BPF_THP_GET_ORDER_EXPERIMENTAL to be
enabled. Note that this capability is currently unstable and may undergo
significant changes—including potential removal—in future kernel versions.

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 MAINTAINERS             |   1 +
 include/linux/huge_mm.h |  23 +++++
 mm/Kconfig              |  12 +++
 mm/Makefile             |   1 +
 mm/huge_memory_bpf.c    | 204 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 241 insertions(+)
 create mode 100644 mm/huge_memory_bpf.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ca8e3d18eedd..7be34b2a64fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16257,6 +16257,7 @@ F:	include/linux/huge_mm.h
 F:	include/linux/khugepaged.h
 F:	include/trace/events/huge_memory.h
 F:	mm/huge_memory.c
+F:	mm/huge_memory_bpf.c
 F:	mm/khugepaged.c
 F:	mm/mm_slot.h
 F:	tools/testing/selftests/mm/khugepaged.c
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a635dcbb2b99..fea94c059bed 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -56,6 +56,7 @@ enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
 	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
+	TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached */
 };
 
 struct kobject;
@@ -269,6 +270,23 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 enum tva_type type,
 					 unsigned long orders);
 
+#ifdef CONFIG_BPF_THP_GET_ORDER_EXPERIMENTAL
+
+unsigned long
+bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type type,
+			unsigned long orders);
+
+#else
+
+static inline unsigned long
+bpf_hook_thp_get_orders(struct vm_area_struct *vma, enum tva_type type,
+			unsigned long orders)
+{
+	return orders;
+}
+
+#endif
+
 /**
  * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
  * @vma:  the vm area to check
@@ -290,6 +308,11 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 {
 	vm_flags_t vm_flags = vma->vm_flags;
 
+	/* The BPF-specified order overrides which order is selected. */
+	orders &= bpf_hook_thp_get_orders(vma, type, orders);
+	if (!orders)
+		return 0;
+
 	/*
 	 * Optimization to check if required orders are enabled early. Only
 	 * forced collapse ignores sysfs configs.
diff --git a/mm/Kconfig b/mm/Kconfig
index bde9f842a4a8..fd7459eecb2d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -895,6 +895,18 @@ config NO_PAGE_MAPCOUNT
 
 	  EXPERIMENTAL because the impact of some changes is still unclear.
 
+config BPF_THP_GET_ORDER_EXPERIMENTAL
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
index 21abb3353550..62ebfa23635a 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
+obj-$(CONFIG_BPF_THP_GET_ORDER_EXPERIMENTAL) += huge_memory_bpf.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
new file mode 100644
index 000000000000..b59a65d70a93
--- /dev/null
+++ b/mm/huge_memory_bpf.c
@@ -0,0 +1,204 @@
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
+/**
+ * @thp_order_fn_t: Get the suggested THP order from a BPF program for allocation
+ * @vma: vm_area_struct associated with the THP allocation
+ * @type: TVA type for current @vma
+ * @orders: Bitmask of available THP orders for this allocation
+ *
+ * Return: The suggested THP order for allocation from the BPF program. Must be
+ *         a valid, available order.
+ */
+typedef int thp_order_fn_t(struct vm_area_struct *vma,
+			   enum tva_type type,
+			   unsigned long orders);
+
+struct bpf_thp_ops {
+	thp_order_fn_t __rcu *thp_get_order;
+};
+
+static struct bpf_thp_ops bpf_thp;
+static DEFINE_SPINLOCK(thp_ops_lock);
+
+unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
+				      enum tva_type type,
+				      unsigned long orders)
+{
+	thp_order_fn_t *bpf_hook_thp_get_order;
+	int bpf_order;
+
+	/* No BPF program is attached */
+	if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
+		      &transparent_hugepage_flags))
+		return orders;
+
+	rcu_read_lock();
+	bpf_hook_thp_get_order = rcu_dereference(bpf_thp.thp_get_order);
+	if (!bpf_hook_thp_get_order)
+		goto out;
+
+	bpf_order = bpf_hook_thp_get_order(vma, type, orders);
+	orders &= BIT(bpf_order);
+
+out:
+	rcu_read_unlock();
+	return orders;
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
+			     enum tva_type type,
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


