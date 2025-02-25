Return-Path: <bpf+bounces-52534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E47A44613
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A6119C6787
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251F195980;
	Tue, 25 Feb 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W13Wtn7g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557618C00B
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501081; cv=none; b=I+bn3Z092T+RKUlYZfAcK2Rt7YvYNYimGFvBolAd+xmPPwlP7ApS3D46E3Y1qa2kFo8FHP9zYGEws5TqjCWnJhC7kkj9h30LBSF36s0FrKqAf0raTT15kCIrrBzTh2Ql6+GeFSUI0Jh91yuuDC6C9mccG0H9yzEKuinNhGrXcO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501081; c=relaxed/simple;
	bh=WHI4MV7FfDaYk5lM/9sAOt60l/P3qf/4w6aHxdHPTss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmCFEKSVeYVUsZf5P2SIVZM/ouPgR2RWCYh2N/XkIfE1I601ih+2hZOm6nbK37E8ZYfqvsdLJMW4pwX4dhemH+O9uASgFeYuHGX7aWbWmQTwx+mqnNWvuVqOrSVQJGjgaGb6raZGim2bL0UNsHdz1YmCQj4ktPTKDIN/i/7+Csw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W13Wtn7g; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso909615866b.2
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 08:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740501078; x=1741105878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3F/74zkGmw7qLKYMhwRNwiBe3DrQUmTl5ep90WvTEII=;
        b=W13Wtn7gPCHDKxcoMW8RWKkMg/NOXBlZzR5hNuXvq1jO3khrwcWbc9A7ZauGRnJ+NH
         kg7seM1GkBQSC8TwuJPUBfu3REkQz6/Jx14KrZi6me2IKA5kDXO8MU7hXV7usvpqeycQ
         K+MaLMqmv25CtQYTgvd6FsIVnM//EtGVU+Qo9Spe8/SwVkyfo4p6lsZ44KlugpIf+tY7
         idGd8B7/L7xHRoDTsdXGmfhP0P6D7f50LNjiCEJ0/8USCh8l6Nb2yBlCgRMTCu6O4pYg
         1KB5yCkM6yOdxOwKE8lEtJMx+WxSWuIVhu51SaiItPesN1jkvSHNEnbb0idKylEkuvKZ
         vIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501078; x=1741105878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3F/74zkGmw7qLKYMhwRNwiBe3DrQUmTl5ep90WvTEII=;
        b=LVpfH5DhhgS9v8U8tNlB/GhQDfb5kO0v1bIrt/xtORY20TQ1Ldir46agAbuzkh82h4
         FZtmftUoZGuFeTe8xXDx0xvQnuhf6IBW8V/CT9IRCjrMsfaUPYpF/4oNlwYDM4WZ4H07
         uxTD3zcttHvxT3dPQlAuOpBC99WVunYcJ9QP4fVAi8MXHPxlgrkMS5J9ye5Ktub4SyiB
         42s1dxIB0B6e9vksROVsmHk5xp4MbIaMExoMXg6USG6D8gHevB4qrQeBGAzj2tzMZhdf
         FKPFt/GS8TmhKXLXu6uSELyhtOCgtKMrsIyqd8NUzF0zDamXEkswxXZVrvnPB1izoufv
         u5BQ==
X-Gm-Message-State: AOJu0Yy/HsY+1X8EBPzfYvuxIQC4XJProSXVL9/2lcvfj7+NeYJb9kMF
	43Np9rvNPmFrQ5ribbxQRndbBkGOqQLfl3wcaL7PVU3ZZ0x0uuudk8YKgA==
X-Gm-Gg: ASbGncuycb8QelSEDItefmbvMogjt/NBUhsQk9v3bdPSbvfTW1a/IOf5AqSscVvhOUJ
	VyerMa2zxp9M/nGy5Hl0nx5sZ5QQj8ATCBEExmJBPe1qlg/qGcWksT2SHnvYa1zbPoYX5z4sjGL
	2BsOQdCfmKgubcuaXNbnKUOHmv0DocspUMqY4f0W1xOFVLxo/T9NfrN5pq+LKemUODRw+yQ83c/
	cBmvoHcTLCkNys67hROxrRWWrtE9FZLwLcKZz5o7N/tLeKXU1xEo6eNINdLuFnVve7TUsXn1z/1
	4I47Uxxi/N/wziJPVI96yj5aaZQRoHpKyyE8ooRm
