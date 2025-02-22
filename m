Return-Path: <bpf+bounces-52238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3506A40522
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 03:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E809E19E0DC1
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 02:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF531FECC0;
	Sat, 22 Feb 2025 02:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HriQzGux"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E82C1FC0FD
	for <bpf@vger.kernel.org>; Sat, 22 Feb 2025 02:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740192297; cv=none; b=Rf/RFccgbEmPhagIjyBBZPOXzFYAvTUSkQJpQhTdTfWvcQXGi1a9076R8l0mge7BPebCtJMfhoiH3/XT//ezXdG/1J+D9eCK3zeKgYijwvfd01b4/Saib1Kh0LDi//4tQ+VEEVIHEINn8dfYeWRSngA39aucEdQLvlhRqyefOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740192297; c=relaxed/simple;
	bh=FOGcEJwCLduPJ0BPyEAlIHEeGXOsaEMppo5JwHbgSgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nvaTXFHhuDnj3CF8GMhZouqvaBjYlwXk0amKz3B0qFQ5wR8wpSJqRNmCKWJpNpnLffiZhSXoGUwBx3jdBhK5nRCa7aJq9Vzx1Gid+nBeuIe0BhbG0O9h3ufRefe6kL75g9XJpBEpX4lA5Ii+lz03NvC6iS43bIK/G+WqpZ29kCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HriQzGux; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220c4159f87so39129335ad.0
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 18:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740192295; x=1740797095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bolBZqmxiF6GETckqAk9OFKRadV+pg4VUXhxs/9P6QM=;
        b=HriQzGuxZTxD0B2xpG9x0a6Ce1gMvWf7dxPPEtL9s+283CD2uvXTimNsQSUVGjeBt1
         sMkh4wUG4s/Z38zgcWShJehz9C9dvNZLJP78Krp6Y9qQ0bf77ndbWZBhERNyMaP8R0WO
         2imP90L2FHvTKY80F24OrGB2ORAj+ZTOOa8UHOf+66E6grup8db9npvywJ8+2p716LFc
         ZnxIcKZk0VDdw6szVF8YHrC5lPizV7q625mD5U2f1mj+S0EIfgu9nMtr4IXAHVoVNjIw
         CCRVCl3tjmjGcb57dRfaNuywEtNvsHK9iwkuHyJwKrXGDzgBv0yMfbGt5Uory/ahAA1f
         zn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740192295; x=1740797095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bolBZqmxiF6GETckqAk9OFKRadV+pg4VUXhxs/9P6QM=;
        b=BMHJ6cSJaLMpeRf0PlJPJATAB1njJHnQCz0DYE8A8eUkuXb6zDaZF7kfe6SaiUWDwF
         EriYc40Z4QExEqxSecp9q7z/g554rdRD0MZztab/oFpOwiCqrJ8glLeW5yFJy1nKa60O
         0JamUPJ8FRnreyl1Wv/Ya5oXXm0tRcfWNR1DxzC0zMxdmh2W1LHK9jWlud4+boM5AOYg
         sab2aBwI2uWE4WEi6pKTUlvJwiDDZ6X2zex+NKlDNtMbpeMRsv+d5ehCsy2dxEUCmJKM
         FxefmCrB6YUk7x85PLvqrNP4BH8YgpzjVl9X+yDx48FEkQFRcTteHE9qF7WXpK2oYMnh
         yUAw==
X-Gm-Message-State: AOJu0YyJZngbHZiR7deFWNt+Ahn9e9zx58iCvMYBj4dpb9ghkl3XfrT6
	KkDesjUKlXaP7tu9dnZdswfDFQLszguSeO08REEBOMufj7MXnj1JL+UA4A==
X-Gm-Gg: ASbGncuheGROQtMIFaW8AQpcyWSuJ8df/sjr3yWADfbD8r+FL/mxBr7oPk+e4a+RCfN
	GXdbC1x4AIxeL9/pZqoe/zMb+ZdLbp92R4JmBYroqmzFpfsM0ovwYuliUo63vOspSRn/bMuQ7dU
	KCWVUq1ojWiDhnNcd5isFTbxTy/yz302dyauQrPstQwGBq8VjPs/gsSl1Ovt/da7VAPy6IgN4tS
	d4mTQQ99oNciJZjVoMAlGao2lcEpXAKJKQKT6unVBGTSYCHHaZJxuNk3/EAxbIOkaI5X0yNKr5X
	boMS3q6Vma8Xc54utl6tTBJa5EpGbmpL/g3ITOF2jpDFV7bLmHU8cA==
X-Google-Smtp-Source: AGHT+IFK4i6e5Q6HRwwkypHWm+mgn/XZd3aa3wu+p1h8KExIL05px6pJ1dJj76k5LTDiVqFHNgy7uw==
X-Received: by 2002:a05:6a20:7f81:b0:1ee:c6bf:7c68 with SMTP id adf61e73a8af0-1eef3c8a93emr10233940637.17.1740192294949;
        Fri, 21 Feb 2025 18:44:54 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:fd1b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae0950ecb95sm7549891a12.41.2025.02.21.18.44.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 18:44:54 -0800 (PST)
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
Subject: [PATCH bpf-next v9 5/6] mm, bpf: Use memcg in try_alloc_pages().
Date: Fri, 21 Feb 2025 18:44:26 -0800
Message-Id: <20250222024427.30294-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
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

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/page_alloc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 79b39ad4bb1b..4ad0ba7801a8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7189,7 +7189,8 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 	 * specify it here to highlight that try_alloc_pages()
 	 * doesn't want to deplete reserves.
 	 */
-	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC;
+	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC
+			| __GFP_ACCOUNT;
 	unsigned int alloc_flags = ALLOC_TRYLOCK;
 	struct alloc_context ac = { };
 	struct page *page;
@@ -7233,6 +7234,11 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 
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


