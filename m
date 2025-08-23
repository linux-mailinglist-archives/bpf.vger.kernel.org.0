Return-Path: <bpf+bounces-66335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31485B325DD
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 02:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A6C62650A
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64A78248B;
	Sat, 23 Aug 2025 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OfyyBiW0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814D18FDDB
	for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 00:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909160; cv=none; b=ThR/zJUWg5gSFPORK3pBGJbNi8OKwI/wNZLC4dG0dfXF08tlYHmRb0r32pu0kF7ulmMNEJr6C8Hyk9vh27QY0vVSL/wJqZvYnqean3IWGm+ijqnEGiSAjUEBeNsmk4iRgOyymWlrAsWCX+Td3ltbN2uu+cXs7T0tkYg2T5qLvzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909160; c=relaxed/simple;
	bh=7mu6r2Zr7aRj83kQ0wFasfirXTL9LVhOthciqwGBRJI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ejbK1E2KlKydAkyqHFwx18DHS/TOltjW+ItuLLvav44BzUcE+YOrcbyZVmeaL2ScuDKOqFCxtkDGXEz0XhyqGh1nHp9SFaxRBmEDESqfXGwNfUEFLPdTbEXylkCvVPydhWLb1RxYCeh6hUw/eXyQAGte8sNCMZp91j0J9ai7+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OfyyBiW0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2449b4f316fso20860295ad.3
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 17:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909157; x=1756513957; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMwO9J0jPgiMGbntOOpSgflb2mQJPKS+Nngt9Kbsr0Y=;
        b=OfyyBiW0CZ//EN2S60urV3xPw6Om8uvtALXblOJKeuLuJYlSeCcWIwqWQU27ZRyIHI
         MRchSXuXPMANQvD0f48FgLRYDnP51xsIf3fc2W7YuXa9vqhBBFzr526If54sgC0pABfm
         4+RnzkqduokRic/bBPj8a2WWvxt2COWnyp7wO8NnsW/Dhw/vq91niYAXbypRdFDPdiPk
         MNUHlGhqIEIGecMNI5vgJCtHs+Vu7waUbO6riuC8NHFPlsoCRo9S5TF4qmqfYtRePu/u
         zzYP68+YdCgbeSuGqO+rUi238dzNUFlpQw6J8ztnp3rr1rU+RQD4v41O8Vj7uocZCvq+
         GPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909157; x=1756513957;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMwO9J0jPgiMGbntOOpSgflb2mQJPKS+Nngt9Kbsr0Y=;
        b=Vtqb3lOgt5h5OfmbhElLe+yPELxanvtt4lrvZk+gtkeqTmir2K/dEf8YRj7uUtQQh1
         MAl7ht8PoqtA/WMLaWx6EpOohQoh0Zks8lVoQ6ZhiYzJXllkEsw0GRD+TiT+zKuQ5GgB
         ++aj0E7nbHfZZmiEJ5svF2gaxE30IJLxXLfQFWRC8Zf0K9nuXJzIKSVjxAmtLZTZ5BQb
         IQ2Xb0MBwcZ+9iUwSVbgBn4pzHmYZAHwyQx2++eSuZEmi4fKuLzI/6SSufpHDLFIqcc7
         2aJ7kNfQaATt4ejIznOD6SIZtyOdm1bCUApbwweUzxxqjGqDUCPclZkB1iVl7YnDhAmt
         c3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw9XCQQi0tiZX9HMRivQIjXEuvtP8nigYUap+cgltJJdKxqVeEc2cso1bKnvv3eUga6m4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4ZX2wnuVGDL5NGdruZsk5BAMtPBWFGTxl/CdrAWqKK2vzD7r
	ssTo461uoJCKJtDsrGAM/lfcqB5GOx3rt/bESMsSe4pLInyMyX5IsxYhLi8Df2pxl6r0Hj5U3UJ
	ptoQkb2o+/A==
