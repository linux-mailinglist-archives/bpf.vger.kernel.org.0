Return-Path: <bpf+bounces-59090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2C1AC6047
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 035D07B1065
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1075015A848;
	Wed, 28 May 2025 03:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3J8oCZU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4AD1E98F3;
	Wed, 28 May 2025 03:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404184; cv=none; b=mH08ZSeSR2S8vqkEqs8EIyHPaY05wY61YRYR8HKRSov0yTsMc4dErb1yNeMXDfVFFosHh6gKNcjcgR5Met3N33P2QuQuezzCDLl+6FF9LnwWmT4Fvck0iA825RNcH6oLNrZ+sBVcWWq+Yw2y+sR5tznJT44dgt7X7flz1LCwSn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404184; c=relaxed/simple;
	bh=brjzoRfQr/GEtdVUjTUnIgAaWrgzva+2OjgAcyy2xVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oFj36sbPVijsE+Cn1bRErbre7UQUy5aitsCU3uEUVaN614pWkaa4vDKsVehp5Q7d6F8ogne4gOa3mMvLr7XdXn812EcA7ThCjoX4XnC2M09GJm6Aptm1/zayiR3RemfhadOn5zQEESSZXe/jk9n7fQqUfdDVSG6kBYAJomrebuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3J8oCZU; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-234bfe37cccso6984225ad.0;
        Tue, 27 May 2025 20:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404181; x=1749008981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsDc4QLUgbCBBYtWAxHqZcjIGHY4TkYNVyWhaF+ewHY=;
        b=T3J8oCZUaWNxJVHkoyQSWJHhSI5jUbxSrMqfGP52DAKYTjqunr7SChIfkBGwZZ0SeL
         A8y2dg5WmwZQLzndzD31FYj17wDJnT/b0XfZrFW4uoD1HoIiZNu3zSx8AjVtpEtzYMtr
         y21xTlU/yepOVDGEGTTBwyid/wm+gDWtOyBVBSrqjQU1EeIgCXMCrGu5DBew3n20AZLl
         moYphd0YT0RjR+V5J+b4iCvH7iyIv0XXYjinxioAwmW7yL0NYO88Rj318LqplGp21ifO
         uUnsa6EgYklgE27S2hb9XsbWrbPDDcOnPDAWUWaAXZN13+Lg1vyl8Eh6Y9XfGeBZngf6
         Gncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404181; x=1749008981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsDc4QLUgbCBBYtWAxHqZcjIGHY4TkYNVyWhaF+ewHY=;
        b=dxwj2MnpsSUzwTNBD3z3ioHDymSNdUSWaZSCd/g1W0a1JqYlFbHrINk59RV/MuBG5d
         XaVkZlzeyo5w04cKSf45/uv3Drj471QgvNaHakfbRIxZogIubBRQWC92kW+RtvhZ4f4/
         kQeua4eCWGGx+pSTtTuRfepNSe86bpGctYkRrZEtgNXKHtqm8cKjo8WcMi6AHU2XqmEs
         eYCQ25iz6w0gGZUonWAK8w8hkp7gPdVBkC6sT7nPOJhxm9u1Op4f8N4LX/RgRLHRnTCh
         NGG+FhIbwOvbw5PWWMvJWMesrREaN/NbGMzOwGZ3RamnEog2Tt0brRkFVH5E7dJoWERM
         4ohg==
X-Forwarded-Encrypted: i=1; AJvYcCUKnYzWswMbmGPdgUQy0S63v240pW2XSOqXUzxPZQeOUrr3lxQLSQlQWYcNDVicfD3Nm5YNkvt0C4yhZvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD8nCkxul0ulsCDSuUM5uKZ1V6q1o2ovUuNd69geF9a1RqbVNz
	TExeTP2VO57NgCrXParo8jGrdxHpGwFyYrsVOQ/vNXLgQgRMHT8VsLcE
