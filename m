Return-Path: <bpf+bounces-69975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB32BAA6A7
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 21:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5923B29CD
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 19:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A616D25228B;
	Mon, 29 Sep 2025 19:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4WogKpa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2524BD0C
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172926; cv=none; b=UyTc81E1Tk5RLkDJwZ4Jtd/vTGepZq2MCyfM9AhupkKOQhS7U5TpbyQd5KKJ3339uBNkbawAcXOLEeA10I1ZYruh9XjdJAlwvkRJOsZQVM6F2d6Wv7pNLmdd7QBXzPJg+t1VMhaSCe2t7XSKO7f7CdfmSrsl9tk40jFq7BuSyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172926; c=relaxed/simple;
	bh=sG7GXj9dZWPgoweAiBVtaxLXGry2kM2zSMgSFDKWukw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pH7kELT8K7orrNDxeVuXPiAT7YHQnIevw0pda8np+XF/Z77P7NR7kqMfnDIyMn57H3MM2NCW74ySX+3gisgf9iKp6S9FXxHxJdMaX4tdtxWZ+OBDlR98cpHdJXB15CfpW7MW7paocI0uYjmE0XpxsTBL+AIHeVWj3rAaGdiD/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4WogKpa; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-272b7bdf41fso52951815ad.0
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759172922; x=1759777722; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J33L4M07H2Lw9WZtW+pVpjZvTY7fnFzmKJOxPiOQosU=;
        b=B4WogKpat9iZZopgka7/ZjDwfii4Rbl/mCp6pnEwIIES0OMRUjlslWRomgwMvft5CW
         Pu1GTmG1Kdh9WA2VMayrGOc89g2c3V8zG2w73XS3Bp1y9Fok9nNRaCV8nf5F16x84R9z
         u9sRhzu57rXzmdsQfDaBzz4Gj0+Asv+MjkmvLUYr8viS+KtqWm+Y+4E+x94nuP7PPL5e
         Gv7OIY1ZQlS2NCTKllXnVm1KWxpTFeAct8AGePRv1retaNzpq+HA3WKUrMJGkaApDMRK
         lRtIvW/iTNZ8H+FVMcsY5DRSGuPqgqD5GlOg7IrBxasPzoqiBxRP7e3NBr/KW+Jq3xJv
         8OCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759172922; x=1759777722;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J33L4M07H2Lw9WZtW+pVpjZvTY7fnFzmKJOxPiOQosU=;
        b=P2CIqGizlGtIqgvGFwxbt0HROwU5kiE4RbC/XWq22kWmYNTSkPLGHdzlsTSpSVS3IQ
         Om+UwjywaDGF8WDZ/OUnxA82sKvSfwuAFnSCkhiwUJc02aAQ+ODKTEVZyvO6PquZtsoO
         cIwaEmSw65vWmWauZId8pS5zB2yI36W9Y8oRKHVbkFORFquMHzDW0o2RZq/u0vPq8Ah7
         12k/z4Zy5XQz4kVOj/bciGV7PKIBw1V82yGBAUkzRfNf8ZSH5rqMfQDQriQ4yUrTuTbi
         ZNAOF7e62/qiJVjdCf3rtn1FzUExDshd3vn+geeQLQjOx/1XXmCjB9UBo9L4hN57VXOO
         7Qmw==
X-Forwarded-Encrypted: i=1; AJvYcCWsJKgXsx1dHvPxByFJ1TeL2nYZZOa0ur+q8Eh0JYTo+SZJNjS0eSup7Tqxej3lGjWm3Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySrF0QNMVvNyC4cISpPkA7h2NxDpirHwkTykr8HqH8BYlxz1Sr
	AMFjfLQIsIeMeA3q0+xMACPE5UpI135KV+mphhv8wJR/PJBKwKT1i5g3ornipR484TbJXScJW4j
	xDphebfskKA==
X-Google-Smtp-Source: AGHT+IEQjzs/CagmcVqOtXMdd616zkKpRk3siJg1YZORZiilUy81aMWHjOhgnzp447Lgxr4TMVOxzst/qaPz
X-Received: from pgbcz14.prod.google.com ([2002:a05:6a02:230e:b0:b55:1827:9212])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c0d:b0:275:27ab:f6c4
 with SMTP id d9443c01a7336-27ed4a315b5mr204239165ad.33.1759172921696; Mon, 29
 Sep 2025 12:08:41 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:07:54 -0700
In-Reply-To: <20250929190805.201446-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250929190805.201446-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250929190805.201446-5-irogers@google.com>
Subject: [PATCH v6 04/15] perf libbfd: Move libbfd functionality to its own file
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Move symbolization and srcline libbfd dependencies to a separate
libbfd.c. This mirrors moving llvm and capstone code. While this code
is deprecated as it is part of BUILD_NONDISTRO license incompatible
code, moving the code to its own file minimizes disruption in the main
files.

disasm_bpf.c is moved to libbfd.c also except for
symbol__disassemble_bpf_image which is currently more of a placeholder
function rather than something that provides disassembly support.

demangle-cxx.cpp code isn't migrated as it is very limited.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config   |   1 +
 tools/perf/util/Build        |   2 +-
 tools/perf/util/disasm.c     |  19 +-
 tools/perf/util/disasm_bpf.c | 195 ------------
 tools/perf/util/disasm_bpf.h |  12 -
 tools/perf/util/libbfd.c     | 600 +++++++++++++++++++++++++++++++++++
 tools/perf/util/libbfd.h     |  83 +++++
 tools/perf/util/srcline.c    | 232 +-------------
 tools/perf/util/srcline.h    |   2 +
 tools/perf/util/symbol-elf.c | 100 +-----
 tools/perf/util/symbol.c     | 131 --------
 11 files changed, 718 insertions(+), 659 deletions(-)
 delete mode 100644 tools/perf/util/disasm_bpf.c
 delete mode 100644 tools/perf/util/disasm_bpf.h
 create mode 100644 tools/perf/util/libbfd.c
 create mode 100644 tools/perf/util/libbfd.h

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7bc2341295c3..1907d1c70b68 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -947,6 +947,7 @@ ifdef BUILD_NONDISTRO
 
   CFLAGS += -DHAVE_LIBBFD_SUPPORT
   CXXFLAGS += -DHAVE_LIBBFD_SUPPORT
+  $(call detected,CONFIG_LIBBFD)
 
   $(call feature_check,libbfd-buildid)
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 63160c4a517e..bb2023a3d0c9 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -14,7 +14,6 @@ perf-util-y += copyfile.o
 perf-util-y += ctype.o
 perf-util-y += db-export.o
 perf-util-y += disasm.o
