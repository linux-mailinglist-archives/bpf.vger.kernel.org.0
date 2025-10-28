Return-Path: <bpf+bounces-72548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D11C1524F
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186451C261E7
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104B2338922;
	Tue, 28 Oct 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY1jGdSK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C97335BAA
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660926; cv=none; b=curpCpX1KYChtr+jJnWG4C8SSefVQRDKDVUc3U5eJFwnTyEs9Vh4O9xZhcUMQK+0Gi7eKCE9GyrVNV5NxT/kho3zQTeDjGib9H6f0q5s7V8Ypdui5nZLpYlifilr1daHyFI1dmuAbcgS1DkXPfTXJgs1QeGWeXbICQV+uPe/Vow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660926; c=relaxed/simple;
	bh=u/YRBo0mNlwRgcKuRRUm2gUwTc1lC/qTW3hapDJXZtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZfkW3C0HPNg8IQoDrJ6135En0kiM4OjuRiblDLVlx4KQiFv1Cw3DeF4uLqoiz+1ixlkj4v10XkAWlKUNEWY2l9YSilnKQ6R2EgfeACFkKyGMDr71hpQuwYfNu19Zb/i3dbm1z9qZX6CjqwPCuchHD4knGIvhNT5AOAPDioSxbeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY1jGdSK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso22550755e9.3
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660920; x=1762265720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bxFckOsCujyFJFAZ8SNJN6YGWIfK/PRTloiFH2veRc=;
        b=KY1jGdSKhORa3hd69Ii7DMTcUkNc3eyQ/9SyRnu6RgNqC0yfW4cw11Fcsj4HbslfrW
         k6T91o1bWeDqvwbdJj87fj9OnuyvuTXbkAd3J6IEh6qbJph5R7ugmnTpgCnfZefUPra4
         mrW85iSKR7VVuo8CXkmrpbwAqJ1TJewyQ3SxJ5FXsdZRO47JTqRwE87bWYvFyp3cFreJ
         AXE9wj93cstUOOUyBJVnMEy4FV+EsjpSe/7q81PlXZeAV2CKYq9BCTVC7TQ7Ijwy10it
         aeLl0mpZVTsFKjKM7VPGFifWj19aSReCrWGN0dK+Hl78TmYJrEEjR+7rFax7CLD61VzH
         k5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660920; x=1762265720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bxFckOsCujyFJFAZ8SNJN6YGWIfK/PRTloiFH2veRc=;
        b=kePjuPEA46iTV3/MGBN5IMwxf1k2nkYHDbEdZ2ZxKaFy3Wm50KmXam9QThkr99yWxh
         eO3enPf6IacmpLsHoPpHecXf/NRLK//TlUbqI94RLmie4ieU3tB8ihvce/KGBmBMbOKM
         hoJoYki3CMdzt2ltMdL4T3x/9RRwikb9tblyFwRN9iruN3hzxs656XsydfnSO5I8cd8i
         KDPodg/mYpOr4NptFY/3G68EK9s9QBQEAQYCBo8noDtuZucou9b9bIlm23hsw9M9idOW
         cvE38+Uyxray3+akCcVck+UMaRYtwtu1a/PV2Wngg4MB9RmxHCTzoyL3nyq7AsXxoMSA
         pbMg==
X-Gm-Message-State: AOJu0Yw3PCL2iofoQVk71jiqztvCIy+HmrkH6rlj3ZElpOUXLUFgdqot
	MBqSUvbAsmJqhrASkZZQOzXUNw7UVqUiEnTeFMsasTYox+ZtRm8If5cnSdwVTQ==
X-Gm-Gg: ASbGnctTg3VxjWTg5HH088sJbGbG0kwVGDHcjUXbLgRbFaoQkuMD1VBJpvHbRXvn0an
	SU0tAM+d3jmp58sgyPPk7qQ3Ni6Fm3C41Ozr7FMr5tB4b5iI1ZRDkad8w6zVigj+qB4s5JLuMvM
	uWiUObZ3uzzomykHd73dC8GQHQyM9A586ebGg96W1nBFYdZl0PUB4bc+3f/On7yUzW+fE/AtxJd
	GY/M/wEZVM2KS84CZA/JphVo2hdr8lOvR9+BtYsZr4sJyA739x+MYORdpxeXtEIkPRefkNyGkSF
	Rd1bHE/c90ExOfZTlvenLhzb1xH85ABnAiNPiZy3B7vISZ7UYbAsyyj4tQz+WaPaILqTEsOnTK8
	Sl9Kto94FrS9LrpK9oW0sbFnTxzphzKEJnpyPezexMOQpSS5Q5Cf5FmiK5SLgrjv6MfW1G2l8RL
	fkPS9ucwzWCShXbssKQfs=
