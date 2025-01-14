Return-Path: <bpf+bounces-48732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11779A0FEA2
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 03:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE7A1882FC9
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 02:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30747230268;
	Tue, 14 Jan 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0LkqiBM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A22B22FE1D
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821197; cv=none; b=CjwFc/VFylV4voXKePV/svx7xVjUPy1hxjMb53+D/TFlA8gXW8k6pTofXomIZXm+FLDuIuDyoBpJcPhx7E8gIaCe/Z4HIoTggSn/+9cQKZ8btVk8EVML5bn55+NJTg3yiBTAeuQKekRwr4gpqnNpUumk9enXhdxa2cPEOTUPJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821197; c=relaxed/simple;
	bh=tzwHjbGjp68P11OdjhC/2hNyfpMrd/9w03aGeFbz4qE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/2uiOUYnhpF9qfhP0Lpk5wwg1DTuySHn9cGB3/XapxW7eSkePs+UNhOUR4dRtYc7HxQg1QPNGa3RHsj4B/7jdLy1cI2gt2plgAjdH7hon2mKSFrKGddusyFRXD3dT00iaUs9e4FZdwZl8r6qotqMJfnkVyE21JwTKVNr8Fz6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0LkqiBM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166360285dso86649955ad.1
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 18:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736821195; x=1737425995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygT/gYIDC88MbRDeBH2BI6HaB56L95edS8LxJJawsPI=;
        b=e0LkqiBM4O63+CQeHTOYQClhzNGemxbcxgRy4hBeblwhBPIf5n83Eg1BIcxH4Z+x+T
         zql1mxqXzOTaXdIiYVjsjfSCsk54q7ZDxgZmHQQEO1diHFJ7fNuxGkkAY3MZmK8nk6qF
         eG8osE9suQTBwpG+Tbs329Wp9WEDXpzI+w0yQXwep0bjgvYADwWFAz9qLK/foeofiC3L
         dkdqIpk6tZ6oByCXF4Xe/AYzCL1HhAOzdiaeLqjibDD88fZhq8YrDrs6roueIkLKuf1/
         x3SiReMCbJZc8vE6YTSzPSXfeuremspvqTIib0h3OFHCI26zCiVkohOkCK9pmCfAd7hw
         CTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821195; x=1737425995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygT/gYIDC88MbRDeBH2BI6HaB56L95edS8LxJJawsPI=;
        b=MRefN8Ok/xtV6iAO+JcO9hq6eMDPBrrTeNnOazJsOA/L0FQZaaQgNr/TNwgYmDnb1A
         XDF+M3OAMk9FTs1kt+KK8PXw1Dh5E2SAgO1ya0x0a5a7DoVyQU56IoDfkezcXhiHN8XA
         Yn0O40j5ctxhNvYSmIBl0VoVGLRN1DTlQtjbYjlSHscw1Xxvsiosz6i1cGMm8y5TyCwr
         bVOvz5sszQvus08GQ34lLqk5UicAQ3Q4pEQYlYbGluisobW5fpn27r3gxix61iXeSv/Y
         S+1GSjbzYN6ninEtkCCf2J153TKwUr1MyfescgzdWQL5L3qDym5yJGTUj8g0Bngmj6CC
         27Ew==
X-Gm-Message-State: AOJu0YxLjU90keOh/uT1A+udDra3ImeMyHvyfEX9LDDlbaIcNcR99zgg
	YpiDBQB/eV+d8xMfkNjPdft8NTxnsCcv+4b7MDizPuPynEyw/8bj+Ef0/g==
X-Gm-Gg: ASbGncu0Vxl+tnJtbIUFrWNZuILxm4+8RRxiEMgTO2/yWNtMmerUYDO8C7xGNcihD3G
	m56CXoksieV7v9agv4qPfLqiriQ6+hvfsYybFf2g7++Xbu8If/iGlTLeyrqBh8iE58B47lR6Ucc
	F3bNp65d9a0rp7YqGT4ruR81aG4OTr5V9w32K30pEmLMBHeV3Zutcyl2BTAve676we1VOFFksbw
	z/gblAAm1smS2xkInzmo7z4uP5T+WAbpIrHvdi2aeMdLEpdtfW3VdyaFkGDg0PFBtmX6xxnrkoG
	zukY/K6k
X-Google-Smtp-Source: AGHT+IFgYqVYLd3bJ1uye+mrUb8xwZqUFfTGtcoiwxRHlc9JoDBAT6ZJfA68H0it17/fmR3KmGQU5g==
X-Received: by 2002:a17:902:f54a:b0:216:2426:7668 with SMTP id d9443c01a7336-21a83f4bce1mr257464125ad.13.1736821195029;
        Mon, 13 Jan 2025 18:19:55 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22eb8esm59444185ad.166.2025.01.13.18.19.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:19:54 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	houtao1@huawei.com,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	willy@infradead.org,
	tglx@linutronix.de,
	jannh@google.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 5/6] mm, bpf: Use memcg in try_alloc_pages().
Date: Mon, 13 Jan 2025 18:19:21 -0800
Message-Id: <20250114021922.92609-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Unconditionally use __GFP_ACCOUNT in try_alloc_pages().
The caller is responsible to setup memcg correctly.
All BPF memory accounting is memcg based.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/page_alloc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f967725898be..d80d4212c7c6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7118,7 +7118,8 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 	 * specify it here to highlight that try_alloc_pages()
 	 * doesn't want to deplete reserves.
 	 */
-	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC;
+	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC
+			| __GFP_ACCOUNT;
 	unsigned int alloc_flags = ALLOC_TRYLOCK;
 	struct alloc_context ac = { };
 	struct page *page;
@@ -7161,6 +7162,11 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 
 	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
 
+	if (memcg_kmem_online() && page &&
+	    unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) != 0)) {
+		free_pages_nolock(page, order);
+		page = NULL;
+	}
 	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
 	kmsan_alloc_page(page, order, alloc_gfp);
 	return page;
-- 
2.43.5


