Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1483B5B511B
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 22:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIKUPX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 16:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIKUPU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 16:15:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B231B7B3
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:15:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id cc5so2469247wrb.6
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sdeh3UJa4UHuyyibCnhct+Nz4AM+vpV8iV5JJ+Tg1CQ=;
        b=lJS0gzQ+pG5IsqsT+55XUqH9e3KBs0PVFHrSKdDfWtW5pX0qhgtKfEe49smF/2H9tW
         c1MYCZzj/iC4upiAmkd9PukxMJqnXSVnOvI/D+CxVpktcYOD37nzyfhbfuwQOGJtQ6Jv
         5jJ56Y2v7eQ4L28YGHt+zL1yXUQqyjuAcRqUPTfClktJJU/MeX6Qin6Wq2JIAHpiGa0H
         UFhjMakVDcrc4wrjXB95HtKbvlwqooIz5aREu6rz+vrcmrCfldClkXprRsTYq74iqqY8
         /XeL4i+YEQe3Dniuru/xwpjRQshI1EYYKcwavvjtZM5xJiR7ybRob93OuZrEzPtlkL/X
         Klvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sdeh3UJa4UHuyyibCnhct+Nz4AM+vpV8iV5JJ+Tg1CQ=;
        b=chSXcJfjBuzyshslAsfhmcZp9TvrEgbUClTOsF3vbRd7U9vSgDwdUZKAqBB5rwKPx+
         1dSR5wbmO8oVSN6bA1KW0F1wpAtburHP4O+hreF7hmUPq8giYaLnYXHkscjUAlFmZ1SC
         YI/5VLTh6tVH/Mp96Qkb1HKJ326L4JqJW9Xw1mrlxUc+pG67ZzTMchLSv0FnZQh9v52t
         roB5t8I3To9VsrkU7kJbPKmureEETvesRc/IwEf+0R/3SAHWrz68vFUAyH4PhwFYg/vO
         WDOC4AEzbkIET2RlTOc5mW6YA/IbvOGbMoGEg1M+seY8R/i/J5dsICrRT2A83LJjU9m6
         2wpQ==
X-Gm-Message-State: ACgBeo1f3O+lYTMGZidxN632INdBcTmqtwy/VG8BySA98++C+AKqpiZj
        oeUe1z88hHkxQttP/dLyYGo12w==
X-Google-Smtp-Source: AA6agR7g3FWSDDSAIia0HVdX7X4NnljZF/9i+ofBiXAQoZCOldzPJHkIXzp0yNeCU00wUqQRTwXoTg==
X-Received: by 2002:a5d:65c2:0:b0:228:68b7:e7b2 with SMTP id e2-20020a5d65c2000000b0022868b7e7b2mr13129055wrw.440.1662927316801;
        Sun, 11 Sep 2022 13:15:16 -0700 (PDT)
