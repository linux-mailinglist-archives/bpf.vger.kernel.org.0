Return-Path: <bpf+bounces-61141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164BCAE1196
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 05:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2A71BC2E83
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 03:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361311DB375;
	Fri, 20 Jun 2025 03:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="jpA2Nscf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A1C1D618A
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 03:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750389104; cv=none; b=HL68jC3m9FR+pujO4q4IscnUnQQjvrhtLiXOu2QHOnoGD32vcbz8lxuoF6MYuPXbAi9O9pCQoa9CNzgcpdQVFhV2kL/dxfIijw0v9ORUsj9AhVhwg38piGLOzuUsNJiU7FnVBUv5lyNdQnJLG0vI25ZlMuJuEaZV36H8CedUtvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750389104; c=relaxed/simple;
	bh=CsH5vX18nwg9v+NAyZXViFVnEMNbFuYeIn5DLpjYCvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHoJ2XXfzdUdUiUj93rfQHsI70wUsUbAKgOWfTDAVXycET+bnsrn5iz5d9v6IdR5DydJ9V1bGQ3VVcrpNgtDesdBPCoBZYBFRr/UE1luZsqk+lHZr/svBIuPM5zXKJgGHC7/ZiBzGiZuyryBROjQoftvE86GNe3DpEYfOZfeST0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=jpA2Nscf; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a4312b4849so14656401cf.1
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 20:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1750389101; x=1750993901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8wQA4DSL5XWvf0QBO0pa8E//areszTV+4hTG0I/jAw=;
        b=jpA2Nscf1woewdcFTzuoPf1QH/wU83Qx9dtsPWxoA1PbUl/sHRc4BvHHbe9LQ9P9kY
         8qON2ID+f2MD7WQle21N3nmvYN8jYmxblXy42QkouXwhfrXflahktrZseOdyD3CvFrRx
         OHQIPxlzCxuFgx/5D8fFJu+JDMxIvblQGB5vT8e+BWmZO7rPhRnL+rtnZUx4+ERL63n6
         OjwoiQ2r0yfs9IVaLYS6fCUePI0mPEyqPSHYE2QhcUvJHPZ2OYJfSGG+9RxZVEsdii3Q
         /NqfzFVzXogdxNl9Hg42cpY7f6YVnQ0s0y+nOAmhSWUMlYmCCKvEv+9FlrLYa+vQ/mq2
         u9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750389101; x=1750993901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8wQA4DSL5XWvf0QBO0pa8E//areszTV+4hTG0I/jAw=;
        b=VUiFnvZ1FtL5tsJb7+GpRK8iAzS302eskNS2ZMVdIJmznAX+vsZZEx80XGVj1VMDkF
         mJfkJT7AsE29WXhGEfRVqzxt90QlP7b54HoXvslx/F1KPaCbQXgrr7yk9ER6KiDZme96
         2E6NoCE++AaXsk+QjznT8BBSpimoNKIlQJuGKxMOI36pE+lP9LBU5veDnEV1Irf5g7Pe
         RGz+MbrBe0lt48Mf7Yrk5au7wPe8n96XBFmcNmPeWergXuERTE6MOVnHpOjX2vNP2b7O
         2FAgaMkWWPZgz1+JgynZji0yh6O6zlHRZpU6mzb1Js0kp/1WspQ2ytybjKhWf8AEyUh+
         AyMg==
X-Gm-Message-State: AOJu0Yx5OKi1+bBNPD5YYNKtX91n7pdXpFt4NIOHjExQ/88jn1baZO4l
	l4JXchDNICdOQ6i8Z5fT+escx1k6cUIdIRdKYCJcOszzdULUONFbY1q4AORabm1J/VOuBYn1DvY
	6872u3tkMFA==
