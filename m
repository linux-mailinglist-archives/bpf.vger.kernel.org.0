Return-Path: <bpf+bounces-12728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F057D01D2
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 20:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A3B1C20F4F
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A10A38DFC;
	Thu, 19 Oct 2023 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1563C685;
	Thu, 19 Oct 2023 18:36:57 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB38196;
	Thu, 19 Oct 2023 11:36:54 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso13123661a12.3;
        Thu, 19 Oct 2023 11:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697740613; x=1698345413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpAc9JR2llpI5jbz/4KyEoDjDKwVg7PxCT40QCvua5I=;
        b=sZKZlls9FjrlXZG8l3YYDwdt1fS0tbCDa3vOKS/MXDlitc4UHV2/BtBDTaDBSRfG2z
         2kl6ozcE01biBe5zt3bOk8DgwSXszVxAdoWjX2N0CVtLXitexekuhJAH8xHIcoameOXe
         /PSA2yndIAsAd4wFeLaYYRqABXWlNn+XSLCHmbSfCOLNfgH1VWfvhrl0C7rQFzZA50Y5
         t3ylOREg1LAnV66swyWYV6Uw6SpWeJWq+VL3TjDSWFlE9oDSFKI8O4juBKIUuf8dMael
         Mj7+1lbRWHoPF3CXlM+VAXsfZCqzrGWSC/7SpSPBIWWDfMtM8QdLzIyhISwQGRfOtZHY
         iw7Q==
X-Gm-Message-State: AOJu0Yy5Cora7JMDLbN0Vyw0rLb4WMM9pek9VjHvJ914GFWCzKBf2Aaz
	UleAvqRBgo3w/AW6bWjU80E=
X-Google-Smtp-Source: AGHT+IE4lt0hm/EIQpi1vFV/0R90YEfOuEUK0F7ZljzjTlQtUBBLLT7wATGinjmXlESRF+RJfhsPCA==
X-Received: by 2002:a17:907:928b:b0:9bf:3c7d:5f53 with SMTP id bw11-20020a170907928b00b009bf3c7d5f53mr2290910ejc.45.1697740613060;
        Thu, 19 Oct 2023 11:36:53 -0700 (PDT)
Received: from localhost (fwdproxy-cln-020.fbsv.net. [2a03:2880:31ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709064a4600b009ae05f9eab3sm24469ejv.65.2023.10.19.11.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:36:52 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: jpoimboe@kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: leit@meta.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Jinghao Jia <jinghao@linux.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-trace-kernel@vger.kernel.org (open list:FUNCTION HOOKS (FTRACE)),
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6])
Subject: [PATCH v5 06/12] x86/bugs: Rename SLS to CONFIG_MITIGATION_SLS
Date: Thu, 19 Oct 2023 11:11:52 -0700
Message-Id: <20231019181158.1982205-7-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019181158.1982205-1-leitao@debian.org>
References: <20231019181158.1982205-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPU mitigations config entries are inconsistent, and names are hard to
related. There are concrete benefits for both users and developers of
having all the mitigation config options living in the same config
namespace.

The mitigation options should have consistency and start with
MITIGATION.

Rename the Kconfig entry from SLS to MITIGATION_SLS.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig               | 2 +-
 arch/x86/Makefile              | 2 +-
 arch/x86/include/asm/linkage.h | 4 ++--
 arch/x86/kernel/alternative.c  | 4 ++--
 arch/x86/kernel/ftrace.c       | 3 ++-
 arch/x86/net/bpf_jit_comp.c    | 4 ++--
 scripts/Makefile.lib           | 2 +-
 7 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f3593461ce35..9dd2fb555973 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2556,7 +2556,7 @@ config CPU_SRSO
 	help
 	  Enable the SRSO mitigation needed on AMD Zen1-4 machines.
 
-config SLS
+config MITIGATION_SLS
 	bool "Mitigate Straight-Line-Speculation"
 	depends on CC_HAS_SLS && X86_64
 	select OBJTOOL if HAVE_OBJTOOL
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 3053b60f017b..1ac5d6002f5f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -204,7 +204,7 @@ ifdef CONFIG_MITIGATION_RETPOLINE
   endif
 endif
 
-ifdef CONFIG_SLS
+ifdef CONFIG_MITIGATION_SLS
   KBUILD_CFLAGS += -mharden-sls=all
 endif
 
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index c5165204c66f..09e2d026df33 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -43,7 +43,7 @@
 #if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
 #else /* CONFIG_MITIGATION_RETPOLINE */
-#ifdef CONFIG_SLS
+#ifdef CONFIG_MITIGATION_SLS
 #define RET	ret; int3
 #else
 #define RET	ret
@@ -55,7 +55,7 @@
 #if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define ASM_RET	"jmp __x86_return_thunk\n\t"
 #else /* CONFIG_MITIGATION_RETPOLINE */
-#ifdef CONFIG_SLS
+#ifdef CONFIG_MITIGATION_SLS
 #define ASM_RET	"ret; int3\n\t"
 #else
 #define ASM_RET	"ret\n\t"
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8932f524c935..ea9652eb455b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -624,8 +624,8 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 	/*
 	 * The compiler is supposed to EMIT an INT3 after every unconditional
 	 * JMP instruction due to AMD BTC. However, if the compiler is too old
-	 * or SLS isn't enabled, we still need an INT3 after indirect JMPs
-	 * even on Intel.
+	 * or MITIGATION_SLS isn't enabled, we still need an INT3 after
+	 * indirect JMPs even on Intel.
 	 */
 	if (op == JMP32_INSN_OPCODE && i < insn->length)
 		bytes[i++] = INT3_INSN_OPCODE;
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 0f26758c7a93..b000158b781a 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -297,7 +297,8 @@ union ftrace_op_code_union {
 	} __attribute__((packed));
 };
 
-#define RET_SIZE	(IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) ? 5 : 1 + IS_ENABLED(CONFIG_SLS))
+#define RET_SIZE \
+	(IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) ? 5 : 1 + IS_ENABLED(CONFIG_MITIGATION_SLS))
 
 static unsigned long
 create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ef732f323926..96a63c4386a9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -469,7 +469,7 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 			emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
 	} else {
 		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */
-		if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) || IS_ENABLED(CONFIG_SLS))
+		if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) || IS_ENABLED(CONFIG_MITIGATION_SLS))
 			EMIT1(0xCC);		/* int3 */
 	}
 
@@ -484,7 +484,7 @@ static void emit_return(u8 **pprog, u8 *ip)
 		emit_jump(&prog, x86_return_thunk, ip);
 	} else {
 		EMIT1(0xC3);		/* ret */
-		if (IS_ENABLED(CONFIG_SLS))
+		if (IS_ENABLED(CONFIG_MITIGATION_SLS))
 			EMIT1(0xCC);	/* int3 */
 	}
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index d6e157938b5f..0d5461276179 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -264,7 +264,7 @@ endif
 objtool-args-$(CONFIG_UNWINDER_ORC)			+= --orc
 objtool-args-$(CONFIG_MITIGATION_RETPOLINE)		+= --retpoline
 objtool-args-$(CONFIG_RETHUNK)				+= --rethunk
-objtool-args-$(CONFIG_SLS)				+= --sls
+objtool-args-$(CONFIG_MITIGATION_SLS)			+= --sls
 objtool-args-$(CONFIG_STACK_VALIDATION)			+= --stackval
 objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
 objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
-- 
2.34.1


