Return-Path: <bpf+bounces-63401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB2AB06BB5
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 04:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDB118954D1
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 02:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F01273D96;
	Wed, 16 Jul 2025 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buVuY8o5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C801C68F
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752633007; cv=none; b=k8QriLFQyUFAgzPGYuMPKZlU+vWtXGNLuxbWmyMeMrCRx27WPr1mxiFv2heiPNaJk3eGc10mCPiVylTdKWD0ZogcVlPup1G55ULkKc215K3uv4siRk+gXZBxbGTOEZ5Up6nkl5WU0KZ6MxvraQDuOzuSMD9DASdeefyq3jDyzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752633007; c=relaxed/simple;
	bh=Y3MT3oWHibBcKRhB/N+6RZY3S66hj1wDO7MapAJKhd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eLS83dB/teDu7rfRV539/Di7Bk7FvHOhMvT+6p760Nxw0W0KGVa3Dp/NbScABNubEtiZ3Zmaqpjqn1zsKD9cRsd5UJ4yhKaSDjqE1EPmqImnmivOABmHboZK29V7LiCYBVZoYzvSN1+jgnfB4F83sDX4OGFTO22MXbJjk2EF6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buVuY8o5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234d3261631so50025425ad.1
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 19:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752633005; x=1753237805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i518bbzfZO/aJkAgPJDTpr5hRhX5KSVRvbb0iT/IJ8Q=;
        b=buVuY8o5iqGy9Td3u7fpvwF5LyzqqLQk3r4WVRk+1rfyCTTkaz7Y2xvlTIiqMBfHxx
         WE8QBP68EtjV7g/mqoDwYj9AIfh9cronpS1jsr0cPxh30E0W9WhU+sWjiVuIE3K7P+kh
         UqtWU3Eawq1O+Z/Lu2NFfsOEPF0ZriDTr9F4epbGSo8h3XSMnn3oQs5Q2IqQ7O+I3YUi
         LW7hULQtgfrT8rmH4AxrpiqG1Xrk7VMpKebLE/YStzjYFXuJ9tDCsohyJEDnwBKfowBM
         L4X0kNfKk3BMBc6EPBSLjmrylLaAJCeo4zPXi5JpVk+A827Z9CH6n/wRjSv7OqW4Tvkc
         lxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752633005; x=1753237805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i518bbzfZO/aJkAgPJDTpr5hRhX5KSVRvbb0iT/IJ8Q=;
        b=JkwGOYPjH60eU/qULH4pcIYsHgMrCcX+ln5Hkk/bAq+N7bbGzeVIYxNY41OOxYzhko
         Os7oPiS34h0AO+5P0ePaaQf2xHxbjPs5hq2PXhxavkLrhUBmhgRDH0C1ZcCNhiR+yGYr
         hFALU332kFSirvkrfPLcWnKzlN3YI1GQI/4o7YYghRGxsUChnK6nBTYYw2j+0EywUfgM
         aNpSzu3VSx64fI+7D+C/pXN8KtMlLtCd8vDnKy77Yli6jWKqTLjkysWmF76a7Rw086Iv
         j69zssozs+3uWU32d+3uS6xi5loRPe4iiGrKZ0XJ9mBzg96vbtbaDTfRoQFYgxQxM+Py
         3q6A==
X-Gm-Message-State: AOJu0YzQwSB7YkfvqbM0fKfvuWKPdQyvT2WBiDdF4jsKhYsx3fs4hIfZ
	l8LC0FZCPGwqI9hMB8vTtNVBVNriAhh5zrjxJR0fVB9/WJCZRaUhE4mT5AKyAw==
X-Gm-Gg: ASbGncsMZE2Os1dLsW4twfYH919Vfog45o7LYdKQ/2F5bTi/u7gQyTn4cLf+7zZDC/O
	16fOOWjcnQT14MUJOYVx11677z3kgDSOp53DBjZ6BG1Bp3xpJ8bwE/z3GEiuBT62HTLSFP6QeUZ
	UJHs6/lE0ufG3SaOaZy7FwFH9Elb6u9fP7zbxD863AW5w0HVMWuXESd/U4VK/r7y/PT8vsmURt7
	GIpnZwWFKgnC+1Z4LQIC5vTV3v4kmZii3ydgX5NrzzMbkbO3AjfDXJ8GgBfC5I/LcLcrOFWZIE1
	+aSRjbX3TAlbU3Pp6OerCw+EQBj/il+1kl2eB4Nd5rS0yV3wSj65GRTvvyQkH7gfrwhhxWqyuqo
	fN77CPIpdukU8roH4qGBLpeMRsYuT61OQ1cLFAvSN/ZiXmXKrEFDahCqVv+5PMqo=