Received: from harfang.access.network ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id bh16-20020a05600c3d1000b003a60ff7c082sm7603789wmb.15.2022.09.11.13.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 13:15:14 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 6/8] bpftool: Add LLVM as default library for disassembling JIT-ed programs
Date:   Sun, 11 Sep 2022 21:14:49 +0100
Message-Id: <20220911201451.12368-7-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911201451.12368-1-quentin@isovalent.com>
References: <20220911201451.12368-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To disassemble instructions for JIT-ed programs, bpftool has relied on
the libbfd library. This has been problematic in the past: libbfd's
interface is not meant to be stable and has changed several times. For
building bpftool, we have to detect how the libbfd version on the system
behaves, which is why we have to handle features disassembler-four-args
and disassembler-init-styled in the Makefile. When it comes to shipping
bpftool, this has also caused issues with several distribution
maintainers unwilling to support the feature (see for example Debian's
page for binutils-dev, which ships libbfd: "Note that building Debian
packages which depend on the shared libbfd is Not Allowed." [0]).

For these reasons, we add support for LLVM as an alternative to libbfd
for disassembling instructions of JIT-ed programs. Thanks to the
preparation work in the previous commits, it's easy to add the library
by passing the relevant compilation options in the Makefile, and by
adding the functions for setting up the LLVM disassembler in file
jit_disasm.c.

Naturally, the display of disassembled instructions comes with a few
minor differences. Here is a sample output with libbfd (already
supported before this patch):

    # bpftool prog dump jited id 56
    bpf_prog_6deef7357e7b4530:
       0:   nopl   0x0(%rax,%rax,1)
       5:   xchg   %ax,%ax
       7:   push   %rbp
       8:   mov    %rsp,%rbp
       b:   push   %rbx
       c:   push   %r13
       e:   push   %r14
      10:   mov    %rdi,%rbx
      13:   movzwq 0xb4(%rbx),%r13
      1b:   xor    %r14d,%r14d
      1e:   or     $0x2,%r14d
      22:   mov    $0x1,%eax
      27:   cmp    $0x2,%r14
      2b:   jne    0x000000000000002f
      2d:   xor    %eax,%eax
      2f:   pop    %r14
      31:   pop    %r13
      33:   pop    %rbx
      34:   leave
      35:   ret

LLVM supports several variants that we could set when initialising the
disassembler, for example with:

    LLVMSetDisasmOptions(*ctx,
                         LLVMDisassembler_Option_AsmPrinterVariant);

but the default printer is used for now. Here is the output with LLVM:

    # bpftool prog dump jited id 56
    bpf_prog_6deef7357e7b4530:
       0:   nopl    (%rax,%rax)
       5:   nop
       7:   pushq   %rbp
       8:   movq    %rsp, %rbp
       b:   pushq   %rbx
       c:   pushq   %r13
       e:   pushq   %r14
      10:   movq    %rdi, %rbx
      13:   movzwq  180(%rbx), %r13
      1b:   xorl    %r14d, %r14d
      1e:   orl     $2, %r14d
      22:   movl    $1, %eax
      27:   cmpq    $2, %r14
      2b:   jne     0x2f
      2d:   xorl    %eax, %eax
      2f:   popq    %r14
      31:   popq    %r13
      33:   popq    %rbx
      34:   leave
      35:   retq

The LLVM disassembler comes as the default choice, with libbfd as a
fall-back.

Of course, we could replace libbfd entirely and avoid supporting two
different libraries. One reason for keeping libbfd is that, right now,
it works well, we have all we need in terms of features detection in the
Makefile, so it provides a fallback for disassembling JIT-ed programs if
libbfd is installed but LLVM is not. The other motivation is that libbfd
supports nfp instruction for Netronome's SmartNICs and can be used to
disassemble offloaded programs, something that LLVM cannot do. If
libbfd's interface breaks again in the future, we might reconsider
keeping support for it.

[0] https://packages.debian.org/buster/binutils-dev

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>
---
 tools/bpf/bpftool/Makefile     |  46 +++++++++-----
 tools/bpf/bpftool/jit_disasm.c | 112 ++++++++++++++++++++++++++++++++-
 tools/bpf/bpftool/main.h       |   4 +-
 3 files changed, 140 insertions(+), 22 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 1c81f4d514bb..787b857d3fb5 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -95,6 +95,7 @@ RM ?= rm -f
 FEATURE_USER = .bpftool
 
 FEATURE_TESTS := clang-bpf-co-re
+FEATURE_TESTS += llvm
 FEATURE_TESTS += libcap
 FEATURE_TESTS += libbfd
 FEATURE_TESTS += libbfd-liberty
@@ -103,6 +104,7 @@ FEATURE_TESTS += disassembler-four-args
 FEATURE_TESTS += disassembler-init-styled
 
 FEATURE_DISPLAY := clang-bpf-co-re
+FEATURE_DISPLAY += llvm
 FEATURE_DISPLAY += libcap
 FEATURE_DISPLAY += libbfd
 FEATURE_DISPLAY += libbfd-liberty
@@ -137,27 +139,37 @@ all: $(OUTPUT)bpftool
 
 SRCS := $(wildcard *.c)
 
-ifeq ($(feature-libbfd),1)
-  LIBS += -lbfd -ldl -lopcodes
-else ifeq ($(feature-libbfd-liberty),1)
-  LIBS += -lbfd -ldl -lopcodes -liberty
-else ifeq ($(feature-libbfd-liberty-z),1)
-  LIBS += -lbfd -ldl -lopcodes -liberty -lz
-endif
+ifeq ($(feature-llvm),1)
+  # If LLVM is available, use it for JIT disassembly
+  CFLAGS  += -DHAVE_LLVM_SUPPORT
+  LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
+  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags --libs $(LLVM_CONFIG_LIB_COMPONENTS))
+  LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
+  LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
+else
+  # Fall back on libbfd
+  ifeq ($(feature-libbfd),1)
+    LIBS += -lbfd -ldl -lopcodes
+  else ifeq ($(feature-libbfd-liberty),1)
+    LIBS += -lbfd -ldl -lopcodes -liberty
+  else ifeq ($(feature-libbfd-liberty-z),1)
+    LIBS += -lbfd -ldl -lopcodes -liberty -lz
+  endif
 
-# If one of the above feature combinations is set, we support libbfd
-ifneq ($(filter -lbfd,$(LIBS)),)
-  CFLAGS += -DHAVE_LIBBFD_SUPPORT
+  # If one of the above feature combinations is set, we support libbfd
+  ifneq ($(filter -lbfd,$(LIBS)),)
+    CFLAGS += -DHAVE_LIBBFD_SUPPORT
 
-  # Libbfd interface changed over time, figure out what we need
-  ifeq ($(feature-disassembler-four-args), 1)
-    CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
-  endif
-  ifeq ($(feature-disassembler-init-styled), 1)
-    CFLAGS += -DDISASM_INIT_STYLED
+    # Libbfd interface changed over time, figure out what we need
+    ifeq ($(feature-disassembler-four-args), 1)
+      CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
+    endif
+    ifeq ($(feature-disassembler-init-styled), 1)
+      CFLAGS += -DDISASM_INIT_STYLED
+    endif
   endif
 endif
