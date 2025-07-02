Return-Path: <bpf+bounces-62025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FDCAF074C
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 02:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4AC4A696D
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 00:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC78BE4E;
	Wed,  2 Jul 2025 00:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="bZqW7q3+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7881912B73
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751416449; cv=none; b=ovJHvTzFwcD7jHcA7/RXbDfA97ZuuOM1ssZU83H8/g5L/CVzo4uYs13Bc+g/NekHEC4VdYXxAbaCoMT7LlrLE/PKeBm0k9rMrxpsj7LgS8v0oL0vlzWiv0+vZXr1sKfzSpnTJoJwq1D7WzJxfboBBFgg5XzU3savgqXgfwaUmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751416449; c=relaxed/simple;
	bh=gU1AXUlDELXv/hbfgrd3BPGgqlpaRT5+yxlq6/OSa0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVmxGMCI47DKV/WJuP3zMTVRVFQNXEVZpyffDwtDUH4GZQFW3I48vmeV7N7aoU6NBpsE8X306Qw4ULMdIZlL3/eouxo1+a0+Pp7FuPexE3rMNbonm79x85nuN1IpVK8T9CF/d3+V82tyFknPMyHSnD85fdWzuuY18kfwfNZyZQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=bZqW7q3+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d425fc4e5fso518298885a.0
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1751416446; x=1752021246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNECXvQgpOLzLcZ+rsxXUFyCSMiCiwHW2NUcAce+Q3s=;
        b=bZqW7q3+uSJEpIed27In6n9h51jdYLsCzYKH6of8fqG7IEgapBIduEwXNZ0sAaoT7L
         hVRyEuP9+28Rbjs8MPsSxHPQl1owQ+1eeidgHZR0bRNW5qklWiWAroWN4M4E1vvJsf4h
         GNc77RC6BUZdy1gkuoUPoDOzG1BNeMsMzXDToQ4M7WSMKOo+sq4W86Jfy4cfb8xxmRb4
         4GFumsTNvE6BDxpyEQPlXG+FZXdhiL69c9K8vpAjOD+aEIGaLc0ZgeUeWZJe+viauYFO
         di5KAYkOjJbuIT+MO6pR4ZDcJFlRSJ9coGBOkKYI4y9tQfZFmBi2Jn+rDo0UvAkiCjYo
         sslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751416446; x=1752021246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNECXvQgpOLzLcZ+rsxXUFyCSMiCiwHW2NUcAce+Q3s=;
        b=SGBwdZsIFEq+E2QqYLmWaVliQFRBW1lbk19PXDiSoRnwL3VDUkNaoeCE9cHsnKy7L1
         tkPb8zJYUSoGJIP6VA3ru0bR1p8+PfVT3gaBnHuSUR777Fs64WxyTUBqOPmib4gAtu6m
         JGLIYNCnXiu9K2m1ZIT8mV1ICtOrm8cw8qEE7FyUh1+iT7wwCANwRD28ts1vNZb9+bz5
         iK4/x0qUKm/gftuPGhuBO5FqxNAS56nYEAsoPVnwg8ns8JQ8qNGJue4sl7ZkPZJhpm3P
         PcgYjLKkb44dHO7x2AmLYNhsMYe82d2yDEjRRTsB/ZQsm4VU4q1LXmE/zVvAsrbWr88H
         Y3Sg==
X-Gm-Message-State: AOJu0Yy4ouk+pQbvwIV1Fs37IsMbjiaqlsTmugAHBeDoNxQ/PLXJiUzz
	qfde5lJMA77F3opk7i7qTYfGFXUF8SFIKrSe/nsFlkv4JksMSe+OW9qfzzj4yMThhTpyiPaX9UJ
	W6nI0shy38A==
X-Gm-Gg: ASbGncvdWmoRtx4T8YPe0KnoizvFX2rb+eyVj+9iQA2vDbVdrTMRFx2de2x6H6iHYXL
	dxWjELcaDtScNw0xSD1oI6kNk7MQru1V8CUeXMM8MaDNw5R3xhL1ywetl0k6cY092aqE6UhaQ22
	xgD0xMuJuU34rZGIyLr2H7heq8LK0Xo9eJM1Ri/iL0TbL7XgroFlXZDkOszb3KRp/7xKbwawH44
	itYLB5OV+ZQV8JY3mo/4sSfSkezR8Urm4OS49YqHQF1mFUbAXRX+FlSNELNn5p1qBfR6/se5L7K
	oElWW91jrlp6NRwxkMyzKp+H8spaR9uFD60Ku3Q8HFET1HcSdTzCudS2ihA=
X-Google-Smtp-Source: AGHT+IHFpziS7IyvwjpPeAQ/cnlv4ypqV9u0Nz0Hh4cFz7HkMUpIeoxTbySR8ypBBfPvJXB803mlMQ==
X-Received: by 2002:a05:620a:410c:b0:7d0:9782:9b05 with SMTP id af79cd13be357-7d5c46a9beemr169427785a.25.1751416446240;
        Tue, 01 Jul 2025 17:34:06 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44317cc43sm853106285a.46.2025.07.01.17.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 17:34:05 -0700 (PDT)
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
Subject: [PATCH v2 2/2] selftests/bpf: add selftests for bpf_arena_reserve_pages
Date: Tue,  1 Jul 2025 20:33:51 -0400
Message-ID: <20250702003351.197234-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702003351.197234-1-emil@etsalapatis.com>
References: <20250702003351.197234-1-emil@etsalapatis.com>
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
index 67509c5d3982..aded43ecbc27 100644
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
+/* Reserve the same page twice, should return -EALREADY. */
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
+	/* Should be -EALREADY. */
+	ret = bpf_arena_reserve_pages(&arena, page, 1);
+	if (ret != -114)
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


