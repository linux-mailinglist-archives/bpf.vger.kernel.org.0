Return-Path: <bpf+bounces-53019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ABBA4B804
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 07:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F1B3B0342
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 06:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639071E9B07;
	Mon,  3 Mar 2025 06:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdI1CMsm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5679B1E990E;
	Mon,  3 Mar 2025 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740984966; cv=none; b=NNBNThPn3JgjuM5Oux+OCBivLr/QgTB9iFkzq4jMionXQQI5R8IPltKigR93EOussqQ3pU+PKXlCTO8rxTqsKkJmpZ26MxsvlkqfC63qs1W9F8Mkq2kMnvD97s17StJ27VYPjm/csftzjabYsxOeSEJRtyEbqeV+aM+pDj7R8Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740984966; c=relaxed/simple;
	bh=r1n1Uafjg9Tb7hAw9aZTOW4QZemIa+WVQ6XY0cn91Fo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AVv+LB20bW0XqYva+Z2tkgWlXz6baMT8T8KyF6AMn6WIpUIjxB/zxzCA0I9RzaNJYty+vIEUe8E6bfJbTuyft+W6QeprXdicgw8qYW2V+n/EDDSEmYu+BbeAFp8ZRN4xd118oyvoU9UQQCdrFtKzxWeESmHTQwStLEdffAJrqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdI1CMsm; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2feb1d7a68fso6904604a91.1;
        Sun, 02 Mar 2025 22:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740984964; x=1741589764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMU16H6izdRqPTzQSvNq/kwALVMPh8dWr5JstZVUeSQ=;
        b=kdI1CMsm+eYdqtJF2xiIN+YGJiENl+/zDMtKCNX1P85MHnzPtpWbQSvvIlYPY5bBUg
         SbqZ+h5Yug+j8BbUJVdbztqpzLWAuzaFgby3KAx/mcXW2F8q3dKX+xwzI52fgdDpkJ8g
         pLskVHUsKfE46pN3gjY+/SmUPeJbDyr9nt6zq0WQvYDiRvNYbzjhOGEoLZdj0xKX5vXL
         rYYLlFFUEKMrsGimr0C6lw/WOAZGRwGPgsOw4or6jwdMDp6bqb5KUpcBfUEX142hKHsi
         usFMs8rGt8SY01utQLtMfUufksmKsv+zk3SM9ca8IOC24cXgxDhKd8LO8WS7sETTPNlz
         BtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740984964; x=1741589764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMU16H6izdRqPTzQSvNq/kwALVMPh8dWr5JstZVUeSQ=;
        b=Vu5fYokXqREgChPs43E4dXiX30rg428dRvFT6OpLA3AUp/jrChKrzr0bsmmQo0LUIF
         TUuHL/bjJ5QbwPpNdqOp4WGLTe+XhcJ5D5eqzKpkizhkXTeQ4+X0gFKot2nnQ6GhUjNA
         Ybee003/ikPQHtjCOfDKBTo9fAmV46br16+VMGGDIUxwUYIL4i7paKuC8RxEnTqUp62U
         QBNj7fWdr12RNZ9a7xfegiYRLCkM+DnJ/tVBhqvo/l1a4q7e/vB4RABtq/oQlWV6bvnM
         Ek4MBH1VuQCwr3+gk7M+H3jV7uMTubohBbiZLjWlGcrs64xzPNRicuarNxsYOeIzb2Zb
         ZLgw==
X-Forwarded-Encrypted: i=1; AJvYcCU+I6Yc8ND2d+iGz+a4ZbEKIHx0OUrOTOABULCaCG+avhzhwhRq4FJDshTdgRNMk4q7O4Nl/kjA@vger.kernel.org, AJvYcCVZgoPGvYXnbsEpi8iuXNPbUf8bepag0YcKQW32UCxYYY9ns4fdEnd4rpfHuOqsgIs7J+o=@vger.kernel.org, AJvYcCXn8CpcngO90mZua7c/hQY9O8KZFSOc0aKN6+DGQa/6Vx2V5HvADYc1gVNaluUGHIGMOyjYliD0bZC6kWz/@vger.kernel.org, AJvYcCXrG0NDnIekdLBqsQ86SixsfUiQneEDaPj4isj7DJGEdyMmMLpr4t7cUFLZpE85ZcmNqHXLeYI+YrlyBm0ibIf16fsx@vger.kernel.org
X-Gm-Message-State: AOJu0YyCqSpjFFAGonO4fO2qnWEt2OPtcHAw2qQ+iBSMdRjt+0Pa9OGF
	ESbNcY4PTzk35yLpXO1NlWEhLnKPwoahcVRi158X4ijFw9eTl9OK
