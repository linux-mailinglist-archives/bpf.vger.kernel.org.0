Return-Path: <bpf+bounces-62736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEDAAFDD21
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A3954135C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397DF19924D;
	Wed,  9 Jul 2025 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="2pHSdbpU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6E16DEB3
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026006; cv=none; b=f23an5k6kJd1KcoG2xKP49FUish5+wtomNlSH0k8bzpk77SXMWZ9KuSvvYpP0t0pSZD1nQxPeW13Utkj1ta87ZPoGRJNvbRRHOf8XHPv9bNTX+LYP0QY5fTCJIKyvb3YIaT+pzCgwYK4cxwPfdu2ZEHnPTeagpQXbYZUt5XvcQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026006; c=relaxed/simple;
	bh=AwfP0uqgz+uuSBk3O8NUy5bkuPQKAyG37pk8Qtxkzmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDRz8lBJJFll1EuI1MZURhGVdYNq96ITdfTLSIclkbXfhzYT77Ueb+WUNl+nDJL4vGmMrqjM7scFLeeqmpjqG0FFNMb0ESKV0T/nk1fp+ymeJ37KSFnAz3mC328CGO5lHt4vVvAu7SmSAuC0oBL22teRjeXJpyRSn0hM92MJww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=2pHSdbpU; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d7cf6efc2fso306513885a.3
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 18:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1752026003; x=1752630803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ksu8nqKnroXcHaUiosqlWb0w7zGyAK3qP74Gg9s7Pes=;
        b=2pHSdbpUuYw5GrlDbHScuHKPetD3qxaILJi79c7Kl2IgZJxx6gi+FTdTtt3MLpTyeA
         iduN7vef62xRPvpHSnQ6KagF6506u8QCxaG1wJZQRzJjkeDh+EePWPjwFqq7lh9QOsaM
         wGrkzl0j4OsOZjcaCtuBL3Vf6B0gN6Ttv1mbxy0IdsG/zD6sW+Rous2bPHHqMPw0ekDR
         xcB9MIGJNU93lv1YWyujlUpfVJcN5Do2rH1kUBBlZOdel66WUqn+SfhxdKFeYu2rVI+Y
         OoIWp5oVKIOhCUQ+TsW2vkESmiRFj0dgGoKMJQEMqB8J/+IFMxsXCUFoHoymcxsPURM9
         Rc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752026003; x=1752630803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ksu8nqKnroXcHaUiosqlWb0w7zGyAK3qP74Gg9s7Pes=;
        b=G/wS8pSpb97ytxF60J3Bptw4DHNQhERQwogggljWBsHr9i9QQn9Dp4cnHr7m2HeeTA
         SucvgjWIvwH4X1mSO05TjE18eZ8PYDJf8BUmqGIiq+i8od7t0Lr/mB/qvgEfatpPWY6M
         3NKIxMtTeVwRxec/+zJpDW6rMnhp+1Hjx4QcmWVSQ1yd1NM/zmp1hRPNaQmK9sw90d28
         vair+yvhSMSmvkclk3/+2K/aBxyOr9O8d9ylVtD5QcvCWNQDKYA5N35wMOtnQY/VrNL+
         NpPyiX9nEioM2bLurVsHcU7DULzItX3pqpo8/CyfL99qo7hcI4whQouq7pVp/wWN9eZw
         b6Ew==
X-Gm-Message-State: AOJu0YwiulUCpKpyzHs2PHOrvqhKt/qhdBNI4jkLol9DZLvcB7DLKyaf
	mqCWdMvR/ij+kMsu+iGUteXFYG95QnvjtXG6fMsaXXrOuErhpkQIs4QZm7fjIPOeDXQwo46Tj20
	nnnh6gtI=
X-Gm-Gg: ASbGncsQmmIRFDl14WOXhh7MbQ8BZc9xhgVkFhbHThLqV3LcI4WCLSUuZGh7xzNWEJc
	jylkjRTyql9wkE2evlJl1Faw4ho1WFSP2+gFlnEOYk4L4RDBMnTazEelQyNpiCS1fXAs57JRw92
	hcRkcmXFz2YfcCC7PGR7znpaXG+pyhUinkgJWvmFUzCkUidpOdb1EmBunnH9Aya4bS4Uqkob5Yx
	yxH67k2c8kL1mJDpDA7eY3BG32uiaWXEOkRa8hj9opmGpDz39UO/Mz8BoMlJBKpGWlnTgNjle4M
	TJEaABcu5B7V1MkgcAS2KoZ+W2fD0BFu5DQwp4MQ05k8NI0U1YFiDK25cAA=
X-Google-Smtp-Source: AGHT+IEAyGmLAXbvXk+nW0w/d+PExQOr9tKZB61T3Oy9xnNfK66OGzxf6+C+/CjohOlNGqPugkiGew==
X-Received: by 2002:ad4:5766:0:b0:6fd:5dc9:6029 with SMTP id 6a1803df08f44-7048ba8bf4amr12416276d6.43.1752026003455;
        Tue, 08 Jul 2025 18:53:23 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702d5e53246sm59807986d6.1.2025.07.08.18.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:53:23 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	sched-ext@meta.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v3 2/2] selftests/bpf: add selftests for bpf_arena_reserve_pages