X-Google-Smtp-Source: AGHT+IG1PXIU8+M9tLlUDFrDsXRQiyanDuL/PeUra6mEnAdpzUypjWpFYwT4YbSemDZY1b5c0vrXpWDAczj7
X-Received: from pjtq16.prod.google.com ([2002:a17:90a:c110:b0:311:1a09:11ff])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d505:b0:242:a4f4:6b7d
 with SMTP id d9443c01a7336-2462ef20675mr62765045ad.28.1755909157205; Fri, 22
 Aug 2025 17:32:37 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:00 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-5-irogers@google.com>
Subject: [PATCH v5 04/19] perf llvm: Move llvm functionality into its own file
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LLVM disassembly support was in disasm.c and addr2line support in
srcline.c. Move support out of these files into llvm.[ch] and remove
LLVM includes from those files. As disassembl routines can fail, make
failure the only option without HAVE_LIBLLVM_SUPPORT. For simplicity's
sake, duplicate the read_symbol utility function.

The intent with moving LLVM support into a single file is that dynamic
support, using dlopen for libllvm, can be added in later patches. This
can potentially always succeed or fail, so relying on ifdefs isn't
sufficient. Using dlopen is a useful option to minimize the perf tools
dependencies and potentially size.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build     |   1 +
 tools/perf/util/disasm.c  | 260 +-----------------------------
 tools/perf/util/disasm.h  |   2 +
 tools/perf/util/llvm.c    | 326 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/llvm.h    |  24 +++
 tools/perf/util/srcline.c |  65 ++------
 tools/perf/util/srcline.h |   6 +
 7 files changed, 373 insertions(+), 311 deletions(-)
 create mode 100644 tools/perf/util/llvm.c
 create mode 100644 tools/perf/util/llvm.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4e8414b7c283..63160c4a517e 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -26,6 +26,7 @@ perf-util-y += evswitch.o
 perf-util-y += find_bit.o
 perf-util-y += get_current_dir_name.o
 perf-util-y += levenshtein.o
+perf-util-y += llvm.o
 perf-util-y += mmap.o
 perf-util-y += memswap.o
 perf-util-y += parse-events.o
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 81e0a74362e4..5a1a7be717d0 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -22,6 +22,7 @@
 #include "dwarf-regs.h"
 #include "env.h"
 #include "evsel.h"
+#include "llvm.h"
 #include "map.h"
 #include "maps.h"
 #include "namespaces.h"
@@ -50,7 +51,6 @@ static int call__scnprintf(struct ins *ins, char *bf, size_t size,
 static void ins__sort(struct arch *arch);
 static int disasm_line__parse(char *line, const char **namep, char **rawp);
 static int disasm_line__parse_powerpc(struct disasm_line *dl, struct annotate_args *args);
-static char *expand_tabs(char *line, char **storage, size_t *storage_len);
 
 static __attribute__((constructor)) void symbol__init_regexpr(void)
 {
@@ -1331,72 +1331,6 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	return 0;
 }
 
-#if defined(HAVE_LIBLLVM_SUPPORT)
-struct find_file_offset_data {
-	u64 ip;
-	u64 offset;
-};
-
-/* This will be called for each PHDR in an ELF binary */
-static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
-{
-	struct find_file_offset_data *data = arg;
-
-	if (start <= data->ip && data->ip < start + len) {
-		data->offset = pgoff + data->ip - start;
-		return 1;
-	}
-	return 0;
-}
-
-static u8 *
-read_symbol(const char *filename, struct map *map, struct symbol *sym,
-	    u64 *len, bool *is_64bit)
-{
-	struct dso *dso = map__dso(map);
-	struct nscookie nsc;
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
-	int fd, count;
-	u8 *buf = NULL;
-	struct find_file_offset_data data = {
-		.ip = start,
-	};
-
-	*is_64bit = false;
-
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
-	if (fd < 0)
-		return NULL;
-
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
-			    is_64bit) == 0)
-		goto err;
-
-	*len = end - start;
-	buf = malloc(*len);
-	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, *len, data.offset);
-	close(fd);
-	fd = -1;
-
-	if ((u64)count != *len)
-		goto err;
-
-	return buf;
-
-err:
-	if (fd >= 0)
-		close(fd);
-	free(buf);
-	return NULL;
-}
-#endif
-
 static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 					struct annotate_args *args)
 {
@@ -1483,202 +1417,12 @@ static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 	goto out;
 }
 
