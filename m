Return-Path: <bpf+bounces-62830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26615AFF18C
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 21:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5EC7B5339
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F3123F27B;
	Wed,  9 Jul 2025 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="LHKGBdhx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DD23E354
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088401; cv=none; b=JTeqLtLmEdDOh5KXC4wtNW4QTtU3/zn8exd3QOutAiFrF/odBzRNkRSEg2NW0fkALsLXqXCdLS4dNRzc6e6JKkopLD5hfMxY/4Bx7H0MKKI2NY2qXkURiJz/OlvpuqEmwpuGgPGakwrunU/NZWfwLSLJzxIDk9hMXerZ1lF3maQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088401; c=relaxed/simple;
	bh=ToLveSUflATsF/kOzbUprIx7v2MMtGna6EIH7bMRVFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNtRp1nEr7DfyV1vMvhPucTmmVVDVej0oGBd09QKm9obJtjJDJ+DqOHEtCnbS4tdXMKRiKOIllubgCrHSGCslobRdSWaPS7eVSBO/+fhzLjSI1ViT3n7RskFZGTfNwGTXRHhd3Mq0HmtIbqiRC3k0rCg/ST8usB63hh1uUUgPJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=LHKGBdhx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d0a0bcd3f3so32964785a.1
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1752088398; x=1752693198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hqi55LA0SpMjE9qojvyRjHqXxgRItL5W0sJ4M4as+Z4=;
        b=LHKGBdhxcYbcwHNijGOmnkLdaKh1Kdu5AXrOHvio+7DGal4EHiBcWfq4+ln9OnXOXI
         z9KQPtMXu2Vwpyy67MdI/QpqDFphw35tVb41a1Efx/ZS/O7m29aq1/HG6TZhxInWBZUX
         sW2CztJ5CSWmwtzK7pVV6pzuTPghsLu89JVKT64syfwj3hkbTOrh/xELVB0UEeFtB6sS
         p7Xs6hkDofxzyHHfc6lCqTusQ02dAEef451rgayjBRo5u6Nn5aCe6gmTtBHPjUcv9Abq
         wjlvb7saB6HtzCrYNZAED/7zLEUhvNseoP7NcdLWF7UB7HTQ/5vHgdBRe7dwkIwEDnkJ
         MFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088398; x=1752693198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hqi55LA0SpMjE9qojvyRjHqXxgRItL5W0sJ4M4as+Z4=;
        b=IbWlhXbFWQODC/z/iLdKfnHemwXauamBegfbPirJIXKsTdKm3w6zRcwEVuFw1JM5xc
         BlW/hAoqZTcdIBpG1Cj84cHLilPKGQTugxv7xEzfa9BxAmbAn5kQ2e6ST5+OPphU6VIh
         OQnjzqRxUOiVqwy/14deGUQNtzuCgwFME4CcwI/ckMy6I/sRbe1G23anJfGGyZSqb2BL
         6htChdtuAKjwlGdZN/yX3ZbKnMVgqeRN3APtzsPThoz2UjAiQSh10lHQvQebU4KsYQ2x
         cavRLv1w77nTY1PLlUTAHyZHj+2VCJg2OwzXhWNhJGgReWRN0gWUjtetvBaoWQqD1rsP
         ASZQ==
X-Gm-Message-State: AOJu0YxjIZjcQ6bSDBIGpYPAWl7CsA9I6fSwJsiHdgBEVw06SDhn+wU2
	zoy06jmePwVaJxXoVfitSiJO03T97+i3KO8RtGPdAcIHNxgYDCkSUpH4cReHe6fMphvA6grnAMt
	vZKo5QQA=
