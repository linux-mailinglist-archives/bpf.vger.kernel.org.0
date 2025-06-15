Return-Path: <bpf+bounces-60682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5168ADA166
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 10:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE9C3B394A
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E73E264A7F;
	Sun, 15 Jun 2025 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjihCgUo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BFE265CDE
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749977741; cv=none; b=Z9LKnAEW2Qr/BR9w7ko2/ISwb/+jmWgqL6r1csrrqRaqdZjowUF5Z4ZFZQIGkChc5E5Y5umpESFxQXJ6noCWUU6/AL1EJckT9+wSt4pz0u1AsYc+LwkadkVZMw1Wx9Pq8gmwkOCf6e6SP+zMiEpZxh6xf3OiYeLpjItj7HWpJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749977741; c=relaxed/simple;
	bh=BjV6VX3aEqGku8JZ1R3IIc57MFMJt9ApK5LWY+Zxvqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNAbE5beokSn0CfUcxUqU/e4ochRzySrlKYROgMw3xDTnGKr3BXg5QMwoNDS6V4BFf79r+u6i45wR/nOlNr/2KfaROS1NSZAneeE5NAsLdPspt9APlMttPxuHKIoec9bN3IyQ4gHGWO8o5FS9KM9knbybfnTgIjizPGR59v9MMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjihCgUo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450ce671a08so20898575e9.3
        for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 01:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749977736; x=1750582536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lvX8Q7q2MTqtnMhUfCeuIQbry4UE85BLmBMw8geBBg=;
        b=UjihCgUo40Tupm8eD5wGpfGcu4ZyGPVc5UsdHem3OxrkT418ZotnBnLA4hXxlK+5dk
         o5hj/loMk4Psq8YFBsIVSYO1hTUqJn0wtCPX37l9CG+hFDCraXAuGb1ql0NR6If4jgpK
         xGKwtviiTTHoFauBlk6eSQzfz6G9qgmQuiUtzUeNO5zBK3pV4/yc69nlz7Y/V++CDc0+
         FyaPEAOvzXdyZbjJLEUuTkXn+LV2ol7uzKM7K8BlnoeQKT3jo3Ct5K0KBIPbUz208kE/
         jTLsQTIV49vAi319jTctfxTYOfSNCq95nvPlclhtlQCNDDxfJ7LSYk1o1TntPd1TTt1W
         Du2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749977736; x=1750582536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lvX8Q7q2MTqtnMhUfCeuIQbry4UE85BLmBMw8geBBg=;
        b=B2fP6wL0q+PcPtq3q9zwOGW8Kfj8fbx8sSfzPzBGpnFNLo4yeg4mwzT29jkcY9ohmH
         ddw3Mc67ttbDRy9l9GvBph2AQWRvDgMfTD+3ydjv9ILxYzgGPO8RczLfpLjw2iNL3CyI
         eQCRy/gUED2kbhrZTbMlBPdSN0os8fX+ewqNxVVs0pCAOFm6T7aICgBp5BAGbY+Na4fg
         P3SlfAC3joTzWY9tV4QKtBZNwOCPtM0ogvTQbNePU+epusXGYo/Ar1pX1YTbc9KIf4tA
         TuM7ND2jdRpMp9GyHkZrKxl2Z6B8CWUEpsQm9gnOdfoXC6Ujke/VImDI9neH4AjpgSyV
         VSnw==
X-Gm-Message-State: AOJu0Yza0PuEeCuIiIMZRUK4QIpUT5BUTCX9OaumX6R2GyqT1KWxur/8
	HPVgEcVyjNVlWtmGl+LOjcZLAOnDIwwInNn4GtjC3x1Ttg7gbX6zQsTgoMrIng==
X-Gm-Gg: ASbGnct+F7Dxxxp5IagPIlgdc9jrpdfaC6fZ08AaseE9k4P8OuLCda6j8MQ0Q6s6zFC
	dYwlfmNKnNChia3ATiQiNOtXDUJenYphtSOmStQM/XTZBuiFt7+HSs1brPYH/cUU/NhRKR3I6j/
	aCGGGpjB5lNBlQjM6kiV9KxJABbpfh4UvtBP52qaUZ4FWky4fWeuIjaiQhcvX1o2kUf6CM4lRLY
	TZCptFR1MNBJVg59x1+Hy+VvYHWcOLj/0X4ggxKP5z8ubvnPhEx4XbP5cvADcakPAMxyNqNXj7q
	n7eEKkS7odmljJeZq0HPDK6MM+5BRQg2JtMX2yA33086dOK3fPlWeWOQBILNOs/Pr3kXHKczed2
	3ZTvnmENgUy37j8R7
