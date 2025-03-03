Return-Path: <bpf+bounces-53059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19957A4C1FE
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 14:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79368172CA4
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5152421481E;
	Mon,  3 Mar 2025 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhNBr+/Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB0214801;
	Mon,  3 Mar 2025 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008662; cv=none; b=aAyAwZ3lzEPd2DG6Ceky8vIOw+wLGDye9qGq+pLSvLp1QXgjLqEe0FGP4USrPNLnFnPFlW+Pg4H+M1ISFk+CFR4lmuHGkH2Mf9HVinkHnr7RIpPRMfcyclqOnPS4xMtnSgeAH+XlAGz00cudKm4arPqSQUgmOMtJmO0TVEpNSFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008662; c=relaxed/simple;
	bh=8+jQ2LOFLvD8yNjmgsq7xpDv7f8F3syKUpRlLU8kRU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CFobIGKvsmG2kIsDo0m1WCyULLXTXsxPxL/A4pJoIJxlNdiQc+J8PKQ01krb73bJQth05n2u29QEyR33I/YGz4FXc/WyYwsohgXVOPzuH6B9PJe/pQbF/g5LiNzckjxhtfn+HR+es0ulCC63wxdWqIr06oFplTef55zq/UfV/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhNBr+/Q; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22328dca22fso65779915ad.1;
        Mon, 03 Mar 2025 05:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741008660; x=1741613460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvSQXTXm2WJtvrSSulKAAYVeipdazZIwWA04KeDmP3s=;
        b=EhNBr+/QzSGBpX2IY6/QL72F/ryYFo3emfmsyWpE8E74EfQLripm/UkS61WwAgQDOJ
         UTSXWnORJ5ODi8AxNJ/8PqjipoFwxVXRFOc1RVkHifYzyTlCVg6WFwJidptYBCBMEpEg
         klrZxOIOO6EtVzbtjP0+2D0uwUlgkJtE1L0GdF8JsvaUtU4z8+4KU4KxM8Xmj2swKKuA
         xbspuk0zO1MNlLAXJjkm0IHV2QVIqBXNSYkS8LlCfK19euWcYE9zzyM20ZyYwjz12xIJ
         O3INi/L20xmiIx+52wVWhGdT2aAN3/AuT89PFtpISQnor56BcXWnqkJuyWLl14mROx+8
         zsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741008660; x=1741613460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvSQXTXm2WJtvrSSulKAAYVeipdazZIwWA04KeDmP3s=;
        b=to+9kOilBa9wU8igexWm+qGrkwPL6yAeH0UT5XcCc1e02kvYV8T29XBq350C0vSujJ
         Tr9uY+LjQbRU3oNrNjBcd+5RFwele/ARymRkZKQEy9TLf7z1tYyb4Bzcg4+V0utmsyti
         7WRG/YvtWeFqDZayr4sucrEILkOvRAvwdeGtauwELcdOc6187hB4Q8jObSwRAPvwe3eA
         JosRnHN/n9IofmJ9UoZJo6w4EPhMrAOy8/qf5k8SRuCzxoa0TukIppdbP0p6oLuIEtXH
         FdMQXRtdSv3KbgvM/rw29NgooD5YqhIyqYncKOFWBfEA5KMEbF8jzzSJR4jFJ904C8xb
         r55w==
X-Forwarded-Encrypted: i=1; AJvYcCU4dQqLEyvOSpXgw8iDU0Jso81lFC2+wtD+pxR1345bnGtgy1lTFRCw5X+eF4ncIh+TBxI=@vger.kernel.org, AJvYcCUEuO4i4XfXKcm3StLOzj6CTy2nMW3NNvd3vRcX5e/LatmBk0e7jSofdxdrg16JA2eiNEGmyPpK@vger.kernel.org, AJvYcCW2wG32040KXJ5c5Wj1r9br+0qDb1pkhcRdZ7XGDzyxQLU+OM06g29ENNssTvYmeq4RI40pQjDeuBo76JTGcML3CBT+@vger.kernel.org, AJvYcCXm4s3rLxlvBL1SU3X7MsS6iI+WESyqIDaWHakO55KjAB3TYHLDoOrpl/fS45TTSjkl3QAZRPBZihlF+nCk@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOXlGkbfg1kC62IS7wI9ow2G8jQz1OD5iDJiFFI1sgIQeydu2
	A8i3mVUN6UMktuqNgCOSIRARICoMPVwv8pt6hjxDspQJqPVzfc7M
