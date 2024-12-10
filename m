Return-Path: <bpf+bounces-46462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB99EA4E8
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 03:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54079188B76E
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 02:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9B1A0BD8;
	Tue, 10 Dec 2024 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQM8TROu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FF5D477;
	Tue, 10 Dec 2024 02:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796719; cv=none; b=SRc8Bak7HuaZEytmyh+jNsKRpBqUike300iQYEUX7SsGqg6Zev2lmHHF89C+8MQN9kS4Cu8uL6yp8MW8aAIwsN02WoEY2o6kgNU2HHRX5TTrrtD50oLghNWxlj5lsqbUwniCp3GBdJ7nn5NR5k+Qjd+WLGQMnuDdE6bBS/6OLEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796719; c=relaxed/simple;
	bh=d8qKogw4FwVtT5AaWwAaIMUXoL1iTSCq2y5iz4mmn+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKuVcXYgkMRxYhKdhE/02nPBuInaroyf0kRbIVQmbKlHftoIs7JVnHb03WM6dHpdnPinq04zNhxkmF8jmuty+8f2ZipaVuKl8jIHrxUNmYOFfpwErAAWyGgaK0aThmOC8UzkpjrJS+y3y6F33G88gMrdVSST8iXVlzzn0puPuHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQM8TROu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9612C4CED1;
	Tue, 10 Dec 2024 02:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733796718;
	bh=d8qKogw4FwVtT5AaWwAaIMUXoL1iTSCq2y5iz4mmn+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQM8TROuy+0QH7Xps1mYDyeZHPYbw9rq8yAjhkM0Tqf2nUeTBYb5yADrfmWh+8fqK
	 kULm8kazssojzcLOOuvdxV3Zwyid25/shDtJ9PlQkMZYH8Ed2l5GclcvK7+0gVq8Jc
	 DH2uOFQq5+DUuRGn1CRtgEILpvgqTq4BocfkAfBGjHeFqQpqC2Qa60jZzRPtu9Nryo
	 jWybTSKtfokV/Lm3PAHfDpHKZUaKO6NVtPleJYFU1qatyMG/k2LzZXo4M5eI5euiFJ
	 PzG+slyRcozQI0P1/VNQ53PL/TmoxAfY3Hu8Tn+qAlVQWGz0p2DdZM1Osn+Lp1HRO1
	 uzlemzUEe9G+g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arch@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
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
	Arnd Bergmann <arnd@arndb.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v21 14/20] fprobe: Add fprobe_header encoding feature
Date: Tue, 10 Dec 2024 11:11:49 +0900
Message-ID: <173379670913.973433.13073394222502227986.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173379652547.973433.2311391879173461183.stgit@devnote2>
References: <173379652547.973433.2311391879173461183.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

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
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 Changes in v19:
  - Fix to use Kbuild for generic arm/fprobe.h
  - Check CONFIG_64BIT in asm-generic/fprobe.h.
---
 arch/arm64/include/asm/Kbuild       |    1 +
 arch/loongarch/include/asm/fprobe.h |   12 +++++++++
 arch/riscv/include/asm/Kbuild       |    1 +
 arch/s390/include/asm/fprobe.h      |   10 ++++++++
 arch/x86/include/asm/Kbuild         |    1 +
 include/asm-generic/fprobe.h        |   46 +++++++++++++++++++++++++++++++++++
 kernel/trace/fprobe.c               |   29 ++++++++++++++++++++++
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