X-Google-Smtp-Source: AGHT+IHn6Byr5+wZ+pbkTuno1o31ixBo3a4hfO63c4om8gQKe5/SQIwhVu31aNzj2EmKlKVC4PYZGA==
X-Received: by 2002:a17:903:230a:b0:234:bfcb:5c21 with SMTP id d9443c01a7336-23e24ed6f39mr16153555ad.19.1752633004527;
        Tue, 15 Jul 2025 19:30:04 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aea81sm116743265ad.82.2025.07.15.19.30.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Jul 2025 19:30:04 -0700 (PDT)
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
Subject: [PATCH v3 4/6] mm: Introduce alloc_frozen_pages_nolock()
Date: Tue, 15 Jul 2025 19:29:48 -0700
Message-Id: <20250716022950.69330-5-alexei.starovoitov@gmail.com>
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

Split alloc_pages_nolock() and introduce alloc_frozen_pages_nolock()
to be used by alloc_slab_page().

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/internal.h   |  4 ++++
 mm/page_alloc.c | 48 +++++++++++++++++++++++++++---------------------
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 5b0f71e5434b..ea85cf703331 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -837,6 +837,10 @@ static inline struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned int ord
 #define alloc_frozen_pages(...) \
 	alloc_hooks(alloc_frozen_pages_noprof(__VA_ARGS__))
 
+struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order);
+#define alloc_frozen_pages_nolock(...) \
+	alloc_hooks(alloc_frozen_pages_nolock_noprof(__VA_ARGS__))
+
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 148945f0b667..11a184bab03c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7504,23 +7504,7 @@ static bool __free_unaccepted(struct page *page)
 
 #endif /* CONFIG_UNACCEPTED_MEMORY */
 
-/**
- * alloc_pages_nolock - opportunistic reentrant allocation from any context
- * @gfp_flags: GFP flags. Only __GFP_ACCOUNT allowed.
- * @nid: node to allocate from
- * @order: allocation order size
- *
- * Allocates pages of a given order from the given node. This is safe to
- * call from any context (from atomic, NMI, and also reentrant
- * allocator -> tracepoint -> alloc_pages_nolock_noprof).
- * Allocation is best effort and to be expected to fail easily so nobody should
- * rely on the success. Failures are not reported via warn_alloc().
- * See always fail conditions below.
- *
- * Return: allocated page or NULL on failure. NULL does not mean EBUSY or EAGAIN.
- * It means ENOMEM. There is no reason to call it again and expect !NULL.
- */
-struct page *alloc_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order)
+struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order)
 {
 	/*
 	 * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allowed.
@@ -7583,16 +7567,38 @@ struct page *alloc_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int or
 
 	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
 
-	if (page)
-		set_page_refcounted(page);
-
 	if (memcg_kmem_online() && page && (gfp_flags & __GFP_ACCOUNT) &&
 	    unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) != 0)) {
-		free_pages_nolock(page, order);
+		__free_frozen_pages(page, order, FPI_TRYLOCK);
 		page = NULL;
 	}
 	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
 	kmsan_alloc_page(page, order, alloc_gfp);
 	return page;
 }
+/**
+ * alloc_pages_nolock - opportunistic reentrant allocation from any context
+ * @gfp_flags: GFP flags. Only __GFP_ACCOUNT allowed.
+ * @nid: node to allocate from
+ * @order: allocation order size
+ *
+ * Allocates pages of a given order from the given node. This is safe to
+ * call from any context (from atomic, NMI, and also reentrant
+ * allocator -> tracepoint -> alloc_pages_nolock_noprof).
+ * Allocation is best effort and to be expected to fail easily so nobody should
+ * rely on the success. Failures are not reported via warn_alloc().
+ * See always fail conditions below.
+ *
+ * Return: allocated page or NULL on failure. NULL does not mean EBUSY or EAGAIN.
+ * It means ENOMEM. There is no reason to call it again and expect !NULL.
+ */
+struct page *alloc_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order)
+{
+	struct page *page;
+
+	page = alloc_frozen_pages_nolock_noprof(gfp_flags, nid, order);
+	if (page)
+		set_page_refcounted(page);
+	return page;
+}
 EXPORT_SYMBOL_GPL(alloc_pages_nolock_noprof);
-- 
2.47.1


