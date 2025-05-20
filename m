Return-Path: <bpf+bounces-58521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A49ABCEF5
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 08:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7507D3B799B
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E24425B676;
	Tue, 20 May 2025 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyHVAMRZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362F1E0DCB
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 06:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747721173; cv=none; b=t81OLQ6ykdg9Iz01609GWbWrEmhxPM3xHBJRT5N600HOjW29jPdFnIrScy8VYarXwuYwzJOv2vSd4VzoL14UYjkCHIlZrc+DUP6LFa/8x3qMwgOiIIpbK4UYyAKk7g8JYShZnciVDK1o3kU0u61bk46s+a8Q55M0MZs7/UMNxuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747721173; c=relaxed/simple;
	bh=xRbojBmnONyNP1bVgPFUByjboRhC2dZvVC8T4HunNQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aS9ovHSycuMsM5yx+trOUixUppqjs7P1/1F2jEVvEtL4oR9r85iCNsInlhNOsWht08hIhExSVCH+5z1sfXIjCpC96YBgPy+7t2spuB4KqRz0kCppE3Kno3z3fRlIEaA6OMjm4OoVB+GH9Yzkomd5wQ/fVBQkWSQFObMABTCGFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyHVAMRZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-231e011edfaso41220625ad.0
        for <bpf@vger.kernel.org>; Mon, 19 May 2025 23:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747721171; x=1748325971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJFbv/C9AXiDHo86Dr0I4aYwY+sQQFfjHNuo4rnELyg=;
        b=lyHVAMRZkDCOXMVKU7ywQ5Ag7gSjXi0ISN8ZWD2AJVGgPMZs4VCyB42/QoxOmgqLM3
         LJnlrzAanTCp6ikhEHTgbkXv3c3L5naoLRWFlkZpd13akW5KwwMlIj9LPJpfDd4flq5Y
         U1jrAAOPQeGRjA/TSCHckZ/8P8oZgrHzwx+j2cgzLZ0rcfZyYUhYy2FeXP4xFQFVwGZD
         G+iL2TGaAnvNMrogFOU+2X+8pJqiWFKpJD2zFSaIZIngYT6Kp8P9zg8U3nv3qr7ZLFM0
         CeJJ4POv1GOJwKsBMElp5nlzYGAOGigoRVNlxJuBeKe+Zr+NdoSIDo/VXXhJCyyNA9k/
         Ysjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747721171; x=1748325971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJFbv/C9AXiDHo86Dr0I4aYwY+sQQFfjHNuo4rnELyg=;
        b=bPbqFq6wE7ePLrbPBVTYaICAKKKwV63JCgwLnYZkKU5SlucgV9NpL3xWfom9feuqEo
         6E5O2nFBs+Qo/Hny5fCdxe8/dOZU8E8pk//pkXeMB2pGy7p7GwMB78gw8D0Whwure8Jf
         mwnLSI6ZeaCqzuvyV1W175ynRHS7GuoDm3xbFxFZ3xvxd902Tz/6F2aXz6dKF8p+dX/g
         hZm7Oj+6FFkt8vv2ivFni+l6DhLwk0GIVRrqf3I6wyxaO0/GiPFMB6mljXV7fzGuAPsR
         QRqCjET9/Uwuk2wpKjKyyZdLY1wz4IskG8FdqQ02fJ2G38oqQcvy84r7s8mVZZTpz3ZK
         Rjhg==
X-Gm-Message-State: AOJu0YxKDQokeqIMB51nKynUhM13zEpzAfOyBs9IU67HEp3URvi7j+fZ
	z4zWOvqEi6bCAZWkgNBIe9WZsyhMhw3CZdYkujIA5MsWxN978EsDKsUb
