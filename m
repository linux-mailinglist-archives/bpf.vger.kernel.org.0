Return-Path: <bpf+bounces-68306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27810B562CE
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 21:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6423A1B2329C
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D1425B312;
	Sat, 13 Sep 2025 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVlFlKpN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70D425486D
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757792035; cv=none; b=Iyzh/WkKtp0e2T1Hj/F5a3wMi1xHBWvbuZQgoXaDl8+9tuoNreeP5RRq/LzQZVmxMqFgXWdCgMv1XuJicyDLGQgeCK0g/ce/0eNCMeN1zZcOJXg9w3k298EFT/q3tHJ/dx6wvMT92bZ0QH4D7V/078pDHzuaKp0XCZwnRxNSLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757792035; c=relaxed/simple;
	bh=CJEiPXc9XUBvYYCo4OGtj3pj9IZs/1BHyGGt8ZFeV9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHqEMGyLMplJSEDmqlG9CMmoDdCv5vsvOILOuYhX6qTDpByFoNpvbnr4MgB0erS/5sGMoRFyEwGyhnYiECJk5+kSPhgzY4vx4qBVQQw16WQcn2PZasbwFWqTLxu13iP1uSbV4bQjG7tGGPxzkhL4wtlt3+LkbqUzt28YOG4VVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVlFlKpN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45e03730f83so13698825e9.0
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 12:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757792031; x=1758396831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtZb3gdCHAuRfJWxHe31jHX39YisBKoW7Sd1CHnIMzs=;
        b=gVlFlKpNI98hxmhb6QD5K1bWcGvUtFKb7tCI2YDFgOvJ1ckSB5+pqlUzasIXE3ihsW
         k/b9GIYl/J6ZUwmnrwo0UBBpfw2PB+1w2pERwYGaRGCtAq+nIuBKOVtyEvYDNB4uKUfc
         4pJ4dGsQrxayBvFnwRNEgTQoH03uVkrUshfqlugcGDnJ9Rzh8xI/2cJWXKf3vRoDLeHg
         LRSF4BCIM9heNeKvLATTHRFYrWNWmeJsDLeNMq+jerc/5K8Ymvgvv+Oye9VsEGXuR+f0
         7x6XwkeXvjnLXxsaYmwEVrYAmatKNfeZkjxWPQSE5PMV5SEFcUaL3eN0RUbbmuvZUAF7
         YOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757792031; x=1758396831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtZb3gdCHAuRfJWxHe31jHX39YisBKoW7Sd1CHnIMzs=;
        b=Yz2hdsmDUyiixLeLPyOC0vOIWyEXLeKHw9f2Kl2lJEm1NB1Ci9o88QUZjlZ9A2b+Rq
         KwolV1++kT+bUdFTTuAen/0DFQtG9M5AgB0EEldc1SszWWCsT8tEgQvVr5mziJ+cHWOO
         XIErbGfzkoKN+wS8q0CFT+/EKVtQb84wbqshpKLG8nTjr5aHE1NDC9HwFV3kfpZ34eLX
         5neVvj7HJkbT9GEaDGS1DvMFR9pierQNpy7Mo9fm1WNwGqJHXuSH9maVbLsD84ObSAEb
         2VgDDrltwr4cwzXYGLRLpBkL6P58Bictfr3r4D6gCqq8AmxVE2qJ4DWd6BBlme5Urjns
         UE2Q==
X-Gm-Message-State: AOJu0Yz+RQZf8sUqk36xDbDDM5zoexKCGV2GZloqlVfpYOYuls2v6IQg
	F79J2uXCnwBeI45707Nf0dgeMH3FK7iXHrzPR9UfWRPp0/Dp+cNldbT1Bgedhg==
X-Gm-Gg: ASbGncubeqJuyNrN0qM+aCVWHj0nfsQhvNOLV9g1nrnGX4CliGXGNnYzzs4/rf2OVqe
	PJokQHMuD9wzNbn0XNtz9xT/E6Iw5k0AfH1YtZqLgMJdg/pzVcXiKtJN0W/uMsDsw9D3ituUGQf
	J497h/cyqFXr4Tqovxl4uZu/UMz5EIjBufAIaw6ZcWKX9y2y1kd27nErnMvRoWA1FRtgAzOvl++
	K0VP2XEbMfvfCps/dKumKvNgH5Y3vagIRpSi/61TXVzEiHgMOq2wZaejvccgAsuZWkviGvD/ETU
	O3hzqiDgjtHbdreG8nJRzXxVVjV6N7RgbtyVRNcBFj3EFBojok9l1tMT4qG7ZtesN25b5mUcMYY
	eJCQgeqr078bdtMcBY4d0PYYJR9JJuiykZrNfdkv8DJRqinh70tZ7+HgxWxSzcpY=
