Return-Path: <bpf+bounces-50985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A1EA2EEDA
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 14:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF663A361E
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 13:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF1230991;
	Mon, 10 Feb 2025 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfTo4O/+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017C221DA9
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195511; cv=none; b=tL2fNIS1eSRiKZTY2VM0i6ZcfKNUkhPlk/1NCwCq7kPQUFlxpzU20AaceUZ8y0QzZBws8UchuhJ+E6T790f6nLmPpjFvd1/M41quQS8bYCGpWydGXQnnfs9FPjN8uJu1JZNq8eDOobM7vE5DNEJHCNty1/OxQ5iGJ1G/xtN4vvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195511; c=relaxed/simple;
	bh=DTP3Dvd3f4h4CgFVfxxSc0EtPaOsqhcbzdli5jzPQ0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vn5jDa4r4SRbrXiq2f+C/eUUKgx0qe2Wj4p59lN5m1DzGX8IPB1AKlPz453EYXko2uOqmn13r2y4c88if20E/batnCNh44SsHZJLsyftDYRROdpo2br9iizMVuYNOL3Ypwb/UOuiL2EXfWvb/XYe80DCYudn1OifmVj7kfIWWrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfTo4O/+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dccc90a52eso7491944a12.0
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 05:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739195508; x=1739800308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujAcpIIrHZbP2yUmC0pOaJk+H67L/H6nxnQyTab9Krg=;
        b=MfTo4O/+d+Aqz98aXp3oOuwZ8PN94Occ1JW28cukvOLxuANIqHQ/Ovc1hqp7F7M0XC
         tibUUY99D2ZwrvWEmiJg13U1/YjZHykA0K+xkDNLEEveKG2V+7RBKI90dumT60eK0Fa8
         oFpkf8vSYSCsHSzAlpQtvlXDZ1MjWBWOW+f8uJ6v/TmXt5zYlC7lxqwN2ZHY1sfBl108
         z23vCxJnKQXIqfbX+WDChveG/JmQAAskY6+OWoCMShtOGoNekRU2KjCRwqI6BuVZB9Cn
         c31/WDLciPiHh+BzqgAdJ9zJgfnedlwj2+ccn6LY1Uzhu890R8T0eyJhpSiSncQJ3GnH
         V7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739195508; x=1739800308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujAcpIIrHZbP2yUmC0pOaJk+H67L/H6nxnQyTab9Krg=;
        b=SSpzT14ZN85bLxFySJSHlSwoDIMnrZ06EGXcAwl6v2xRW5IdRQZ+6/5hiCy/eMC+sI
         wntvlxrneXbM1uGds+xhDSMZMe4PgfOEzJCcSG+Nmqx9p1Sempbppx8nBkmdY83CIY7f
         X8xOVuCgFZNaibDPWP3XQFYXpan7Id/TFrMqYaGO14ArMagtS3bZErhsbQhNH2VQ+FYm
         6cS5yytRCor0suUwT+8qXNazL09qB3dpo5o7eoxGPdwaCIPXWO2kGbst961Ybus77Z/U
         RrNQ0x1zDDz/Xx+gCxNKAh9KiYPx62RCCrG9FkrrQTFt8dafaoRL+g9fOptU1D6MtuYJ
         HcSQ==
X-Gm-Message-State: AOJu0YzdioJN7VdyOV1I1aDhwLEZh1b6QhvmaT0eVkCUm1zg1qQCIHu/
	rio7HjoGL+kRO1/VE0Ljy2+81DAMpxOPQ9EYMkZwriQPVqtJVkR6ib2qlw==
X-Gm-Gg: ASbGncuSjq1UxxQXkMVdclvSLsgQoje0674YM2syiV9pX7DDBnmx9KJhiFrh6whAAOQ
	haha0j5Q/rALe84oNhDVtaZy6wiqdZWTA7ansycFdCQ/rzwFBHy6wqUQlbL4UbT2PKlQXQNHsYV
	Xad3GDCKdWtSD1ikhgvX73o4Rh8SzxkRCfc/76ZnYsDv9LiP7Q0YRQ1xSYcHzqmgqJ1NzgHc7pr
	nMyVIsTd/HUO3NoeYoHGycLANZkjkTP4BVBKy4m1jsGeL7HE+jfhQPialfZihRnC2G4NvAmSAJN
	BJKuypXrMzh3ma7awCLDxxgb6sxt
X-Google-Smtp-Source: AGHT+IE8VCl/JHRdPKXC/7ESnPZdkHAASblPf68/bl4AN8Qh8SbShGFI8vmw7FTrFJQ56mxhc14X5A==
X-Received: by 2002:a17:907:805:b0:ab6:42f7:af4c with SMTP id a640c23a62f3a-ab789b21b21mr1298536066b.27.1739195507866;
        Mon, 10 Feb 2025 05:51:47 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:400::5:db8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e71f1sm878261566b.92.2025.02.10.05.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:51:47 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: introduce veristat test
