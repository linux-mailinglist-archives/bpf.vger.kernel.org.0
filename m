Return-Path: <bpf+bounces-67821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B131B49E6B
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68729189D005
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 01:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFF021C9ED;
	Tue,  9 Sep 2025 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBkmHZAa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB919343B
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379618; cv=none; b=Mg/Bm8yL+/4Q7ffet0yMlpIvGhpoAN8j5Gbs136S4rj+EsxjEPmM1YHiWcPS8HtsxBlXwyYvOhtlKJliO57QQHBIiTPbXcnJ+nlcfqJ7Hf9utFeh4nowZh4sZ2z5TNPy/l7iv/NI+RGH+08+N5Kf66R4+c6AUD9lVcmXQBO8Tuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379618; c=relaxed/simple;
	bh=KDjE8RHU+QZVb2SvnggR3QPFVGfhX8/gy/6cZL9y0o4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KQjTq9mXZuFYgBdL1BtnlWniNZEIW+Db8oTTTScmi5UZTAW+Vig3bR54GDeEwVCp+WgQZ1kmGyHaBuJlSOZyhzrj6QA0i5a0hyY+0faeMMjH33742094gFoBLU/UnNBzpnyuDNMprK/6fyZ6Z5UcnY2HXvcx9jdL3DWI7wJvIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBkmHZAa; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77246079bc9so6014791b3a.3
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 18:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757379615; x=1757984415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mha16x92fV++DlMun1mfAi0mcQgqv+XgnRVTVIJwwCA=;
        b=nBkmHZAaByAfLcgmNHEhaQxOBANS6eQmHHJFY1LrVLSBFQypTATd/PPTGfxkQopDvk
         441TCxc7UmT2zYDQhwMPWqv6rnIeMWw6CAIWWEMfwREwuIb7EHGJSTAwN9SkOjzR+fd/
         R4pRFVE0MVeVNjIGcOWD6p17yj/6dh1RVuu1kIRQRDAgne13GuEuUr2l8+uCdySAt5va
         syGG7tywlMutBTOUuxGPRwxfD2n3/tCdtM+o2FDHf9qko091q8pPQ6M1rHQqYvucUUV2
         c62RtQGSwtRyVXua+L97PkJgF+M6lC9dtuHKTCEzTLpe72tBaPaJPYolAimmYRTj/PpW
         OLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757379615; x=1757984415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mha16x92fV++DlMun1mfAi0mcQgqv+XgnRVTVIJwwCA=;
        b=HaZdzrXC2Z16fsX0f+FfBWL75onenclU2vQszadxN2D9Dv/JYCK62wxvO3Hq+gtMK5
         tKxMVNGiz30zaTKMJuCkoxRuslxFiJm8MFPChPkzeyPMgium+K8r41gJyetFlGc1RFlD
         XQOefc64H5Owttt8eerh2BE6RQ5gugmHq8HSeqxKJmhLrqWgA8TEKfLmZdeLE1Dp8Dq7
         xGJ0j66fugDvlevXhePN67J5bhvoysc+09j38LCA7DWkP21zvEjHPA5NQv90GRorD2Eh
         YVb8QowGaWBwyquxzOGkjptA+XfuwhDyjK3MC2TOs7NOE9lhKDMvZlA1WFC4m0T//RPn
         qKhA==
X-Gm-Message-State: AOJu0YzDcUGUn40ZVUa7L5g74c9rzHDXTQkzOxFG1oGQnFP0K9wwJJfw
	PRmSKUsKT2biN2NtqxhjXNovGffiUSU2IeVDgwZyg89o7RbHWyPzsWh2P8ha7A==
X-Gm-Gg: ASbGncvOQfMmMMF+dLDTIxznlTSc8SgXmIAGMBIMl2/tcqTQxbPZq4T1tzy7lOn1cse
	lp3wqaFM5R3CUgOP0R6MEfUIBAt6Ls/YSsytJqt19qQ5HS6Wo8i7IvUgf02ag4X8Vw3+WA35TR1
	ZHCT605RZaFbW4v9b0KpYlJdhqelPitmQjuCABv2i9ZWOeDdGxpUhWCHbpve7aINK5QNqN4W+Xl
	whm/4O3D0zgnkpHj4htth8m80LV2jaUsyHR06wTmLN70ee/xkNELoDUsU8lOOoF2/YwUjaBZdc9
	uATFVgU4fRYVLVGHYAOYxjOkFTuConvoLIr1lr5mEW7XiF3Yv8HW39HC5CnEER1C1+PZhl67OPR
	0wiz45SDHBWXF3ACZGt6ttnyS+OubT5A+sM6kIz7eQXbwO5snJfOyu+Ia5C8Um8ZA95G6L8+DFg
	==
