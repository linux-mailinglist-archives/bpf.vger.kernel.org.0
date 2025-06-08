Return-Path: <bpf+bounces-60005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C91AD1175
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 09:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69E516A0CE
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 07:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3221F4C94;
	Sun,  8 Jun 2025 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8zglZ2A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80883E573
	for <bpf@vger.kernel.org>; Sun,  8 Jun 2025 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749368186; cv=none; b=Bl3ee2Gp0aa0AiJ9idOnlW9fCbdkO1qgFDfaJu9P6mTLVRZFc3afrVnhHA2ZFKt5T58VbmrTm2ZaVduin7e8gb75tRwc3a1A8zAQgSdXdpTZsTY4k62Tnh6ikoOP6Moo+Cy+HPVhAVk+GAb8HtxzKcSJGxBgOZdl6itOjtzHUWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749368186; c=relaxed/simple;
	bh=VUqwuEMrSCnuaAxfnzru1Z74GodBx2NIDVP4bE5+mzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qTu0pls+N+nMKuf5i1ZJPRVppVLCrMQyKN/wYqEClFO7nHBGMTD8y9odCiavBwLBjJUBseV6Hyy1NE7HzSJNBGV+QX50HVIpa/jh9fT6DRlCIyuFBTarTJG36KCgfTa71U65XJycdrHM5Cj5ACaOKuF6pRP41RuTGv4VT+rSULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8zglZ2A; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234c5b57557so30686245ad.3
        for <bpf@vger.kernel.org>; Sun, 08 Jun 2025 00:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749368184; x=1749972984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Om/soDdlb1irFSyjr02L7f3XW+ZfYX9+/hWOK174JY=;
        b=S8zglZ2AoWSZH22YDO8dUe8wH46YhPNVbP3BVo8xAHjkZ7bEC0PRTyAp4A410/l0eg
         r1PuBagkvjwvuf1K+i+hfP+h/AfNdCDHvV9th4Q6iVA86Ooqs6vTAzaQLHcbm1siUySx
         9dHy/VFG9TvPSU2/xtn53QUzNmNcItr5vagt/jvyEzFdA/koBADNexyC86U3EWdCqJfQ
         hpTSfF9tm6X6zSz3J9ifLyRm+qXOMhscvquhFfK6AKXmFSUrSXP5Omn2DBKrmrV/4FpH
         kTpHFwA31QvMqUA8kBLbCNhzMOjA++sqrtBOJxD4qO4hR1gWn+qkTmQtQW5L3HRHGqBr
         /zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749368184; x=1749972984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Om/soDdlb1irFSyjr02L7f3XW+ZfYX9+/hWOK174JY=;
        b=pvebfNh//ItCEX2T1hmgCclv0SZTaoTCyIuo5U/Dt+Vhqvjq0zwtK9ooJFEAILmd5k
         S1unz4Q2Yrfc+SS3J8zZbtPqJmsHMkBayUD7rex898XMJt+s/JToxX+NSQWmngHZ3G0d
         V8zqTbhBsVtPC1d9mXw3ZP59lwbazu9HlkO8fcehGfE+UAHBvTvxyA4PgwI7st3ILfm0
         BYyEAlZkSxHw0mfk3sVlW4rOUk5MwKP5yCOunt7v4lHayMwR+u48jyb7drfE0fCuvxZv
         tiTGDg4YnJdo2kDZzV6IXkBby3tvVFaOuN8jSu5gfJ0+PeBqbnqzANMBgCY8EnoGK1QT
         yDLA==
X-Gm-Message-State: AOJu0Ywi3ylvJZEv81K3utbWNGwxXjYC5OPYw0o6d/mLQkptw4VSFDEd
	5kutj9NPYM170iK/4ixaPZPvXCdk3J3vcKorpNQZVsBH7VlC+Py98MHH
X-Gm-Gg: ASbGncsmvb/2dotDzm2WUyNG5jm4BUfVmsTYP/nY69OAXQj+lgHwYh8//mFF3M3l09k
	YTudGcdz1kluFsnnqpWjLqSJdKTSj/DV+0sgPdMzVc98sxNRMq8iWAVbStKATJQ1dDXZNCGSYBl
	A7ijbGpUwlF49Sq4UIuVXKXvZf8s+QherkILO9OWlnPplghuG6dV9YKoDV7PSf9fpfrX08+Ksbs
	pc1CNY87l8zZDON55jC54cKtOunKlIuxuigyvarVrxFH8e7kRIXqTEITfiVJy501aMG7iOm3Niz
	aNkSL38+TU5yy52yX2gDjrjjydKYZoWHhULXteYsNzTcylVZlHEdmgI3NLjgDONTW4aqZTtGnME
	=