X-Gm-Gg: ASbGncugMAyoKBaVPYiEibhR5HC5TWskpX/HeSGh2LctYdNXXojuH/gP8QFaJY47pev
	ypc67dzWCdbcw55B7km9C2n4INe4H8CVMKaFHR+JjSyJXv4Qv27YPFuwC0mJ6E5wc/LRTZQexAb
	3+m0UP/qZBXboPrCxtNZGLq1qy+jJ6/6WGgEfP4fOC7jI6MxBKDWpCoAuiWjiMkGL9NYApagZdF
	HjKjcb5CkaAR9nBSEsdt9qOnrnTGWE0/Z1UQZHvbvkW7CGmg4spb0U1efWC6mGs8/153qCVXbZb
	fj5KuGg854ktur/p6kLMHw6Kvi3SIvvVr2eRr2BICiO0hPW5GS0tclP1l7iMBYtKxAOYOfxLBcj
	sRbA=
X-Google-Smtp-Source: AGHT+IFFmuM2KuoJrIGiY+X6Xa/3xOqPHrS80F9eVMW7zRPeXztvJ1YZLoiJAKud8BF+8v168sJ6oA==
X-Received: by 2002:a17:903:2988:b0:224:e0f:4b5 with SMTP id d9443c01a7336-23414f3aa7bmr195721765ad.7.1748404180895;
        Tue, 27 May 2025 20:49:40 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:49:40 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 02/25] x86: implement per-function metadata storage for x86
Date: Wed, 28 May 2025 11:46:49 +0800
Message-Id: <20250528034712.138701-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_CALL_PADDING enabled, there will be 16-bytes padding space
before all the kernel functions. And some kernel features can use it,
such as MITIGATION_CALL_DEPTH_TRACKING, CFI_CLANG, FINEIBT, etc.

In my research, MITIGATION_CALL_DEPTH_TRACKING will consume the tail
9-bytes in the function padding, CFI_CLANG will consume the head 5-bytes,
and FINEIBT will consume all the 16 bytes if it is enabled. So there will
be no space for us if MITIGATION_CALL_DEPTH_TRACKING and CFI_CLANG are
both enabled, or FINEIBT is enabled.

In order to implement the padding-based function metadata, we need 5-bytes
to prepend a "mov %eax xxx" insn in x86_64, which can hold a 4-bytes
index. So we have following logic:

1. use the head 5-bytes if CFI_CLANG is not enabled
2. use the tail 5-bytes if MITIGATION_CALL_DEPTH_TRACKING and FINEIBT are
   not enabled
3. try to probe if fineibt or the call thunks is enabled after the kernel
   boot dynamically

On the third case, we implement the function metadata by hash table if
"cfi_mode==CFI_FINEIBT || thunks_initialized". Therefore, we need to make
thunks_initialized global in arch/x86/kernel/callthunks.c

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/Kconfig                   | 26 +++++++++++++++++
 arch/x86/include/asm/alternative.h |  2 ++
 arch/x86/include/asm/ftrace.h      | 47 ++++++++++++++++++++++++++++++
 arch/x86/kernel/callthunks.c       |  2 +-
 arch/x86/kernel/ftrace.c           | 26 +++++++++++++++++
 5 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b9f378e05f6..0405288c42c6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2459,6 +2459,32 @@ config PREFIX_SYMBOLS
 	def_bool y
 	depends on CALL_PADDING && !CFI_CLANG
 
+config FUNCTION_METADATA
+	bool "Per-function metadata storage support"
+	default y
+	depends on CC_HAS_ENTRY_PADDING && OBJTOOL
+	help
+	  Support function padding based per-function metadata storage for
+	  kernel functions, and get the metadata of the function by its
+	  address with almost no overhead.
+
+	  The index of the metadata will be stored in the function padding
+	  and consumes 5-bytes.
+
+	  Hash table based function metadata will be used if this option
+	  is not enabled.
+
+config FUNCTION_METADATA_PADDING
+	bool "function padding is available for metadata"
+	default y
+	depends on FUNCTION_METADATA && !FINEIBT && !(CFI_CLANG && CALL_THUNKS)
+	select CALL_PADDING
+	help
+	  Function padding is available for the function metadata. If this
+	  option is disabled, function metadata will try to probe if there
+	  are usable function padding during the system boot. If not, the
+	  hash table based function metadata will be used instead.
+
 menuconfig CPU_MITIGATIONS
 	bool "Mitigations for CPU vulnerabilities"
 	default y
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4a37a8bd87fd..951edf1857c3 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -103,6 +103,8 @@ struct callthunk_sites {
 };
 
 #ifdef CONFIG_CALL_THUNKS
