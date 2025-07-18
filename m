Return-Path: <bpf+bounces-63688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F9FB099BB
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 04:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FDEF7B9897
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 02:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF1186E2D;
	Fri, 18 Jul 2025 02:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByptkZyh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79EB17597
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805023; cv=none; b=f+4q9RlEYu4rBpArWkY6cQg3zp9zPx8ejjkJJiGdPIq8h6P1srl2N/BuirolhLSCO0GjUNiqew8fNIcW/JKUz3mpi7knFEHemNtHtKFOACaA6pbF+J3d33xUC76ymAgJpC2BPs9BTqpT+m/fIDcI9t4mrwXMv6oTYEHsoKLWTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805023; c=relaxed/simple;
	bh=Y3MT3oWHibBcKRhB/N+6RZY3S66hj1wDO7MapAJKhd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J7vgStfkH96Zr6eNBsw/BotLQYK1ZcvgM8hkjW3MhAxNNHNpMWCFC0wkI019/jfponka5xugXQtvWelzadPP5iy/OsCOjEC39KPot7EBPjsDaNGAreRyRgm/Fc7bEq/GZAN+uylHT07bHuqGmTHD1tfFH0Lsvs5CDyGBuQYdz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByptkZyh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7426c44e014so1686826b3a.3
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 19:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752805021; x=1753409821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i518bbzfZO/aJkAgPJDTpr5hRhX5KSVRvbb0iT/IJ8Q=;
        b=ByptkZyh0vtMgUB9BWpsHbfzkMQPaVbUbo4QzHmH8hSW7GKc4JWahS5AMhsKGrdUq0
         p6DOBFmAXs/7q7cOsthYEnqXarFahgoMATFPL6Hvu0WIKEI7O6O3UplFsHOupdTNU8ub
         K590r7LEODU9hxap/kD7ivjN5ySvDBCb5Lf6NZ6PmGhLUqRa3FZsIl6Rkk36QRZrKb2l
         9o9MQ/eKaDiikkYqSwDbOYwSYtMHnPsDfXunJX39a8QX8W0AG+R2dxNc8A2UQ5Ompg2C
         2yh0SnE9TZpzAiqCi6T6v1OJ1p/KBJ3RvsBZnNW8w8lGLYYi87cXbLUyCMRi1S6EM7GV
         rdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752805021; x=1753409821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i518bbzfZO/aJkAgPJDTpr5hRhX5KSVRvbb0iT/IJ8Q=;
        b=Q5v0ylbdO3Nv5oXu5duhs00AEqWt/lAtu6AfjFjHkA8comTAmwkfjc3OYwtfQ6HwdS
         hs2g6LwyMW/GVUVVjm/ljVl11tL6fBh1TvzsMaCly4WeV1gkDizj/OR8SkGrXdT5Bt4U
         3gnOXGQ51LLqJqWJmBiya9uK5NYvJKRIhf2h+WLWafT05mQBP8FBlgFoYIIjlF8HMamo
         n3YCHXYDQ9y/x5iZafkKxSMG2aecewb182rom4uz+mhjlc9K4QfyjAZ5zIyvhTE7WVCF
         6K0WdpNPWCv/IpE0CkpUqDhxOqZgqyuL8GS4cZ+WXByeIc0D0wQ8ZL5mwMxrbAZ+SuNg
         Q2YQ==
X-Gm-Message-State: AOJu0YycVKyhGLjW/M0c882QGF8VmxoXRkYKRmwdsxG3Of+rPxjrGFHk
	JlpTQWewwRWCSkS4a6FEsGgnUEqghe7PwrC8tfeA3r2WJROTW7wwbzjKiMYqEw==
X-Gm-Gg: ASbGncsxtgQ0+/fKHXaiSfh23oq/+Xg7UXI6Df1KUQoLvwRK0UBabPIeHXOy74pTv2o
	1CTZztmTCQlvH9P2OWX7Ot49S7GifY4rVUd+TI/qFT6XODJNh3J8NGMI1Z0d6CWxlyPNyUvk+2D
	OcwO456sTGCTYhvs/I46KFnWOfsEuvluIFtcTYmeNZ2GRMwwCoTYmggrJ2zkjJkJZDo1y1QaIJQ
	7ySB4jS+WAVnJJIB8/9ldSEHqnQT48vVCKcjCpUL3u31EwZTDAT0mgjrDPi2El3wMI2o98C3U1Q
	aGdFyE2xIi8MVbd9xT5tOCJGnjinsE8MAa5O5TnF+3y/V/MWiAdiOmZaXjV4+uTaYldhTosMuQU
	us6V6hO66+FP5jwxN1SGRK6rSPIc65kDpWoLKZ55X44tmbSnyTv1+ZSuzi/FDVEz2rOfrXX3kZw
	==
X-Google-Smtp-Source: AGHT+IFcY2VsA7LkPF499uUm0R86UTS1mtNIOHPycskWH/JF5YYqWIqSstbyRkbU87Fg4yiMkJvBRQ==
X-Received: by 2002:a05:6a20:7290:b0:235:b6de:4470 with SMTP id adf61e73a8af0-237d5a04312mr16499209637.13.1752805020753;
        Thu, 17 Jul 2025 19:17:00 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ffb69b8sm300281a12.71.2025.07.17.19.16.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Jul 2025 19:17:00 -0700 (PDT)
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
Subject: [PATCH v4 4/6] mm: Introduce alloc_frozen_pages_nolock()
Date: Thu, 17 Jul 2025 19:16:44 -0700
Message-Id: <20250718021646.73353-5-alexei.starovoitov@gmail.com>
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


