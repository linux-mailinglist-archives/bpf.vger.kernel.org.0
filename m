Return-Path: <bpf+bounces-56884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FDFAA0003
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 04:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741FF462F6B
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 02:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D2129CB4F;
	Tue, 29 Apr 2025 02:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lisQTigj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520A92FB2
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 02:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745894515; cv=none; b=A49dgAj6KjSmw/t4bPXU+LOsi3l6TOh3w7CvP5q58lzygubYU53iewstCe9RWiG+ZzVaUF0OEOsSNUSbDBUth92/tg9FPciaVzy16BIw7ZyGYqZar8kqyAzz/uxl8Jlid30DlxWz9LJs3k5YjfmZnAs6mxiwI6H+fqfd2HQFmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745894515; c=relaxed/simple;
	bh=TOFuEu9hJZX6EPTvbUbdTG8RZCpsfiEqSVbeZiOsDN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9zi3BWGRTC6WIp7FJG0kKcVEz9EzVMt563OuEpTR6Vn7gHZzl4W3pud+6JGzGHkwB2JigzH6FqqLAVkwgwpBcwV2DSHqwfkTgexeWloprwDZILrIivpqB5sH+i80l1v0SLveTmwQRv9Jp9CuAaLL+HYBi3KZH6D04rOZEc2I/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lisQTigj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-301e05b90caso6113600a91.2
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 19:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745894513; x=1746499313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waacX/lXsmFSOHeLxxTGTjSLf8mXp5UdS3vwhftA+Os=;
        b=lisQTigjtS9Vg5YoxGPdpAvAtJCZ4yTw3LrzMeuN+HQM5Ue8ETv/UfaFsqMYifNbFe
         IOXzvMeSa4hRwCSDO2TNY+5YBkgONog1QvRsDduv+Uu7HORacGJvfa0W005QF22vOkCL
         5PEwFkR5DfUuR3UKMC2jmAvl50JiXjGKBrbv9Ya3Zz8N2Ap+aW6Fw2IOPF0B4vub3CKG
         wgeJAx6xdWuMDSjFaGMFfZ+E+5sPptzrRc/Fn9hqfMBr+d+Zm8rEV7DLkO5EWK7jOD23
         opirqBh23FDENRtN+9/CPFkJr5h7+8sdxDYP8lXCvq/QrWMXH8ZXPpTAQCBceHJmeuJ+
         B46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745894513; x=1746499313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waacX/lXsmFSOHeLxxTGTjSLf8mXp5UdS3vwhftA+Os=;
        b=PdxiEfMl7oazGdjBzB3EMeKLsBfsSHcXcR77U0DN44ZXonhysKTVX63ROsqVoXlwHw
         a/tOy9DDgVzwrBZoA0l9ZEjvBTxsUX+dgR8tVhnW40vQgLw0zJcKKxvL80b4Ie+gYJe+
         4UR+0yf4ne5jSg5O5z36atX+RJnRukEBIXSLR85GgtcMwUJWRERtOQCY6IkzhaqE2zMG
         eBq8LxBab59HVZCwQ6vScOUDwMrZ2Iz3Q3N/HWb0lO0FrjSii8ADoLs+ZWZIqKPWvb0a
         wqVMESSgqFt5kW7LQLCbgki7k5kM8RFctvbXE4/YfnbZDv6fJmP02shjSpkvAneCUItd
         volQ==
X-Gm-Message-State: AOJu0Ywupjxvu7PYV5PEIdEDhv0VKI0/ztzzJynxYQnSyUSHviuaBaVu
	fG1DsXHutb9y953roMSxFcNnf/XBLoXKhE39kJtQV5VTeoptlcpe6IoTrpP/CK8=
X-Gm-Gg: ASbGncvMGy6yjZ0zYOlmV8wfqXO4HNBMnoZSko1cEmUaf7jB0rBzSKR8C9TZRYG6NJ0
	6MCei/wBiQqHAfMOFIuM/bxtmdhdCr8DHCcW4WhFpMMVfAfQArse/V8dmf/eG9/3YysiT2Re5B3
	GK0a8gaWrI/xetjOvwpbOS28xD+d3FphGrLI5/TF7OdJsp1wGQtjA+ERpGJ0+F5T44WhHTXWerO
	wyGH6Y6Sj+U3EokjdW0ZJ6WC/AuhCJGxbWm25ow3EgGxy1ZGJ8O8eltKXcrvMnTKkLX7/6k56un
	hWpy/Atxyr61ve60Uhp/mAiha5WRqFJ9a0AfNOEkLUXEZLgj6vF+ZbUrDsO80Lz1LQ==
X-Google-Smtp-Source: AGHT+IF7e4pA8Y55vBVIkd/Z4QppQKJkTuySaI50+TMICaQepHZ9gdzqB0a1MJO32aNBlUBY2KnCiA==
X-Received: by 2002:a17:90b:2dc1:b0:2ff:6f88:b04a with SMTP id 98e67ed59e1d1-30a0133a0bemr17925694a91.15.1745894513455;
        Mon, 28 Apr 2025 19:41:53 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef097cb7sm9893211a91.22.2025.04.28.19.41.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Apr 2025 19:41:53 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 1/4] mm: move hugepage_global_{enabled,always}() to internal.h
