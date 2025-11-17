Return-Path: <bpf+bounces-74769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A398C65918
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AD524EE7CB
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9922231326A;
	Mon, 17 Nov 2025 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW0vC6m7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32F030FF24
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401055; cv=none; b=NFoODL2K220sduD1JtKiu++X/hLztdwOFBvsPj1K1YJLfU/7EcKP1CCLd+lTvLekR9AtP3G78Hdx3ock6N9atf6tG4gu7mw334LA6E04ppf6NjPeYG68CyX4HFqNwqUQm8zLhCA6jlQH/3j0iedbfCrjmPEHu0Qqa6a6Q1pYkVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401055; c=relaxed/simple;
	bh=KpKUOuZkvDAqQXOamx/GLVPKVK1ZvPHfjFfW98cK8Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCgUZ7lT6JYBKkUzFWaBOZtdNpn/mxJ7m1D4KCqktc7GV7czyjkLHTfYX+ICqWtGQWqFZ8WT4T2c/ZgV+HgjDiTCr+7L4OaLinGUyy+bdMQQyrcjH685ysKZOO3VLi4+IhfJ74ZQUmDucoPkd64DpNKWyJjTIB7t/iLOZM8PGWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW0vC6m7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so4353707b3a.1
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763401053; x=1764005853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPcO45dHFDvBr1myur2O5RaxoSFdLaXlPhz3NmNfzjQ=;
        b=kW0vC6m7d0PKw/6mxZOc4FhauTUs5ZxHUO15Hd3WQeJLoJ42z/Exc+weh3494VYEUb
         5Uo3vwaQZVQYbwvAdfxCSnI9h8UcSwCFNdDDaXcCUZRB1dMyyQAzfY6nA+sOXfUoY9Hu
         sz/w+D6JWh3vGsExEeBXZD5wPnQ8bsiGIOyWyYpzlXezchGI28MvY0aYfoGuDeIsZIXo
         xNAsxgQv//K7zsfZ6/NgPt8FS+HRVE2PLb2j40HeW2TT0NME+BEbJLleq7879dnEYDtH
         D5RirACePG/FEHnlTeg0OHIDB0phsEcwxi8qVzvpK76pX7zKu8jvjQrozVSZFZKvW3x7
         knRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763401053; x=1764005853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IPcO45dHFDvBr1myur2O5RaxoSFdLaXlPhz3NmNfzjQ=;
        b=JhUi9Yrl2+/HNluBa/1pd7Z+W9CNlLOG2T7qI9XOi86qG4cBSvU+bp0nrzX9hjvjon
         wJURMoIhfizXKVx6tBQrPOSG2zQUpFRUHpoiS3WC4kl7dLcpTw4Z8XPxLkQyiBxC58KZ
         pHDagww1WIq64SewvFENqfdCn7uMgROhasPckpafWfUchmHLtvRjf0pIlz9qTsjmQBRr
         3jgkfLrmD9mvRI78/z0Cal73f88hngIholkLaHqObRHnVMmzXJSM4V/S/rzt/lSm3ihx
         z0fKqwB5mYF8kZtS2Mfto2HqDl0RgqZiEVY6R5G4cYkxXYhi/MYRZWjJUir6ndWbDgtp
         cBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH3XSRb2JFAdaz5oa3MN5w4Fhk9uICc1bKuMLkUITBkopYy5+gLxgOdJNC1lgFlXT5GPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfaD6ELVoiHx1kxZqrag751B/8Qhjn1AnZtX4ml6qGo6AhA8k4
	3IngezIDgtQ8njtVhXvh+LSdoXAWd2VGOtU1YhJA72rSP0mzvUuHOrTG
X-Gm-Gg: ASbGnctKzNqs9JX48kZF8rDzuTnlW1oB3sisay6KcW/Jb77tVAKPJG2OWmxKiXbZhKy
	KzzQRzYSyuW/E352OkAAUa4eIv/qtnbJkTEwu+0gSI1OKFA68VZjjOAC3Q+EGlW8mn8ASdV/57E
	YDNjFB7erXLkz1O7q3Bwsf2nMKFwTcSOjuWYpXktkVUKSDj2ZhxT90UW1Pg7041/NIGL3n/dCYy
	rQb0xXlnE45ZiMQjJA5NgLIGasuJL33oNSHbLpCsxhP8++Pp1Rg9o/fvEUh5Mp4SmA2qM6mjRUe
	6zvc9bo/DWLcHYGI4RHanW4pDDaVrQEFiwpwoFeW4F7JAHtDSKaV/A4CHNqqZmfbUVkiRy67e2i
	YHG/aujfN/c7F6E/zlhm56YKyQfUcqyCO4PpPLrFiTeKQGS8BnWSTdyrqeIm5hH2PBCqXr18jP8
	Q0QaWWNl3vK2HvjBhBW+E7Fs2K2cTIXawP11Gubm983a8=
X-Google-Smtp-Source: AGHT+IH4K/uKp4wBmji5+078HBHMRacMom3qXOxhrv9ZqIKosCXUetWMfsZ4zZ1443wE5zlGVPEjIA==
X-Received: by 2002:a05:7022:69a5:b0:119:e56b:957c with SMTP id a92af1059eb24-11b40e7bfdemr5600667c88.1.1763401052835;
        Mon, 17 Nov 2025 09:37:32 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11bf23d6967sm17190077c88.3.2025.11.17.09.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:37:29 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 2/4] mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
Date: Mon, 17 Nov 2025 09:35:28 -0800
Message-ID: <20251117173530.43293-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117173530.43293-1-vishal.moola@gmail.com>
References: <20251117173530.43293-1-vishal.moola@gmail.com>
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
index 5dc467c6cab4..0929f4f53ffe 100644
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


