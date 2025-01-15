Return-Path: <bpf+bounces-48899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C7DA1172B
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 03:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB5F167DBD
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EB6229B21;
	Wed, 15 Jan 2025 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHz1pro4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9C63594F
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907501; cv=none; b=aTVxkJw/gAFqYWuMG74362PgXSU5StOBsut2oBgptw6+OaTQrxULxDq30RrJlaPHmUXx5nB49ZY7zxZlfq32dqW/x8DZsuNBqv2taaxDRoFT4daFf6HdNOEcfNQC94hflRi35rOLgrfVaR1ea23zJcPVkHh+j/eYnWgK4z+VYVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907501; c=relaxed/simple;
	bh=GoND/gqV9lHkmshdkED2zIzF0DqyThdxlWZmtV52wlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNKoEZDq/DT7wT1mvwGy2X8VWyhuHIqeRmTToMa1fNpR5EzcViIDRdK4/3HFqoAM8bRn3UxVP3mEQwyVx7NQxfZkltWi2fm/GiaRFiHUeAncWgaJjmlPtdQakiI/7fekV0V/vxIQz3RRLcgthBySpCROP7BswFdLUyJsX2iNuio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHz1pro4; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so10241023a91.2
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 18:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736907496; x=1737512296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FG/FEC6x+yVU1JM4G4OAfpXBrpZC0py7nMQcVE3sTc=;
        b=jHz1pro4CIUloux6pJPLC4y4LXYpADyXlMGfUTeOfLO7jqEUILY0JGMFsWN6MwbRXj
         ssMB7SGuhp++EXsNTM1YU7KeHkIRfV7Tx5L9zJthSOGZqCM3SmOMieHxOhNomYVTlJq0
         XbKReSSY04BF3EjWWcAF/iP50OOI8snVMClsdkmInjG6uEZRFJleijE6dbOzoPy4oz7+
         4/JvPguI16iyi2g/38SYcf6oSZlLZ5dY/oa5xssLiYeeOOSNlanO3YIiggvQsy2yY5TX
         6Y4YX/9im1fb/jjk9sOKbUmXYs5BP6E9drmHlBFLDehXdarCQmhP+ClYdF/b0WkRyt7g
         VApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736907496; x=1737512296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FG/FEC6x+yVU1JM4G4OAfpXBrpZC0py7nMQcVE3sTc=;
        b=rtFHODkHBYCCTiLf4i+hZbNl5WJdMTnvWiEmAH0eoA/dgFb9ANjPixKs8K1xn9BooQ
         YCQIHVjbgfjHn3xDryNkcHpEHiH/05bKeQwso4K5orAwzxvjqeG+u7BJZQwWr2m6ZdL6
         YLyn2ooVzqDcGbBHWvs+DkNBmNC3B1asRiP6vYjyt0xkSFuyyGzoIhWt9qC8YszRYstb
         el41uaArsJvIpip99xbXv8YvPw2sh3feLZEyRpL8i9hyjmNdSCObKs93lcZgN/sz9abx
         6NN61wfQjGsWGoYahdw0cR1Kv9QOQuWE3yChZf+eGfJa+/SfMQsJJ4HQcFWjMGgn7hOk
         TeIg==
X-Gm-Message-State: AOJu0Yw0AFc86DBJVQmVFgTnjr8mqHYytx2OoRcKcpY+X0rLZ6IbDpZk
	DhvmJz1aDZx7fXzVkDocyHLQsYgsNzq1QOCy6yJSyV4IZdOyognQYzAPBw==
X-Gm-Gg: ASbGncvZuyE7WNn5x9XAmWFq+eT3Im59DjVZoi5bPGuDkP2lXd4vdNx8djIKc7ZFvli
	vbFKeGRrixVGLSB8D8GTnY/r/TaG+ep//Xc6MqckmDCPYgEoOaRIup11kICXzcSzT8RreJbO6Rs
	GB33rgqx/YnXKMoPu1iIzCKfb7bE/Qz/G8/Cbc4GO5gwh5pJx3KVKxmdN+tJTixCWqU2MUgtyQ7
	MW+j5j2zPROBbpqrEN3AXVTh2dplE3myyDa820RYFDN4WfUqk8O7u8SVQMb5a91CtE/uxrU18pP
	c23zlgmJ
X-Google-Smtp-Source: AGHT+IHNs63EfYlrVfU/fJaiMNGL7uVjWhVVtEL4nC7WmO69hxtGaNlrKdUTNVZudJVLwEfNIUiYFQ==
X-Received: by 2002:a17:90b:2f45:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2f548ece7afmr43528398a91.18.1736907496611;
        Tue, 14 Jan 2025 18:18:16 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c157a09sm231999a91.8.2025.01.14.18.18.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jan 2025 18:18:16 -0800 (PST)
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
Subject: [PATCH bpf-next v5 5/7] mm, bpf: Use memcg in try_alloc_pages().
Date: Tue, 14 Jan 2025 18:17:44 -0800
Message-Id: <20250115021746.34691-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
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
index a9c639e3db91..c87fd6cc3909 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7131,7 +7131,8 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 	 * specify it here to highlight that try_alloc_pages()
 	 * doesn't want to deplete reserves.
 	 */
-	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC;
+	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC
+			| __GFP_ACCOUNT;
 	unsigned int alloc_flags = ALLOC_TRYLOCK;
 	struct alloc_context ac = { };
 	struct page *page;
@@ -7174,6 +7175,11 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
 
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