Date: Tue, 29 Apr 2025 10:41:36 +0800
Message-Id: <20250429024139.34365-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250429024139.34365-1-laoar.shao@gmail.com>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions hugepage_global_{enabled,always}() are currently only used in
mm/huge_memory.c, so we can move them to mm/internal.h. They will also be
exposed for BPF hooking in a future change.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/huge_mm.h | 54 +----------------------------------------
 mm/huge_memory.c        | 46 ++++++++++++++++++++++++++++++++---
 mm/internal.h           | 14 +++++++++++
 3 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e893d546a49f..5e92db48fc99 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -177,19 +177,6 @@ extern unsigned long huge_anon_orders_always;
 extern unsigned long huge_anon_orders_madvise;
 extern unsigned long huge_anon_orders_inherit;
 
-static inline bool hugepage_global_enabled(void)
-{
-	return transparent_hugepage_flags &
-			((1<<TRANSPARENT_HUGEPAGE_FLAG) |
-			(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG));
-}
-
-static inline bool hugepage_global_always(void)
-{
-	return transparent_hugepage_flags &
-			(1<<TRANSPARENT_HUGEPAGE_FLAG);
-}
-
 static inline int highest_order(unsigned long orders)
 {
 	return fls_long(orders) - 1;
@@ -260,49 +247,10 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
 	return orders;
 }
 
-unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
-					 unsigned long vm_flags,
-					 unsigned long tva_flags,
-					 unsigned long orders);
-
-/**
- * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
- * @vma:  the vm area to check
- * @vm_flags: use these vm_flags instead of vma->vm_flags
- * @tva_flags: Which TVA flags to honour
- * @orders: bitfield of all orders to consider
- *
- * Calculates the intersection of the requested hugepage orders and the allowed
- * hugepage orders for the provided vma. Permitted orders are encoded as a set
- * bit at the corresponding bit position (bit-2 corresponds to order-2, bit-3
- * corresponds to order-3, etc). Order-0 is never considered a hugepage order.
- *
- * Return: bitfield of orders allowed for hugepage in the vma. 0 if no hugepage
- * orders are allowed.
- */
-static inline
 unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 				       unsigned long vm_flags,
 				       unsigned long tva_flags,
-				       unsigned long orders)
-{
-	/* Optimization to check if required orders are enabled early. */
-	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
-		unsigned long mask = READ_ONCE(huge_anon_orders_always);
-
-		if (vm_flags & VM_HUGEPAGE)
-			mask |= READ_ONCE(huge_anon_orders_madvise);
-		if (hugepage_global_always() ||
-		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
-			mask |= READ_ONCE(huge_anon_orders_inherit);
-
-		orders &= mask;
-		if (!orders)
-			return 0;
-	}
-
-	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
-}
+				       unsigned long orders);
 
 struct thpsize {
 	struct kobject kobj;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2a47682d1ab7..39afa14af2f2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -98,10 +98,10 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 	return !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
 }
 
-unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
-					 unsigned long vm_flags,
-					 unsigned long tva_flags,
-					 unsigned long orders)
+static unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
+						unsigned long vm_flags,
+						unsigned long tva_flags,
+						unsigned long orders)
 {
 	bool smaps = tva_flags & TVA_SMAPS;
 	bool in_pf = tva_flags & TVA_IN_PF;
@@ -208,6 +208,44 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	return orders;
 }
 
+/**
+ * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
+ * @vma:  the vm area to check
+ * @vm_flags: use these vm_flags instead of vma->vm_flags
+ * @tva_flags: Which TVA flags to honour
+ * @orders: bitfield of all orders to consider
+ *
+ * Calculates the intersection of the requested hugepage orders and the allowed
+ * hugepage orders for the provided vma. Permitted orders are encoded as a set
+ * bit at the corresponding bit position (bit-2 corresponds to order-2, bit-3
+ * corresponds to order-3, etc). Order-0 is never considered a hugepage order.
+ *
+ * Return: bitfield of orders allowed for hugepage in the vma. 0 if no hugepage
+ * orders are allowed.
+ */
+unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
+				       unsigned long vm_flags,
+				       unsigned long tva_flags,
+				       unsigned long orders)
+{
+	/* Optimization to check if required orders are enabled early. */
+	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
+		unsigned long mask = READ_ONCE(huge_anon_orders_always);
+
+		if (vm_flags & VM_HUGEPAGE)
+			mask |= READ_ONCE(huge_anon_orders_madvise);
+		if (hugepage_global_always() ||
+		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
+			mask |= READ_ONCE(huge_anon_orders_inherit);
+
+		orders &= mask;
+		if (!orders)
+			return 0;
+	}
+
+	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
+}
+
 static bool get_huge_zero_page(void)
 {
 	struct folio *zero_folio;
diff --git a/mm/internal.h b/mm/internal.h
index e9695baa5922..462d85c2ba7b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1625,5 +1625,19 @@ static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
 }
 #endif /* CONFIG_PT_RECLAIM */
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline bool hugepage_global_enabled(void)
+{
+	return transparent_hugepage_flags &
+			((1<<TRANSPARENT_HUGEPAGE_FLAG) |
+			(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG));
+}
+
+static inline bool hugepage_global_always(void)
+{
+	return transparent_hugepage_flags &
+			(1<<TRANSPARENT_HUGEPAGE_FLAG);
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #endif	/* __MM_INTERNAL_H */
-- 
2.43.5