Date: Tue,  8 Jul 2025 21:53:09 -0400
Message-ID: <20250709015309.96742-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250709015309.96742-1-emil@etsalapatis.com>
References: <20250709014751.96274-1-emil@etsalapatis.com>
 <20250709015309.96742-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for the new bpf_arena_reserve_pages kfunc.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../testing/selftests/bpf/bpf_arena_common.h  |   3 +
 .../selftests/bpf/progs/verifier_arena.c      | 106 ++++++++++++++++++
 .../bpf/progs/verifier_arena_large.c          |  95 ++++++++++++++++
 3 files changed, 204 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_arena_common.h b/tools/testing/selftests/bpf/bpf_arena_common.h
index 68a51dcc0669..16f8ce832004 100644
--- a/tools/testing/selftests/bpf/bpf_arena_common.h
+++ b/tools/testing/selftests/bpf/bpf_arena_common.h
@@ -46,8 +46,11 @@
 
 void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cnt,
 				    int node_id, __u64 flags) __ksym __weak;
+int bpf_arena_reserve_pages(void *map, void __arena *addr, __u32 page_cnt) __ksym __weak;
 void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym __weak;
 
+#define arena_base(map) ((void __arena *)((struct bpf_arena *)(map))->user_vm_start)
+
 #else /* when compiled as user space code */
 
 #define __arena
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 67509c5d3982..35248b3327aa 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -114,6 +114,112 @@ int basic_alloc3(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__success __retval(0)
+int basic_reserve1(void *ctx)
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
+	/* Reserve the second page */
+	ret = bpf_arena_reserve_pages(&arena, page, 1);
+	if (ret)
+		return 2;
+
+	/* Try to explicitly allocate the reserved page. */
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
+int basic_reserve2(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *page;
+	int ret;
+
+	page = arena_base(&arena);
+	ret = bpf_arena_reserve_pages(&arena, page, 1);
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
+/* Reserve the same page twice, should return -EBUSY. */
+SEC("syscall")
+__success __retval(0)
+int reserve_twice(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *page;
+	int ret;
+
+	page = arena_base(&arena);
+
+	ret = bpf_arena_reserve_pages(&arena, page, 1);
+	if (ret)
+		return 1;
+
+	/* Should be -EBUSY. */
+	ret = bpf_arena_reserve_pages(&arena, page, 1);
+	if (ret != -16)
+		return 2;
+#endif
+	return 0;
+}
+
+/* Try to reserve past the end of the arena. */
+SEC("syscall")
+__success __retval(0)
+int reserve_invalid_region(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *page;
+	int ret;
+
+	/* Try a NULL pointer. */
+	ret = bpf_arena_reserve_pages(&arena, NULL, 3);
+	if (ret != -22)
+		return 1;
+
+	page = arena_base(&arena);
+
+	ret = bpf_arena_reserve_pages(&arena, page, 3);
+	if (ret != -22)
+		return 2;
+
+	ret = bpf_arena_reserve_pages(&arena, page, 4096);
+	if (ret != -22)
+		return 3;
+
+	ret = bpf_arena_reserve_pages(&arena, page, (1ULL << 32) - 1);
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
index f94f30cf1bb8..9eee51912280 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -67,6 +67,101 @@ int big_alloc1(void *ctx)
 	return 0;
 }
 
+/* Try to access a reserved page. Behavior should be identical with accessing unallocated pages. */
+SEC("syscall")
+__success __retval(0)
+int access_reserved(void *ctx)
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
+	ret = bpf_arena_reserve_pages(&arena, base, len);
+	if (ret)
+		return 1;
+
+	/* Try to dirty reserved memory. */
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
+/* Try to allocate a region overlapping with a reservation. */
+SEC("syscall")
+__success __retval(0)
+int request_partially_reserved(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	volatile char __arena *page;
+	char __arena *base;
+	int ret;
+
+	/* Add an arbitrary page offset. */
+	page = base = arena_base(&arena) + 4096 * __PAGE_SIZE;
+
+	ret = bpf_arena_reserve_pages(&arena, base + 3 * __PAGE_SIZE, 4);
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
+int free_reserved(void *ctx)
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
+	ret = bpf_arena_reserve_pages(&arena, addr + 4 * __PAGE_SIZE, 4);
+	if (ret)
+		return 2;
+
+	/* Freeing a reserved area, fully or partially, should succeed. */
+	bpf_arena_free_pages(&arena, addr, 2);
+	bpf_arena_free_pages(&arena, addr + 2 * __PAGE_SIZE, 2);
+
+	/* The free pages call above should have succeeded, so this allocation should too. */
+	page = bpf_arena_alloc_pages(&arena, addr + 3 * __PAGE_SIZE, 1, NUMA_NO_NODE, 0);
+	if (!page)
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


