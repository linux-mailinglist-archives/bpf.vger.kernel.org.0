Return-Path: <bpf+bounces-49647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD875A1AF38
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 04:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F371680C8
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 03:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942121D79B1;
	Fri, 24 Jan 2025 03:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktn0zRGd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E1E1D6DC8
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 03:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737691040; cv=none; b=hvY3rq4NdlrZN7rX40j2nUY9IKdY0XuJ/XjyZ/AHO5oTBphcOjTpJwSMNwENWcMVN10QO3GjX3CQLOGk77km+yI8nD7IZ5VN/Vd8Q28Tx1UwywkOVupj0fePtbHlwZMsCHQs4lFChNVUSLHhT7dpnTjsYF2mGFSEkdRY1BRQ7kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737691040; c=relaxed/simple;
	bh=vfzkPtuMn7THzMDejWzHSa5NwJvatkmrRDhM3Ln6UxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uKZEl9/A1KGenw+n7+xVxEjMJ99OCz5e5OBRX614649WmFlskidy/88DRVCtOHKJ036BwcePs+NfvzVXmLeSsICMNg2XpWl5isdE1M6zN0COyyPNjBEsaiX6WX5S/62LHvncG5AtWMkW1+xm0MblieGcayWBmJB1ONyWBg9zU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktn0zRGd; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso2498765a91.2
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 19:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737691037; x=1738295837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDuPZRtqsVh7bFH3yxNIFanE739bKkzWZ/UfDyq/wdw=;
        b=ktn0zRGdtASZN6mTP1vyErFidX5N867PWQOBxH78BelUihvPU4W1xWThYpXjhZSJ7s
         2CQETjU0X+KXOclyim2zkJGADrUfiG9Q+9MmzjooAEZHHk12knlCZFoDrXDxrFP3LnLw
         uwnpgmBkJA/sqA5SzbNuE25q3v093S1yTzTxUQRBcnXO+6+RlH3EjHg2HyIRcDLhgJ8w
         TqSBKx7FljL9Ko9mYF3gyGyoFNSRb3ASdDEGe+YCHXXqFJy2v44pqV4CfjxHqHXxDJZx
         cff5iMlIvY8mKp3XJ/MaBVoSD9w3VGiYL8NpKgtL+YCreyWmVJkrjoHBCkswr/tVfLe+
         c85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737691037; x=1738295837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDuPZRtqsVh7bFH3yxNIFanE739bKkzWZ/UfDyq/wdw=;
        b=Wn3qjdNerb6kKZeDikgE84w3uE9LoIftncvqAD+y1tOJvrzO38lGRTCTxr2N7mm7l+
         zDJmpSP0vwiZKoTddWIQXIrXkE3TzFtE42NzaMuvlBHv0d91B9DVsEjvfx0pt8UC22MQ
         xxO5SQgdeXB4Xshvic/cXcUCYNdmAtAbzzYJcbZQj2fn8IS/V+fQ1aY7sz75s21AIxli
         SQr0wwBshtsA/n6Z03F73xJpMkRipHEde27s1nOSosfGcAz+vqpe6RMTxTsLMXDHTG42
         hCeZQjO7RScM2eg42znjhWWznSXM3L3fVnMjIBJTNYGouk/wn0N6ea1QdzmGWpqMdLdh
         39HA==
X-Gm-Message-State: AOJu0YzLCkIvJyD8o91loGEFRAU3iizB677SAyBjlYdChdxNF0Rylj6Q
	rwcXMwJ+Rz6HEDfFrBFa8bxphSfdF5TcSxGim5Da3plSVW+8MrQWvEyJCQ==
X-Gm-Gg: ASbGncvXrcifPcKcmEmGG78L36IGNj7gGsT0JPrGSTQasi0DhOyNTu/gbrtwDuUMaI9
	GeB6UOCsn6Zw7+DfeBqI9wvY89Cm4c1Wv2dpazRjlyf1Tm5ZuTEIhldajtN1QW/9uoWx9O1ocdg
	Bzd50nijt5sPdK+/RUONLcR+3Fsl0c96L0XjEMM0pGiGorgQ7MdADV9a7xmUwheGgYjS1KvjtH5
	45F2pNbq6EJj0K/blxpOI2WQYG2INQSucJmImwH4qWe0D2y9LbodiG0sOkVquyMR6cXXYpnKJRO
	QW9cX/ZsikVYYXM4CH8R6mlCkoVFpnBJIKf0GvI=
