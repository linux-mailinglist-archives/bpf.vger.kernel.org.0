Return-Path: <bpf+bounces-51351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163E9A33622
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 04:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BF5167CBA
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 03:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BF1204F72;
	Thu, 13 Feb 2025 03:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVZ/4SOR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A6204C15
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739417782; cv=none; b=qaLnlBSoweKwaSGenJzaGKBL1t+xigql5uP+LqUX+TnRFXLj1Ew1V5TxytXev4EfEo+G2pQkHzBWllY4Raqjpo6Zzy6Tyr0TMzc3pdtBrDscUqKGrpvZvzfgXuP8vHbx3dizoRwJ3NiIl/UkS1jjHG2s8iBL2XpN80YncgC9w8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739417782; c=relaxed/simple;
	bh=TSxROkvhAG5IYqi3Cx7cKZkWqXvbU4Yr4NE0XE2gaU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBjdri0oQ1pLMv+F6NKcVYHf4LkL6hkFsB2mWIriXwxMkKj7lzXDI9VEzkMtjt04SD9KU7bOdjpSz73+ubOcaTdFnS74Uu0xClcm2gQgvbfXO8aRB3N3g4KXBoefMB6bPs4ZM8Aj8Cz5mOlfdexcVELuRtFfonC/hvZBAvT4KvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVZ/4SOR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso668583a91.1
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 19:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739417779; x=1740022579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bG2TcWcZQz5k+Gqwwy79wI8/0pax/QFELT9STfGtKY=;
        b=jVZ/4SORs2iLH7NdWYnMFktweVrtl55YrSTaC8oyxCznNY+1CJ9qQVlXmGR7czbROs
         iBQz/k6/bwI+Sa7zudzuzUf/D01K3/MF7ZkppC6ZMYYBedlmz91YwEoiY0QNl9j3PIEY
         S/fDwVzRj48MUbxgDysSc2ffd6VC4aNirSG6Pj2/jiAnLj0gm/oQyz+8UfDRHVdkyQkG
         E+8rS0ffQCFYG5sf/jYgiMzHv74iv6mAmFvSzB3tvFjhBdhOGG2xzyGPX6INXWXtZRGa
         dfjX+0psjF6L0Lh+yDX6NUv3Jy0e36m3NxFRHcKE+e6Gz/mt5LZkN4tDgQJMZym6nMSg
         qiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739417779; x=1740022579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bG2TcWcZQz5k+Gqwwy79wI8/0pax/QFELT9STfGtKY=;
        b=EUS90k1FpeKYHeOnkwsQvwPXL07gC+Mmaz4guXIFs7eb5he8/D5asnneoWOqfiuEIi
         V04cnMcWBsLXEOTEiAnyYOMaly3SybTJoq6AqO05tZrQtNL27D8AuPwVQxc6rX8rtfZg
         EM7Bg/snhUcJfhjnK5JRh11dopVxBGI5lI4MQ085cWgJjzN01Z6o55Xd0NMVtiK89r7g
         fSLnZZrY9OmeNCaSIe49sQM9KnehLZRUl1jrL67cHKKuB1OBS25WeKl3atwBhDV0AEpf
         rU686G3tDepq3+p2Gm1K2hRj0clFr69IED+1rZRnEjR5fumqdCltTsX1QVXXPBbEBX2I
         GOZg==
X-Gm-Message-State: AOJu0YzOB9dFy/C410Cs/qsv+A4ThAp9IwsTyVKI3SFbkxpdMi3Srfda
	QCGd6dcB4utjGBbNaP4jQLhhEpTt4iP7HqCHkBK8wAAnMC743D8Y1yv9KQ==
X-Gm-Gg: ASbGncte41jgKMDRwVx7JlKxkQz9bIxrfmhzzZtXTDkkkJrFZeHTjNARmj8oi+NfMI8
	+A253krnE/1es6bCuRvz8iF6jln3nQB/lBs6uURtamla79S3U3SWkEXVtvydozcmmNCEcF3ImCG
	7XDfikPJM8X0EHR6aIvkxQibRDNUNSrNuwRUukYPYgQIQMJfVn9zxbtMSVq2jad8v+vxugtExav
	l3pHvvnJIEkXQRa80VYxzdFA9mk9hQpE6OLwJPq2VLA0hIlARaJ7zgyBYU9WictWnMo02P6ynJT
	xdBuHxr6IfctGW7GA58pvZ4oiNYZU1DAK39Jfvjta0bzxeXAMQ==
X-Google-Smtp-Source: AGHT+IFXy/P5J+sCx9sY/U/MAEMVw0FrBRnsYEuISK2pqOweK9ST2IkQe2QsXaxkx9P9LFDey130mw==
X-Received: by 2002:a05:6a00:2294:b0:730:9768:ccdf with SMTP id d2e1a72fcca58-7322c3a5ef2mr7987610b3a.14.1739417779128;
        Wed, 12 Feb 2025 19:36:19 -0800 (PST)
Received: from macbookpro.lan ([2603:3023:16e:5000:8af:ecd2:44cd:8027])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425468bdsm222056b3a.31.2025.02.12.19.36.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Feb 2025 19:36:18 -0800 (PST)
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
Subject: [PATCH bpf-next v8 6/6] bpf: Use try_alloc_pages() to allocate pages for bpf needs.
Date: Wed, 12 Feb 2025 19:35:56 -0800
Message-Id: <20250213033556.9534-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
References: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
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
index 0975d7f22544..8ecc62e6b1a2 100644
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
index c420edbfb7c8..a7af8d0185d0 100644
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