X-Gm-Gg: ASbGncuoHfxpzk9y1AhOYNIiylyhjzdQG56r+dvJTSHbA/JxclzGb7h26F6rgAFcvfu
	sFu2T/RNVdIjne8rM+/dTbqdMzim8OfTaFTDlNI8794PzyaxXD01Ek3vc34odU19BtntXvF9UiM
	5LR6BFl8FUTH7Ldm0deAM7ldG75j2t7/+gFZ96MA48ePNVr+blxUdyowGaa0jgP864odOrSYSpD
	ifMpWMjFFw8Ki+sYqcJqclIABFXSCOw/PguN6pwv2OQ8RCJyPV/3yFQ8qLosFiAKUwMF50cUenA
	xrWwnaBop/jHZGfSfhuxvnGZV95dNjiViI0TMXwzd3qo4NS3wptjqTHySSLZ
X-Google-Smtp-Source: AGHT+IEEZB6VvPF1mGwpNYO80lFZqAdkS80+CQtmC/CGbcBEcx2I+IQZaiC1AhSUya3ro7m0qINbeQ==
X-Received: by 2002:a05:622a:1b90:b0:4a6:f99d:9633 with SMTP id d75a77b69052e-4a77a269e25mr23327281cf.31.1750389101514;
        Thu, 19 Jun 2025 20:11:41 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e90ffasm4502441cf.70.2025.06.19.20.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 20:11:41 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: add selftests for bpf_arena_guard_pages
Date: Thu, 19 Jun 2025 23:11:18 -0400
Message-ID: <20250620031118.245601-3-emil@etsalapatis.com>
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

Add selftests for the new bpf_arena_guard_pages kfunc.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../testing/selftests/bpf/bpf_arena_common.h  |   3 +
 .../selftests/bpf/progs/verifier_arena.c      | 106 ++++++++++++++++++
 .../bpf/progs/verifier_arena_large.c          |  93 +++++++++++++++
 3 files changed, 202 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_arena_common.h b/tools/testing/selftests/bpf/bpf_arena_common.h
index 68a51dcc0669..339de1719bc7 100644
--- a/tools/testing/selftests/bpf/bpf_arena_common.h
+++ b/tools/testing/selftests/bpf/bpf_arena_common.h
@@ -46,8 +46,11 @@
 
 void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cnt,
 				    int node_id, __u64 flags) __ksym __weak;
+int bpf_arena_guard_pages(void *map, void __arena *addr, __u32 page_cnt) __ksym __weak;
 void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym __weak;
 
+#define arena_base(map) ((void __arena *)((struct bpf_arena *)(map))->user_vm_start)
+
 #else /* when compiled as user space code */
 
 #define __arena
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 67509c5d3982..af175dc89a8c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -114,6 +114,112 @@ int basic_alloc3(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__success __retval(0)
+int basic_guard1(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *page;
+	int ret;
+
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page)
+		return 1;
+
+	page += __PAGE_SIZE;
+
+	/* Guard the second page */
+	ret = bpf_arena_guard_pages(&arena, page, 1);
+	if (ret)
+		return 2;
+
+	/* Try to explicitly allocate the guarded page. */
+	page = bpf_arena_alloc_pages(&arena, page, 1, NUMA_NO_NODE, 0);
+	if (page)
+		return 3;
+
+	/* Try to implicitly allocate the page (since there's only 2 of them). */
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (page)
+		return 4;
+#endif
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int basic_guard2(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *page;
+	int ret;
+
+	page = arena_base(&arena);
+	ret = bpf_arena_guard_pages(&arena, page, 1);
+	if (ret)
+		return 1;
+
+	page = bpf_arena_alloc_pages(&arena, page, 1, NUMA_NO_NODE, 0);
+	if ((u64)page)
+		return 2;
+#endif
+	return 0;
+}
+
+/* Guard the same page twice, should return -EALREADY. */
+SEC("syscall")
+__success __retval(0)
+int guard_twice(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *page;
+	int ret;
+
+	page = arena_base(&arena);
+
+	ret = bpf_arena_guard_pages(&arena, page, 1);
+	if (ret)
+		return 1;
+
+	/* Should be -EALREADY. */
+	ret = bpf_arena_guard_pages(&arena, page, 1);
+	if (ret != -114)
+		return 2;
+#endif
+	return 0;
+}
+
+/* Try to add a guard past the end of the arena. */
+SEC("syscall")
+__success __retval(0)
+int guard_invalid_region(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *page;
+	int ret;
+
+	/* Try a NULL pointer. */
+	ret = bpf_arena_guard_pages(&arena, NULL, 3);
+	if (ret != -22)
+		return 1;
+
+	page = arena_base(&arena);
+
+	ret = bpf_arena_guard_pages(&arena, page, 3);
+	if (ret != -22)
+		return 2;
+
+	ret = bpf_arena_guard_pages(&arena, page, 4096);
+	if (ret != -22)
+		return 3;
+
+	ret = bpf_arena_guard_pages(&arena, page, (1ULL << 32) - 1);
+	if (ret != -22)
+		return 4;
+#endif
+	return 0;
+}
+
 SEC("iter.s/bpf_map")
 __success __log_level(2)
 int iter_maps1(struct bpf_iter__bpf_map *ctx)
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index f94f30cf1bb8..cf76acd72ed1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -67,6 +67,99 @@ int big_alloc1(void *ctx)
 	return 0;
 }
 
