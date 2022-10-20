Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB8660605E
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 14:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJTMh3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 08:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiJTMh2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 08:37:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A1946609
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j7so34205553wrr.3
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 05:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQ5G+LqCu4UgAdrOZLgN0oH7PzZxkUftVl9Lp5qe/AY=;
        b=oibsX0NEt50naCOeWeMiCic3/GlE56yp+BA0lgcpYMXtocwhtI+OxJvplo85FddpZ8
         x99XgMK9hTAS+VfkItPnKSmL5WlMikaelN6XImAqJVMgDn02G0CnXXQX9qeu9LFniHQg
         GJDC0NlJJWXedTP2Utlmhbv0UGb390QlxphU7AKHV78boRHoPxFiobNa0OB5o5FeelK8
         SSou9a8ydURQagzl26Ko76tJ2xR7Tf7FHYdXbtri3EKRVEjL0HrJ2w0aA6w9cBRW7oug
         6pCGcf2JQ2ajWUzcxhNpCj75opNKcDhhFHsNE1VYxSHE0TBYvRaOfTC4StwYBx4vyYg6
         LCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQ5G+LqCu4UgAdrOZLgN0oH7PzZxkUftVl9Lp5qe/AY=;
        b=tUCDjo+/zyOpfzg4W7pWXJKtbhsl1ptAktKteuJejrwsE5mu25BZX72czCpWW11Ddt
         9frAe/n+Gr2KY2VtWayhSomSgSKcPE7XKL2HJrvAeQRd3KLfF71CxLXkjakfIHp5Mn7G
         3cY1DtbPHuOm/Kf9kiv5UNG19jbIWWI92HBIU8EpZGOpHNcrD0RsmmE2h97G/AQpPHW1
         pI3RWabMGpuTAy7jWzEWC+63ui0R7xnnvwGqni/hXVoMbOMT6+YK7LxvHhLw0ZBmQVqF
         LqoOtMdSPxPGI3mhtOckbVm7nagy5BmwZAq9m2xAtSJQQt+U1Kp4VMgqUSK5pcl9GsIy
         nruQ==
X-Gm-Message-State: ACrzQf2HSUDRzIpNMCrNFeTyWdxCLSeVAn/TdM4xlh7fH2XowzqUfwtr
        Y4qPJ0/9mhafX/P3sGuaux1mRg==
X-Google-Smtp-Source: AMsMyM7RsmCIHN6Pk8dWhd4enI8qUszktKMdNYI1QIJ5PSZhngHvGIRGggE7BvR5ouTIWR8rYScohw==
X-Received: by 2002:adf:ce90:0:b0:236:4cd6:6a4c with SMTP id r16-20020adfce90000000b002364cd66a4cmr283647wrn.348.1666269444269;
        Thu, 20 Oct 2022 05:37:24 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a9246c853sm16329581wrt.41.2022.10.20.05.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:37:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 6/8] bpftool: Add LLVM as default library for disassembling JIT-ed programs
Date:   Thu, 20 Oct 2022 13:37:02 +0100
Message-Id: <20221020123704.91203-7-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020123704.91203-1-quentin@isovalent.com>
References: <20221020123704.91203-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

The LLVM disassembler requires the LLVM development package (usually
llvm-dev or llvm-devel).

The expectation is that the interface for this disassembler will be more
stable. There is a note in LLVM's Developer Policy [1] stating that the
stability for the C API is "best effort" and not guaranteed, but at
least there is some effort to keep compatibility when possible (which
hasn't really been the case for libbfd so far). Furthermore, the Debian
page for the related LLVM package does not caution against linking to
the lib, as binutils-dev page does.

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
[1] https://llvm.org/docs/DeveloperPolicy.html#c-api-changes

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Yonghong Song <yhs@fb.com>
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

