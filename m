Return-Path: <bpf+bounces-74768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C36C6599C
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACBAF35658D
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6068D30E844;
	Mon, 17 Nov 2025 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi8Kv4rr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3A308F33
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401051; cv=none; b=oFA6uyALt/XPcegU8cF1OWh8rAN8AD+bM62jFmMR4nlBRGd0JXs4hhR1QZJgCP4GN2FFoUx0NRkA1bh/s8RKGM3Piz0Qj6+zJ5bfRMoo6BN7EEtmBCepz8SwOyoF8C4V6W4YGJ30J8h4veHc+yQi2aUhEhouvhnsSiCrV3eLjYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401051; c=relaxed/simple;
	bh=htcPVRXuXe+qY1d+V7D5BEon8d1BbotVn+VtDCIaEHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0LrRneFWhVOn2wwIfEPlzIbCfAY6VK6kUgF4dZOH8lLdjj4DAH9fqpPMDsOjudIaSYo3NQJ+MB1R6p347/E/hPnZ7VDuMS8Xd7HTmFchADo4D1veZqfzThBpK6PosAKw4fPxDiEfaFRF4OHbdcD+EkzPzOEpXDnlrW8NispWlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi8Kv4rr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b80fed1505so3796083b3a.3
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 09:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763401049; x=1764005849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5C9LjYYrJflrSHBkOuvUe5rS+MjPzFDPPc1TMJZwtTo=;
        b=Fi8Kv4rr38a6U3YqQ/kOpmdqgF5WYttZMhUKGv+qdNMCGOSwd+iAkBe7Z2kZYKJ4DL
         Y46v/owTERKyLO1XHXjT6FfyGIKrpnGrQ4VuFlp5AXHXP6Jc8K9296ixcmYu6deOZy4G
         KlVP5YFCXfL4YFquGQBudjXfRELzf67rgWHedXcs/UjhyTu1nKkFSmZD1COxstVsVn5s
         MfRxOR0jaQHoJnq+Ao0AgZ7IdoK5Yfq2tpm0Xoc8pUtXXe+NqL1z859VZvmIOmr9D6eq
         vfs93Y5kWDjupCo9qFZW6CyP7ZVneK39ygiKv8t2Zk3I6m6uL59RQi42o1tlwqdTWzFO
         GlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763401049; x=1764005849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5C9LjYYrJflrSHBkOuvUe5rS+MjPzFDPPc1TMJZwtTo=;
        b=NaVcMPcztU/fZXT6gd6FogBUGr3HtGc/XTcLLVKpPhRBuasH9r6KVyrnvB88k7OorT
         nVdUyYLTKzK0z61CZ5nkS4H/nuSgDmHxYhYlnTkTYbxVW//Qi25UgOjRuSRxIe6+OB/u
         kFm0EFp0yTPGtaqRkk8arbnRjjGIADz61BNdCOGdw7QCMIijoh0ndTZcQJLl3z/2qqQc
         0TK3vrU7zlMnH5XGS6Es3kXuW/zGrBANhbxmYynvjazaJ8mQq6jT20N7Y810c0coK6tn
         Zq3xHAbWk2pSkeUr2GhAc+OOLqU8hJKIkrYO/m3b2r2Xj17dGXl8fDuyarNEyepMLnYk
         +C2A==
X-Forwarded-Encrypted: i=1; AJvYcCVyIk2Pt+0i58V7QPBnIGcMI/mmvaaf1T3NaLHUkNdyQPP0TD3orSoqPEtvb2oUx6bS+e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNkVWOpIMbifafLpgulGv4Z4zDBbGC/3Zl3P50OVllVgFX1Gu
	bwBrb9rttjfLijIKhStH0Q+2AVuA/LFK3RegQdB3X17UruCTRzBexYRt
X-Gm-Gg: ASbGnctXIAE1zYNdgPKf1NGteB0et36qzvTAPkr9tbb2GB0CNCA1RCw47REZzxSbN6Z
	iaLdlh3FKhsRfZ39sb1uXuh0xrXmen3t5aWmCWwdKqTFQMVc0JN0AyjVJPWDdiWW0CMrZd9etnQ
	9xt9om4RC/j7rDdbXOg3Tqjnend1U6Jgbjqvd6+Iwq0FwulSwwaPViyOIxXNMbDw12rtsTou9zB
	kRfVQrL0aghOzgWNcmI9AwbLkpPscLMBZQ14Qf+oCTUFnbPebFTLzayPNXBqy67avFXPbrcOMS+
	VMepWJPtRlvnR2ZHZ7/XcTRBWE04Tl+y14zgD0FUK1jefFqSK81J2wGo/BelMpRNdoP8MDqBx3E
	S6MkeupTmvSwDE2IvMCBbd9M6BgarKP/ycVZ6N5XbTwcDdZc70uVtLQBYo5Ly0rY8K/LC6uHIVU
	G7ZBr73E5sgYTYDME3Tc/qKwpzcFCicscDk6wfy2YnSlE=
X-Google-Smtp-Source: AGHT+IEtmyLNGF6+QflVUQjGtJXEUw+OJH0XXFljr1HmNZzIfgfyYe60Ql4OLIvcBVf84mkOlBoDZQ==
X-Received: by 2002:a05:7022:b90d:b0:11b:8fc9:9f5d with SMTP id a92af1059eb24-11b8fc9ae93mr2387442c88.30.1763401049333;
        Mon, 17 Nov 2025 09:37:29 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11bf23d6967sm17190077c88.3.2025.11.17.09.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:37:26 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
Date: Mon, 17 Nov 2025 09:35:27 -0800
Message-ID: <20251117173530.43293-2-vishal.moola@gmail.com>
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
 mm/vmalloc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0832f944544c..5dc467c6cab4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3911,6 +3911,28 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	return NULL;
 }
 
+/*
+ * See __vmalloc_node_range() for a clear list of supported vmalloc flags.
+ * This gfp lists all flags currently passed through vmalloc. Currently,
+ * __GFP_ZERO is used by BPF and __GFP_NORETRY is used by percpu. Both drm
+ * and BPF also use GFP_USER. Additionally, various users pass
+ * GFP_KERNEL_ACCOUNT.
+ */
+#define GFP_VMALLOC_SUPPORTED (GFP_KERNEL | GFP_ATOMIC | GFP_NOWAIT |\
+				__GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY |\
+				GFP_NOFS | GFP_NOIO | GFP_KERNEL_ACCOUNT |\
+				GFP_USER)
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
@@ -4092,6 +4114,8 @@ EXPORT_SYMBOL_GPL(__vmalloc_node_noprof);
 
 void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
 {
+	if (unlikely(gfp_mask & ~GFP_VMALLOC_SUPPORTED))
+		gfp_mask = vmalloc_fix_flags(gfp_mask);
 	return __vmalloc_node_noprof(size, 1, gfp_mask, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
@@ -4131,6 +4155,8 @@ EXPORT_SYMBOL(vmalloc_noprof);
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