X-Google-Smtp-Source: AGHT+IEFc5S1UisQmcqD08/fo40gZbWFkNW0G+aVNGeaRx/g3WCuw3RQL35rBd2EOVk2O6yocWSgUw==
X-Received: by 2002:a17:902:f686:b0:234:aa9a:9e0f with SMTP id d9443c01a7336-23601d21231mr136980265ad.23.1749368183703;
        Sun, 08 Jun 2025 00:36:23 -0700 (PDT)
Received: from localhost.localdomain ([39.144.124.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236035069c3sm35968135ad.234.2025.06.08.00.36.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Jun 2025 00:36:23 -0700 (PDT)
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
Subject: [RFC PATCH v3 4/5] mm: thp: add bpf thp struct ops
Date: Sun,  8 Jun 2025 15:35:15 +0800
Message-Id: <20250608073516.22415-5-laoar.shao@gmail.com>
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

A new bpf_thp struct ops is introduced to provide finer-grained control
over THP allocation policy. The struct ops includes two APIs for
determining the THP allocator and reclaimer behavior:

- THP allocator

  int (*allocator)(unsigned long vm_flags, unsigned long tva_flags);

  The BPF program returns either THP_ALLOC_CURRENT or THP_ALLOC_KHUGEPAGED,
  indicating whether THP allocation should be performed synchronously
  (current task) or asynchronously (khugepaged).

  The decision is based on the current task context, VMA flags, and TVA
  flags.

- THP reclaimer

  int (*reclaimer)(bool vma_madvised);

  The BPF program returns either RECLAIMER_CURRENT or RECLAIMER_KSWAPD,
  determining whether memory reclamation is handled by the current task or
  kswapd.

  The decision depends on the current task and VMA flags.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/huge_mm.h |  13 +--
 mm/Makefile             |   3 +
 mm/bpf_thp.c            | 184 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 10 deletions(-)
 create mode 100644 mm/bpf_thp.c

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 6a40ebf25f5c..0d02c9b56a85 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -54,6 +54,7 @@ enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
 	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
 	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
+	TRANSPARENT_HUGEPAGE_BPF_ATTACHED,	/* BPF prog is attached */
 };
 
 struct kobject;
@@ -192,16 +193,8 @@ static inline bool hugepage_global_always(void)
 
 #define THP_ALLOC_KHUGEPAGED (1 << 1)
 #define THP_ALLOC_CURRENT (1 << 2)
-static inline int bpf_thp_allocator(unsigned long vm_flags,
-				     unsigned long tva_flags)
-{
-	return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
-}
-
-static inline gfp_t bpf_thp_gfp_mask(bool vma_madvised)
-{
-	return 0;
-}
+int bpf_thp_allocator(unsigned long vm_flags, unsigned long tva_flags);
+gfp_t bpf_thp_gfp_mask(bool vma_madvised);
 
 static inline int highest_order(unsigned long orders)
 {
diff --git a/mm/Makefile b/mm/Makefile
index 1a7a11d4933d..e5f41cf3fd61 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -99,6 +99,9 @@ obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
+ifdef CONFIG_BPF_SYSCALL
+obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += bpf_thp.o
+endif
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
new file mode 100644
index 000000000000..894d6cb93107
--- /dev/null
+++ b/mm/bpf_thp.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/huge_mm.h>
+#include <linux/khugepaged.h>
+
+#define RECLAIMER_CURRENT (1 << 1)
+#define RECLAIMER_KSWAPD (1 << 2)
+#define RECLAIMER_BOTH (RECLAIMER_CURRENT | RECLAIMER_KSWAPD)
+
+struct bpf_thp_ops {
+	/**
+	 * @allocator: Specifies whether the THP allocation is performed
+	 * by the current task or by khugepaged.
+	 * @vm_flags: Flags for the VMA in the current allocation context
+	 * @tva_flags: Flags for the TVA in the current allocation context
+	 *
+	 * Rerurn:
+	 * - THP_ALLOC_CURRENT: THP was allocated synchronously by the calling
+	 *   task's context.
+	 * - THP_ALLOC_KHUGEPAGED: THP was allocated asynchronously by the
+	 *   khugepaged kernel thread.
+	 * - 0: THP allocation is disallowed in the current context.
+	 */
+	int (*allocator)(unsigned long vm_flags, unsigned long tva_flags);
+	/**
+	 * @reclaimer: Specifies the entity performing page reclaim:
+	 *             - current task context
+	 *             - kswapd
+	 *             - none (no reclaim)
+	 * @vma_madvised: MADV flags for this VMA (e.g., MADV_HUGEPAGE, MADV_NOHUGEPAGE)
+	 *
+	 * Return:
+	 * - RECLAIMER_CURRENT: Direct reclaim by the current task if THP
+	 *   allocation fails.
+	 * - RECLAIMER_KSWAPD: Wake kswapd to reclaim memory if THP allocation fails.
+	 * - RECLAIMER_ALL: Both current and kswapd will perform the reclaim
+	 * - 0: No reclaim will be attempted.
+	 */
+	int (*reclaimer)(bool vma_madvised);
+};
+
+static struct bpf_thp_ops bpf_thp;
+
+int bpf_thp_allocator(unsigned long vm_flags, unsigned long tva_flags)
+{
+	int allocator;
+
+	/* No BPF program is attached */
+	if (!(transparent_hugepage_flags & (1<<TRANSPARENT_HUGEPAGE_BPF_ATTACHED)))
+		return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
+
+	if (current_is_khugepaged())
+		return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
+	if (!bpf_thp.allocator)
+		return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
+
+	allocator = bpf_thp.allocator(vm_flags, tva_flags);
+	if (!allocator)
+		return 0;
+	/* invalid return value */
+	if (allocator & ~(THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT))
+		return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;
+	return allocator;
+}
+
+gfp_t bpf_thp_gfp_mask(bool vma_madvised)
+{
+	int reclaimer;
+
+	if (!(transparent_hugepage_flags & (1<<TRANSPARENT_HUGEPAGE_BPF_ATTACHED)))
+		return 0;
+
+	if (!bpf_thp.reclaimer)
+		return 0;
+
+	reclaimer = bpf_thp.reclaimer(vma_madvised);
+	switch (reclaimer) {
+	case RECLAIMER_CURRENT:
+		return GFP_TRANSHUGE | __GFP_NORETRY;
+	case RECLAIMER_KSWAPD:
+		return GFP_TRANSHUGE_LIGHT | __GFP_KSWAPD_RECLAIM;
+	case RECLAIMER_BOTH:
+		return GFP_TRANSHUGE | __GFP_KSWAPD_RECLAIM | __GFP_NORETRY;
+	default:
+		return 0;
+	}
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
+static int bpf_thp_reg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_thp_ops *ops = kdata;
+
+	/* TODO: add support for multiple attaches */
+	if (test_and_set_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
+		&transparent_hugepage_flags))
+		return -EOPNOTSUPP;
+	bpf_thp.allocator = ops->allocator;
+	bpf_thp.reclaimer = ops->reclaimer;
+	return 0;
+}
+
+static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
+{
+	clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags);
+	bpf_thp.allocator = NULL;
+	bpf_thp.reclaimer = NULL;
+}
+
+static int bpf_thp_check_member(const struct btf_type *t,
+				const struct btf_member *member,
+				const struct bpf_prog *prog)
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
+static int bpf_thp_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int allocator(unsigned long vm_flags, unsigned long tva_flags)
+{
+	return 0;
+}
+
+static int reclaimer(bool vma_madvised)
+{
+	return 0;
+}
+
+static struct bpf_thp_ops __bpf_thp_ops = {
+	.allocator = allocator,
+	.reclaimer = reclaimer,
+};
+
+static struct bpf_struct_ops bpf_bpf_thp_ops = {
+	.verifier_ops = &thp_bpf_verifier_ops,
+	.init = bpf_thp_init,
+	.check_member = bpf_thp_check_member,
+	.init_member = bpf_thp_init_member,
+	.reg = bpf_thp_reg,
+	.unreg = bpf_thp_unreg,
+	.name = "bpf_thp_ops",
+	.cfi_stubs = &__bpf_thp_ops,
+	.owner = THIS_MODULE,
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
-- 
2.43.5


