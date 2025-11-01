Return-Path: <bpf+bounces-73237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30733C27C67
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 12:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193923BBDB7
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 11:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F92F12C8;
	Sat,  1 Nov 2025 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGOuctSm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839B2F0C7E
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761994882; cv=none; b=pl5Zs40WxzLk8NTvpV9M+naKWVWjZLqlr7eIO4vTpxR8OD6jxjwtTACjBI/nW/rFWX0efbsU0iY/rsVen7taQEodmO9/ytrGyE44cCJ/RlrEHT+m5SZfHorSd+2AH9joKAqWE7YvkxJHFU2qSFfrKy/ok8f5PBH2iIrtMYftKQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761994882; c=relaxed/simple;
	bh=yYkqC9T61sDzjmLQnWUSLc444y8xaezsQrV4o7ncENE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mv8Riz99VVCFn91n7cFPgNGTv69l87doa2Ao2bX+9bK8GR0ti3WoyLt63dran7pwK9kot+rjJsQgypbWZ7oGzMTNfYKIPua0cLuXyJ/KVsWshFicbXcsJGqYaJ/Esb1Js07RmffX4xlkZlH62l4XW0NDYxYHevC9WjUaMwBn7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGOuctSm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475d9de970eso20530545e9.1
        for <bpf@vger.kernel.org>; Sat, 01 Nov 2025 04:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761994878; x=1762599678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9p9E/hRuNKXGmugoZ+QykMn3kxPcQ3VWGRYgu05yFso=;
        b=eGOuctSmID8vggZGWLUs7hVoV7tNWdFO0cnwks9eVsaIXA4huW6zduZWCoebw3CmKv
         DKQIyEWNQvMGiX65nSyCeR6t3r+ZsxSW6tVomG48/cq9qV1RVxbtushOKmYE3xxKvHtP
         Kutp65QrH1MDiJSKRdl2XIr0VipIVKGhsUE5fX+wy2F/3TygODFrrVfyeAFgudy4SjDX
         EQUTTXV9ZIpQAeJiY3ZZYkIyvcb38/p1ba3LDFsDOg0RviW1ixa3csugVYYe0cyR+oxu
         N6KroWJSI7ZmOFCD6RBcxtxBTrzOjB90/45jV5aWNlwRmI+ViFvPW0fJ9NvzyrVBtftB
         GdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761994878; x=1762599678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9p9E/hRuNKXGmugoZ+QykMn3kxPcQ3VWGRYgu05yFso=;
        b=dRgRdyXShu0LhAXHDB8JNL4du/XPboAszHlbNw90xPYH0aQ+unp2/LcNSpYW/imW7w
         OhRpuOfI35IDRSLgroxSQNnSi9evjdRGDlXqSnhKMZ5aszin/zBB3QyYUpuGjjSW51RJ
         JtGTFB1R8unMHY3O10+7ezOmfLXq89B4Puk7bF0gw04c0o0J5DQ7tNPFRDTOFx9rXqtz
         dikCPQGAcYz3xDDLA3cSRlQzhyZx+GDJyv/ElxQmzO4unqURQRNXi9joFRiK7Hgk/QP9
         FUEOJhGQEA5IByP3StfwnO/+EjL24b9jSxdlxPGPRguj1thPtHCfEJ6m++DY0HMpDSAf
         hhSA==
X-Gm-Message-State: AOJu0YwhflHu+dJEM6JQ9d3TEXNgetVtTa/c/GmEahTclCJWxWqswxDT
	gqXCpliIVoz108XfN3e8obdiBMjfaTJYqB4SvxGaJOaWvbnW9UUwlbZdg5Bngw==
X-Gm-Gg: ASbGncsXrr/2fWUzCmWm/YuNxZXUKtIV/p5iS8UxnT9LZrQI9PRKP+wg0pk6z74sFFa
	EqdxbRojdV3so3RTplr5/Nwb5PWePjkzDlFVkshyej3R7uhKCbex3LP7QBXMvxA3GXpt8rdMo3j
	q03gZ6G+oAnl+yXTMootA8kq1TCG78KeG5DBlk/MqxSULGjBmSHfSlMY2E2NXUsKc0Vo9BzZkUX
	AHSDktVAzY9xl1ZZDGYqwhZcsz7VhFmQGVuAN3ZfSOaYwMbdbXvAYKftylq/mWn6cim9NlmnUTG
	Qo+/CYoydj/Fdz0Vy9U/qbO5QmZ7alE+xTrbWDS4m3NZZ3pBcQggu7nDQsC5D4pavoMEIrghxCK
	vCzkkixh6gnLbKinWGD9B1xYuKSiHu9kgWrquTXdT0aCbRDhVNjlSVP7VbWSV0GlQkLnJ6iocEI
	qFg6wGSNXQRm+wKCqGUU1A0451LCd+yg==
