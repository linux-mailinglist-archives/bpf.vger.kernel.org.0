Return-Path: <bpf+bounces-33419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB8991CBF1
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 11:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1C81F220C6
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7693FE55;
	Sat, 29 Jun 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXLyuM0f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7DF3CF7E
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719654492; cv=none; b=OX5Ous+MaPVkFLefni3Uh/1GEII/deCxPaCGguDdK0/xENwYQrafgAT6JbM+MLlIPN5dvl9+o4S32lONgQgvePUyGkVM26OV47FQcabxtPRu6IJWP/wkJN0xFLpV3GdJNHFSMakcowUdkLqAYrseg1WbyHuEjJjctyjXfTn0ANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719654492; c=relaxed/simple;
	bh=hMoR0VsH6b/86oM4MC60TZBCv5ZEfsGMaDUt3aOIl2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4fb0WRJ7yyRna98yB0Pl2zWeQrCXrNU3os3gRseKOgON0izmxWo4YWDpqMHiJZWZFiKazMbYZZ73KSTXpCNuTAo8ivZjWhevabP4u350xYdNImoPABop3bh++MGHw2OR4ySDDcM8/epuQh6CEhD6MMScbQSwfsn27pH4tk+EmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXLyuM0f; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25c9786835eso803580fac.3
        for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719654490; x=1720259290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tF6+BoPqiTXE6WlMeUomLmOMPBTE3lwEWPLjkPv3CLc=;
        b=kXLyuM0feBKnhk1PKkOxowmHX/eB+3AmtO/si8ks4HWp+vthJNReH+K1hubJfSCxAg
         2zrs7kZlZU3+bY4f23lSWPkPGfBlHNZVjtON0p2REEGCv64/pAdqYpLSmsLAbS2XWLwU
         ZKrxjJRf25GfdvzqQgJmw5KvWar9iBfKrSEwTEesgRU+oUiBjOM4sZDEY0ZnvGDzWG6a
         HQq4u2mggzzdCVwF46PohlDVvcSMkED1QIF0DxPugmADAjFq458iItK+xl2XgT8fWSRC
         fi7t2OM6nsXMC6efq972l7HzsL0xL5yHT3rwX9nEQ06diSMFBU/Tu+AP0CQ5JaiYzsHe
         +HyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719654490; x=1720259290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tF6+BoPqiTXE6WlMeUomLmOMPBTE3lwEWPLjkPv3CLc=;
        b=mEF7qG8x/R8X9nGZIgKknxfpxa0Dk3fLJgrMYBABRp8aFwip7DtrQ8G5dJLYdsifNd
         k+aRVObZe4IsLfgHg5948M0X2q2rjJo9hJroa0lWzr7t4BfSv4B3vy3YVKykx2vqrKvL
         dcA+/KywtSsi+TXPp4lWO3eVwnCdraErXZY8XkbwRq6p7s5XsTKetUs2Leqd5AWNmIQj
         sGPXT+lcXbiOO1PyyXD6Blx96NkG4kk/e+TvZmBQGId5QkHWzwWPUFrEvDAKqgTwWMZo
         YFUC/iT1XACA8EemnIAWewDqb0XcoKgpNz1JZ2H6a14jqy6i44oZ1p1btEJWayiF4zhe
         lenQ==
X-Gm-Message-State: AOJu0YwsnYZqmkvEw8DFhJkalMMrQ5lQVaHcBQblWuGw2muMT6r5Q76W
	Fe25VU3nXsY9aocWC1TNv2aiqaKI1i/WonSQNjb/fPheAnev7KBPGz1WWA==
