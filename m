Return-Path: <bpf+bounces-35282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B708B93970B
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35ECD1F2236C
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 23:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7FA69953;
	Mon, 22 Jul 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvc4zJmA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A245812F
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721691552; cv=none; b=q26AdIXrt5vlWXRV+g2d+BJ1+hkvxmltMl56woFLbJIeEL+T5kEVfN1lJ9es6pXvlh87+KdFyGIEKFXBFTBxuPflIMQ+gCjCTrO9GMZQyZhTRTEkFa6jO0rlkuCX1+4pGfodir7uYCJRYjQnH1V2vKxYxfFFx0YVL8cr6yga4Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721691552; c=relaxed/simple;
	bh=B3+Vn1NwQmhObNt3+SKd157zQOMA3HX6E/enzDcMLGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSlF8BV00hQQvLa1oKsxike7lMVQ8wdUjytEW9EUYdY1nahn93YBFwYtgzss6GBVXSWOBoSY6wxWtM6kHm7UdwRQYAf18S0uEGWsUPji+HkFyVYMtYqGBODhTY2LCbt3gfkZE3MfZjyUbQijFzb+9JW3oG8SXa36bl2LFYuWpgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvc4zJmA; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d28023accso877197b3a.0
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 16:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721691550; x=1722296350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHoUFsCwxPPEf/6YciLZvizLI6GYPqexwytCxxFplDA=;
        b=Hvc4zJmAIpLJZmyM8JSq3M63RKCJPTnjHUC1SRDDF+PRdndT6AtwWhBhhOTKaTlbDv
         DlL7UoQsFz4nlaZJS1PwFqjX3XJcsuJ09czt41IvBHr3glGN9XbBfqYowWp+Fn5kMGEP
         yKY1ljSg6NaVQdxjGe2BL81npM57HBUQBQ45xXe5+pxO74QxOdKeJ5M7pt9bGCo+OhzV
         sky2NhEDI4t1fe2ZY4XfUK2oQMI17hesBsjtMVL+ETNzaNWWsI0qH+OyXhyX64OtRy3P
         DxsHcHaZchvuiWJpW7k77k4CjuHqSEA91VRRuzqLkZtLpLIWVuF6lBmAiAJEs45yUzBt
         aURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721691550; x=1722296350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHoUFsCwxPPEf/6YciLZvizLI6GYPqexwytCxxFplDA=;
        b=rYJ+NL/PXIf16np/rfpuznELp68T+6NUOx8rchDkc6lBY2X4Z5b+ftURSkZL7A918P
         8x9cYNrK4S0d4OOI39L3izKK57Mb7TyxyFS2zJhYjwKVUH0dpGkSrBraWkV1ZwzaxSeo
         pOSj+RcYU2ACYVmE7Hqo/X+lCNv8xiA62GZu6IvZbdt7GqbMyAlQNltNAhGvNzUDAbnv
         2ra7nGWECYp0/xZ6WS7UG/GWU24pIjOl+gEkGfb+9Yxi6l+W8SzB9UsiiLH7l+m4mffK
         hjMHLxQ6l6c2woulTMVe5qhLfbYrdZ3f02Jlcy7N24M8ODYmCccRxMzaX4rS3fpB9vVv
         DmsQ==
X-Gm-Message-State: AOJu0Yx0bpFKDC0xcyxVyHjCxC5n+9JOsDQodPPrvEUXzfccPElcz8+5
	RkUqqCUnVFiYW5opDHF7t5DGpZmqgb/vARd4kVteiMd8pfXw8t/tQsMkDPBdGX8=
X-Google-Smtp-Source: AGHT+IFylroEWzCDPrs7xoHKPD5DtnkNUfigRgEf5LYHJLISsUNQBmvL8tepWqlxbSRiFkW9gaNwgg==
X-Received: by 2002:a05:6a00:3cd4:b0:705:c5f9:5e54 with SMTP id d2e1a72fcca58-70d0eff6310mr7066871b3a.10.1721691549958;
        Mon, 22 Jul 2024 16:39:09 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2707fe14sm2479500b3a.163.2024.07.22.16.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 16:39:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 04/10] selftests/bpf: extract utility function for BPF disassembly
Date: Mon, 22 Jul 2024 16:38:38 -0700
Message-ID: <20240722233844.1406874-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722233844.1406874-1-eddyz87@gmail.com>
References: <20240722233844.1406874-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz);

  Disassembles instruction 'insn' to a text buffer 'buf'.
  Removes insn->code hex prefix added by kernel disassembly routine.
  Returns a pointer to the next instruction
  (increments insn by either 1 or 2).

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          |  1 +
 tools/testing/selftests/bpf/disasm_helpers.c  | 51 +++++++++++++
 tools/testing/selftests/bpf/disasm_helpers.h  | 12 +++
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 74 +++----------------
 tools/testing/selftests/bpf/testing_helpers.c |  1 +
 5 files changed, 75 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.c
 create mode 100644 tools/testing/selftests/bpf/disasm_helpers.h

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 05b234248b38..2886f2d75e01 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -657,6 +657,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 test_loader.c		\
 			 xsk.c			\
 			 disasm.c		\
+			 disasm_helpers.c	\
 			 json_writer.c 		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
