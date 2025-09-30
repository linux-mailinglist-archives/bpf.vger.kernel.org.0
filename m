Return-Path: <bpf+bounces-70024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D118BAC8FB
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3992F1C8210
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F83A2FB968;
	Tue, 30 Sep 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9Xz5rrf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA2223702
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229402; cv=none; b=fADf4rc6tLs9TBYpPkuiWxlUfUlbTiswNZHBCJ50cSAiS6WvUW7vTE9hMO4dmrrIdysKVM2XJkDDK7iIyjRBpECSw6Z3yJRzqotCyuzhO91BpEEuwMSMtybLfjEnAyx3vV5yj48lUhwC4qyh7gSuK55UzcsOfwUdqhEqMZVpQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229402; c=relaxed/simple;
	bh=zOqxB7wkOOeLR7MpeUKhMefzhC3vP+PUCefn8/edYmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMWh71CHNI0/Zoe/LamvchxZktyVJX3p0+Mz7H1wWrWJ3JDlqqjO4jhbxVK8w5vYnGR6q4OYmqrD9al84dArF+1AkDEZpalheIFXUyG+6Q8i1woV+Hoezrv0WCZIpYn+MMGc3s7VUzrric0odxIU50tx7/cDzwirYQI6siomCrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9Xz5rrf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ece1102998so3884687f8f.2
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 03:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759229399; x=1759834199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OASLu0pZm0kYutvvpoY2Qna4setUyXoeWW4Ea2W7FeM=;
        b=W9Xz5rrfy5g1znWLsCPf2el+vXKH74mEDIP+HFwO1U+sYkUteNwoqG6THRHaasxPfj
         Xj1kGJ8t2KS6FWaFY1bqku/rzvROzdIiz+fSa9WVI4y/JQwBpwGCo8L3P75fVhD2TtIy
         YUynb4+QsuMJ7TJfrbRN76jpQjOxaDrGZNwO2eCffbQOYDkREgkblGqWXqdFaIVg5k3m
         33nMXx7MxDuSgZzat9nLon6mW85d2JFN4+FbZ1QkBnNvIs0fDX959DbksMFB+ImIXtAX
         2SzgWDS7/H0mslxnP4lKxBCeoe80fP6fdHfuZISmAGBsQhpXuSLpXptRnwpXRr9jOMt/
         CiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229399; x=1759834199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OASLu0pZm0kYutvvpoY2Qna4setUyXoeWW4Ea2W7FeM=;
        b=WRhNBjTMQyBHPLAqAUE/1L3ZUWvFVTaSPFP6RBbfOgQvir5aPoKptwYLe7haTjqiM1
         9HrkFvhRpDVgkwX9SjXTahnRJXtgLA5Y75vlCdW4dWCiM4UToZpWfCapxvAyc91bNMmU
         2kiCUcG5+f1wUrFzgagXzJ0r5xfOnfrFmYLNwn+nkViR830LkEQMjawoyxrIvXKClhFI
         zQ3t8KuIWbbSM96hkbo+HMUmwd/k5rfdQ1movdfaKmyJYECcpwuP2hShFzaHYspWbR9n
         8LlNe6XRIo+IXAhb92hfKXSrOtZwS3GEByukyPrRbL00Zx7KUguusWreYM0Sg0LmKqvB
         efGA==
X-Gm-Message-State: AOJu0YxZmbBaJLjHJacXH6wN8NQ1CVCQ8vDALHxc7lh7sxbwk1rlcUup
	ujx6iYhIsU1lQNS5tboSDqzWVjSerQ9Ls+OjYWrjrzPO5YTtO9LwKtQ11wfzvg==
X-Gm-Gg: ASbGncs22h1Fo/Y+/F4i77byLFAXL20gve6RTBaPkIrLxejQOUHIq4QnKqlHpKimdvX
	wpY9A9CuZcB/pXIcvcrI3qemhgKUSvH1XJw4E9xnkYlEExx2ZYbPt33tfn/37i37BBsG9tEHVdA
	lKUQXvpwox1pNkiRtmXGXV9ucwzZisEy4a/kFKY0bPZIgz2Xgr0yu4UiRBogSoXtpvLEpEcTuCU
	+Cc1QaYDWu3MX6dqm/uoSGUExkkyaciK9sh+xoRKbJTvJwcbGM815BGA8Z84H3uvrtlSTqb4oHh
	ilWwQVCUhD+WT3Se7Zo5qL3r3r7gnFS2OTD+RdCNL5BFq3V1GG6FVhL6PiKCWkMEBQoU7Ek4fvU
	h13zV8ZzBXlRZq0tgr+PqiEi2/nnrYcJMVitVBBATLpWH3btfh8fy75XgQKkNxhCLWg==
X-Google-Smtp-Source: AGHT+IFYmVfoazW0x9Z1XrVwgPM9SzdMkvUHfmliPxBiC+ahFjX0neHpw2LpDhLwkPEUf70xeuVAcw==
X-Received: by 2002:a5d:5d07:0:b0:3d0:3eae:576d with SMTP id ffacd0b85a97d-40e437370afmr18909266f8f.22.1759229398700;
        Tue, 30 Sep 2025 03:49:58 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm21982161f8f.33.2025.09.30.03.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:49:57 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 15/15] selftests/bpf: add selftests for indirect jumps
Date: Tue, 30 Sep 2025 10:55:23 +0000
Message-Id: <20250930105523.1014140-16-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
References: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
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
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 177 ++++++++
 tools/testing/selftests/bpf/progs/bpf_gotox.c | 411 ++++++++++++++++++
 3 files changed, 591 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_gotox.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0b6ee902bce5..d208a53b7aec 100644
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
index 000000000000..199aa4c50678
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
@@ -0,0 +1,177 @@
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
diff --git a/tools/testing/selftests/bpf/progs/bpf_gotox.c b/tools/testing/selftests/bpf/progs/bpf_gotox.c
new file mode 100644
index 000000000000..4aa4bf251442
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_gotox.c
@@ -0,0 +1,411 @@
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
+SEC("syscall")
+int one_map_two_jumps(struct simple_ctx *ctx __attribute__((unused)))
+{
+#if 0
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