X-Google-Smtp-Source: AGHT+IF+nMlhDli42ogYJJnwoYxlb4JhIOoLbFZ7JEptURI58AN3RFsbyN3g0DvIv01lvDojwMasxg==
X-Received: by 2002:a05:600c:4747:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-47717e6ab35mr28700565e9.33.1761660920115;
        Tue, 28 Oct 2025 07:15:20 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm20867060f8f.21.2025.10.28.07.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:15:19 -0700 (PDT)
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
Subject: [PATCH v8 bpf-next 11/11] selftests/bpf: add C-level selftests for indirect jumps
Date: Tue, 28 Oct 2025 14:20:49 +0000
Message-Id: <20251028142049.1324520-12-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
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
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 276 ++++++++++++
 tools/testing/selftests/bpf/progs/bpf_gotox.c | 401 ++++++++++++++++++
 3 files changed, 680 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_gotox.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 64997fa47053..d418863b2fb5 100644
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
index 000000000000..bb0ebd16df43
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
@@ -0,0 +1,276 @@
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
+static void check_one_switch(struct bpf_gotox *skel)
+{
+	__u64 in[]   = {0, 1, 2, 3, 4,  5, 77};
+	__u64 out[]  = {2, 3, 4, 5, 7, 19, 19};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.one_switch, in[i], out[i]);
+}
+
+static void check_one_switch_non_zero_sec_off(struct bpf_gotox *skel)
+{
+	__u64 in[]   = {0, 1, 2, 3, 4,  5, 77};
+	__u64 out[]  = {2, 3, 4, 5, 7, 19, 19};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.one_switch_non_zero_sec_off, in[i], out[i]);
+}
+
+static void check_two_switches(struct bpf_gotox *skel)
+{
+	__u64 in[]   = {0, 1, 2, 3, 4,  5, 77};
+	__u64 out[] = {103, 104, 107, 205, 115, 1019, 1019};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.two_switches, in[i], out[i]);
+}
+
+static void check_big_jump_table(struct bpf_gotox *skel)
+{
+	__u64 in[]  = {0, 11, 27, 31, 22, 45, 99};
+	__u64 out[] = {2,  3,  4,  5, 19, 19, 19};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.big_jump_table, in[i], out[i]);
+}
+
+static void check_one_jump_two_maps(struct bpf_gotox *skel)
+{
+	__u64 in[]  = {0, 1, 2, 3, 4,  5, 77};
+	__u64 out[] = {12, 15, 7 , 15, 12, 15, 15};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.one_jump_two_maps, in[i], out[i]);
+}
+
+static void check_static_global(struct bpf_gotox *skel)
+{
+	__u64 in[]   = {0, 1, 2, 3, 4,  5, 77};
+	__u64 out[]  = {2, 3, 4, 5, 7, 19, 19};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.use_static_global1, in[i], out[i]);
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.use_static_global2, in[i], out[i]);
+}
+
+static void check_nonstatic_global(struct bpf_gotox *skel)
+{
+	__u64 in[]   = {0, 1, 2, 3, 4,  5, 77};
+	__u64 out[]  = {2, 3, 4, 5, 7, 19, 19};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.use_nonstatic_global1, in[i], out[i]);
+
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.use_nonstatic_global2, in[i], out[i]);
+}
+
+static void check_other_sec(struct bpf_gotox *skel)
+{
+	__u64 in[]   = {0, 1, 2, 3, 4,  5, 77};
+	__u64 out[]  = {2, 3, 4, 5, 7, 19, 19};
+	int i;
+
+	bpf_program__attach(skel->progs.simple_test_other_sec);
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple_fentry(skel, skel->progs.simple_test_other_sec, in[i], out[i]);
+}
+
+static void check_static_global_other_sec(struct bpf_gotox *skel)
+{
+	__u64 in[]   = {0, 1, 2, 3, 4,  5, 77};
+	__u64 out[]  = {2, 3, 4, 5, 7, 19, 19};
+	int i;
+
+	bpf_program__attach(skel->progs.use_static_global_other_sec);
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple_fentry(skel, skel->progs.use_static_global_other_sec, in[i], out[i]);
+}
+
+static void check_nonstatic_global_other_sec(struct bpf_gotox *skel)
+{
+	__u64 in[]   = {0, 1, 2, 3, 4,  5, 77};
+	__u64 out[]  = {2, 3, 4, 5, 7, 19, 19};
+	int i;
+
+	bpf_program__attach(skel->progs.use_nonstatic_global_other_sec);
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple_fentry(skel, skel->progs.use_nonstatic_global_other_sec, in[i], out[i]);
+}
+
+static void __test_bpf_gotox(void)
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
+	if (test__start_subtest("one-switch"))
+		check_one_switch(skel);
+
+	if (test__start_subtest("one-switch-non-zero-sec-offset"))
+		check_one_switch_non_zero_sec_off(skel);
+
+	if (test__start_subtest("two-switches"))
+		check_two_switches(skel);
+
+	if (test__start_subtest("big-jump-table"))
+		check_big_jump_table(skel);
+
+	if (test__start_subtest("static-global"))
+		check_static_global(skel);
+
+	if (test__start_subtest("nonstatic-global"))
+		check_nonstatic_global(skel);
+
+	if (test__start_subtest("other-sec"))
+		check_other_sec(skel);
+
+	if (test__start_subtest("static-global-other-sec"))
+		check_static_global_other_sec(skel);
+
+	if (test__start_subtest("nonstatic-global-other-sec"))
+		check_nonstatic_global_other_sec(skel);
+
+	if (test__start_subtest("one-jump-two-maps"))
+		check_one_jump_two_maps(skel);
+
+	if (test__start_subtest("one-map-two-jumps"))
+		check_one_map_two_jumps(skel);
+
+	bpf_gotox__destroy(skel);
+}
+#else
+static void __test_bpf_gotox(void)
+{
+	test__skip();
+}
+#endif
+
+void test_bpf_gotox(void)
+{
+	__test_bpf_gotox();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_gotox.c b/tools/testing/selftests/bpf/progs/bpf_gotox.c
new file mode 100644
index 000000000000..16ad6cf279c0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_gotox.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
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
+int one_switch(struct simple_ctx *ctx)
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
+int one_switch_non_zero_sec_off(struct simple_ctx *ctx)
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


