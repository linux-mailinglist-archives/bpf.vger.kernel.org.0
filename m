Return-Path: <bpf+bounces-72269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEA3C0B118
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DDD3B1659
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 19:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CD6261581;
	Sun, 26 Oct 2025 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU2IKPRg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708C2FE04B
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506454; cv=none; b=czPmNesZInfWJy0+W/sF8hePxPQP5FVLOx4p4PWncfqLvcGbizU5v6plfhKnwdqjxHJ1WYw7TmbrkcOyIu0PvIYxHOlCpdj8r0v3+DJakdygP2lzgSREniup5erZSf1Kpd3cZ3Rg/8Bo5qOKrdgHrUrhjyBLQYniVXFU5km+SGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506454; c=relaxed/simple;
	bh=Bp+FnsP1wAW8DK15oxvCaOxtNWT+XxvMtuKwtjhPbhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2HhYMAYphxf04VF05dahdq8LyTWOEbEHiH5yRTmRwLwVT0x4G0mJmzxNljWkOKLngSSCQdZyMaIeZ1/Ls1+GyvrtB1QBUDqXHsrq+cehLRaiMJaz2kZEvbVuFK3wML/5Kgr5VKTO//i8BIXps5u5569oXUJYJcI/EprG1JwDkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU2IKPRg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4711b95226dso46454495e9.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 12:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761506450; x=1762111250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5Ju/VSJ0D/h26aATaUOZIgX79vwM2wkSuQMVwA31M8=;
        b=EU2IKPRgXN68inytZf6wrlmtqbFdh+vYm3PuFphuFK6CgO1Wplz/j07zExa8tXzfFw
         lj0WnBkd3/unyuNaomVetn9cL4o9KVal0DfjxDZXynofXK82ZOZoB4zACK+ajYbwf83r
         tusOaAu36ZA9DvOCsbFOFKrNXc5/F6KGsTpu5GBxxzgsMcxp6EV7QMgNh/WXYT0Qjw6P
         BiTX6Gdf+pT/W8Apq1ZrPbAMbJeM1hySxp7+6IRd/9QZhgizn9aCQ3N8VRfu6dsR+5bK
         TYi003OUDtaFMQft94BNN/7pSWl8iX8W6NvTQmEJzuG6s4v9eAievMqtv+m4ZbYDqH3x
         fLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761506450; x=1762111250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5Ju/VSJ0D/h26aATaUOZIgX79vwM2wkSuQMVwA31M8=;
        b=s0Z4GAOoheEk131k0jrUKyyihzTe/iQUJAp7iN7RBP2Y8/BeAAxKhP24G2kscIHGKr
         ueKBrhdstSvJf55Nc8FVJ1vT/yToRNR4ALb8xvte5c6JKY24ZDroe/7wYA7kmhaO65Pf
         xYsJd/r5iR12CrKRiyGU0/yGj9GjnDSGCl8JNtfR24jJJCpwdgNVmxmOGSrHensam9gE
         1FZ0W0q26vcdUFwQnIzigmR8axWrTxp6TtJP7KshJD6WJvx8alyj4+B80qc6EpQu5wMi
         jbWjfmtvynPFjYSAo3Ix6esXapKZN0oLJg4O18pRanLNKY1OlnNd7C0kewRSfnidWtYm
         IO2A==
X-Gm-Message-State: AOJu0YzANu7qdZ8z9Xs0x+2LoRpFy+cCNgDyhKY+NPm9Iiex4Vun9PO7
	Ku/IzYKObmqd6wnpm+NGwHLsV9COSDBoXLL+XBX/kPgY+2ROG6h0D8IKepgApg==
X-Gm-Gg: ASbGnctTOcvxMYy7/VkBhLCRaMeZMESSXjatpWEufV4aDOihkFWCF1dDh4tI7G0h7TH
	OGA/T8jKAhMwwZ6x6+Q7S9GFMTO5sYbO7Q5jgJdeTTbgaIvG2kWAGNjw2vYddKXWSJvQxKFKbBa
	6jCElC3hG9MS6wzW+FGkWgH3MXzkRZOPuzBgLbke/xSfbQFA5CRUd7OuJWwvQe9xc5YNYb1ZMaI
	P1j3Z5Nm/KtNxbZSWof7oaRy0wg6OlluLgDFZHf6C/6GbUa0Qb1odXQ0tTk+TfLz2lS0RF3sgAH
	1N9a+lBLuCWXsdVVfDDY8l5ROVjZhFPHCEV0/aX9jUthi7ww03ZA8kvJ67pj8OcnWD7UjID4eWe
	7ztPg1mYmptu/4YwcCfdrmsRYqYywEzxO7tXiaH6a1S7dVG6hxAXYUCQknokIeKXoqou4fON5TQ
	6N5PvyW1xvkNEd9lS0EOg=
