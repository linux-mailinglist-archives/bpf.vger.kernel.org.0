Return-Path: <bpf+bounces-69977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754E3BAA6B6
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 21:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300EF3C6B20
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D7F261B9E;
	Mon, 29 Sep 2025 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2eoPiNt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883EE258ED4
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759172936; cv=none; b=o0yb5rJaSabF/lZ1EEKwwVYGaezpejBmA0siQtBviEYVH70TmhCdAOSVqxtPw85Z19qHWPoqi5kAunXXP1972TZ6schdu40jU7+sA4PFsalo+4vulLUSObr4U9dlVnnHZVvSrV19ystV1a+OGN4qGWx1zv0J19e0C8vpzqv7lhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759172936; c=relaxed/simple;
	bh=AVPvmJinkN+ChIjcvn7Zq0BPV9zVIYeBJdwRHwdUEpE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BJdzxJjHiHoFRGg05h/7v4Wg++/vC6/ZtU4hyPlr/jxxXgUc3PBzynMvAZsG8mubzYqGngng15Gzs+4WlPsJPVf7+GrtLJlu8h+UYmtuhDV21tSyXkic6QJxyfR1egj4Bb9Mi72LoqnuCGnrCxjrPipNjXif17x69ZRkyv0T5Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2eoPiNt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-71d60163d68so74223897b3.0
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759172933; x=1759777733; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BI3nOwntd4sZSGIX2BG+Rf556tM7S0t0SeXjHRWsGnc=;
        b=i2eoPiNtaqiGihrBWfx4IjhX9zVUoJ3GsAc1R44nLFUwa12Ed2fxLSzSMVN1TAbBHx
         THCxb38FrDXTxpRcY0A5h2qZlRsBprS9IntQoaF2P7drNPvtNvCqkUEajUGN+5H2cbIo
         5/zZ6XyCKUNi4URI7uMOARHjSEF8N2cPYft3fjhJbVUFeVO61KVuIqeJTKtHrxH82L5r
         Z81P+QpWN511trNUZn20GqXs7Q/9psIc+mAC/jsm9/iQV+xke51tS3gp1HF0K0If/z9U
         W4LMdWXUHWxOGXxCZAWnpyFc++N+Clne0l40kxqW2QadIRxVXlCfi4ihfngS2l4S2tcs
         xvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759172933; x=1759777733;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BI3nOwntd4sZSGIX2BG+Rf556tM7S0t0SeXjHRWsGnc=;
        b=e9ExNYTU1YGE//KWi8xFCn1Vf3l+c+q9QFjn4wrp2K8wt6VNCIG1U08YNyavtBxCzC
         3MzQUO6iLLRSKs2gpeb8t/XFng67A1ZnxYQrRqbk7FVeMjFYXZbUJDYqet6wSO5rxykI
         3hRh+jM1PW7lbshbx5uUHvK/pmkm1t+oX31hdw2jt0rSN2rXwtwULDQhxrbpokVJ3r3j
         ymmqrfgqD89xjUnSyH/wjmpLHzCVQ847FqKxohmZOzV8fTCayBO7Ji708SQUEFw/kVbf
         MohQ8AHNhTBfTo1smZos/VZnBvzrb5Ut55BG0tuOgNK564y6EKO3/hkbg/zO1Q2bvgWN
         6adw==
X-Forwarded-Encrypted: i=1; AJvYcCW4BNqMelTBTLHI9F6io052xlHZmf2pYHUVZUDw8L1TmYnawJmW6kNQT6oDcIoHsKdL1gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJAMsdX8kqdyTqqjPD5gjXE/WR3ieBqqV29f5pd+N2cPA+Kwe3
	GGGnaNcXl6Tam4k23EDNLWGfVi+0faWZ23HNMhw2r1DHEEcatTdu2cGwtMWdxnJJ5o1ab2us5b9
	GMeoISNSE+w==
X-Google-Smtp-Source: AGHT+IEZEQST18hSDEs9VdJT5pI7Rj9LvHne7IRGt9VFqU0+6AdUDCmPRkVWUYq7ucbBJPFv4W+PzzAHAnV4
X-Received: from ywbbg10.prod.google.com ([2002:a05:690c:30a:b0:726:20d5:53])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:a7d2:b0:71b:fa04:d16e
 with SMTP id 00721157ae682-763fa716424mr164008727b3.16.1759172932666; Mon, 29
 Sep 2025 12:08:52 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:07:56 -0700
In-Reply-To: <20250929190805.201446-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250929190805.201446-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250929190805.201446-7-irogers@google.com>
Subject: [PATCH v6 06/15] perf capstone: Support for dlopen-ing libcapstone.so
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

