Return-Path: <bpf+bounces-63400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C80AB06BB4
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 04:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0AD4E0683
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 02:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B302B7E792;
	Wed, 16 Jul 2025 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY/HN9AV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE52750E5
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 02:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752633004; cv=none; b=gVu7pq6FXCaXDNxsYI10Z5LSoxqiUZd1ouZ8lSmnUiXaXY9IZlK+jSf5Z4BjIF9Uk24lGwiYCLIlm65kLh1AlWhq7XFy3fY239oaSvTQYE5ir+OnLzon5YNV9ZUlotucO4Vqq2JU3mEhEEdI9L6wanNcL1UV6+VFIsV75Nwxb7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752633004; c=relaxed/simple;
	bh=Y/W2ev4sUgpL2aQ5R+cmVPrSRn/0qFklzVvwTy8X7yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=geLf+ZNoEIlTTTYyTWUhPiYrBvEyRxskumPve5PzGt0zrgZQQfSLaJ7rXPKNH9McXkV8r/4GJBvjYxRblNzA7TnlFLQEfd80gsbT5e71t7ZaZhlIQzFDZ+KAlY9OuFABOWXrOe/0kz78CV0pzabnPgg3YPqKTE0X/72BGFaYSxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZY/HN9AV; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b34ab678931so4516010a12.0
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 19:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752633002; x=1753237802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuA/XIiS/PtBSaJOIUt5hu5AZg5850snKe3VMWy5DuQ=;
        b=ZY/HN9AVaCJQAByS7N0XxdBxQIP3Fq/P+b54g+CA4kccnaHoDsw762WQWU3W48gQ30
         yOZGz5kYRvyRk65trC1feoJmkTWi9UwvwMMavQG3/uky8PYHgUOczxH5BFYdHge/FUZu
         fXiWnRk57P55CPyU2g4vXfTIBmVWVAUGpnwYZ7a6Tk/1bfMy5ti3zOLqrl2eh5meZ7Sj
         8jlhXluslHGhphaKIr0YmIARpdw0JUDcylysyFd/IFE173yutXM3Np4sMpvfH1TeDT6H
         NnsBxF+XudX5FFYsePyzTff0GQANabu80CVlcxxHtYv51j2gtIlHJMNtOLIhauNgWlBq
         +yNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752633002; x=1753237802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuA/XIiS/PtBSaJOIUt5hu5AZg5850snKe3VMWy5DuQ=;
        b=Nf9zXIe0PP5d5QJ0FB288bWI2Jqcdb+hvXdrMFc7ERQ6BTqIfLTbUNu6z33u+FZsth
         am2wcegJq6C89JJsuYykFWSFxlUdpxZAff7EQI0jNQ588ynboO3mV7hTwlkxCxa6DWIP
         mGxq+ir7VnRS6gJoL6uGSERadAuIp5+lUQce8/M5ACtpvRrWDDW6gYBBjEFo0DE3yUGt
         KqlU+wUlcykU3JCzUjKY7amlx81V3VTSUyC2ElueJCWvjmOVhbC3Z5gUZirKZPAdfHMi
         aCZe9q7II07mPVOUK/YdAV/jNYhG2bgdLUjNiQpk7mlW69wosqnTjuyIqz0oPdHPDPsk
         ATjg==
X-Gm-Message-State: AOJu0YxbMQwDPvJYbfzvRn/WwrOPcEXeLGZomCC2CxnEjLRdaFNgj+El
	4heoIY2qBPJdoOr6XlnaUXBfhbxdqJmPmiLfutedYWQA9TRH41aLg3p+9Or8rA==
X-Gm-Gg: ASbGncuJMBmvRT+toos6ehCcpHCsGGq26mfWgb/VwbDeXiD+sApVTYJ4HsKpMDjfHmm
	pVgYHIEmmz9d2GlVFLuFCts12uFhJ4/QNTkXhDkaqeHUey/mPd66iD3Kt+LkhGh9oArT+CR9BgH
	x6xeVSqKun77qhmq8sxUMwc6tWkTxcq0GS8zS1UMQA+ROhBBu3ObUEQxJqpLmxKwjAwwpz2C4Ot
	pvlAzWxT/ktVXA4eoZK8QKIKoycCASTphT92vsXfS3PqS/5hNAbFwxt4imvE16+sAhJ9ViQYMy7
	GGfSSbRP8KpFJIEApIcy1DyuKKbEaEQ5p7NxJNkjQbELfO0TAQYWZUWMuTyWDfyRr1raQKMU91Z
	ePD0a5J0hkbAwyyVHFKnq/+kaV5+kRjy+PC2XWYg6qPeIQdJnkGqcAaVcyfsTCF8=
X-Google-Smtp-Source: AGHT+IGx77ETC8ZOiWV8rNUIJdKbdYS3AhSCR/mbxtYMjINZJ59P+I7tTHKAVaz7pIGdO1wkg7hNlw==
X-Received: by 2002:a17:90b:28c4:b0:311:e8cc:425e with SMTP id 98e67ed59e1d1-31c9e78b707mr1669029a91.31.1752633001702;
        Tue, 15 Jul 2025 19:30:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e61f3sm306751a91.15.2025.07.15.19.30.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Jul 2025 19:30:01 -0700 (PDT)
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
Subject: [PATCH v3 3/6] mm: Allow GFP_ACCOUNT to be used in alloc_pages_nolock().
Date: Tue, 15 Jul 2025 19:29:47 -0700
Message-Id: <20250716022950.69330-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
References: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
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
since BPF infra needs __GFP_ACCOUNT.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h  |  2 +-
 kernel/bpf/syscall.c |  2 +-
 mm/page_alloc.c      | 10 ++++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

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
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index dd5304c6ac3c..eb9b6c4c10e9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -579,7 +579,7 @@ static bool can_alloc_pages(void)
 static struct page *__bpf_alloc_page(int nid)
 {
 	if (!can_alloc_pages())
-		return alloc_pages_nolock(nid, 0);
+		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
 
 	return alloc_pages_node(nid,
 				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 78ddf1d43c6c..148945f0b667 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7506,6 +7506,7 @@ static bool __free_unaccepted(struct page *page)
 
 /**
  * alloc_pages_nolock - opportunistic reentrant allocation from any context
+ * @gfp_flags: GFP flags. Only __GFP_ACCOUNT allowed.
  * @nid: node to allocate from
  * @order: allocation order size
  *
@@ -7519,7 +7520,7 @@ static bool __free_unaccepted(struct page *page)
  * Return: allocated page or NULL on failure. NULL does not mean EBUSY or EAGAIN.
  * It means ENOMEM. There is no reason to call it again and expect !NULL.
  */
-struct page *alloc_pages_nolock_noprof(int nid, unsigned int order)
+struct page *alloc_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order)
 {
 	/*
 	 * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allowed.
@@ -7541,12 +7542,13 @@ struct page *alloc_pages_nolock_noprof(int nid, unsigned int order)
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
@@ -7584,7 +7586,7 @@ struct page *alloc_pages_nolock_noprof(int nid, unsigned int order)
 	if (page)
 		set_page_refcounted(page);
 
-	if (memcg_kmem_online() && page &&
+	if (memcg_kmem_online() && page && (gfp_flags & __GFP_ACCOUNT) &&
 	    unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) != 0)) {
 		free_pages_nolock(page, order);
 		page = NULL;
-- 
2.47.1


