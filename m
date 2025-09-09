Return-Path: <bpf+bounces-67822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 656BAB49E71
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF163BA58C
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 01:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150A222172C;
	Tue,  9 Sep 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbJiLhRR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2447719343B
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379620; cv=none; b=II5YW+mT+0C0TTryS5a0GDyFxLmyqyAiBRQrG+lHHEDbJPHVSTCQLMMl4MZnAiCTgGb7h4wRv3/cOavO8XMpb6Unok8vb5+d7TrkQ5HhELOBs447oxMCLkkpDC29ktBzAn3aju7oA4Z8NShvOq6brJoKf4KCg8IlT9hEXab2Ne0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379620; c=relaxed/simple;
	bh=AAysDizNNkrlC8Dlh62Xaa+kSRpKoEGnD4YOpc+FAsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rtz3Oq57UUAh5+Gl2O6xCDAKvoeoPESIlFisp2F4M+GUyTX4b5angMQpOuoOwxFOnyO8YAEOuPDTxoxpZCAwCDV5zcJyGQN7iPvA+HcJIln9ilzbHpPk9gee9f0d7yAXLe9BjrgZV60taPnj3oaucMurc1uIHAlUVmWBP0DkEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbJiLhRR; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326e8005bso4581380a91.3
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 18:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757379618; x=1757984418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lweQth/eoeP4wh/Y1X6sTVK7tPaLR6fCtzruOPdl+ns=;
        b=WbJiLhRRi3fpF7Eo8GgoqtJzHRweFlvWxCB22QRkj9MaLQt0mhCH6Y4Nq9pvXHPt6R
         zKOh2413+v5+t0PXhBe3VGllDSXcC8q67GolvzHMMDxkCXDcRkPgxKEeIe4NA4hzHxea
         M4ADXzVRZJjqIGoV4laLXkxc2ortYsIajF/3BNenNv9lSVXyJrCRIg+LDScIqtEsjALW
         KZgWAUSK0+gZZmv2TOu6WjCjByvH+14DkF2GIBPD6w9OyAow52oA09I9V2F/b0zH6IMd
         FWVOyHdLySt+Px4+5HBwFPtdsq9tTGkY5NFG0XIDVdTagsa3M54Sqn51Hi2dc6M/MEr+
         GFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757379618; x=1757984418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lweQth/eoeP4wh/Y1X6sTVK7tPaLR6fCtzruOPdl+ns=;
        b=BdTrR/9HrYyq1irJsfxvmzGvSzJv1B58iFCR8o42tZXml6zuBpPNu8JfRCu2lC7puq
         SPxV3MOotF43MTiZ5IR+pEwK7wgsP3Fv/XxerZFePeMxb9yTj3ktv5zOrSC34SkQrHZ4
         lqxLH8oK7b8HXh/MvELZCTktP1ASfJXpEZWvEw9Exiokl/tCzpqovnQCzkul02A/5BjA
         KMoU9cmXXYF6Nu/dKDB4GvAbMkg0xm0STasdbeF4ySkLGxUtd4eDeXpwLlIaSG4MaZIj
         NvYO8fBdJt0Eiqdw8PBEYIuYVCJ8Pv3ZtvRpf5Rl9l0GuiQMtJviohQwJ3wX5rw4cJhp
         GsHg==
X-Gm-Message-State: AOJu0Yx8Bspfo/7S7YbUelySAfYVf0NkZXAqmtABnFvkkui3bSdzLXCR
	azilr40lGo9+4kRlmvi7YlFL6zH+PjlssylNldWVTPpNoYk1hogrG4INrhFjXA==
X-Gm-Gg: ASbGncsv3HFoEKW4THZOlRdEm2spu9i/sJNq51eivY8uJnpITfHldy8gCf4BZvUcNWX
	sUJxjOR8uXAGG29swuEB/k0eGUUDToxLec1thrUv1VVTuZTG1q4eOkV0UIXBv2yBClMBbYxYZvw
	K4e3ttOSoxFP3aClAIYiGwT9C5l7s7GodUz/NUQJ3FcWEHSmI42+EqFtISaHr3brMNeCB7GrtHH
	Z5yW5rs422yrLCc7C+bYyFakTtzn0+bPXkFYjZOZuNLegwHJP7bNQDisG5RhrcIFaXe4tCA5uGf
	nkoBDypBqxHdYAz46bi0v+GluS0bhxwiIxc+8M7Vabs3CNmnY4KCPKDpycRHNkPxEmFqqPSfEaj
	KEE5boPw+q53MPXllK0cN4qNnd0eEU7+3AzdapY6ou0akBFpLcXN70En78K+oRC/uKvAQ7jnIr9
	MJLISo3mUj
X-Google-Smtp-Source: AGHT+IGcC1Pn9CL6jai0UNiIjOeh56a1f273MfYqECSfhc//Nu1mCQn/YDNIhWHyr7s7smQBh7K17Q==
X-Received: by 2002:a17:90b:2883:b0:32b:97ff:c944 with SMTP id 98e67ed59e1d1-32d43f93d9bmr11748116a91.28.1757379617901;
        Mon, 08 Sep 2025 18:00:17 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:44e6:767e:cc5a:a060])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b694f5120sm16166651a91.0.2025.09.08.18.00.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Sep 2025 18:00:17 -0700 (PDT)
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
Subject: [PATCH slab v5 3/6] mm: Introduce alloc_frozen_pages_nolock()
Date: Mon,  8 Sep 2025 18:00:04 -0700
Message-Id: <20250909010007.1660-4-alexei.starovoitov@gmail.com>
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

Split alloc_pages_nolock() and introduce alloc_frozen_pages_nolock()
to be used by alloc_slab_page().

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/internal.h   |  4 ++++
 mm/page_alloc.c | 49 ++++++++++++++++++++++++++++---------------------
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc03..9904421cabc1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -842,6 +842,10 @@ static inline struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned int ord
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
index 30ccff0283fd..5a40e2b7d148 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7478,23 +7478,7 @@ static bool __free_unaccepted(struct page *page)
 
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
@@ -7557,15 +7541,38 @@ struct page *alloc_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int or
 
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
+EXPORT_SYMBOL_GPL(alloc_pages_nolock_noprof);
-- 
2.47.3


