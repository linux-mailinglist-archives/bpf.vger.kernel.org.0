Return-Path: <bpf+bounces-74821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D32E6C669A5
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B07544E4AC2
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 23:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A248317709;
	Mon, 17 Nov 2025 23:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Ec/zNJgW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC5231A7E6
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763423834; cv=none; b=kWF5orhVl3y9Cwg/ssZrGar5o2zB3otPWTJYUsifGVLY/s9Er5y9DbZgCPCoFfa/1BMC5dYvAlRiSCm4RPQQUZS2H9IcE7KtIZf2l8GgZciEcYInmtcGMC4tT5+8Ew2M4mSt24MbMzQOl0IhSW9yLZNPed9xGaGT49vBvvijEcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763423834; c=relaxed/simple;
	bh=7OqxqEjdt2c+/5oJiJOwtdcXVK392RcPf10UOhNu5fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xz4vgByoafKpcF/YYsoORz+QMOUd362JDGDWBnpRR4dvXmgXx6CXxB8jp5gBEX3eAr0GYqjGhMPSt63aueXVUGRyszKqRn4gTn9ugKwsbw5z34X4jzugDmz9JngD2Vj+aSD9FO9h+6rB1pwSPw1ABkvERIk6ktUUuBNN3AkGphQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Ec/zNJgW; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8823cde292eso56819236d6.2
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 15:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1763423831; x=1764028631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5dAUyQuo8fzK+4xA7/45z+xk+oCevJkY0SNrVTaO5k=;
        b=Ec/zNJgWEJx36azb67TM3j+5ktfsHTxi+xeYwCdm7iwM5iIo/UiRF2Ne2A6N/ubbTq
         iZpCtV682bvY3V4vNzbs+7V09pDqjKDWejE/OF24TkraXoNbKUQxVFyZZHTJN9MHvKhH
         bSrXFeLutEiLdO6v7p2Qe6xSTK4cuhOH8hH3HMjCOozAC6LkClDc70bxtzqdvZ4HSRpB
         D3QU5u9z+W3uOxoTXTPzq6kCJ1JvcCBbvfjaRDnprGiPKEFXtK7LyjjnNnnvD9QvQ74j
         gCXAgZemg/BuX8/vB2QnpHJqS9uSb4JKv+SF0emLL8ARXMnEy8ReH2L7y3nkz+xgLVAt
         O8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763423831; x=1764028631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q5dAUyQuo8fzK+4xA7/45z+xk+oCevJkY0SNrVTaO5k=;
        b=L14TFmjF4SNNEtZ59vfOykvVeCclt5qxXP8owDKOAQwNZerI6OwgezuFY5Brjq2wWe
         OZX+h0hRbafTRDSomRexyaWkQkXm5+P8jrxRdDAJIH/r2+3seoUbrSMogMX3TcBmjLDr
         S5oY3UajYWbIdh+s3xXrou3eGL4l6Et481y05Rm+2j4a4F4BJsrcU48K0MIwNztFU3kQ
         UkveGryf8BMZIyZsUYANC3R3kFiJFajFws5G9qbKrml1ohaLIBEs9lBA2if+grBX0nAd
         AewjkogzxAM6qvmSDcsxAzxrbQ3nEuOZXqY8bGNNtwglwJzN0R+uWGATkavC9D5eE+S+
         c0Ug==
X-Gm-Message-State: AOJu0YwCClSsvlVpQ2EYAVoC6HfX3Tpg70UFF4+Jm4pdriD0qtVRHLeG
	Jv1NUEguFqbRnc6+xAlUsHaXltl/d0A2F9LJtIM0joaYj1S24FEpNP4v6GdTMA757Zy4etsF2fU
	xoM84m6s=
X-Gm-Gg: ASbGncsySFy3Rf1dRWFEfVS1TqLfxv54odpx13rl2xFWNFw6kKSKc1iJYuUZfovEfp+
	b3vs3rhf981blmRSMOw5Y5xrJPZLgDw3HAzzxCHv3PZGbXR/gjYKkdqtJnpNCNejixnnzMKhSky
	9nu6DF/X72m64Miw/jWssnODteEWPRrUCGWs0izdbyx49tmN+A8gM86JMb2/F7mYjSqgXiunqGp
	d7rdN5z7gNfo3Up2yTWQSxtXVkfVvyMaFcEHPOB6FyN+wG7pI6bxC55QtqjDyHGz8BYgprfb1Sa
	2W+0NB250YvkQAVDpSWMxawp+ObfKML5pPdpVLYwi+3WGPvH9rue5j0wh4JtM1GPUCzAC6yo2Ba
	1FfGf5+RWkTDYlHleQQtAlO9E2TRDyIbjrFKIIsU+0fA+giTIYkTV4Dz7pYwy+vA8vhg4lpVxyW
	4=
X-Google-Smtp-Source: AGHT+IEYSC0BTCWuMpptD52QRUvrDSULuDogMfkgcY9HvJyKNRAjkP7GjUmhB1IvfavjBeBfFj+n5g==
X-Received: by 2002:a05:6214:1c8b:b0:880:4b27:1888 with SMTP id 6a1803df08f44-882925c504dmr217361306d6.3.1763423831346;
        Mon, 17 Nov 2025 15:57:11 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862cf6d5sm103077516d6.11.2025.11.17.15.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 15:57:10 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 4/4] selftests/bpf: add tests for the arena offset of globals
