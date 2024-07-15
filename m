Return-Path: <bpf+bounces-34856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CF6931D6E
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92978B21988
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 23:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A76144304;
	Mon, 15 Jul 2024 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBfaixrp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F8143C49
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084553; cv=none; b=otH3mixhUPcN+gafwehPjsbbaNTXqf0ekg/7PFYIZA+FQrdryr19nesQWIxQTSukE6vQ7GGdswTkBYJI/uTyDf4b9iOq3uscy18jlQM35Tdf39ZY6JJI5ZuHcC7CfC1ENWrnIeIE5rEhqxcX+bzEI97qWLGLsKSe43XcQJldkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084553; c=relaxed/simple;
	bh=qEWSHaY6YxLBfqtxrK2EEvtoM/35ocsIieGV3/yigcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PM6aXYGeSVy5EXqWR669BrXytNQs1hkVsVFqJkPie8gScGZEMNfj80RvY25qrXSB8ORLPLOSilEPetNehR2nB1tCYW0+KvGOhF6bf4jrPyDNdCt5sj3HAwQI5tqSD+TufLrPaKhHY1jsU3yXjfZRzqoZT0YXaCpbuiu6pnIKnmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBfaixrp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-706a1711ee5so3259065b3a.0
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 16:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721084551; x=1721689351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OS8NdMPZNHGoTxtKNDKNnwmxe8ypUk8+Q4SCQfNAw4=;
        b=cBfaixrpkFY264zZp1QR7Q3OVMsb6TvQLy4S9blEFsG9LmCGiqrinKI7FZjPyaAWIi
         OepDkvAMgEPnzdctoHlEkCt2UVJitrB6Y+Awaa93s8asXLhLFzrqhhUTgLAirOiRNt4w
         2EMOuxfwXgVk8VC0X/ZeXpCRFPgZjVXb9xYYi66zDGyZcbaAyhN7vQ7Lpp4lVFpoI23n
         FKC99flC/3VeRz9tV0rYN9iYXOFfg5R7f/k2oaTyWXLYTNezJVW9S82lA6UD+6JAZoLy
         OBu+BBV9NaktqDWuy4X5MKCKy5xRuxtJZyCYHVCebnlSN7pAFePP0abZ1V5pQAPtxcgB
         WvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721084551; x=1721689351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OS8NdMPZNHGoTxtKNDKNnwmxe8ypUk8+Q4SCQfNAw4=;
        b=GFUVdFyDhjUvT2j9jcKItkSCfKovn6odU5799ftMLs8owJ7zWVTh+KObUyoz8QHd+3
         /VyixC+//oOZoj2feEQJk1ASwBfgUv1pZiacLOFfIBgBwu8c+NfB/YM618kGBEbi1NPi
         0q/W08ovffD5OP4XwPlCI8/zKF5+tgKjsLUOTw/d6cGlL5A/jFLAmHZKWlQNI5hnbgsO
         cD/UJFTSZqqAseDIMXPR8l7Qbk5Hrwk9ufODbqMBTYicoE/KFdY0pTfCWz40DT9QqW2U
         pUfOAOIYzVkZLVHJTDegWx7+YN1UMBrQG+yAQMD2PKhpgRUTFrhCNPTHY2Vxlc+1wtdm
         70lQ==
X-Gm-Message-State: AOJu0YzupvXsRJDnCP0w3kFvy+YW5nMF1xCjWqPLL9HcHBVYWoGpUB98
	MRAaKpodLO5KsQKqngjgxB2rNMfcwhxvPvN7Sw1D53N6kVwnulfpfmci0w==
X-Google-Smtp-Source: AGHT+IEDGjLtoxEje4Dh6ZDX+LrG9smbQY6/qt4QvvdfB06GmUS5pKrsvuXNeqRcp9D+Fjkd4CymTw==
X-Received: by 2002:a05:6a00:4f85:b0:705:e5da:8293 with SMTP id d2e1a72fcca58-70c1fba11c6mr639165b3a.12.1721084551019;
        Mon, 15 Jul 2024 16:02:31 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc9d36sm4915344b3a.205.2024.07.15.16.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:02:30 -0700 (PDT)
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
Subject: [bpf-next v3 04/12] selftests/bpf: extract utility function for BPF disassembly
Date: Mon, 15 Jul 2024 16:01:53 -0700
Message-ID: <20240715230201.3901423-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715230201.3901423-1-eddyz87@gmail.com>
References: <20240715230201.3901423-1-eddyz87@gmail.com>
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
index dd49c1d23a60..fcacc693ed8a 100644
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


