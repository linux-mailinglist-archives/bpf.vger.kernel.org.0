Return-Path: <bpf+bounces-59091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1553AC6049
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C25D7B129C
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8CE1F463E;
	Wed, 28 May 2025 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDTDdCqe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC07B1EF36B;
	Wed, 28 May 2025 03:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404186; cv=none; b=NxK8PYuHsWNMI/m7wYEZODOqzzIc0+Bpjpvrzh/zh5JKzRARoMi7KGh5OLErUv6KMLuSGSQUFJyOgaWtTCPtph5qbVGhEaZLg7/lHh4AVE05VNzFbI28GWv9bxsbB0kUDmUcPmyEAiTisJbic8Q5HW0l5PUYBssCOONMT1jF/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404186; c=relaxed/simple;
	bh=PzcQU/jU8BoBn8QTc/rCoOpUq8QKomNni3rt844DF8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PAKugwmchozDIeHOgoprMEDkOAw0gekr0snv+WyE850NAmu6rqAqBZmvv8z1iTOVfgAB714KDOMMYiZoj+KIpnSQr+UMONGZ0jG/eQVeye+tYtneBjqITpKqzAQ7WqkL2Av21gBpPfZUPBFUhpH4EHOQcMfgwa/NjyVuWA4gu7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDTDdCqe; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-234ade5a819so11268865ad.1;
        Tue, 27 May 2025 20:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404183; x=1749008983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYPTFZRK7Anqseg021BaLIF06orSQsH0yc5V0T15hTo=;
        b=mDTDdCqefiPSvRnwve7/gZS7seJXwqsqOIfAc9gnk8itF2ttwdAHaty32ezClRMe/P
         xt3WUrd8gNzNEkXaTfyqrs0mPixGHaIj5V7JZb7IRVnqAHPxv8NvovKsbSYy8KZBoSDX
         cgzFud8qgWV21LWJbERsdCr0obQBGSbEUftmVQIOTDV1ZoFPFvRF+JJA2NPum25YOfzy
         EuNb1cvxdhh3LTdeG2CNZ51+76hKZ2WXXOOfmVLgARXaKO3HZxA48Ny5LlSyiMlx1os2
         Ta2x1ouEpmdPRsWpZY7bHIOv+1RfrOdVSgUEfxAOphNo2DxUFl8e5hYuY6qHjZdF0xH4
         IQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404183; x=1749008983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYPTFZRK7Anqseg021BaLIF06orSQsH0yc5V0T15hTo=;
        b=pTHZMzTdkc3fIWXjHcTsvPy2JuxanVq10tEr4WB8aabvdFV+3SZshyiE2IWKVaJI5B
         IJ7c+/SF9uYy85PuAMzl0y8mQIsqLD16OT3yAwWrvlOFcVlGmSkOXVMWNh8SexUqmLSQ
         rr7JxkISkKfbxnFjCMdTGY5V3EpwJdGMOAO6pHEmJIxGjzFVvQvbtp5uWh9tReluZPzC
         bjrKa5rr7C0/SCDBDP5ftfOGV3CS3HApY6Q0H+lqrne0rzbXvmLAfv/BX63e1x4yN1rX
         lrOsV2d2Bp3DQ+8FgswKSf/OXEmAyErRq+xw14n65CZweXsmS3ImKolCxYIEVnRiUbK4
         OhoA==
X-Forwarded-Encrypted: i=1; AJvYcCWP3gkxaeuWzLpCj2mtDwHoAhrXT6TsFH8Q6ue2nzYbSNnu17Pcg21/093XMUTmCaDQf7S+7UTv3sFdfHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8drU/oTb5a64qbafCAlEgKgsTWhvupM10TfRVj0iW3QD79q5P
	AunZNMLBWv9/iNq9iEaekm5s2FA81+ynFX+DZ74SDUt2CANvy3uwZsR7
X-Gm-Gg: ASbGnctcJPcwg+KUk4gicdK9jC5KAwjvYrTaZYVhdMkrHeytbib9CSV1lcD060kdWD3
	DhEszU5kxIVUTWl4VWKLqRskfuX6SGHbg84w9UrBCeF+kLkbsb47gl/2+BgmL1yNgJ36qQZT72N
	wrcTY/wXN85Bd7MR9EpWCoLyr7UVpiTAa9CBQUzl9zfHLJNs6bPvht+yWxU6NoAdN5REd8BxdAx
	y3uBhHsGyVavi4cdb+Lg2mmUeBXmQR1ujfREUxA9dSw2HObjPKIElkuE4TYF/TRcS6CRGirE1p3
	PBuTdEhYNAvapZrl5XyPoQcyFDKsLwG0kGgDE0j2VkLTJFYziMcg6EenxD0Hn4On/XqL