X-Google-Smtp-Source: AGHT+IG7+oUT/x2wivj5i79ZvtbWqDckNgaT0MnNEatp9Zr3gEp5qe+9XDyHyWvrkWvuFyDDqRrz+A==
X-Received: by 2002:a05:600c:4f0b:b0:45d:d718:3b9e with SMTP id 5b1f17b1804b1-45f2165e852mr69818555e9.10.1757792031174;
        Sat, 13 Sep 2025 12:33:51 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm4948753f8f.27.2025.09.13.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 12:33:50 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 13/13] selftests/bpf: add selftests for indirect jumps
Date: Sat, 13 Sep 2025 19:39:22 +0000
Message-Id: <20250913193922.1910480-14-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for indirect jumps. All the indirect jumps are
generated from C switch statements, so, if compiled by a compiler
which doesn't support indirect jumps, then should pass as well.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 132 ++++++
 tools/testing/selftests/bpf/progs/bpf_gotox.c | 384 ++++++++++++++++++
 3 files changed, 519 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_gotox.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 11d2a368db3e..606d7d5a48a7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -453,7 +453,9 @@ BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
 	     -I$(abspath $(OUTPUT)/../usr/include)			\
 	     -std=gnu11		 					\
 	     -fno-strict-aliasing 					\
-	     -Wno-compare-distinct-pointer-types
+	     -Wno-compare-distinct-pointer-types			\
+	     -Wno-initializer-overrides					\
+	     #
 # TODO: enable me -Wsign-compare
 
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
new file mode 100644
index 000000000000..90647c080579
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/in6.h>
+#include <linux/udp.h>
+#include <linux/tcp.h>
+
+#include <sys/syscall.h>
+#include <bpf/bpf.h>
+
+#include "bpf_gotox.skel.h"
+
+static void __test_run(struct bpf_program *prog, void *ctx_in, size_t ctx_size_in)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+			    .ctx_in = ctx_in,
+			    .ctx_size_in = ctx_size_in,
+		   );
+	int err, prog_fd;
+
+	prog_fd = bpf_program__fd(prog);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run_opts err");
+}
+
+static void check_simple(struct bpf_gotox *skel,
+			 struct bpf_program *prog,
+			 __u64 ctx_in,
+			 __u64 expected)
+{
+	skel->bss->ret_user = 0;
+
+	__test_run(prog, &ctx_in, sizeof(ctx_in));
+
+	if (!ASSERT_EQ(skel->bss->ret_user, expected, "skel->bss->ret_user"))
+		return;
+}
+
+static void check_simple_fentry(struct bpf_gotox *skel,
+				struct bpf_program *prog,
+				__u64 ctx_in,
+				__u64 expected)
+{
+	skel->bss->in_user = ctx_in;
+	skel->bss->ret_user = 0;
+
+	/* trigger */
+	usleep(1);
+
+	if (!ASSERT_EQ(skel->bss->ret_user, expected, "skel->bss->ret_user"))
+		return;
+}
+
+static void check_gotox_skel(struct bpf_gotox *skel)
+{
+	int i;
+	__u64 in[]   = {0, 1, 2, 3, 4,  5, 77};
+	__u64 out[]  = {2, 3, 4, 5, 7, 19, 19};
+	__u64 out2[] = {103, 104, 107, 205, 115, 1019, 1019};
+	__u64 in3[]  = {0, 11, 27, 31, 22, 45, 99};
+	__u64 out3[] = {2,  3,  4,  5, 19, 19, 19};
+	__u64 in4[]  = {0, 1, 2, 3, 4,  5, 77};
+	__u64 out4[] = {12, 15, 7 , 15, 12, 15, 15};
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.simple_test, in[i], out[i]);
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.simple_test2, in[i], out[i]);
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.two_switches, in[i], out2[i]);
+
+	if (0) for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.big_jump_table, in3[i], out3[i]);
+
+	if (0) for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.one_jump_two_maps, in4[i], out4[i]);
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.use_static_global1, in[i], out[i]);
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.use_static_global2, in[i], out[i]);
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.use_nonstatic_global1, in[i], out[i]);
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.use_nonstatic_global2, in[i], out[i]);
+
+	bpf_program__attach(skel->progs.simple_test_other_sec);
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple_fentry(skel, skel->progs.simple_test_other_sec, in[i], out[i]);
+
+	bpf_program__attach(skel->progs.use_static_global_other_sec);
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple_fentry(skel, skel->progs.use_static_global_other_sec, in[i], out[i]);
+
+	bpf_program__attach(skel->progs.use_nonstatic_global_other_sec);
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple_fentry(skel, skel->progs.use_nonstatic_global_other_sec, in[i], out[i]);
+}
+
+void gotox_skel(void)
+{
+	struct bpf_gotox *skel;
+	int ret;
+
+	skel = bpf_gotox__open();
+	if (!ASSERT_NEQ(skel, NULL, "bpf_gotox__open"))
+		return;
+
+	ret = bpf_gotox__load(skel);
+	if (!ASSERT_OK(ret, "bpf_gotox__load"))
+		return;
+
+	check_gotox_skel(skel);
+
+	bpf_gotox__destroy(skel);
+}
+
+void test_bpf_gotox(void)
+{
+	if (test__start_subtest("gotox_skel"))
+		gotox_skel();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_gotox.c b/tools/testing/selftests/bpf/progs/bpf_gotox.c
new file mode 100644
index 000000000000..72917f34315c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_gotox.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+__u64 in_user;
+__u64 ret_user;
+
+struct simple_ctx {
+	__u64 x;
+};
+
+__u64 some_var;
+
+/*
+ * This function adds code which will be replaced by a different
+ * number of instructions by the verifier. This adds additional
+ * stress on testing the insn_array maps corresponding to indirect jumps.
+ */
+static __always_inline void adjust_insns(__u64 x)
+{
+	some_var ^= x + bpf_jiffies64();
+}
+
+SEC("syscall")
+int simple_test(struct simple_ctx *ctx)
+{
+	switch (ctx->x) {
+	case 0:
+		adjust_insns(ctx->x + 1);
+		ret_user = 2;
+		break;
+	case 1:
+		adjust_insns(ctx->x + 7);
+		ret_user = 3;
+		break;
+	case 2:
+		adjust_insns(ctx->x + 9);
+		ret_user = 4;
+		break;
+	case 3:
+		adjust_insns(ctx->x + 11);
+		ret_user = 5;
+		break;
+	case 4:
+		adjust_insns(ctx->x + 17);
+		ret_user = 7;
+		break;
+	default:
+		adjust_insns(ctx->x + 177);
+		ret_user = 19;
+		break;
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+int simple_test2(struct simple_ctx *ctx)
+{
+	switch (ctx->x) {
+	case 0:
+		adjust_insns(ctx->x + 1);
+		ret_user = 2;
+		break;
+	case 1:
+		adjust_insns(ctx->x + 7);
+		ret_user = 3;
+		break;
+	case 2:
+		adjust_insns(ctx->x + 9);
+		ret_user = 4;
+		break;
+	case 3:
+		adjust_insns(ctx->x + 11);
+		ret_user = 5;
+		break;
+	case 4:
+		adjust_insns(ctx->x + 17);
+		ret_user = 7;
+		break;
+	default:
+		adjust_insns(ctx->x + 177);
+		ret_user = 19;
+		break;
+	}
+
+	return 0;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int simple_test_other_sec(struct pt_regs *ctx)
+{
+	__u64 x = in_user;
+
+	switch (x) {
+	case 0:
+		adjust_insns(x + 1);
+		ret_user = 2;
+		break;
+	case 1:
+		adjust_insns(x + 7);
+		ret_user = 3;
+		break;
+	case 2:
+		adjust_insns(x + 9);
+		ret_user = 4;
+		break;
+	case 3:
+		adjust_insns(x + 11);
+		ret_user = 5;
+		break;
+	case 4:
+		adjust_insns(x + 17);
+		ret_user = 7;
+		break;
+	default:
+		adjust_insns(x + 177);
+		ret_user = 19;
+		break;
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+int two_switches(struct simple_ctx *ctx)
+{
+	switch (ctx->x) {
+	case 0:
+		adjust_insns(ctx->x + 1);
+		ret_user = 2;
+		break;
+	case 1:
+		adjust_insns(ctx->x + 7);
+		ret_user = 3;
+		break;
+	case 2:
+		adjust_insns(ctx->x + 9);
+		ret_user = 4;
+		break;
+	case 3:
+		adjust_insns(ctx->x + 11);
+		ret_user = 5;
+		break;
+	case 4:
+		adjust_insns(ctx->x + 17);
+		ret_user = 7;
+		break;
+	default:
+		adjust_insns(ctx->x + 177);
+		ret_user = 19;
+		break;
+	}
+
+	switch (ctx->x + !!ret_user) {
+	case 1:
+		adjust_insns(ctx->x + 7);
+		ret_user = 103;
+		break;
+	case 2:
+		adjust_insns(ctx->x + 9);
+		ret_user = 104;
+		break;
+	case 3:
+		adjust_insns(ctx->x + 11);
+		ret_user = 107;
+		break;
+	case 4:
+		adjust_insns(ctx->x + 11);
+		ret_user = 205;
+		break;
+	case 5:
+		adjust_insns(ctx->x + 11);
+		ret_user = 115;
+		break;
+	default:
+		adjust_insns(ctx->x + 177);
+		ret_user = 1019;
+		break;
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+int big_jump_table(struct simple_ctx *ctx __attribute__((unused)))
+{
+#if 0
+	const void *const jt[256] = {
+		[0 ... 255] = &&default_label,
+		[0] = &&l0,
+		[11] = &&l11,
+		[27] = &&l27,
+		[31] = &&l31,
+	};
+
+	goto *jt[ctx->x & 0xff];
+
+l0:
+	adjust_insns(ctx->x + 1);
+	ret_user = 2;
+	return 0;
+
+l11:
+	adjust_insns(ctx->x + 7);
+	ret_user = 3;
+	return 0;
+
+l27:
+	adjust_insns(ctx->x + 9);
+	ret_user = 4;
+	return 0;
+
+l31:
+	adjust_insns(ctx->x + 11);
+	ret_user = 5;
+	return 0;
+
+default_label:
+	adjust_insns(ctx->x + 177);
+	ret_user = 19;
+	return 0;
+#else
+	return 0;
+#endif
+}
+
+SEC("syscall")
+int one_jump_two_maps(struct simple_ctx *ctx __attribute__((unused)))
+{
+#if 0
+	__label__ l1, l2, l3, l4;
+	void *jt1[2] = { &&l1, &&l2 };
+	void *jt2[2] = { &&l3, &&l4 };
+	unsigned int a = ctx->x % 2;
+	unsigned int b = (ctx->x / 2) % 2;
+	volatile int ret = 0;
+
+	if (!(a < 2 && b < 2))
+		return 19;
+
+	if (ctx->x % 2)
+		goto *jt1[a];
+	else
+		goto *jt2[b];
+
+	l1: ret += 1;
+	l2: ret += 3;
+	l3: ret += 5;
+	l4: ret += 7;
+
+	ret_user = ret;
+	return ret;
+#else
+	return 0;
+#endif
+}
+
+/* Just to introduce some non-zero offsets in .text */
+static __noinline int f0(volatile struct simple_ctx *ctx __arg_ctx)
+{
+	if (ctx)
+		return 1;
+	else
+		return 13;
+}
+
+SEC("syscall") int f1(struct simple_ctx *ctx)
+{
+	ret_user = 0;
+	return f0(ctx);
+}
+
+static __noinline int __static_global(__u64 x)
+{
+	switch (x) {
+	case 0:
+		adjust_insns(x + 1);
+		ret_user = 2;
+		break;
+	case 1:
+		adjust_insns(x + 7);
+		ret_user = 3;
+		break;
+	case 2:
+		adjust_insns(x + 9);
+		ret_user = 4;
+		break;
+	case 3:
+		adjust_insns(x + 11);
+		ret_user = 5;
+		break;
+	case 4:
+		adjust_insns(x + 17);
+		ret_user = 7;
+		break;
+	default:
+		adjust_insns(x + 177);
+		ret_user = 19;
+		break;
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+int use_static_global1(struct simple_ctx *ctx)
+{
+	ret_user = 0;
+	return __static_global(ctx->x);
+}
+
+SEC("syscall")
+int use_static_global2(struct simple_ctx *ctx)
+{
+	ret_user = 0;
+	adjust_insns(ctx->x + 1);
+	return __static_global(ctx->x);
+}
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int use_static_global_other_sec(void *ctx)
+{
+	return __static_global(in_user);
+}
+
+__noinline int __nonstatic_global(__u64 x)
+{
+	switch (x) {
+	case 0:
+		adjust_insns(x + 1);
+		ret_user = 2;
+		break;
+	case 1:
+		adjust_insns(x + 7);
+		ret_user = 3;
+		break;
+	case 2:
+		adjust_insns(x + 9);
+		ret_user = 4;
+		break;
+	case 3:
+		adjust_insns(x + 11);
+		ret_user = 5;
+		break;
+	case 4:
+		adjust_insns(x + 17);
+		ret_user = 7;
+		break;
+	default:
+		adjust_insns(x + 177);
+		ret_user = 19;
+		break;
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+int use_nonstatic_global1(struct simple_ctx *ctx)
+{
+	ret_user = 0;
+	return __nonstatic_global(ctx->x);
+}
+
+SEC("syscall")
+int use_nonstatic_global2(struct simple_ctx *ctx)
+{
+	ret_user = 0;
+	adjust_insns(ctx->x + 1);
+	return __nonstatic_global(ctx->x);
+}
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int use_nonstatic_global_other_sec(void *ctx)
+{
+	return __nonstatic_global(in_user);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