X-Google-Smtp-Source: AGHT+IFYn9l+IK6z2LyWWy+j6eUu0dD4kgCsi91i0dMipO5RiDiPMrX4zFLHwlaFU3VoW1F2PUEuvA==
X-Received: by 2002:a05:6a00:1789:b0:772:48c5:c758 with SMTP id d2e1a72fcca58-7742dde288bmr14089090b3a.8.1757379615253;
        Mon, 08 Sep 2025 18:00:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:44e6:767e:cc5a:a060])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466118d15sm215227b3a.27.2025.09.08.18.00.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Sep 2025 18:00:14 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
Cc: vbabka@suse.cz,
	harry.yoo@oracle.com,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	bigeasy@linutronix.de,
	andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	hannes@cmpxchg.org
Subject: [PATCH slab v5 2/6] mm: Allow GFP_ACCOUNT to be used in alloc_pages_nolock().
Date: Mon,  8 Sep 2025 18:00:03 -0700
Message-Id: <20250909010007.1660-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Change alloc_pages_nolock() to default to __GFP_COMP when allocating
pages, since upcoming reentrant alloc_slab_page() needs __GFP_COMP.
Also allow __GFP_ACCOUNT flag to be specified,
since most of BPF infra needs __GFP_ACCOUNT except BPF streams.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h  |  2 +-
 kernel/bpf/stream.c  |  2 +-
 kernel/bpf/syscall.c |  2 +-
 mm/page_alloc.c      | 10 ++++++----
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 5ebf26fcdcfa..0ceb4e09306c 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -354,7 +354,7 @@ static inline struct page *alloc_page_vma_noprof(gfp_t gfp,
 }
 #define alloc_page_vma(...)			alloc_hooks(alloc_page_vma_noprof(__VA_ARGS__))
 
-struct page *alloc_pages_nolock_noprof(int nid, unsigned int order);
+struct page *alloc_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order);
 #define alloc_pages_nolock(...)			alloc_hooks(alloc_pages_nolock_noprof(__VA_ARGS__))
 
 extern unsigned long get_free_pages_noprof(gfp_t gfp_mask, unsigned int order);
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index ab592db4a4bf..eb6c5a21c2ef 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -83,7 +83,7 @@ static struct bpf_stream_page *bpf_stream_page_replace(void)
 	struct bpf_stream_page *stream_page, *old_stream_page;
 	struct page *page;
 
-	page = alloc_pages_nolock(NUMA_NO_NODE, 0);
+	page = alloc_pages_nolock(/* Don't account */ 0, NUMA_NO_NODE, 0);
 	if (!page)
 		return NULL;
 	stream_page = page_address(page);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fbfa8532c39..dbf86f8014de 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -581,7 +581,7 @@ static bool can_alloc_pages(void)
 static struct page *__bpf_alloc_page(int nid)
 {
 	if (!can_alloc_pages())
-		return alloc_pages_nolock(nid, 0);
+		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
 
 	return alloc_pages_node(nid,
 				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1d037f97c5f..30ccff0283fd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7480,6 +7480,7 @@ static bool __free_unaccepted(struct page *page)
 
 /**
  * alloc_pages_nolock - opportunistic reentrant allocation from any context
+ * @gfp_flags: GFP flags. Only __GFP_ACCOUNT allowed.
  * @nid: node to allocate from
  * @order: allocation order size
  *
@@ -7493,7 +7494,7 @@ static bool __free_unaccepted(struct page *page)
  * Return: allocated page or NULL on failure. NULL does not mean EBUSY or EAGAIN.
  * It means ENOMEM. There is no reason to call it again and expect !NULL.
  */
-struct page *alloc_pages_nolock_noprof(int nid, unsigned int order)
+struct page *alloc_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order)
 {
 	/*
 	 * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allowed.
@@ -7515,12 +7516,13 @@ struct page *alloc_pages_nolock_noprof(int nid, unsigned int order)
 	 * specify it here to highlight that alloc_pages_nolock()
 	 * doesn't want to deplete reserves.
 	 */
-	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC
-			| __GFP_ACCOUNT;
+	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC | __GFP_COMP
+			| gfp_flags;
 	unsigned int alloc_flags = ALLOC_TRYLOCK;
 	struct alloc_context ac = { };
 	struct page *page;
 
+	VM_WARN_ON_ONCE(gfp_flags & ~__GFP_ACCOUNT);
 	/*
 	 * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
 	 * unsafe in NMI. If spin_trylock() is called from hard IRQ the current
@@ -7558,7 +7560,7 @@ struct page *alloc_pages_nolock_noprof(int nid, unsigned int order)
 	if (page)
 		set_page_refcounted(page);
 
-	if (memcg_kmem_online() && page &&
+	if (memcg_kmem_online() && page && (gfp_flags & __GFP_ACCOUNT) &&
 	    unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) != 0)) {
 		free_pages_nolock(page, order);
 		page = NULL;
-- 
2.47.3


