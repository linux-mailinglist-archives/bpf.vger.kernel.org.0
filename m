Return-Path: <bpf+bounces-33879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B09A9273F3
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 12:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C27A1F22E11
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 10:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022C61ABC26;
	Thu,  4 Jul 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PScnbChj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123A013C8FF
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088666; cv=none; b=KU81W79KRocK7t8OfkNcpFTj2Aqnw5DOz2t6zC8gEFK0mUqcMGMsSkgtde8fS+eQAHTv1X4cgXrFOhRgN0BEJm93L0qxETuGDYl5mfq8maRGmMsrtXn2zcw0fo+Ye6WB/BmIjaVAIcvEJlYRKi5WSXPWFLb6UQeLh6SJHn1OAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088666; c=relaxed/simple;
	bh=xnASLsCOBryRuodIdDKREqMt8MKr9ttqgtV/XcxU2N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fe1QPRilLFHISINOxnm+e30h+Kqz3aRuIEIViScrMW/dWoj0bonMXijZ0p3VBToJ1++9CT1LLKwOwE79oNSzdJPJy2qzjchDB2A9N3DRDRlKNltfGlHI5w7GaY/F8lIFFxmMIzN67asBI2p7vSQvQfZWdnLQiEp8DR5zH20aS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PScnbChj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c983d8bdc7so402212a91.0
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 03:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720088664; x=1720693464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C24mtLz9Hjduk/1K2PNUEthFuyWN0AEt97R5T0ddlL0=;
        b=PScnbChjWPzToYd0XKlqiMEGi7J6eWu2vTF9i9Mv7iFSVhc/zAPaUV6aNfqzS68c9m
         GIc+IOIi/GmF/LzgD3IbCNzpmRfHQfAgPQyvu9sqPDltFIOfNZzi0FV2F/AqOd5zFuH9
         3H0kXgDGJmrRaDd70cOamCIm6CnT4/u8aOWOjAjOA/mfGqKnXH0LJXaKiMVnriUU/SSi
         LsROxw7b4/m5cIMYoBVjeVXaWtTn9oic7dgCy8lw3g9oFkRpItL0c7rVSbwYMLpLFRa7
         T3lSC1quqPuaG7rKawDYipSBoJ+pagWiRgtA9wLC5JdQ/r8Nnrf9m4hVp4pd+pU27LNS
         GZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720088664; x=1720693464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C24mtLz9Hjduk/1K2PNUEthFuyWN0AEt97R5T0ddlL0=;
        b=MNKw/RorXNOFoE6mNHUI2jzPOhFfN2H4alIe8PjOr4Et2k3SlZvIOkXFTG5DIQ19oF
         jUD9ZXhF2azInknnigNDp1F+M02vssE/C0ITUmzDY8nbnfY4JUF/6Zme8g/PUSMzfufb
         1fOyAEyyw4lO1Aa/WCpweEFxqKCF1TwlRQnzWz2ZWejZ5qd+Gu2rsK3MmwKZatjM00fw
         AqLLkvkoDmfgB7SDV20rwNkepDP6/qQMkaYabN328+WV617WbKmX+AxY2wha3fDcCpiQ
         5xGFULJc0ch4DJw+571pgLCE6/z4JWx7onMRUHCGsu53eECpqerYJhY4TWZrxxHDv/xw
         4I7w==
X-Gm-Message-State: AOJu0YzxEAF+p+t4CDNXfwerS3Ni73x7Q8QPZlBZ3SmocIntMibE6SHM
	IM1ghtPRm4ZchVbasjeXZTAhm1oCorb48FdM+KqEvPyDncwERb/z7rc6fg==
X-Google-Smtp-Source: AGHT+IFpconvVWGmswtTwjEfWe6fuzG6u+hl5/Z+y0jm3SByH1RkDdiwN0mdyxjBGRdP8gE5NNDFvg==
X-Received: by 2002:a17:90a:d795:b0:2c9:8b23:15ba with SMTP id 98e67ed59e1d1-2c99c6c8eaemr913720a91.42.1720088663955;
        Thu, 04 Jul 2024 03:24:23 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c9a4c0fe8dsm216693a91.0.2024.07.04.03.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 03:24:23 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next v2 4/9] selftests/bpf: extract utility function for BPF disassembly
Date: Thu,  4 Jul 2024 03:23:56 -0700
Message-ID: <20240704102402.1644916-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102402.1644916-1-eddyz87@gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
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
index e0b3887b3d2d..5eb7b5eb89d2 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -636,6 +636,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
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


