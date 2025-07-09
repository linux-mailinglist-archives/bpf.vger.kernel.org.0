Return-Path: <bpf+bounces-62739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6C5AFDD2C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192173BE78C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553A619E7F7;
	Wed,  9 Jul 2025 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="CZwqMQus"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F3191F92
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026241; cv=none; b=aJQBjO5ustiACO8EYRyPHfhCpJMvlQTx/igZNTL6B/8miJis8ZXxQUWndlwu2hAQArBfWUyTI42AW16/IN9ru7cyZGwk5/C94udsOfPqp9V09JPJAQJVeaHt363G+WygzG1rTZeSJua+8i8nOsjUZd0/n6esVC5NLuWzHswNmW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026241; c=relaxed/simple;
	bh=AwfP0uqgz+uuSBk3O8NUy5bkuPQKAyG37pk8Qtxkzmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrOhqayT3pon0vVLEnj9LnkXD0/+4T5jewNSYs9aZJPahus2D2DwAYsWC4Jf1JhQHEnZWZIJYUqPTcnM0UVjQLT74OV3PXBqLGDVreKm5yBxi/o/NsasLh3z3bWbtTonA/UZt8XlwEDbtj0VPghfpOOUquB86eKCzPZzkVSS1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=CZwqMQus; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a9b08740e3so35755231cf.3
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 18:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1752026239; x=1752631039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ksu8nqKnroXcHaUiosqlWb0w7zGyAK3qP74Gg9s7Pes=;
        b=CZwqMQus5Yyk81xSPV1n3nc/h3NoyzbjxGVxe3/xdSVxfX6dA+JD9M3nfC7L/xP6gS
         s6yczLvdEM8a+noJnSRGJqAxdP8K9OoE+H5uDy6ei9dThh/kqDzGCmmNg6Oav1c6Hu7L
         SnVlQso7/vB4wgShs4pNmxt7DExPvm6dmF86aI+A+aIHjvM0IJTrOWnGM5UYDN9aqstb
         SQ9EUNd325HptNLhF3Y537JOeOhSoBbXu+K0f2rRSVVfgwpaw+J0pY0hxON2kxh7m6Dv
         7BdcWeiEwXIVm0nGKmf+jo8U+gxmw79Uk6mVsq7ULFxGzg0gtyER+d+sKxKaU3JIijKE
         0wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752026239; x=1752631039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ksu8nqKnroXcHaUiosqlWb0w7zGyAK3qP74Gg9s7Pes=;
        b=b1h5FJ5VteYSZONV+hhjTERXxEbXmAtzLnYGmdhRp/wGIz/NKX7WduewdsEViSJc4v
         60I+Eq2Z8jKi9PtIP/iJl9saNAzhaR23v6cj0R90oKZvekTFA62l4cbttF9Lh55TptGT
         GCy1rDLJrw3hsQ9ZZKrnuDcp3jt+TItp2XqpWh0o/MMnH3CB6L2VX9OBqdKYpjkFaulg
         jUY6BgaoAci7YPs/2mvYvL+NHDqjojMWNzXv+LxWlVnIDJLq+yhgEhWhNBGgrCG2vfpy
         uJRGzGTn1MNSDM4E4aVu4mbZqw4oo1RSUMCkVjg+LvKf0mAlzB23/WcwFny6ak4bPsrF
         c00g==
X-Gm-Message-State: AOJu0YzQVsU/UYAhf4o3+LJE8XxJmoH1I/YtZS4H54jnAph27JHBAKCQ
	OhcM/yY4AWJ2uUhyfztN+sRhpXD2OY6UlTV9+z6ONnVcOourBrfFjhDQUu0yFG893b9TcriEQmR
	ZypHsUUc=
X-Gm-Gg: ASbGncuz0jEumkCOYL5JMq14a22HFY7JLZ5sQEasm9EBE610bHiIZX5uy5XedVRwYf0
	Ev1fqo1HyEcJ3iwh4O5jY5bOlDx6S4ZGk/BuD/tprD8MHIg4wmVz58/95S9wcGuyWh3IbDUYfd4
	UfGSu5aCd1i0wQ2VipYvvazw+TwFpCcydaagwh7azzknkPhPR57kM1TnrMgCzSuPRX1op3sgGRg
	Sz1ORoICnZ+1ndgVhPNT0ZmowUrJORBFAfZv4a1x5MLOMVi8kvn9tOBA1CaJo//MMW9ygD3irV9
	4pMsEkdSbtR8xh/TfAluixiH9SQm6/BHN0DXrJ77bqGqEaxnVuPYf29S0Yb2HipxvyG37A==
X-Google-Smtp-Source: AGHT+IGf5H74g99vy0JdkST8sQioa1Zg6h2ZCwSQdNPCBrbexepb+OE+pEFM/u+Oy0u7KgoPXCGkyw==
X-Received: by 2002:a05:622a:11c1:b0:4a5:9825:d6fe with SMTP id d75a77b69052e-4a9decf3a20mr10595011cf.26.1752026238785;
        Tue, 08 Jul 2025 18:57:18 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a79106sm92041421cf.45.2025.07.08.18.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:57:18 -0700 (PDT)
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
Date: Tue,  8 Jul 2025 21:57:12 -0400
Message-ID: <20250709015712.97099-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250709015712.97099-1-emil@etsalapatis.com>
References: <20250709015712.97099-1-emil@etsalapatis.com>
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