-perf-util-y += disasm_bpf.o
 perf-util-y += env.o
 perf-util-y += event.o
 perf-util-y += evlist.o
@@ -26,6 +25,7 @@ perf-util-y += evswitch.o
 perf-util-y += find_bit.o
 perf-util-y += get_current_dir_name.o
 perf-util-y += levenshtein.o
+perf-util-$(CONFIG_LIBBFD) += libbfd.o
 perf-util-y += llvm.o
 perf-util-y += mmap.o
 perf-util-y += memswap.o
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index fa6accd8d873..a1240543c89c 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -17,11 +17,11 @@
 #include "capstone.h"
 #include "debug.h"
 #include "disasm.h"
-#include "disasm_bpf.h"
 #include "dso.h"
 #include "dwarf-regs.h"
 #include "env.h"
 #include "evsel.h"
+#include "libbfd.h"
 #include "llvm.h"
 #include "map.h"
 #include "maps.h"
@@ -1480,6 +1480,23 @@ char *expand_tabs(char *line, char **storage, size_t *storage_len)
 	return new_line;
 }
 
+static int symbol__disassemble_bpf_image(struct symbol *sym, struct annotate_args *args)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct disasm_line *dl;
+
+	args->offset = -1;
+	args->line = strdup("to be implemented");
+	args->line_nr = 0;
+	args->fileloc = NULL;
+	dl = disasm_line__new(args);
+	if (dl)
+		annotation_line__add(&dl->al, &notes->src->source);
+
+	zfree(&args->line);
+	return 0;
+}
+
 static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 				       struct annotate_args *args)
 {
diff --git a/tools/perf/util/disasm_bpf.c b/tools/perf/util/disasm_bpf.c
deleted file mode 100644
index 1fee71c79b62..000000000000
--- a/tools/perf/util/disasm_bpf.c
+++ /dev/null
@@ -1,195 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-#include "util/annotate.h"
-#include "util/disasm_bpf.h"
-#include "util/symbol.h"
-#include <linux/zalloc.h>
-#include <string.h>
-
-#if defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
-#define PACKAGE "perf"
-#include <bfd.h>
-#include <bpf/bpf.h>
-#include <bpf/btf.h>
-#include <bpf/libbpf.h>
-#include <dis-asm.h>
-#include <errno.h>
-#include <linux/btf.h>
-#include <tools/dis-asm-compat.h>
-
-#include "util/bpf-event.h"
-#include "util/bpf-utils.h"
-#include "util/debug.h"
-#include "util/dso.h"
-#include "util/map.h"
-#include "util/env.h"
-#include "util/util.h"
-
-int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *args)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	struct bpf_prog_linfo *prog_linfo = NULL;
-	struct bpf_prog_info_node *info_node;
-	int len = sym->end - sym->start;
-	disassembler_ftype disassemble;
-	struct map *map = args->ms.map;
-	struct perf_bpil *info_linear;
-	struct disassemble_info info;
-	struct dso *dso = map__dso(map);
-	int pc = 0, count, sub_id;
-	struct btf *btf = NULL;
-	char tpath[PATH_MAX];
-	size_t buf_size;
-	int nr_skip = 0;
-	char *buf;
-	bfd *bfdf;
-	int ret;
-	FILE *s;
-
-	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BPF_PROG_INFO)
-		return SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE;
-
-	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
-		  sym->name, sym->start, sym->end - sym->start);
-
-	memset(tpath, 0, sizeof(tpath));
-	perf_exe(tpath, sizeof(tpath));
-
-	bfdf = bfd_openr(tpath, NULL);
-	if (bfdf == NULL)
-		abort();
-
-	if (!bfd_check_format(bfdf, bfd_object))
-		abort();
-
-	s = open_memstream(&buf, &buf_size);
-	if (!s) {
-		ret = errno;
-		goto out;
-	}
-	init_disassemble_info_compat(&info, s,
-				     (fprintf_ftype) fprintf,
-				     fprintf_styled);
-	info.arch = bfd_get_arch(bfdf);
-	info.mach = bfd_get_mach(bfdf);
-
-	info_node = perf_env__find_bpf_prog_info(dso__bpf_prog(dso)->env,
-						 dso__bpf_prog(dso)->id);
-	if (!info_node) {
-		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
-		goto out;
-	}
-	info_linear = info_node->info_linear;
-	sub_id = dso__bpf_prog(dso)->sub_id;
-
-	info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
-	info.buffer_length = info_linear->info.jited_prog_len;
-
-	if (info_linear->info.nr_line_info)
-		prog_linfo = bpf_prog_linfo__new(&info_linear->info);
-
-	if (info_linear->info.btf_id) {
-		struct btf_node *node;
-
-		node = perf_env__find_btf(dso__bpf_prog(dso)->env,
-					  info_linear->info.btf_id);
-		if (node)
-			btf = btf__new((__u8 *)(node->data),
-				       node->data_size);
-	}
-
-	disassemble_init_for_target(&info);
-
-#ifdef DISASM_FOUR_ARGS_SIGNATURE
-	disassemble = disassembler(info.arch,
-				   bfd_big_endian(bfdf),
-				   info.mach,
-				   bfdf);
-#else
-	disassemble = disassembler(bfdf);
-#endif
-	if (disassemble == NULL)
-		abort();
-
-	fflush(s);
-	do {
-		const struct bpf_line_info *linfo = NULL;
-		struct disasm_line *dl;
-		size_t prev_buf_size;
-		const char *srcline;
-		u64 addr;
-
-		addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
-		count = disassemble(pc, &info);
-
-		if (prog_linfo)
-			linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
-								addr, sub_id,
-								nr_skip);
-
-		if (linfo && btf) {
-			srcline = btf__name_by_offset(btf, linfo->line_off);
-			nr_skip++;
-		} else
-			srcline = NULL;
-
-		fprintf(s, "\n");
-		prev_buf_size = buf_size;
-		fflush(s);
-
-		if (!annotate_opts.hide_src_code && srcline) {
-			args->offset = -1;
-			args->line = strdup(srcline);
-			args->line_nr = 0;
-			args->fileloc = NULL;
-			args->ms.sym  = sym;
-			dl = disasm_line__new(args);
-			if (dl) {
-				annotation_line__add(&dl->al,
-						     &notes->src->source);
-			}
-		}
-
-		args->offset = pc;
-		args->line = buf + prev_buf_size;
-		args->line_nr = 0;
-		args->fileloc = NULL;
-		args->ms.sym  = sym;
-		dl = disasm_line__new(args);
-		if (dl)
-			annotation_line__add(&dl->al, &notes->src->source);
-
-		pc += count;
-	} while (count > 0 && pc < len);
-
-	ret = 0;
-out:
-	free(prog_linfo);
-	btf__free(btf);
-	fclose(s);
-	bfd_close(bfdf);
-	return ret;
-}
-#else // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
-int symbol__disassemble_bpf(struct symbol *sym __maybe_unused, struct annotate_args *args __maybe_unused)
-{
-	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
-}
-#endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
-
-int symbol__disassemble_bpf_image(struct symbol *sym, struct annotate_args *args)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	struct disasm_line *dl;
-
-	args->offset = -1;
-	args->line = strdup("to be implemented");
-	args->line_nr = 0;
-	args->fileloc = NULL;
-	dl = disasm_line__new(args);
-	if (dl)
-		annotation_line__add(&dl->al, &notes->src->source);
-
-	zfree(&args->line);
-	return 0;
-}
diff --git a/tools/perf/util/disasm_bpf.h b/tools/perf/util/disasm_bpf.h
deleted file mode 100644
index 2ecb19545388..000000000000
--- a/tools/perf/util/disasm_bpf.h
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-#ifndef __PERF_DISASM_BPF_H
-#define __PERF_DISASM_BPF_H
-
-struct symbol;
-struct annotate_args;
-
-int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *args);
-int symbol__disassemble_bpf_image(struct symbol *sym, struct annotate_args *args);
-
-#endif /* __PERF_DISASM_BPF_H */
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
new file mode 100644
index 000000000000..09a0eeb78a1a
--- /dev/null
+++ b/tools/perf/util/libbfd.c
@@ -0,0 +1,600 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "libbfd.h"
+#include "annotate.h"
+#include "bpf-event.h"
+#include "bpf-utils.h"
+#include "debug.h"
+#include "dso.h"
+#include "env.h"
+#include "map.h"
+#include "srcline.h"
+#include "symbol.h"
+#include "symbol_conf.h"
+#include "util.h"
+#include <tools/dis-asm-compat.h>
+#ifdef HAVE_LIBBPF_SUPPORT
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#endif
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#define PACKAGE "perf"
+#include <bfd.h>
+
+/*
+ * Implement addr2line using libbfd.
+ */
+struct a2l_data {
+	const char *input;
+	u64 addr;
+
+	bool found;
+	const char *filename;
+	const char *funcname;
+	unsigned int line;
+
+	bfd *abfd;
+	asymbol **syms;
+};
+
+static int bfd_error(const char *string)
+{
+	const char *errmsg;
+
+	errmsg = bfd_errmsg(bfd_get_error());
+	fflush(stdout);
+
+	if (string)
+		pr_debug("%s: %s\n", string, errmsg);
+	else
+		pr_debug("%s\n", errmsg);
+
+	return -1;
+}
+
+static int slurp_symtab(bfd *abfd, struct a2l_data *a2l)
+{
+	long storage;
+	long symcount;
+	asymbol **syms;
+	bfd_boolean dynamic = FALSE;
+
+	if ((bfd_get_file_flags(abfd) & HAS_SYMS) == 0)
+		return bfd_error(bfd_get_filename(abfd));
+
+	storage = bfd_get_symtab_upper_bound(abfd);
+	if (storage == 0L) {
+		storage = bfd_get_dynamic_symtab_upper_bound(abfd);
+		dynamic = TRUE;
+	}
+	if (storage < 0L)
+		return bfd_error(bfd_get_filename(abfd));
+
+	syms = malloc(storage);
+	if (dynamic)
+		symcount = bfd_canonicalize_dynamic_symtab(abfd, syms);
+	else
+		symcount = bfd_canonicalize_symtab(abfd, syms);
+
+	if (symcount < 0) {
+		free(syms);
+		return bfd_error(bfd_get_filename(abfd));
+	}
+
+	a2l->syms = syms;
+	return 0;
+}
+
+static void find_address_in_section(bfd *abfd, asection *section, void *data)
+{
+	bfd_vma pc, vma;
+	bfd_size_type size;
+	struct a2l_data *a2l = data;
+	flagword flags;
+
+	if (a2l->found)
+		return;
+
+#ifdef bfd_get_section_flags
+	flags = bfd_get_section_flags(abfd, section);
+#else
+	flags = bfd_section_flags(section);
+#endif
+	if ((flags & SEC_ALLOC) == 0)
+		return;
+
+	pc = a2l->addr;
+#ifdef bfd_get_section_vma
+	vma = bfd_get_section_vma(abfd, section);
+#else
+	vma = bfd_section_vma(section);
+#endif
+#ifdef bfd_get_section_size
+	size = bfd_get_section_size(section);
+#else
+	size = bfd_section_size(section);
+#endif
+
+	if (pc < vma || pc >= vma + size)
+		return;
+
+	a2l->found = bfd_find_nearest_line(abfd, section, a2l->syms, pc - vma,
+					   &a2l->filename, &a2l->funcname,
+					   &a2l->line);
+
+	if (a2l->filename && !strlen(a2l->filename))
+		a2l->filename = NULL;
+}
+
+static struct a2l_data *addr2line_init(const char *path)
+{
+	bfd *abfd;
+	struct a2l_data *a2l = NULL;
+
+	abfd = bfd_openr(path, NULL);
+	if (abfd == NULL)
+		return NULL;
+
+	if (!bfd_check_format(abfd, bfd_object))
+		goto out;
+
+	a2l = zalloc(sizeof(*a2l));
+	if (a2l == NULL)
+		goto out;
+
+	a2l->abfd = abfd;
+	a2l->input = strdup(path);
+	if (a2l->input == NULL)
+		goto out;
+
+	if (slurp_symtab(abfd, a2l))
+		goto out;
+
+	return a2l;
+
+out:
+	if (a2l) {
+		zfree((char **)&a2l->input);
+		free(a2l);
+	}
+	bfd_close(abfd);
+	return NULL;
+}
+
+static void addr2line_cleanup(struct a2l_data *a2l)
+{
+	if (a2l->abfd)
+		bfd_close(a2l->abfd);
+	zfree((char **)&a2l->input);
+	zfree(&a2l->syms);
+	free(a2l);
+}
+
+static int inline_list__append_dso_a2l(struct dso *dso,
+				       struct inline_node *node,
+				       struct symbol *sym)
+{
+	struct a2l_data *a2l = dso__a2l(dso);
+	struct symbol *inline_sym = new_inline_sym(dso, sym, a2l->funcname);
+	char *srcline = NULL;
+
+	if (a2l->filename)
+		srcline = srcline_from_fileline(a2l->filename, a2l->line);
+
+	return inline_list__append(inline_sym, srcline, node);
+}
+
+int libbfd__addr2line(const char *dso_name, u64 addr,
+		      char **file, unsigned int *line, struct dso *dso,
+		      bool unwind_inlines, struct inline_node *node,
+		      struct symbol *sym)
+{
+	int ret = 0;
+	struct a2l_data *a2l = dso__a2l(dso);
+
+	if (!a2l) {
+		a2l = addr2line_init(dso_name);
+		dso__set_a2l(dso, a2l);
+	}
+
+	if (a2l == NULL) {
+		if (!symbol_conf.disable_add2line_warn)
+			pr_warning("addr2line_init failed for %s\n", dso_name);
+		return 0;
+	}
+
+	a2l->addr = addr;
+	a2l->found = false;
+
+	bfd_map_over_sections(a2l->abfd, find_address_in_section, a2l);
+
+	if (!a2l->found)
+		return 0;
+
+	if (unwind_inlines) {
+		int cnt = 0;
+
+		if (node && inline_list__append_dso_a2l(dso, node, sym))
+			return 0;
+
+		while (bfd_find_inliner_info(a2l->abfd, &a2l->filename,
+					     &a2l->funcname, &a2l->line) &&
+		       cnt++ < MAX_INLINE_NEST) {
+
+			if (a2l->filename && !strlen(a2l->filename))
+				a2l->filename = NULL;
+
+			if (node != NULL) {
+				if (inline_list__append_dso_a2l(dso, node, sym))
+					return 0;
+				// found at least one inline frame
+				ret = 1;
+			}
+		}
+	}
+
+	if (file) {
+		*file = a2l->filename ? strdup(a2l->filename) : NULL;
+		ret = *file ? 1 : 0;
+	}
+
+	if (line)
+		*line = a2l->line;
+
+	return ret;
+}
+
+void dso__free_a2l_libbfd(struct dso *dso)
+{
+	struct a2l_data *a2l = dso__a2l(dso);
+
+	if (!a2l)
+		return;
+
+	addr2line_cleanup(a2l);
+
+	dso__set_a2l(dso, NULL);
+}
+
+static int bfd_symbols__cmpvalue(const void *a, const void *b)
+{
+	const asymbol *as = *(const asymbol **)a, *bs = *(const asymbol **)b;
+
+	if (bfd_asymbol_value(as) != bfd_asymbol_value(bs))
+		return bfd_asymbol_value(as) - bfd_asymbol_value(bs);
+
+	return bfd_asymbol_name(as)[0] - bfd_asymbol_name(bs)[0];
+}
+
+static int bfd2elf_binding(asymbol *symbol)
+{
+	if (symbol->flags & BSF_WEAK)
+		return STB_WEAK;
+	if (symbol->flags & BSF_GLOBAL)
+		return STB_GLOBAL;
+	if (symbol->flags & BSF_LOCAL)
+		return STB_LOCAL;
+	return -1;
+}
+
+int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
+{
+	int err = -1;
+	long symbols_size, symbols_count, i;
+	asection *section;
+	asymbol **symbols, *sym;
+	struct symbol *symbol;
+	bfd *abfd;
+	u64 start, len;
+
+	abfd = bfd_openr(debugfile, NULL);
+	if (!abfd)
+		return -1;
+
+	if (!bfd_check_format(abfd, bfd_object)) {
+		pr_debug2("%s: cannot read %s bfd file.\n", __func__,
+			  dso__long_name(dso));
+		goto out_close;
+	}
+
+	if (bfd_get_flavour(abfd) == bfd_target_elf_flavour)
+		goto out_close;
+
+	symbols_size = bfd_get_symtab_upper_bound(abfd);
+	if (symbols_size == 0) {
+		bfd_close(abfd);
+		return 0;
+	}
+
+	if (symbols_size < 0)
+		goto out_close;
+
+	symbols = malloc(symbols_size);
+	if (!symbols)
+		goto out_close;
+
+	symbols_count = bfd_canonicalize_symtab(abfd, symbols);
+	if (symbols_count < 0)
+		goto out_free;
+
+	section = bfd_get_section_by_name(abfd, ".text");
+	if (section) {
+		for (i = 0; i < symbols_count; ++i) {
+			if (!strcmp(bfd_asymbol_name(symbols[i]), "__ImageBase") ||
+			    !strcmp(bfd_asymbol_name(symbols[i]), "__image_base__"))
+				break;
+		}
+		if (i < symbols_count) {
+			/* PE symbols can only have 4 bytes, so use .text high bits */
+			u64 text_offset = (section->vma - (u32)section->vma)
+				+ (u32)bfd_asymbol_value(symbols[i]);
+			dso__set_text_offset(dso, text_offset);
+			dso__set_text_end(dso, (section->vma - text_offset) + section->size);
+		} else {
+			dso__set_text_offset(dso, section->vma - section->filepos);
+			dso__set_text_end(dso, section->filepos + section->size);
+		}
+	}
+
+	qsort(symbols, symbols_count, sizeof(asymbol *), bfd_symbols__cmpvalue);
+
+#ifdef bfd_get_section
+#define bfd_asymbol_section bfd_get_section
+#endif
+	for (i = 0; i < symbols_count; ++i) {
+		sym = symbols[i];
+		section = bfd_asymbol_section(sym);
+		if (bfd2elf_binding(sym) < 0)
+			continue;
+
+		while (i + 1 < symbols_count &&
+		       bfd_asymbol_section(symbols[i + 1]) == section &&
+		       bfd2elf_binding(symbols[i + 1]) < 0)
+			i++;
+
+		if (i + 1 < symbols_count &&
+		    bfd_asymbol_section(symbols[i + 1]) == section)
+			len = symbols[i + 1]->value - sym->value;
+		else
+			len = section->size - sym->value;
+
+		start = bfd_asymbol_value(sym) - dso__text_offset(dso);
+		symbol = symbol__new(start, len, bfd2elf_binding(sym), STT_FUNC,
+				     bfd_asymbol_name(sym));
+		if (!symbol)
+			goto out_free;
+
+		symbols__insert(dso__symbols(dso), symbol);
+	}
+#ifdef bfd_get_section
+#undef bfd_asymbol_section
+#endif
+
+	symbols__fixup_end(dso__symbols(dso), false);
+	symbols__fixup_duplicate(dso__symbols(dso));
+	dso__set_adjust_symbols(dso, true);
+
+	err = 0;
+out_free:
+	free(symbols);
+out_close:
+	bfd_close(abfd);
+	return err;
+}
+
+int libbfd__read_build_id(const char *filename, struct build_id *bid, bool block)
+{
+	size_t size = sizeof(bid->data);
+	int err = -1, fd;
+	bfd *abfd;
+
+	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
+	if (fd < 0)
+		return -1;
+
+	abfd = bfd_fdopenr(filename, /*target=*/NULL, fd);
+	if (!abfd)
+		return -1;
+
+	if (!bfd_check_format(abfd, bfd_object)) {
+		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
+		goto out_close;
+	}
+
+	if (!abfd->build_id || abfd->build_id->size > size)
+		goto out_close;
+
+	memcpy(bid->data, abfd->build_id->data, abfd->build_id->size);
+	memset(bid->data + abfd->build_id->size, 0, size - abfd->build_id->size);
+	err = bid->size = abfd->build_id->size;
+
+out_close:
+	bfd_close(abfd);
+	return err;
+}
+
+int libbfd_filename__read_debuglink(const char *filename, char *debuglink,
+				    size_t size)
+{
+	int err = -1;
+	asection *section;
+	bfd *abfd;
+
+	abfd = bfd_openr(filename, NULL);
+	if (!abfd)
+		return -1;
+
+	if (!bfd_check_format(abfd, bfd_object)) {
+		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
+		goto out_close;
+	}
+
+	section = bfd_get_section_by_name(abfd, ".gnu_debuglink");
+	if (!section)
+		goto out_close;
+
+	if (section->size > size)
+		goto out_close;
+
+	if (!bfd_get_section_contents(abfd, section, debuglink, 0,
+				      section->size))
+		goto out_close;
+
+	err = 0;
+
+out_close:
+	bfd_close(abfd);
+	return err;
+}
+
+int symbol__disassemble_bpf(struct symbol *sym __maybe_unused,
+			    struct annotate_args *args  __maybe_unused)
+{
+#ifdef HAVE_LIBBPF_SUPPORT
+	struct annotation *notes = symbol__annotation(sym);
+	struct bpf_prog_linfo *prog_linfo = NULL;
+	struct bpf_prog_info_node *info_node;
+	int len = sym->end - sym->start;
+	disassembler_ftype disassemble;
+	struct map *map = args->ms.map;
+	struct perf_bpil *info_linear;
+	struct disassemble_info info;
+	struct dso *dso = map__dso(map);
+	int pc = 0, count, sub_id;
+	struct btf *btf = NULL;
+	char tpath[PATH_MAX];
+	size_t buf_size;
+	int nr_skip = 0;
+	char *buf;
+	bfd *bfdf;
+	int ret;
+	FILE *s;
+
+	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE;
+
+	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
+		  sym->name, sym->start, sym->end - sym->start);
+
+	memset(tpath, 0, sizeof(tpath));
+	perf_exe(tpath, sizeof(tpath));
+
+	bfdf = bfd_openr(tpath, NULL);
+	if (bfdf == NULL)
+		abort();
+
+	if (!bfd_check_format(bfdf, bfd_object))
+		abort();
+
+	s = open_memstream(&buf, &buf_size);
+	if (!s) {
+		ret = errno;
+		goto out;
+	}
+	init_disassemble_info_compat(&info, s,
+				     (fprintf_ftype) fprintf,
+				     fprintf_styled);
+	info.arch = bfd_get_arch(bfdf);
+	info.mach = bfd_get_mach(bfdf);
+
+	info_node = perf_env__find_bpf_prog_info(dso__bpf_prog(dso)->env,
+						 dso__bpf_prog(dso)->id);
+	if (!info_node) {
+		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+		goto out;
+	}
+	info_linear = info_node->info_linear;
+	sub_id = dso__bpf_prog(dso)->sub_id;
+
+	info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
+	info.buffer_length = info_linear->info.jited_prog_len;
+
+	if (info_linear->info.nr_line_info)
+		prog_linfo = bpf_prog_linfo__new(&info_linear->info);
+
+	if (info_linear->info.btf_id) {
+		struct btf_node *node;
+
+		node = perf_env__find_btf(dso__bpf_prog(dso)->env,
+					  info_linear->info.btf_id);
+		if (node)
+			btf = btf__new((__u8 *)(node->data),
+				       node->data_size);
+	}
+
+	disassemble_init_for_target(&info);
+
+#ifdef DISASM_FOUR_ARGS_SIGNATURE
+	disassemble = disassembler(info.arch,
+				   bfd_big_endian(bfdf),
+				   info.mach,
+				   bfdf);
+#else
+	disassemble = disassembler(bfdf);
+#endif
+	if (disassemble == NULL)
+		abort();
+
+	fflush(s);
+	do {
+		const struct bpf_line_info *linfo = NULL;
+		struct disasm_line *dl;
+		size_t prev_buf_size;
+		const char *srcline;
+		u64 addr;
+
+		addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
+		count = disassemble(pc, &info);
+
+		if (prog_linfo)
+			linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
+								addr, sub_id,
+								nr_skip);
+
+		if (linfo && btf) {
+			srcline = btf__name_by_offset(btf, linfo->line_off);
+			nr_skip++;
+		} else
+			srcline = NULL;
+
+		fprintf(s, "\n");
+		prev_buf_size = buf_size;
+		fflush(s);
+
+		if (!annotate_opts.hide_src_code && srcline) {
+			args->offset = -1;
+			args->line = strdup(srcline);
+			args->line_nr = 0;
+			args->fileloc = NULL;
+			args->ms.sym  = sym;
+			dl = disasm_line__new(args);
+			if (dl) {
+				annotation_line__add(&dl->al,
+						     &notes->src->source);
+			}
+		}
+
+		args->offset = pc;
+		args->line = buf + prev_buf_size;
+		args->line_nr = 0;
+		args->fileloc = NULL;
+		args->ms.sym  = sym;
+		dl = disasm_line__new(args);
+		if (dl)
+			annotation_line__add(&dl->al, &notes->src->source);
+
+		pc += count;
+	} while (count > 0 && pc < len);
+
+	ret = 0;
+out:
+	free(prog_linfo);
+	btf__free(btf);
+	fclose(s);
+	bfd_close(bfdf);
+	return ret;
+#else
+	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
+#endif
+}
diff --git a/tools/perf/util/libbfd.h b/tools/perf/util/libbfd.h
new file mode 100644
index 000000000000..7441e95f8ec0
--- /dev/null
+++ b/tools/perf/util/libbfd.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_LIBBFD_H
+#define __PERF_LIBBFD_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <stdbool.h>
+#include <stddef.h>
+
+struct annotate_args;
+struct build_id;
+struct dso;
+struct inline_node;
+struct symbol;
+
+#ifdef HAVE_LIBBFD_SUPPORT
+int libbfd__addr2line(const char *dso_name, u64 addr,
+		char **file, unsigned int *line, struct dso *dso,
+		bool unwind_inlines, struct inline_node *node,
+		struct symbol *sym);
+
+
+void dso__free_a2l_libbfd(struct dso *dso);
+
+int symbol__disassemble_libbfd(const char *filename, struct symbol *sym,
+			     struct annotate_args *args);
+
+int libbfd__read_build_id(const char *filename, struct build_id *bid, bool block);
+
+int libbfd_filename__read_debuglink(const char *filename, char *debuglink, size_t size);
+
+int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *args);
+
+#else // !defined(HAVE_LIBBFD_SUPPORT)
+#include "annotate.h"
+
+static inline int libbfd__addr2line(const char *dso_name __always_unused,
+				u64 addr __always_unused,
+				char **file __always_unused,
+				unsigned int *line __always_unused,
+				struct dso *dso __always_unused,
+				bool unwind_inlines __always_unused,
+				struct inline_node *node __always_unused,
+				struct symbol *sym __always_unused)
+{
+	return -1;
+}
+
+
+static inline void dso__free_a2l_libbfd(struct dso *dso __always_unused)
+{
+}
+
+static inline int symbol__disassemble_libbfd(const char *filename __always_unused,
+					struct symbol *sym __always_unused,
+					struct annotate_args *args __always_unused)
+{
+	return -1;
+}
+
+static inline int libbfd__read_build_id(const char *filename __always_unused,
+					struct build_id *bid __always_unused,
+					bool block __always_unused)
+{
+	return -1;
+}
+
+static inline int libbfd_filename__read_debuglink(const char *filename __always_unused,
+						char *debuglink __always_unused,
+						size_t size __always_unused)
+{
+	return -1;
+}
+
+static inline int symbol__disassemble_bpf(struct symbol *sym __always_unused,
+					  struct annotate_args *args __always_unused)
+{
+	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
+}
+
+#endif // defined(HAVE_LIBBFD_SUPPORT)
+
+#endif /* __PERF_LIBBFD_H */
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 45e138ff3e52..23b942d4729e 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -129,8 +129,6 @@ struct symbol *new_inline_sym(struct dso *dso,
 	return inline_sym;
 }
 
