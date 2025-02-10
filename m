Return-Path: <bpf+bounces-50958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EF1A2E9C7
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 11:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624BC3A453F
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69881CC8AE;
	Mon, 10 Feb 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGzNQzfA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85401C7002;
	Mon, 10 Feb 2025 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184119; cv=none; b=PzLlNuCKY7u1E4ow25YNv4wj9LLVu0Iw7nKjdEtECSBGSnMniSCT6vuQFV/WzRwpS6BMTObLI5PCuIT9a8eUwKXAQw26p7kNF5ZtB/uc1fR4IHL7eutuC6zxIbJoh8o/YomnIrTJCDradt8gnfC0o5cRlDA3mLnERtux2m6PuL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184119; c=relaxed/simple;
	bh=d/kqbVhtHfEkOC9vPeOy1p5THSL8CklFa2zk808j+D0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0qzeED/wmIUu3sHk6QrRHbRLMwzzaKCfPC6nNyiJ8pIMEXwu3gfiHtxZv4n0aD/mIBL4emKN3q/HX8ZaXwJI+IJvItWdOPtjJvjfOdXZTxwxCkYYV7klk7aOyAvfcwZar4FstukD450OJ0kfk34V9EmKwFHtdxhZewSMd60yhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGzNQzfA; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-21f49bd087cso51576055ad.0;
        Mon, 10 Feb 2025 02:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739184117; x=1739788917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i2bBBre6zpa2JK4ICNO/p1Io5EET0F0HrhRvCCTr82Y=;
        b=KGzNQzfAlXm6akrZV+W0B682s7rk7rE8b1icRWy2GUJI+mTWTRLbtPoElHFzNa2Mtr
         yJUlQ6gWd6MsEHECJUlxZ9Z/QPoUFICKRIQt3je8vPGHnr40WyCGsaHMYIq6TVOzMahE
         if0xoFHo+lXBLDBy776rgsj3dh4p77a6IFvbDc9LoJSZ+wwA1d6ug430Oa+V4LV9IdS1
         EPZb3QmtltpgyDTv0lZVxr6VBv+mk1XsR6kCK9lMdOP5Cpl3k10dpPqgGKeCJbdOl1Vr
         uZrReOLCHl9IZTRR3pZEhRNlhfQUMQnL+Mxt225e1uD3Wb6ghd83TuJR1NthHcdHBgkI
         nW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739184117; x=1739788917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2bBBre6zpa2JK4ICNO/p1Io5EET0F0HrhRvCCTr82Y=;
        b=cFBdp+U0U801A49CsUNdA1spndHH/6bawKpFK25CNS3MfD4+lEtgT3n+1Len+frahJ
         r3R4jOgHPoeoO8NQR2WtkmzO3FeEUvPIWW4SxG73AFmSAPmN8yPFaxsV9q5e939b7H7J
         3fgGWDytIQUDCdql21uN+o/PAUbugddOh1dTyZv9Zgm7pp7hd9rPmKjPMuQHoD4j6PSS
         tj+2xzZk5LGrPCtsFtpbDnOdpqj9RBvaQZRWLdDKxaJqtKxUpNOfe/7WX7Rnt0fqs8Go
         TbgEoeUcRC8GaY5ZeW0fjOUlriB7lYRrRW94G8JXC21hw3pVsPxfTigyJdCY0rzzzTwL
         hyNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVronBb1Ah2Fu3ADLuzAT3UJvaHx17zVZVqqd5rvGLyfNNLXDQC5KnCMM8t5LhofpJ5NKU=@vger.kernel.org, AJvYcCW+EPVZrtMjHUBUm6QerZ0TZYVQTYbY+fJ5WsDIVWR3h889Ph3ThbizkhFtwzhnQ5z2MzObweJSL0NKsc2p@vger.kernel.org, AJvYcCWLXTrWVaiUle3lCWESfzzWtE1eoYn8ro+LohJem2+hn5n80lZlnuQFK9pw4z6eElTpnBL+15i304zZQtuKVNIBQRzN@vger.kernel.org
X-Gm-Message-State: AOJu0YzSaet5gjE+C0xQQKIAXv2uOF8ZfCr1BnQzkZc/JXEA1X+K/WBY
	JuYVpw05q/u5Oip90CZrZUpo4KZHsibx1WeY58OlUyv9uQrpjBfd
