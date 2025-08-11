Return-Path: <bpf+bounces-65390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEFDB21735
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 23:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F06463474
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D582E1743;
	Mon, 11 Aug 2025 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+cHARjW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05831F4C8C
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947235; cv=none; b=svxC4DxHeCeQpvhNycDU+8mfxY1ABLQu2AnjaT/+fqnoUK1AaVrdbLYMbdRTjNm46jwi8itxr88quxq8KqT8+71S7D5Pe5cZ0ThNdETal9kbSgj1yvI29ux3uSn48x4WaN22gYoNC0Y7HfUVkrPbrLcQJQPv5rxE+HoLPtIQibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947235; c=relaxed/simple;
	bh=EGVm338xMb7TMjEwl5577Foh7hxeEgsulFUP9QtIdgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aoo9CVKayZDJ+om7DFYgzyD0tRSMWLzgz5GYLMw3HRwciEPyS1SXv/mu8zxIsJDSwHe3T1xWh/1O9xWj8UEi3SDy2KeoPRrRXXo/NJ/DDYx7Mr65sm31DKDpUPIShNX6fDyxTDn0WK8U2Fd/E6B/f9L8y8WbI1v61PL7WakDm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+cHARjW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b77b8750acso2934436f8f.0
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 14:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754947232; x=1755552032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rC+1v0SW8dAtIM174UQiLKP1sf6Jf2RwwjeYm5/I8lc=;
        b=a+cHARjWgyvHpupAteLbrJogy8CdeIvafVXG85e793Ybga6fQcbHnZZ3ra+BTLU1Is
         V9t6K2HRAYDrRJJiH73m34PMw9HxL84sx+JJvj/VO+wO1sfrvd2q6RWb32uoRBxvx+NW
         Ye62WNIBxbgx/4+7WAEWRahei8gzvxLpg7v3X0wzcUOWl92VhYtYNHkOjNTQZc+xW4vH
         yDZeNt0qEE7Zh5hxTgjUlhivi2Fej9QzCT2cMHujwv3Emua2IfodQC9948+iJ0xDhKrV
         SJ6LEu4ssUE6ZD3+eP5Ix0VaJVgjQejaJSoU9V0sX9qojh1XVID4ezGP/W0fCi9+r1mW
         XvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754947232; x=1755552032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rC+1v0SW8dAtIM174UQiLKP1sf6Jf2RwwjeYm5/I8lc=;
        b=tCWFyw/BYSTF+Ch/Q7MBNLVsXE2H6NIlxDiTH8GRiz4oxcf2WNwrCh7RT3R/Ax8sw1
         cvpZwUe563LtFpsMUgMdZ4V5hqjzC3aaJk/5nZck9BOADpNF7noIvs1UlCIuB29FDV5p
         nLvg3fWj609mBjzoiVx5oRIUjnflR1OE3usRfxQVqCKhr+gJUtadtN9a2WYVQ+bOHR5Q
         dpyPvIw/1mTbQC5x8ZMCkspuSDi2EZPbnP2H3MYIK803mLteWwnp0kl6Fp3qFAkZmuev
         aUrz4IKiP7dGdQJFsIplo3HWFCP8c4+prfhO3wbkSsnoWUXGQjjKqCv4q9Ot/UaQN86j
         xPwg==
X-Gm-Message-State: AOJu0Yz0MexT4WqiglmlGB/EmpFnMTLBoTLf2GKHoW3mhvg8aT5MX0IJ
	KOw3zf8cqkmgP8X+3zJWBFd71WHB2kI2uBiPkVOs7GulVFEOCDre+8fC6ouGsg==