X-Gm-Gg: ASbGncuUj4ZUis7Fta8z4/LYyMJlMgXPGRyib1QYIMaWnIy2k7sf8rBgcSihWyjWFFs
	QXlRxv7EZ1XkY0DaDiE2i9g6joDFZdlG1rq1kehwl4vwGHp6myJAeW9XsFWR9pjgky8z1NZdH03
	4fgui6UUKytP0NX5tAOk6+TTJ8u5vL1tnDaPtb70gc68onAAs7sZX95fKXOspJD0g69S80LfQVk
	Du4zFwvWeQc/3tpnuS0SXVQnpnJsm8IPbl7XrwwMeO1X0WjBuaY9ESxdA6Ub0Iyf68gYhSIk3ZR
	3Gd5Wu7JHB0nb5A7EXFjdUmllNv/DPk3JeTl0s/wuYUemVg2JS8PmiLL1Ch2Ow==
X-Google-Smtp-Source: AGHT+IFrx9yunejrhIIBax0i6zoJK5cErggOeRBXOxeJLSAEu6Vgq/DyW9livSLEsya9w6YWkG4/Ug==
X-Received: by 2002:a17:902:fc8d:b0:223:44dc:3f36 with SMTP id d9443c01a7336-2236925eef4mr220020495ad.43.1741008660442;
        Mon, 03 Mar 2025 05:31:00 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505359b8sm77297035ad.253.2025.03.03.05.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:31:00 -0800 (PST)
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
Subject: [PATCH v4 4/4] arm64: implement per-function metadata storage for arm64
Date: Mon,  3 Mar 2025 21:28:37 +0800
Message-Id: <20250303132837.498938-5-dongml2@chinatelecom.cn>
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

The per-function metadata storage is already used by ftrace if
CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS is enabled, and it store the pointer
of the callback directly to the function padding, which consume 8-bytes,
in the commit
baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS").
So we can directly store the index to the function padding too, without
a prepending. With CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS enabled, the
function is 8-bytes aligned, and we will compile the kernel with extra
8-bytes (2 NOPS) padding space. Otherwise, the function is 4-bytes
aligned, and only extra 4-bytes (1 NOPS) is needed.

However, we have the same problem with Mark in the commit above: we can't
use the function padding together with CFI_CLANG, which can make the clang
compiles a wrong offset to the pre-function type hash. He said that he was
working with others on this problem 2 years ago. Hi Mark, is there any
progress on this problem?

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/arm64/Kconfig              | 15 +++++++++++++++
 arch/arm64/Makefile             | 23 ++++++++++++++++++++--
 arch/arm64/include/asm/ftrace.h | 34 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ftrace.c      | 13 +++++++++++--
 4 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 940343beb3d4..7ed80f5eb267 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1536,6 +1536,21 @@ config NODES_SHIFT
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
 
+config FUNCTION_METADATA
+	bool "Per-function metadata storage support"
+	default y
+	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE if !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
+	depends on !CFI_CLANG
+	help
+	  Support per-function metadata storage for kernel functions, and
+	  get the metadata of the function by its address with almost no
+	  overhead.
+
+	  The index of the metadata will be stored in the function padding,
+	  which will consume 4-bytes. If FUNCTION_ALIGNMENT_8B is enabled,
+	  extra 8-bytes function padding will be reserved during compiling.
+	  Otherwise, only extra 4-bytes function padding is needed.
+
 source "kernel/Kconfig.hz"
 
 config ARCH_SPARSEMEM_ENABLE
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2b25d671365f..2df2b0f4dd90 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -144,12 +144,31 @@ endif
 
 CHECKFLAGS	+= -D__aarch64__
 
+ifeq ($(CONFIG_FUNCTION_METADATA),y)
+  ifeq ($(CONFIG_FUNCTION_ALIGNMENT_8B),y)
+  __padding_nops := 2
+  else
+  __padding_nops := 1
+  endif
+else
+  __padding_nops := 0
+endif
+
 ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS),y)