X-Google-Smtp-Source: AGHT+IE+LCbRskWbsR6jz9xA0dh2MfdRvUJzJjh376jPaUjhK25k9uihZ7etnl2RsWLAETsaV50r6A==
X-Received: by 2002:a17:90b:3547:b0:2f7:ef57:c7df with SMTP id 98e67ed59e1d1-2f7ef57c8fbmr11319328a91.7.1737691037538;
        Thu, 23 Jan 2025 19:57:17 -0800 (PST)
Received: from macbookpro.lan ([2603:3023:16e:5000:8af:ecd2:44cd:8027])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffaf896csm542025a91.34.2025.01.23.19.57.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jan 2025 19:57:17 -0800 (PST)
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
Subject: [PATCH bpf-next v6 6/6] bpf: Use try_alloc_pages() to allocate pages for bpf needs.
Date: Thu, 23 Jan 2025 19:56:55 -0800
Message-Id: <20250124035655.78899-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Use try_alloc_pages() and free_pages_nolock() for BPF needs
when context doesn't allow using normal alloc_pages.
This is a prerequisite for further work.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h  |  2 +-
 kernel/bpf/arena.c   |  5 ++---
 kernel/bpf/syscall.c | 23 ++++++++++++++++++++---
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f3f50e29d639..e1838a341817 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2348,7 +2348,7 @@ int  generic_map_delete_batch(struct bpf_map *map,
 struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
 struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
-int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
+int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 			unsigned long nr_pages, struct page **page_array);
 #ifdef CONFIG_MEMCG
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 4b22a651b5d5..642399a5fd9f 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -287,7 +287,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGSEGV;
 
 	/* Account into memcg of the process that created bpf_arena */
-	ret = bpf_map_alloc_pages(map, GFP_KERNEL | __GFP_ZERO, NUMA_NO_NODE, 1, &page);
+	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
 	if (ret) {
 		range_tree_set(&arena->rt, vmf->pgoff, 1);
 		return VM_FAULT_SIGSEGV;
@@ -465,8 +465,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	if (ret)
 		goto out_free_pages;
 
-	ret = bpf_map_alloc_pages(&arena->map, GFP_KERNEL | __GFP_ZERO,
-				  node_id, page_cnt, pages);
+	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
 	if (ret)
 		goto out;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0daf098e3207..55588dbd2fce 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -569,7 +569,24 @@ static void bpf_map_release_memcg(struct bpf_map *map)
 }
 #endif
 
-int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
+static bool can_alloc_pages(void)
+{
+	return preempt_count() == 0 && !irqs_disabled() &&
+		!IS_ENABLED(CONFIG_PREEMPT_RT);
+}
+
+static struct page *__bpf_alloc_page(int nid)
+{
+	if (!can_alloc_pages())
+		return try_alloc_pages(nid, 0);
+
+	return alloc_pages_node(nid,
+				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
+				| __GFP_NOWARN,
+				0);
+}
+
+int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 			unsigned long nr_pages, struct page **pages)
 {
 	unsigned long i, j;
@@ -582,14 +599,14 @@ int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
 	old_memcg = set_active_memcg(memcg);
 #endif
 	for (i = 0; i < nr_pages; i++) {
-		pg = alloc_pages_node(nid, gfp | __GFP_ACCOUNT, 0);
+		pg = __bpf_alloc_page(nid);
 
 		if (pg) {
 			pages[i] = pg;
 			continue;
 		}
 		for (j = 0; j < i; j++)
-			__free_page(pages[j]);
+			free_pages_nolock(pages[j], 0);
 		ret = -ENOMEM;
 		break;
 	}
-- 
2.43.5