X-Gm-Gg: ASbGncuJXR9qlll7FrylqlJWMxsbjTQwPb/HOfP9NnyKvYvl86/WTfkK62ZCGVjOhKt
	LIMeimmHJmMxCwyN7PnuvgeO9IZPH5teaNTaPxPwiuup2qnffG0IhZht4JWOnYTw1Ptt7ikTzlm
	xdb7+dIwmkHJ0ni5K2IhRifGY/6u02keMDSs+/1h6av0hXUER0tHIAxi1auUI+uVUy/b0NqlZ9h
	ntJ6PUqtHqYDb5JAut6drx0XE1v63yZa+SqJZkxaZvZ2PlBC65rKebUKxtg4B4PYK7Lj4VhxZmF
	dJZC9e7V5MaZ8M+wsQmRsn+s1wIU2RUx
X-Google-Smtp-Source: AGHT+IHBB8yyfqDeXCkpl6QzEP7yzAbBfsca3MOOwusHs/aJskZSfvD6+N+zdcAfGFV0AQGhvcP78g==
X-Received: by 2002:a17:903:41c4:b0:21f:5933:b3eb with SMTP id d9443c01a7336-21f5933b4demr167406765ad.31.1739184116767;
        Mon, 10 Feb 2025 02:41:56 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ceaasm75611965ad.27.2025.02.10.02.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 02:41:56 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	x86@kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	dongml2@chinatelecom.cn,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC PATCH] x86: add function metadata support
Date: Mon, 10 Feb 2025 18:40:34 +0800
Message-Id: <20250210104034.146273-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_CALL_PADDING enabled, there will be 16-bytes(or more) padding
space before all the kernel functions. And some kernel features can use
it, such as MITIGATION_CALL_DEPTH_TRACKING, CFI_CLANG, FINEIBT, etc.

In this commit, we add supporting to store per-function metadata in the
function padding, and previous discussion can be found in [1]. Generally
speaking, we have two way to implement this feature:

1. create a function metadata array, and prepend a 5-bytes insn
"mov %eax, 0x12345678", and store the insn to the function padding.
And 0x12345678 means the index of the function metadata in the array.
By this way, 5-bytes will be consumed in the function padding.

2. prepend a 10-bytes insn "mov %rax, 0x12345678aabbccdd" and store
the insn to the function padding, and 0x12345678aabbccdd means the address
of the function metadata.

Compared with way 2, way 1 consume less space, but we need to do more work
on the global function metadata array. And in this commit, we implemented
the way 1.

In my research, MITIGATION_CALL_DEPTH_TRACKING will consume the tail
9-bytes in the function padding, and FINEIBT+CFI_CLANG will consume
the head 7-bytes. So there will be no space for us if
MITIGATION_CALL_DEPTH_TRACKING and CFI_CLANG are both enabled. So I have
following logic:
1. use the head 5-bytes if CFI_CLANG is not enabled
2. use the tail 5-bytes if MITIGATION_CALL_DEPTH_TRACKING is not enabled
3. compile the kernel with extra 5-bytes padding if
   MITIGATION_CALL_DEPTH_TRACKING and CFI_CLANG are both enabled.

