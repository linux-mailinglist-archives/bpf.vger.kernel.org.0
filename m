Return-Path: <bpf+bounces-52222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D73A402C0
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 23:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA32918956EE
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 22:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E8D253B73;
	Fri, 21 Feb 2025 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfnyHpNe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1781A254B09
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177193; cv=none; b=QYpl3dKKTu4aefNSzvVydoZ3Y3KIb4I5BPMvK09axqHr9ND56IgwpRDm6ElceHsap95gnE5/aPQNo3KybICK+xiQBNuUrQ9PbkL6qquqsE0cfK1wsovouz33b6EumvAyYr0w4P42TWQk+30Gcjdj2EHWUlnzRGit8i1GiisI+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177193; c=relaxed/simple;
	bh=yUctMfuA1l+sKHcncB6u6tr/puiw75j8Zz85C+UaQew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3h/1yoz7We/CiEbiJ19W5bUMIq/gHBLu3Ua7aLWi0mwwbBuXbVtRY+qG+0uYdyKy4U06W08+mHQyoUPZF0pWZpyGfkOXZV8q7OQlL5dX1eb93x91LnXp0FUKEQrqaNDRaT+z7rZNwV9GFPSelNsAJN2oa27tk38oK5Xo0+EyAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfnyHpNe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso2315607f8f.0
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 14:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740177188; x=1740781988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMw2FquKdbplg420C4xGv1fVMSj6EEaetbkbDjSljEA=;
        b=JfnyHpNe7cAP2q1CFoPNTrJZbjSf5Cqfwgr55PKpt+/2BpJ2SToirwib/OdQ+qINK9
         1I910nKoWrFZ1IY7sOhXCIfXcOl8wlYooZA5bRQ2IAjDfrjdPur86JtFsji6Q6InH5AO
         mDqKzj6AvYutSBnvEFpnLb20m+fGJIf7CQNmBOXYTVLlaBKUaf0tn/ikJbqzTFK3GCOE
         PJvkv1tR609K0xhx3GjT6r5Iciguc4NccOsGwgCGsCwmEEQu2AGMRo/ptuGJ72Klacra
         Jo+C8DCNb3FvWi+HUR5fSYS2yif7lNeTjsgmmw0NAhABwzCFU8RjOgMXYHZU5XlsZhIb
         M0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177188; x=1740781988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMw2FquKdbplg420C4xGv1fVMSj6EEaetbkbDjSljEA=;
        b=MqER+Di4W8nIGkSO0/Bzn/n9l4ko6F9dUJHnijvA1iv8jMwDMxi+v8SelW5xJPvJzT
         Qlt7ctKmgcl8/DPZo53wgT1HpQzpXxixEpj17jZeaohzsbCuxqJ5YXWty5sAnYOg9NgY
         zTvgLxsuCGu+LzuvnZn2Bjsql0j9zHXsSi3VOlnpWdAWs1EpRVqb90KSGe0GCh1cQeky
         lmnzi/anZTSiK+iJn9PFtlkOCuLZEmKpIOwd+jvTu3aFd7+bFLpH8G4pLnkad7jG65Il
         Jwp81+5fcnOmFZ28gf3PIE9RGoDDW+9QL0vrAxPGtkzpIl+P1cPah8v+RljirRWGi60d
         gn7A==
X-Gm-Message-State: AOJu0YyoeEc1hm6WIaV7kRZMY6pMplYBTE64eyzyV30ZfuKTT1enSwiC
	ffN+YjpnVdUG/YAZtecIH7oTYDPKXsm4CQ6yOfJdTkY43hfV9jfMcSLyRQ==
X-Gm-Gg: ASbGnctzrUzX8nJMaSykM8FuAgHp4ygH+OeHVJpmBJAjPNNggg2E0ADmAa1g89NSku5
	2xo2nHCrDhCVBJUY75UXXmkLm8X9mNsYqjsb9bgXkXZykOc4mS32caaYxn4HfJPOdB/YZTFNzOJ
	Mm+ETophswB+YTDpeAaaB4I/XrPXmCXa8lzilvw5PUPgMarxD4oBxUeAciYzYK8prFjJXjS7CYp
	/3AHn3oSKKkwk2CogSzYKcNmnBxW65vXHBOl0///os2xBd6S1FMOQkqONHCQWgUhgHhGjOSBnLv
	+dRxu7mhjv0KslMMBCDh7FQLjaRhAd2UYW61YtSVWklb08EFGDjWZGus5YVyIYutVazKgexwA3s
	pNghHRaWM5lYCV+CZwwiwSjgSMwEUajA=
X-Google-Smtp-Source: AGHT+IETHvzG1bGawbCn7UcLCi0tkNmRRsTJoEOLyppS/GhFIVuDIVyDDpNhziyZEsCIkgE7h82vag==
X-Received: by 2002:a05:6000:1a87:b0:38f:3ec3:4801 with SMTP id ffacd0b85a97d-38f616323bamr8492030f8f.25.1740177188222;
        Fri, 21 Feb 2025 14:33:08 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d9be9sm24880003f8f.79.2025.02.21.14.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 14:33:07 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: introduce veristat test
Date: Fri, 21 Feb 2025 22:32:59 +0000
Message-ID: <20250221223259.677471-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221223259.677471-1-mykyta.yatsenko5@gmail.com>
References: <20250221223259.677471-1-mykyta.yatsenko5@gmail.com>
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
index 0d552bfcfe7d..5e9d3c91c6db 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -690,6 +690,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
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