-#ifdef HAVE_LIBLLVM_SUPPORT
-#include <llvm-c/Disassembler.h>
-#include <llvm-c/Target.h>
-#include "util/llvm-c-helpers.h"
-
-struct symbol_lookup_storage {
-	u64 branch_addr;
-	u64 pcrel_load_addr;
-};
-
-/*
- * Whenever LLVM wants to resolve an address into a symbol, it calls this
- * callback. We don't ever actually _return_ anything (in particular, because
- * it puts quotation marks around what we return), but we use this as a hint
- * that there is a branch or PC-relative address in the expression that we
- * should add some textual annotation for after the instruction. The caller
- * will use this information to add the actual annotation.
- */
-static const char *
-symbol_lookup_callback(void *disinfo, uint64_t value,
-		       uint64_t *ref_type,
-		       uint64_t address __maybe_unused,
-		       const char **ref __maybe_unused)
-{
-	struct symbol_lookup_storage *storage = disinfo;
-
-	if (*ref_type == LLVMDisassembler_ReferenceType_In_Branch)
-		storage->branch_addr = value;
-	else if (*ref_type == LLVMDisassembler_ReferenceType_In_PCrel_Load)
-		storage->pcrel_load_addr = value;
-	*ref_type = LLVMDisassembler_ReferenceType_InOut_None;
-	return NULL;
-}
-
-static int symbol__disassemble_llvm(char *filename, struct symbol *sym,
-				    struct annotate_args *args)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	struct map *map = args->ms.map;
-	struct dso *dso = map__dso(map);
-	u64 start = map__rip_2objdump(map, sym->start);
-	u8 *buf;
-	u64 len;
-	u64 pc;
-	bool is_64bit;
-	char triplet[64];
-	char disasm_buf[2048];
-	size_t disasm_len;
-	struct disasm_line *dl;
-	LLVMDisasmContextRef disasm = NULL;
-	struct symbol_lookup_storage storage;
-	char *line_storage = NULL;
-	size_t line_storage_len = 0;
-	int ret = -1;
-
-	if (args->options->objdump_path)
-		return -1;
-
-	LLVMInitializeAllTargetInfos();
-	LLVMInitializeAllTargetMCs();
-	LLVMInitializeAllDisassemblers();
-
-	buf = read_symbol(filename, map, sym, &len, &is_64bit);
-	if (buf == NULL)
-		return -1;
-
-	if (arch__is(args->arch, "x86")) {
-		if (is_64bit)
-			scnprintf(triplet, sizeof(triplet), "x86_64-pc-linux");
-		else
-			scnprintf(triplet, sizeof(triplet), "i686-pc-linux");
-	} else {
-		scnprintf(triplet, sizeof(triplet), "%s-linux-gnu",
-			  args->arch->name);
-	}
-
-	disasm = LLVMCreateDisasm(triplet, &storage, 0, NULL,
-				  symbol_lookup_callback);
-	if (disasm == NULL)
-		goto err;
-
-	if (args->options->disassembler_style &&
-	    !strcmp(args->options->disassembler_style, "intel"))
-		LLVMSetDisasmOptions(disasm,
-				     LLVMDisassembler_Option_AsmPrinterVariant);
-
-	/*
-	 * This needs to be set after AsmPrinterVariant, due to a bug in LLVM;
-	 * setting AsmPrinterVariant makes a new instruction printer, making it
-	 * forget about the PrintImmHex flag (which is applied before if both
-	 * are given to the same call).
-	 */
-	LLVMSetDisasmOptions(disasm, LLVMDisassembler_Option_PrintImmHex);
-
-	/* add the function address and name */
-	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
-		  start, sym->name);
-
-	args->offset = -1;
-	args->line = disasm_buf;
-	args->line_nr = 0;
-	args->fileloc = NULL;
-	args->ms.sym = sym;
-
-	dl = disasm_line__new(args);
-	if (dl == NULL)
-		goto err;
-
-	annotation_line__add(&dl->al, &notes->src->source);
-
-	pc = start;
-	for (u64 offset = 0; offset < len; ) {
-		unsigned int ins_len;
-
-		storage.branch_addr = 0;
-		storage.pcrel_load_addr = 0;
-
-		ins_len = LLVMDisasmInstruction(disasm, buf + offset,
-						len - offset, pc,
-						disasm_buf, sizeof(disasm_buf));
-		if (ins_len == 0)
-			goto err;
-		disasm_len = strlen(disasm_buf);
-
-		if (storage.branch_addr != 0) {
-			char *name = llvm_name_for_code(dso, filename,
-							storage.branch_addr);
-			if (name != NULL) {
-				disasm_len += scnprintf(disasm_buf + disasm_len,
-							sizeof(disasm_buf) -
-								disasm_len,
-							" <%s>", name);
-				free(name);
-			}
-		}
-		if (storage.pcrel_load_addr != 0) {
-			char *name = llvm_name_for_data(dso, filename,
-							storage.pcrel_load_addr);
-			disasm_len += scnprintf(disasm_buf + disasm_len,
-						sizeof(disasm_buf) - disasm_len,
-						"  # %#"PRIx64,
-						storage.pcrel_load_addr);
-			if (name) {
-				disasm_len += scnprintf(disasm_buf + disasm_len,
-							sizeof(disasm_buf) -
-							disasm_len,
-							" <%s>", name);
-				free(name);
-			}
-		}
-
-		args->offset = offset;
-		args->line = expand_tabs(disasm_buf, &line_storage,
-					 &line_storage_len);
-		args->line_nr = 0;
-		args->fileloc = NULL;
-		args->ms.sym = sym;
-
-		llvm_addr2line(filename, pc, &args->fileloc,
-			       (unsigned int *)&args->line_nr, false, NULL);
-
-		dl = disasm_line__new(args);
-		if (dl == NULL)
-			goto err;
-
-		annotation_line__add(&dl->al, &notes->src->source);
-
-		free(args->fileloc);
-		pc += ins_len;
-		offset += ins_len;
-	}
-
-	ret = 0;
-
-err:
-	LLVMDisasmDispose(disasm);
-	free(buf);
-	free(line_storage);
-	return ret;
-}
-#else // HAVE_LIBLLVM_SUPPORT
-static int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
-				    struct annotate_args *args __maybe_unused)
-{
-	pr_debug("The LLVM disassembler isn't linked in for %s in %s\n",
-		 sym->name, filename);
-	return -1;
-}
-#endif // HAVE_LIBLLVM_SUPPORT
-
 /*
  * Possibly create a new version of line with tabs expanded. Returns the
  * existing or new line, storage is updated if a new line is allocated. If
  * allocation fails then NULL is returned.
  */
