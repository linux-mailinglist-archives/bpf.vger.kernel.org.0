Return-Path: <bpf+bounces-76617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C313CBED94
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 17:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC4AE3017B4E
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A873161B0;
	Mon, 15 Dec 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="BfGDYc/r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061D61D63F5
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815226; cv=none; b=jR6HSRHTIE3eYf44igEHQ7c9VMQ8c1+kaiiGRziTKzbPWVbOapkWzes6ZTtUBz6ZSeZXVxviwBRNGo3rx/Ga5PxxtDuxyP8jgkqfkmsTeOWrPEcLrwOUSvT+DmO3s71kjOX7LHg7UMaZ59GB/YubzviTrLVfzaSRM+L2aRs3Nug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815226; c=relaxed/simple;
	bh=26E306QT+F1Efr6ivyXhnTTA0SAufb93JYDV54fuH6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dueZdh2nFYYv0o6yCCNZeyP/LM5/6Wwd/3bGhUYX3WrdaAyX+MNfHwth3v7+UTEcAt7Tog6mS3swklWDZ3a8k9yGfjCA2aBExytRxBGqPdBFpZ66cLxAVmv9aETAmlLZJCVmKhLbyWWsXcG3IU3nTDHPow++OwwcSMVvTAVNWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=BfGDYc/r; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ba4197fbd4so401274385a.2
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 08:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1765815221; x=1766420021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uRtddhsbjtQKGq4OPZoGjVMpZmM1/JFiaY7DMZK8to=;
        b=BfGDYc/rqgLBNxRVXVsRXvHb7/79RN8Sn62Sa9/CFOUdNALEbMRtq42mU3BToTSL3D
         sw6oe0D6+rpc/GY4ECYGWv+npvWRz7iGwzGVvsbS5BaB/3LOlMPGTPB5moftW2p+bwBY
         caEWQklXvuSD2651p8dbjzfNnTZL8+j3Cav7lhtk0j+S3RxaSuTP5wpLXmcroiWB2LwV
         b7tgISJt1BkeTdzCwbse6CICT8PR0cX91Yd/Q/c1arZFGHWg5owzsEHHRUfJf1ZnbKMY
         k6pX8HtFE8ObJGhd0+WL00KD3maPGjh7OKrf1D8vAOZJ8PXdMFMlDEPNodnQHfqDEPHe
         QnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765815221; x=1766420021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0uRtddhsbjtQKGq4OPZoGjVMpZmM1/JFiaY7DMZK8to=;
        b=LLXK993nBdCcimw1gGVnpsSWh6wpQZMhS0b79lgY5cnTSexpmlH8lD7nODKw7P2Zfj
         2jFNsmjur8rwsGOOUkmpfp+jGI9oWeXuT8tXs593qA6RO84gYpmeATUdrOnrGGcV6z/n
         vZOoJMXIDkVx2MoBy+GqdzWQOqD1b64Im/zXuhmE7l/xXnfL7Xt9xA23+eLk+xW51fbY
         L9unEGE0xE3bUN6RvVaoQOPzr8KxyqGA670Qsq7vHvcSly9Nw3MPQynfe1ZnOvOgrbk1
         6qCWf2gRwgDaUzLsBKcDv+6Sj2cL7BvC3/cAUfFAMLHgdIVb1DLVz08oz5sjKVMZ/40F
         BPOg==
X-Gm-Message-State: AOJu0Yx43TZMFwJ7PBdoxRkBi+tKVr7F7Eom3QoiUpvMvJsZeBFB1yrb
	XPbLXRDbaoYZOzFJ+OwAJGxtX6leTj32XxCKPY8bVxhnhSyFLkbwc0yJ/NPgOx7pgHchXpzJEYl
	p2ul6
X-Gm-Gg: AY/fxX7DNJLpaAl8839MwGE9KKzDnyYbuwlM3DU7Z64Biw2afnCuagrbIuyPI8MKa87
	IqDtXAMpMeaz4z0522UOn+XyijTJehO6vWvMmGN2CSYsG1lBC2SFgG8OcifXcr2G5G0hJfCzcll
	3EKVR3tddLx2YuJqPCelrpEFLfNG3lcNPlgDz+vwCZFQg6/8k1m7y3zVOpiaJ40bdagbjcc+ID/
	ggymdl+5UpU0uyapu0aXwjnnKxsppvq4wo+By0Inypv10Lc8Xeq1goScOlntZIXad79e5pVTMK+
	YumyZV85QRZTsQWiKuNrWMAVV6C0+wjiRB01qZ/i1U+uBysVNKhVMK7/AH75f9/8HJechPpDfDg
	7ltHdRmthxmmG0re7HQE9+LZ3e5+AfqO59LsMXeLIQk1ULDX8DtWIHZOxUeHXdON3n1sNCfmi4B
	ezsdCudgZ0fw==
X-Google-Smtp-Source: AGHT+IGF6L2ljDIpFO2d7hmdAjTtXYBLJyPpGlqqzdDupqUlhoAF7qHFiBEA7C4+gVoQHsDqUuEIfw==
X-Received: by 2002:a05:620a:170e:b0:8b5:ccd1:1a0f with SMTP id af79cd13be357-8bb3a3c2166mr1604469985a.90.1765815220621;
        Mon, 15 Dec 2025 08:13:40 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5c3c85bsm1142195585a.26.2025.12.15.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:13:40 -0800 (PST)
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
Subject: [PATCH v3 5/5] selftests/bpf: add tests for the arena offset of globals
Date: Mon, 15 Dec 2025 11:13:13 -0500
Message-ID: <20251215161313.10120-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251215161313.10120-1-emil@etsalapatis.com>
References: <20251215161313.10120-1-emil@etsalapatis.com>
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
 .../bpf/progs/verifier_arena_globals1.c       | 75 +++++++++++++++++++
 .../bpf/progs/verifier_arena_globals2.c       | 49 ++++++++++++
 3 files changed, 128 insertions(+)
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
index 000000000000..d998a277e5e7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
@@ -0,0 +1,75 @@
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
+char __arena global_data[GLOBAL_PAGES][PAGE_SIZE];
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
+	/* Make sure the globals are in the expected offset. */
+	ret = bpf_arena_reserve_pages(&arena, globals, 1);
+	if (!ret)
+		return 2;
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
index 000000000000..5a6f6bc3b00c
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