If perf wasn't built against libcapstone, no HAVE_LIBCAPSTONE_SUPPORT,
support dlopen-ing libcapstone.so and then calling the necessary
functions by looking them up using dlsym. Reverse engineer the types
in the API using pahole, adding only what's used in the perf code or
necessary for the sake of struct size and alignment.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c | 287 ++++++++++++++++++++++++++++++++-----
 1 file changed, 248 insertions(+), 39 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index 01e47d5c8e3e..fa9aa9cde68d 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -11,19 +11,249 @@
 #include "print_insn.h"
 #include "symbol.h"
 #include "thread.h"
+#include <dlfcn.h>
 #include <fcntl.h>
+#include <inttypes.h>
 #include <string.h>
 
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 #include <capstone/capstone.h>
+#else
+typedef size_t csh;
+enum cs_arch {
+	CS_ARCH_ARM = 0,
+	CS_ARCH_ARM64 = 1,
+	CS_ARCH_X86 = 3,
+	CS_ARCH_SYSZ = 6,
+};
+enum cs_mode {
+	CS_MODE_ARM = 0,
+	CS_MODE_32 = 1 << 2,
+	CS_MODE_64 = 1 << 3,
+	CS_MODE_V8 = 1 << 6,
+	CS_MODE_BIG_ENDIAN = 1 << 31,
+};
+enum cs_opt_type {
+	CS_OPT_SYNTAX = 1,
+	CS_OPT_DETAIL = 2,
+};
+enum cs_opt_value {
+	CS_OPT_SYNTAX_ATT = 2,
+	CS_OPT_ON = 3,
+};
+enum cs_err {
+	CS_ERR_OK = 0,
+	CS_ERR_HANDLE = 3,
+};
+enum x86_op_type {
+	X86_OP_IMM = 2,
+	X86_OP_MEM = 3,
+};
+enum x86_reg {
+	X86_REG_RIP = 41,
+};
+typedef int32_t x86_avx_bcast;
+struct x86_op_mem {
+	enum x86_reg segment;
+	enum x86_reg base;
+	enum x86_reg index;
+	int scale;
+	int64_t disp;
+};
+
+struct cs_x86_op {
+	enum x86_op_type type;
+	union {
+		enum x86_reg  reg;
+		int64_t imm;
+		struct x86_op_mem mem;
+	};
+	uint8_t size;
+	uint8_t access;
+	x86_avx_bcast avx_bcast;
+	bool avx_zero_opmask;
+};
+struct cs_x86_encoding {
+	uint8_t modrm_offset;
+	uint8_t disp_offset;
+	uint8_t disp_size;
+	uint8_t imm_offset;
+	uint8_t imm_size;
+};
+typedef int32_t  x86_xop_cc;
+typedef int32_t  x86_sse_cc;
+typedef int32_t  x86_avx_cc;
+typedef int32_t  x86_avx_rm;
+struct cs_x86 {
+	uint8_t prefix[4];
+	uint8_t opcode[4];
+	uint8_t rex;
+	uint8_t addr_size;
+	uint8_t modrm;
+	uint8_t sib;
+	int64_t disp;
+	enum x86_reg sib_index;
+	int8_t sib_scale;
+	enum x86_reg sib_base;
+	x86_xop_cc xop_cc;
+	x86_sse_cc sse_cc;
+	x86_avx_cc avx_cc;
+	bool avx_sae;
+	x86_avx_rm avx_rm;
+	union {
+		uint64_t eflags;
+		uint64_t fpu_flags;
+	};
+	uint8_t op_count;
+	struct cs_x86_op operands[8];
+	struct cs_x86_encoding encoding;
+};
+struct cs_detail {
+	uint16_t regs_read[12];
+	uint8_t regs_read_count;
+	uint16_t regs_write[20];
+	uint8_t regs_write_count;
+	uint8_t groups[8];
+	uint8_t groups_count;
+
+	union {
+		struct cs_x86 x86;
+	};
+};
+struct cs_insn {
+	unsigned int id;
+	uint64_t address;
+	uint16_t size;
+	uint8_t bytes[16];
+	char mnemonic[32];
+	char op_str[160];
+	struct cs_detail *detail;
+};
+#endif
+
+#ifndef HAVE_LIBCAPSTONE_SUPPORT
+static void *perf_cs_dll_handle(void)
+{
+	static bool dll_handle_init;
+	static void *dll_handle;
+
+	if (!dll_handle_init) {
+		dll_handle_init = true;
+		dll_handle = dlopen("libcapstone.so", RTLD_LAZY);
+		if (!dll_handle)
+			pr_debug("dlopen failed for libcapstone.so\n");
+	}
+	return dll_handle;
+}
+#endif
+
+static enum cs_err perf_cs_open(enum cs_arch arch, enum cs_mode mode, csh *handle)
+{
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+	return cs_open(arch, mode, handle);
+#else
+	static bool fn_init;
+	static enum cs_err (*fn)(enum cs_arch arch, enum cs_mode mode, csh *handle);
+
+	if (!fn_init) {
+		fn = dlsym(perf_cs_dll_handle(), "cs_open");
+		if (!fn)
+			pr_debug("dlsym failed for cs_open\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return CS_ERR_HANDLE;
+	return fn(arch, mode, handle);
+#endif
+}
+
+static enum cs_err perf_cs_option(csh handle, enum cs_opt_type type, size_t value)
+{
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+	return cs_option(handle, type, value);
+#else
+	static bool fn_init;
+	static enum cs_err (*fn)(csh handle, enum cs_opt_type type, size_t value);
+
+	if (!fn_init) {
+		fn = dlsym(perf_cs_dll_handle(), "cs_option");
+		if (!fn)
+			pr_debug("dlsym failed for cs_option\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return CS_ERR_HANDLE;
+	return fn(handle, type, value);
+#endif
+}
+
+static size_t perf_cs_disasm(csh handle, const uint8_t *code, size_t code_size,
+			uint64_t address, size_t count, struct cs_insn **insn)
+{
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+	return cs_disasm(handle, code, code_size, address, count, insn);
+#else
+	static bool fn_init;
+	static enum cs_err (*fn)(csh handle, const uint8_t *code, size_t code_size,
+				 uint64_t address, size_t count, struct cs_insn **insn);
+
+	if (!fn_init) {
+		fn = dlsym(perf_cs_dll_handle(), "cs_disasm");
+		if (!fn)
+			pr_debug("dlsym failed for cs_disasm\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return CS_ERR_HANDLE;
+	return fn(handle, code, code_size, address, count, insn);
 #endif
+}
 
+static void perf_cs_free(struct cs_insn *insn, size_t count)
+{
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
+	cs_free(insn, count);
+#else
+	static bool fn_init;
+	static void (*fn)(struct cs_insn *insn, size_t count);
+
+	if (!fn_init) {
+		fn = dlsym(perf_cs_dll_handle(), "cs_free");
+		if (!fn)
+			pr_debug("dlsym failed for cs_free\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return;
+	fn(insn, count);
+#endif
+}
+
+static enum cs_err perf_cs_close(csh *handle)
+{
+#ifdef HAVE_LIBCAPSTONE_SUPPORT
+	return cs_close(handle);
+#else
+	static bool fn_init;
+	static enum cs_err (*fn)(csh *handle);
+
+	if (!fn_init) {
+		fn = dlsym(perf_cs_dll_handle(), "cs_close");
+		if (!fn)
+			pr_debug("dlsym failed for cs_close\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return CS_ERR_HANDLE;
+	return fn(handle);
+#endif
+}
+
 static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
 			 bool disassembler_style)
 {
-	cs_arch arch;
-	cs_mode mode;
+	enum cs_arch arch;
+	enum cs_mode mode;
 
 	if (machine__is(machine, "x86_64") && is64) {
 		arch = CS_ARCH_X86;
@@ -44,7 +274,7 @@ static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
 		return -1;
 	}
 
-	if (cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
+	if (perf_cs_open(arch, mode, cs_handle) != CS_ERR_OK) {
 		pr_warning_once("cs_open failed\n");
 		return -1;
 	}
@@ -56,27 +286,25 @@ static int capstone_init(struct machine *machine, csh *cs_handle, bool is64,
 		 * is set via annotation args
 		 */
 		if (disassembler_style)
-			cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
+			perf_cs_option(*cs_handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
 		/*
 		 * Resolving address operands to symbols is implemented
 		 * on x86 by investigating instruction details.
 		 */
-		cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
+		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
 	}
 
 	return 0;
 }
-#endif
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
-static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_insn *insn,
+static size_t print_insn_x86(struct thread *thread, u8 cpumode, struct cs_insn *insn,
 			     int print_opts, FILE *fp)
 {
 	struct addr_location al;
 	size_t printed = 0;
 
 	if (insn->detail && insn->detail->x86.op_count == 1) {
-		cs_x86_op *op = &insn->detail->x86.operands[0];
+		struct cs_x86_op *op = &insn->detail->x86.operands[0];
 
 		addr_location__init(&al);
 		if (op->type == X86_OP_IMM &&
@@ -94,7 +322,6 @@ static size_t print_insn_x86(struct thread *thread, u8 cpumode, cs_insn *insn,
 	printed += fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
 	return printed;
 }
-#endif
 
 
 ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
@@ -105,9 +332,8 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
 				   uint64_t ip __maybe_unused, int *lenp __maybe_unused,
 				   int print_opts __maybe_unused, FILE *fp __maybe_unused)
 {
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
 	size_t printed;
-	cs_insn *insn;
+	struct cs_insn *insn;
 	csh cs_handle;
 	size_t count;
 	int ret;
@@ -117,7 +343,7 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
 	if (ret < 0)
 		return ret;
 
-	count = cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
+	count = perf_cs_disasm(cs_handle, code, code_size, ip, 1, &insn);
 	if (count > 0) {
 		if (machine__normalized_is(machine, "x86"))
 			printed = print_insn_x86(thread, cpumode, &insn[0], print_opts, fp);
@@ -125,20 +351,16 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
 			printed = fprintf(fp, "%s %s", insn[0].mnemonic, insn[0].op_str);
 		if (lenp)
 			*lenp = insn->size;
-		cs_free(insn, count);
+		perf_cs_free(insn, count);
 	} else {
 		printed = -1;
 	}
 
-	cs_close(&cs_handle);
+	perf_cs_close(&cs_handle);
 	return printed;
-#else
-	return -1;
-#endif
 }
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
-static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
+static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
 				  struct annotate_args *args, u64 addr)
 {
 	int i;
@@ -153,7 +375,7 @@ static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 		return;
 
 	for (i = 0; i < insn->detail->x86.op_count; i++) {
-		cs_x86_op *op = &insn->detail->x86.operands[i];
+		struct cs_x86_op *op = &insn->detail->x86.operands[i];
 		u64 orig_addr;
 
 		if (op->type != X86_OP_MEM)
@@ -194,9 +416,7 @@ static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 		break;
 	}
 }
-#endif
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
 struct find_file_offset_data {
 	u64 ip;
 	u64 offset;
@@ -213,9 +433,7 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
 	}
 	return 0;
 }
-#endif
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
 static u8 *
 read_symbol(const char *filename, struct map *map, struct symbol *sym,
 	    u64 *len, bool *is_64bit)
@@ -262,13 +480,11 @@ read_symbol(const char *filename, struct map *map, struct symbol *sym,
 	free(buf);
 	return NULL;
 }
-#endif
 
 int symbol__disassemble_capstone(const char *filename __maybe_unused,
 				 struct symbol *sym __maybe_unused,
 				 struct annotate_args *args __maybe_unused)
 {
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms.map;
 	u64 start = map__rip_2objdump(map, sym->start);
@@ -279,7 +495,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	bool needs_cs_close = false;
 	u8 *buf = NULL;
 	csh handle;
-	cs_insn *insn = NULL;
+	struct cs_insn *insn = NULL;
 	char disasm_buf[512];
 	struct disasm_line *dl;
 	bool disassembler_style = false;
@@ -316,7 +532,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 
 	needs_cs_close = true;
 
-	free_count = count = cs_disasm(handle, buf, len, start, len, &insn);
+	free_count = count = perf_cs_disasm(handle, buf, len, start, len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
 		int printed;
 
@@ -355,9 +571,9 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 
 out:
 	if (needs_cs_close) {
-		cs_close(&handle);
+		perf_cs_close(&handle);
 		if (free_count > 0)
-			cs_free(insn, free_count);
+			perf_cs_free(insn, free_count);
 	}
 	free(buf);
 	return count < 0 ? count : 0;
@@ -377,16 +593,12 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	}
 	count = -1;
 	goto out;
-#else
-	return -1;
-#endif
 }
 
 int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 					 struct symbol *sym __maybe_unused,
 					 struct annotate_args *args __maybe_unused)
 {
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms.map;
 	struct dso *dso = map__dso(map);
@@ -499,7 +711,7 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 
 out:
 	if (needs_cs_close)
-		cs_close(&handle);
+		perf_cs_close(&handle);
 	free(buf);
 	return count < 0 ? count : 0;
 
@@ -508,7 +720,4 @@ int symbol__disassemble_capstone_powerpc(const char *filename __maybe_unused,
 		close(fd);
 	count = -1;
 	goto out;
-#else
-	return -1;
-#endif
 }
-- 
2.51.0.570.gb178f27e6d-goog