-#define MAX_INLINE_NEST 1024
-
 #ifdef HAVE_LIBLLVM_SUPPORT
 #include "llvm.h"
 
@@ -147,243 +145,19 @@ void dso__free_a2l(struct dso *dso)
 	dso__free_a2l_llvm(dso);
 }
 #elif defined(HAVE_LIBBFD_SUPPORT)
-
-/*
- * Implement addr2line using libbfd.
- */
-#define PACKAGE "perf"
-#include <bfd.h>
-
-struct a2l_data {
-	const char 	*input;
-	u64	 	addr;
-
-	bool 		found;
-	const char 	*filename;
-	const char 	*funcname;
-	unsigned 	line;
-
-	bfd 		*abfd;
-	asymbol 	**syms;
-};
-
-static int bfd_error(const char *string)
-{
-	const char *errmsg;
-
-	errmsg = bfd_errmsg(bfd_get_error());
-	fflush(stdout);
-
-	if (string)
-		pr_debug("%s: %s\n", string, errmsg);
-	else
-		pr_debug("%s\n", errmsg);
-
-	return -1;
-}
-
-static int slurp_symtab(bfd *abfd, struct a2l_data *a2l)
-{
-	long storage;
-	long symcount;
-	asymbol **syms;
-	bfd_boolean dynamic = FALSE;
-
-	if ((bfd_get_file_flags(abfd) & HAS_SYMS) == 0)
-		return bfd_error(bfd_get_filename(abfd));
-
-	storage = bfd_get_symtab_upper_bound(abfd);
-	if (storage == 0L) {
-		storage = bfd_get_dynamic_symtab_upper_bound(abfd);
-		dynamic = TRUE;
-	}
-	if (storage < 0L)
-		return bfd_error(bfd_get_filename(abfd));
-
-	syms = malloc(storage);
-	if (dynamic)
-		symcount = bfd_canonicalize_dynamic_symtab(abfd, syms);
-	else
-		symcount = bfd_canonicalize_symtab(abfd, syms);
-
-	if (symcount < 0) {
-		free(syms);
-		return bfd_error(bfd_get_filename(abfd));
-	}
-
-	a2l->syms = syms;
-	return 0;
-}
-
-static void find_address_in_section(bfd *abfd, asection *section, void *data)
-{
-	bfd_vma pc, vma;
-	bfd_size_type size;
-	struct a2l_data *a2l = data;
-	flagword flags;
-
-	if (a2l->found)
-		return;
-
-#ifdef bfd_get_section_flags
-	flags = bfd_get_section_flags(abfd, section);
-#else
-	flags = bfd_section_flags(section);
-#endif
-	if ((flags & SEC_ALLOC) == 0)
-		return;
-
-	pc = a2l->addr;
-#ifdef bfd_get_section_vma
-	vma = bfd_get_section_vma(abfd, section);
-#else
-	vma = bfd_section_vma(section);
-#endif
-#ifdef bfd_get_section_size
-	size = bfd_get_section_size(section);
-#else
-	size = bfd_section_size(section);
-#endif
-
-	if (pc < vma || pc >= vma + size)
-		return;
-
-	a2l->found = bfd_find_nearest_line(abfd, section, a2l->syms, pc - vma,
-					   &a2l->filename, &a2l->funcname,
-					   &a2l->line);
-
-	if (a2l->filename && !strlen(a2l->filename))
-		a2l->filename = NULL;
-}
-
-static struct a2l_data *addr2line_init(const char *path)
-{
-	bfd *abfd;
-	struct a2l_data *a2l = NULL;
-
-	abfd = bfd_openr(path, NULL);
-	if (abfd == NULL)
-		return NULL;
-
-	if (!bfd_check_format(abfd, bfd_object))
-		goto out;
-
-	a2l = zalloc(sizeof(*a2l));
-	if (a2l == NULL)
-		goto out;
-
-	a2l->abfd = abfd;
-	a2l->input = strdup(path);
-	if (a2l->input == NULL)
-		goto out;
-
-	if (slurp_symtab(abfd, a2l))
-		goto out;
-
-	return a2l;
-
-out:
-	if (a2l) {
-		zfree((char **)&a2l->input);
-		free(a2l);
-	}
-	bfd_close(abfd);
-	return NULL;
-}
-
-static void addr2line_cleanup(struct a2l_data *a2l)
-{
-	if (a2l->abfd)
-		bfd_close(a2l->abfd);
-	zfree((char **)&a2l->input);
-	zfree(&a2l->syms);
-	free(a2l);
-}
-
-static int inline_list__append_dso_a2l(struct dso *dso,
-				       struct inline_node *node,
-				       struct symbol *sym)
-{
-	struct a2l_data *a2l = dso__a2l(dso);
-	struct symbol *inline_sym = new_inline_sym(dso, sym, a2l->funcname);
-	char *srcline = NULL;
-
-	if (a2l->filename)
-		srcline = srcline_from_fileline(a2l->filename, a2l->line);
-
-	return inline_list__append(inline_sym, srcline, node);
-}
+#include "libbfd.h"
 
 static int addr2line(const char *dso_name, u64 addr,
 		     char **file, unsigned int *line, struct dso *dso,
 		     bool unwind_inlines, struct inline_node *node,
 		     struct symbol *sym)
 {
-	int ret = 0;
-	struct a2l_data *a2l = dso__a2l(dso);
-
-	if (!a2l) {
-		a2l = addr2line_init(dso_name);
-		dso__set_a2l(dso, a2l);
-	}
-
-	if (a2l == NULL) {
-		if (!symbol_conf.disable_add2line_warn)
-			pr_warning("addr2line_init failed for %s\n", dso_name);
-		return 0;
-	}
-
-	a2l->addr = addr;
-	a2l->found = false;
-
-	bfd_map_over_sections(a2l->abfd, find_address_in_section, a2l);
-
-	if (!a2l->found)
-		return 0;
-
-	if (unwind_inlines) {
-		int cnt = 0;
-
-		if (node && inline_list__append_dso_a2l(dso, node, sym))
-			return 0;
-
-		while (bfd_find_inliner_info(a2l->abfd, &a2l->filename,
-					     &a2l->funcname, &a2l->line) &&
-		       cnt++ < MAX_INLINE_NEST) {
-
-			if (a2l->filename && !strlen(a2l->filename))
-				a2l->filename = NULL;
-
-			if (node != NULL) {
-				if (inline_list__append_dso_a2l(dso, node, sym))
-					return 0;
-				// found at least one inline frame
-				ret = 1;
-			}
-		}
-	}
-
-	if (file) {
-		*file = a2l->filename ? strdup(a2l->filename) : NULL;
-		ret = *file ? 1 : 0;
-	}
-
-	if (line)
-		*line = a2l->line;
-
-	return ret;
+	return libbfd__addr2line(dso_name, addr, file, line, dso, unwind_inlines, node, sym);
 }
 
 void dso__free_a2l(struct dso *dso)
 {
-	struct a2l_data *a2l = dso__a2l(dso);
-
-	if (!a2l)
-		return;
-
-	addr2line_cleanup(a2l);
-
-	dso__set_a2l(dso, NULL);
+	dso__free_a2l_libbfd(dso);
 }
 
 #else /* HAVE_LIBBFD_SUPPORT */
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index 80c20169e250..6e66ddbcc879 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -29,6 +29,8 @@ void srcline__tree_delete(struct rb_root_cached *tree);
 extern char *srcline__unknown;
 #define SRCLINE_UNKNOWN srcline__unknown
 