+extern bool thunks_initialized;
+
 extern void callthunks_patch_builtin_calls(void);
 extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
 					  struct module *mod);
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 93156ac4ffe0..ed1fdfce824e 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -4,6 +4,21 @@
 
 #include <asm/ptrace.h>
 
+#ifdef CONFIG_FUNCTION_METADATA_PADDING
+
+#ifdef CONFIG_CFI_CLANG
+/* use the space that CALL_THUNKS suppose to use */
+#define KFUNC_MD_INSN_OFFSET	(5)
+#define KFUNC_MD_DATA_OFFSET	(4)
+#else
+/* use the space that CFI_CLANG suppose to use */
+#define KFUNC_MD_INSN_OFFSET	(CONFIG_FUNCTION_PADDING_BYTES)
+#define KFUNC_MD_DATA_OFFSET	(CONFIG_FUNCTION_PADDING_BYTES - 1)
+#endif
+#endif
+
+#define KFUNC_MD_INSN_SIZE	(5)
+
 #ifdef CONFIG_FUNCTION_TRACER
 #ifndef CC_USING_FENTRY
 # error Compiler does not support fentry?
@@ -154,6 +169,38 @@ static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 }
 #endif /* CONFIG_FTRACE_SYSCALLS && CONFIG_IA32_EMULATION */
 #endif /* !COMPILE_OFFSETS */
+
+#ifdef CONFIG_FUNCTION_METADATA
+#include <asm/text-patching.h>
+
+static inline bool kfunc_md_arch_exist(unsigned long ip, int insn_offset)
+{
+	return *(u8 *)(ip - insn_offset) == 0xB8;
+}
+
+static inline void kfunc_md_arch_pretend(u8 *insn, u32 index)
+{
+	*insn = 0xB8;
+	*(u32 *)(insn + 1) = index;
+}
+
+static inline void kfunc_md_arch_nops(u8 *insn)
+{
+	*(insn++) = BYTES_NOP1;
+	*(insn++) = BYTES_NOP1;
+	*(insn++) = BYTES_NOP1;
+	*(insn++) = BYTES_NOP1;
+	*(insn++) = BYTES_NOP1;
+}
+
+static inline int kfunc_md_arch_poke(void *ip, u8 *insn, int insn_offset)
+{
+	text_poke(ip, insn, insn_offset);
+	text_poke_sync();
+	return 0;
+}
+#endif /* CONFIG_FUNCTION_METADATA */
+
 #endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_X86_FTRACE_H */
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index d86d7d6e750c..6ed49904cd61 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -56,7 +56,7 @@ struct core_text {
 	const char	*name;
 };
 
-static bool thunks_initialized __ro_after_init;
+bool thunks_initialized __ro_after_init;
 
 static const struct core_text builtin_coretext = {
 	.base = (unsigned long)_text,
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index cace6e8d7cc7..2504c2556508 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -26,6 +26,7 @@
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 #include <linux/execmem.h>
+#include <linux/kfunc_md.h>
 
 #include <trace/syscall.h>
 
@@ -569,6 +570,31 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 	ops->trampoline = 0;
 }
 
+#if defined(CONFIG_FUNCTION_METADATA) && !defined(CONFIG_FUNCTION_METADATA_PADDING)
+bool kfunc_md_arch_support(int *insn, int *data)
+{
+	/* when fineibt is enabled, the 16-bytes padding are all used */
+	if (IS_ENABLED(CONFIG_FINEIBT) && cfi_mode == CFI_FINEIBT)
+		return false;
+
+	if (IS_ENABLED(CONFIG_CALL_THUNKS) && IS_ENABLED(CONFIG_CFI_CLANG)) {
+		/* when call thunks and cfi are both enabled, no enough space
+		 * for us.
+		 */
+		if (thunks_initialized)
+			return false;
+		/* use the tail 5-bytes for function meta data */
+		*insn = 5;
+		*data = 4;
+
+		return true;
+	}
+
+	WARN_ON_ONCE(1);
+	return true;
+}
+#endif
+
 #endif /* CONFIG_X86_64 */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
-- 
2.39.5


