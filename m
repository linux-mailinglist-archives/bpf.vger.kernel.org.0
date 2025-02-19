Return-Path: <bpf+bounces-52004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9034A3CD9C
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 00:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD0C7A8598
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 23:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747425EF9F;
	Wed, 19 Feb 2025 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtELp/yY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28321260A4A
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007869; cv=none; b=dvk+i2LHVQX66RxVpWDKNp55XH6WgbsHM11attF3u1hGUkEPgryTV5E0KEnN85zmWqcfIJKRWyAj523jtKfqXh3vY8yiFkhXrwMSLbN3qWGxITSxreyiumrlqh0i18QtsOh//0WxrejPC2k941ZanDL3CYs/77esy4bi2mcfe+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007869; c=relaxed/simple;
	bh=9oI+CryHIWFfVk+vJAE0HpM32KMTc4S6nwYfuupuVcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNemYPjxkSW9u3RLoJUZUY50vau7hLmlLJOCYhpMipw+Eifx06WzYlJAm8wPUl+Yh0dGDeCn06IQ5raTaU5UeVswzmbTAGeiwDBMPNAU0Hi4qNh90CfnoQ9hO+GfpXXRwV7qj1S+TOeOTpveryJN2Oxp+Dr3m+7n2iBGGG/QXog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtELp/yY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f5fc33602so198312f8f.0
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 15:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740007865; x=1740612665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtGC9yy/rZNIhGxG00U3J4p1ioOI+GZIf1K3eZY5cOM=;
        b=ZtELp/yYEV1qY6hSf660mzMqV1dAS2LDGKI/3c5CJzUFeJeVhMLUVziDFlfilXGkcw
         3rwiU0x5ep/NR9unc2iwYCMqlDEU8LKt1UIOJx50qPlYrCsz6I6Qf4fFE4UvHy6ZLMxK
         /QARZ+R3L9b/eT+rsbo0rFX0o1t3ODSiPa8NEmue4ukKRjlw6u0UCmGAZJa1n5n4DwXH
         nKwv9W7zlDNYoFZKrqpjfLopFmntmwiUQTUlucXegvWtE7JAO0slrh5gdHbybydAaLtZ
         9T6TlGXotwMsetYafxkKSkKyT9e/EvNmZ0yUAmmJ8qTJsJsLQgD6JlQS2HwT6EzZFI5C
         3IbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740007865; x=1740612665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtGC9yy/rZNIhGxG00U3J4p1ioOI+GZIf1K3eZY5cOM=;
        b=jn9H5CG0OZkDH47jR64IqYFEmRxW5KJol6A9llP76qhDT7MTJIeKN+lT2pweIOCLfY
         DvGxk7dMI6HhrFKeD11hsqnMHvck028K3Fy3I3Q/oMNfJNSWMkScjVOUXk5EvoLDcGTk
         9CfPLVqEwmlY7dRGnRPnLEQIwlemcRYncI+88vMAXrwPDmWWmicy5dLv6ujBX7DCbOME
         UAfGUrLAzKf5tz2P08Gdfbe049uj+cIY/zc2o0OI7FTufFUlvKWwWtr1TZHmpp33qhSB
         JLDqz4li07EV28CXcpc5GXJumWBIHUDLPZtrCkKVQ1Z/Ev8WzUkTsp8A+V2uUl7pYPgS
         e+WQ==
X-Gm-Message-State: AOJu0Yzl5bcnzHxUXwDYFpAGa2BigRnlTbap7WpO8Xb93JXcDW9ckh3e
	/tepeDsRQQ89unZfmpuPl3SW9DnOrcv1ENzKvuwUtd/g2mUdbasAdVGeqg==
X-Gm-Gg: ASbGnct57aFHLQzh7F+AvLDbRiFnXanrT/uLP1/QIRQvgDIeVBXmOvp4T55E3hJUsIf
	Ks+unbSwReqg8VpIh6VatZKu4Z3zzhCnD0mqk6eMZXm1zsvGrZ8ncFKgSz9L4pvbt/CzynJPQkP
	5Zk279GUIN71RUzls9rEOBYntmKctnaPIkvA3T5Oqmg3GmU6Amp3LpVfndFHZI0GL1hApqardIg
	g10FXn9RkS2F6Wrb/sx3aAICS86oLEyDlm6eOGA5krJQDG26zbQysfActT/ZewYhsCc6M+sJTHM
	Pc8hdae8XxEjuhIceTe3k+F7wQEL8pkLGOXNzL5wyMTUqfjlNJS06NN5TPoRi0Hrt7FUGMKYkfM
	7kyf/U8wYCMjm9tDBRotu
X-Google-Smtp-Source: AGHT+IGVfiYj46jle18rJGsJlQo/B4ruKVXJnmMPXjcAEy7t0CP0kQ4euek8UuJO+tQv2rP11c37vw==
X-Received: by 2002:a5d:5f4d:0:b0:38c:5da8:5f88 with SMTP id ffacd0b85a97d-38f61609df3mr1043559f8f.28.1740007865313;
        Wed, 19 Feb 2025 15:31:05 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7998sm18779048f8f.82.2025.02.19.15.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 15:31:04 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: introduce veristat test
Date: Wed, 19 Feb 2025 23:30:45 +0000
Message-ID: <20250219233045.201595-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219233045.201595-1-mykyta.yatsenko5@gmail.com>
References: <20250219233045.201595-1-mykyta.yatsenko5@gmail.com>
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
 .../selftests/bpf/prog_tests/test_veristat.c  | 136 ++++++++++++++++++
 .../selftests/bpf/progs/set_global_vars.c     |  47 ++++++
 tools/testing/selftests/bpf/test_progs.h      |   8 ++
 4 files changed, 192 insertions(+)
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
index 000000000000..eff79bf55fe3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
@@ -0,0 +1,136 @@
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
+	if (access("./veristat", F_OK) == 0)
+		strcpy(fix->veristat, "./veristat");
+	/* for no_alu32 and cpuv4 veristat is in parent folder */
+	if (access("../veristat", F_OK) == 0)
+		strcpy(fix->veristat, "../veristat");
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