+#define MAX_INLINE_NEST 1024
+
 struct inline_list {
 	struct symbol		*symbol;
 	char			*srcline;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 1346fd180653..9e820599bab3 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -9,6 +9,7 @@
 
 #include "compress.h"
 #include "dso.h"
+#include "libbfd.h"
 #include "map.h"
 #include "maps.h"
 #include "symbol.h"
@@ -24,18 +25,6 @@
 #include <symbol/kallsyms.h>
 #include <internal/lib.h>
 
-#ifdef HAVE_LIBBFD_SUPPORT
-#define PACKAGE 'perf'
-#include <bfd.h>
-#endif
-
-#if defined(HAVE_LIBBFD_SUPPORT) || defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
-#ifndef DMGL_PARAMS
-#define DMGL_PARAMS     (1 << 0)  /* Include function args */
-#define DMGL_ANSI       (1 << 1)  /* Include const, volatile, etc */
-#endif
-#endif
-
 #ifndef EM_AARCH64
 #define EM_AARCH64	183  /* ARM 64 bit */
 #endif
@@ -871,47 +860,16 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 	return err;
 }
 
-#ifdef HAVE_LIBBFD_BUILDID_SUPPORT
-
-static int read_build_id(const char *filename, struct build_id *bid, bool block)
-{
-	size_t size = sizeof(bid->data);
-	int err = -1, fd;
-	bfd *abfd;
-
-	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
-	if (fd < 0)
-		return -1;
-
-	abfd = bfd_fdopenr(filename, /*target=*/NULL, fd);
-	if (!abfd)
-		return -1;
-
-	if (!bfd_check_format(abfd, bfd_object)) {
-		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
-		goto out_close;
-	}
-
-	if (!abfd->build_id || abfd->build_id->size > size)
-		goto out_close;
-
-	memcpy(bid->data, abfd->build_id->data, abfd->build_id->size);
-	memset(bid->data + abfd->build_id->size, 0, size - abfd->build_id->size);
-	err = bid->size = abfd->build_id->size;
-
-out_close:
-	bfd_close(abfd);
-	return err;
-}
-
-#else // HAVE_LIBBFD_BUILDID_SUPPORT
-
 static int read_build_id(const char *filename, struct build_id *bid, bool block)
 {
 	size_t size = sizeof(bid->data);
-	int fd, err = -1;
+	int fd, err;
 	Elf *elf;
 
+	err = libbfd__read_build_id(filename, bid, block);
+	if (err >= 0)
+		goto out;
+
 	if (size < BUILD_ID_SIZE)
 		goto out;
 
@@ -936,8 +894,6 @@ static int read_build_id(const char *filename, struct build_id *bid, bool block)
 	return err;
 }
 