X-Google-Smtp-Source: AGHT+IGGs5cuDLBUSreZFPotrsk08oWNOKsU0UEbfH+1BdbSAZuMLVNdpMcs7o6ZDzByMWz75jp27A==
X-Received: by 2002:a05:600c:3548:b0:471:16b1:b824 with SMTP id 5b1f17b1804b1-4773088be8bmr73574395e9.28.1761994877366;
        Sat, 01 Nov 2025 04:01:17 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc52378sm38794005e9.6.2025.11.01.04.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:01:16 -0700 (PDT)
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
Subject: [PATCH v9 bpf-next 11/11] selftests/bpf: add C-level selftests for indirect jumps
Date: Sat,  1 Nov 2025 11:07:17 +0000
Message-Id: <20251101110717.2860949-12-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
References: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
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
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 272 +++++++++++
 tools/testing/selftests/bpf/progs/bpf_gotox.c | 437 ++++++++++++++++++
 3 files changed, 712 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_gotox.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 93dbafa050c9..34ea23c63bd5 100644
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
index 000000000000..2a55fa91e1fa
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
@@ -0,0 +1,272 @@
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
+static void __subtest(struct bpf_gotox *skel, void (*check)(struct bpf_gotox *))
+{
+	if (skel->data->skip)
+		test__skip();
+	else
+		check(skel);
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
+	if (test__start_subtest("one-switch"))
+		__subtest(skel, check_one_switch);
+
+	if (test__start_subtest("one-switch-non-zero-sec-offset"))
+		__subtest(skel, check_one_switch_non_zero_sec_off);
+
+	if (test__start_subtest("two-switches"))
+		__subtest(skel, check_two_switches);
+
+	if (test__start_subtest("big-jump-table"))
+		__subtest(skel, check_big_jump_table);
+
+	if (test__start_subtest("static-global"))
+		__subtest(skel, check_static_global);
+
+	if (test__start_subtest("nonstatic-global"))
+		__subtest(skel, check_nonstatic_global);
+
+	if (test__start_subtest("other-sec"))
+		__subtest(skel, check_other_sec);
+
+	if (test__start_subtest("static-global-other-sec"))
+		__subtest(skel, check_static_global_other_sec);
+
+	if (test__start_subtest("nonstatic-global-other-sec"))
+		__subtest(skel, check_nonstatic_global_other_sec);
+
+	if (test__start_subtest("one-jump-two-maps"))
+		__subtest(skel, check_one_jump_two_maps);
+
+	if (test__start_subtest("one-map-two-jumps"))
+		__subtest(skel, check_one_map_two_jumps);
+
+	bpf_gotox__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_gotox.c b/tools/testing/selftests/bpf/progs/bpf_gotox.c
new file mode 100644
index 000000000000..8a84f4b225b2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_gotox.c
@@ -0,0 +1,437 @@
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
+/*
+ * Skip all the tests if compiler doesn't support indirect jumps.
+ *
+ * If tests are skipped, then all functions below are compiled as
+ * dummy, such that the skeleton looks the same, and the userspace
+ * program can avoid any checks rather than if data->skip is set.
+ */
+#ifdef __BPF_FEATURE_GOTOX
+__u64 skip SEC(".data") = 0;
+#else
+__u64 skip = 1;
+#endif
+
+struct simple_ctx {
+	__u64 x;
+};
+
+#ifdef __BPF_FEATURE_GOTOX
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
+
+#else /* __BPF_FEATURE_GOTOX */
+
+#define SKIP_TEST(TEST_NAME)				\
+	SEC("syscall") int TEST_NAME(void *ctx)		\
+	{						\
+		return 0;				\
+	}
+
+SKIP_TEST(one_switch);
+SKIP_TEST(one_switch_non_zero_sec_off);
+SKIP_TEST(simple_test_other_sec);
+SKIP_TEST(two_switches);
+SKIP_TEST(big_jump_table);
+SKIP_TEST(one_jump_two_maps);
+SKIP_TEST(one_map_two_jumps);
+SKIP_TEST(use_static_global1);
+SKIP_TEST(use_static_global2);
+SKIP_TEST(use_static_global_other_sec);
+SKIP_TEST(use_nonstatic_global1);
+SKIP_TEST(use_nonstatic_global2);
+SKIP_TEST(use_nonstatic_global_other_sec);
+
+#endif /* __BPF_FEATURE_GOTOX */
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


