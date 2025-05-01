Return-Path: <bpf+bounces-57111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DCBAA59F7
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 05:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF20189FE3F
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 03:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705B8230BD2;
	Thu,  1 May 2025 03:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0MDYNtK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B31A0BFE
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 03:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746070069; cv=none; b=VNc0ht/rKP42X/ViUwJ4pLOIunzucEPUr/Jj0n74SBhh4jJQdkIOcAL5nWagdS93AVH93xHx7DHWro/6zIBjIgRa5LX33PP2HWcKlVqN+753fmhxEUlD17+R1vaBnRU68TDY0VIR2GjNS+k5SOsPLHj4IX7wZcJt9CH+iBIiCXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746070069; c=relaxed/simple;
	bh=p6OGuOJBmHTJxRzgOuEGvyT0XSe/A3Eb78rbZV6bOw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=erq2fsF0uPvV1k0M4QcHfF9i8JPf01XGKjIL51BdEQ4Ij/7ioY4Vhcrh/18zNdtnoD58iyCuZzRRo39PuDn5kt2+RF13Jsz01RtzYZ4zMdRxLRfcurGexAhY1EXFF68zmZjjLLTTjJQqOo0h9lrNW8pJA1zXAok8haeal5mxoKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0MDYNtK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso593828b3a.2
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 20:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746070066; x=1746674866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+EUZuBpCtEkxSo+g5YTm/FD1JFtDCLsEwWX610EiQk=;
        b=H0MDYNtK+8ipGA+pMr76Rq334tm8AzZtVx0msR5tRJdan1zcnhO6pjtRFb7apX83tu
         ZFXTxsvK9oSEOiuxNQIo8k3Cv8X6+onDjDkxTMkAnslqM9EARUixzguhCEKJMB6oxWLd
         CEWN53OnC1DX56SIEM2AtQgaTFt4e6QmKi8CyMOMwCnEofJB11zo4a+jpwIfEdfUWTCz
         ctqRUHdbpq8ojTHfcheQRLWjiJyFGEgqQaJ3ApKSDzlACM35jLcbGROf/itHmj9J2IEf
         KJU/zCXX4h7syyWult2i+FNmh7yb1zwAS9ktL1D0OGEwVcjmug6IK8dNIicoVE5hCoCG
         xKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746070066; x=1746674866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+EUZuBpCtEkxSo+g5YTm/FD1JFtDCLsEwWX610EiQk=;
        b=kb5YsC5RtatN8s1ChyloJ9a7EM0pHZyHfgT2Xn7d7nmfqKxT64naFKfV/wVC3Kny65
         iyHTXaQMSGkFTMOAsIfTVk3j6I0zw3m63k/RV1QQNiLlyp9WTBWxyJM6wJLM4aCqiume
         J+DLEXLg+vEsT2ErOfRMlZmMF9oca2v+CMAcaC6XJ46F4EA4Z3gYVbAdUghQnYs3Pbbe
         4AP9YwQbH/MiKLOLLO5Ky8llAaJOsaz74JhJXYZzxjLeEjPOGpmSyM/MUnI7gxLqTysA
         Zc830kA9ygOgkFs4amOemWEn8j8gkm04Cyy9PLM9kH8mSEbZaOChHC6IYEnqS2e2WRwT
         fJNw==
X-Gm-Message-State: AOJu0Yw7PlZRtB9YxYalzncr/Tr5fdqX5cctkt9tk6y/ya9Q/9HSdhhe
	miNO85HXaAMV7St4rbRdvrUEf191UZ7qK8i3JxRIFTl2TM+WDpOLHwI5Ww==