X-Google-Smtp-Source: AGHT+IHZdGdpsTzeRfx9xKiCMkdWV+5vKYFIU4x8VuwMZsmqeTu/rcGsgPCx9pnheEwC+vB2FDl/Fw==
X-Received: by 2002:a17:902:e842:b0:22e:4a2e:8ae7 with SMTP id d9443c01a7336-23414f7d0ebmr288136065ad.22.1748404183038;
        Tue, 27 May 2025 20:49:43 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:49:42 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 03/25] arm64: implement per-function metadata storage for arm64
Date: Wed, 28 May 2025 11:46:50 +0800
Message-Id: <20250528034712.138701-4-dongml2@chinatelecom.cn>
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

The per-function metadata storage is already used by ftrace if
CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS is enabled, and it store the pointer
of the callback directly to the function padding, which consume 8-bytes,
in the commit
baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS").
So we can directly store the index to the function padding too, without
a prepending. With CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS enabled, the
function is 8-bytes aligned, and we will compile the kernel with extra
8-bytes (2 NOPS) padding space. Otherwise, the function is 4-bytes
aligned, and only extra 4-bytes (1 NOPS) is needed for us.

However, we have the same problem with Mark in the commit above: we can't
use the function padding together with CFI_CLANG, which can make the clang
compiles a wrong offset to the pre-function type hash. So we fallback to
the hash table mode for function metadata if CFI_CLANG is enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/arm64/Kconfig              | 21 ++++++++++++++++++++
 arch/arm64/Makefile             | 23 ++++++++++++++++++++--
 arch/arm64/include/asm/ftrace.h | 34 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ftrace.c      | 13 +++++++++++--
 4 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a182295e6f08..db504df07072 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1549,6 +1549,27 @@ config NODES_SHIFT
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
 
+config FUNCTION_METADATA
+	bool "Per-function metadata storage support"
+	default y
+	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE if !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
+	depends on !CFI_CLANG
+	help
+	  Support function padding based per-function metadata storage for
+	  kernel functions, and get the metadata of the function by its
+	  address with almost no overhead.
+
+	  The index of the metadata will be stored in the function padding,
+	  which will consume 4-bytes. If FUNCTION_ALIGNMENT_8B is enabled,
+	  extra 8-bytes function padding will be reserved during compiling.
+	  Otherwise, only extra 4-bytes function padding is needed.
+
+	  Hash table based function metadata will be used if this option
+	  is not enabled.
+
+config FUNCTION_METADATA_PADDING
+	def_bool FUNCTION_METADATA
+
 source "kernel/Kconfig.hz"
 
 config ARCH_SPARSEMEM_ENABLE
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 1d5dfcd1c13e..576d6ab94dc5 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -144,12 +144,31 @@ endif
 
 CHECKFLAGS	+= -D__aarch64__
 
+ifeq ($(CONFIG_FUNCTION_METADATA_PADDING),y)
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
+else ifeq ($(CONFIG_FUNCTION_METADATA_PADDING),y)
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
index bfe3ce9df197..9aafb3103829 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -24,6 +24,16 @@
 #define FTRACE_PLT_IDX		0
 #define NR_FTRACE_PLTS		1
 
+#ifdef CONFIG_FUNCTION_METADATA_PADDING
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
+#ifdef CONFIG_FUNCTION_METADATA_PADDING
+#include <asm/text-patching.h>
+
+static inline bool kfunc_md_arch_exist(unsigned long ip, int insn_offset)
+{
+	return !aarch64_insn_is_nop(*(u32 *)(ip - insn_offset));
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
+static inline int kfunc_md_arch_poke(void *ip, u8 *insn, int insn_offset)
+{
+	return aarch64_insn_patch_text_nosync(ip, *(u32 *)insn);
+}
+#endif
 #endif /* ifndef __ASSEMBLY__ */
 
 #ifndef __ASSEMBLY__
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 5a890714ee2e..869946dabdd0 100644
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
+	if (IS_ENABLED(CONFIG_FUNCTION_METADATA_PADDING)) {
+		if (IS_ENABLED(CONFIG_FUNCTION_ALIGNMENT_8B))
+			addr += 2 * AARCH64_INSN_SIZE;
+		else
+			addr += AARCH64_INSN_SIZE;
+	}
 
 	return addr;
 }
-- 
2.39.5


