Return-Path: <bpf+bounces-37290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E996953ADB
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EFE1C22008
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 19:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC2F770F5;
	Thu, 15 Aug 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TSbgWZDk"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55E157CA7
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750040; cv=none; b=Mp2WJexYWVITOeRWBJ5oL6Etu1Daywx94B8B2E1af03SPXGTyWz1q5mOdHK/xZkvwbQhnEvSZaDDjQreNCJTjbNX+DM4nL7gV9lKUfG+7fDrKr6hm+0E/qJyITk9S7rIVpTrNlZiMrjDsFLeObO3fHX2Cunf/Bwm5vyni1qA3Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750040; c=relaxed/simple;
	bh=s9k6uu2qqkxEbHghq9vAyUxjg24b9jfFRh9gq6xSiGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjQB8CkkcrEVg9ho2nmaW3yMvFIVJ2LY/dZLDX0O5vaY8e9EjcuOBx08715XbOTO9nkrlTLvn3IK2hB2ZIp4v+/SPudBPFNPIl2mN3QLchwthQxpJ4CoHQ7FeyUpVSBOnevRHFMhkIOoXC9rWRBoOmJZE80zW8+d8dp64ICfAn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TSbgWZDk; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <de45cb69-8116-4589-a0ba-9e77ba1c3e60@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723750034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOQ8UYbEWYbF3aW2OeQrJisvh17AZVT5oW+pJkO727E=;
	b=TSbgWZDk133VZfKSPDum4zq7UlO/bDrt3UBPWtq0c6EPpiX1H3O0cbH9BDI0egTbSvkLta
	Em+ZsckgXJc6R4z2QWXmZg3QvI8R5QMEamt/ARc97B0Z9uZ9mBdQ66ZHBZXUCPfeg24cLE
	D7M/A8mJqD71CtUiyqs2hml95keUoyM=
Date: Thu, 15 Aug 2024 12:27:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: utility function to get
 program disassembly after jit
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, hffilwlqm@gmail.com
References: <20240809010518.1137758-1-eddyz87@gmail.com>
 <20240809010518.1137758-3-eddyz87@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240809010518.1137758-3-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/8/24 6:05 PM, Eduard Zingerman wrote:
>      int get_jited_program_text(int fd, char *text, size_t text_sz)
>
You need to give some context before the above function signature.

> Loads and disassembles jited instructions for program pointed to by fd.
> Much like 'bpftool prog dump jited ...'.
>
> The code and makefile changes are inspired by jit_disasm.c from bpftool.
> Use llvm libraries to disassemble BPF program instead of libbfd to avoid
> issues with disassembly output stability pointed out in [1].
>
> Selftests makefile uses Makefile.feature to detect if LLVM libraries
> are available. If that is not the case selftests build proceeds but
> the function returns -ENOTSUP at runtime.
>
> [1] commit eb9d1acf634b ("bpftool: Add LLVM as default library for disassembling JIT-ed programs")
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