Date: Mon, 10 Feb 2025 13:51:29 +0000
Message-ID: <20250210135129.719119-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210135129.719119-1-mykyta.yatsenko5@gmail.com>
References: <20250210135129.719119-1-mykyta.yatsenko5@gmail.com>
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
 .../selftests/bpf/prog_tests/test_veristat.c  | 122 ++++++++++++++++++
 .../selftests/bpf/progs/set_global_vars.c     |  47 +++++++
 3 files changed, 170 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_veristat.c
 create mode 100644 tools/testing/selftests/bpf/progs/set_global_vars.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 87551628e112..c300190c59ae 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -684,6 +684,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
 			     $(RESOLVE_BTFIDS)				\
 			     $(TRUNNER_BPFTOOL)				\
+				 $(OUTPUT)/veristat				\
 			     | $(TRUNNER_BINARY)-extras
 	$$(call msg,BINARY,,$$@)
 	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LDFLAGS) -o $$@
diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
new file mode 100644
index 000000000000..df7d0f291c7e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <string.h>
+#include <stdio.h>
+
+struct fixture {
+	char tmpfile[80];
+	int fd;
+	char *output;
+	size_t sz;
+};
+
+static struct fixture *init_fixture(void)
+{
+	struct fixture *fix = malloc(sizeof(struct fixture));
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
+void test_veristat_set_global_vars_succeeds(void)
+{
+	char command[512];
+	struct fixture *fix = init_fixture();
+
+	snprintf(command, sizeof(command),
+		 "./veristat set_global_vars.bpf.o"\
+		 " -G \"var_s64 = 0xf000000000000001\" "\
+		 " -G \"var_u64 = 0xfedcba9876543210\" "\
+		 " -G \"var_s32 = -0x80000000\" "\
+		 " -G \"var_u32 = 0x76543210\" "\
+		 " -G \"var_s16 = -32768\" "\
+		 " -G \"var_u16 = 60652\" "\
+		 " -G \"var_s8 = -128\" "\
+		 " -G \"var_u8 = 255\" "\
+		 " -G \"var_ea = EA2\" "\
+		 " -G \"var_eb = EB2\" "\
+		 " -G \"var_ec = EC2\" "\
+		 " -G \"var_b = 1\" "\
+		 "-vl2 > %s", fix->tmpfile);
+	if (!ASSERT_EQ(0, system(command), "command"))
+		goto out;
+
+	read(fix->fd, fix->output, fix->sz);
+	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0xf000000000000001 "),
+		   "var_s64 = 0xf000000000000001");
+	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0xfedcba9876543210 "),
+		   "var_u64 = 0xfedcba9876543210");
+	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0x80000000 "), "var_s32 = -0x80000000");
+	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0x76543210 "), "var_u32 = 0x76543210");
+	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0x8000 "), "var_s16 = -32768");
+	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0xecec "), "var_u16 = 60652");
+	ASSERT_NEQ(NULL, strstr(fix->output, "_w=128 "), "var_s8 = -128");
+	ASSERT_NEQ(NULL, strstr(fix->output, "_w=255 "), "var_u8 = 255");
+	ASSERT_NEQ(NULL, strstr(fix->output, "_w=11 "), "var_ea = EA2");
+	ASSERT_NEQ(NULL, strstr(fix->output, "_w=12 "), "var_eb = EB2");
+	ASSERT_NEQ(NULL, strstr(fix->output, "_w=13 "), "var_ec = EC2");
+	ASSERT_NEQ(NULL, strstr(fix->output, "_w=1 "), "var_b = 1");
+
+out:
+	teardown_fixture(fix);
+}
+
+void test_veristat_set_global_vars_from_file_succeeds(void)
+{
+	struct fixture *fix = init_fixture();
+	char command[512];
+	char input_file[80];
+	const char *vars = "var_s16 = -32768\nvar_u16 = 60652";
+	int fd;
+
+	snprintf(input_file, sizeof(input_file), "/tmp/veristat_input.XXXXXX");
+	fd = mkstemp(input_file);
+	if (!ASSERT_GT(fd, 0, "valid fd"))
+		goto out;
+
+	write(fd, vars, strlen(vars));
+	snprintf(command, sizeof(command),
+		 "./veristat set_global_vars.bpf.o -G \"@%s\" -vl2 > %s",
+		 input_file, fix->tmpfile);
+
+	ASSERT_EQ(0, system(command), "command");
+	read(fix->fd, fix->output, fix->sz);
+	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0x8000 "), "var_s16 = -32768");
+	ASSERT_NEQ(NULL, strstr(fix->output, "_w=0xecec "), "var_u16 = 60652");
+
+out:
+	close(fd);
+	remove(input_file);
+	teardown_fixture(fix);
+}
+
+void test_veristat_set_global_vars_out_of_range(void)
+{
+	struct fixture *fix = init_fixture();
+	char command[512];
+
+	snprintf(command, sizeof(command),
+		 "./veristat set_global_vars.bpf.o -G \"var_s32 = 2147483648\" -vl2 2> %s",
+		 fix->tmpfile);
+
+	if (!ASSERT_NEQ(0, system(command), "command"))
+		goto out;
+
+	read(fix->fd, fix->output, fix->sz);
+	ASSERT_NEQ(NULL, strstr(fix->output, "is out of range [-2147483648; 2147483647]"),
+		   "out of range");
+out:
+	teardown_fixture(fix);
+}
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
-- 
2.48.1