X-Gm-Gg: ASbGncv+t/1KiLruVf39lWOSHJvJhF9ysrKbujCyJ7TVRngay56xrVFLzUPM/L9gQ+O
	Ko1BuWsMJMrHRg0O6PPoqBfvJn/dWZENfgeZl1aHvSIuRRPoWfaWArf6wSXh+GCaqnTLt1cvsFs
	8N7+LqpvZM8ZONPpwWz4ZRLqdsCjyV7f7yj6FJSGDzu+bChSJAGsyzjS9siQ2brIL55suRpQ+Q0
	6PbtTKSHQLE04PqoDkNX7ugvxNhA6IB6LMqnGy2HcL7ISfcOdHW/MiG4fK/DxnNlSOXBJ5zN8oO
	VvAzPesalGBC9uu/84aIktQpqB6AyT9I0bodaH0ZzKO59Z54wimKE9pQBUE40g==
X-Google-Smtp-Source: AGHT+IGyBy5lAIgE9/BJFGPHKWL9IGQJbSt/AMZr+VvaZ6EhLBWcU/x/8umKGWf6iOEq1B7Odhyfkg==
X-Received: by 2002:a17:90b:1845:b0:2ee:d193:f3d5 with SMTP id 98e67ed59e1d1-2febab2ecbfmr20898385a91.7.1740984964540;
        Sun, 02 Mar 2025 22:56:04 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea6769ad2sm8139575a91.11.2025.03.02.22.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 22:56:04 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	rostedt@goodmis.org,
	mark.rutland@arm.com,
	alexei.starovoitov@gmail.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mhiramat@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	mathieu.desnoyers@efficios.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	samitolvanen@google.com,
	kees@kernel.org,
	dongml2@chinatelecom.cn,
	akpm@linux-foundation.org,
	riel@surriel.com,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next v3 3/4] x86: implement per-function metadata storage for x86
Date: Mon,  3 Mar 2025 14:53:44 +0800
Message-Id: <20250303065345.229298-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303065345.229298-1-dongml2@chinatelecom.cn>
References: <20250303065345.229298-1-dongml2@chinatelecom.cn>
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

In x86, we need 5-bytes to prepend a "mov %eax xxx" insn, which can hold
a 4-bytes index. So we have following logic:

1. use the head 5-bytes if CFI_CLANG is not enabled
2. use the tail 5-bytes if MITIGATION_CALL_DEPTH_TRACKING and FINEIBT are
   not enabled
3. compile the kernel with FUNCTION_ALIGNMENT_32B otherwise

In the third case, we make the kernel function 32 bytes aligned, and there
will be 32 bytes padding before the functions. According to my testing,
the text size didn't increase on this case, which is weird.

With 16-bytes padding:

-rwxr-xr-x 1 401190688  x86-dev/vmlinux*
-rw-r--r-- 1    251068  x86-dev/vmlinux.a
-rw-r--r-- 1 851892992  x86-dev/vmlinux.o
-rw-r--r-- 1  12395008  x86-dev/arch/x86/boot/bzImage

With 32-bytes padding:

-rwxr-xr-x 1 401318128 x86-dev/vmlinux*
-rw-r--r-- 1    251154 x86-dev/vmlinux.a
-rw-r--r-- 1 853636704 x86-dev/vmlinux.o
-rw-r--r-- 1  12509696 x86-dev/arch/x86/boot/bzImage

The way I tested should be right, and this is a good news for us. On the
third case, the layout of the padding space will be like this if fineibt
is enabled:

__cfi_func:
	mov	--	5	-- cfi, not used anymore
	nop
	nop
	nop
	mov	--	5	-- function metadata
	nop
	nop
	nop
	fineibt	--	16	-- fineibt
