Return-Path: <bpf+bounces-15562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D197F3499
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080001C20969
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FF859162;
	Tue, 21 Nov 2023 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F3612C;
	Tue, 21 Nov 2023 09:12:06 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-548f0b7ab9eso1969591a12.3;
        Tue, 21 Nov 2023 09:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586725; x=1701191525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebJQJJFo7/pcaMF1DppCtjVHP/HYRDV89vhrdayN63o=;
        b=oKeJuf1gYZcTqTzGimi5tUkNsCS9Duz6Am7mo2Ls1JxIpREN4DuxAbQnqb/RH4OZTH
         GeeCXm9PhPpqgpLRAvg8Y4ZzgikZ3l4rNnodLMb01bPaX4qxXPqBohiPSl8+K+FB8iNJ
         oKh0qYpDjQAIdlUOS8T4toQ2mVK2PsYXDio1gHQV6gkRJGskRlLuiSQQsCOnKz9imWrQ
         H9MoscfWx+e4wDK7Eup8FturTLTJa48SrMipN0yrw6uhtZwbvNlDSC4eZGNVrpJCEwt2
         GMUmb3qHiwShEQjZM0puqkJn1rD0vTeM/U9v7JeVKn9Ap/XU2Gf2o8sT8Zk7uC5Cx3r6
         V6Xw==
X-Gm-Message-State: AOJu0YyONPm8IEbqn5fa3X3YOi9X/ckVXNmuwNIwwPmiInExDmghUiw9
	70NwtmqUpQFTujNY5azBv3o=
X-Google-Smtp-Source: AGHT+IHUp28jw9wemj9vkp0605dFINkpbeYM4ti0Dj59xJ6PmYGDso+p9DDgIfhD+xaWesCmDI/usA==
X-Received: by 2002:a17:906:1011:b0:a02:8820:cfa4 with SMTP id 17-20020a170906101100b00a028820cfa4mr1723457ejm.32.1700586724955;
        Tue, 21 Nov 2023 09:12:04 -0800 (PST)
Received: from localhost (fwdproxy-cln-017.fbsv.net. [2a03:2880:31ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2-20020a170906640200b0099bd7b26639sm5461362ejm.6.2023.11.21.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:12:04 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jinghao Jia <jinghao@linux.ibm.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Kees Cook <keescook@chromium.org>,
	linux-trace-kernel@vger.kernel.org (open list:FUNCTION HOOKS (FTRACE)),
	netdev@vger.kernel.org (open list:NETWORKING [IPv4/IPv6]),
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools))
Subject: [PATCH v6 06/13] x86/bugs: Rename SLS to CONFIG_MITIGATION_SLS
Date: Tue, 21 Nov 2023 08:07:33 -0800
Message-Id: <20231121160740.1249350-7-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121160740.1249350-1-leitao@debian.org>
References: <20231121160740.1249350-1-leitao@debian.org>
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
index 862be9b3b216..fa246de60cdb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2580,7 +2580,7 @@ config CPU_SRSO
 	help
 	  Enable the SRSO mitigation needed on AMD Zen1-4 machines.
 
-config SLS
+config MITIGATION_SLS
 	bool "Mitigate Straight-Line-Speculation"
 	depends on CC_HAS_SLS && X86_64
 	select OBJTOOL if HAVE_OBJTOOL
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index b8d23ed059fb..5ce8c30e7701 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -205,7 +205,7 @@ ifdef CONFIG_MITIGATION_RETPOLINE
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
index 5ec887d065ce..b01d49862497 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -637,8 +637,8 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
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
index 93bc52d4a472..70139d9d2e01 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -307,7 +307,8 @@ union ftrace_op_code_union {
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


