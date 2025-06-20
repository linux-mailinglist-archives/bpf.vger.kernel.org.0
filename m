Return-Path: <bpf+bounces-61140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF0AE1195
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 05:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EC73B8CD1
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 03:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919D51D5CDD;
	Fri, 20 Jun 2025 03:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Ts1yuVv4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136601BEF77
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750389102; cv=none; b=OWQVFKvux5zQMAxPvpaZceMteviLD5zYuEJXrafhxoFL4O8Pp0eg4NEX00Sk/4EKiZeYfKSrE1t6kLtqS00x65Dkjq2ZrKjnhFfkWfkD3zy7L3A/4jY5JzvE01MK3eUqQyU1rweIERTaKxGvtiT+CQCBXWKy6z6OB6XUpWZSXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750389102; c=relaxed/simple;
	bh=uiJNe8EGt4qyJNqE7qSsMOHTTR1w+p7DUhFW11QFtQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkpZkWVX7cVFQRPU4UEUb1u62j7IO6CMbLtIamkgAbKsj877zNZMloEfGwc8ilp2a2m71+8UJifdKmZDvA38QtmI4UxDpkkNf8LmCFTqScO/wrJQdRcj8AoBJtyKPCNKW4AFRfzBmfAqb0CISjH2epm8ZKtndJuiZZkimet+uR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Ts1yuVv4; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d3da67de87so163894585a.3
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 20:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1750389099; x=1750993899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oo9SkDG7E5ZB7X/mvcMzdeeOs9uOdAX+sV8s1qxmbA4=;
        b=Ts1yuVv4O8CWULjMUb6CNL9v1d71IS4v10ludABKgIqtJZu67Gro7+8wwoPt5ItWbk
         BfffWmlTq5b++s4vYExyX4vR87Q/9ArWIpK3hqxyPAKxBmLzmFt86DBlrE87kSACXnsX
         9/mlB2Jvv5amMbwS9jzyKxEgJ5ejEiCuaF3z2x46jQbCGPcUQivWt3XXfYaWaydcyM53
         xYdTBBAFQSZ3UXS55qEM9PTEyixiTgj3mQsQxcNyoZddGqiPSRch3BKyj9fTBq7ElCRw
         Z21zXkVc28O9DBX+GTu77I2336kbJENP26ZG1rrGTMc2t4BhMiMBKUuquzgbpYXiKfMg
         YpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750389099; x=1750993899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oo9SkDG7E5ZB7X/mvcMzdeeOs9uOdAX+sV8s1qxmbA4=;
        b=MYj+AnAVb6daZnggNW6eyzotdNm4j8ACHdlWGdEDk1jYiBioin0H0hV19eOXvJWI28
         MMZeHVJCIrH5JLdRrT5AUB17GY1MeDoNlciKoOA97LSOUgE8qLlPa/Ss4FW/B3kwjiSX
         btnpPt4obNQht+80e0QV4toEnCgFGOg0ZvWCKgvLZoEI4rfXN1aE1cFnxjL9FB9VQXTS
         Ol5fc9Ug2zG4XxepL523mgE+nP1LVDsLuiFscT1urRmhyl+1eNctaBioFnij4PbXZple
         RI2u7P0U3wNe/XCaTXh+kKWTfCF3ApmIlxEKMMWQqpLFu7GmRiimuNtek2lnaBIMqUBD
         mXGg==
X-Gm-Message-State: AOJu0YyiKWsIKfVRj8yBzPIddt7SHXGfiF2G+xiQWtrt3QLsvaxXkavY
	82GprQmlvEkalDrlu5Vt2jz6r5CrhgGA9QRHgFP4vPjSV3sQhHZjfsOBO6gjLtnCwun9IB1ufng
	g/4q/9lyIQw==
X-Gm-Gg: ASbGncukIOjQwBgB2nevhCVKvovncn65qkTDxStfMUUdPHjmvbb3AQSqBG9WrwNs35k
	hbIeO4c+GCsuRPrW5YU+7KCrgmc/sjNIT4MTy8XIJCfuXMvKhXB/ZwwmQYO0fOisI6nnYM1jjrh
	THNVeMndu4cu/ioZWlYytCsOpWuJPsUeomJkkmx0aTQTNb/SsOXQC1PHSA5QR6Lv90SxXA2ejUM
	qdjwYg0wg8p6skgdidGizDp3BQJ24MyVn347SMitGQs3g2XisG6JS/MsOtv6S33XrG2bNyUDF5v
	NnrPYBh7ZsIAGHrFwHtFvnptJ8L2yM3aa+pbUFsic1ZEoZ+HFAI8I2KIDgBN
X-Google-Smtp-Source: AGHT+IGI3Q5lVQyxDu3iV77xa2ZWMiB4lkuQ/DvJXC4x1hLFVQgdfXSXccDRz51LUx9esFhGw0Ej7w==
X-Received: by 2002:a05:620a:3191:b0:7d3:8a1a:9a03 with SMTP id af79cd13be357-7d3f98c9769mr202034485a.14.1750389098859;
        Thu, 19 Jun 2025 20:11:38 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e90ffasm4502441cf.70.2025.06.19.20.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 20:11:38 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	sched-ext@meta.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 1/2] bpf/arena: add bpf_arena_guard_pages kfunc