-static char *expand_tabs(char *line, char **storage, size_t *storage_len)
+char *expand_tabs(char *line, char **storage, size_t *storage_len)
 {
 	size_t i, src, dst, len, new_storage_len, num_tabs;
 	char *new_line;
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index c135db2416b5..2cb4e1a6bd30 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -128,4 +128,6 @@ int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size,
 
 int symbol__disassemble(struct symbol *sym, struct annotate_args *args);
 
+char *expand_tabs(char *line, char **storage, size_t *storage_len);
+
 #endif /* __PERF_UTIL_DISASM_H */
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
new file mode 100644
index 000000000000..ddc737194692
--- /dev/null
+++ b/tools/perf/util/llvm.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "llvm.h"
+#include "annotate.h"
+#include "debug.h"
+#include "dso.h"
+#include "map.h"
+#include "namespaces.h"
+#include "srcline.h"
+#include "symbol.h"
+#include <fcntl.h>
+#include <unistd.h>
+#include <linux/zalloc.h>
+
+#ifdef HAVE_LIBLLVM_SUPPORT
+#include "llvm-c-helpers.h"
+#include <llvm-c/Disassembler.h>
+#include <llvm-c/Target.h>
+#endif
+
+#ifdef HAVE_LIBLLVM_SUPPORT
+static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_frames,
+				    int num_frames)
+{
+	if (inline_frames != NULL) {
+		for (int i = 0; i < num_frames; ++i) {
+			zfree(&inline_frames[i].filename);
+			zfree(&inline_frames[i].funcname);
+		}
+		zfree(&inline_frames);
+	}
+}
+#endif
+
+int llvm__addr2line(const char *dso_name __maybe_unused, u64 addr __maybe_unused,
+		     char **file __maybe_unused, unsigned int *line __maybe_unused,
+		     struct dso *dso __maybe_unused, bool unwind_inlines __maybe_unused,
+		     struct inline_node *node __maybe_unused, struct symbol *sym __maybe_unused)
+{
+#ifdef HAVE_LIBLLVM_SUPPORT
+	struct llvm_a2l_frame *inline_frames = NULL;
+	int num_frames = llvm_addr2line(dso_name, addr, file, line,
+					node && unwind_inlines, &inline_frames);
+
+	if (num_frames == 0 || !inline_frames) {
+		/* Error, or we didn't want inlines. */
+		return num_frames;
+	}
+
+	for (int i = 0; i < num_frames; ++i) {
+		struct symbol *inline_sym =
+			new_inline_sym(dso, sym, inline_frames[i].funcname);
+		char *srcline = NULL;
+
+		if (inline_frames[i].filename) {
+			srcline =
+				srcline_from_fileline(inline_frames[i].filename,
+						      inline_frames[i].line);
+		}
+		if (inline_list__append(inline_sym, srcline, node) != 0) {
+			free_llvm_inline_frames(inline_frames, num_frames);
+			return 0;
+		}
+	}
+	free_llvm_inline_frames(inline_frames, num_frames);
+
+	return num_frames;
+#else
+	return -1;
+#endif
+}
+
+void dso__free_a2l_llvm(struct dso *dso __maybe_unused)
+{
+	/* Nothing to free. */
+}
+
+
+#if defined(HAVE_LIBLLVM_SUPPORT)
+struct find_file_offset_data {
+	u64 ip;
+	u64 offset;
+};
+
+/* This will be called for each PHDR in an ELF binary */
+static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
+{
+	struct find_file_offset_data *data = arg;
+
+	if (start <= data->ip && data->ip < start + len) {
+		data->offset = pgoff + data->ip - start;
+		return 1;
+	}
+	return 0;
+}
+
+static u8 *
+read_symbol(const char *filename, struct map *map, struct symbol *sym,
+	    u64 *len, bool *is_64bit)
+{
+	struct dso *dso = map__dso(map);
+	struct nscookie nsc;
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 end = map__rip_2objdump(map, sym->end);
+	int fd, count;
+	u8 *buf = NULL;
+	struct find_file_offset_data data = {
+		.ip = start,
+	};
+
+	*is_64bit = false;
+
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	fd = open(filename, O_RDONLY);
+	nsinfo__mountns_exit(&nsc);
+	if (fd < 0)
+		return NULL;
+
+	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
+			    is_64bit) == 0)
+		goto err;
+
+	*len = end - start;
+	buf = malloc(*len);
+	if (buf == NULL)
+		goto err;
+
+	count = pread(fd, buf, *len, data.offset);
+	close(fd);
+	fd = -1;
+
+	if ((u64)count != *len)
+		goto err;
+
+	return buf;
+
+err:
+	if (fd >= 0)
+		close(fd);
+	free(buf);
+	return NULL;
+}
+#endif
+
+/*
+ * Whenever LLVM wants to resolve an address into a symbol, it calls this
+ * callback. We don't ever actually _return_ anything (in particular, because
+ * it puts quotation marks around what we return), but we use this as a hint
+ * that there is a branch or PC-relative address in the expression that we
+ * should add some textual annotation for after the instruction. The caller
+ * will use this information to add the actual annotation.
+ */
+#ifdef HAVE_LIBLLVM_SUPPORT
+struct symbol_lookup_storage {
+	u64 branch_addr;
+	u64 pcrel_load_addr;
+};
+
+static const char *
+symbol_lookup_callback(void *disinfo, uint64_t value,
+		       uint64_t *ref_type,
+		       uint64_t address __maybe_unused,
+		       const char **ref __maybe_unused)
+{
+	struct symbol_lookup_storage *storage = disinfo;
+
+	if (*ref_type == LLVMDisassembler_ReferenceType_In_Branch)
+		storage->branch_addr = value;
+	else if (*ref_type == LLVMDisassembler_ReferenceType_In_PCrel_Load)
+		storage->pcrel_load_addr = value;
+	*ref_type = LLVMDisassembler_ReferenceType_InOut_None;
+	return NULL;
+}
+#endif
+
+int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
+			     struct annotate_args *args __maybe_unused)
+{
+#ifdef HAVE_LIBLLVM_SUPPORT
+	struct annotation *notes = symbol__annotation(sym);
+	struct map *map = args->ms.map;
+	struct dso *dso = map__dso(map);
+	u64 start = map__rip_2objdump(map, sym->start);
+	u8 *buf;
+	u64 len;
+	u64 pc;
+	bool is_64bit;
+	char triplet[64];
+	char disasm_buf[2048];
+	size_t disasm_len;
+	struct disasm_line *dl;
+	LLVMDisasmContextRef disasm = NULL;
+	struct symbol_lookup_storage storage;
+	char *line_storage = NULL;
+	size_t line_storage_len = 0;
+	int ret = -1;
+
+	if (args->options->objdump_path)
+		return -1;
+
+	LLVMInitializeAllTargetInfos();
+	LLVMInitializeAllTargetMCs();
+	LLVMInitializeAllDisassemblers();
+
+	buf = read_symbol(filename, map, sym, &len, &is_64bit);
+	if (buf == NULL)
+		return -1;
+
+	if (arch__is(args->arch, "x86")) {
+		if (is_64bit)
+			scnprintf(triplet, sizeof(triplet), "x86_64-pc-linux");
+		else
+			scnprintf(triplet, sizeof(triplet), "i686-pc-linux");
+	} else {
+		scnprintf(triplet, sizeof(triplet), "%s-linux-gnu",
+			  args->arch->name);
+	}
+
+	disasm = LLVMCreateDisasm(triplet, &storage, 0, NULL,
+				  symbol_lookup_callback);
+	if (disasm == NULL)
+		goto err;
+
+	if (args->options->disassembler_style &&
+	    !strcmp(args->options->disassembler_style, "intel"))
+		LLVMSetDisasmOptions(disasm,
+				     LLVMDisassembler_Option_AsmPrinterVariant);
+
+	/*
+	 * This needs to be set after AsmPrinterVariant, due to a bug in LLVM;
+	 * setting AsmPrinterVariant makes a new instruction printer, making it
+	 * forget about the PrintImmHex flag (which is applied before if both
+	 * are given to the same call).
+	 */
+	LLVMSetDisasmOptions(disasm, LLVMDisassembler_Option_PrintImmHex);
+
+	/* add the function address and name */
+	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
+		  start, sym->name);
+
+	args->offset = -1;
+	args->line = disasm_buf;
+	args->line_nr = 0;
+	args->fileloc = NULL;
+	args->ms.sym = sym;
+
+	dl = disasm_line__new(args);
+	if (dl == NULL)
+		goto err;
+
+	annotation_line__add(&dl->al, &notes->src->source);
+
+	pc = start;
+	for (u64 offset = 0; offset < len; ) {
+		unsigned int ins_len;
+
+		storage.branch_addr = 0;
+		storage.pcrel_load_addr = 0;
+
+		ins_len = LLVMDisasmInstruction(disasm, buf + offset,
+						len - offset, pc,
+						disasm_buf, sizeof(disasm_buf));
+		if (ins_len == 0)
+			goto err;
+		disasm_len = strlen(disasm_buf);
+
+		if (storage.branch_addr != 0) {
+			char *name = llvm_name_for_code(dso, filename,
+							storage.branch_addr);
+			if (name != NULL) {
+				disasm_len += scnprintf(disasm_buf + disasm_len,
+							sizeof(disasm_buf) -
+								disasm_len,
+							" <%s>", name);
+				free(name);
+			}
+		}
+		if (storage.pcrel_load_addr != 0) {
+			char *name = llvm_name_for_data(dso, filename,
+							storage.pcrel_load_addr);
+			disasm_len += scnprintf(disasm_buf + disasm_len,
+						sizeof(disasm_buf) - disasm_len,
+						"  # %#"PRIx64,
+						storage.pcrel_load_addr);
+			if (name) {
+				disasm_len += scnprintf(disasm_buf + disasm_len,
+							sizeof(disasm_buf) -
+							disasm_len,
+							" <%s>", name);
+				free(name);
+			}
+		}
+
+		args->offset = offset;
+		args->line = expand_tabs(disasm_buf, &line_storage,
+					 &line_storage_len);
+		args->line_nr = 0;
+		args->fileloc = NULL;
+		args->ms.sym = sym;
+
+		llvm_addr2line(filename, pc, &args->fileloc,
+			       (unsigned int *)&args->line_nr, false, NULL);
+
+		dl = disasm_line__new(args);
+		if (dl == NULL)
+			goto err;
+
+		annotation_line__add(&dl->al, &notes->src->source);
+
+		free(args->fileloc);
+		pc += ins_len;
+		offset += ins_len;
+	}
+
+	ret = 0;
+
+err:
+	LLVMDisasmDispose(disasm);
+	free(buf);
+	free(line_storage);
+	return ret;
+#else // HAVE_LIBLLVM_SUPPORT
+	pr_debug("The LLVM disassembler isn't linked in for %s in %s\n",
+		 sym->name, filename);
+	return -1;
+#endif
+}
diff --git a/tools/perf/util/llvm.h b/tools/perf/util/llvm.h
new file mode 100644
index 000000000000..8aa19bb6b068
--- /dev/null
+++ b/tools/perf/util/llvm.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_LLVM_H
+#define __PERF_LLVM_H
+
+#include <stdbool.h>
+#include <linux/types.h>
+
+struct annotate_args;
+struct dso;
+struct inline_node;
+struct symbol;
+
+int llvm__addr2line(const char *dso_name, u64 addr,
+		char **file, unsigned int *line, struct dso *dso,
+		bool unwind_inlines, struct inline_node *node,
+		struct symbol *sym);
+
+
+void dso__free_a2l_llvm(struct dso *dso);
+
+int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
+			     struct annotate_args *args);
+
+#endif /* __PERF_LLVM_H */
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 3e3449e35dd4..45e138ff3e52 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -17,9 +17,7 @@
 #include "util/debug.h"
 #include "util/callchain.h"
 #include "util/symbol_conf.h"
