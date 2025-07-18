Return-Path: <bpf+bounces-63687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A77B099BA
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 04:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5FC7B9510
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 02:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7A1C5D4B;
	Fri, 18 Jul 2025 02:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF39172j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1342F17597
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 02:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805020; cv=none; b=VJeKpTKgEcR4F6TaErdDAQ7vkXnNzkvSshjCr0gTvv0nmfHrpKgNpOxJdA+bUN0UMWvnVYTyDZLZv01g9pju1axJVZCvC6ZMWePbf8NLFMIC1TjFn+Atc+FKG249ilyCn0f/25hxdxATHDGi6t186ePpIOJ+MhgAdOkeZE6GwM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805020; c=relaxed/simple;
	bh=Y/W2ev4sUgpL2aQ5R+cmVPrSRn/0qFklzVvwTy8X7yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fS5UGMuOzsfHY4CIJEVxz/V2JaTgPiMeGr0b+vEFYz9rn/jjv0kXlnchHzrD/rgc3HFQDIzUgvOm4QRXQQLcId6SLoF/7HH2Cx4oHamwd/BzAE9xz9bhRnG91TObBu8wPg+Bh9UOTkZINlmg73yfsGeT+rD/znc+GmaAW82wZsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lF39172j; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7481600130eso2141584b3a.3
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 19:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752805018; x=1753409818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuA/XIiS/PtBSaJOIUt5hu5AZg5850snKe3VMWy5DuQ=;
        b=lF39172jDF8mE2F/rfFtvZh4N/2Z+7Rel/lE+WDnrjMJjaVkdFqeEjBikH7wWxloWv
         JgVXB8gDfEJXbANoEX9h/PhX2kFHBEyUKxGu1QeTi8f2ducAdgbOhZuc/C2xEQziAUIZ
         U6FHV6Pf4FV6Cm9li43X996SSIzCUjSqxk3Bp7CgvCP0MpBl4aL9Yo4P5VltYMVEKnwX
         I4CcOQmX+WZVapbjC8fbNkQbm4K2KRNNxTBYn1dRxUTXwM9CLeLCqnY8MReK588+mupy
         00GxxVrIUIXOa+ITNgRy8fwa3GTBrlZtT62NZ50SHUDgQ19nIdE7ApCT1hwwRtOvEli9
         eqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752805018; x=1753409818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuA/XIiS/PtBSaJOIUt5hu5AZg5850snKe3VMWy5DuQ=;
        b=GByvNrSwH8s5TSsohnrQH0CnflhyvVuTzbDOD0NIcFfeKbFT79gDNDry4vkuT/cdvO
         otexxV+3zV6stv2ao6ImPLqIsS0bxlSp/GIuNv1JbFRd6vwvuKGEpoj1lO+2QPMsSA4p
         TOsmpS6rN8B0q9D7dBN3ge3ALT+AGeXAZ1G8Hi+2E5ZtiAsgARzEyMRv2826MTDbJfh+
         9VLjk2jJ7ugWjgVwFi1PaswpPwOaLkFu6LPoBbhutCbjuaTlIPCQBlYu6YbiMszMGRQS
         YBKikfv0EiERu/AHpYXrf8NN68EQieA6fRj7THaStqpEJlPA2xg0hpQiL3b3WgtPIAeX
         tVsQ==
X-Gm-Message-State: AOJu0YyJZySl10Yu6gn4fDZzDrDcCTZf1tUmuCA1HwiFx3OeG/SeBr9/
	cDVDukojGoJJiTcZi9xf9CtmD53iXstbd481FofFyu34dkxAHeZTeF7tWVaqnQ==
X-Gm-Gg: ASbGncsxtVsewIaXbhRd+VvxSjLQdWfk8NXDQC9T3AHI0l5QG/WwKYPU7QYIAKkdMPI
	06j6tKDFVDZy9N4TwZcKXuqeuzMwcVaIPnLlLJ1TiRPZxe4yGAKVF5ndjIfCGjUNR7hfJuzdGip
	3MZd9Z2N/0rnJq53Z6p2C1bpRedrnB5XI3iiPaw5J6nBQ+DZBxFoI5B6tiRXm+qF7CyNyhbBjnD
	sk9X7g88b63fOjp0bN+wPbWsKA0Vtei7q4pA/OgBd5BpVkVD+3Nv5xQlSWAmZ1Lo90nW2swjo+Z
	3arC2XvBiOVKlvqDeuCGgWvuivozJn8pcKSnDFNh4gJBWSTGbOdTdnjkuMFiNN+HSkYbByvIre8
	6Kj2etXfi/SD9CAuW2a7rRnm7+urgwyLRPIkLW6GrWP3Uo9xsRQ8Fo6PCKG2P0qQ=
X-Google-Smtp-Source: AGHT+IHFD95keE/9He7L+EbnGEIuvPADjxInNCQJsechooxa8qLKnunVikIclaiznhdQ84GlfqEaCA==
X-Received: by 2002:a05:6300:6199:b0:232:9550:128f with SMTP id adf61e73a8af0-23813237521mr13770813637.36.1752805017855;
        Thu, 17 Jul 2025 19:16:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe8bf2csm314930a12.17.2025.07.17.19.16.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Jul 2025 19:16:57 -0700 (PDT)
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
Subject: [PATCH v4 3/6] mm: Allow GFP_ACCOUNT to be used in alloc_pages_nolock().
Date: Thu, 17 Jul 2025 19:16:43 -0700
Message-Id: <20250718021646.73353-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
References: <20250718021646.73353-1-alexei.starovoitov@gmail.com>
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