X-Gm-Gg: ASbGnctyS1afpjQa5v4nuHg3/8VBktQLvsXzHAiwHlk65YiHhgcEh+EKJJTFiw4XQ6m
	hlpGj3bDHmG38qGlwuTzERjB4WzcYPYw5GpBj60Z5w0pBKCWww53eNrS4aAC83MlBvBKQmSa9Qq
	5xumFiWMimgog6SeJUD81fnWasZNkCDEEA03NiXo0f1b54fQ8jZARPvgm1qUcxL+HY3671cDUsM
	ANlrdPTxU7ng5waH5aGOG5d8ZP2MDtOei2fc9V+BO0JxmFuB2Hr7UbvM1ziyDayHgjJjbMe5ECF
	YyRA/+l7XqIBqpCC/9hRXjszyc5Do56/QbK4uSWAgIAohIHu5WJttoVG3LgopWoCgk7ap+fZysk
	=
X-Google-Smtp-Source: AGHT+IHUrxlL5Ojor8N2fSwzgtjTKIcAEzMGoxLho1sS5QRfcHndSJxXeWOeMFuBERf4mjOkfUWoEA==
X-Received: by 2002:a17:903:2607:b0:231:ecd5:e70a with SMTP id d9443c01a7336-231ecd5ea28mr154527025ad.23.1747721170866;
        Mon, 19 May 2025 23:06:10 -0700 (PDT)
Received: from localhost.localdomain ([39.144.103.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36385e91sm823428a91.12.2025.05.19.23.06.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 May 2025 23:06:10 -0700 (PDT)
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
Subject: [RFC PATCH v2 2/5] mm: thp: Add hook for BPF based THP adjustment
Date: Tue, 20 May 2025 14:05:00 +0800
Message-Id: <20250520060504.20251-3-laoar.shao@gmail.com>
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

This patch introduces new hooks for BPF program attachment and adds a flag
to indicate when a BPF program is attached. The program only functions when
"bpf" mode is enabled.

Per task THP policy based on BPF will be added in the followup patch.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/huge_mm.h | 24 +++++++++++++++++++++++-
 mm/khugepaged.c         |  3 +++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 3b5429f73e6e..fedb5b014d9a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -55,6 +55,7 @@ enum transparent_hugepage_flag {
 	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
 	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
 	TRANSPARENT_HUGEPAGE_REQ_BPF_FLAG,	/* "bpf" mode */
+	TRANSPARENT_HUGEPAGE_BPF_ATTACHED,	/* BPF program is attached */
 };
 
 struct kobject;
@@ -192,6 +193,26 @@ static inline bool hugepage_global_always(void)
 			(1<<TRANSPARENT_HUGEPAGE_FLAG);
 }
 
+static inline bool hugepage_bpf_allowable(void)
+{
+	/* Works only for BPF mode */
+	if (!(transparent_hugepage_flags & (1<<TRANSPARENT_HUGEPAGE_REQ_BPF_FLAG)))
+		return 0;
+
+	/* No BPF program is attached */
+	if (!(transparent_hugepage_flags & (1<<TRANSPARENT_HUGEPAGE_BPF_ATTACHED)))
+		return 0;
+	/* We will add struct ops in the future */
+	return 1;
+}
+
+static inline bool hugepaged_bpf_allowable(void)
+{
+	if (!(transparent_hugepage_flags & (1<<TRANSPARENT_HUGEPAGE_BPF_ATTACHED)))
+		return 0;
+	return 1;
+}
+
 static inline int highest_order(unsigned long orders)
 {
 	return fls_long(orders) - 1;
@@ -295,7 +316,8 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 		if (vm_flags & VM_HUGEPAGE)
 			mask |= READ_ONCE(huge_anon_orders_madvise);
 		if (hugepage_global_always() ||
-		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
+		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()) ||
+		    hugepage_bpf_allowable())
 			mask |= READ_ONCE(huge_anon_orders_inherit);
 
 		orders &= mask;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cc945c6ab3bd..762e03b50bca 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -432,6 +432,9 @@ static bool hugepage_pmd_enabled(void)
 	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
 	    hugepage_global_enabled())
 		return true;
+	if (test_bit(PMD_ORDER, &huge_anon_orders_bpf) &&
+	    hugepaged_bpf_allowable())
+		return true;
 	if (IS_ENABLED(CONFIG_SHMEM) && shmem_hpage_pmd_enabled())
 		return true;
 	return false;
-- 
2.43.5


