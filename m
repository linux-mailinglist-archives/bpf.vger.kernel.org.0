Return-Path: <bpf+bounces-47670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 445B29FD566
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 16:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB76B165719
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995D41F8674;
	Fri, 27 Dec 2024 15:13:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6081F76C4;
	Fri, 27 Dec 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735312382; cv=none; b=mcfKiF31DZQCM1QUOoyrRtM2hbUU9TYt33eku3cfCQoTvqaAq7c8fYorT6AMDMk1MA930Vh+/FaG61AYlvoAShGxXJ5wCNmia8G72aAM/ic58xCgrVItcgr/z/A86jbc/nCG/HmzWM7ZtK+5DfHUgZnfRBRMrPIsKDrVYf7zVdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735312382; c=relaxed/simple;
	bh=lWoeBvfsF+pF9P5toGAj8CGQ3WxJILXODqq8czKNlQY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cPtwUuDzdRfoL5+1oF7XiLlZqQsGYrN1V4crmd3y+/dCq4lxFYKCp/ZuABXM08Nm10VQaFTIPb4e2kyMGcdTrdZ/PL3pU/CSQWVSWvkHm9Ee9xoz79RCW3ePHR/1d4j1qyq7QPpN8SAreM35bVidNID25C/bcdB6bz6PuVzpzzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789B6C4CEDD;
	Fri, 27 Dec 2024 15:13:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tRC2M-0000000GxYP-3vgh;
	Fri, 27 Dec 2024 10:14:02 -0500
Message-ID: <20241227151402.788088794@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 27 Dec 2024 10:13:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [for-next][PATCH 13/18] fprobe: Add fprobe_header encoding feature
References: <20241227151335.898746489@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Fprobe store its data structure address and size on the fgraph return stack
by __fprobe_header. But most 64bit architecture can combine those to
one unsigned long value because 4 MSB in the kernel address are the same.
With this encoding, fprobe can consume less space on ret_stack.

This introduces asm/fprobe.h to define arch dependent encode/decode
macros. Note that since fprobe depends on CONFIG_HAVE_FUNCTION_GRAPH_FREGS,
currently only arm64, loongarch, riscv, s390 and x86 are supported.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/173519005783.391279.5307910947400277525.stgit@devnote2
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/arm64/include/asm/Kbuild       |  1 +
 arch/loongarch/include/asm/fprobe.h | 12 ++++++++
 arch/riscv/include/asm/Kbuild       |  1 +
 arch/s390/include/asm/fprobe.h      | 10 +++++++
 arch/x86/include/asm/Kbuild         |  1 +
 include/asm-generic/fprobe.h        | 46 +++++++++++++++++++++++++++++
 kernel/trace/fprobe.c               | 29 ++++++++++++++++++
 7 files changed, 100 insertions(+)
 create mode 100644 arch/loongarch/include/asm/fprobe.h
 create mode 100644 arch/s390/include/asm/fprobe.h
 create mode 100644 include/asm-generic/fprobe.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 4e350df9a02d..d2ff8f6c3231 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -8,6 +8,7 @@ syscall-y += unistd_32.h
 syscall-y += unistd_compat_32.h
 
 generic-y += early_ioremap.h
+generic-y += fprobe.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
 generic-y += qrwlock.h
diff --git a/arch/loongarch/include/asm/fprobe.h b/arch/loongarch/include/asm/fprobe.h
new file mode 100644
index 000000000000..7af3b3126caf
--- /dev/null
+++ b/arch/loongarch/include/asm/fprobe.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LOONGARCH_FPROBE_H
+#define _ASM_LOONGARCH_FPROBE_H
+
+/*
+ * Explicitly undef ARCH_DEFINE_ENCODE_FPROBE_HEADER, because loongarch does not
+ * have enough number of fixed MSBs of the address of kernel objects for
+ * encoding the size of data in fprobe_header. Use 2-entries encoding instead.
+ */
+#undef ARCH_DEFINE_ENCODE_FPROBE_HEADER
+
+#endif /* _ASM_LOONGARCH_FPROBE_H */
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index de13d5a234f8..bd5fc9403295 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -4,6 +4,7 @@ syscall-y += syscall_table_64.h
 
 generic-y += early_ioremap.h
 generic-y += flat.h
+generic-y += fprobe.h
 generic-y += kvm_para.h
 generic-y += mmzone.h
 generic-y += mcs_spinlock.h
