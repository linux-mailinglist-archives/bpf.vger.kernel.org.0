Return-Path: <bpf+bounces-37297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FF0953C37
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647211F222DC
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 20:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910FD14B965;
	Thu, 15 Aug 2024 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKX0SXBL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142838DC7
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755396; cv=none; b=HaEksFsWKw96maaQsNga8loJyX9RC4Kj7WRQSkPEe2OiK0I2xLaYVFLxCCbrvRAQDgvt3QXhsbDL/pwH+PprlB6RsTzavGcZNpqKekrBDmKYfyJLHSy5oPrzRIa40QTUdEv2ICWj0iA1T/GA/zInJbxQe7Q1g6MmLEMGaou3p84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755396; c=relaxed/simple;
	bh=8svz8hLcGQBLLl6v7s906A4XSqVqZtzWjxrNN322UbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoTkxpBo23Sxh2NN7vU961OCTME6xlLpjUVXMAGDYxlV3ml1LU82UjDF+vsLynjCe3uM+iOZy3QGIn6ibWwmO8ZYwXdM3MUVQMPRabyhMDjS9AdPSAPYddcV7ZlWSbjGpoZO3GszGBuOj2CUCvwSO4vRwGaLq73M7877x+kdbpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKX0SXBL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fec34f94abso13681635ad.2
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723755393; x=1724360193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5ThoDqZ4+AH2DIlG8lMUbHRTcUADtlux5x4v4uoxfM=;
        b=eKX0SXBLjD/2Tn+423DQH/2Yg7J9Hp5p1CHyhdLxn4/N6hgEwTbwREm1rHxDzHtOTQ
         kh3C8oltbYbvC6CAAVUmyPTS9dAFs5CK8wxG5Er7P/x0i0cJ54QQlhi9q3tRQLKGPQt7
         l1ZIKEVtp9hiMkANmL6AcIcKw22mldzsZx/s7e2xSuH9CudDpQxIBml1x9j4JmoFThS1
         GjdEPuBFm621bPMzOlD8eYb1AGEOTxZWI0M16dqbbj2wbf/KoHxUS2C1EY2sOrUCwDOG
         DTQpuqVGiu7FgBFGZY2IxP0uCegzftmNHc2HcfmJeze+9S4V3jB1qY1gfOwV2H5PWtcd
         DUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755393; x=1724360193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5ThoDqZ4+AH2DIlG8lMUbHRTcUADtlux5x4v4uoxfM=;
        b=goSqyy/Hhayp8RO3xjvCxUgxYBwhVIRRIOABei9sV+DhngoejpOFOW1WvFdfumiA5K
         n0tQWAvUBxRf0wXFPLu74ANsqDRkOQLFvjBb5QHJNschNDyx32O84V7uRvUJ7e48avfc
         b1owykWZd1pu6/6NkkQ5HRPk/rwMcBRgNfqmryvzplivCe7NsXNPJt8X1ZOyLYmAopTu
         PPSQSAqtnhh67zQ7FbPTb9rWyhFTnjf91DnypABf+LU5uKdLc3oU10iFHNm8J4VKI4HC
         rOMSvrFEbLSzizufovjwyAeKTqSjj30MQMscH+qoiW7cEE5qhNkx17if4bjmei3NqoQw
         1sLg==
X-Gm-Message-State: AOJu0Yxw7S8xxq5HB6+VA0cIWJaHGeSV5gwdKmMRFBHrQ70+N3OVNIOR
	p3zrEa9+C3YxrqgQybCVfJ+kV74SX9K0fED8KbDfGDtdRyVI/WKmr004zMIRo/Q=
X-Google-Smtp-Source: AGHT+IH6VYs6Q7iVkIdA/B/r5wzdjIYFM5Cakk9VGPU9yoVHAHwtpBrKea/MxflJpUB1pSch7JGU1A==
X-Received: by 2002:a17:90b:1e4a:b0:2c8:81b:e798 with SMTP id 98e67ed59e1d1-2d3e00f2f83mr971650a91.30.1723755392850;
        Thu, 15 Aug 2024 13:56:32 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7f2eb2sm4024364a91.26.2024.08.15.13.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 13:56:32 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	hffilwlqm@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: utility function to get program disassembly after jit
Date: Thu, 15 Aug 2024 13:54:47 -0700
Message-ID: <20240815205449.242556-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815205449.242556-1-eddyz87@gmail.com>
References: <20240815205449.242556-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a utility function to get disassembled text for jited
representation of a BPF program designated by file descriptor.
Function prototype looks as follows:

    int get_jited_program_text(int fd, char *text, size_t text_sz)

Where 'fd' is a file descriptor for the program, 'text' and 'text_sz'
refer to a destination buffer for disassembled text.