-ifeq ($(filter -DHAVE_LIBBFD_SUPPORT,$(CFLAGS)),)
+ifeq ($(filter -DHAVE_LLVM_SUPPORT -DHAVE_LIBBFD_SUPPORT,$(CFLAGS)),)
   # No support for JIT disassembly
   SRCS := $(filter-out jit_disasm.c,$(SRCS))
 endif
diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index e31ad3950fd6..c28b21f90cb9 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -20,18 +20,123 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
-#include <bfd.h>
-#include <dis-asm.h>
 #include <sys/stat.h>
 #include <limits.h>
 #include <bpf/libbpf.h>
+
+#ifdef HAVE_LLVM_SUPPORT
+#include <llvm-c/Core.h>
+#include <llvm-c/Disassembler.h>
+#include <llvm-c/Target.h>
+#include <llvm-c/TargetMachine.h>
+#endif
+
+#ifdef HAVE_LIBBFD_SUPPORT
+#include <bfd.h>
+#include <dis-asm.h>
 #include <tools/dis-asm-compat.h>
+#endif
 
 #include "json_writer.h"
 #include "main.h"
 
 static int oper_count;
 
+#ifdef HAVE_LLVM_SUPPORT
+#define DISASM_SPACER
+
+typedef LLVMDisasmContextRef disasm_ctx_t;
+
+static int printf_json(char *s)
+{
+	s = strtok(s, " \t");
+	jsonw_string_field(json_wtr, "operation", s);
+
+	jsonw_name(json_wtr, "operands");
+	jsonw_start_array(json_wtr);
+	oper_count = 1;
+
+	while ((s = strtok(NULL, " \t,()")) != 0) {
+		jsonw_string(json_wtr, s);
+		oper_count++;
+	}
+	return 0;
+}
+
+/* This callback to set the ref_type is necessary to have the LLVM disassembler
+ * print PC-relative addresses instead of byte offsets for branch instruction
+ * targets.
+ */
+static const char *
+symbol_lookup_callback(__maybe_unused void *disasm_info,
+		       __maybe_unused uint64_t ref_value,
+		       uint64_t *ref_type, __maybe_unused uint64_t ref_PC,
+		       __maybe_unused const char **ref_name)
+{
+	*ref_type = LLVMDisassembler_ReferenceType_InOut_None;
+	return NULL;
+}
+
+static int
+init_context(disasm_ctx_t *ctx, const char *arch,
+	     __maybe_unused const char *disassembler_options,
+	     __maybe_unused unsigned char *image, __maybe_unused ssize_t len)
+{
+	char *triple;
+
+	if (arch) {
+		p_err("Architecture %s not supported", arch);
+		return -1;
+	}
+
+	triple = LLVMGetDefaultTargetTriple();
+	if (!triple) {
+		p_err("Failed to retrieve triple");
+		return -1;
+	}
+	*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callback);
+	LLVMDisposeMessage(triple);
+
+	if (!*ctx) {
+		p_err("Failed to create disassembler");
+		return -1;
+	}
+
+	return 0;
+}
+
+static void destroy_context(disasm_ctx_t *ctx)
+{
+	LLVMDisposeMessage(*ctx);
+}
+
+static int
+disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc)
+{
+	char buf[256];
+	int count;
+
+	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
+				      buf, sizeof(buf));
+	if (json_output)
+		printf_json(buf);
+	else
+		printf("%s", buf);
+
+	return count;
+}
+
+int disasm_init(void)
+{
+	LLVMInitializeNativeTarget();
+	LLVMInitializeNativeDisassembler();
+	return 0;
+}
+#endif /* HAVE_LLVM_SUPPORT */
+
+#ifdef HAVE_LIBBFD_SUPPORT
+#define DISASM_SPACER "\t"
+
 typedef struct {
 	struct disassemble_info *info;
 	disassembler_ftype disassemble;
@@ -210,6 +315,7 @@ int disasm_init(void)
 	bfd_init();
 	return 0;
 }
+#endif /* HAVE_LIBBPFD_SUPPORT */
 
 int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 		      const char *arch, const char *disassembler_options,
@@ -252,7 +358,7 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 			if (linfo)
 				btf_dump_linfo_plain(btf, linfo, "; ",
 						     linum);
-			printf("%4x:\t", pc);
+			printf("%4x:" DISASM_SPACER, pc);
 		}
 
 		count = disassemble_insn(&ctx, image, len, pc);
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index c9e171082cf6..9a149c67aa5d 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -172,7 +172,7 @@ int map_parse_fds(int *argc, char ***argv, int **fds);
 int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len);
 
 struct bpf_prog_linfo;
-#ifdef HAVE_LIBBFD_SUPPORT
+#if defined(HAVE_LLVM_SUPPORT) || defined(HAVE_LIBBFD_SUPPORT)
 int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 		      const char *arch, const char *disassembler_options,
 		      const struct btf *btf,
@@ -193,7 +193,7 @@ int disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 }
 static inline int disasm_init(void)
 {
-	p_err("No libbfd support");
+	p_err("No JIT disassembly support");
 	return -1;
 }
 #endif
-- 
2.34.1

