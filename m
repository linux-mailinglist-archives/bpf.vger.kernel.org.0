Return-Path: <bpf+bounces-53058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C275A4C1F6
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 14:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE3C171230
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 13:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE672144B1;
	Mon,  3 Mar 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo3VuO1y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DE8212D8A;
	Mon,  3 Mar 2025 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008655; cv=none; b=Huj8dsdJsZXACvKPnNF1gAgt15rlOXC6hB0rpumcJwf03ugfq9T5wFfhe6WkiUbyjEKHuT54HAaZ8GG8/tNJGWVVvXa9H3LNEkqCYXxX+PwOxUJLaGN+sy7uKbizvsWrMwdvpNfG/XhuGfVYNgsOvB7i6wzY9M18XXH9M83kUu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008655; c=relaxed/simple;
	bh=0opDRmJgFcne9MVvIB9mWH4N0ry/ocl2wUXCnUeZZWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=unuuv/WuzFJterWZ2+DY/X6rChPXNqFX/No/3wdqdXKMPGQmTEzXLonW0lJRsss0cxQFuS7S8oHIaXsUMeUX9a5GvWaES1mPrAQIROOId0WKsBKcAVscNuz9O3cB9L4eDRHP3WUPk1TxWg3zUroOCxabcpj3G/07lAQ7Sjl8vwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yo3VuO1y; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2232b12cd36so58594305ad.0;
        Mon, 03 Mar 2025 05:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741008653; x=1741613453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0whn35vPm8J+vjBTbfA5u1AHwSTrw7swcARc6I++Hc=;
        b=Yo3VuO1yECF1+kFHLH0euRtLVZw/zHR0aag+qhLUnLNwo/6dTKDcoBq8r8qUoXxqa8
         J9iCfesx+8hqAUOMfjaO2WyG7BX56E7wcaEOFI4b+T4ZcX9Ku2AAECuPF9u79fI+Og95
         dy0YKP8msNzZ8ZO8xVGYZ48aFCjJrmEkiQpbfii4sErkFXiNBwdG8bNGMDLx+TnviruW
         Kku4DV2CPXCKF2ccZznsQSFhqAgppiMiqe96pAgV1vKSnIgc05G98cLBMJPcCfNSAY5+
         APN5IppKTHfs6QWNv3mOAOsRf8URxHmn8aVPfW3ZsUcYMeCM8maYfcadS4Wksy/LgWRM
         MF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741008653; x=1741613453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0whn35vPm8J+vjBTbfA5u1AHwSTrw7swcARc6I++Hc=;
        b=cN3Pqa66nf8KP6JEEOetEfup+PSwbH+BYCH+svOO+eR6iqlU8Y6r2pAN2CB/vfNS8k
         fCoeuEKfxJ/mr1JDz3eFEE4QlUa3BirpvIP9jiM6JHJTeXWdw2QDjbRy5X6FKtNCGC81
         QrzUyKha1km3dLlXBYwA+y53ZZCx2cp9Ye7NE7NUzMoMTQhCe+TA+1Q4kRLyJPPB6T/q
         ZaIaqg4a5YsyN1vv5t7a5BQKcQuuM3uhiCxI3TKcH9hKTz/n4mdiZgays7fhX7hws5m2
         FFn1wE0LRB8sNAgZNqoVjCk++OA/ZvwNshl1uSyG3pILFVEnUMAgYciXhdPpQJ4AbHsX
         XHcA==
X-Forwarded-Encrypted: i=1; AJvYcCU03EUyFuF1B+ZnixmX/WdPawaMl34Cjvo3VHKhyx2cNKbKSOEWugI8uv98t1QBYRQXFmcXPSLZ3Vsphk1d@vger.kernel.org, AJvYcCUNbdOEd77zxjPXxRw2bEAM1GUyJ2EQOEpEu9Bs85OBDRrJv0aeKYtvkiCvtgMDBQ58g1jgv/cZ81knnF2JT7n03VY8@vger.kernel.org, AJvYcCUdMVQtvYCuO4KhTKzGQuE0sqzGPbtGUurIVNp3xGXH/qU9n5aDCFUwtLZd71pun0G6Vto=@vger.kernel.org, AJvYcCVUOPK1YNrnzcjtLMxrOX2i5yAbWNf/tv6DItHENLEX6LBh6Ccb0Ykt/E5RLkolFMD4OkvDqeSE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WKIBGMWziMcEmuWKe084oXNkzrvUDIMDkvGgI/jBjMJ5kBK5
	jMh+73nuOBmzqUJCyOYmY6P37mgmeKESD6FLMs4JF+rxVx1QWZrx
X-Gm-Gg: ASbGncu1G/WMyjicL0VxJOVwDQo1z95VWLVGEoMOybuv5uhxW1Rs3s+/ptj9mKl/az+
	1DBk6noW1zZqLgK4HnOp7hIwgn+XQu6HOPi299H9cyZzut7t6qdD9PGY5qgTSFwuo21Qop2jgO+
	koJafqg0UzbfZTqw7MN24X0MImuTLPCmshhevbFr63l8WyMqnCDBTaMwtNilEOmjAscpRhZBSw5
	UfFGKHAn1C5AVapXIfuy0TGpD+2Czfid7rkq+rU9roMnYDoFJSMWzqKgyVHIaIsw7dh/BRDR230
	NAXphmvJwqhDec6NvFT7Oh0ZHQxKk8+yjgE2vvSd4f45xz1j8p6/4wQpRtXyWQ==
X-Google-Smtp-Source: AGHT+IECVEaRvzz7jFgM9Xs6Qsz7AN1fGJ1Lrd2ZRMORcgHaHlhwWOyshFl83O3butQP+uNtOa6yXg==
X-Received: by 2002:a17:902:e5c5:b0:223:4bd6:3863 with SMTP id d9443c01a7336-22368f6a174mr217254605ad.10.1741008652539;
        Mon, 03 Mar 2025 05:30:52 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505359b8sm77297035ad.253.2025.03.03.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:30:52 -0800 (PST)
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
Subject: [PATCH v4 3/4] x86: implement per-function metadata storage for x86
Date: Mon,  3 Mar 2025 21:28:36 +0800
Message-Id: <20250303132837.498938-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303132837.498938-1-dongml2@chinatelecom.cn>
References: <20250303132837.498938-1-dongml2@chinatelecom.cn>
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
index 5c277261507e..b0614188c80b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2518,6 +2518,24 @@ config PREFIX_SYMBOLS
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
index f2265246249a..700bb729e949 100644
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
@@ -156,4 +178,36 @@ static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
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