The code and makefile changes are inspired by jit_disasm.c from bpftool.
Use llvm libraries to disassemble BPF program instead of libbfd to avoid
issues with disassembly output stability pointed out in [1].

Selftests makefile uses Makefile.feature to detect if LLVM libraries
are available. If that is not the case selftests build proceeds but
the function returns -ENOTSUP at runtime.

[1] commit eb9d1acf634b ("bpftool: Add LLVM as default library for disassembling JIT-ed programs")

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  51 +++-
 .../selftests/bpf/jit_disasm_helpers.c        | 234 ++++++++++++++++++
 .../selftests/bpf/jit_disasm_helpers.h        |  10 +
 4 files changed, 294 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.c
 create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.h

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 8f14d8faeb0b..7de4108771a0 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -8,6 +8,7 @@ test_lru_map
 test_lpm_map
 test_tag
 FEATURE-DUMP.libbpf
+FEATURE-DUMP.selftests
 fixdep
 /test_progs
 /test_progs-no_alu32
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f54185e96a95..b1a52739d9e7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -33,6 +33,13 @@ OPT_FLAGS	?= $(if $(RELEASE),-O2,-O0)
 LIBELF_CFLAGS	:= $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
 LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
+
 CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
 	  -Wall -Werror -fno-omit-frame-pointer				\
 	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
@@ -55,6 +62,11 @@ progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
 progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
 progs/test_global_func9.c-CFLAGS := -fno-strict-aliasing
 
+# Some utility functions use LLVM libraries
+jit_disasm_helpers.c-CFLAGS = $(LLVM_CFLAGS)
+test_progs-LDLIBS = $(LLVM_LDLIBS)
+test_progs-LDFLAGS = $(LLVM_LDFLAGS)
+
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
 CFLAGS += -Wno-unused-command-line-argument
@@ -164,6 +176,31 @@ endef
 
 include ../lib.mk
 
+NON_CHECK_FEAT_TARGETS := clean docs-clean
+CHECK_FEAT := $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDGOALS), "none"))
+ifneq ($(CHECK_FEAT),)
+FEATURE_USER := .selftests
+FEATURE_TESTS := llvm
+FEATURE_DISPLAY := $(FEATURE_TESTS)
+
+# Makefile.feature expects OUTPUT to end with a slash
+$(let OUTPUT,$(OUTPUT)/,\
+	$(eval include ../../../build/Makefile.feature))
+endif
+
+ifeq ($(feature-llvm),1)
+  LLVM_CFLAGS  += -DHAVE_LLVM_SUPPORT
+  LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
+  # both llvm-config and lib.mk add -D_GNU_SOURCE, which ends up as conflict
+  LLVM_CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
+  LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
+  ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
+    LLVM_LDLIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
+    LLVM_LDLIBS += -lstdc++
+  endif
+  LLVM_LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
+endif
+
 SCRATCH_DIR := $(OUTPUT)/tools
 BUILD_DIR := $(SCRATCH_DIR)/build
 INCLUDE_DIR := $(SCRATCH_DIR)/include
@@ -488,6 +525,7 @@ define DEFINE_TEST_RUNNER
 
 TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
 TRUNNER_BINARY := $1$(if $2,-)$2
