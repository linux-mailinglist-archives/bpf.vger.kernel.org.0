Return-Path: <bpf+bounces-49443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2466A18BE9
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 07:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1853A4085
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 06:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622B61B6D11;
	Wed, 22 Jan 2025 06:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ePCui7c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553471922F4
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527055; cv=none; b=fxd5L+1w2fm8j/mdhQVNY/yZ7Uj/xLquj67asr9BmRyf6er3MxCyRqo7uCKsvMWLb0NMcWqri/pkQEX9PpxC7NP8TmPos7uAV0O0LaZMwIwXz0IeTAG4umZc8KCN8T+m26K7M0ClrMqSm8tu7KHwsgELOARIW3K+37uFl2eAy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527055; c=relaxed/simple;
	bh=vFb+HyGIMnTuE4+8yPur8hNT1aQ25ULyLOvz1kWdv/8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=szocx37KXxuOIfE/RcM/MaOQJ9CXySkrlJIARTRIb8jq2LFR3AHa1O+VMgISq8hzV61tVFq+ch1Wgid+V5miZIytALtYa9SN9MYhXCjxkB14bJuK3GZZO0zjQ/gBIgntZ74YsfumWo8VOLoIWAQoxiycHRDbxzv2D62YnjGNh3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ePCui7c; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e5799401f12so13942129276.0
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 22:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737527052; x=1738131852; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/Xkh0A7UQ6xsQQnl38+jJR7kMCb05O19GL71kRj76o=;
        b=2ePCui7chSNYITPY2OazZTTu8F5iMJgBXOgNvbFDjezI/FGTlmUMtMyMc0ePcy8GY8
         xr58O452IdoEXy7dADA2nST8cS/umt0so7+ZeOaX8rwUtcdDtzLLEx7kXuIuZWHJYJNf
         eqv/R9HU6DVDqxpTArWuRIFvAQUrAy2eK/6RNOalHDGpCcPJNSj1er2wgh9rJ+XEy7+c
         M7eBPNeEHFFewuSleTfeJCdMvXovYIjyByw0yMA/SCQ5TntLP5lHzU8DmFvT0TQk9Y9p
         R3yfC+d3tmGGl07AecCKH9iQVDmUqkk7jV3mxE11um4ZT9MJSle9Y+g1YmoZNSCgnoGi
         Nj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737527052; x=1738131852;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/Xkh0A7UQ6xsQQnl38+jJR7kMCb05O19GL71kRj76o=;
        b=mJa2NG/0jmu1+vIOjY1i+1GHc2HPqzDWqsJtsM9j63zNCNKQQjmxbN6+dCBGUZQYqQ
         KsnBKwiP3zy8ih4pIP8mND0p6rOCjl0+7WYqWGniiO2p6IJ5T0hgDBtViXqgxafmgqqY
         5XliirHzI6J2aWywW7JSjQlDFAyjuVLusnh4PMLNSquRC7m+nH0Lg3fDFE0rfpR4GI8e
         U1SpFG2IT7NvkOwDJ2P82bFtIo5bxISnWjzMGqAC/o8SoYyTNPsCGG2GYCv9akCJ4NwK
         jmUJWElCdpzCDMC/fV9AfoePxvdTWbQcwaoXZGxa9qFGoXwPuLUo+HGSOSO82uu0rPeP
         gLkA==
X-Forwarded-Encrypted: i=1; AJvYcCVYKVSGMg6ntO18XGSGs3f1PLSDvcdOLv+FFeh3y4Q5gHzoJv9koijfSXC30JyaCoI56QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwkLGEmJD7lvR2QuWjeleYWl/oOgnqcik73jz5n6wpgrCL3x1V
	6t7mTne3o8acGIa4apzljKL70ZgfLb6xVzAzoVTU0sScQ2cUPVqkoZyfWs+kS3Et+gS0PhpIVhR
	vzPoI7A==
X-Google-Smtp-Source: AGHT+IEpCMP3xuDb6S3I6xdW9UBjl5UYkf2X5DmguPd3jZmu+4fP/uRDDLWB1ip9iJeqpSaDUpzp2mVE2aKb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:7306:b0:6f0:22ad:43f8 with SMTP
 id 00721157ae682-6f6eb953485mr540447b3.7.1737527052060; Tue, 21 Jan 2025
 22:24:12 -0800 (PST)
Date: Tue, 21 Jan 2025 22:23:18 -0800
In-Reply-To: <20250122062332.577009-1-irogers@google.com>
Message-Id: <20250122062332.577009-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 03/17] perf capstone: Move capstone functionality into its
 own file
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
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