X-Google-Smtp-Source: AGHT+IEh3fsY8wwRxlH+Le+UZu8uORlMyGrJBiGnHO5fHQ+/VSsBoBhNQ3mSPUG1oyuNSHLo2HJkSg==
X-Received: by 2002:a17:907:6ea2:b0:ab7:b072:8481 with SMTP id a640c23a62f3a-abc09c1a63dmr1756057966b.45.1740501077543;
        Tue, 25 Feb 2025 08:31:17 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::7:2cec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2013321sm167178166b.96.2025.02.25.08.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:31:17 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: introduce veristat test
Date: Tue, 25 Feb 2025 16:31:01 +0000
Message-ID: <20250225163101.121043-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225163101.121043-1-mykyta.yatsenko5@gmail.com>
References: <20250225163101.121043-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introducing test for veristat, part of test_progs.
Test cases cover functionality of setting global variables in BPF
program.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/prog_tests/test_veristat.c  | 139 ++++++++++++++++++
 .../selftests/bpf/progs/set_global_vars.c     |  47 ++++++
 tools/testing/selftests/bpf/test_progs.h      |   8 +
 4 files changed, 195 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_veristat.c
 create mode 100644 tools/testing/selftests/bpf/progs/set_global_vars.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5dc9c84ed30f..abfb450c26bb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -688,6 +688,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
 			     $(RESOLVE_BTFIDS)				\
 			     $(TRUNNER_BPFTOOL)				\
+			     $(OUTPUT)/veristat				\
 			     | $(TRUNNER_BINARY)-extras
 	$$(call msg,BINARY,,$$@)
 	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LDFLAGS) -o $$@
diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
new file mode 100644
index 000000000000..a95b42bf744a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <string.h>
+#include <stdio.h>
+
+#define __CHECK_STR(str, name)					    \
+	do {							    \
+		if (!ASSERT_HAS_SUBSTR(fix->output, (str), (name))) \
+			goto out;				    \
+	} while (0)
+
+struct fixture {
+	char tmpfile[80];
+	int fd;
+	char *output;
+	size_t sz;
+	char veristat[80];
+};
+
+static struct fixture *init_fixture(void)
+{
+	struct fixture *fix = malloc(sizeof(struct fixture));
+
+	/* for no_alu32 and cpuv4 veristat is in parent folder */
+	if (access("./veristat", F_OK) == 0)
+		strcpy(fix->veristat, "./veristat");
+	else if (access("../veristat", F_OK) == 0)
+		strcpy(fix->veristat, "../veristat");
+	else
+		PRINT_FAIL("Can't find veristat binary");
+
+	snprintf(fix->tmpfile, sizeof(fix->tmpfile), "/tmp/test_veristat.XXXXXX");
+	fix->fd = mkstemp(fix->tmpfile);
+	fix->sz = 1000000;
+	fix->output = malloc(fix->sz);
+	return fix;
+}
+
+static void teardown_fixture(struct fixture *fix)
+{
+	free(fix->output);
+	close(fix->fd);
+	remove(fix->tmpfile);
+	free(fix);
+}
+
+static void test_set_global_vars_succeeds(void)
+{
+	struct fixture *fix = init_fixture();
+
+	SYS(out,
+	    "%s set_global_vars.bpf.o"\
+	    " -G \"var_s64 = 0xf000000000000001\" "\
+	    " -G \"var_u64 = 0xfedcba9876543210\" "\
+	    " -G \"var_s32 = -0x80000000\" "\
+	    " -G \"var_u32 = 0x76543210\" "\
+	    " -G \"var_s16 = -32768\" "\
+	    " -G \"var_u16 = 60652\" "\
+	    " -G \"var_s8 = -128\" "\
+	    " -G \"var_u8 = 255\" "\
+	    " -G \"var_ea = EA2\" "\
+	    " -G \"var_eb = EB2\" "\
+	    " -G \"var_ec = EC2\" "\
+	    " -G \"var_b = 1\" "\
+	    "-vl2 > %s", fix->veristat, fix->tmpfile);
+
+	read(fix->fd, fix->output, fix->sz);
+	__CHECK_STR("_w=0xf000000000000001 ", "var_s64 = 0xf000000000000001");
+	__CHECK_STR("_w=0xfedcba9876543210 ", "var_u64 = 0xfedcba9876543210");
+	__CHECK_STR("_w=0x80000000 ", "var_s32 = -0x80000000");
+	__CHECK_STR("_w=0x76543210 ", "var_u32 = 0x76543210");
+	__CHECK_STR("_w=0x8000 ", "var_s16 = -32768");
+	__CHECK_STR("_w=0xecec ", "var_u16 = 60652");
+	__CHECK_STR("_w=128 ", "var_s8 = -128");
+	__CHECK_STR("_w=255 ", "var_u8 = 255");
+	__CHECK_STR("_w=11 ", "var_ea = EA2");
+	__CHECK_STR("_w=12 ", "var_eb = EB2");
+	__CHECK_STR("_w=13 ", "var_ec = EC2");
+	__CHECK_STR("_w=1 ", "var_b = 1");
+
+out:
+	teardown_fixture(fix);
+}
+
+static void test_set_global_vars_from_file_succeeds(void)
+{
+	struct fixture *fix = init_fixture();
+	char input_file[80];
+	const char *vars = "var_s16 = -32768\nvar_u16 = 60652";
+	int fd;
+
+	snprintf(input_file, sizeof(input_file), "/tmp/veristat_input.XXXXXX");
+	fd = mkstemp(input_file);
+	if (!ASSERT_GE(fd, 0, "valid fd"))
+		goto out;
+
+	write(fd, vars, strlen(vars));
+	syncfs(fd);
+	SYS(out, "%s set_global_vars.bpf.o -G \"@%s\" -vl2 > %s",
+	    fix->veristat, input_file, fix->tmpfile);
+	read(fix->fd, fix->output, fix->sz);
+	__CHECK_STR("_w=0x8000 ", "var_s16 = -32768");
+	__CHECK_STR("_w=0xecec ", "var_u16 = 60652");
+
+out:
+	close(fd);
+	remove(input_file);
+	teardown_fixture(fix);
+}
+
+static void test_set_global_vars_out_of_range(void)
+{
+	struct fixture *fix = init_fixture();
+
+	SYS_FAIL(out,
+		 "%s set_global_vars.bpf.o -G \"var_s32 = 2147483648\" -vl2 2> %s",
+		 fix->veristat, fix->tmpfile);
+
+	read(fix->fd, fix->output, fix->sz);
+	__CHECK_STR("is out of range [-2147483648; 2147483647]", "out of range");
+
+out:
+	teardown_fixture(fix);
+}
+
+void test_veristat(void)
+{
+	if (test__start_subtest("set_global_vars_succeeds"))
+		test_set_global_vars_succeeds();
+
+	if (test__start_subtest("set_global_vars_out_of_range"))
+		test_set_global_vars_out_of_range();
+
+	if (test__start_subtest("set_global_vars_from_file_succeeds"))
+		test_set_global_vars_from_file_succeeds();
+}
+
+#undef __CHECK_STR
diff --git a/tools/testing/selftests/bpf/progs/set_global_vars.c b/tools/testing/selftests/bpf/progs/set_global_vars.c
new file mode 100644
index 000000000000..9adb5ba4cd4d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/set_global_vars.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include "bpf_experimental.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include <stdbool.h>
+
+char _license[] SEC("license") = "GPL";
+
+enum Enum { EA1 = 0, EA2 = 11 };
+enum Enumu64 {EB1 = 0llu, EB2 = 12llu };
+enum Enums64 { EC1 = 0ll, EC2 = 13ll };
+
+const volatile __s64 var_s64 = -1;
+const volatile __u64 var_u64 = 0;
+const volatile __s32 var_s32 = -1;
+const volatile __u32 var_u32 = 0;
+const volatile __s16 var_s16 = -1;
+const volatile __u16 var_u16 = 0;
+const volatile __s8 var_s8 = -1;
+const volatile __u8 var_u8 = 0;
+const volatile enum Enum var_ea = EA1;
+const volatile enum Enumu64 var_eb = EB1;
+const volatile enum Enums64 var_ec = EC1;
+const volatile bool var_b = false;
+
+char arr[4] = {0};
+
+SEC("socket")
+int test_set_globals(void *ctx)
+{
+	volatile __s8 a;
+
+	a = var_s64;
+	a = var_u64;
+	a = var_s32;
+	a = var_u32;
+	a = var_s16;
+	a = var_u16;
+	a = var_s8;
+	a = var_u8;
+	a = var_ea;
+	a = var_eb;
+	a = var_ec;
+	a = var_b;
+	return a;
+}
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 404d0d4915d5..870694f2a359 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -427,6 +427,14 @@ void hexdump(const char *prefix, const void *buf, size_t len);
 			goto goto_label;				\
 	})
 
+#define SYS_FAIL(goto_label, fmt, ...)					\
+	({								\
+		char cmd[1024];						\
+		snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);		\
+		if (!ASSERT_NEQ(0, system(cmd), cmd))			\
+			goto goto_label;				\
+	})
+
 #define ALL_TO_DEV_NULL " >/dev/null 2>&1"
 
 #define SYS_NOFAIL(fmt, ...)						\
-- 
2.48.1