+TRUNNER_BASE_NAME := $1
 TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
 				 $$(notdir $$(wildcard $(TRUNNER_TESTS_DIR)/*.c)))
 TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
@@ -611,6 +649,10 @@ ifeq ($(filter clean docs-clean,$(MAKECMDGOALS)),)
 include $(wildcard $(TRUNNER_TEST_OBJS:.o=.d))
 endif
 
+# add per extra obj CFGLAGS definitions
+$(foreach N,$(patsubst $(TRUNNER_OUTPUT)/%.o,%,$(TRUNNER_EXTRA_OBJS)),	\
+	$(eval $(TRUNNER_OUTPUT)/$(N).o: CFLAGS += $($(N).c-CFLAGS)))
+
 $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 		       %.c						\
 		       $(TRUNNER_EXTRA_HDRS)				\
@@ -627,6 +669,9 @@ ifneq ($2:$(OUTPUT),:$(shell pwd))
 	$(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
 endif
 
+$(OUTPUT)/$(TRUNNER_BINARY): LDLIBS += $$($(TRUNNER_BASE_NAME)-LDLIBS)
+$(OUTPUT)/$(TRUNNER_BINARY): LDFLAGS += $$($(TRUNNER_BASE_NAME)-LDFLAGS)
+
 # some X.test.o files have runtime dependencies on Y.bpf.o files
 $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
 
@@ -636,7 +681,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 			     $(TRUNNER_BPFTOOL)				\
 			     | $(TRUNNER_BINARY)-extras
 	$$(call msg,BINARY,,$$@)
-	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
+	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LDFLAGS) -o $$@
 	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
 	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
 		   $(OUTPUT)/$(if $2,$2/)bpftool
@@ -655,6 +700,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 cap_helpers.c		\
 			 unpriv_helpers.c 	\
 			 netlink_helpers.c	\
+			 jit_disasm_helpers.c	\
 			 test_loader.c		\
 			 xsk.c			\
 			 disasm.c		\
@@ -797,7 +843,8 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 	$(addprefix $(OUTPUT)/,*.o *.d *.skel.h *.lskel.h *.subskel.h	\
 			       no_alu32 cpuv4 bpf_gcc bpf_testmod.ko	\
 			       bpf_test_no_cfi.ko			\
-			       liburandom_read.so)
+			       liburandom_read.so)			\
+	$(OUTPUT)/FEATURE-DUMP.selftests
 
 .PHONY: docs docs-clean
 
diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
new file mode 100644
index 000000000000..d1ded19be759
--- /dev/null
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include <test_progs.h>
+
+#ifdef HAVE_LLVM_SUPPORT
+
+#include <llvm-c/Core.h>
+#include <llvm-c/Disassembler.h>
+#include <llvm-c/Target.h>
+#include <llvm-c/TargetMachine.h>
+
+/* The intent is to use get_jited_program_text() for small test
+ * programs written in BPF assembly, thus assume that 32 local labels
+ * would be sufficient.
+ */
+#define MAX_LOCAL_LABELS 32
+
+static bool llvm_initialized;
+
+struct local_labels {
+	bool print_phase;
+	__u32 prog_len;
+	__u32 cnt;
+	__u32 pcs[MAX_LOCAL_LABELS];
+	char names[MAX_LOCAL_LABELS][4];
+};
+
+static const char *lookup_symbol(void *data, uint64_t ref_value, uint64_t *ref_type,
+				 uint64_t ref_pc, const char **ref_name)
+{
+	struct local_labels *labels = data;
+	uint64_t type = *ref_type;
+	int i;
+
+	*ref_type = LLVMDisassembler_ReferenceType_InOut_None;
+	*ref_name = NULL;
+	if (type != LLVMDisassembler_ReferenceType_In_Branch)
+		return NULL;
+	/* Depending on labels->print_phase either discover local labels or
+	 * return a name assigned with local jump target:
+	 * - if print_phase is true and ref_value is in labels->pcs,
+	 *   return corresponding labels->name.
+	 * - if print_phase is false, save program-local jump targets
+	 *   in labels->pcs;
+	 */
+	if (labels->print_phase) {
+		for (i = 0; i < labels->cnt; ++i)
+			if (labels->pcs[i] == ref_value)
+				return labels->names[i];
+	} else {
+		if (labels->cnt < MAX_LOCAL_LABELS && ref_value < labels->prog_len)
+			labels->pcs[labels->cnt++] = ref_value;
+	}
+	return NULL;
+}
+
+static int disasm_insn(LLVMDisasmContextRef ctx, uint8_t *image, __u32 len, __u32 pc,
+		       char *buf, __u32 buf_sz)
+{
+	int i, cnt;
+
+	cnt = LLVMDisasmInstruction(ctx, image + pc, len - pc, pc,
+				    buf, buf_sz);
+	if (cnt > 0)
+		return cnt;
+	PRINT_FAIL("Can't disasm instruction at offset %d:", pc);
+	for (i = 0; i < 16 && pc + i < len; ++i)
+		printf(" %02x", image[pc + i]);
+	printf("\n");
+	return -EINVAL;
+}
+
+static int cmp_u32(const void *_a, const void *_b)
+{
+	__u32 a = *(__u32 *)_a;
+	__u32 b = *(__u32 *)_b;
+
+	if (a < b)
+		return -1;
+	if (a > b)
+		return 1;
+	return 0;
+}
+
+static int disasm_one_func(FILE *text_out, uint8_t *image, __u32 len)
+{
+	char *label, *colon, *triple = NULL;
+	LLVMDisasmContextRef ctx = NULL;
+	struct local_labels labels = {};
+	__u32 *label_pc, pc;
+	int i, cnt, err = 0;
+	char buf[64];
+
+	triple = LLVMGetDefaultTargetTriple();
+	ctx = LLVMCreateDisasm(triple, &labels, 0, NULL, lookup_symbol);
+	if (!ASSERT_OK_PTR(ctx, "LLVMCreateDisasm")) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	cnt = LLVMSetDisasmOptions(ctx, LLVMDisassembler_Option_PrintImmHex);
+	if (!ASSERT_EQ(cnt, 1, "LLVMSetDisasmOptions")) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* discover labels */
+	labels.prog_len = len;
+	pc = 0;
+	while (pc < len) {
+		cnt = disasm_insn(ctx, image, len, pc, buf, 1);
+		if (cnt < 0) {
+			err = cnt;
+			goto out;
+		}
+		pc += cnt;
+	}
+	qsort(labels.pcs, labels.cnt, sizeof(*labels.pcs), cmp_u32);
+	for (i = 0; i < labels.cnt; ++i)
+		/* use (i % 100) to avoid format truncation warning */
+		snprintf(labels.names[i], sizeof(labels.names[i]), "L%d", i % 100);
+
+	/* now print with labels */
+	labels.print_phase = true;
+	pc = 0;
+	while (pc < len) {
+		cnt = disasm_insn(ctx, image, len, pc, buf, sizeof(buf));
+		if (cnt < 0) {
+			err = cnt;
+			goto out;
+		}
+		label_pc = bsearch(&pc, labels.pcs, labels.cnt, sizeof(*labels.pcs), cmp_u32);
+		label = "";
+		colon = "";
+		if (label_pc) {
+			label = labels.names[label_pc - labels.pcs];
+			colon = ":";
+		}
+		fprintf(text_out, "%x:\t", pc);
+		for (i = 0; i < cnt; ++i)
+			fprintf(text_out, "%02x ", image[pc + i]);
+		for (i = cnt * 3; i < 12 * 3; ++i)
+			fputc(' ', text_out);
+		fprintf(text_out, "%s%s%s\n", label, colon, buf);
+		pc += cnt;
+	}
+
+out:
+	if (triple)
+		LLVMDisposeMessage(triple);
+	if (ctx)
+		LLVMDisasmDispose(ctx);
+	return err;
+}
+
+int get_jited_program_text(int fd, char *text, size_t text_sz)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	__u32 jited_funcs, len, pc;
+	__u32 *func_lens = NULL;
+	FILE *text_out = NULL;
+	uint8_t *image = NULL;
+	int i, err = 0;
+
+	if (!llvm_initialized) {
+		LLVMInitializeAllTargetInfos();
+		LLVMInitializeAllTargetMCs();
+		LLVMInitializeAllDisassemblers();
+		llvm_initialized = 1;
+	}
+
+	text_out = fmemopen(text, text_sz, "w");
+	if (!ASSERT_OK_PTR(text_out, "open_memstream")) {
+		err = -errno;
+		goto out;
+	}
+
+	/* first call is to find out jited program len */
+	err = bpf_prog_get_info_by_fd(fd, &info, &info_len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #1"))
+		goto out;
+
+	len = info.jited_prog_len;
+	image = malloc(len);
+	if (!ASSERT_OK_PTR(image, "malloc(info.jited_prog_len)")) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	jited_funcs = info.nr_jited_func_lens;
+	func_lens = malloc(jited_funcs * sizeof(__u32));
+	if (!ASSERT_OK_PTR(func_lens, "malloc(info.nr_jited_func_lens)")) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	memset(&info, 0, sizeof(info));
+	info.jited_prog_insns = (__u64)image;
+	info.jited_prog_len = len;
+	info.jited_func_lens = (__u64)func_lens;
+	info.nr_jited_func_lens = jited_funcs;
+	err = bpf_prog_get_info_by_fd(fd, &info, &info_len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
+		goto out;
+
+	for (pc = 0, i = 0; i < jited_funcs; ++i) {
+		fprintf(text_out, "func #%d:\n", i);
+		disasm_one_func(text_out, image + pc, func_lens[i]);
+		fprintf(text_out, "\n");
+		pc += func_lens[i];
+	}
+
+out:
+	if (text_out)
+		fclose(text_out);
+	if (image)
+		free(image);
+	if (func_lens)
+		free(func_lens);
+	return err;
+}
+
+#else /* HAVE_LLVM_SUPPORT */
+
+int get_jited_program_text(int fd, char *text, size_t text_sz)
+{
+	if (env.verbosity >= VERBOSE_VERY)
+		printf("compiled w/o llvm development libraries, can't dis-assembly binary code");
+	return -ENOTSUP;
+}
+
+#endif /* HAVE_LLVM_SUPPORT */
diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.h b/tools/testing/selftests/bpf/jit_disasm_helpers.h
new file mode 100644
index 000000000000..e6924fd65ecf
--- /dev/null
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+
+#ifndef __JIT_DISASM_HELPERS_H
+#define __JIT_DISASM_HELPERS_H
+
+#include <stddef.h>
+
+int get_jited_program_text(int fd, char *text, size_t text_sz);
+
+#endif /* __JIT_DISASM_HELPERS_H */
-- 
2.45.2