X-Google-Smtp-Source: AGHT+IGvQRPqdtitddhAH7dYOnsTmppCdPbG8itf0Ab7wZQh1Cw6Zi2zEZ225UNidjeKqRp2mO/oDQ==
X-Received: by 2002:a05:6870:d202:b0:254:b4a6:958d with SMTP id 586e51a60fabf-25db338f565mr417899fac.2.1719654489738;
        Sat, 29 Jun 2024 02:48:09 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804989f5asm2948932b3a.195.2024.06.29.02.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 02:48:09 -0700 (PDT)
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
Subject: [RFC bpf-next v1 4/8] selftests/bpf: extract utility function for BPF disassembly
Date: Sat, 29 Jun 2024 02:47:29 -0700
Message-ID: <20240629094733.3863850-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240629094733.3863850-1-eddyz87@gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uint32_t disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz);

  Disassembles instruction 'insn' to a text buffer 'buf'.
  Removes insn->code hex prefix added by kernel disassemly routine.
  Returns the length of decoded instruction (either 1 or 2).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          |  1 +
 tools/testing/selftests/bpf/disasm_helpers.c  | 50 +++++++++++++
 tools/testing/selftests/bpf/disasm_helpers.h  | 12 ++++
 .../selftests/bpf/prog_tests/ctx_rewrite.c    | 71 +++----------------
 tools/testing/selftests/bpf/testing_helpers.c |  1 +
 5 files changed, 72 insertions(+), 63 deletions(-)
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
index 000000000000..7c29d294a456
--- /dev/null
+++ b/tools/testing/selftests/bpf/disasm_helpers.c
@@ -0,0 +1,50 @@
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
+uint32_t disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)
+{
+	struct print_insn_context ctx = {
+		.buf = buf,
+		.sz = buf_sz,
+	};
+	struct bpf_insn_cbs cbs = {
+		.cb_print	= print_insn_cb,
+		.private_data	= &ctx,
+	};
+	int pfx_end, sfx_start, len;
+	bool double_insn;
+
+	print_bpf_insn(&cbs, insn, true);
+	/* We share code with kernel BPF disassembler, it adds '(FF) ' prefix
+	 * for each instruction (FF stands for instruction `code` byte).
+	 * Remove the prefix inplace, and also simplify call instructions.
+	 * E.g.: "(85) call foo#10" -> "call foo".
+	 */
+	pfx_end = 0;
+	sfx_start = max((int)strlen(buf) - 1, 0);
+	/* For whatever reason %n is not counted in sscanf return value */
+	sscanf(buf, "(%*[^)]) %n", &pfx_end);
+	sscanf(buf, "(%*[^)]) call %*[^#]%n", &sfx_start);
+	len = sfx_start - pfx_end;
+	memmove(buf, buf + pfx_end, len);
+	buf[len] = 0;
+	double_insn = insn->code == (BPF_LD | BPF_IMM | BPF_DW);
+	return double_insn ? 2 : 1;
+}
diff --git a/tools/testing/selftests/bpf/disasm_helpers.h b/tools/testing/selftests/bpf/disasm_helpers.h
new file mode 100644
index 000000000000..db3dfe9f93dd
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
+uint32_t disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz);
+
+#endif /* __DISASM_HELPERS_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c b/tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c
index 08b6391f2f56..55e41167f1f3 100644
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
@@ -702,8 +646,10 @@ static void match_program(struct btf *btf,
 	struct bpf_insn *buf = NULL;
 	int err = 0, prog_fd = 0;
 	FILE *prog_out = NULL;
+	char insn_buf[64];
 	char *text = NULL;
 	__u32 cnt = 0;
+	int i;
 
 	text = calloc(MAX_PROG_TEXT_SZ, 1);
 	if (!text) {
@@ -739,12 +685,11 @@ static void match_program(struct btf *btf,
 		PRINT_FAIL("Can't open memory stream\n");
 		goto out;
 	}
-	if (skip_first_insn)
-		print_xlated(prog_out, buf + 1, cnt - 1);
-	else
-		print_xlated(prog_out, buf, cnt);
+	for (i = skip_first_insn ? 1 : 0; i < cnt;) {
+		i += disasm_insn(buf + i, insn_buf, sizeof(insn_buf));
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


