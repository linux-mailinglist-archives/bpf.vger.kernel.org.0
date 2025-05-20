Return-Path: <bpf+bounces-58522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7DEABCEF6
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 08:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7308A1B66078
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 06:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989BD25B676;
	Tue, 20 May 2025 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL1LpYDU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930472571AE
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747721182; cv=none; b=fhAKQZiBy4YUMILMYzWRgzUrE5IMlpiJfEeUlHXfioN4/e0G4Ws9NC+a7DA/V6fjwFILfSq7ykOjz4wdT/9gSuZoEzTZHW+MVzaYD9aOTzxalqDynsqYKKWyeHOjmrRdUrauF3hwbPBXZGkz0X/aNGdpc1b3N/3IK+Ik/4hUWCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747721182; c=relaxed/simple;
	bh=KPGcmP061qaxayyw5oy2PS5+JWW3c+97qH1gT5oR9es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kX02N79XbKI5iRD7Ab3CeQesy7PJatffo2D2fJaNEietKxUW4qj5s8SPXMMM2ggdS4+4t+LiHEiKtHDApAADioooRR4+9EjrCOSwmoGMun/HA+JRbQLSQ00Sb5WM4s6JNqY74Gov+HyBHAVDHYtSRDrjhxLxD0/hnSs8HO8wghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL1LpYDU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30e7bfef364so3793003a91.1
        for <bpf@vger.kernel.org>; Mon, 19 May 2025 23:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747721180; x=1748325980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMBA7d6UZalbeb3iJQhCyUuvULAsLBrIg9tSXAts4m0=;
        b=VL1LpYDUvxJoU8y/w7BMOk3FSIJMlnGVXp83Xdiz4io0mq9Cpro70lWxGU+j8RhlfH
         1jiUgClVfdINju44gu7rQ931l6vc6y6jrSrXnA/lLKTNkNJfDCg638pYi4WXvDjaDEUi
         fAs/rPabyIquHGfPK1aD8Zt5+rOwISZJrjR/nuVhA/lNEDMNFuwrqPkR4tiF5mEwwuoq
         G8zkC2135JgDyq0kO6TAiotr8rDuyNyAyET9Rj4CfG5c3ev7BLGlRXXaJTZc7f7t8HuV
         W4yULoVPaqauNKiU6paq2KRHPouhNr5XS6BXbkZ8fyVWOIMC4JfO1UUHxhOfC85fZppC
         cylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747721180; x=1748325980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMBA7d6UZalbeb3iJQhCyUuvULAsLBrIg9tSXAts4m0=;
        b=dWFeA4r6puk0aec1F70WeKwKkuKW3SQqWMJlqxO4dDhjaBHSCxJ+IiNWWwIe8g6Z2c
         yJkzkeMGKetEtDkI5Y99kQ8bYwKGWDhuhOLDxKPPa9nTunohkARq+dk+2s2gR9xaV7VZ
         A03WsQkNfmIDZ9fdUYypXEN/5TUbSKvLDwgun7onIvTiwT+DZPJE5gt0NHP/MxEpKclb
         U1e8I0JrHOeQwOUxTHQ3+Lh545WB0iR2w0y3/18JpHOXtOW0nicqG6MvNUH0Wo9Finyi
         +HscAshQbzTGlmD9eKLS58EE8m9KRPobk7yB44MfXSZ6RPNtwxte7TsV4fRc/DBZPOHM
         q2TA==
X-Gm-Message-State: AOJu0YxeHn8RxJYJHVPlwwKsxiPPkasucPMSY0WmhN5ITfnqFMZCMdX3
	M4ca7ihutkqRChqXf360fZ5fhhpfMPBmgWqZBpQ7ZYX/cksaWdUV02q5
X-Gm-Gg: ASbGncvRwtAjNz+a8Pey580HG+1dvu0vKbceocHypBe888m8YD3BWPf1qvu93sYd+mR
	vVx2SCFI8MrZZC37YxHIEtyhwDvMK5IvoPuL/P/DGS/GCAIWaCTJF0DmMwavRUPZjH0bJSvkuzm
	LIN8ZHqPCzViiWxm20RI5wU7YfHYzYXkSIZhWPUXtRZHUeNeQ0cT+ApEZKdagD3AslaFsly2vIT
	VRgPxjX4rrxY0Pw+UC4oP/EEQpf597X1dSe0OSG8OWY6TMhcZRcnsSu6A4Vi928LqIsERyPVy7s
	gQR+i53T2/4EYT67ewJphtKZ05FEluvFJD6BTwf/yMeheDpCk9GqWbRRX8dCOqUytnsRQIIO9qQ
	=