X-Gm-Gg: ASbGncv/JqWrPf2M9kmwjqW/JLVs6zoIoGDblUGWg0hbcA0ZsNaBGRkUiDLHQ41e0Q7
	Vu8TGVw2GsFoSn+cHSfjhp17iZHQLsXUDBB5wFb2b2jFxJynSiOVXcvOicvaeOQoyuj0TZKb4z9
	iMpdvwuFuOjEhHgPEWMGh+ZxQmOQK9z3dMn27z3TipRZtSSreYxNYoJykXiw7UyE67h71/S6yFJ
	h+bpRFFjoDt9MxLjBI9hr60BaFUHXOUM2s/QOQie0bn+Pq5hjm1XoYNH+FX2o71XPPl9vs3AuJm
	VgrNECnhN+aqFlKyBTKi/wdGiCWF5vwIECAPKCOlMwl+4+PkYUljDd4MN8M=
X-Google-Smtp-Source: AGHT+IEhKGOeq34z7aI5RxVRSDf1OcyWT2/XfxMrkB7fv6wghvm+n7OiuHu5ppYpvgcL2VJXm10idA==
X-Received: by 2002:a05:620a:d86:b0:7d3:a7d9:1120 with SMTP id af79cd13be357-7dc99b9fb23mr86725485a.24.1752088397416;
        Wed, 09 Jul 2025 12:13:17 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe92c9bsm977186985a.91.2025.07.09.12.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:13:17 -0700 (PDT)
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
Subject: [PATCH v4 2/2] selftests/bpf: add selftests for bpf_arena_reserve_pages
Date: Wed,  9 Jul 2025 15:13:12 -0400
Message-ID: <20250709191312.29840-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250709191312.29840-1-emil@etsalapatis.com>
References: <20250709191312.29840-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for the new bpf_arena_reserve_pages kfunc.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../testing/selftests/bpf/bpf_arena_common.h  |   3 +
 .../selftests/bpf/progs/verifier_arena.c      | 106 ++++++++++++++++++
 .../bpf/progs/verifier_arena_large.c          |  98 ++++++++++++++++
 3 files changed, 207 insertions(+)

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
index 67509c5d3982..7f4827eede3c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -3,6 +3,7 @@
 
 #define BPF_NO_KFUNC_PROTOTYPES
 #include <vmlinux.h>
+#include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
@@ -114,6 +115,111 @@ int basic_alloc3(void *ctx)
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
+	ret = bpf_arena_reserve_pages(&arena, page, 1);
+	if (ret != -EBUSY)
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
+	if (ret != -EINVAL)
+		return 1;
+
+	page = arena_base(&arena);
+
+	ret = bpf_arena_reserve_pages(&arena, page, 3);
+	if (ret != -EINVAL)
+		return 2;
+
+	ret = bpf_arena_reserve_pages(&arena, page, 4096);
+	if (ret != -EINVAL)
+		return 3;
+
+	ret = bpf_arena_reserve_pages(&arena, page, (1ULL << 32) - 1);
+	if (ret != -EINVAL)
+		return 4;
+#endif
+	return 0;
+}
+
 SEC("iter.s/bpf_map")
 __success __log_level(2)
 int iter_maps1(struct bpf_iter__bpf_map *ctx)
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index f94f30cf1bb8..9dbdf123542d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -67,6 +67,104 @@ int big_alloc1(void *ctx)
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
+	page = bpf_arena_alloc_pages(&arena, addr, 2, NUMA_NO_NODE, 0);
+	if (!page)
+		return 1;
+
+	ret = bpf_arena_reserve_pages(&arena, addr + 2 * __PAGE_SIZE, 2);
+	if (ret)
+		return 2;
+
+	/*
+	 * Reserved and allocated pages should be interchangeable for
+	 * bpf_arena_free_pages(). Free a reserved and an allocated
+	 * page with a single call.
+	 */
+	bpf_arena_free_pages(&arena, addr + __PAGE_SIZE , 2);
+
+	/* The free call above should have succeeded, so this allocation should too. */
+	page = bpf_arena_alloc_pages(&arena, addr + __PAGE_SIZE, 2, NUMA_NO_NODE, 0);
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


