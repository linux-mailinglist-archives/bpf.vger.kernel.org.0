Return-Path: <bpf+bounces-74851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9EBC67156
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 04:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4DD94ED8D8
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 03:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCF0326951;
	Tue, 18 Nov 2025 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="z++EWQfS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1679ED515
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434880; cv=none; b=n/nzhS4Wzw4PDoOIsBgJ+2eeo9dcd1c3mYKBlObrOWGGk5AcwkYDEgukBzKRPCRZS7aVP1GDqyIHk449sKiLjwriYJNk7WV7xoW2I7EEnkAnM5XV8X4E5sX/2keip71DeTvU2nyMRmfPgEfLfNWb32F7qvgzjH1vN9qnlLJbh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434880; c=relaxed/simple;
	bh=sV9wMFHraob1YT5DNnRQ83U7PduH6ahMlpzptRprKh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g18EfzT4NPrg0uPkniTFRd+IFlzyNi9U6GH70XIJUJMU0AlcG5bgxN4WMoxkdIDVrW1IVzQH5rjdHYuNSsDIcdouHUj5ILc+fvw7XD+APdI1lSv/A70XkYaMR9pM9mwNT86UiT3utHHGT1NHUiBxu+9zLJvRorFA1BzDWR7PcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=z++EWQfS; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b2148ca40eso688798485a.1
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 19:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1763434877; x=1764039677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6ftw8wP1SZQKHLa+WSwK4fcaXPpukifxsrSvNMRwS0=;
        b=z++EWQfSAoW7CmYcDt8ibLthy67aE4z24i7wdYWr+vvrFassyc3a9p//FPTxYQTD5s
         vUZsK+vV6qY2+fQ3c5qSKqYpLlmCeWcqlrtnbsmYA3VyUqPw50ZwIZJXqwhVO6Zy9KHy
         1xvilkk/MfNkwVg8e6DidimS84xoKCOAl9vwkmqKKJrJ1xot0zZ0xX14MJ/TmzhWZr2i
         tKrgky4AnjuCylXOi4jUkKHKQYeZov/CFePALN9FfWod4cockGWaB5zOTDQVlfO3RxN9
         EjiUZ29J4EBeAsw4XcL8BCp6T2PqLH/ughBQDQf5JKdMkKm1y6S5orFJUJnDDUyvNq0V
         RtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763434877; x=1764039677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M6ftw8wP1SZQKHLa+WSwK4fcaXPpukifxsrSvNMRwS0=;
        b=IOjHh89+SarJ7aIF5vYFkyzpU4V1IZcvAWThVCrYdPw61NVnyjHnVQc3lU+F7wMp2H
         ztDsysLy48ayp9P5G0J3OJ/Em8MXCmuJ9ZOsDbXCSUVQ1KRpXSFGxCFj2zqzhKX1L5PD
         LQmpwKol3pn9y2lFuBRXrKB1zxEoBAarl2xB0lLCyeOLJwYyQMNH/REqiqG4r2UgASxS
         mqVxLWsQF5RfsVyPfzghK24+tOQ1c8g8XJR04luu+3L9D5EcgihczTFzx8+4bvgo4yel
         ElPSsHsLyr9dbQGvnnGF5ZsKrZpTrUcO9B8BXdP/JNPB2BR6vO+/I/XoPGA68MLORLMM
         eC+g==
X-Gm-Message-State: AOJu0YxCklNuhiEdYKbM8LRKf3S1lXbFi+5sKkpxFs7AomAkx+ic5cXa
	Tx98D9fDmEoBehUcZSx321h6eWOGLSJRCVSPnMNCtIX+uTczVyVoda+C1W61oCm71aNcjEFGkkE
	2FX09hwA=
X-Gm-Gg: ASbGncsB6s5MqU+47gt2HIXEbaboEQyAHCmHFXmGHw9q/+zN6lr5B+vskgDuRYKeq5j
	lDuI8ko64QULUyZow7vEQ4JMd62h7t5/rLR7XE9/4Ujc3b8r/aQ2DAQ/IrhabcokoCdNoz8KnzE
	ekHpoTxcOAXHrDVRzamDacHZKHS0/JtvbStcUwEPNjZTGWFA/c/kvNMYys71EJAr2pMs4dHHTOf
	xg0e+62RBVJ/AssjtjazZGHD6rt1IU/OUTnf5kuRnxS16n5cJ62yStOwzdJhwzkvI3g4jknp8Na
	btG3Y+L6+kNR5AkB8yAdGULZHOcA7lnT7quvgQNjGSpzFmE7J6xd4oGZpD99kNx/7hsoPR8ym0d
	HIDiblACFIdP8Ut1jtZqpBYoCWefFAL9rDpJu3VBlxzLSzEP3eDIPTomxSCUhtGMsiFRCurCflL
	FVK0LrtNh1TU61hLzdqp0p
X-Google-Smtp-Source: AGHT+IEadrO9oJ4yrNtGaRdMxoDGhgW+EyCVQfBNRWkiAHe3b4cIEuaqJ2iine3Oz2TR+iIhQKPrtw==
X-Received: by 2002:a05:620a:444a:b0:8b3:16c:1a81 with SMTP id af79cd13be357-8b3016c31dcmr202129085a.54.1763434876822;
        Mon, 17 Nov 2025 19:01:16 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af043037sm1117130185a.48.2025.11.17.19.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 19:01:16 -0800 (PST)
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
Subject: [PATCH v2 4/4] selftests/bpf: add tests for the arena offset of globals
Date: Mon, 17 Nov 2025 22:00:58 -0500
Message-ID: <20251118030058.162967-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251118030058.162967-1-emil@etsalapatis.com>
References: <20251118030058.162967-1-emil@etsalapatis.com>
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
index 000000000000..761844577981
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
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	__u8 __arena *guard, *globals;
+	int ret;
+
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
index 000000000000..9b6a08135de5
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
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals3.c b/tools/testing/selftests/bpf/progs/verifier_arena_globals3.c
new file mode 100644
index 000000000000..62d1a46955fd
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
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	void __arena *guard, *globals;
+	int ret;
+
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


