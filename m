Return-Path: <bpf+bounces-74320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA15C54085
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 19:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051873AF19A
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 18:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA1134C81F;
	Wed, 12 Nov 2025 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nncfSasT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947A34847B
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973926; cv=none; b=Wjbu7kQqC7PVIiuu+ZqvOpEfO8LJi2rZZRmnocHZZFxz+hbhR+g8Mq4TjhqMVPxmcFA3RSn/pwj2GrvqKrPF+f5tNUafGYlb+X2tFrcaGAZg3DrfMbp+1xzR1L2jyddY0YF3w1EaMKJ9ggJFkWurhiaJGkxCByzBA9+AZyPSL8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973926; c=relaxed/simple;
	bh=3/Vz0WT4gC1hndymh6gIvmz9w0Pvxo33wzsR8v46SX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSkg7NlQvMXnti52ZMnmRQj/aW3x0Qt+tGKwIdvHWbAMO8CL2ewf1+HaeWPSpewWwAFXZsuLB6J7QFPxq1VPS/tQrxXLtJPFuAr3Soik02KjbihuELZFXqCG2jF+jkSIbOspNHBiSJKJV6SFMK5bFdbqldqk/7kZKsHdpcLqD00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nncfSasT; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b553412a19bso779921a12.1
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 10:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762973924; x=1763578724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOzeYRhvW6xlaG+pSPr/FnesrhCbCiDgfjq3/z1PcaI=;
        b=nncfSasTlHNemW4ZzKs1/lJOSW296qABIQ0bx1s4fJXcR1MweqRkgHTL4mxOvpk2kg
         1zvG9LUmLVBYpYB7bbEtzMuEDXpq1bU7jbqW8Q1T0dv3IVdhsY2zsNLxLOhkN9kCDTit
         fd6SWvbzRCRioc3Z4fOtVPffemhGaXOGvSS3ofl7etitelaiS59AzfcTiV5q/D1rkHE6
         cBOShvwBNERtWESNh0qqoXS6ZxKGWLDTFwnGxb5rIEbAt/CFYqXz+LZQhyx9Qn1kNG21
         M0bDerPYz3x2PWB214yC4GB/mHRXRrJCSklmASTdgmxFwzcHSoTvAKFbx4aTIggKvIAX
         hQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762973924; x=1763578724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FOzeYRhvW6xlaG+pSPr/FnesrhCbCiDgfjq3/z1PcaI=;
        b=pxc5AXQhdkgULJSWZi6t0Ni1FOITlPAX3vN2kjQ6XxYRa1cItf3ut2VEYaffYFe1lH
         KQ/AtYuxE5nZVB5rCC2t+1is+sNvmKX36xyFKuYmPNAlq1ZwV0z2k22E+fiJv4arHkZc
         ahyG/f+8lIHYx/PhHATLsFtpvl6ySsQo04mUjHAuA5GVCK0wr+LgPcRVncjjwSD6zMTK
         PjOPKgP4CwW9ZwIckOpjduiAcP2aWS0rM4mbrKoNKwvNgfY8gD4yotjtlBESGVEFN/yX
         UKdBhzokRpWCM+Q/6dmuc50kAHd7opAj5x8M0vNAqDHBk3xuolxG5Rxwhs2x8YII7+8v
         eJWw==
X-Forwarded-Encrypted: i=1; AJvYcCVGn7oBibohdnaoRn7kfPRYzQZVicWLzlzS51TN/08eiPzPFX4DmBtwhdeTc08pF1K9kIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRfvivlpm3rfdNpex7UXnO87RCfJaz0X28qJGA7j9V6Tf311q4
	1NsJ0ANpF7uuxgi24Sq7BbC8jRp5KOAslAjO7wsVqyXQkLRkTZGosFdJ
