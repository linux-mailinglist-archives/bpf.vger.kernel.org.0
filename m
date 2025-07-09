Return-Path: <bpf+bounces-62733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9580DAFDD1E
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296D81BC8254
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21692199947;
	Wed,  9 Jul 2025 01:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YztZzglr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD118B464
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026001; cv=none; b=SQo237B+y5b+d0xh3KxceNC97mzvs4ygRZ42Rh9KCdfmwr/cS/9Fwvuo4BLj2tRSgWydu45sSmVCvJjodVXN4TUKQkRqfa+Zd0OFJBrkYpB/tGUj7Ycs0BcDluZlKzGWqe9ICVjrdP7OFTL4KtmWxp56RgcDEdROyFKLSWpa2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026001; c=relaxed/simple;
	bh=P2XZGdSkkAFyODSPdEwiiNaBKxYB2nyNakMRZNrm7lI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rIwiIiks0ujqTLquB2zFPa4+2bBBY3SXBd7HtqRP8Mg0LVuSXwFDGzx/671DtELlFQ4VXwzPZ8cs9LO0JqIm1fGpr0m87bZDrO7k3PTrci4W2eDSdZ7ulzVZP8cftG4j+pHrVYXggIh5uhiamjG8Gd7CitHGEJ/eipL4fMLohhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YztZzglr; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso4240959a91.2
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 18:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752025997; x=1752630797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGJ5phVBe26AHffUjtQ0C5chQhrjMeWzPyV2gXCSEws=;
        b=YztZzglrNyMnMnnheX9iy3YmT7wTsIuACiynSUWrLEeiKo1hrRvcqIcpMnk/iMXcsm
         m5LwKbwiuhKsVGIUaPj261otMOzOvTZkG/qAz7P2TCwg92ZRG1BJDjRGxMk2vSYORf9i
         6ROcysaRF7YKNH1c+EzmMDII7Epipyb72xDGRgYLKPiKbaTGoB6N4JzHAG03bWmJd9JK
         qKMhcInNHWHVZmhz5ZAdz30O9xCjHV1n3KyOgF9GFqq2DALV/seK3Wc3YKBbNtR8DmpS
         eUkRitmzyrB8EVQGVE9zjjOGl85hzwLxO1lgcdk4DQmC/MjvzP2EA+BdOQpTFrGWu6tm
         S+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752025997; x=1752630797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGJ5phVBe26AHffUjtQ0C5chQhrjMeWzPyV2gXCSEws=;
        b=tlJrwOwmWj1XB4dxMRGX3FJcJY390EjDu4R7dSD7vQ6ilTCU57wY65NX/BdA8SVVck
         Ag9Y6oSdeGyeuGjcWrs55UMQd6ZFQsDQXVpyDSrv/8clKNIV8jDYBHobJ9egqU+3vSB4
         el9GsSUFPRmKU6a7nJZ3fRd99+pyCEEqfef+4crBdh+r2DG50DfV+zJ4AAbCNxBE6Of/
         Fhu1mwv0+ZfBysBAnnMQjzd4MlLZhxv+DdnNHPH300RbzFaF2sXTvwn4XH4lYIuh1Oin
         LBr7fu6E8W0ma1Q7M9j7etg2s9ZnMZV+8WsCIBReMjSBAUOesDkMO9dEgT7m5DGEBzjI
         Y0Bw==
X-Gm-Message-State: AOJu0Yxk7mMYAdFwsS838RHebo7hl0U/lZ+nxEm+iUHucF5Dk0MIrN37
	yKZYhNjt+fIsGl+9a+fkcG3umgSErbHe38Mq2udweNrenVm1dvbZlrY7e8wurQ==
X-Gm-Gg: ASbGncueKwndoP86JciI2gaWi/QrOKVGwpRCGxtrA8C8MqzkuYmlNGBxr7DGv7nxskS
	21DpDQYJSE/+zsIIiRxhxtNJWIFGtodWPz5HgFXoNWZ/DamEL/K5MQfCp23m/2be1yVDJbZ5LJ+
	PmmocVs82S0AnReAQzUlI1xttz0x/4AxE6u/4Bt4j5xhDw5hDb7CO71Rn33vtVJtcWJCiTc5YjJ
	6GcAnbqQ4h/vy3d9D3hgG1xI7S1qpvZgYxuY794Nm3FJy+Awl/DfGR6W8eteO3QDI4KHaEoEsJL
	riWj2cJAeSjOc24GXFmZ7xFTkMRfTNDJOO//BN1gvGIysmGDngoUsYTZ4CQtcZSzJ1zJn/Rdh+u
	ozGeb6rGxnm73RynrFF04wS0gq1s=
X-Google-Smtp-Source: AGHT+IHGHvw2R/ZLy4YM57AnOJL7xjem1ShfJH6FuzBAF2fTOGwIMvfNS2UPCGKW+uTTJb4HLFOW6w==
X-Received: by 2002:a17:90b:1cc3:b0:311:b0d3:865 with SMTP id 98e67ed59e1d1-31c2fe04666mr916648a91.32.1752025996974;
        Tue, 08 Jul 2025 18:53:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300f7177sm453103a91.45.2025.07.08.18.53.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Jul 2025 18:53:16 -0700 (PDT)
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
Subject: [PATCH v2 4/6] mm: Allow GFP_ACCOUNT to be used in alloc_pages_nolock().
Date: Tue,  8 Jul 2025 18:53:01 -0700
Message-Id: <20250709015303.8107-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
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


