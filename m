Return-Path: <bpf+bounces-36747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3214094C7E0
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 03:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15BE1F230B8
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 01:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486408F54;
	Fri,  9 Aug 2024 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjeAlotp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B0610D
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723165553; cv=none; b=fzrac6COHOlIMhUIben/5tpLFS3wNhiBNgxts6JlJWci7SXtIQUWkv0dL55p4wmOxror61pZ0Ml0OjEt3stPm0FT/yETjJFHmpr5tNIkxVSVkUnUv3Tq9vxMcG57ye6B19VbQOsg/sSdTeuK1rKAbf98sg0hkCffY8WN6qaJrTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723165553; c=relaxed/simple;
	bh=A/IA1JQh8E45UjTZjphXKnFwRTLco16XSncHwbsMkL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QljMQTq50jxIoGwaAsR40HwVLeoYAIRSHYTzsz3KS9ujuFICEXw+GBYXYaGfzLFGvuHPoU7i7JYqMzd+hLpp0JHYv2rNPEkmv8AJRSZ/h+Pne63CF/q9TDtVdxhFIy8NNpeJn5o2tJbiyLDi+D/2toAD4epaKYbgeEoU6aoHvAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjeAlotp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d19d768c2so1211466b3a.3
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 18:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723165551; x=1723770351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch7ouf20XeJ8u9bqhHVlf0crJoXiw/m1uq580t8N+Ck=;
        b=KjeAlotpumjVsUaa8n0J1iwf4mdtLGtr4aJQODkk2Jia1KB0j6PO4HBJyNNguTtCWz
         tz8pKldusX1zOa2S4S9JolZLHcx0llxXwuQACCcCxDNBfKJ52n+JjNP2Y83FEEBS4Cmx
         8+HexQcjrGjrtSd4buUPrE23XWmASaMMyH6HNvx9iPCPZKGmJ14DL+0QAFTsHMcT0XL5
         apgLkoeN2NdCXNepWrdbTBlh87HAygkULvn6q1YNL3QnSKxSyo0jY2aT61c5aL27ktFq
         aw4GMURPO/M8cpyHa5H/cCDolUmnl2FwEZGROEQXrhkbkqrRva5GgaRW8a+wQnnnAqo2
         xcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723165551; x=1723770351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ch7ouf20XeJ8u9bqhHVlf0crJoXiw/m1uq580t8N+Ck=;
        b=io2uiXaj8d8Thnz9tfYjF96bGbqGEpVMF87M9s/LMW60L5h8Fh8wyOQraHx1JSk/81
         xmKhXfRUn6PoWR1NBJYz7gDZr5wBWossdHt0tm9bPXwW/qA1DvEegMc/eT/BMJi5LfW+
         LOmN5ni97oco50WzCzS2I3+a7hdm9veJuHfcwq4UXlWik9j/yt1l19KFVxJXryN3qJBp
         XELBC4CIGdg7TSjDcBuihiub548qo+Inr9+YXBYoq+L12kviJF3R/lbMMlWMvKBRCLrq
         WEX3CvQNkdyrihrBJ/CfAo2AieLNGSVogZaOS16s/Gu0Z+ovwGsiJ8OmvHgnFCckREKg
         9jmg==
X-Gm-Message-State: AOJu0YxmeAQf+8n6Bg337GPW2Of2a3hhJJmdpPT/w+v6LEAzLb+RGNkd
	8ne/I+FTg6cRsrrC5MNO9Hm0a/QVafJBJ1teaWRx5k4P7IvoRHUofacVpHsFwLY=
X-Google-Smtp-Source: AGHT+IEG8HP+J/Qjb+/EEVL5aX4FZOSGHDwLS/f3W6gb3FULUXweQx/xkVqZ0uSMxCcvm+DLOMcHaQ==
X-Received: by 2002:a05:6a00:114b:b0:70d:21b4:46ca with SMTP id d2e1a72fcca58-710cad774bbmr4622576b3a.11.1723165550823;
        Thu, 08 Aug 2024 18:05:50 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2fc0d8sm1678626b3a.205.2024.08.08.18.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 18:05:50 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/4] selftests/bpf: utility function to get program disassembly after jit
Date: Thu,  8 Aug 2024 18:05:16 -0700
Message-ID: <20240809010518.1137758-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240809010518.1137758-1-eddyz87@gmail.com>
References: <20240809010518.1137758-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    int get_jited_program_text(int fd, char *text, size_t text_sz)

Loads and disassembles jited instructions for program pointed to by fd.
Much like 'bpftool prog dump jited ...'.

The code and makefile changes are inspired by jit_disasm.c from bpftool.
Use llvm libraries to disassemble BPF program instead of libbfd to avoid
issues with disassembly output stability pointed out in [1].

Selftests makefile uses Makefile.feature to detect if LLVM libraries
are available. If that is not the case selftests build proceeds but
the function returns -ENOTSUP at runtime.

[1] commit eb9d1acf634b ("bpftool: Add LLVM as default library for disassembling JIT-ed programs")

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |  51 +++-
 .../selftests/bpf/jit_disasm_helpers.c        | 228 ++++++++++++++++++
 .../selftests/bpf/jit_disasm_helpers.h        |  10 +
 4 files changed, 288 insertions(+), 2 deletions(-)
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
index 000000000000..ae704f7c5ee7
--- /dev/null
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -0,0 +1,228 @@
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
+/* Depending on labels->print_phase:
+ * - if false: record save jump labels within the program in labels->pcs;
+ * - if true: if ref_value is in labels->pcs, return corresponding labels->name.
+ */
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
+	for (i = 0; i < labels->cnt; ++i)
+		if (labels->pcs[i] == ref_value)
+			return labels->names[i];
+	if (!labels->print_phase && labels->cnt < MAX_LOCAL_LABELS &&
+	    ref_value < labels->prog_len)
+		labels->pcs[labels->cnt++] = ref_value;
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
+	char buf[256];
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
+	/* GCC can't figure max bound for i and thus reports possible truncation */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wformat-truncation"
+	for (i = 0; i < labels.cnt; ++i)
+		snprintf(labels.names[i], sizeof(labels.names[i]), "L%d", i);
+#pragma GCC diagnostic pop
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