X-Gm-Gg: ASbGncuOMPhbEHDYqP66akIaL0Ma+hCMbFtmqP5o1iTQv/NWgIOLbpmR46DuqfkFu4J
	7cFc2cKAsmieXfnYUNyEJEhsTM5tuhpkFQtLgcKCsUdbyrGD3q1UWFKunVX8GQ5xxTG7w+98cm8
	BFgaulQSobTxpDu06fkb0DIEuksqOU3+4paqoU8T8plip963kVI86e9a0W82eqPfylXyYsKqzvk
	G5dhpt/u2kM3u3BHleelUgyJBXZyAEAH+Uiqxiy7WidJovkMSDnwXWtk63A8uypRFKt0NWqnq1+
	aIxWQhoyAcZw0lLSA/Og2H00mv5GsjeUV2lTrpgwKgOTlBhIqr+XdP/4z45PbTduwpJ28wisKQo
	JhQ==
X-Google-Smtp-Source: AGHT+IE0nMFv7WmbJTGk1MaBxI8rJFRT6K7vAEXzkMaoyukDNtL9sQ9663dJzH97YbgAVm1tnKPLfw==
X-Received: by 2002:a5d:5f81:0:b0:3a5:8991:64b7 with SMTP id ffacd0b85a97d-3b9111f458bmr840433f8f.26.1754947231578;
        Mon, 11 Aug 2025 14:20:31 -0700 (PDT)
Received: from localhost ([2620:10d:c092:600::1:50de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abec8sm43592382f8f.8.2025.08.11.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:20:31 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: add BPF program dump in veristat
Date: Mon, 11 Aug 2025 22:20:26 +0100
Message-ID: <20250811212026.310901-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch adds support for dumping BPF program instructions directly
from veristat.
While it is already possible to inspect BPF program dump using bpftool,
it requires multiple commands. During active development, it's common
for developers to use veristat for testing verification. Integrating
instruction dumping into veristat reduces the need to switch tools and
simplifies the workflow.
By making this information more readily accessible, this change aims
to streamline the BPF development cycle and improve usability for
developers.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/Makefile   |   2 +-
 tools/testing/selftests/bpf/veristat.c | 319 +++++++++++++++++++++++++
 2 files changed, 320 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4863106034df..c9fe5ed4b7f4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -847,7 +847,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 #   snprintf(a, "%s/foo", b);      // triggers -Wformat-truncation
 $(OUTPUT)/veristat.o: CFLAGS += -Wno-format-truncation
 $(OUTPUT)/veristat.o: $(BPFOBJ)
-$(OUTPUT)/veristat: $(OUTPUT)/veristat.o
+$(OUTPUT)/veristat: $(OUTPUT)/veristat.o $(OUTPUT)/disasm.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index d532dd82a3a8..951b25d71909 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -25,6 +25,8 @@
 #include <limits.h>
 #include <assert.h>
 
+#include "disasm.h"
+
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #endif
@@ -181,6 +183,11 @@ struct var_preset {
 	bool applied;
 };
 
+struct kernel_sym {
+	size_t address;
+	char name[256];
+};
+
 static struct env {
 	char **filenames;
 	int filename_cnt;
@@ -227,6 +234,7 @@ static struct env {
 	char orig_cgroup[PATH_MAX];
 	char stat_cgroup[PATH_MAX];
 	int memory_peak_fd;
+	bool dump;
 } env;
 
 static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
@@ -295,6 +303,7 @@ static const struct argp_option opts[] = {
 	  "Force BPF verifier failure on register invariant violation (BPF_F_TEST_REG_INVARIANTS program flag)" },
 	{ "top-src-lines", 'S', "N", 0, "Emit N most frequent source code lines" },
 	{ "set-global-vars", 'G', "GLOBAL", 0, "Set global variables provided in the expression, for example \"var1 = 1\"" },
+	{ "dump", 'p', NULL, 0, "Print BPF program dump" },
 	{},
 };
 
@@ -427,6 +436,9 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			return err;
 		}
 		break;
+	case 'p':
+		env.dump = true;
+		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -891,6 +903,14 @@ static bool is_desc_sym(char c)
 	return c == 'v' || c == 'V' || c == '.' || c == '!' || c == '_';
 }
 
