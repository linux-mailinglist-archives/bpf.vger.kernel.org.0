Return-Path: <bpf+bounces-74321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC57FC54091
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 19:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A68F3AEE59
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883DF34D39D;
	Wed, 12 Nov 2025 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7knOLgO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9934B683
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973927; cv=none; b=c7fuyEZQsDW53oiPjq1sPDLYu0Ighz4F56nn+vqq0Io8rbwRG7IMQ2wa11emEXAxfWuf+Mf/aqmGSLeJy5oOzx7lea0hyCR/DU00DlDimEriuSyGMfZfcU8y9NSHDT5MUV0Qfwe33Jg1e46ElZFFreI5WTYEk3bSdkfGHvM6Kys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973927; c=relaxed/simple;
	bh=rcvkjrTXMnJLziWH8zqVfRZ78IP9ZlW60rUNeTsh1wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0Q4UStITjF369OAlIlvChzXsjH1a8o/upNW0NbKBwv/IVvgn/EWoj09gIf4bId+HGZeeRsxPE/vTczxYf1d0VC1Gr7ierBK0S0UPqcC6Isx+//sp+b/vDb2VZB5PO9dNNtUIqaKFpD7x1FIfz8woYAOZ54w5Fx1hBsnrh5KlKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7knOLgO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so1159550a91.0
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 10:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762973925; x=1763578725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA8cP4S3Tl3Wh5mUe69KyfI7cCSKipKpnkLZNCnzqEA=;
        b=S7knOLgOgnl+9TKwbK2bIMhslp3VQrmhZHPQX/VYm41XXPG5oQx7LF8Px7AkGjbhZp
         3yiLehtk731OLJsUaU9OjrSoBh1bHAUq9spQMCaN7pdPjV1QEAhcd5hHTURX8E8FXxjg
         z00U0moAzEkCV142wuaVPIhj0chzze7zHK3wuwNaiFrBp9wj/hYfiY288wiYa9H2XhqT
         NJH5lQbqc6yqGWZu1YALl9uMVs81aReVrlkUNxs/xuTHi9h3oIkJiiY25ZnTl7ADgJJJ
         rD/vHqisyF8AJv+VreqbVzPUVagyaAYhN/VhDLo4KXi6cfXUANgZ+dcIqnyXIgj6Qc4u
         Ov3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762973925; x=1763578725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qA8cP4S3Tl3Wh5mUe69KyfI7cCSKipKpnkLZNCnzqEA=;
        b=clolaK98FRh++b7I41WwTnEmor2mJXQzSanw5r5uS+0OEHq1YYN7Ej5vYRPKu+tIO4
         DrQVQnuPW9RYGl1/X/LuPjHsMXwaqH3puwFij3TBM5+yobmKBT2LNJxDISLt7raqevzQ
         Mmnb+CAgC788I2HjSF27+jLslvV3ZhcgPrkZ9iMZfc+dbQGB8Hrx+QAyJcf+MZtKdJ7J
         sX3N7aTSwsoLwiaVmAK+nAc2TYcZW6snvB3prXUL17I/OY+1bofPFlWDevXlAyM3EDCf
         QQTDIMBXFBRgap0bzXydRijyjEahX0TIpYx0RpGkiqjNAsWH5ESqmcU6pDhMM7Tkk5G0
         i9jw==
X-Forwarded-Encrypted: i=1; AJvYcCUoF2aFqOfCDuyFSUphFb6+fPI48ahh4nRTDmj3vdxQlu6p4KmD7XklXqwJjcUpND4Ut2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2QH2sAEyRLkvOGowl7Eyza8zvGOAC6//diUU2HbKXoOmAv3k/
	JU8L4PMSUlc5LeV22TxPZMgBWq8Z2QtedUi3PJihwL6JPeafPC312dGk
X-Gm-Gg: ASbGnctbK0K68s19oFN88LZuu7aeSb52f+BiH8xa4hn+NjvE2sOYDdy8UiSsz7NhjE6
	CPpfYu3svTwYgbqI2l+/77dZ1Jo3s6R7IcRC8kXMhQVV1qtaxfY3d4B0tqj9rNirOTHaFvWY+PN
	XN7wwuefDbueRZ+wsobi/WsDhpPlTALlI8YVG0T9/Klrt323fEPzSAg8aKN8nj33n6I9GxLfCVN
	F3Wf3p4b7cv1jdqn3W9+tD4wuPX/26hJy+Yg0P9LWCgs8HdosXxv/7dkUmOxyXZIfY+hHK9KD6m
	lSWgkMLqHmzQz2B/wyjsh/fuQQRIKatvLpM8L2OQldiFp4ofn2v0rwFbItyY7u0K/8o6DTjnNzP
	IZ2hn1OUwZbZL1z/+PUpnNB+Gfiy2F88usQSTqN9AATpDoeBxARZvgxgJUX1VSUxQQ0bjKi4w3e
	dmNdWYPmGCSP7N8WBmCzGEuVRHZUdQFfaf
X-Google-Smtp-Source: AGHT+IFVZWew3uxTlI2SxVBJMfOtL/w/zYRfLdI2Xrhh6UsbcQNHvvYj4pBEwbgZsC/LfWpQC5/usw==
X-Received: by 2002:a17:90b:50:b0:33b:938c:570a with SMTP id 98e67ed59e1d1-343ddefbbbemr5088912a91.33.1762973924869;
        Wed, 12 Nov 2025 10:58:44 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-343e06fe521sm3491565a91.1.2025.11.12.10.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:58:44 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 2/4] mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
Date: Wed, 12 Nov 2025 10:58:31 -0800
Message-ID: <20251112185834.32487-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112185834.32487-1-vishal.moola@gmail.com>
References: <20251112185834.32487-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vm_area_alloc_pages() attempts to use different gfp flags as a way
to optimize allocations. This has been done inline which makes things
harder to read.

Add a helper function to make the code more readable.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/vmalloc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 802a189f8d83..c0876ccf3447 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3614,6 +3614,17 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
 EXPORT_SYMBOL_GPL(vmap_pfn);
 #endif /* CONFIG_VMAP_PFN */
 
+/*
+ * Helper for vmalloc to adjust the gfp flags for certain allocations.
+ */
+static inline gfp_t vmalloc_gfp_adjust(gfp_t flags, const bool large)
+{
+	flags |= __GFP_NOWARN;
+	if (large)
+		flags &= ~__GFP_NOFAIL;
+	return flags;
+}
+
 static inline unsigned int
 vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
@@ -3852,9 +3863,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	 * Please note, the __vmalloc_node_range_noprof() falls-back
 	 * to order-0 pages if high-order attempt is unsuccessful.
 	 */
-	area->nr_pages = vm_area_alloc_pages((page_order ?
-		gfp_mask & ~__GFP_NOFAIL : gfp_mask) | __GFP_NOWARN,
-		node, page_order, nr_small_pages, area->pages);
+	area->nr_pages = vm_area_alloc_pages(
+			vmalloc_gfp_adjust(gfp_mask, page_order), node,
+			page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 	/* All pages of vm should be charged to same memcg, so use first one. */
-- 
2.51.1