X-Gm-Gg: ASbGncvz0aP4vqN5YV2sr9YuHRlPOx02kvadWqsReJPaxjXI0b2LCdZbp6tx79xSE1w
	u3UcmQ41Ub0KQ+wgmSHWCWmZU/FK+CNbUMrDSPjFYW12YhDWpLebBxto3M56Ya/AdiJ7wUxL04J
	JNfx/b6OPZaOmCm5DmeZwlBWeDBx90DVIiZGfLHeP2OV9OXv+QHb1bneiHyGOTB6DbdeXqzUw5B
	9LlMPk1Y/ANH9FCoPa5x+u/N8yfHZ2C7ey15j7jehhWt49s7OaDqWdQOu8gR40fXzIrLsdARwdO
	YVpKOyHAb731fx58AJ4hd6mzCxzhtxzFWXa3/3GToICJxh5cX3iYD+4ipveKcxj7GOJ9
X-Google-Smtp-Source: AGHT+IHeLJ2NXP14CarSZr4yDkwP+sPREACfOArzqc/wYp/BDY0aljYBICiyQDeQSwmr+N9W4BBA8Q==
X-Received: by 2002:a05:6a00:9282:b0:72d:3b2e:fef9 with SMTP id d2e1a72fcca58-7403a828934mr7589622b3a.20.1746070066598;
        Wed, 30 Apr 2025 20:27:46 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:13f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a8d256sm2512273b3a.157.2025.04.30.20.27.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Apr 2025 20:27:46 -0700 (PDT)
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
	hannes@cmpxchg.org,
	willy@infradead.org
Subject: [PATCH 5/6] mm: Allow GFP_ACCOUNT and GFP_COMP to be used in alloc_pages_nolock().
Date: Wed, 30 Apr 2025 20:27:17 -0700
Message-Id: <20250501032718.65476-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Allow __GFP_ACCOUNT and __GFP_COMP flags to be specified when calling
alloc_pages_nolock(), since upcoming reentrant alloc_slab_page() needs
to allocate __GFP_COMP pages while BPF infra needs __GFP_ACCOUNT.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h  | 2 +-
 kernel/bpf/syscall.c | 2 +-
 mm/page_alloc.c      | 8 +++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index be160e8d8bcb..9afbe5b3aef6 100644
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
index d0ddba2a952b..83af8fa9db3f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -578,7 +578,7 @@ static bool can_alloc_pages(void)
 static struct page *__bpf_alloc_page(int nid)
 {
 	if (!can_alloc_pages())
-		return alloc_pages_nolock(nid, 0);
+		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
 
 	return alloc_pages_node(nid,
 				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1d77a07b0659..303df205ca7d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7379,6 +7379,7 @@ static bool __free_unaccepted(struct page *page)
 
 /**
  * alloc_pages_nolock - opportunistic reentrant allocation from any context
+ * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, __GFP_COMP allowed.
  * @nid: node to allocate from
  * @order: allocation order size
  *
@@ -7392,7 +7393,7 @@ static bool __free_unaccepted(struct page *page)
  * Return: allocated page or NULL on failure. NULL does not mean EBUSY or EAGAIN.
  * It means ENOMEM. There is no reason to call it again and expect !NULL.
  */
-struct page *alloc_pages_nolock_noprof(int nid, unsigned int order)
+struct page *alloc_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order)
 {
 	/*
 	 * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allowed.
@@ -7415,11 +7416,12 @@ struct page *alloc_pages_nolock_noprof(int nid, unsigned int order)
 	 * doesn't want to deplete reserves.
 	 */
 	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC
-			| __GFP_ACCOUNT;
+			| gfp_flags;
 	unsigned int alloc_flags = ALLOC_TRYLOCK;
 	struct alloc_context ac = { };
 	struct page *page;
 
+	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_COMP));
 	/*
 	 * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
 	 * unsafe in NMI. If spin_trylock() is called from hard IRQ the current
@@ -7462,7 +7464,7 @@ struct page *alloc_pages_nolock_noprof(int nid, unsigned int order)
 	if (page)
 		set_page_refcounted(page);
 
-	if (memcg_kmem_online() && page &&
+	if (memcg_kmem_online() && page && (gfp_flags & __GFP_ACCOUNT) &&
 	    unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) != 0)) {
 		free_pages_nolock(page, order);
 		page = NULL;
-- 
2.47.1