X-Google-Smtp-Source: AGHT+IHw1SCOix0RZWxo4SaRMUeBWObM5vR19MLt7VgfCrVsBSSA8bWfdPSZ7XthzvhEhDfXZyopNg==
X-Received: by 2002:a05:600c:3496:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-4533caf507fmr51478395e9.9.1749977736304;
        Sun, 15 Jun 2025 01:55:36 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm7196105f8f.26.2025.06.15.01.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 01:55:35 -0700 (PDT)
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
Subject: [RFC bpf-next 9/9] selftests/bpf: add selftests for indirect jumps
Date: Sun, 15 Jun 2025 08:59:43 +0000
Message-Id: <20250615085943.3871208-10-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
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
 .../selftests/bpf/prog_tests/bpf_goto_x.c     | 127 +++++++
 .../testing/selftests/bpf/progs/bpf_goto_x.c  | 336 ++++++++++++++++++
 3 files changed, 466 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_goto_x.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_goto_x.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 97013c49920b..53ec703ba713 100644
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
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_goto_x.c b/tools/testing/selftests/bpf/prog_tests/bpf_goto_x.c
new file mode 100644
index 000000000000..15781b6f8249
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_goto_x.c
@@ -0,0 +1,127 @@
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
+#include "bpf_goto_x.skel.h"
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
+static void check_simple(struct bpf_goto_x *skel,
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
+static void check_simple_fentry(struct bpf_goto_x *skel,
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
+static void check_goto_x_skel(struct bpf_goto_x *skel)
+{
+	int i;
+	__u64 in[]   = {0, 1, 2, 3, 4,  5, 77};
+	__u64 out[]  = {2, 3, 4, 5, 7, 19, 19};
+	__u64 out2[] = {103, 104, 107, 205, 115, 1019, 1019};
+	__u64 in3[]  = {0, 11, 27, 31, 447, 22, 45, 999};
+	__u64 out3[] = {2,  3,  4,  5,   7, 19, 19,  19};
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.simple_test, in[i], out[i]);
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.simple_test2, in[i], out[i]);
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.two_towers, in[i], out2[i]);
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.the_return_of_the_king, in3[i], out3[i]);
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
+void goto_x_skel(void)
+{
+	struct bpf_goto_x *skel;
+	int ret;
+
+	skel = bpf_goto_x__open();
+	if (!ASSERT_NEQ(skel, NULL, "bpf_goto_x__open"))
+		return;
+
+	ret = bpf_goto_x__load(skel);
+	if (!ASSERT_OK(ret, "bpf_goto_x__load"))
+		return;
+
+	check_goto_x_skel(skel);
+
+	bpf_goto_x__destroy(skel);
+}
+
+void test_bpf_goto_x(void)
+{
+	if (test__start_subtest("goto_x_skel"))
+		goto_x_skel();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_goto_x.c b/tools/testing/selftests/bpf/progs/bpf_goto_x.c
new file mode 100644
index 000000000000..ebe4239cfd24
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_goto_x.c
@@ -0,0 +1,336 @@
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
+SEC("syscall")
+int simple_test(struct simple_ctx *ctx)
+{
+	switch (ctx->x) {
+	case 0:
+		bpf_printk("%lu\n", ctx->x + 1);
+		ret_user = 2;
+		break;
+	case 1:
+		bpf_printk("%lu\n", ctx->x + 7);
+		ret_user = 3;
+		break;
+	case 2:
+		bpf_printk("%lu\n", ctx->x + 9);
+		ret_user = 4;
+		break;
+	case 3:
+		bpf_printk("%lu\n", ctx->x + 11);
+		ret_user = 5;
+		break;
+	case 4:
+		bpf_printk("%lu\n", ctx->x + 17);
+		ret_user = 7;
+		break;
+	default:
+		bpf_printk("%lu\n", ctx->x + 177);
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
+		bpf_printk("%lu\n", ctx->x + 1);
+		ret_user = 2;
+		break;
+	case 1:
+		bpf_printk("%lu\n", ctx->x + 7);
+		ret_user = 3;
+		break;
+	case 2:
+		bpf_printk("%lu\n", ctx->x + 9);
+		ret_user = 4;
+		break;
+	case 3:
+		bpf_printk("%lu\n", ctx->x + 11);
+		ret_user = 5;
+		break;
+	case 4:
+		bpf_printk("%lu\n", ctx->x + 17);
+		ret_user = 7;
+		break;
+	default:
+		bpf_printk("%lu\n", ctx->x + 177);
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
+		bpf_printk("%lu\n", x + 1);
+		ret_user = 2;
+		break;
+	case 1:
+		bpf_printk("%lu\n", x + 7);
+		ret_user = 3;
+		break;
+	case 2:
+		bpf_printk("%lu\n", x + 9);
+		ret_user = 4;
+		break;
+	case 3:
+		bpf_printk("%lu\n", x + 11);
+		ret_user = 5;
+		break;
+	case 4:
+		bpf_printk("%lu\n", x + 17);
+		ret_user = 7;
+		break;
+	default:
+		bpf_printk("%lu\n", x + 177);
+		ret_user = 19;
+		break;
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+int two_towers(struct simple_ctx *ctx)
+{
+	switch (ctx->x) {
+	case 0:
+		bpf_printk("%lu\n", ctx->x + 1);
+		ret_user = 2;
+		break;
+	case 1:
+		bpf_printk("%lu\n", ctx->x + 7);
+		ret_user = 3;
+		break;
+	case 2:
+		bpf_printk("%lu\n", ctx->x + 9);
+		ret_user = 4;
+		break;
+	case 3:
+		bpf_printk("%lu\n", ctx->x + 11);
+		ret_user = 5;
+		break;
+	case 4:
+		bpf_printk("%lu\n", ctx->x + 17);
+		ret_user = 7;
+		break;
+	default:
+		bpf_printk("%lu\n", ctx->x + 177);
+		ret_user = 19;
+		break;
+	}
+
+	switch (ctx->x + !!ret_user) {
+	case 0: /* never happens */
+		bpf_printk("%lu\n", ctx->x + 1);
+		ret_user = 102;
+		break;
+	case 1:
+		bpf_printk("%lu\n", ctx->x + 7);
+		ret_user = 103;
+		break;
+	case 2:
+		bpf_printk("%lu\n", ctx->x + 9);
+		ret_user = 104;
+		break;
+	case 3:
+		bpf_printk("%lu\n", ctx->x + 11);
+		ret_user = 107;
+		break;
+	case 4:
+		bpf_printk("%lu\n", ctx->x + 11);
+		ret_user = 205;
+		break;
+	case 5:
+		bpf_printk("%lu\n", ctx->x + 11);
+		ret_user = 115;
+		break;
+	default:
+		bpf_printk("%lu\n", ctx->x + 177);
+		ret_user = 1019;
+		break;
+	}
+
+	return 0;
+}
+
+/* this actually creates a big insn_set map */
+SEC("syscall")
+int the_return_of_the_king(struct simple_ctx *ctx)
+{
+	switch (ctx->x) {
+	case 0:
+		bpf_printk("%lu\n", ctx->x + 1);
+		ret_user = 2;
+		break;
+	case 11:
+		bpf_printk("%lu\n", ctx->x + 7);
+		ret_user = 3;
+		break;
+	case 27:
+		bpf_printk("%lu\n", ctx->x + 9);
+		ret_user = 4;
+		break;
+	case 31:
+		bpf_printk("%lu\n", ctx->x + 11);
+		ret_user = 5;
+		break;
+	case 447:
+		bpf_printk("%lu\n", ctx->x + 17);
+		ret_user = 7;
+		break;
+	default:
+		bpf_printk("%lu\n", ctx->x + 177);
+		ret_user = 19;
+		break;
+	}
+
+	return 0;
+}
+
+/* Just to introduce some non-zero offsets in .text */
+static __noinline int i_am_a_little_tiny_foo(volatile struct simple_ctx *ctx __arg_ctx)
+{
+	if (ctx)
+		return 1;
+	else
+		return 13;
+}
+
+SEC("syscall") int just_me(struct simple_ctx *ctx)
+{
+	ret_user = 0;
+	return i_am_a_little_tiny_foo(ctx);
+}
+
+static __noinline int __static_global(__u64 x)
+{
+	switch (x) {
+	case 0:
+		bpf_printk("%lu\n", x + 1);
+		ret_user = 2;
+		break;
+	case 1:
+		bpf_printk("%lu\n", x + 7);
+		ret_user = 3;
+		break;
+	case 2:
+		bpf_printk("%lu\n", x + 9);
+		ret_user = 4;
+		break;
+	case 3:
+		bpf_printk("%lu\n", x + 11);
+		ret_user = 5;
+		break;
+	case 4:
+		bpf_printk("%lu\n", x + 17);
+		ret_user = 7;
+		break;
+	default:
+		bpf_printk("%lu\n", x + 177);
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
+	bpf_printk("%lu\n", ctx->x + 1);
+	return __static_global(ctx->x);
+}
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int use_static_global_other_sec(void *ctx)
+{
+	return __static_global(in_user);
+}
+
+__noinline int __gobble_till_you_global(__u64 x)
+{
+	switch (x) {
+	case 0:
+		bpf_printk("%lu\n", x + 1);
+		ret_user = 2;
+		break;
+	case 1:
+		bpf_printk("%lu\n", x + 7);
+		ret_user = 3;
+		break;
+	case 2:
+		bpf_printk("%lu\n", x + 9);
+		ret_user = 4;
+		break;
+	case 3:
+		bpf_printk("%lu\n", x + 11);
+		ret_user = 5;
+		break;
+	case 4:
+		bpf_printk("%lu\n", x + 17);
+		ret_user = 7;
+		break;
+	default:
+		bpf_printk("%lu\n", x + 177);
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
+	return __gobble_till_you_global(ctx->x);
+}
+
+SEC("syscall")
+int use_nonstatic_global2(struct simple_ctx *ctx)
+{
+	ret_user = 0;
+	bpf_printk("%lu\n", ctx->x + 1);
+	return __gobble_till_you_global(ctx->x);
+}
+
+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int use_nonstatic_global_other_sec(void *ctx)
+{
+	return __gobble_till_you_global(in_user);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