diff --git a/tools/testing/selftests/bpf/disasm_helpers.c b/tools/testing/selftests/bpf/disasm_helpers.c
new file mode 100644
index 000000000000..96b1f2ffe438
--- /dev/null
+++ b/tools/testing/selftests/bpf/disasm_helpers.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+#include <bpf/bpf.h>
+#include "disasm.h"
+
+struct print_insn_context {
+	char *buf;
+	size_t sz;
+};
+
+static void print_insn_cb(void *private_data, const char *fmt, ...)
+{
+	struct print_insn_context *ctx = private_data;
+	va_list args;
+
+	va_start(args, fmt);
+	vsnprintf(ctx->buf, ctx->sz, fmt, args);
+	va_end(args);
+}
+
+struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)
+{
+	struct print_insn_context ctx = {
+		.buf = buf,
+		.sz = buf_sz,
+	};
+	struct bpf_insn_cbs cbs = {
+		.cb_print	= print_insn_cb,
+		.private_data	= &ctx,
+	};
+	char *tmp, *pfx_end, *sfx_start;
+	bool double_insn;
+	int len;
+
+	print_bpf_insn(&cbs, insn, true);
+	/* We share code with kernel BPF disassembler, it adds '(FF) ' prefix
+	 * for each instruction (FF stands for instruction `code` byte).
+	 * Remove the prefix inplace, and also simplify call instructions.
+	 * E.g.: "(85) call foo#10" -> "call foo".
+	 * Also remove newline in the end (the 'max(strlen(buf) - 1, 0)' thing).
+	 */
+	pfx_end = buf + 5;
+	sfx_start = buf + max((int)strlen(buf) - 1, 0);
+	if (strncmp(pfx_end, "call ", 5) == 0 && (tmp = strrchr(buf, '#')))
+		sfx_start = tmp;
+	len = sfx_start - pfx_end;
+	memmove(buf, pfx_end, len);
+	buf[len] = 0;
+	double_insn = insn->code == (BPF_LD | BPF_IMM | BPF_DW);
+	return insn + (double_insn ? 2 : 1);
+}
diff --git a/tools/testing/selftests/bpf/disasm_helpers.h b/tools/testing/selftests/bpf/disasm_helpers.h
new file mode 100644
index 000000000000..7b26cab70099
--- /dev/null
+++ b/tools/testing/selftests/bpf/disasm_helpers.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+
+#ifndef __DISASM_HELPERS_H
+#define __DISASM_HELPERS_H
+
+#include <stdlib.h>
+
+struct bpf_insn;
+
+struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz);
+
+#endif /* __DISASM_HELPERS_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
index 08b6391f2f56..dd75ccb03770 100644
--- a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
+++ b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
@@ -10,7 +10,8 @@
 #include "bpf/btf.h"
 #include "bpf_util.h"
 #include "linux/filter.h"
-#include "disasm.h"
+#include "linux/kernel.h"
+#include "disasm_helpers.h"
 
 #define MAX_PROG_TEXT_SZ (32 * 1024)
 
@@ -628,63 +629,6 @@ static bool match_pattern(struct btf *btf, char *pattern, char *text, char *reg_
 	return false;
 }
 
-static void print_insn(void *private_data, const char *fmt, ...)
-{
-	va_list args;
-
-	va_start(args, fmt);
-	vfprintf((FILE *)private_data, fmt, args);
-	va_end(args);
-}
-
-/* Disassemble instructions to a stream */
-static void print_xlated(FILE *out, struct bpf_insn *insn, __u32 len)
-{
-	const struct bpf_insn_cbs cbs = {
-		.cb_print	= print_insn,
-		.cb_call	= NULL,
-		.cb_imm		= NULL,
-		.private_data	= out,
-	};
-	bool double_insn = false;
-	int i;
-
-	for (i = 0; i < len; i++) {
-		if (double_insn) {
-			double_insn = false;
-			continue;
-		}
-
-		double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
-		print_bpf_insn(&cbs, insn + i, true);
-	}
-}
-
-/* We share code with kernel BPF disassembler, it adds '(FF) ' prefix
- * for each instruction (FF stands for instruction `code` byte).
- * This function removes the prefix inplace for each line in `str`.
- */
-static void remove_insn_prefix(char *str, int size)
-{
-	const int prefix_size = 5;
-
-	int write_pos = 0, read_pos = prefix_size;
-	int len = strlen(str);
-	char c;
-
-	size = min(size, len);
-
-	while (read_pos < size) {
-		c = str[read_pos++];
-		if (c == 0)
-			break;
-		str[write_pos++] = c;
-		if (c == '\n')
-			read_pos += prefix_size;
-	}
-	str[write_pos] = 0;
-}
-
 struct prog_info {
 	char *prog_kind;
 	enum bpf_prog_type prog_type;
@@ -699,9 +643,10 @@ static void match_program(struct btf *btf,
 			  char *reg_map[][2],
 			  bool skip_first_insn)
 {
-	struct bpf_insn *buf = NULL;
+	struct bpf_insn *buf = NULL, *insn, *insn_end;
 	int err = 0, prog_fd = 0;
 	FILE *prog_out = NULL;
+	char insn_buf[64];
 	char *text = NULL;
 	__u32 cnt = 0;
 
@@ -739,12 +684,13 @@ static void match_program(struct btf *btf,
 		PRINT_FAIL("Can't open memory stream\n");
 		goto out;
 	}
-	if (skip_first_insn)
-		print_xlated(prog_out, buf + 1, cnt - 1);
-	else
-		print_xlated(prog_out, buf, cnt);
+	insn_end = buf + cnt;
+	insn = buf + (skip_first_insn ? 1 : 0);
+	while (insn < insn_end) {
+		insn = disasm_insn(insn, insn_buf, sizeof(insn_buf));
+		fprintf(prog_out, "%s\n", insn_buf);
+	}
 	fclose(prog_out);
-	remove_insn_prefix(text, MAX_PROG_TEXT_SZ);
 
 	ASSERT_TRUE(match_pattern(btf, pattern, text, reg_map),
 		    pinfo->prog_kind);
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index d5379a0e6da8..ac7c66f4fc7b 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include "disasm.h"
 #include "test_progs.h"
 #include "testing_helpers.h"
 #include <linux/membarrier.h>
-- 
2.45.2