X-Gm-Gg: ASbGncuSZtOlEaT2SSNH7zsLMhEOSPTwTkGUO/PauxnY3eQY7nEVe1dVtaeIm6e19wr
	RL2NZcDr6BIJq32oHI6Ty5qxjFGEC6zP9fyG+7iNxXZ6i9YyKzTnGqvsCJz7XG2LZO7rJwDndjB
	4720xCaQDftjFvfDQU6Tgtw/kmkbocLqnCmW0bHvddbj4Ry3C625wbhnE3OpqMHqmki6wkOf7Lg
	jMcQtO+EQc6oWQW5PzfkvoSZiy34A5nBw/RXYWriF/kz5dNGCeL5zW0I9APOrvItfZWi7ALA/bX
	AhUh+GxHq1LZdSP1Py7bgz9fe+njptuL/6H6TXjZUmFdc9qvts4LLrDYHhJm8pC2Q3FnzOTPJxx
	b0wsRAP7EuAaosld06ur0ixF9KBGJk6QUV3d2VAtN/JUeT5HZARq2qq3x9d+Pi7fsDQTaTs6tVt
	2PRAcxuAX2AGy+0Z4PfI/SVLGcrr73XT1n
X-Google-Smtp-Source: AGHT+IEJrBaRK17BHWcJTyjM/w29/bLHBps6owC9QTOW3jaEO5KXlOYxTfBkyQVQ+DswKdhsHIpiAA==
X-Received: by 2002:a17:902:dac3:b0:27e:ec72:f67 with SMTP id d9443c01a7336-2984ed27ec5mr50621645ad.6.1762973923702;
        Wed, 12 Nov 2025 10:58:43 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-343e06fe521sm3491565a91.1.2025.11.12.10.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:58:42 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
Date: Wed, 12 Nov 2025 10:58:30 -0800
Message-ID: <20251112185834.32487-2-vishal.moola@gmail.com>
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

Vmalloc explicitly supports a list of flags, but we never enforce them.
vmalloc has been trying to handle unsupported flags by clearing and
setting flags wherever necessary. This is messy and makes the code
harder to understand, when we could simply check for a supported input
immediately instead.

Define a helper mask and function telling callers they have passed in
invalid flags, and clear those unsupported vmalloc flags.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/vmalloc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0832f944544c..802a189f8d83 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3911,6 +3911,26 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	return NULL;
 }
 
+/*
+ * See __vmalloc_node_range() for a clear list of supported vmalloc flags.
+ * This gfp lists all flags currently passed through vmalloc. Currently,
+ * __GFP_ZERO is used by BPF and __GFP_NORETRY is used by percpu. Both drm
+ * and BPF also use GFP_USER, which is GFP_KERNEL | __GFP_HARDWALL.
+ */
+#define GFP_VMALLOC_SUPPORTED (GFP_KERNEL | GFP_ATOMIC | GFP_NOWAIT |\
+				__GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY |\
+				__GFP_HARDWALL)
+
+static gfp_t vmalloc_fix_flags(gfp_t flags)
+{
+	gfp_t invalid_mask = flags & ~GFP_VMALLOC_SUPPORTED;
+
+	flags &= GFP_VMALLOC_SUPPORTED;
+	WARN(1, "Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
+			invalid_mask, &invalid_mask, flags, &flags);
+	return flags;
+}
+
 /**
  * __vmalloc_node_range - allocate virtually contiguous memory
  * @size:		  allocation size
@@ -4092,6 +4112,8 @@ EXPORT_SYMBOL_GPL(__vmalloc_node_noprof);
 
 void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
 {
+	if (unlikely(gfp_mask & ~GFP_VMALLOC_SUPPORTED))
+		gfp_mask = vmalloc_fix_flags(gfp_mask);
 	return __vmalloc_node_noprof(size, 1, gfp_mask, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
@@ -4131,6 +4153,8 @@ EXPORT_SYMBOL(vmalloc_noprof);
  */
 void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
 {
+	if (unlikely(gfp_mask & ~GFP_VMALLOC_SUPPORTED))
+		gfp_mask = vmalloc_fix_flags(gfp_mask);
 	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
 					   gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
 					   node, __builtin_return_address(0));
-- 
2.51.1


