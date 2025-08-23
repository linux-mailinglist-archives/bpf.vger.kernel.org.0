Return-Path: <bpf+bounces-66337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F22FB325E1
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 02:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4192C625BFC
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644581C5F09;
	Sat, 23 Aug 2025 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WkCgzCeP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02DE1A23A4
	for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909163; cv=none; b=pkkLR6nZenZk2hmEkglbuh2nhZqooEE8b2mDNlOdyxh2gZosn8XPQOT1P47icp7/xUZphfcR66GNLhitc0iDR7h/ZiDrbYpenICPiZkenoiF3rrkZreV0O3UYBQV3IOhlAhaeQeXdAH481KaFvwRwtNKa59jLC8vl3SGj6NW5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909163; c=relaxed/simple;
	bh=YNp6Un8jB8VueHw7VLN6PxAxn7Rzd03dn00HYkjAljg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Pli0nrcQYAfDgR62y/YdrwwbFyF4lCmn8EQvaxb7mZLvRCsF/2ar+hawwoMN1xqqIh+buq92fB5aXk6jcctWVS0hoBSktUCnufV2aII3hKbV1Az/J7EBATGbfK1NysMKpksr0kpZuB/TMLFvTkPa6dEHdeK+gM7lGLrTU8wIrzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WkCgzCeP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581187c6so34846725ad.1
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 17:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909161; x=1756513961; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5J36ldUwfJPgYtcAt1dgEXuEq4rBs3D8Tr5Y9rSZGE=;
        b=WkCgzCePeWeA+n7A5OzFlascU/P4lxkb5Cp6r9lJt11PZYT3euB3LE1l5YmgSLXYDV
         6Y04fs0rFs85jPvMWYkDm2WxKDnEcb0Mt3YCa9O1UK1HhCERKlc/ygG15XcdcCV0cJs/
         9HSL3rei3mONn1JFnP54CGWGAG554XcsMv3GTUKFDaSfYgzt4whWsjb+yKhV/9+0bNdS
         U48JxjnE4ocLdojMyR6sbBJWwj01YoylGevU9HPsH6d/l8lIC4b7HMuQWIbSeNr14+3E
         DH3B0fNhBY7eHN5KmRqt73UbUIFQD5i6ybxZbzfZFFioPBH+e0yM/vN9jHPz4A2qQiHl
         vkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909161; x=1756513961;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5J36ldUwfJPgYtcAt1dgEXuEq4rBs3D8Tr5Y9rSZGE=;
        b=f0avgpkX8HG9yiCI+Q/DDtcOkavYWxcKAWcu3AzuVd7/7Dh/AHXrAOVWYd/Zz6cdL3
         4SpEnXAq6itsRLKck43eXlcZ0au7bsu4E/LvpoBSow0J6sTXV3yzc/beazhWml2jp8vt
         /nrDCsR34SnopgdG8Of7nQ5UI3br/kM0OqdtexHja7DBaNkZE/bURl3gNDPCboKwBuKC
         MoshN977Xd/M0ucTHpguh0S2h+FEz13t2jF6nF8xPyXvuTJm/yLUrsY5MuXN/FndKq5G
         98ao0gBDKdgrc/7xtREAYJ6DYhG4euQpdo1Us+DEiFuMGAeI3JCnG481cvT1QW1Lan4Q
         ugKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyaHj1JvrAoNigRlEARAAfLGfc8nXZRROwuGVEg4uwg39hKged8COZzCVRLj0dHMgBLzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynsQoRmtT7/H2bc2e4HT3ioKTwXfk2V3jJi14uoJD2wPsy4fpr
	DZ0WhDSlWRjLCLcDK0IdFvdCXpmxLTbCgkFKP+EYjZf9tOcgxytBOpjgnUXEo08RL/tY2Vlc5CA
	t/uXiHTxdeQ==
X-Google-Smtp-Source: AGHT+IGvdtT9DdnjI0VAIa21Y1Gk7rCy9ek2Zl9MvCyyZxYX4shEhZAuMKYydVdN7y91cPlU0zEezkdZni3o
X-Received: from plbmp6.prod.google.com ([2002:a17:902:fd06:b0:246:230b:f282])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec2:b0:245:fe27:fe80
 with SMTP id d9443c01a7336-2462eeb004cmr71478625ad.26.1755909161106; Fri, 22
 Aug 2025 17:32:41 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:02 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-7-irogers@google.com>
Subject: [PATCH v5 06/19] perf capstone: Support for dlopen-ing libcapstone.so
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
2.51.0.rc2.233.g662b1ed5c5-goog


