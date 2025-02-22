Return-Path: <bpf+bounces-52239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375D0A40523
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 03:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5CC70362C
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 02:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC131FF615;
	Sat, 22 Feb 2025 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRST24dw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD91FBEB3
	for <bpf@vger.kernel.org>; Sat, 22 Feb 2025 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740192302; cv=none; b=OT0EMbzNOuHRf0cisU+AWb4ucDGWrnqLs8+7CQq8te/zCQNsw1yFxjThbUzyj/GspGzrrWjrPXmDuE3vNM02iiZEEDq0LQFra0/+4WMk9y+GTiypnnuQ30Qvnp/4fzJkMAzfDageHVMf46tHhAMImJehJGSU56ENoIVTb0mCMRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740192302; c=relaxed/simple;
	bh=C+J4n7BDOuX93zcgob79HbEJgPw+TUEypNT+5BPLQu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mc8XlW8J3q+1CxkiE/xZBkzK4ukIrSoM+o9kCXZMmnSzZVpxETPX4o8zUyKzW6+eHwH7STGoVYuSZqpQZ/NMjD05sW57Y+aHIsXRqFnOf2/GuMo9BZq+6yCWCi96usUM9RPnjfvUi3LTgiBnKxUiEKW/1Y0c1R2y31ZDIN7EO4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRST24dw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2211cd4463cso55988115ad.2
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 18:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740192300; x=1740797100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPs3yc+PiAaWT0mDird4KgOQtxAcHODpsiThplYmhyc=;
        b=MRST24dw7q5Jt5dt77oH3rchiBGGqMjkGoCzC3DoZTGH8m1PMawUJ8c1fVLj8WCxV/
         1drPn44FUIrEO+V8kz1dA09pk9lzt2bWcTUUM4inOjqscw/aE4FBPmdTrBObCKaTjKmE
         p9gjM+kC6invMgCeeMyXFh91KeEEDHxzO6SY9hLzMkaZj0Y2p/LqZfj2+lzRcm0VAbpG
         D1nhA751BQjsKkWKl471q6RcrRQ8FVlOeuQfIzoEDFFn7ppQhLCR0zj2t9TYRRHy4kaY
         Ehb6QPw4uMlh5W8012+kO/N524MshLJ7OrfreiCgQFldpw0apOx/8b3blaPi8iZko0BD
         Emqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740192300; x=1740797100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPs3yc+PiAaWT0mDird4KgOQtxAcHODpsiThplYmhyc=;
        b=W3n526cpzQC3wzsGF5QGxcIsX/10gEnVQlL+tV1yQDwHTCGQJrEw9tEGWPWtRU8/Mk
         eBAXF4rTmVQTjGy7m7i5pZUOW/qBvK/1pC3Zl9TfZDw18fHmR2ik1nkVgBbIb6rY0jZ2
         Deh4yaFxMQI5b7NYBm3WPL87G8pXyU2RVGDohTTESMaJXNyF+3gDuefAosbXyTvmqQSw
         6+kC9C4yrMG15CWHqeW7K62RpIAfMAt8KkfLRZSNJuXNekI4ZO++to9gHzmDSSSOfvTp
         Rf7OSSvHhgr4yA3SjYHUkgvz1U+ZBGguVhT8PHWvSORbXT9qNu660J2ZsKh41XW0xnMP
         tUnw==
X-Gm-Message-State: AOJu0Ywc71/eoG0iuCFYnZWWU1ZyZ1G/dfyR2e4dK1qnDOu29iUKcR0f
	P1LH2g/TBKjBlG1YRIRn+XC/Ogf/G9C98DOnvmNr+2SnH3hH9uJdDwICYg==
X-Gm-Gg: ASbGncsqpjv2MJBnKSgG+HEuG3DLLwZFlZjMssknKlLUqCnmlOyL+IumNE27e1ys7/i
	7eIhJ5gwyESwNTpyOa6gS6xwpdZwEUZM4A+ms+yHwHeKkfBBpwZWo+Z2ATwC5b+PIBxs/DUkNDZ
	X1fXdpCWf2K6Hrye0lVEraFUw0hCeQeUAJ2YqDm2Js3xQcdLa3aeGDcJXw1wXSOiCK8TdhlmX9l
	vovPv7tR7QgVEys7ZqaU9QusxL+F8WIYmfmVkVtxmCsM9GavzGuyMO3L5atd21cmBwcbcPKNLyI
	JICLVaOPMmEvH4FBlc+5XL4Z4VagNh3YUE4tWG/HCvsNtzruiM3tUQ==
X-Google-Smtp-Source: AGHT+IGe5ruubfI6Kv2JX5V72ftGr8+QNktHSqGRav+UGawI2sLc8KeipECS2WW3ixuo2162gZmKxQ==
X-Received: by 2002:a17:903:8c5:b0:21f:4c8b:c514 with SMTP id d9443c01a7336-2219fffa9f3mr82089215ad.45.1740192299832;
        Fri, 21 Feb 2025 18:44:59 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:fd1b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d43dsm144772515ad.158.2025.02.21.18.44.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 18:44:59 -0800 (PST)
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
Subject: [PATCH bpf-next v9 6/6] bpf: Use try_alloc_pages() to allocate pages for bpf needs.
Date: Fri, 21 Feb 2025 18:44:27 -0800
Message-Id: <20250222024427.30294-7-alexei.starovoitov@gmail.com>
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
index 15164787ce7f..aec102868b93 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2354,7 +2354,7 @@ int  generic_map_delete_batch(struct bpf_map *map,
 struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
 struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
-int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
+int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 			unsigned long nr_pages, struct page **page_array);
 #ifdef CONFIG_MEMCG
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 647b709d7d77..0d56cea71602 100644
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
index dbd89c13dd32..28680896c6a4 100644
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