-#ifdef HAVE_LIBLLVM_SUPPORT
-#include "util/llvm-c-helpers.h"
-#endif
+#include "llvm.h"
 #include "srcline.h"
 #include "string2.h"
 #include "symbol.h"
@@ -49,8 +47,7 @@ static const char *srcline_dso_name(struct dso *dso)
 	return dso_name;
 }
 
-static int inline_list__append(struct symbol *symbol, char *srcline,
-			       struct inline_node *node)
+int inline_list__append(struct symbol *symbol, char *srcline, struct inline_node *node)
 {
 	struct inline_list *ilist;
 
@@ -77,7 +74,7 @@ static const char *gnu_basename(const char *path)
 	return base ? base + 1 : path;
 }
 
-static char *srcline_from_fileline(const char *file, unsigned int line)
+char *srcline_from_fileline(const char *file, unsigned int line)
 {
 	char *srcline;
 
@@ -93,9 +90,9 @@ static char *srcline_from_fileline(const char *file, unsigned int line)
 	return srcline;
 }
 
-static struct symbol *new_inline_sym(struct dso *dso,
-				     struct symbol *base_sym,
-				     const char *funcname)
+struct symbol *new_inline_sym(struct dso *dso,
+			      struct symbol *base_sym,
+			      const char *funcname)
 {
 	struct symbol *inline_sym;
 	char *demangled = NULL;
@@ -135,58 +132,20 @@ static struct symbol *new_inline_sym(struct dso *dso,
 #define MAX_INLINE_NEST 1024
 
 #ifdef HAVE_LIBLLVM_SUPPORT
-
-static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_frames,
-				    int num_frames)
-{
-	if (inline_frames != NULL) {
-		for (int i = 0; i < num_frames; ++i) {
-			zfree(&inline_frames[i].filename);
-			zfree(&inline_frames[i].funcname);
-		}
-		zfree(&inline_frames);
-	}
-}
+#include "llvm.h"
 
 static int addr2line(const char *dso_name, u64 addr,
 		     char **file, unsigned int *line, struct dso *dso,
-		     bool unwind_inlines, struct inline_node *node,
-		     struct symbol *sym)
+		      bool unwind_inlines, struct inline_node *node,
+		      struct symbol *sym)
 {
-	struct llvm_a2l_frame *inline_frames = NULL;
-	int num_frames = llvm_addr2line(dso_name, addr, file, line,
-					node && unwind_inlines, &inline_frames);
-
-	if (num_frames == 0 || !inline_frames) {
-		/* Error, or we didn't want inlines. */
-		return num_frames;
-	}
-
-	for (int i = 0; i < num_frames; ++i) {
-		struct symbol *inline_sym =
-			new_inline_sym(dso, sym, inline_frames[i].funcname);
-		char *srcline = NULL;
-
-		if (inline_frames[i].filename) {
-			srcline =
-				srcline_from_fileline(inline_frames[i].filename,
-						      inline_frames[i].line);
-		}
-		if (inline_list__append(inline_sym, srcline, node) != 0) {
-			free_llvm_inline_frames(inline_frames, num_frames);
-			return 0;
-		}
-	}
-	free_llvm_inline_frames(inline_frames, num_frames);
-
-	return num_frames;
+	return llvm__addr2line(dso_name, addr, file, line, dso, unwind_inlines, node, sym);
 }
 
-void dso__free_a2l(struct dso *dso __maybe_unused)
+void dso__free_a2l(struct dso *dso)
 {
-	/* Nothing to free. */
+	dso__free_a2l_llvm(dso);
 }
-
 #elif defined(HAVE_LIBBFD_SUPPORT)
 
 /*
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index 75010d39ea28..80c20169e250 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -55,4 +55,10 @@ struct inline_node *inlines__tree_find(struct rb_root_cached *tree, u64 addr);
 /* delete all nodes within the tree of inline_node s */
 void inlines__tree_delete(struct rb_root_cached *tree);
 
+int inline_list__append(struct symbol *symbol, char *srcline, struct inline_node *node);
+char *srcline_from_fileline(const char *file, unsigned int line);
+struct symbol *new_inline_sym(struct dso *dso,
+			      struct symbol *base_sym,
+			      const char *funcname);
+
 #endif /* PERF_SRCLINE_H */
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


