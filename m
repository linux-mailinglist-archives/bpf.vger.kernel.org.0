Return-Path: <bpf+bounces-76738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D1FCC4BAE
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E24E309CF76
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAAE3314B8;
	Tue, 16 Dec 2025 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="r+c8bQ/+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB012D47EF
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906517; cv=none; b=b8OJJb0IZZLEqemW1lEmgkQhkT/CQVs7n4VsL0UQN02uknMzchSa+afvScO7tWYR7rKVQ3YM9TkxeJXwsFu19jSTVtR3q89GS0cKajGQKGQx4EWhL2Y0SozygEAl989vZCqQAaWqK/TGmFy4lSkuXvGyBMDAejgkSDIpJKcAJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906517; c=relaxed/simple;
	bh=u+p0neYkbMcxGcjrqNicxRsDaOV3JgAx2JHtNU99WPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nI7RGggr9LwDCfTplgH+WeSDpQNg8viTosstGCg0+FT+FJF3/yQAOBloPm25KzP8I4z2ciiRR5pN37GZ88aZZ8rn1xGB/EMvmnoEWLIozwiRPbY3x3RV4RpC0BDN/1aoXsrSmQ2m3FR4ei7d/TuykfIAnBD3NgEdMcYYbpkwdso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=r+c8bQ/+; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a367a1db0so37192896d6.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 09:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765906508; x=1766511308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+Chtg3v9/QR1Qg6Ga3rZYafB4zmruwOq7hj3TrRNd8=;
        b=r+c8bQ/+v8N5v1Yn0K0LwzqDoGzFsIt7y2uLMHIqx/WuZTY41WdKCibUyXuYerdgt1
         LElIjuNTTj9p1nULyYUEEBWdltrcrHGDk33ez3jI04+DWrxAETwOYuTb9b9GP3k4uomA
         F57X/hlLzqf/TJn077iID0E7WbTrp0Z18JylSsBBThhvunEoCyboz2XHgP1JIGIr3dnW
         BBhdT5Ha+SGatdwZMHVjrNWfxx78x33Q4g5wfjy1sZLFEW5re5y9Moc1CUzDxtQj2Zt0
         9XhBaqZ/dQOWuP0H8nh70zzWU6SnPPIjyL+xip3RCyzHsOL5mpZ9AAck67AV1W0WyABm
         kjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906508; x=1766511308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9+Chtg3v9/QR1Qg6Ga3rZYafB4zmruwOq7hj3TrRNd8=;
        b=oucui5LhwF2KQKxSwc6mVUuJ5v25aKS60YGwOWOui4WzsID3i56m5WUtqIc5s6mds+
         APfRreweVwT9BIG9UxKNNOZe2IxY8UvLKk5BGifJGmY40Deu6lAbe3/1kqwBAd3fmhwf
         cM8FogE0UjlSARHRqJW/dmWvpDBCLLEjCnuaO56CbXike/yrU8FKdzVmJ/0YqHnl9Gyp
         ghnZvMF+3gkJ6Eg1ZH8jwY3m+gFc8/iZFqKtazRU4uoh9KexwWBwHylstOxNnPKJSHFV
         4cThbE/EkbaOdQYls4zIeQjVbpuGx76/I2c/0lMhv6RJZD3NG5r/hd59yixS3d2UI6kU
         HBQg==
X-Gm-Message-State: AOJu0YxEbMLNTMgUj+o+qEU8Xo9/voVUuBOF/MO/KDIdTLQIkfMNrMbL
	wdb4uBRZ1a6dQuE0WUBUDUWdptDpOIyqZfp25fw+Wt2kOjwRSs+W8D7ZcDnbBUEdwgJHoY/wGKY
	BbMglZy0=
X-Gm-Gg: AY/fxX7CuwgG2Kqu4IBSLHeTMkvRgvynxTmusmpX2y8pQnTz2+3mP2sVROBDYj9Ecjy
	6yW/XYIPbnTIdruM8cmJaez312JQDltywIPjfPFe8up0anLMrqgRJiJmnIF1y8PGZvUMxUwo7IU
	FKFYESH9WtdSlPdfZHf8/qnbuSZyly/t5kAN8IkSqi6p/8onGZjSjzhyukKkPddwoYbPI1We+OI
	HbRVN4xuwGt4L4eG1dN/DmrKmMCIRyyzPzxMMS0D8cvjgYx/hH2xpyKICkTzv7C6k+uZ4Z3obUy
	LgN7LJT19OnarMbmMa00sQPiw6kL6cA58+eMWetgY+HURsnDTPLlzw5JSofTHIImjrOXdL84DJJ
	yhTybGc+atWzYLmYrR7K+b5zujnBfdIZlRRwIypDScny3pl6yfIDcjWI/c7QAxercdT9ZG2grfq
	83QDnMkLuHR93Jai2kFcCn