X-Google-Smtp-Source: AGHT+IFoo08Y61pkP9GewiXExlx7Tav+LS5zb//iA1K/M3XCeG6QBragcDGBxhCdcTYC4l6AG5zWqQ==
X-Received: by 2002:a17:90b:1d4f:b0:2fe:b470:dde4 with SMTP id 98e67ed59e1d1-30e7d50b00amr30918692a91.12.1747721179547;
        Mon, 19 May 2025 23:06:19 -0700 (PDT)
Received: from localhost.localdomain ([39.144.103.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36385e91sm823428a91.12.2025.05.19.23.06.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 May 2025 23:06:19 -0700 (PDT)
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
Subject: [RFC PATCH v2 3/5] mm: thp: add struct ops for BPF based THP adjustment
Date: Tue, 20 May 2025 14:05:01 +0800
Message-Id: <20250520060504.20251-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250520060504.20251-1-laoar.shao@gmail.com>
References: <20250520060504.20251-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a minimal struct_ops for BPF-based THP adjustment.

Currently, only a single BPF program can be attached. Support for multiple
attachments will be added in the future.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/huge_mm.h |  13 +----
 mm/Makefile             |   3 +
 mm/bpf_thp.c            | 120 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 12 deletions(-)
 create mode 100644 mm/bpf_thp.c

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fedb5b014d9a..a75f5f902af0 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -193,18 +193,7 @@ static inline bool hugepage_global_always(void)
 			(1<<TRANSPARENT_HUGEPAGE_FLAG);
 }
 
-static inline bool hugepage_bpf_allowable(void)
-{
-	/* Works only for BPF mode */
-	if (!(transparent_hugepage_flags & (1<<TRANSPARENT_HUGEPAGE_REQ_BPF_FLAG)))
-		return 0;
-
-	/* No BPF program is attached */
-	if (!(transparent_hugepage_flags & (1<<TRANSPARENT_HUGEPAGE_BPF_ATTACHED)))
-		return 0;
-	/* We will add struct ops in the future */
-	return 1;
-}
+bool hugepage_bpf_allowable(void);
 
 static inline bool hugepaged_bpf_allowable(void)
 {
diff --git a/mm/Makefile b/mm/Makefile
index e7f6bbf8ae5f..c355f9426c93 100644
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
index 000000000000..690980cdb4da
--- /dev/null
+++ b/mm/bpf_thp.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/huge_mm.h>
+
+struct bpf_thp_ops {
+	/**
+	 * @thp_bpf_allowable: Determines whether a task is permitted to
+	 * allocate a THP when it is allocating anon memory.
+	 *
+	 * Return: %true if THP allocation is allowed, %false otherwise.
+	 */
+	bool (*thp_bpf_allowable)(void);
+};
+
+static struct bpf_thp_ops bpf_thp;
+
+bool hugepage_bpf_allowable(void)
+{
+	/* Works only for "bpf" mode */
+	if (!(transparent_hugepage_flags & (1<<TRANSPARENT_HUGEPAGE_REQ_BPF_FLAG)))
+		return 0;
+
+	/* No BPF program is attached */
+	if (!(transparent_hugepage_flags & (1<<TRANSPARENT_HUGEPAGE_BPF_ATTACHED)))
+		return 0;
+
+	/* BPF adjustment hook */
+	if (bpf_thp.thp_bpf_allowable)
+		return bpf_thp.thp_bpf_allowable();
+	return 0;
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
+	bpf_thp.thp_bpf_allowable = ops->thp_bpf_allowable;
+	return 0;
+}
+
+static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
+{
+	clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags);
+	bpf_thp.thp_bpf_allowable = NULL;
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
+static bool thp_bpf_allowable(void)
+{
+	return 0;
+}
+
+static struct bpf_thp_ops __bpf_thp_ops = {
+	.thp_bpf_allowable = thp_bpf_allowable,
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


