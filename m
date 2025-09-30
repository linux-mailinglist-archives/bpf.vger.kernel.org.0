Return-Path: <bpf+bounces-69999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B301EBAB9B7
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 07:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7AB1925C33
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 06:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE0F27F198;
	Tue, 30 Sep 2025 05:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAIjZU+P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A427F012
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211957; cv=none; b=B+xamspOx2Pnnu9xafa/cjDqwebzLzJfqgGBC3sf91SV3LFXxzXv3xSiMOq2Kss9Cle12pUMzbzNHMuA5NkS2iUymJVevjScVmPSDjb05CVUN73AA+H2aV2rPn6wM77mw66DdWn942/GiZp4hpTgDZs8wmyurx9KSPqKaRjg38A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211957; c=relaxed/simple;
	bh=EWSaSgGlB/juKc59Olj/PpxOpjhYRC5Fq9YoPMt6Abg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwXMGXH3WWooewRGlyAzhkzPljkJFJTQ1JVVjpiomOG7C+4gSnQ82EsqVfu9hcKC3JxGewCx9e6WQrmbhdzMNZ6NzSWA23NfGWnx/7nYMxhpTXyrsIjGeUohsV46/A4joRbq+yL644WUHZJyOi2x9Vgf53jCJnr+I+H1pX8iSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAIjZU+P; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-279e2554c8fso56776365ad.2
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 22:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759211954; x=1759816754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pU2SzCsYNRWOhFkPpxF5i6fX6DQXje7k2mX62DbPVIg=;
        b=FAIjZU+PIPf/JbJPiInL6gBjklILs0eEDG97nip2GXzASunDTWhb9y/hGfJyCKy6dv
         uGL6w/oazn/YInNXmz/AVQMQMfPNXeQYmaROjvm/5SvisXXP6xDuIj8xd9YmISA+fAag
         7Ke7FOi4mPWrIi4l7zsRNJx8r/5PnPreFont9WP0u4/9VTuSQoU6FvNCrC0bLB0HDDzA
         MEthJOhHb+m96wwvojUv1c1cdiY/WKQx50ozb3gX1DeSMJ9n+bp6pGhy0LqX3U6CMVT8
         JnajaY2iZNKsRCK1u7o2sE2u3TDJ5KNc8rXc5l3nWJo0BP0PCTN5Y8LoHg/yt1rbIUQ9
         su0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211954; x=1759816754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pU2SzCsYNRWOhFkPpxF5i6fX6DQXje7k2mX62DbPVIg=;
        b=onocQOgnxpcqyIl3MvK6LUHIZ86jr+jzVnNiwNNkQNeM6pCGPIFiDoO23rv/PwiKiD
         oJSsKEb7e4QFK7Jsx5zBwbKQOYyBzdZwmTgiNf2ZERSYg6W8ZSNR1+I9PfgVWQFZwCWZ
         gz8NmytmiUu0V2/ky7nPDUNteMZt06rWbDM9myBQPQc8XnbAHg/DpXoTw+/pNOBkkraO
         dJm2yU5RP09vJ52xOfzPxKP4dtEYZoKOlWtEMtePPIe+81ffS1Qh2e598hsb3qWu4H6P
         GMYK6p1XowNg+OmtueUO/w1s1FievQ1L16YO8yIFx+OjyaMMH+aMIBBVdiW/76xsasg/
         a2Qg==
X-Gm-Message-State: AOJu0YwhzTbThIf0BCkhah5tl/J+yoENHsu40H2uMJIFRwiTVq2DgMso
	v/VshooCFa7GLx3PFH1gNmvMV8zNsk1YvQKI1WN07RIHFOCP36AvZYc6
X-Gm-Gg: ASbGncvJSIR/leI63W30rsBKLOxWOBOgxqiT+SKd8c50Oce132V6tML395xczFZa/6n
	PXSALhETRCsZ+qDEUwi2JWvobPDp3StKrN4fvbhh3F59o2Xkvq6cPl2dzqmiusUFsKEdEfkuxyc
	uiEIr11KaWqGMRLO515l5tDBop7cdLZJlz6WCTuUAuBOJCzo+77Px90DSUKPxiqgUBKYSxI6bIk
	nEcLPeGywr97b6bGMLhRk92deUrhZHlIYOVcFqUvrvP/c7HFTV+PN0YL1ZptA1RAVjI9jovTgC6
	jifAh04ZR+pxs3PhqDH7bbDQomxXtuFWyxqfVW29JeHLRg4qfQNj0hYUNGIMRmEyEIl54dQiLdx
	MlBrQpk9LCzoMfPYfSQ4W6LLZxG66wfTL3v0mJ0yR9LjdNd23sXHI1YiagdURbK/MIKsKuIXmqM
	HNzGooSLGW0bWm04VEKlVuxAkUXuQ=
X-Google-Smtp-Source: AGHT+IFpB1ELcmxl96OYKyLCQ93t55yCZz/ljq5ccARZ0IQJmhLOUbqZtdM1H5tzU1i/eB4FY2S1gw==
X-Received: by 2002:a17:903:3586:b0:268:cc5:5e4e with SMTP id d9443c01a7336-27ed4a06de2mr192026365ad.1.1759211953994;
        Mon, 29 Sep 2025 22:59:13 -0700 (PDT)
Received: from localhost.localdomain ([61.171.228.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm148834065ad.9.2025.09.29.22.59.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 22:59:13 -0700 (PDT)
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
	Yafang Shao <laoar.shao@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP order selection
Date: Tue, 30 Sep 2025 13:58:18 +0800
Message-Id: <20250930055826.9810-4-laoar.shao@gmail.com>
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

This feature requires CONFIG_BPF_THP (EXPERIMENTAL) to be enabled. Note
that this capability is currently unstable and may undergo significant
changes—including potential removal—in future kernel versions.

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 MAINTAINERS             |   1 +
 include/linux/huge_mm.h |  23 +++++
 mm/Kconfig              |  11 +++
 mm/Makefile             |   1 +
 mm/huge_memory_bpf.c    | 204 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 240 insertions(+)
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
index a635dcbb2b99..02055cc93bfe 100644
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
 
+#ifdef CONFIG_BPF_THP
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
index bde9f842a4a8..ffbcc5febb10 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -895,6 +895,17 @@ config NO_PAGE_MAPCOUNT
 
 	  EXPERIMENTAL because the impact of some changes is still unclear.
 
+config BPF_THP
+	bool "BPF-based THP Policy (EXPERIMENTAL)"
+	depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
+
+	help
+	  Enable dynamic THP policy adjustment using BPF programs. This feature
+	  is currently experimental.
+
+	  WARNING: This feature is unstable and may change in future kernel
+	  versions.
+
 endif # TRANSPARENT_HUGEPAGE
 
 # simple helper to make the code a bit easier to read
diff --git a/mm/Makefile b/mm/Makefile
index 21abb3353550..4efca1c8a919 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
+obj-$(CONFIG_BPF_THP) += huge_memory_bpf.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
new file mode 100644
index 000000000000..47c124d588b2
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
+	if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
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