In the third case, we compile the kernel with a function padding of
21-bytes, which means the real function is not 16-bytes aligned any more.
And in [2], I tested the performance of the kernel with different padding,
and it seems that extra 5-bytes don't have impact on the performance.
However, it's a huge change to make the kernel function unaligned in
16-bytes, and I'm sure if there are any other influence. So another choice
is to compile the kernel with 32-bytes aligned if there is no space
available for us in the function padding. But this will increase the text
size ~5%. (And I'm not sure with method to use.)

The beneficiaries of this feature can be BPF and ftrace. For BPF, we can
implement a "dynamic trampoline" and add tracing multi-link supporting
base on this feature. And for ftrace, we can optimize its performance
base on this feature.

This commit is not complete, as the synchronous of func_metas is not
considered :/

Link: https://lore.kernel.org/bpf/CADxym3anLzM6cAkn_z71GDd_VeKiqqk1ts=xuiP7pr4PO6USPA@mail.gmail.com/ [1]
Link: https://lore.kernel.org/bpf/CADxym3af+CU5Mx8myB8UowdXSc3wJOqWyH4oyq+eXKahXBTXyg@mail.gmail.com/ [2]
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/Kconfig          |  15 ++++
 arch/x86/Makefile         |  17 ++--
 include/linux/func_meta.h |  17 ++++
 kernel/trace/Makefile     |   1 +
 kernel/trace/func_meta.c  | 184 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 228 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/func_meta.h
 create mode 100644 kernel/trace/func_meta.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6df7779ed6da..0ff3cb74cfc0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2510,6 +2510,21 @@ config PREFIX_SYMBOLS
 	def_bool y
 	depends on CALL_PADDING && !CFI_CLANG
 
+config FUNCTION_METADATA
+	bool "Enable function metadata support"
+	select CALL_PADDING
+	default y
+	help
+	  This feature allow us to set metadata for kernel functions, and
+	  get the metadata of the function by its address without any
+	  costing.
+
+	  The index of the metadata will be stored in the function padding,
+	  which will consume 5-bytes. The spare space of the padding
+	  is enough for us with CALL_PADDING and FUNCTION_ALIGNMENT_16B if
+	  CALL_THUNKS or CFI_CLANG not enabled. Or, we need extra 5-bytes
+	  in the function padding, which will increases text ~1%.
+
 menuconfig CPU_MITIGATIONS
 	bool "Mitigations for CPU vulnerabilities"
 	default y
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5b773b34768d..05689c9a8942 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -240,13 +240,18 @@ ifdef CONFIG_MITIGATION_SLS
 endif
 
 ifdef CONFIG_CALL_PADDING
-PADDING_CFLAGS := -fpatchable-function-entry=$(CONFIG_FUNCTION_PADDING_BYTES),$(CONFIG_FUNCTION_PADDING_BYTES)
-KBUILD_CFLAGS += $(PADDING_CFLAGS)
-export PADDING_CFLAGS
+  __padding_bytes := $(CONFIG_FUNCTION_PADDING_BYTES)
+  ifneq ($(and $(CONFIG_FUNCTION_METADATA),$(CONFIG_CALL_THUNKS),$(CONFIG_CFI_CLANG)),)
+    __padding_bytes := $(shell echo $(__padding_bytes) + 5 | bc)
+  endif
+
+  PADDING_CFLAGS := -fpatchable-function-entry=$(__padding_bytes),$(__padding_bytes)
+  KBUILD_CFLAGS += $(PADDING_CFLAGS)
+  export PADDING_CFLAGS
 
-PADDING_RUSTFLAGS := -Zpatchable-function-entry=$(CONFIG_FUNCTION_PADDING_BYTES),$(CONFIG_FUNCTION_PADDING_BYTES)
-KBUILD_RUSTFLAGS += $(PADDING_RUSTFLAGS)
-export PADDING_RUSTFLAGS
+  PADDING_RUSTFLAGS := -Zpatchable-function-entry=$(__padding_bytes),$(__padding_bytes)
+  KBUILD_RUSTFLAGS += $(PADDING_RUSTFLAGS)
+  export PADDING_RUSTFLAGS
 endif
 
 KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
diff --git a/include/linux/func_meta.h b/include/linux/func_meta.h
new file mode 100644
index 000000000000..840cbd858c47
--- /dev/null
+++ b/include/linux/func_meta.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FUNC_META_H
+#define _LINUX_FUNC_META_H
+
+#include <linux/kernel.h>
+
+struct func_meta {
+	int users;
+	void *func;
+};
+
+extern struct func_meta *func_metas;
+
+struct func_meta *func_meta_get(void *ip);
+void func_meta_put(void *ip, struct func_meta *meta);
+
+#endif
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 057cd975d014..4042c168dcfc 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
 obj-$(CONFIG_FPROBE) += fprobe.o
 obj-$(CONFIG_RETHOOK) += rethook.o
 obj-$(CONFIG_FPROBE_EVENTS) += trace_fprobe.o
+obj-$(CONFIG_FUNCTION_METADATA) += func_meta.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 obj-$(CONFIG_RV) += rv/
diff --git a/kernel/trace/func_meta.c b/kernel/trace/func_meta.c
new file mode 100644
index 000000000000..9ce77da81e71
--- /dev/null
+++ b/kernel/trace/func_meta.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/slab.h>
+#include <linux/memory.h>
+#include <linux/func_meta.h>
+#include <linux/text-patching.h>
+
+#define FUNC_META_INSN_SIZE	5
+
+#ifdef CONFIG_CFI_CLANG
+  #ifdef CONFIG_CALL_THUNKS
+    /* use the extra 5-bytes that we reserve */
+    #define FUNC_META_INSN_OFFSET	(CONFIG_FUNCTION_PADDING_BYTES + 5)
+    #define FUNC_META_DATA_OFFSET	(CONFIG_FUNCTION_PADDING_BYTES + 4)
+  #else
+    /* use the space that CALL_THUNKS suppose to use */
+    #define FUNC_META_INSN_OFFSET	(5)
+    #define FUNC_META_DATA_OFFSET	(4)
+  #endif
+#else
+  /* use the space that CFI_CLANG support to use */
+  #define FUNC_META_INSN_OFFSET	(CONFIG_FUNCTION_PADDING_BYTES)
+  #define FUNC_META_DATA_OFFSET	(CONFIG_FUNCTION_PADDING_BYTES - 1)
+#endif
+
+static u32 func_meta_count = 32, func_meta_used;
+struct func_meta *func_metas;
+EXPORT_SYMBOL_GPL(func_metas);
+
+static DEFINE_MUTEX(func_meta_lock);
+
+static u32 func_meta_get_index(void *ip)
+{
+	return *(u32 *)(ip - FUNC_META_DATA_OFFSET);
+}
+
+static bool func_meta_exist(void *ip)
+{
+	return *(u8 *)(ip - FUNC_META_INSN_OFFSET) == 0xB8;
+}
+
+static void func_meta_init(struct func_meta *metas, u32 start, u32 end)
+{
+	u32 i;
+
+	for (i = start; i < end; i++)
+		metas[i].users = 0;
+}
+
+/* get next usable function metadata */
+static struct func_meta *func_meta_get_next(u32 *index)
+{
+	struct func_meta *tmp;
+	u32 i;
+
+	if (func_metas == NULL) {
+		func_metas = kmalloc_array(func_meta_count, sizeof(*tmp),
+					   GFP_KERNEL);
+		if (!func_metas)
+			return NULL;
+		func_meta_init(func_metas, 0, func_meta_count);
+	}
+
+	/* maybe we can manage the used function metadata entry with a bit
+	 * map ?
+	 */
+	for (i = 0; i < func_meta_count; i++) {
+		if (!func_metas[i].users) {
+			func_meta_used++;
+			*index = i;
+			func_metas[i].users++;
+			return func_metas + i;
+		}
+	}
+
+	tmp = kmalloc_array(func_meta_count * 2, sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return NULL;
+
+	memcpy(tmp, func_metas, func_meta_count * sizeof(*tmp));
+	kfree(func_metas);
+
+	/* TODO: we need a way to update func_metas synchronously, RCU ? */
+	func_metas = tmp;
+	func_meta_init(func_metas, func_meta_count, func_meta_count * 2);
+
+	tmp += func_meta_count;
+	*index = func_meta_count;
+	func_meta_count <<= 1;
+	func_meta_used++;
+	tmp->users++;
+
+	return tmp;
+}
+
+static int func_meta_text_poke(void *ip, u32 index, bool nop)
+{
+	const u8 nop_insn[FUNC_META_INSN_SIZE] = { BYTES_NOP1, BYTES_NOP1,
+						   BYTES_NOP1, BYTES_NOP1,
+						   BYTES_NOP1 };
+	u8 insn[FUNC_META_INSN_SIZE] = { 0xB8, };
+	const u8 *prog;
+	void *target;
+	int ret = 0;
+
+	target = ip - FUNC_META_INSN_OFFSET;
+	mutex_lock(&text_mutex);
+	if (nop) {
+		if (!memcmp(target, nop_insn, FUNC_META_INSN_SIZE))
+			goto out;
+		prog = nop_insn;
+	} else {
+		*(u32 *)(insn + 1) = index;
+		if (!memcmp(target, insn, FUNC_META_INSN_SIZE))
+			goto out;
+
+		if (memcmp(target, nop_insn, FUNC_META_INSN_SIZE)) {
+			ret = -EBUSY;
+			goto out;
+		}
+		prog = insn;
+	}
+	text_poke(target, prog, FUNC_META_INSN_SIZE);
+	text_poke_sync();
+out:
+	mutex_unlock(&text_mutex);
+	return ret;
+}
+
+static void __func_meta_put(void *ip, struct func_meta *meta)
+{
+	if (WARN_ON_ONCE(meta->users <= 0))
+		return;
+
+	meta->users--;
+	if (meta->users > 0)
+		return;
+
+	/* TODO: we need a way to shrink the array "func_metas" */
+	func_meta_used--;
+	if (!func_meta_exist(ip))
+		return;
+
+	func_meta_text_poke(ip, 0, true);
+}
+
+void func_meta_put(void *ip, struct func_meta *meta)
+{
+	mutex_lock(&func_meta_lock);
+	__func_meta_put(ip, meta);
+	mutex_unlock(&func_meta_lock);
+}
+EXPORT_SYMBOL_GPL(func_meta_put);
+
+struct func_meta *func_meta_get(void *ip)
+{
+	struct func_meta *tmp = NULL;
+	u32 index;
+
+	mutex_lock(&func_meta_lock);
+	if (func_meta_exist(ip)) {
+		index = func_meta_get_index(ip);
+		if (WARN_ON_ONCE(index >= func_meta_count))
+			goto out;
+
+		tmp = &func_metas[index];
+		tmp->users++;
+		goto out;
+	}
+
+	tmp = func_meta_get_next(&index);
+	if (!tmp)
+		goto out;
+
+	if (func_meta_text_poke(ip, index, false)) {
+		__func_meta_put(ip, tmp);
+		goto out;
+	}
+	tmp->func = ip;
+out:
+	mutex_unlock(&func_meta_lock);
+	return tmp;
+}
+EXPORT_SYMBOL_GPL(func_meta_get);
-- 
2.39.5