LGTM except a few nits below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/testing/selftests/bpf/.gitignore        |   1 +
>   tools/testing/selftests/bpf/Makefile          |  51 +++-
>   .../selftests/bpf/jit_disasm_helpers.c        | 228 ++++++++++++++++++
>   .../selftests/bpf/jit_disasm_helpers.h        |  10 +
>   4 files changed, 288 insertions(+), 2 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.c
>   create mode 100644 tools/testing/selftests/bpf/jit_disasm_helpers.h
>
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 8f14d8faeb0b..7de4108771a0 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -8,6 +8,7 @@ test_lru_map
>   test_lpm_map
>   test_tag
>   FEATURE-DUMP.libbpf
> +FEATURE-DUMP.selftests
>   fixdep
>   /test_progs
>   /test_progs-no_alu32
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index f54185e96a95..b1a52739d9e7 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -33,6 +33,13 @@ OPT_FLAGS	?= $(if $(RELEASE),-O2,-O0)
>   LIBELF_CFLAGS	:= $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
>   LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>   
> +ifeq ($(srctree),)
> +srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +endif
> +
>   CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
>   	  -Wall -Werror -fno-omit-frame-pointer				\
>   	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
> @@ -55,6 +62,11 @@ progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
>   progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
>   progs/test_global_func9.c-CFLAGS := -fno-strict-aliasing
>   
> +# Some utility functions use LLVM libraries
> +jit_disasm_helpers.c-CFLAGS = $(LLVM_CFLAGS)
> +test_progs-LDLIBS = $(LLVM_LDLIBS)
> +test_progs-LDFLAGS = $(LLVM_LDFLAGS)
> +
>   ifneq ($(LLVM),)
>   # Silence some warnings when compiled with clang
>   CFLAGS += -Wno-unused-command-line-argument
> @@ -164,6 +176,31 @@ endef
>   
>   include ../lib.mk
>   
> +NON_CHECK_FEAT_TARGETS := clean docs-clean
> +CHECK_FEAT := $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDGOALS), "none"))
> +ifneq ($(CHECK_FEAT),)
> +FEATURE_USER := .selftests
> +FEATURE_TESTS := llvm
> +FEATURE_DISPLAY := $(FEATURE_TESTS)
> +
> +# Makefile.feature expects OUTPUT to end with a slash
> +$(let OUTPUT,$(OUTPUT)/,\
> +	$(eval include ../../../build/Makefile.feature))
> +endif
> +
> +ifeq ($(feature-llvm),1)
> +  LLVM_CFLAGS  += -DHAVE_LLVM_SUPPORT
> +  LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
> +  # both llvm-config and lib.mk add -D_GNU_SOURCE, which ends up as conflict
> +  LLVM_CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
> +  LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
> +  ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
> +    LLVM_LDLIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
> +    LLVM_LDLIBS += -lstdc++
> +  endif
> +  LLVM_LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
> +endif
> +
>   SCRATCH_DIR := $(OUTPUT)/tools
>   BUILD_DIR := $(SCRATCH_DIR)/build
>   INCLUDE_DIR := $(SCRATCH_DIR)/include
> @@ -488,6 +525,7 @@ define DEFINE_TEST_RUNNER
>   
>   TRUNNER_OUTPUT := $(OUTPUT)$(if $2,/)$2
>   TRUNNER_BINARY := $1$(if $2,-)$2
> +TRUNNER_BASE_NAME := $1
>   TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
>   				 $$(notdir $$(wildcard $(TRUNNER_TESTS_DIR)/*.c)))
>   TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
> @@ -611,6 +649,10 @@ ifeq ($(filter clean docs-clean,$(MAKECMDGOALS)),)
>   include $(wildcard $(TRUNNER_TEST_OBJS:.o=.d))
>   endif
>   
> +# add per extra obj CFGLAGS definitions
> +$(foreach N,$(patsubst $(TRUNNER_OUTPUT)/%.o,%,$(TRUNNER_EXTRA_OBJS)),	\
> +	$(eval $(TRUNNER_OUTPUT)/$(N).o: CFLAGS += $($(N).c-CFLAGS)))
> +
>   $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
>   		       %.c						\
>   		       $(TRUNNER_EXTRA_HDRS)				\
> @@ -627,6 +669,9 @@ ifneq ($2:$(OUTPUT),:$(shell pwd))
>   	$(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
>   endif
>   
> +$(OUTPUT)/$(TRUNNER_BINARY): LDLIBS += $$($(TRUNNER_BASE_NAME)-LDLIBS)
> +$(OUTPUT)/$(TRUNNER_BINARY): LDFLAGS += $$($(TRUNNER_BASE_NAME)-LDFLAGS)
> +
>   # some X.test.o files have runtime dependencies on Y.bpf.o files
>   $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
>   
> @@ -636,7 +681,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
>   			     $(TRUNNER_BPFTOOL)				\
>   			     | $(TRUNNER_BINARY)-extras
>   	$$(call msg,BINARY,,$$@)
> -	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> +	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) $$(LDFLAGS) -o $$@
>   	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
>   	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
>   		   $(OUTPUT)/$(if $2,$2/)bpftool
> @@ -655,6 +700,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
>   			 cap_helpers.c		\
>   			 unpriv_helpers.c 	\
>   			 netlink_helpers.c	\
> +			 jit_disasm_helpers.c	\
>   			 test_loader.c		\
>   			 xsk.c			\
>   			 disasm.c		\
> @@ -797,7 +843,8 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
>   	$(addprefix $(OUTPUT)/,*.o *.d *.skel.h *.lskel.h *.subskel.h	\
>   			       no_alu32 cpuv4 bpf_gcc bpf_testmod.ko	\
>   			       bpf_test_no_cfi.ko			\
> -			       liburandom_read.so)
> +			       liburandom_read.so)			\
> +	$(OUTPUT)/FEATURE-DUMP.selftests
>   
>   .PHONY: docs docs-clean
>   
> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> new file mode 100644
> index 000000000000..ae704f7c5ee7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +#include <bpf/bpf.h>
> +#include <bpf/libbpf.h>
> +#include <test_progs.h>
> +
> +#ifdef HAVE_LLVM_SUPPORT
> +
> +#include <llvm-c/Core.h>
> +#include <llvm-c/Disassembler.h>
> +#include <llvm-c/Target.h>
> +#include <llvm-c/TargetMachine.h>
> +
> +#define MAX_LOCAL_LABELS 32

Some bpf progs, e.g., pyperf600.bpf.o has thousands of lables.
But since this file is for selftest and we expect the test
case will be simpler, so the above number '32' should be okay.
But it would be good to add a comment for this.

> +
> +static bool llvm_initialized;
> +
> +struct local_labels {
> +	bool print_phase;
> +	__u32 prog_len;
> +	__u32 cnt;
> +	__u32 pcs[MAX_LOCAL_LABELS];
> +	char names[MAX_LOCAL_LABELS][4];
> +};
> +
> +/* Depending on labels->print_phase:
> + * - if false: record save jump labels within the program in labels->pcs;
> + * - if true: if ref_value is in labels->pcs, return corresponding labels->name
> + */
> +static const char *lookup_symbol(void *data, uint64_t ref_value, uint64_t *ref_type,
> +				 uint64_t ref_pc, const char **ref_name)
> +{
> +	struct local_labels *labels = data;
> +	uint64_t type = *ref_type;
> +	int i;
> +
> +	*ref_type = LLVMDisassembler_ReferenceType_InOut_None;
> +	*ref_name = NULL;
> +	if (type != LLVMDisassembler_ReferenceType_In_Branch)
> +		return NULL;
> +	for (i = 0; i < labels->cnt; ++i)
> +		if (labels->pcs[i] == ref_value)
> +			return labels->names[i];
> +	if (!labels->print_phase && labels->cnt < MAX_LOCAL_LABELS &&
> +	    ref_value < labels->prog_len)
> +		labels->pcs[labels->cnt++] = ref_value;

Maybe the following easy to understand?

	if (labels->print_phase) {
		for (i = 0; i < labels->cnt; ++i)
			if (labels->pcs[i] == ref_value)
				return labels->names[i];

	} else {
		if (labels->cnt < MAX_LOCAL_LABELS && ref_value < labels->prog_len)
			labels->pcs[labels->cnt++] = ref_value;
	}

> +	return NULL;
> +}
> +
> +static int disasm_insn(LLVMDisasmContextRef ctx, uint8_t *image, __u32 len, __u32 pc,
> +		       char *buf, __u32 buf_sz)
> +{
> +	int i, cnt;
> +
> +	cnt = LLVMDisasmInstruction(ctx, image + pc, len - pc, pc,
> +				    buf, buf_sz);
> +	if (cnt > 0)
> +		return cnt;
> +	PRINT_FAIL("Can't disasm instruction at offset %d:", pc);
> +	for (i = 0; i < 16 && pc + i < len; ++i)
> +		printf(" %02x", image[pc + i]);
> +	printf("\n");
> +	return -EINVAL;
> +}
> +
> +static int cmp_u32(const void *_a, const void *_b)
> +{
> +	__u32 a = *(__u32 *)_a;
> +	__u32 b = *(__u32 *)_b;
> +
> +	if (a < b)
> +		return -1;
> +	if (a > b)
> +		return 1;
> +	return 0;
> +}
> +
> +static int disasm_one_func(FILE *text_out, uint8_t *image, __u32 len)
> +{
> +	char *label, *colon, *triple = NULL;
> +	LLVMDisasmContextRef ctx = NULL;
> +	struct local_labels labels = {};
> +	__u32 *label_pc, pc;
> +	int i, cnt, err = 0;
> +	char buf[256];

buf[16]?

> +
> +	triple = LLVMGetDefaultTargetTriple();
> +	ctx = LLVMCreateDisasm(triple, &labels, 0, NULL, lookup_symbol);
> +	if (!ASSERT_OK_PTR(ctx, "LLVMCreateDisasm")) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	cnt = LLVMSetDisasmOptions(ctx, LLVMDisassembler_Option_PrintImmHex);
> +	if (!ASSERT_EQ(cnt, 1, "LLVMSetDisasmOptions")) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* discover labels */
> +	labels.prog_len = len;
> +	pc = 0;
> +	while (pc < len) {
> +		cnt = disasm_insn(ctx, image, len, pc, buf, 1);
> +		if (cnt < 0) {
> +			err = cnt;
> +			goto out;
> +		}
> +		pc += cnt;
> +	}
> +	qsort(labels.pcs, labels.cnt, sizeof(*labels.pcs), cmp_u32);

[...]


