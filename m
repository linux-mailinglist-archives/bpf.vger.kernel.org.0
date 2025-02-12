Return-Path: <bpf+bounces-51290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFA0A32DD3
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 18:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAD41648DA
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E6C25C714;
	Wed, 12 Feb 2025 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahLzWmb4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46012586E6
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382457; cv=none; b=UtP0c+PqDSive73ta4dZTAJDx7lOv7qAu1QLlNdf3HOZd69RXsYtVSZ1T7Ljf3evkJ5fpfGeOKOYlZrIJUgHYMy17CPowOxcqRnx0ok6XFhM99ser9DvLWiZi3HhadGunrURN7QPsS9HcHid5w+pApm8Y+5PCJYyCZr/vsyt6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382457; c=relaxed/simple;
	bh=vfzkPtuMn7THzMDejWzHSa5NwJvatkmrRDhM3Ln6UxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZG78ZxOpEZyqdgt3bFExuqrQ1Mc4NlugYYoIlBsNCVaIFPtX1NFHE2daCs2lDydJdm3htQFkkMYNx3D8M3lFkVtUNEQIIdEsKP6b2SRuMawDWLTa8UapFAXlY3eqSn9ZbGNThjIVj7hnUeaBfX1B+xul5Fs2Rsn0ivvg8kohOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahLzWmb4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa3fe04dd2so79055a91.0
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 09:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739382455; x=1739987255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDuPZRtqsVh7bFH3yxNIFanE739bKkzWZ/UfDyq/wdw=;
        b=ahLzWmb4SjK/vznhv2SZA0rnH3N94FRz2G+jo6geuWVQrm3sSsboy8WLH2IkoMs5XL
         +Wtk8iVIPdq1ZUwKvrK3ycqo2ELh/xngtN6J/ogYKv5Ma2t5JGAlCcg/TKpTg2/2Vl5g
         5ZlQQJJdRJiz3AcXDLSq5uzx1+bamY5qCaOieKRyeAzpv5VKwyv2exoxNy1CtQK5LIuq
         JYQHsZXMoP+pFBg+7ipkajRMbRozYSQZh8RaW7iIP/NCj6ag2+gD8zg6Ex0UZYsG5cd7
         5RoYI2/qMwmfMdad4sRt4YyX3ncS9WPuBz3KoOlhQOtC+g1TzlCk2rEf0NwlYpRndXfD
         e9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382455; x=1739987255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDuPZRtqsVh7bFH3yxNIFanE739bKkzWZ/UfDyq/wdw=;
        b=bcMgGjf+rzMMhvsYVErthRJstZldOBJCt9XLuRZ5ka1GxjVNeGFzFjkMxmdwvAOrYq
         KPb4U0DXpZS7ShyryL3IVmsO4rz/2P1gxhuID2OMDLwMGV6j+CiDsdZ+R8uPBAcX/sjI
         KDhQgSfDUfm6K9kF4HNbL/VzIyO+JT/ZXM8U4JeoOB2kkyh2k3NCngcUcqQZ3XWhktzY
         3nLUqZuU8mw2QrwK0PQapfhwBAs66ef/PK4/2/XKvUyXPf5FHakXCOz+OY3aRxW8PXBM
         JGPyzhrEor9QyPvbnhv2SRvWESREq20iqZ011JeGw/pY5/7jGXyqG9ZMNfvSNNHu5W1S
         IFqw==
X-Gm-Message-State: AOJu0Yxw8dM53D+XMKvlrcB+UJYDoZ/qRr1GUy1jqdSAfZqmfx2xlvN1
	i6Ppg45ydtSTnvZlWGWHx4YtMdK9rcdkOJyfphGmqoSMMZ8IrPZnphuGqA==
X-Gm-Gg: ASbGncvKSIjzxgEREgU7iPEBCKtq76dAwBka41OhoC8eb3Mdz/kdFuw2tO1cFx8rU5h
	fk1XD+US3mWuUiSDd6qx6glA/h95s6VA6WGrImQ5KK1zlScVyswvhk8pcFkalZq2bee+2VO3wy1
	Zt1ifQ7NbvX+tZHqg+lAut+uwPBpA9MZXdwEiHmdFMXX+vT/7bQfF18MIIZFaT4ZmOhwB2oq+fu
	m9l+5mVxPX8bfOr7Mp0n4xgKgEYWc2Q/32F7nm0lPLJQp/tZxhKi1TdI6t1qyQoEuj68Ccf6y/C
	r3n/xv9zu6Tk3LPf+djqCshlGX2d4zeljU3krnpksZ1RcA==
X-Google-Smtp-Source: AGHT+IE9puw91tznIalD6EtLkH8J2zj9zmB6kCfaMb8CIT8gL4HusyDm8J9VmRaGQdeer0qVub9Dvw==
X-Received: by 2002:a17:90b:280b:b0:2f8:2c47:fb36 with SMTP id 98e67ed59e1d1-2fbf5c6ea65mr7171319a91.33.1739382454794;
        Wed, 12 Feb 2025 09:47:34 -0800 (PST)
Received: from ast-mac.thefacebook.com ([2620:10d:c090:500::4:c330])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36882dd7sm115611505ad.199.2025.02.12.09.47.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Feb 2025 09:47:34 -0800 (PST)
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
	mhocko@suse.com,
	willy@infradead.org,
	tglx@linutronix.de,
	jannh@google.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 6/6] bpf: Use try_alloc_pages() to allocate pages for bpf needs.
Date: Wed, 12 Feb 2025 09:47:05 -0800
Message-Id: <20250212174705.44492-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212174705.44492-1-alexei.starovoitov@gmail.com>
References: <20250212174705.44492-1-alexei.starovoitov@gmail.com>
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