Date: Thu, 19 Jun 2025 23:11:17 -0400
Message-ID: <20250620031118.245601-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620031118.245601-1-emil@etsalapatis.com>
References: <20250620031118.245601-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new BPF arena kfunc from protecting a range of pages. These pages
cannot be allocated, either explicitly through bpf_arena_alloc_pages()
or implicitly through userspace page faults.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 95 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 0d56cea71602..2f9293eb7151 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -48,6 +48,7 @@ struct bpf_arena {
 	u64 user_vm_end;
 	struct vm_struct *kern_vm;
 	struct range_tree rt;
+	struct range_tree rt_guard;
 	struct list_head vma_list;
 	struct mutex lock;
 };
@@ -143,6 +144,20 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		bpf_map_area_free(arena);
 		goto err;
 	}
+
+	/*
+	 * Use the same semantics as the main range tree to reuse
+	 * its methods: Present ranges are all unguarded, while
+	 * absent ones are guarded.
+	 */
+	range_tree_init(&arena->rt_guard);
+	err = range_tree_set(&arena->rt_guard, 0, attr->max_entries);
+	if (err) {
+		range_tree_destroy(&arena->rt);
+		bpf_map_area_free(arena);
+		goto err;
+	}
+
 	mutex_init(&arena->lock);
 
 	return &arena->map;
@@ -193,6 +208,7 @@ static void arena_map_free(struct bpf_map *map)
 	apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
 				     KERN_VM_SZ - GUARD_SZ, existing_page_cb, NULL);
 	free_vm_area(arena->kern_vm);
+	range_tree_destroy(&arena->rt_guard);
 	range_tree_destroy(&arena->rt);
 	bpf_map_area_free(arena);
 }
@@ -282,6 +298,11 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		/* User space requested to segfault when page is not allocated by bpf prog */
 		return VM_FAULT_SIGSEGV;
 
+	/* Make sure the page is not guarded. */
+	ret = is_range_tree_set(&arena->rt_guard, vmf->pgoff, 1);
+	if (ret)
+		return VM_FAULT_SIGSEGV;
+
 	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
 	if (ret)
 		return VM_FAULT_SIGSEGV;
@@ -456,12 +477,17 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 		ret = is_range_tree_set(&arena->rt, pgoff, page_cnt);
 		if (ret)
 			goto out_free_pages;
-		ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
 	} else {
 		ret = pgoff = range_tree_find(&arena->rt, page_cnt);
-		if (pgoff >= 0)
-			ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
+		if (pgoff < 0)
+			goto out_free_pages;
 	}
+
+	ret = is_range_tree_set(&arena->rt_guard, pgoff, page_cnt);
+	if (ret)
+		goto out_free_pages;
+
+	ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
 	if (ret)
 		goto out_free_pages;
 
@@ -512,6 +538,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 	u64 full_uaddr, uaddr_end;
 	long kaddr, pgoff, i;
 	struct page *page;
+	int ret;
 
 	/* only aligned lower 32-bit are relevant */
 	uaddr = (u32)uaddr;
@@ -525,7 +552,14 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 
 	guard(mutex)(&arena->lock);
 
+
 	pgoff = compute_pgoff(arena, uaddr);
+
+	/* Do not free regions that include guarded pages. */
+	ret = is_range_tree_set(&arena->rt_guard, pgoff, page_cnt);
+	if (ret)
+		return;
+
 	/* clear range */
 	range_tree_set(&arena->rt, pgoff, page_cnt);
 
@@ -550,6 +584,46 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 	}
 }
 
+static int arena_guard_pages(struct bpf_arena *arena, long uaddr, u32 page_cnt)
+{
+	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
+	long pgoff;
+	int ret;
+
+	if (uaddr & ~PAGE_MASK)
+		return 0;
+
+	pgoff = compute_pgoff(arena, uaddr);
+	if (pgoff + page_cnt > page_cnt_max)
+		return -EINVAL;
+
+	guard(mutex)(&arena->lock);
+
+	/* Make sure we have not already guarded the pages. */
+	ret = is_range_tree_set(&arena->rt_guard, pgoff, page_cnt);
+	if (ret)
+		return -EALREADY;
+
+	/* Cannot guard already allocated pages. */
+	ret = is_range_tree_set(&arena->rt, pgoff, page_cnt);
+	if (ret)
+		return -EINVAL;
+
+	/* Reserve the region. */
+	ret = range_tree_clear(&arena->rt_guard, pgoff, page_cnt);
+	if (ret)
+		return ret;
+
+	/* Also "allocate" the region to prevent it from being allocated. */
+	ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
+	if (ret) {
+		range_tree_set(&arena->rt_guard, pgoff, page_cnt);
+		return ret;
+	}
+
+	return 0;
+}
+
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
@@ -573,11 +647,26 @@ __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt
 		return;
 	arena_free_pages(arena, (long)ptr__ign, page_cnt);
 }
+
+__bpf_kfunc int bpf_arena_guard_pages(void *p__map, void *ptr__ign, u32 page_cnt)
+{
+	struct bpf_map *map = p__map;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	if (map->map_type != BPF_MAP_TYPE_ARENA)
+		return -EINVAL;
+
+	if (!page_cnt)
+		return 0;
+
+	return arena_guard_pages(arena, (long)ptr__ign, page_cnt);
+}
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
 BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_ARENA_RET | KF_ARENA_ARG2)
 BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, bpf_arena_guard_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_ARENA_ARG2)
 BTF_KFUNCS_END(arena_kfuncs)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.49.0


