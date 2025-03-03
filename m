Return-Path: <bpf+bounces-53020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DB0A4B806
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 07:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 357D77A4D81
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 06:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4D31EEA3B;
	Mon,  3 Mar 2025 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGUEjYfT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D81E9B25;
	Mon,  3 Mar 2025 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740984975; cv=none; b=es9ALGMy1XDRAXAZhhctwht/s8Z/r98DbF7R3rvPVMRBUJsufNqnatRND0QTcX4YwK6nYIjmaymHUZfsZK1aW9NHKcukGRnptuhPVaShMVf6rfDq+F+47UEPpypF/dOVrQf2nWp8w00pxM8kJl99+D3Ij+gn62Jm2T7rBIWNb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740984975; c=relaxed/simple;
	bh=8+jQ2LOFLvD8yNjmgsq7xpDv7f8F3syKUpRlLU8kRU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJ3P0Rd4yItYta6SlFK0zUJSHWSErFCamTftZFdn4KzlLXAYBU/Y53p97he4ciQtPGJt7Wp2tbYm3+fL8g8UPy9a0Mo7O8hR3X43V0LnktdA7CzvxncJVBszKfZWT0hMdgV+DKRkt1GK6Owot+eBlVN42MPZ1jvfR1mHHzxQ1fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGUEjYfT; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2234e4b079cso71473705ad.1;
        Sun, 02 Mar 2025 22:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740984972; x=1741589772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvSQXTXm2WJtvrSSulKAAYVeipdazZIwWA04KeDmP3s=;
        b=cGUEjYfT88miiKVGNn/JCoptAo9F87JQHbzUoMe6ahICREMT55MSaAAKZX6k+qnQLz
         3cxIweuKGuPJYVjc68XVCTR/8mSIpbBahs3GjEoODIB69JILDSP79h0kk3Jc/2rnWHEP
         0DgN0TcOZ/yzoMlFvHZ0S72x7oTF3YdjD/EGjEcyL3Bz/t9C7g+FKXvPdMncuS1H7bNy
         eWUR4ss9ZRiDJfLmpA/tBDkVXHvVj+lrrj6N3j93oVeW5AGaJl1ZONoShajwuMyijEwZ
         S7iDXAzC3MWNy0eHmDXcNCaxGUKCzu2WxNnAfZqQHiGf8BCdpz0/Zan7yxwmZWEpIADX
         Nthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740984972; x=1741589772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvSQXTXm2WJtvrSSulKAAYVeipdazZIwWA04KeDmP3s=;
        b=PA0fBMrRNh7rrjIa2K4J1UVCM5ZWI7Lbr9gXjWmnEfnoRkLkpSysPT5Qm7h7PvscVD
         bopoMMt0DMEk8jNffjqLZgoLuFJMfkjwWjcdSCRq3lxb3p4ddqp4Y2js8lGog1kvj1Ch
         takFIWKEGJ2mWDlXXyjAo9r8WrvpNWlLhv9eShWpJimHHzRAPiBZgu4nlwTN59/ITIgT
         KrbsflT2AbLnKXOsVc+fHo5VxQO8JmzPbSAPGn+Z0HWWj0spMoTYAQTCL4o6x498vsg+
         jQdxtDngxZ4+el7R8BOLt4gbwbmJxgaUEDbJzOhmEgFnHaGbxANzJK9U8v4NuOYhnUoC
         fvrw==
X-Forwarded-Encrypted: i=1; AJvYcCU6oZUmR9aiVatwNVUQPo75W2P+mWtdCD4N5K2HjQBQmEf8Pys/+2bJXT2S1aJwG+2o2NqMyJqxA3cNvU8V@vger.kernel.org, AJvYcCUnM9BX/QpQ77esQrIFPufogqvrtBR1TM5dQuMnZ5nXBptFTzgZ6bG0MFp5LVuaQKbQW2U=@vger.kernel.org, AJvYcCWQJbPMTc/oK8gexB6k1bz0ao7HLQ0Qc4sEfjkhFG+n1IS9MOmymBQzNlXfFmLdEBjmbm+ooKoQI5UAEMVFQqVYs6Bk@vger.kernel.org, AJvYcCWWVObil1JgWvEbolMA0DWYpflV6IazZyMtPiLsaRrjwXdcQDeKp5Bh6GPLrxC/cBguoH5IfJe5@vger.kernel.org
X-Gm-Message-State: AOJu0YwezXGD0pVM9H1FE+FXws5HkBWptVBk6DXB99ND7fKinhGmRJN0
	rUln9QgefTGOdW7rybJcrZlI1g1TSAFi0Dpgt28GZ1YkhwfwIlut
X-Gm-Gg: ASbGncuaBv759bAGFrv5tshBn/sYLQMkwlMKve9M6uUg6OVUlupZ9NWn2o6kYXXNWuo
	DwhYz5HKcYGP5q54g43G3bGk9hA6pjY3Y2TSTX+F1VsmHCKUFTsCE90tSn3U7h7uRIjW6iJXyRO
	XWNmuR/BgU6hTgdbi4943+PIXGNu3PIYyDkwCltZF3cmgLI1zFdBB1OFmZudeg7n88Y7HiMtqAz
	FonK6WAD8flfqhDm4iae65P9fFjWraZUlG+M9x3XRMDo2awFWf+IU0Ut1iz5d66w2JSErDIyNbP
	xKqOkj9b4O2gFJJDDajRvw/tZhn7SizeS7DC1FYqF/mvv/wapqV40cQNazQ3hQ==
X-Google-Smtp-Source: AGHT+IHD7TOQHXPnvhY3fUJExGRRx5jR57Vtr+fKvMEWMLLg1ZWvH9nc0mv2BX9j9PlmWnQhBjDbsg==
X-Received: by 2002:a17:903:3b83:b0:21f:6c3:aefb with SMTP id d9443c01a7336-2236920c418mr195671705ad.35.1740984972122;
        Sun, 02 Mar 2025 22:56:12 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea6769ad2sm8139575a91.11.2025.03.02.22.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 22:56:11 -0800 (PST)
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
Subject: [PATCH bpf-next v3 4/4] arm64: implement per-function metadata storage for arm64
Date: Mon,  3 Mar 2025 14:53:45 +0800
Message-Id: <20250303065345.229298-5-dongml2@chinatelecom.cn>
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