func:
	nopw	--	4
	......

I tested the fineibt with "cfi=fineibt" cmdline, and it works well
together with FUNCTION_METADATA enabled. And I also tested the
performance of this function by setting metadata for all the kernel
function, and it consumes 0.7s for 70k+ functions, not bad :/

I can't find a machine that support IBT, so I didn't test the IBT. I'd
appreciate it if someone can do this testing for me :/

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- select FUNCTION_ALIGNMENT_32B on case3, instead of extra 5-bytes
---
 arch/x86/Kconfig              | 18 ++++++++++++
 arch/x86/include/asm/ftrace.h | 54 +++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be2c311f5118..fe5a98401135 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2509,6 +2509,24 @@ config PREFIX_SYMBOLS
 	def_bool y
 	depends on CALL_PADDING && !CFI_CLANG
 
+config FUNCTION_METADATA
+	bool "Per-function metadata storage support"
+	default y
+	depends on CC_HAS_ENTRY_PADDING && OBJTOOL
+	select CALL_PADDING
+	select FUNCTION_ALIGNMENT_32B if ((CFI_CLANG && CALL_THUNKS) || FINEIBT)
+	help
+	  Support per-function metadata storage for kernel functions, and
+	  get the metadata of the function by its address with almost no
+	  overhead.
+
+	  The index of the metadata will be stored in the function padding
+	  and consumes 5-bytes. FUNCTION_ALIGNMENT_32B will be selected if
+	  "(CFI_CLANG && CALL_THUNKS) || FINEIBT" to make sure there is
+	  enough available padding space for this function. However, it
+	  seems that the text size almost don't change, compare with
+	  FUNCTION_ALIGNMENT_16B.
+
 menuconfig CPU_MITIGATIONS
 	bool "Mitigations for CPU vulnerabilities"
 	default y
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index f9cb4d07df58..d5cbb8e18fd7 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -4,6 +4,28 @@
 
 #include <asm/ptrace.h>
 
+#ifdef CONFIG_FUNCTION_METADATA
+#if (defined(CONFIG_CFI_CLANG) && defined(CONFIG_CALL_THUNKS)) || (defined(CONFIG_FINEIBT))
+  /* the CONFIG_FUNCTION_PADDING_BYTES is 32 in this case, use the
+   * range: [align + 8, align + 13].
+   */
+  #define KFUNC_MD_INSN_OFFSET		(CONFIG_FUNCTION_PADDING_BYTES - 8)
+  #define KFUNC_MD_DATA_OFFSET		(CONFIG_FUNCTION_PADDING_BYTES - 9)
+#else
+  #ifdef CONFIG_CFI_CLANG
+    /* use the space that CALL_THUNKS suppose to use */
+    #define KFUNC_MD_INSN_OFFSET	(5)
+    #define KFUNC_MD_DATA_OFFSET	(4)
+  #else
+    /* use the space that CFI_CLANG suppose to use */
+    #define KFUNC_MD_INSN_OFFSET	(CONFIG_FUNCTION_PADDING_BYTES)
+    #define KFUNC_MD_DATA_OFFSET	(CONFIG_FUNCTION_PADDING_BYTES - 1)
+  #endif
+#endif
+
+#define KFUNC_MD_INSN_SIZE		(5)
+#endif
+
 #ifdef CONFIG_FUNCTION_TRACER
 #ifndef CC_USING_FENTRY
 # error Compiler does not support fentry?
@@ -168,4 +190,36 @@ static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 #endif /* !COMPILE_OFFSETS */
 #endif /* !__ASSEMBLY__ */
 
+#if !defined(__ASSEMBLY__) && defined(CONFIG_FUNCTION_METADATA)
+#include <asm/text-patching.h>
+
+static inline bool kfunc_md_arch_exist(void *ip)
+{
+	return *(u8 *)(ip - KFUNC_MD_INSN_OFFSET) == 0xB8;
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
+static inline int kfunc_md_arch_poke(void *ip, u8 *insn)
+{
+	text_poke(ip, insn, KFUNC_MD_INSN_SIZE);
+	text_poke_sync();
+	return 0;
+}
+
+#endif
+
 #endif /* _ASM_X86_FTRACE_H */
-- 
2.39.5


