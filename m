Return-Path: <bpf+bounces-75978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B9CA0173
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 17:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 869113060A47
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5817435CB94;
	Wed,  3 Dec 2025 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="14uyqAgP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023D35CBAB
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779212; cv=none; b=mCO6v8OP9jOxHV8Z+vDllTKWsVg31NpDsxyAD93s7gkgZvkwkrtMJkK7UVDRL7drjCqeSC0nayvHZjz6jzmiO6uZtepqMiSE9xBWxF/JfcQL7zOGwL7lhxXLzDxAUSyeTVFc+08+RvF1qQXcR+TktmNQ/n2GCLWoEaHpFA1QalY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779212; c=relaxed/simple;
	bh=McAOlS01Me0No7jgJnBBMoU8Xxx/UjcJO/OIXMb19C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYCiDGryxkHRH0KBRWmEXPzX/C+GQ8NNjkkUczPbLVp0FFqkSmpXWH4j+cMuQe/erDQa2ucBtnoKHoSs12xa2czkfXMBsfC+K2Bwv/oxxOxmL9C14PULJsvEm/iCHlq4e1NgdDowuZp0mM6jzVn5ctcMUplIMbDBE9WrCfvn51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=14uyqAgP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4eda26a04bfso75663631cf.2
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 08:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1764779210; x=1765384010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niFmWnB5Cwa8+Ngb15lqCxx3HXwn1ex97HmxbvafnwA=;
        b=14uyqAgPYAxN+aF0Ks+BQk0auo4WOEqo11V3pdLAQEGMUQd2JdeHOgqf1fRX77nC1T
         5IOtUEJ76n0VDHMYyiIeSli740sfJmJmIJsii5PGeeGFOIwIhDZnLF0mT5R3KIfCrlFt
         cvr6Fvq5KSHFKamkmb2zaXY3t/6fHdOPPlBykfcCGtVIzkwrswTQi2VGRrgoGrrD+AoZ
         8Bo1t+YNE+1AJrcUyOGhvgJwWLehDjFEYdtQNC8676K15MPk6USOTVUf6LYUCuQrq2r6
         7f3idL7rIgv/iIpjFQutzIoc7j1rL42feznxKgH/EpvzTkzGtP8qXdz8bNvDtdyrW33U
         IADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779210; x=1765384010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=niFmWnB5Cwa8+Ngb15lqCxx3HXwn1ex97HmxbvafnwA=;
        b=t9UMswA3KO0HEAHKSto7w/ahtfKyILzgoJDshsJbvDUYOKRVIfKvRwiq6y0o6E7YGv
         gBggaksNnZkh8/t3KJRFyxcOe768xrsKO9nif8ygvmdaifjwPexfm6J73IH6rRctzBBi
         9fdDSG+OvKiK4SUkN9QIoSZ3yg6WLBpMgw0I66+nb4ZymLvBAdN1oGwRfTXDH1GWHjdG
         4h7DyyCh/WgrFAlaxfwsgCb1GUZ64jQxvIGeSU3gNOH2H0L6mT06zV9EmATiJ+0w30Xj
         x4rhlj4y35J7oSCLO2neeq7tihVQ76txKuL2o0Btb7gADk942ot1v5S4LfcT+ce3N/R/
         u4Pg==
X-Gm-Message-State: AOJu0YxrMXJJSdKcdcPJ3W1r/InjN+Dgff1ykdWWV4MVh5Pj8PWg08Ia
	C3n89b3ozflFmUM+dGbyiwjtw0jAdla2t10I1pJCIkaAMgKg0LF4aIrhMsiJUyR3ZYhiQmf7Tcu
	tleh2z60=
X-Gm-Gg: ASbGnctwScAJdpV1qHCt3r3SjZZ6Yd2kK1fUUJ+MhZm6zBMsaS/RR7X1m1JSloOYWvI
	6m8VjGIrSreokDYQjDGATmoObQ4R48DAd8RmUtOVP7yeKXBgWuJVwOQ2QtfeWRBW2CmtB2Rwcqo
	15NMSKuSiebamParvJ7QNlkqEmhEzQtbcWh7CXGvXTeHupiFuZwu5bJyKOPaUk+Qzrv7LWMB2ws
	8kGSwRJzXcxpDmbeleNl9AkJRGgQQW0EX+NMzjscmjn98sm5K56XffcXLEbh4qL27qmyPjwENCg
	CeFknLcfnXCoU9Hs6+p3fETkOemQIEIaP+REq0lg/Zoy2TZTw0FPXaIq3pKNCE6eBJcNy2VPZS+
	d31yVFw0byJ3mp9UE8iAcPSqm7BP+ZaGcCyyPJ2f50JLR7DIv6q8ZtAWXVaO65+Fn6kl+3m+6SO
	UHs3I2mEftRLqIiwVF+Px4
X-Google-Smtp-Source: AGHT+IFjBt6zfjpH3eO4JoEvqm29D8FucpU935VgA4J4Gs74u5XxtBAfyi5nlsCeC34r37pfRxK2iw==
X-Received: by 2002:ac8:574f:0:b0:4ed:b012:9716 with SMTP id d75a77b69052e-4f017696e4dmr39354331cf.80.1764779209492;
        Wed, 03 Dec 2025 08:26:49 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f0046825d6sm45279411cf.5.2025.12.03.08.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:26:49 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 4/4] selftests/bpf: add tests for the arena offset of globals
Date: Wed,  3 Dec 2025 11:26:25 -0500
Message-ID: <20251203162625.13152-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251203162625.13152-1-emil@etsalapatis.com>
References: <20251203162625.13152-1-emil@etsalapatis.com>
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
 .../selftests/bpf/prog_tests/verifier.c       |  4 ++
 .../bpf/progs/verifier_arena_globals1.c       | 58 +++++++++++++++++++
 .../bpf/progs/verifier_arena_globals2.c       | 49 ++++++++++++++++
 3 files changed, 111 insertions(+)
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
index 000000000000..3e68a5e83db8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
@@ -0,0 +1,58 @@
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
+#define GLOBAL_PAGES (16)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, ARENA_PAGES); /* Arena of 64 pages */
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
+char __arena global_data[PAGE_SIZE][GLOBAL_PAGES];
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
+	globals = (void __arena *)(arena_base(&arena) + (ARENA_PAGES - GLOBAL_PAGES) * PAGE_SIZE);
+
+	/* Reserve the region we've offset the globals by. */
+	ret = bpf_arena_reserve_pages(&arena, guard, ARENA_PAGES - GLOBAL_PAGES);
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
-- 
2.49.0