diff --git a/arch/s390/include/asm/fprobe.h b/arch/s390/include/asm/fprobe.h
new file mode 100644
index 000000000000..5ef600b372f4
--- /dev/null
+++ b/arch/s390/include/asm/fprobe.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_FPROBE_H
+#define _ASM_S390_FPROBE_H
+
+#include <asm-generic/fprobe.h>
+
+#undef FPROBE_HEADER_MSB_PATTERN
+#define FPROBE_HEADER_MSB_PATTERN 0
+
+#endif /* _ASM_S390_FPROBE_H */
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 6c23d1661b17..58f4ddecc5fa 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -10,5 +10,6 @@ generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
 
 generic-y += early_ioremap.h
+generic-y += fprobe.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
diff --git a/include/asm-generic/fprobe.h b/include/asm-generic/fprobe.h
new file mode 100644
index 000000000000..8659a4dc6eb6
--- /dev/null
+++ b/include/asm-generic/fprobe.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Generic arch dependent fprobe macros.
+ */
+#ifndef __ASM_GENERIC_FPROBE_H__
+#define __ASM_GENERIC_FPROBE_H__
+
+#include <linux/bits.h>
+
+#ifdef CONFIG_64BIT
+/*
+ * Encoding the size and the address of fprobe into one 64bit entry.
+ * The 32bit architectures should use 2 entries to store those info.
+ */
+
+#define ARCH_DEFINE_ENCODE_FPROBE_HEADER
+
+#define FPROBE_HEADER_MSB_SIZE_SHIFT (BITS_PER_LONG - FPROBE_DATA_SIZE_BITS)
+#define FPROBE_HEADER_MSB_MASK					\
+	GENMASK(FPROBE_HEADER_MSB_SIZE_SHIFT - 1, 0)
+
+/*
+ * By default, this expects the MSBs in the address of kprobe is 0xf.
+ * If any arch needs another fixed pattern (e.g. s390 is zero filled),
+ * override this.
+ */
+#define FPROBE_HEADER_MSB_PATTERN				\
+	GENMASK(BITS_PER_LONG - 1, FPROBE_HEADER_MSB_SIZE_SHIFT)
+
+#define arch_fprobe_header_encodable(fp)			\
+	(((unsigned long)(fp) & ~FPROBE_HEADER_MSB_MASK) ==	\
+	 FPROBE_HEADER_MSB_PATTERN)
+
+#define arch_encode_fprobe_header(fp, size)			\
+	(((unsigned long)(fp) & FPROBE_HEADER_MSB_MASK) |	\
+	 ((unsigned long)(size) << FPROBE_HEADER_MSB_SIZE_SHIFT))
+
+#define arch_decode_fprobe_header_size(val)			\
+	((unsigned long)(val) >> FPROBE_HEADER_MSB_SIZE_SHIFT)
+
+#define arch_decode_fprobe_header_fp(val)					\
+	((struct fprobe *)(((unsigned long)(val) & FPROBE_HEADER_MSB_MASK) |	\
+			   FPROBE_HEADER_MSB_PATTERN))
+#endif /* CONFIG_64BIT */
+
+#endif /* __ASM_GENERIC_FPROBE_H__ */
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index ed9c1d79426a..2560b312ad57 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -13,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/sort.h>
 
+#include <asm/fprobe.h>
+
 #include "trace.h"
 
 #define FPROBE_IP_HASH_BITS 8
@@ -143,6 +145,31 @@ static int del_fprobe_hash(struct fprobe *fp)
 	return 0;
 }
 
+#ifdef ARCH_DEFINE_ENCODE_FPROBE_HEADER
+
+/* The arch should encode fprobe_header info into one unsigned long */
+#define FPROBE_HEADER_SIZE_IN_LONG	1
+
+static inline bool write_fprobe_header(unsigned long *stack,
+					struct fprobe *fp, unsigned int size_words)
+{
+	if (WARN_ON_ONCE(size_words > MAX_FPROBE_DATA_SIZE_WORD ||
+			 !arch_fprobe_header_encodable(fp)))
+		return false;
+
+	*stack = arch_encode_fprobe_header(fp, size_words);
+	return true;
+}
+
+static inline void read_fprobe_header(unsigned long *stack,
+					struct fprobe **fp, unsigned int *size_words)
+{
+	*fp = arch_decode_fprobe_header_fp(*stack);
+	*size_words = arch_decode_fprobe_header_size(*stack);
+}
+
+#else
+
 /* Generic fprobe_header */
 struct __fprobe_header {
 	struct fprobe *fp;
@@ -173,6 +200,8 @@ static inline void read_fprobe_header(unsigned long *stack,
 	*size_words = fph->size_words;
 }
 
+#endif
+
 /*
  * fprobe shadow stack management:
  * Since fprobe shares a single fgraph_ops, it needs to share the stack entry
-- 
2.45.2