X-Google-Smtp-Source: AGHT+IETnu4R28WBm4zBmiq3Y7Vkqs14XrAKczJofzBjQAgj+AWtChW6HN754aRIF/6xpDluVCIFzw==
X-Received: by 2002:ad4:5761:0:b0:721:a9d7:297a with SMTP id 6a1803df08f44-8887dfe0aafmr276471486d6.7.1765906508303;
        Tue, 16 Dec 2025 09:35:08 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a860f8basm79310456d6.56.2025.12.16.09.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:35:07 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v4 5/5] selftests/bpf: add tests for the arena offset of globals
Date: Tue, 16 Dec 2025 12:33:25 -0500
Message-ID: <20251216173325.98465-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251216173325.98465-1-emil@etsalapatis.com>
References: <20251216173325.98465-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for the new libbpf globals arena offset logic. The
tests cover the case of globals being as large as the arena
itself, and being smaller than the arena. In that case, the
data is placed at the end of the arena, and the beginning
of the arena is free.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  4 +
 .../bpf/progs/verifier_arena_globals1.c       | 87 +++++++++++++++++++
 .../bpf/progs/verifier_arena_globals2.c       | 49 +++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_globals2.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 4b4b081b46cc..5829ffd70f8f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -6,6 +6,8 @@
 #include "verifier_and.skel.h"
 #include "verifier_arena.skel.h"
 #include "verifier_arena_large.skel.h"
+#include "verifier_arena_globals1.skel.h"
+#include "verifier_arena_globals2.skel.h"
 #include "verifier_array_access.skel.h"
 #include "verifier_async_cb_context.skel.h"
 #include "verifier_basic_stack.skel.h"
@@ -147,6 +149,8 @@ static void run_tests_aux(const char *skel_name,
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
 void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
+void test_verifier_arena_globals1(void)       { RUN(verifier_arena_globals1); }
+void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globals2); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
 void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_write); }
 void test_verifier_bounds(void)               { RUN(verifier_bounds); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
new file mode 100644
index 000000000000..14afef3d6442
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
@@ -0,0 +1,87 @@
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
+#define ARENA_PAGES (1UL<< (32 - 12))
+#define GLOBAL_PAGES (16)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, ARENA_PAGES);
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, (1ull << 32) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1));
+#else
+	__ulong(map_extra, (1ull << 44) | (~0u - __PAGE_SIZE * ARENA_PAGES + 1));
+#endif
+} arena SEC(".maps");
+
+/*
+ * Global data, to be placed at the end of the arena.
+ */
+volatile char __arena global_data[GLOBAL_PAGES][PAGE_SIZE];
+
+SEC("syscall")
+__success __retval(0)
+int check_reserve1(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	const u8 magic = 0x5a;
+	__u8 __arena *guard, *globals;
+	volatile char __arena *ptr;
+	int i;
+	int ret;
+
+	guard = (void __arena *)arena_base(&arena);
+	globals = (void __arena *)(arena_base(&arena) + (ARENA_PAGES - GLOBAL_PAGES) * PAGE_SIZE);
+
+	/* Reserve the region we've offset the globals by. */
+	ret = bpf_arena_reserve_pages(&arena, guard, ARENA_PAGES - GLOBAL_PAGES);
+	if (ret)
+		return 1;
+
+	/* Make sure the globals are in the expected offset. */
+	ret = bpf_arena_reserve_pages(&arena, globals, 1);
+	if (!ret)
+		return 2;
+
+	/* Verify globals are properly mapped in by libbpf. */
+	for (i = 0; i < GLOBAL_PAGES; i++) {
+		ptr = &global_data[i][PAGE_SIZE / 2];
+
+		*ptr = magic;
+		if (*ptr != magic)
+			return i + 3;
+	}
+#endif
+	return 0;
+}
+
+/*
+ * Relocation check by reading directly into the global data w/o using symbols.
+ */
+SEC("syscall")
+__success __retval(0)
+int check_relocation(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	const u8 magic = 0xfa;
+	u8 __arena *ptr;
+
+	global_data[GLOBAL_PAGES - 1][PAGE_SIZE / 2] = magic;
+	ptr = (u8 __arena *)((u64)(ARENA_PAGES * PAGE_SIZE - PAGE_SIZE / 2));
+	if (*ptr != magic)
+		return 1;
+
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c b/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
new file mode 100644
index 000000000000..e6bd7b61f9f1
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
+	__uint(max_entries, ARENA_PAGES);
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
+char __arena global_data[ARENA_PAGES][PAGE_SIZE];
+
+SEC("syscall")
+__success __retval(0)
+int check_reserve2(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	void __arena *guard;
+	int ret;
+
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
-- 
2.49.0