+static const char *ltrim(const char *s)
+{
+	while (isspace(*s))
+		s++;
+
+	return s;
+}
+
 static char *rtrim(char *str)
 {
 	int i;
@@ -1554,6 +1574,304 @@ static int parse_rvalue(const char *val, struct rvalue *rvalue)
 	return 0;
 }
 
+static int kernel_syms_cmp(const void *sym_a, const void *sym_b)
+{
+	return ((struct kernel_sym *)sym_a)->address -
+	       ((struct kernel_sym *)sym_b)->address;
+}
+
+struct dump_context {
+	struct bpf_prog_info *info;
+	struct kernel_sym *kernel_syms;
+	int kernel_sym_cnt;
+	size_t kfunc_base_addr;
+	char scratch_buf[512];
+};
+
+static void kernel_syms_free(struct dump_context *ctx)
+{
+	free(ctx->kernel_syms);
+	ctx->kernel_syms = NULL;
+	ctx->kernel_sym_cnt = 0;
+}
+
+static void kernel_syms_load(struct dump_context *ctx)
+{
+	struct kernel_sym *sym;
+	char buff[256];
+	void *tmp, *address;
+	FILE *fp;
+
+	fp = fopen("/proc/kallsyms", "r");
+	if (!fp)
+		return;
+	while (fgets(buff, sizeof(buff), fp)) {
+		tmp = reallocarray(ctx->kernel_syms, ctx->kernel_sym_cnt + 1,
+				   sizeof(*ctx->kernel_syms));
+		if (!tmp)
+			goto failure;
+		ctx->kernel_syms = tmp;
+		sym = ctx->kernel_syms + ctx->kernel_sym_cnt;
+
+		if (sscanf(buff, "%p %*c %s", &address, sym->name) < 2)
+			continue;
+		sym->address = (unsigned long)address;
+		if (!strcmp(sym->name, "__bpf_call_base")) {
+			ctx->kfunc_base_addr = sym->address;
+			/* sysctl kernel.kptr_restrict was set */
+			if (!sym->address)
+				goto failure;
+		}
+		if (sym->address)
+			ctx->kernel_sym_cnt++;
+	}
+
+	fclose(fp);
+	qsort(ctx->kernel_syms, ctx->kernel_sym_cnt, sizeof(*ctx->kernel_syms), kernel_syms_cmp);
+	return;
+failure:
+	kernel_syms_free(ctx);
+	fclose(fp);
+}
+
+__attribute__((format(printf, 2, 3)))
+static void print_insn(void *private_data, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vprintf(fmt, args);
+	va_end(args);
+}
+
+static struct kernel_sym *kernel_syms_search(unsigned long key, struct dump_context *ctx)
+{
+	struct kernel_sym sym = {
+		.address = key,
+	};
+
+	return ctx->kernel_syms ? bsearch(&sym, ctx->kernel_syms, ctx->kernel_sym_cnt,
+					  sizeof(*ctx->kernel_syms), kernel_syms_cmp) :
+				  NULL;
+}
+
+static const char *print_call(void *private_data, const struct bpf_insn *insn)
+{
+	struct kernel_sym *sym;
+	struct dump_context *ctx = (struct dump_context *)private_data;
+	size_t address = ctx->kfunc_base_addr + insn->imm;
+	struct bpf_prog_info *info = ctx->info;
+
+	if (insn->src_reg == BPF_PSEUDO_CALL) {
+		if ((__u32)insn->imm < info->nr_jited_ksyms && info->jited_ksyms) {
+			__u64 *ptr = (void *)(size_t)info->jited_ksyms;
+
+			address = ptr[insn->imm];
+		}
+
+		sym = kernel_syms_search(address, ctx);
+		if (!info->jited_ksyms)
+			snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "%+d", insn->off);
+		else if (sym)
+			snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "%+d#%s", insn->off,
+				 sym->name);
+		else
+			snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "%+d#0x%lx", insn->off,
+				 address);
+	} else {
+		sym = kernel_syms_search(address, ctx);
+		if (sym)
+			snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "%s", sym->name);
+		else
+			snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "0x%lx", address);
+	}
+	return ctx->scratch_buf;
+}
+
+static const char *print_imm(void *private_data, const struct bpf_insn *insn, __u64 full_imm)
+{
+	struct dump_context *ctx = (struct dump_context *)private_data;
+
+	switch (insn->src_reg) {
+	case BPF_PSEUDO_MAP_FD:
+		snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "map[id:%d]", insn->imm);
+		break;
+	case BPF_PSEUDO_MAP_VALUE:
+		snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "map[id:%d][0]+%d", insn->imm,
+			 insn[1].imm);
+		break;
+	case BPF_PSEUDO_MAP_IDX_VALUE:
+		snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "map[idx:%d]+%d", insn->imm,
+			 insn[1].imm);
+		break;
+	case BPF_PSEUDO_FUNC:
+		snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "subprog[%+d]", insn->imm);
+		break;
+	default:
+		snprintf(ctx->scratch_buf, sizeof(ctx->scratch_buf), "0x%llx",
+			 (unsigned long long)full_imm);
+	}
+	return ctx->scratch_buf;
+}
+
+static void func_printf(void *ctx, const char *fmt, va_list args)
+{
+	vprintf(fmt, args);
+}
+
+static int prep_prog_info(struct bpf_prog_info *info)
+{
+	struct bpf_prog_info holder = {};
+	size_t needed = 0;
+	void *ptr;
+
+	holder.xlated_prog_len = info->xlated_prog_len;
+	needed += info->xlated_prog_len;
+
+	holder.nr_jited_ksyms = info->nr_jited_ksyms;
+	needed += info->nr_jited_ksyms * sizeof(__u64);
+
+	holder.nr_jited_func_lens = info->nr_jited_func_lens;
+	needed += info->nr_jited_func_lens * sizeof(__u32);
+
+	holder.nr_func_info = info->nr_func_info;
+	holder.func_info_rec_size = info->func_info_rec_size;
+	needed += info->nr_func_info * info->func_info_rec_size;
+
+	holder.nr_line_info = info->nr_line_info;
+	holder.line_info_rec_size = info->line_info_rec_size;
+	needed += info->nr_line_info * info->line_info_rec_size;
+
+	holder.nr_jited_line_info = info->nr_jited_line_info;
+	holder.jited_line_info_rec_size = info->jited_line_info_rec_size;
+	needed += info->nr_jited_line_info * info->jited_line_info_rec_size;
+	ptr = malloc(needed);
+	if (!ptr)
+		return -ENOMEM;
+
+	holder.xlated_prog_insns = (unsigned long)(ptr);
+	ptr += holder.xlated_prog_len;
+
+	holder.jited_ksyms = (unsigned long)(ptr);
+	ptr += holder.nr_jited_ksyms * sizeof(__u64);
+
+	holder.jited_func_lens = (unsigned long)(ptr);
+	ptr += holder.nr_jited_func_lens * sizeof(__u32);
+
+	holder.func_info = (unsigned long)(ptr);
+	ptr += holder.nr_func_info * holder.func_info_rec_size;
+
+	holder.line_info = (unsigned long)(ptr);
+	ptr += holder.nr_line_info * holder.line_info_rec_size;
+
+	holder.jited_line_info = (unsigned long)(ptr);
+	ptr += holder.nr_jited_line_info * holder.jited_line_info_rec_size;
+
+	*info = holder;
+	return 0;
+}
+
+static void emit_line_info(const struct btf *btf, const struct bpf_line_info *linfo)
+{
+	const char *line = btf__name_by_offset(btf, linfo->line_off);
+
+	if (!line)
+		return;
+	line = ltrim(line);
+	printf("; %s\n", line);
+}
+
+static void emit_func_info(struct btf_dump *d, const struct btf *btf,
+			   const struct bpf_func_info *finfo)
+{
+	LIBBPF_OPTS(btf_dump_emit_type_decl_opts, emit_opts);
+	const struct btf_type *t;
+	__u32 name_off;
+
+	name_off = btf__type_by_id(btf, finfo->type_id)->name_off;
+	emit_opts.field_name = btf__name_by_offset(btf, name_off);
+	if (!emit_opts.field_name) /* field_name can't be NULL */
+		emit_opts.field_name = "N/A";
+	t = btf__type_by_id(btf, finfo->type_id);
+	btf_dump__emit_type_decl(d, t->type, &emit_opts);
+	printf(":\n");
+}
+
+static void dump_xlated(const struct btf *btf, struct bpf_program *prog, struct bpf_prog_info *info)
+{
+	const struct bpf_insn *insn;
+	const struct bpf_func_info *finfo;
+	const struct bpf_line_info *linfo;
+	const struct bpf_prog_linfo *prog_linfo;
+	struct btf_dump *d;
+	__u32 nr_skip = 0, i, n;
+	bool double_insn = false;
+	LIBBPF_OPTS(btf_dump_opts, dump_opts);
+	LIBBPF_OPTS(btf_dump_emit_type_decl_opts, emit_opts);
+	struct dump_context ctx = {
+		.info = info,
+		.kernel_syms = NULL,
+		.kernel_sym_cnt = 0,
+		.kfunc_base_addr = 0
+	};
+	struct bpf_insn_cbs cbs = {
+		.cb_print = print_insn,
+		.cb_call = print_call,
+		.cb_imm = print_imm,
+		.private_data = &ctx,
+	};
+
+	/* load symbols for each prog, as prog load could have added new items */
+	kernel_syms_load(&ctx);
+
+	prog_linfo = bpf_prog_linfo__new(info);
+	insn = (struct bpf_insn *)info->xlated_prog_insns;
+	finfo = (struct bpf_func_info *)info->func_info;
+	d = btf_dump__new(btf, func_printf, NULL, &dump_opts);
+	n = info->xlated_prog_len / sizeof(*insn);
+
+	for (i = 0; i < n; i += double_insn ? 2 : 1) {
+		if (d && finfo && finfo->insn_off == i) {
+			emit_func_info(d, btf, finfo);
+			finfo++;
+		}
+
+		if (prog_linfo) {
+			linfo = bpf_prog_linfo__lfind(prog_linfo, i, nr_skip);
+			if (linfo) {
+				emit_line_info(btf, linfo);
+				nr_skip++;
+			}
+		}
+		printf("%4u: ", i);
+		print_bpf_insn(&cbs, insn + i, false);
+		double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
+	}
+
+	kernel_syms_free(&ctx);
+	btf_dump__free(d);
+}
+
+static void dump(const struct btf *btf, struct bpf_program *prog, struct bpf_prog_info *info,
+		 int prog_fd)
+{
+	int err;
+	__u32 info_len = sizeof(*info);
+
+	if (!env.dump || prog_fd <= 0)
+		return;
+
+	err = prep_prog_info(info);
+	if (err)
+		return;
+
+	if (bpf_prog_get_info_by_fd(prog_fd, info, &info_len) != 0)
+		goto cleanup;
+	dump_xlated(btf, prog, info);
+cleanup:
+	free((void *)(unsigned long)info->xlated_prog_insns);
+}
+
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
 	const char *base_filename = basename(strdupa(filename));
@@ -1634,6 +1952,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 		stats->stats[JITED_SIZE] = info.jited_prog_len;
 
 	parse_verif_log(buf, buf_sz, stats);
+	dump(bpf_object__btf(obj), prog, &info, fd);
 
 	if (env.verbose) {
 		printf("PROCESSING %s/%s, DURATION US: %ld, VERDICT: %s, VERIFIER LOG:\n%s\n",
-- 
2.50.1