Date: Mon, 17 Nov 2025 18:56:36 -0500
Message-ID: <20251117235636.140259-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251117235636.140259-1-emil@etsalapatis.com>
References: <20251117235636.140259-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for the new libbpf globals arena offset logic. The
tests cover all three cases: The globals being small enough
to be placed at the maximum possible offset, being as large as
the arena itself and being placed at the very beginning, and
requiring an intermediate offset into the arena.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  6 ++
 .../bpf/progs/verifier_arena_globals1.c       | 60 ++++++++++++++++++
 .../bpf/progs/verifier_arena_globals2.c       | 49 +++++++++++++++
 .../bpf/progs/verifier_arena_globals3.c       | 61 +++++++++++++++++++
 4 files changed, 176 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals3.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 4b4b081b46cc..0c64fbc9a194 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -6,6 +6,9 @@
 #include "verifier_and.skel.h"
 #include "verifier_arena.skel.h"
 #include "verifier_arena_large.skel.h"
+#include "verifier_arena_globals1.skel.h"
+#include "verifier_arena_globals2.skel.h"
+#include "verifier_arena_globals3.skel.h"
 #include "verifier_array_access.skel.h"
 #include "verifier_async_cb_context.skel.h"
 #include "verifier_basic_stack.skel.h"
@@ -147,6 +150,9 @@ static void run_tests_aux(const char *skel_name,
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
 void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
+void test_verifier_arena_globals1(void)       { RUN(verifier_arena_globals1); }
+void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globals2); }
+void test_verifier_arena_globals3(void)       { RUN(verifier_arena_globals3); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
 void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_write); }
 void test_verifier_bounds(void)               { RUN(verifier_bounds); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
new file mode 100644
index 000000000000..c9bfdc33e1f3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_experimental.h"
+#include "bpf_arena_common.h"
+#include "bpf_misc.h"
+
+#define ARENA_PAGES (64)
+
+/* Set in libbpf. */
+#define GLOBALS_PGOFF (16)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, ARENA_PAGES); /* Arena of 64 pages (standard offset is 16 pages) */
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, (1ull << 32) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1));
+#else
+	__ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1));
+#endif
+} arena SEC(".maps");
+
+/*
+ * Global data small enough that we can apply the maximum
+ * offset into the arena. Userspace will also use this to
+ * ensure the offset doesn't unexpectedly change from
+ * under us.
+ */
+char __arena global_data[PAGE_SIZE][ARENA_PAGES - GLOBALS_PGOFF];
+
+SEC("syscall")
+__success __retval(0)
+int check_reserve1(void *ctx)
+{
+	__u8 __arena *guard, *globals;
+	int ret;
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	guard = (void __arena *)arena_base(&arena);
+	globals = (void __arena *)(arena_base(&arena) + GLOBALS_PGOFF * PAGE_SIZE);
+
+	/* Reserve the region we've offset the globals by. */
+	ret = bpf_arena_reserve_pages(&arena, guard, GLOBALS_PGOFF);
+	if (ret)
+		return 1;
+
+	/* Make sure the globals are placed GLOBALS_PGOFF pages in. */
+	ret = bpf_arena_reserve_pages(&arena, globals, 1);
+	if (!ret)
+		return 2;
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c b/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
new file mode 100644
index 000000000000..79fd37e5783f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+#include "bpf_arena_common.h"
+
+#define ARENA_PAGES (32)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, ARENA_PAGES); /* Arena of 32 pages (standard offset is 16 pages) */
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, (1ull << 32) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1));
+#else
+	__ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1));
+#endif
+} arena SEC(".maps");
+
+/*
+ * Fill the entire arena with global data.
+ * The offset into the arena should be 0.
+ */
+char __arena global_data[PAGE_SIZE][ARENA_PAGES];
+
+SEC("syscall")
+__success __retval(0)
+int check_reserve2(void *ctx)
+{
+	void __arena *guard;
+	int ret;
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	guard = (void __arena *)arena_base(&arena);
+
+	/* Make sure the data at offset 0 case is properly handled. */
+	ret = bpf_arena_reserve_pages(&arena, guard, 1);
+	if (!ret)
+		return 1;
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals3.c b/tools/testing/selftests/bpf/progs/verifier_arena_globals3.c
new file mode 100644
index 000000000000..cad29610e9be
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals3.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+#include "bpf_arena_common.h"
+
+#define ARENA_PAGES (32)
+
+#define ARENA_AVAIL_PAGES (6)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, ARENA_PAGES); /* Arena of 32 pages (standard offset is 16 pages) */
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, (1ull << 32) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1));
+#else
+	__ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1));
+#endif
+} arena SEC(".maps");
+
+/*
+ * Enough global data to fill most of the arena. Force libbpf to
+ * adjust the offset into the arena enough for the data to fit.
+ */
+
+char __arena global_data[PAGE_SIZE][ARENA_PAGES - ARENA_AVAIL_PAGES];
+
+SEC("syscall")
+__success __retval(0)
+int check_reserve3(void *ctx)
+{
+	void __arena *guard, *globals;
+	int ret;
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	guard = (void __arena *)arena_base(&arena);
+	globals = (void __arena *)(arena_base(&arena) + 4 * PAGE_SIZE);
+
+	/*
+	 * The data should be offset 4 pages in (the largest
+	 * possible power of 2 that still leaves enough room
+	 * to the global data).
+	 */
+	ret = bpf_arena_reserve_pages(&arena, guard, 4);
+	if (ret)
+		return 1;
+
+	ret = bpf_arena_reserve_pages(&arena, globals, 1);
+	if (!ret)
+		return 2;
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.49.0