+/* Try to access a guarded page. Behavior should be identical with accessing unallocated pages. */
+SEC("syscall")
+__success __retval(0)
+int access_guarded(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	volatile char __arena *page;
+	char __arena *base;
+	const size_t len = 4;
+	int ret, i;
+
+	/* Get a separate region of the arena. */
+	page = base = arena_base(&arena) + 16384 * PAGE_SIZE;
+
+	ret = bpf_arena_guard_pages(&arena, base, len);
+	if (ret)
+		return 1;
+
+	/* Try to dirty guarded memory. */
+	for (i = 0; i < len && can_loop; i++)
+		*page = 0x5a;
+
+	for (i = 0; i < len && can_loop; i++) {
+		page = (volatile char __arena *)(base + i * PAGE_SIZE);
+
+		/*
+		 * Error out in case either the write went through,
+		 * or the address has random garbage.
+		 */
+		if (*page == 0x5a)
+			return 2 + 2 * i;
+
+		if (*page)
+			return 2 + 2 * i + 1;
+	}
+#endif
+	return 0;
+}
+
+/* Try to allocate a region overlapping with a guard. */
+SEC("syscall")
+__success __retval(0)
+int request_partially_guarded(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	volatile char __arena *page;
+	char __arena *base;
+	int ret;
+
+	/* Add an arbitrary page offset. */
+	page = base = arena_base(&arena) + 4096 * __PAGE_SIZE;
+
+	ret = bpf_arena_guard_pages(&arena, base + 3 * __PAGE_SIZE, 4);
+	if (ret)
+		return 1;
+
+	page = bpf_arena_alloc_pages(&arena, base, 5, NUMA_NO_NODE, 0);
+	if ((u64)page != 0ULL)
+		return 2;
+#endif
+	return 0;
+}
+
+SEC("syscall")
+__success __retval(0)
+int free_guarded(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *addr;
+	char __arena *page;
+	int ret;
+
+	/* Add an arbitrary page offset. */
+	addr = arena_base(&arena) + 32768 * __PAGE_SIZE;
+
+	page = bpf_arena_alloc_pages(&arena, addr, 4, NUMA_NO_NODE, 0);
+	if (!page)
+		return 1;
+
+	ret = bpf_arena_guard_pages(&arena, addr + 4 * __PAGE_SIZE, 4);
+	if (ret)
+		return 2;
+
+	bpf_arena_free_pages(&arena, addr + 3 * __PAGE_SIZE, 2);
+
+	/* The free pages call above should have failed, so this allocation should fail too. */
+	page = bpf_arena_alloc_pages(&arena, addr + 3 * __PAGE_SIZE, 1, NUMA_NO_NODE, 0);
+	if (page)
+		return 3;
+#endif
+	return 0;
+}
+
 #if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 #define PAGE_CNT 100
 __u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */
-- 
2.49.0