Capstone disassembly support was split between disasm.c and
print_insn.c. Move support out of these files into capstone.[ch] and
remove include capstone/capstone.h from those files. As disassembly
routines can fail, make failure the only option without
HAVE_LIBCAPSTONE_SUPPORT. For simplicity's sake, duplicate the
read_symbol utility function.

The intent with moving capstone support into a single file is that
dynamic support, using dlopen for libcapstone, can be added in later
patches. This can potentially always succeed or fail, so relying on
ifdefs isn't sufficient. Using dlopen is a useful option to minimize
the perf tools dependencies and potentially size.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c  |   2 -
 tools/perf/util/Build        |   1 +
 tools/perf/util/capstone.c   | 536 +++++++++++++++++++++++++++++++++++
 tools/perf/util/capstone.h   |  24 ++
 tools/perf/util/disasm.c     | 358 +----------------------
 tools/perf/util/print_insn.c | 117 +-------
 6 files changed, 569 insertions(+), 469 deletions(-)
 create mode 100644 tools/perf/util/capstone.c
 create mode 100644 tools/perf/util/capstone.h

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 33667b534634..f05b2b70d5a7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1200,7 +1200,6 @@ static int any_dump_insn(struct evsel *evsel __maybe_unused,
 			 u8 *inbuf, int inlen, int *lenp,
 			 FILE *fp)
 {
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
 	if (PRINT_FIELD(BRSTACKDISASM)) {
 		int printed = fprintf_insn_asm(x->machine, x->thread, x->cpumode, x->is64bit,
 					       (uint8_t *)inbuf, inlen, ip, lenp,
@@ -1209,7 +1208,6 @@ static int any_dump_insn(struct evsel *evsel __maybe_unused,
 		if (printed > 0)
 			return printed;
 	}
-#endif
 	return fprintf(fp, "%s", dump_insn(x, ip, inbuf, inlen, lenp));
 }
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 5ec97e8d6b6d..9542decf9625 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -8,6 +8,7 @@ perf-util-y += block-info.o
 perf-util-y += block-range.o
 perf-util-y += build-id.o
 perf-util-y += cacheline.o
+perf-util-y += capstone.o
 perf-util-y += config.o
 perf-util-y += copyfile.o
 perf-util-y += ctype.o
diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
new file mode 100644
index 000000000000..c0a6d94ebc18
--- /dev/null
+++ b/tools/perf/util/capstone.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "capstone.h"
+#include "annotate.h"
+#include "addr_location.h"
+#include "debug.h"
+#include "disasm.h"
+#include "dso.h"
+#include "machine.h"
+#include "map.h"
+#include "namespaces.h"
+#include "print_insn.h"
+#include "symbol.h"
+#include "thread.h"
+#include <fcntl.h>
+#include <string.h>
+
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+#include <capstone/capstone.h>
+#endif
+
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
+			 bool disassembler_style)
+{
+	cs_arch arch;
+	cs_mode mode;
+
+	if (machine__is(machine, "x86_64") && is64) {
+		arch = CS_ARCH_X86;
+		mode = CS_MODE_64;
+	} else if (machine__normalized_is(machine, "x86")) {
+		arch = CS_ARCH_X86;
+		mode = CS_MODE_32;
+	} else if (machine__normalized_is(machine, "arm64")) {
+		arch = CS_ARCH_ARM64;
+		mode = CS_MODE_ARM;
+	} else if (machine__normalized_is(machine, "arm")) {
+		arch = CS_ARCH_ARM;
+		mode = CS_MODE_ARM + CS_MODE_V8;
+	} else if (machine__normalized_is(machine, "s390")) {
+		arch = CS_ARCH_SYSZ;
+		mode = CS_MODE_BIG_ENDIAN;
+	} else {
+		return -1;
+	}
+
+	if (cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
+		pr_warning_once("cs_open failed\n");
+		return -1;
+	}
+
+	if (machine__normalized_is(machine, "x86")) {
+		/*
+		 * In case of using capstone_init while symbol__disassemble
+		 * setting CS_OPT_SYNTAX_ATT depends if disassembler_style opts
+		 * is set via annotation args
+		 */
+		if (disassembler_style)
+			cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
+		/*
+		 * Resolving address operands to symbols is implemented
+		 * on x86 by investigating instruction details.
+		 */
+		cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
+	}
+
+	return 0;
+}
+#endif
+
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_insn *insn,
+			     int print_opts, FILE *fp)
+{
+	struct addr_location al;
+	size_t printed = 0;
+
+	if (insn->detail && insn->detail->x86.op_count == 1) {
+		cs_x86_op *op = &insn->detail->x86.operands[0];
+
+		addr_location__init(&al);
+		if (op->type == X86_OP_IMM &&
+		    thread__find_symbol(thread, cpumode, op->imm, &al)) {
+			printed += fprintf(fp, "%s ", insn[0].mnemonic);
+			printed += symbol__fprintf_symname_offs(al.sym, &al, fp);
+			if (print_opts & PRINT_INSN_IMM_HEX)
+				printed += fprintf(fp, " [%#" PRIx64 "]", op->imm);
+			addr_location__exit(&al);
+			return printed;
+		}
+		addr_location__exit(&al);
+	}
+
+	printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
+	return printed;
+}
+#endif
+
+
+ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
+				   struct thread *thread __maybe_unused,
+				   u8 cpumode __maybe_unused, bool is64bit __maybe_unused,
+				   const uint8_t *code __maybe_unused,
+				   size_t code_size __maybe_unused,
+				   uint64_t ip __maybe_unused, int *lenp __maybe_unused,
+				   int print_opts __maybe_unused, FILE *fp __maybe_unused)
+{
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+	size_t printed;
+	cs_insn *insn;
+	csh cs_handle;
+	size_t count;
+	int ret;
+
+	/* TODO: Try to initiate capstone only once but need a proper place. */
+	ret = capstone_init(machine, &cs_handle, is64bit, true);
+	if (ret < 0)
+		return ret;
+
+	count = cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
+	if (count > 0) {
+		if (machine__normalized_is(machine, "x86"))
+			printed = print_insn_x86(thread, cpumode, &insn[0], print_opts, fp);
+		else
+			printed = fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
+		if (lenp)
+			*lenp = insn->size;
+		cs_free(insn, count);
+	} else {
+		printed = -1;
+	}
+
+	cs_close(&cs_handle);
+	return printed;
+#else
+	return -1;
+#endif
+}
+
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+static int open_capstone_handle(struct annotate_args *args, bool is_64bit, csh *handle)
+{
+	struct annotation_options *opt = args->options;
+	cs_mode mode = is_64bit ? CS_MODE_64 : CS_MODE_32;
+
+	/* TODO: support more architectures */
+	if (!arch__is(args->arch, "x86"))
+		return -1;
+
+	if (cs_open(CS_ARCH_X86, mode, handle) != CS_ERR_OK)
+		return -1;
+
+	if (!opt->disassembler_style ||
+	    !strcmp(opt->disassembler_style, "att"))
+		cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
+
+	/*
+	 * Resolving address operands to symbols is implemented
+	 * on x86 by investigating instruction details.
+	 */
+	cs_option(*handle, CS_OPT_DETAIL, CS_OPT_ON);
+
+	return 0;
+}
+#endif
+
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
+				  struct annotate_args *args, u64 addr)
+{
+	int i;
+	struct map *map = args->ms.map;
+	struct symbol *sym;
+
+	/* TODO: support more architectures */
+	if (!arch__is(args->arch, "x86"))
+		return;
+
+	if (insn->detail == NULL)
+		return;
+
+	for (i = 0; i < insn->detail->x86.op_count; i++) {
+		cs_x86_op *op = &insn->detail->x86.operands[i];
+		u64 orig_addr;
+
+		if (op->type != X86_OP_MEM)
+			continue;
+
+		/* only print RIP-based global symbols for now */
+		if (op->mem.base != X86_REG_RIP)
+			continue;
+
+		/* get the target address */
+		orig_addr = addr + insn->size + op->mem.disp;
+		addr = map__objdump_2mem(map, orig_addr);
+
+		if (dso__kernel(map__dso(map))) {
+			/*
+			 * The kernel maps can be splitted into sections,
+			 * let's find the map first and the search the symbol.
+			 */
+			map = maps__find(map__kmaps(map), addr);
+			if (map == NULL)
+				continue;
+		}
+
+		/* convert it to map-relative address for search */
+		addr = map__map_ip(map, addr);
+
+		sym = map__find_symbol(map, addr);
+		if (sym == NULL)
+			continue;
+
+		if (addr == sym->start) {
+			scnprintf(buf, len, "\t# %"PRIx64" <%s>",
+				  orig_addr, sym->name);
+		} else {
+			scnprintf(buf, len, "\t# %"PRIx64" <%s+%#"PRIx64">",
+				  orig_addr, sym->name, addr - sym->start);
+		}
+		break;
+	}
+}
+#endif
+
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
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
+#endif
+
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
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
+int symbol__disassemble_capstone(const char *filename __maybe_unused,
+				 struct symbol *sym __maybe_unused,
+				 struct annotate_args *args __maybe_unused)
+{
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+	struct annotation *notes = symbol__annotation(sym);
+	struct map *map = args->ms.map;
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 len;
+	u64 offset;
+	int i, count, free_count;
+	bool is_64bit = false;
+	bool needs_cs_close = false;
+	u8 *buf = NULL;
+	csh handle;
+	cs_insn *insn = NULL;
+	char disasm_buf[512];
+	struct disasm_line *dl;
+
+	if (args->options->objdump_path)
+		return -1;
+
+	buf = read_symbol(filename, map, sym, &len, &is_64bit);
+	if (buf == NULL)
+		return -1;
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
+	if (open_capstone_handle(args, is_64bit, &handle) < 0)
+		goto err;
+
+	needs_cs_close = true;
+
+	free_count = count = cs_disasm(handle, buf, len, start, len, &insn);
+	for (i = 0, offset = 0; i < count; i++) {
+		int printed;
+
+		printed = scnprintf(disasm_buf, sizeof(disasm_buf),
+				    "       %-7s %s",
+				    insn[i].mnemonic, insn[i].op_str);
+		print_capstone_detail(&insn[i], disasm_buf + printed,
+				      sizeof(disasm_buf) - printed, args,
+				      start + offset);
+
+		args->offset = offset;
+		args->line = disasm_buf;
+
+		dl = disasm_line__new(args);
+		if (dl == NULL)
+			goto err;
+
+		annotation_line__add(&dl->al, &notes->src->source);
+
+		offset += insn[i].size;
+	}
+
+	/* It failed in the middle: probably due to unknown instructions */
+	if (offset != len) {
+		struct list_head *list = &notes->src->source;
+
+		/* Discard all lines and fallback to objdump */
+		while (!list_empty(list)) {
+			dl = list_first_entry(list, struct disasm_line, al.node);
+
+			list_del_init(&dl->al.node);
+			disasm_line__free(dl);
+		}
+		count = -1;
+	}
+
+out:
+	if (needs_cs_close) {
+		cs_close(&handle);
+		if (free_count > 0)
+			cs_free(insn, free_count);
+	}
+	free(buf);
+	return count < 0 ? count : 0;
+
+err:
+	if (needs_cs_close) {
+		struct disasm_line *tmp;
+
+		/*
+		 * It probably failed in the middle of the above loop.
+		 * Release any resources it might add.
+		 */
+		list_for_each_entry_safe(dl, tmp, &notes->src->source, al.node) {
+			list_del(&dl->al.node);
+			disasm_line__free(dl);
+		}
+	}
+	count = -1;
+	goto out;
+#else
+	return -1;
+#endif
+}
+
+int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
+					 struct symbol *sym __maybe_unused,
+					 struct annotate_args *args __maybe_unused)
+{
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+	struct annotation *notes = symbol__annotation(sym);
+	struct map *map = args->ms.map;
+	struct dso *dso = map__dso(map);
+	struct nscookie nsc;
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 end = map__rip_2objdump(map, sym->end);
+	u64 len = end - start;
+	u64 offset;
+	int i, fd, count;
+	bool is_64bit = false;
+	bool needs_cs_close = false;
+	u8 *buf = NULL;
+	struct find_file_offset_data data = {
+		.ip = start,
+	};
+	csh handle;
+	char disasm_buf[512];
+	struct disasm_line *dl;
+	u32 *line;
+	bool disassembler_style = false;
+
+	if (args->options->objdump_path)
+		return -1;
+
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	fd = open(filename, O_RDONLY);
+	nsinfo__mountns_exit(&nsc);
+	if (fd < 0)
+		return -1;
+
+	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
+			    &is_64bit) == 0)
+		goto err;
+
+	if (!args->options->disassembler_style ||
+	    !strcmp(args->options->disassembler_style, "att"))
+		disassembler_style = true;
+
+	if (capstone_init(maps__machine(args->ms.maps), &handle, is_64bit, disassembler_style) < 0)
+		goto err;
+
+	needs_cs_close = true;
+
+	buf = malloc(len);
+	if (buf == NULL)
+		goto err;
+
+	count = pread(fd, buf, len, data.offset);
+	close(fd);
+	fd = -1;
+
+	if ((u64)count != len)
+		goto err;
+
+	line = (u32 *)buf;
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
+	/*
+	 * TODO: enable disassm for powerpc
+	 * count = cs_disasm(handle, buf, len, start, len, &insn);
+	 *
+	 * For now, only binary code is saved in disassembled line
+	 * to be used in "type" and "typeoff" sort keys. Each raw code
+	 * is 32 bit instruction. So use "len/4" to get the number of
+	 * entries.
+	 */
+	count = len/4;
+
+	for (i = 0, offset = 0; i < count; i++) {
+		args->offset = offset;
+		sprintf(args->line, "%x", line[i]);
+
+		dl = disasm_line__new(args);
+		if (dl == NULL)
+			break;
+
+		annotation_line__add(&dl->al, &notes->src->source);
+
+		offset += 4;
+	}
+
+	/* It failed in the middle */
+	if (offset != len) {
+		struct list_head *list = &notes->src->source;
+
+		/* Discard all lines and fallback to objdump */
+		while (!list_empty(list)) {
+			dl = list_first_entry(list, struct disasm_line, al.node);
+
+			list_del_init(&dl->al.node);
+			disasm_line__free(dl);
+		}
+		count = -1;
+	}
+
+out:
+	if (needs_cs_close)
+		cs_close(&handle);
+	free(buf);
+	return count < 0 ? count : 0;
+
+err:
+	if (fd >= 0)
+		close(fd);
+	count = -1;
+	goto out;
+#else
+	return -1;
+#endif
+}
diff --git a/tools/perf/util/capstone.h b/tools/perf/util/capstone.h
new file mode 100644
index 000000000000..0f030ea034b6
--- /dev/null
+++ b/tools/perf/util/capstone.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_CAPSTONE_H
+#define __PERF_CAPSTONE_H
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <linux/types.h>
+
+struct annotate_args;
+struct machine;
+struct symbol;
+struct thread;
+
+ssize_t capstone__fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpumode,
+				   bool is64bit, const uint8_t *code, size_t code_size,
+				   uint64_t ip, int *lenp, int print_opts, FILE *fp);
+int symbol__disassemble_capstone(const char *filename, struct symbol *sym,
+				 struct annotate_args *args);
+int symbol__disassemble_capstone_powerpc(const char *filename, struct symbol *sym,
+					 struct annotate_args *args);
+
+#endif /* __PERF_CAPSTONE_H */
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index b7de4d9fd004..0e5881189ae8 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -14,6 +14,7 @@
 #include "annotate.h"
 #include "annotate-data.h"
 #include "build-id.h"