-#endif // HAVE_LIBBFD_BUILDID_SUPPORT
-
 int filename__read_build_id(const char *filename, struct build_id *bid, bool block)
 {
 	struct kmod_path m = { .name = NULL, };
@@ -1022,44 +978,6 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
 	return err;
 }
 
-#ifdef HAVE_LIBBFD_SUPPORT
-
-int filename__read_debuglink(const char *filename, char *debuglink,
-			     size_t size)
-{
-	int err = -1;
-	asection *section;
-	bfd *abfd;
-
-	abfd = bfd_openr(filename, NULL);
-	if (!abfd)
-		return -1;
-
-	if (!bfd_check_format(abfd, bfd_object)) {
-		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
-		goto out_close;
-	}
-
-	section = bfd_get_section_by_name(abfd, ".gnu_debuglink");
-	if (!section)
-		goto out_close;
-
-	if (section->size > size)
-		goto out_close;
-
-	if (!bfd_get_section_contents(abfd, section, debuglink, 0,
-				      section->size))
-		goto out_close;
-
-	err = 0;
-
-out_close:
-	bfd_close(abfd);
-	return err;
-}
-
-#else
-
 int filename__read_debuglink(const char *filename, char *debuglink,
 			     size_t size)
 {
@@ -1071,6 +989,10 @@ int filename__read_debuglink(const char *filename, char *debuglink,
 	Elf_Scn *sec;
 	Elf_Kind ek;
 
+	err = libbfd_filename__read_debuglink(filename, debuglink, size);
+	if (err >= 0)
+		goto out;
+
 	fd = open(filename, O_RDONLY);
 	if (fd < 0)
 		goto out;
@@ -1112,8 +1034,6 @@ int filename__read_debuglink(const char *filename, char *debuglink,
 	return err;
 }
 
-#endif
-
 bool symsrc__possibly_runtime(struct symsrc *ss)
 {
 	return ss->dynsym || ss->opdsec;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3d04382687d1..cc26b7bf302b 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1589,137 +1589,6 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso)
 	return -1;
 }
 
-#ifdef HAVE_LIBBFD_SUPPORT
-#define PACKAGE 'perf'
-#include <bfd.h>
-
-static int bfd_symbols__cmpvalue(const void *a, const void *b)
-{
-	const asymbol *as = *(const asymbol **)a, *bs = *(const asymbol **)b;
-
-	if (bfd_asymbol_value(as) != bfd_asymbol_value(bs))
-		return bfd_asymbol_value(as) - bfd_asymbol_value(bs);
-
-	return bfd_asymbol_name(as)[0] - bfd_asymbol_name(bs)[0];
-}
-
-static int bfd2elf_binding(asymbol *symbol)
-{
-	if (symbol->flags & BSF_WEAK)
-		return STB_WEAK;
-	if (symbol->flags & BSF_GLOBAL)
-		return STB_GLOBAL;
-	if (symbol->flags & BSF_LOCAL)
-		return STB_LOCAL;
-	return -1;
-}
-
-int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
-{
-	int err = -1;
-	long symbols_size, symbols_count, i;
-	asection *section;
-	asymbol **symbols, *sym;
-	struct symbol *symbol;
-	bfd *abfd;
-	u64 start, len;
-
-	abfd = bfd_openr(debugfile, NULL);
-	if (!abfd)
-		return -1;
-
-	if (!bfd_check_format(abfd, bfd_object)) {
-		pr_debug2("%s: cannot read %s bfd file.\n", __func__,
-			  dso__long_name(dso));
-		goto out_close;
-	}
-
-	if (bfd_get_flavour(abfd) == bfd_target_elf_flavour)
-		goto out_close;
-
-	symbols_size = bfd_get_symtab_upper_bound(abfd);
-	if (symbols_size == 0) {
-		bfd_close(abfd);
-		return 0;
-	}
-
-	if (symbols_size < 0)
-		goto out_close;
-
-	symbols = malloc(symbols_size);
-	if (!symbols)
-		goto out_close;
-
-	symbols_count = bfd_canonicalize_symtab(abfd, symbols);
-	if (symbols_count < 0)
-		goto out_free;
-
-	section = bfd_get_section_by_name(abfd, ".text");
-	if (section) {
-		for (i = 0; i < symbols_count; ++i) {
-			if (!strcmp(bfd_asymbol_name(symbols[i]), "__ImageBase") ||
-			    !strcmp(bfd_asymbol_name(symbols[i]), "__image_base__"))
-				break;
-		}
-		if (i < symbols_count) {
-			/* PE symbols can only have 4 bytes, so use .text high bits */
-			u64 text_offset = (section->vma - (u32)section->vma)
-				+ (u32)bfd_asymbol_value(symbols[i]);
-			dso__set_text_offset(dso, text_offset);
-			dso__set_text_end(dso, (section->vma - text_offset) + section->size);
-		} else {
-			dso__set_text_offset(dso, section->vma - section->filepos);
-			dso__set_text_end(dso, section->filepos + section->size);
-		}
-	}
-
-	qsort(symbols, symbols_count, sizeof(asymbol *), bfd_symbols__cmpvalue);
-
-#ifdef bfd_get_section
-#define bfd_asymbol_section bfd_get_section
-#endif
-	for (i = 0; i < symbols_count; ++i) {
-		sym = symbols[i];
-		section = bfd_asymbol_section(sym);
-		if (bfd2elf_binding(sym) < 0)
-			continue;
-
-		while (i + 1 < symbols_count &&
-		       bfd_asymbol_section(symbols[i + 1]) == section &&
-		       bfd2elf_binding(symbols[i + 1]) < 0)
-			i++;
-
-		if (i + 1 < symbols_count &&
-		    bfd_asymbol_section(symbols[i + 1]) == section)
-			len = symbols[i + 1]->value - sym->value;
-		else
-			len = section->size - sym->value;
-
-		start = bfd_asymbol_value(sym) - dso__text_offset(dso);
-		symbol = symbol__new(start, len, bfd2elf_binding(sym), STT_FUNC,
-				     bfd_asymbol_name(sym));
-		if (!symbol)
-			goto out_free;
-
-		symbols__insert(dso__symbols(dso), symbol);
-	}
-#ifdef bfd_get_section
-#undef bfd_asymbol_section
-#endif
-
-	symbols__fixup_end(dso__symbols(dso), false);
-	symbols__fixup_duplicate(dso__symbols(dso));
-	dso__set_adjust_symbols(dso, true);
-
-	err = 0;
-out_free:
-	free(symbols);
-out_close:
-	bfd_close(abfd);
-	return err;
-}
-#endif
-
 static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 					   enum dso_binary_type type)
 {
-- 
2.51.0.570.gb178f27e6d-goog