+  __padding_nops  := $(shell echo $(__padding_nops) + 2 | bc)
   KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
-  CC_FLAGS_FTRACE := -fpatchable-function-entry=4,2
+  CC_FLAGS_FTRACE := -fpatchable-function-entry=$(shell echo $(__padding_nops) + 2 | bc),$(__padding_nops)
 else ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_ARGS),y)
+  CC_FLAGS_FTRACE := -fpatchable-function-entry=$(shell echo $(__padding_nops) + 2 | bc),$(__padding_nops)
   KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
-  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+else ifeq ($(CONFIG_FUNCTION_METADATA),y)
+  CC_FLAGS_FTRACE += -fpatchable-function-entry=$(__padding_nops),$(__padding_nops)
+  ifneq ($(CONFIG_FUNCTION_TRACER),y)
+    KBUILD_CFLAGS += $(CC_FLAGS_FTRACE)
+    # some file need to remove this cflag when CONFIG_FUNCTION_TRACER
+    # is not enabled, so we need to export it here
+    export CC_FLAGS_FTRACE
+  endif
 endif
 
 ifeq ($(CONFIG_KASAN_SW_TAGS), y)
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index bfe3ce9df197..aa3eaa91bf82 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -24,6 +24,16 @@
 #define FTRACE_PLT_IDX		0
 #define NR_FTRACE_PLTS		1
 
+#ifdef CONFIG_FUNCTION_METADATA
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+#define KFUNC_MD_DATA_OFFSET	(AARCH64_INSN_SIZE * 3)
+#else
+#define KFUNC_MD_DATA_OFFSET	AARCH64_INSN_SIZE
+#endif
+#define KFUNC_MD_INSN_SIZE	AARCH64_INSN_SIZE
+#define KFUNC_MD_INSN_OFFSET	KFUNC_MD_DATA_OFFSET
+#endif
+
 /*
  * Currently, gcc tends to save the link register after the local variables
  * on the stack. This causes the max stack tracer to report the function
@@ -216,6 +226,30 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
 	 */
 	return !strcmp(sym + 8, name);
 }
+
+#ifdef CONFIG_FUNCTION_METADATA
+#include <asm/text-patching.h>
+
+static inline bool kfunc_md_arch_exist(void *ip)
+{
+	return !aarch64_insn_is_nop(*(u32 *)(ip - KFUNC_MD_INSN_OFFSET));
+}
+
+static inline void kfunc_md_arch_pretend(u8 *insn, u32 index)
+{
+	*(u32 *)insn = index;
+}
+
+static inline void kfunc_md_arch_nops(u8 *insn)
+{
+	*(u32 *)insn = aarch64_insn_gen_nop();
+}
+
+static inline int kfunc_md_arch_poke(void *ip, u8 *insn)
+{
+	return aarch64_insn_patch_text_nosync(ip, *(u32 *)insn);
+}
+#endif
 #endif /* ifndef __ASSEMBLY__ */
 
 #ifndef __ASSEMBLY__
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index d7c0d023dfe5..4191ff0037f5 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -88,8 +88,10 @@ unsigned long ftrace_call_adjust(unsigned long addr)
 	 * to `BL <caller>`, which is at `addr + 4` bytes in either case.
 	 *
 	 */
-	if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
-		return addr + AARCH64_INSN_SIZE;
+	if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS)) {
+		addr += AARCH64_INSN_SIZE;
+		goto out;
+	}
 
 	/*
 	 * When using patchable-function-entry with pre-function NOPs, addr is
@@ -139,6 +141,13 @@ unsigned long ftrace_call_adjust(unsigned long addr)
 
 	/* Skip the first NOP after function entry */
 	addr += AARCH64_INSN_SIZE;
+out:
+	if (IS_ENABLED(CONFIG_FUNCTION_METADATA)) {
+		if (IS_ENABLED(CONFIG_FUNCTION_ALIGNMENT_8B))
+			addr += 2 * AARCH64_INSN_SIZE;
+		else
+			addr += AARCH64_INSN_SIZE;
+	}
 
 	return addr;
 }
-- 
2.39.5