+#include "capstone.h"
 #include "debug.h"
 #include "disasm.h"
 #include "disasm_bpf.h"
@@ -1329,39 +1330,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	return 0;
 }
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
-#include <capstone/capstone.h>
-
-int capstone_init(struct machine *machine, csh *cs_handle, bool is64, bool disassembler_style);
-
-static int open_capstone_handle(struct annotate_args *args, bool is_64bit,
-				csh *handle)
-{
-	struct annotation_options *opt = args->options;
-	cs_mode mode = is_64bit ? CS_MODE_64 : CS_MODE_32;
-
-	/* TODO: support more architectures */
-	if (!arch__is(args->arch, "x86"))
-		return -1;
-
-	if (cs_open(CS_ARCH_X86, mode, handle) != CS_ERR_OK)
-		return -1;
-
-	if (!opt->disassembler_style ||
-	    !strcmp(opt->disassembler_style, "att"))
-		cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
-
-	/*
-	 * Resolving address operands to symbols is implemented
-	 * on x86 by investigating instruction details.
-	 */
-	cs_option(*handle, CS_OPT_DETAIL, CS_OPT_ON);
-
-	return 0;
-}
-#endif
-
-#if defined(HAVE_LIBCAPSTONE_SUPPORT) || defined(HAVE_LIBLLVM_SUPPORT)
+#if defined(HAVE_LIBLLVM_SUPPORT)
 struct find_file_offset_data {
 	u64 ip;
 	u64 offset;
@@ -1427,322 +1396,6 @@ read_symbol(const char *filename, struct map *map, struct symbol *sym,
 }
 #endif
 
-#if !defined(HAVE_LIBCAPSTONE_SUPPORT) || !defined(HAVE_LIBLLVM_SUPPORT)
-static void symbol__disassembler_missing(const char *disassembler, const char *filename,
-					 struct symbol *sym)
-{
-	pr_debug("The %s disassembler isn't linked in for %s in %s\n",
-		 disassembler, sym->name, filename);
-}
-#endif
-
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
-static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
-				  struct annotate_args *args, u64 addr)
-{
-	int i;
-	struct map *map = args->ms.map;
-	struct symbol *sym;
-
-	/* TODO: support more architectures */
-	if (!arch__is(args->arch, "x86"))
-		return;
-
-	if (insn->detail == NULL)
-		return;
-
-	for (i = 0; i < insn->detail->x86.op_count; i++) {
-		cs_x86_op *op = &insn->detail->x86.operands[i];
-		u64 orig_addr;
-
-		if (op->type != X86_OP_MEM)
-			continue;
-
-		/* only print RIP-based global symbols for now */
-		if (op->mem.base != X86_REG_RIP)
-			continue;
-
-		/* get the target address */
-		orig_addr = addr + insn->size + op->mem.disp;
-		addr = map__objdump_2mem(map, orig_addr);
-
-		if (dso__kernel(map__dso(map))) {
-			/*
-			 * The kernel maps can be splitted into sections,
-			 * let's find the map first and the search the symbol.
-			 */
-			map = maps__find(map__kmaps(map), addr);
-			if (map == NULL)
-				continue;
-		}
-
-		/* convert it to map-relative address for search */
-		addr = map__map_ip(map, addr);
-
-		sym = map__find_symbol(map, addr);
-		if (sym == NULL)
-			continue;
-
-		if (addr == sym->start) {
-			scnprintf(buf, len, "\t# %"PRIx64" <%s>",
-				  orig_addr, sym->name);
-		} else {
-			scnprintf(buf, len, "\t# %"PRIx64" <%s+%#"PRIx64">",
-				  orig_addr, sym->name, addr - sym->start);
-		}
-		break;
-	}
-}
-
-static int symbol__disassemble_capstone_powerpc(char *filename, struct symbol *sym,
-					struct annotate_args *args)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	struct map *map = args->ms.map;
-	struct dso *dso = map__dso(map);
-	struct nscookie nsc;
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
-	u64 len = end - start;
-	u64 offset;
-	int i, fd, count;
-	bool is_64bit = false;
-	bool needs_cs_close = false;
-	u8 *buf = NULL;
-	struct find_file_offset_data data = {
-		.ip = start,
-	};
-	csh handle;
-	char disasm_buf[512];
-	struct disasm_line *dl;
-	u32 *line;
-	bool disassembler_style = false;
-
-	if (args->options->objdump_path)
-		return -1;
-
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
-	if (fd < 0)
-		return -1;
-
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
-			    &is_64bit) == 0)
-		goto err;
-
-	if (!args->options->disassembler_style ||
-			!strcmp(args->options->disassembler_style, "att"))
-		disassembler_style = true;
-
-	if (capstone_init(maps__machine(args->ms.maps), &handle, is_64bit, disassembler_style) < 0)
-		goto err;
-
-	needs_cs_close = true;
-
-	buf = malloc(len);
-	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, len, data.offset);
-	close(fd);
-	fd = -1;
-
-	if ((u64)count != len)
-		goto err;
-
-	line = (u32 *)buf;
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
-	/*
-	 * TODO: enable disassm for powerpc
-	 * count = cs_disasm(handle, buf, len, start, len, &insn);
-	 *
-	 * For now, only binary code is saved in disassembled line
-	 * to be used in "type" and "typeoff" sort keys. Each raw code
-	 * is 32 bit instruction. So use "len/4" to get the number of
-	 * entries.
-	 */
-	count = len/4;
-
-	for (i = 0, offset = 0; i < count; i++) {
-		args->offset = offset;
-		sprintf(args->line, "%x", line[i]);
-
-		dl = disasm_line__new(args);
-		if (dl == NULL)
-			break;
-
-		annotation_line__add(&dl->al, &notes->src->source);
-
-		offset += 4;
-	}
-
-	/* It failed in the middle */
-	if (offset != len) {
-		struct list_head *list = &notes->src->source;
-
-		/* Discard all lines and fallback to objdump */
-		while (!list_empty(list)) {
-			dl = list_first_entry(list, struct disasm_line, al.node);
-
-			list_del_init(&dl->al.node);
-			disasm_line__free(dl);
-		}
-		count = -1;
-	}
-
-out:
-	if (needs_cs_close)
-		cs_close(&handle);
-	free(buf);
-	return count < 0 ? count : 0;
-
-err:
-	if (fd >= 0)
-		close(fd);
-	count = -1;
-	goto out;
-}
-
-static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
-					struct annotate_args *args)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	struct map *map = args->ms.map;
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 len;
-	u64 offset;
-	int i, count, free_count;
-	bool is_64bit = false;
-	bool needs_cs_close = false;
-	u8 *buf = NULL;
-	csh handle;
-	cs_insn *insn = NULL;
-	char disasm_buf[512];
-	struct disasm_line *dl;
-
-	if (args->options->objdump_path)
-		return -1;
-
-	buf = read_symbol(filename, map, sym, &len, &is_64bit);
-	if (buf == NULL)
-		return -1;
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
-	if (open_capstone_handle(args, is_64bit, &handle) < 0)
-		goto err;
-
-	needs_cs_close = true;
-
-	free_count = count = cs_disasm(handle, buf, len, start, len, &insn);
-	for (i = 0, offset = 0; i < count; i++) {
-		int printed;
-
-		printed = scnprintf(disasm_buf, sizeof(disasm_buf),
-				    "       %-7s %s",
-				    insn[i].mnemonic, insn[i].op_str);
-		print_capstone_detail(&insn[i], disasm_buf + printed,
-				      sizeof(disasm_buf) - printed, args,
-				      start + offset);
-
-		args->offset = offset;
-		args->line = disasm_buf;
-
-		dl = disasm_line__new(args);
-		if (dl == NULL)
-			goto err;
-
-		annotation_line__add(&dl->al, &notes->src->source);
-
-		offset += insn[i].size;
-	}
-
-	/* It failed in the middle: probably due to unknown instructions */
-	if (offset != len) {
-		struct list_head *list = &notes->src->source;
-
-		/* Discard all lines and fallback to objdump */
-		while (!list_empty(list)) {
-			dl = list_first_entry(list, struct disasm_line, al.node);
-
-			list_del_init(&dl->al.node);
-			disasm_line__free(dl);
-		}
-		count = -1;
-	}
-
-out:
-	if (needs_cs_close) {
-		cs_close(&handle);
-		if (free_count > 0)
-			cs_free(insn, free_count);
-	}
-	free(buf);
-	return count < 0 ? count : 0;
-
-err:
-	if (needs_cs_close) {
-		struct disasm_line *tmp;
-
-		/*
-		 * It probably failed in the middle of the above loop.
-		 * Release any resources it might add.
-		 */
-		list_for_each_entry_safe(dl, tmp, &notes->src->source, al.node) {
-			list_del(&dl->al.node);
-			disasm_line__free(dl);
-		}
-	}
-	count = -1;
-	goto out;
-}
-#else // HAVE_LIBCAPSTONE_SUPPORT
-static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
-					struct annotate_args *args __maybe_unused)
-{
-	symbol__disassembler_missing("capstone", filename, sym);
-	return -1;
-}
-
-static int symbol__disassemble_capstone_powerpc(char *filename, struct symbol *sym,
-						struct annotate_args *args __maybe_unused)
-{
-	symbol__disassembler_missing("capstone powerpc", filename, sym);
-	return -1;
-}
-#endif // HAVE_LIBCAPSTONE_SUPPORT
-
 static int symbol__disassemble_raw(char *filename, struct symbol *sym,
 					struct annotate_args *args)
 {
@@ -2010,10 +1663,11 @@ static int symbol__disassemble_llvm(char *filename, struct symbol *sym,
 	return ret;
 }
 #else // HAVE_LIBLLVM_SUPPORT
-static int symbol__disassemble_llvm(char *filename, struct symbol *sym,
+static int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 				    struct annotate_args *args __maybe_unused)
 {
-	symbol__disassembler_missing("LLVM", filename, sym);
+	pr_debug("The LLVM disassembler isn't linked in for %s in %s\n",
+		 sym->name, filename);
 	return -1;
 }
 #endif // HAVE_LIBLLVM_SUPPORT
@@ -2225,9 +1879,7 @@ static int annotation_options__init_disassemblers(struct annotation_options *opt
 #ifdef HAVE_LIBLLVM_SUPPORT
 				"llvm,"
 #endif
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
 				"capstone,"
-#endif
 				"objdump";
 
 		options->disassemblers_str = strdup(default_disassemblers_str);
diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index a33a7726422d..02e6fbb8ca04 100644
--- a/tools/perf/util/print_insn.c
+++ b/tools/perf/util/print_insn.c
@@ -7,6 +7,7 @@
 #include <inttypes.h>
 #include <string.h>
 #include <stdbool.h>
+#include "capstone.h"
 #include "debug.h"
 #include "sample.h"
 #include "symbol.h"
@@ -29,84 +30,6 @@ size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
 	return printed;
 }
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
-#include <capstone/capstone.h>
-
-int capstone_init(struct machine *machine, csh *cs_handle, bool is64, bool disassembler_style);
-
-int capstone_init(struct machine *machine, csh *cs_handle, bool is64, bool disassembler_style)
-{
-	cs_arch arch;
-	cs_mode mode;
-
-	if (machine__is(machine, "x86_64") && is64) {
-		arch = CS_ARCH_X86;
-		mode = CS_MODE_64;
-	} else if (machine__normalized_is(machine, "x86")) {
-		arch = CS_ARCH_X86;
-		mode = CS_MODE_32;
-	} else if (machine__normalized_is(machine, "arm64")) {
-		arch = CS_ARCH_ARM64;
-		mode = CS_MODE_ARM;
-	} else if (machine__normalized_is(machine, "arm")) {
-		arch = CS_ARCH_ARM;
-		mode = CS_MODE_ARM + CS_MODE_V8;
-	} else if (machine__normalized_is(machine, "s390")) {
-		arch = CS_ARCH_SYSZ;
-		mode = CS_MODE_BIG_ENDIAN;
-	} else {
-		return -1;
-	}
-
-	if (cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
-		pr_warning_once("cs_open failed\n");
-		return -1;
-	}
-
-	if (machine__normalized_is(machine, "x86")) {
-		/*
-		 * In case of using capstone_init while symbol__disassemble
-		 * setting CS_OPT_SYNTAX_ATT depends if disassembler_style opts
-		 * is set via annotation args
-		 */
-		if (disassembler_style)
-			cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
-		/*
-		 * Resolving address operands to symbols is implemented
-		 * on x86 by investigating instruction details.
-		 */
-		cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
-	}
-
-	return 0;
-}
-
-static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_insn *insn,
-			     int print_opts, FILE *fp)
-{
-	struct addr_location al;
-	size_t printed = 0;
-
-	if (insn->detail && insn->detail->x86.op_count == 1) {
-		cs_x86_op *op = &insn->detail->x86.operands[0];
-
-		addr_location__init(&al);
-		if (op->type == X86_OP_IMM &&
-		    thread__find_symbol(thread, cpumode, op->imm, &al)) {
-			printed += fprintf(fp, "%s ", insn[0].mnemonic);
-			printed += symbol__fprintf_symname_offs(al.sym, &al, fp);
-			if (print_opts & PRINT_INSN_IMM_HEX)
-				printed += fprintf(fp, " [%#" PRIx64 "]", op->imm);
-			addr_location__exit(&al);
-			return printed;
-		}
-		addr_location__exit(&al);
-	}
-
-	printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
-	return printed;
-}
-
 static bool is64bitip(struct machine *machine, struct addr_location *al)
 {
 	const struct dso *dso = al->map ? map__dso(al->map) : NULL;
@@ -123,32 +46,8 @@ ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpum
 			 bool is64bit, const uint8_t *code, size_t code_size,
 			 uint64_t ip, int *lenp, int print_opts, FILE *fp)
 {
-	size_t printed;
-	cs_insn *insn;
-	csh cs_handle;
-	size_t count;
-	int ret;
-
-	/* TODO: Try to initiate capstone only once but need a proper place. */
-	ret = capstone_init(machine, &cs_handle, is64bit, true);
-	if (ret < 0)
-		return ret;
-
-	count = cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
-	if (count > 0) {
-		if (machine__normalized_is(machine, "x86"))
-			printed = print_insn_x86(thread, cpumode, &insn[0], print_opts, fp);
-		else
-			printed = fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
-		if (lenp)
-			*lenp = insn->size;
-		cs_free(insn, count);
-	} else {
-		printed = -1;
-	}
-
-	cs_close(&cs_handle);
-	return printed;
+	return capstone__fprintf_insn_asm(machine, thread, cpumode, is64bit, code, code_size,
+					  ip, lenp, print_opts, fp);
 }
 
 size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *thread,
@@ -166,13 +65,3 @@ size_t sample__fprintf_insn_asm(struct perf_sample *sample, struct thread *threa
 
 	return printed;
 }
-#else
-size_t sample__fprintf_insn_asm(struct perf_sample *sample __maybe_unused,
-				struct thread *thread __maybe_unused,
-				struct machine *machine __maybe_unused,
-				FILE *fp __maybe_unused,
-				struct addr_location *al __maybe_unused)
-{
-	return 0;
-}
-#endif
-- 
2.48.0.rc2.279.g1de40edade-goog


