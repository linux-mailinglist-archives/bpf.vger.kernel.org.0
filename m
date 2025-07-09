Return-Path: <bpf+bounces-62734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7A6AFDD1F
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888EB1BC8387
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F8619CCFC;
	Wed,  9 Jul 2025 01:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqT7derD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63B8196C7C
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026002; cv=none; b=QDfN38AEtaeC0cKaKqWW/34hhVxqSBgfeg3GMZ5AEwMj4UhmB0AMfbp0AXT9+Px/AqAftbAwd7Wyhi/km/dFyKGgyADpsmu9WQ2XnXk9jPOx2df87WjCyRr11JaXnkc7Zo7woZMrLym97dcU9KPLT2Suti/LXRkwpn2yGBE2m7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026002; c=relaxed/simple;
	bh=nvAcORkGiTSVNskj1HbrVqJRhmVj56QdnmlITJ8Kyx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BcqegOc3Q3CgZAc0EdW3usAyU3fXyyAeyO6Fa8C4feLFLCT82gtnkzp+ZGz8uYqPTFhZ+ZPFOFz3Ca3lmANDmqMRDJX2RExqXqq9+vu34KsiE1PF04sp1jEi9M+49P6ueCwpE4d1pdvtXJBn5lxmCVtvPW4tLjITfq38GeK4oBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqT7derD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7481600130eso6635301b3a.3
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 18:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752026000; x=1752630800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swPCx2ZCPdr3kVviURV1cSakbdre5MF5VQyGIctNo/0=;
        b=HqT7derDpuLgvdbnYETOgbkb1lduZ2VRe2d1MocHmzo8pNR+y6y4qR2TUs3IgNGPnv
         NkNR1ukn7GX/9rM8h1VCWj8KeykXLZjWVvRlYrRvotV4rqziW70iFN+2vre+yLnJwB7F
         cgMj+FFbM6qiRAHNaYgihMhneR5tsV1EDRsa6s306cEJngyjrxMwXMeDQWEpIVfFo6Tr
         9oxJqDPJn5Y1dCndT1IY0EULaTlWX088NqLyt7Ys/eOodpN/mMsNaDpRxt2puxfEq3yL
         oDVKWCxOt+hYA7aj3p9arkUUQ+n+N1RWZmb+hHj9hpa1EC8KqeciRN3QKkCxI8aiFy5j
         Ay6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752026000; x=1752630800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swPCx2ZCPdr3kVviURV1cSakbdre5MF5VQyGIctNo/0=;
        b=Y08EbWQPKxrdlRSGj+xb6/43QvJtgIYt3/KJueMtmjdfyUYc+pX7bZfPkrMDWMQR2q
         rxRmhe9Lp2PAF6okGI3BvYf5CZuHv3AgrHUL54HOxk4fnSUzV7u1bCB/my2k7YU2Hn7Q
         PL2Z8de5RUb36WKhyTtaXejM9M7Gcv0oweCOGkSdPLJXcl7/sqi70LmdNFpB4Z1LWmfU
         bk0WWguj8bAwPvNYBAjzb+180VtUq/pWhEEZIe2o9jZ3AUyRKieThS6dp1H+2W2D2HIB
         8r9tDi9TsE+/nHKtsKBHkedl4yld15ugD+S+WSn8tBGwGnAp5ZgzZb4SIpLV4hFjFxZp
         J3fQ==
X-Gm-Message-State: AOJu0YwbEEyDui0tRzcf8dPQaZ1sFDplOP+4kbEbhnF8AtL6bVaZr0RU
	RW8b80s7eTCA5DOEzkjRhkiV9v4uhb3sBR+IaUDQixY0zEOKo0mnHQvU4Evp2w==
X-Gm-Gg: ASbGncvRC6+9mRLwQcezB3a9cT/3oKOW6VL3V67xS3rGxefVP1hB6jifdLKg1cT7rcl
	5SfTP3nwbEEjZBGFBs9JCGQRNB2Bjrc6ZqcOkhF4DByaDKxhGuRFagL+IQNbjU7d3V33M+CMWox
	BYnceekwg1HFg526jo+3hif4b8LggtV63zsNwojIymNtm9+bF6E+miecQnpEVktyKt6SYeq4tx7
	wYD4F2TqDMlr+OzghyzjI/loRCUpSQI49YIxhNSKj+xvHTMLbnjY+vjofwp6DjVGSKn6jMzS/Tt
	3imQnVk1h0NiMxkr7RNRd+GdxAOSqLv3HUdsk7w4WK5eUb8AMSeh4QwedAXK3PQguw3doDpE97l
	efMDyxcZH2piShhNJxpLGqBH63Wk=
X-Google-Smtp-Source: AGHT+IFyHvkwCKA3WtV4emwIkj9KrLzmSuKcCHFtpkTnsKskKbbrpP9oMuPYme/O7vMCfh2JX9n7Rg==
X-Received: by 2002:a05:6a00:22d5:b0:747:aa79:e2f5 with SMTP id d2e1a72fcca58-74ea60b6b52mr1390164b3a.0.1752025999720;
        Tue, 08 Jul 2025 18:53:19 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417e842sm13620416b3a.79.2025.07.08.18.53.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Jul 2025 18:53:19 -0700 (PDT)
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
Subject: [PATCH v2 5/6] mm: Introduce alloc_frozen_pages_nolock()
Date: Tue,  8 Jul 2025 18:53:02 -0700
Message-Id: <20250709015303.8107-6-alexei.starovoitov@gmail.com>
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

Split alloc_pages_nolock() and introduce alloc_frozen_pages_nolock()
to be used by alloc_slab_page().

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