X-Google-Smtp-Source: AGHT+IG4pWUer9yO1GmtudAx7BV4fvHdtvzEvzc4vXDtlYrxdKL1oLswgAmWuG3zSe8n6ghusImBAQ==
X-Received: by 2002:a05:600c:524f:b0:46e:4c67:ff17 with SMTP id 5b1f17b1804b1-471178a6fa9mr239595485e9.14.1761506449808;
        Sun, 26 Oct 2025 12:20:49 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4894c9sm92434375e9.5.2025.10.26.12.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:20:48 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 12/12] selftests/bpf: add C-level selftests for indirect jumps
Date: Sun, 26 Oct 2025 19:27:09 +0000
Message-Id: <20251026192709.1964787-13-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add C-level selftests for indirect jumps to validate LLVM and libbpf
functionality. The tests are intentionally disabled, to be run
locally by developers, but will not make the CI red.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 185 ++++++++
 tools/testing/selftests/bpf/progs/bpf_gotox.c | 402 ++++++++++++++++++
 3 files changed, 590 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_gotox.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7437c325179e..a897cb31fe6d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -454,7 +454,9 @@ BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
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
index 000000000000..4394654ac75a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
@@ -0,0 +1,185 @@
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
+/* Disable tests for now, as CI runs with LLVM-20 */
+#if 0
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
+/* validate that for two loads of the same jump table libbpf generates only one map */
+static void check_one_map_two_jumps(struct bpf_gotox *skel)
+{
+	struct bpf_prog_info prog_info;
+	struct bpf_map_info map_info;
+	__u32 len;
+	__u32 map_ids[16];
+	int prog_fd, map_fd;
+	int ret;
+	int i;
+	bool seen = false;
+
+	memset(&prog_info, 0, sizeof(prog_info));
+	prog_info.map_ids = (long)map_ids;
+	prog_info.nr_map_ids = ARRAY_SIZE(map_ids);
+	prog_fd = bpf_program__fd(skel->progs.one_map_two_jumps);
+	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd(one_map_two_jumps)"))
+		return;
+
+	len = sizeof(prog_info);
+	ret = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &len);
+	if (!ASSERT_OK(ret, "bpf_obj_get_info_by_fd(prog_fd)"))
+		return;
+
+	for (i = 0; i < prog_info.nr_map_ids; i++) {
+		map_fd  = bpf_map_get_fd_by_id(map_ids[i]);
+		if (!ASSERT_GE(map_fd, 0, "bpf_program__fd(one_map_two_jumps)"))
+			return;
+
+		len = sizeof(map_info);
+		memset(&map_info, 0, len);
+		ret = bpf_obj_get_info_by_fd(map_fd, &map_info, &len);
+		if (!ASSERT_OK(ret, "bpf_obj_get_info_by_fd(map_fd)")) {
+			close(map_fd);
+			return;
+		}
+
+		if (map_info.type == BPF_MAP_TYPE_INSN_ARRAY) {
+			if (!ASSERT_EQ(seen, false, "more than one INSN_ARRAY map")) {
+				close(map_fd);
+				return;
+			}
+			seen = true;
+		}
+		close(map_fd);
+	}
+
+	ASSERT_EQ(seen, true, "no INSN_ARRAY map");
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
+
+	if (0) check_one_map_two_jumps(skel);
+}
+
+void test_bpf_gotox(void)
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
+#else
+void test_bpf_gotox(void)
+{
+}
+#endif
diff --git a/tools/testing/selftests/bpf/progs/bpf_gotox.c b/tools/testing/selftests/bpf/progs/bpf_gotox.c
new file mode 100644
index 000000000000..3c8ee363bda1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_gotox.c
@@ -0,0 +1,402 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+/* Disable tests for now, as CI runs with LLVM-20 */
+#if 0
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
+}
+
+SEC("syscall")
+int one_jump_two_maps(struct simple_ctx *ctx __attribute__((unused)))
+{
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
+}
+
+SEC("syscall")
+int one_map_two_jumps(struct simple_ctx *ctx __attribute__((unused)))
+{
+	__label__ l1, l2, l3;
+	void *jt[3] = { &&l1, &&l2, &&l3 };
+	unsigned int a = (ctx->x >> 2) & 1;
+	unsigned int b = (ctx->x >> 3) & 1;
+	volatile int ret = 0;
+
+	if (ctx->x % 2)
+		goto *jt[a];
+
+	if (ctx->x % 3)
+		goto *jt[a + b];
+
+	l1: ret += 3;
+	l2: ret += 5;
+	l3: ret += 7;
+
+	ret_user = ret;
+	return ret;
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
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


