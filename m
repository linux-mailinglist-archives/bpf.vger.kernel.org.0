Return-Path: <bpf+bounces-39404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D11F972959
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 08:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0651F219E0
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 06:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74611176252;
	Tue, 10 Sep 2024 06:14:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72728175D4F;
	Tue, 10 Sep 2024 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948851; cv=none; b=hZN61Ea3pxcfUIUsCwIAr/PpYq1wLeG+nY2lGsR7O65YI4LeA7AihxM8a4OuiEkU7RG9QrVLrURA0oQzCPxN1bEgyhtiw6TDxWTSAarR8R5q4rI9IK+Oy7IoO5Eu0MzLsyjgKV3q2kIID1Hrw/K0F7Ix9WjAlFpSB88nguLgzNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948851; c=relaxed/simple;
	bh=kXpO2upk/7WHPX5Mr2KsdooYOPiEhp+y3e2QCnIJIl8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o2jKgOlFPcCEOlF5Eb3ZfjZP+0hpZOtBH3xoxGD+CAhi4bCA1fw61fLS/MT4wHWhyDBDRzWNitGZ4uCdfH2eX8ujaW0BoFSXtPZHPhSPBDAx/mgHfE+mZYgEi8rloxo0+L+VMK2cKokuXeE+QURxcichoHqkrTg2JBgHd+KP5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X2tfg4v43z1P9HV;
	Tue, 10 Sep 2024 14:12:59 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id AE438180AE7;
	Tue, 10 Sep 2024 14:14:04 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 10 Sep
 2024 14:14:03 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mhiramat@kernel.org>,
	<oleg@redhat.com>, <peterz@infradead.org>, <ast@kernel.org>,
	<puranjay@kernel.org>, <liaochang1@huawei.com>, <andrii@kernel.org>,
	<andrii.nakryiko@gmail.com>, <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH] arm64: uprobes: Simulate STP for pushing fp/lr into user stack
Date: Tue, 10 Sep 2024 06:04:07 +0000
Message-ID: <20240910060407.1427716-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200013.china.huawei.com (7.221.188.133)

This patch is the second part of a series to improve the selftest bench
of uprobe/uretprobe [0]. The lack of simulating 'stp fp, lr, [sp, #imm]'
significantly impact uprobe/uretprobe performance at function entry in
most user cases. Profiling results below reveals the STP that executes
in the xol slot and trap back to kernel, reduce redis RPS and increase
the time of string grep obviously.

On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Arm64 cores@2.4GHz.

Redis GET (higher is better)
----------------------------
No uprobe: 49149.71 RPS
Single-stepped STP: 46750.82 RPS
Emulated STP: 48981.19 RPS

Redis SET (larger is better)
----------------------------
No uprobe: 49761.14 RPS
Single-stepped STP: 45255.01 RPS
Emulated stp: 48619.21 RPS

Grep (lower is better)
----------------------
No uprobe: 2.165s
Single-stepped STP: 15.314s
Emualted STP: 2.216s

Additionally, a profiling of the entry instruction for all leaf and
non-leaf function, the ratio of 'stp fp, lr, [sp, #imm]' is larger than
50%. So simulting the STP on the function entry is a more viable option
for uprobe.

In the first version [1], it used a uaccess routine to simulate the STP
that push fp/lr into stack, which use double STTR instructions for
memory store. But as Mark pointed out, this approach can't simulate the
correct single-atomicity and ordering properties of STP, especiallly
when it interacts with MTE, POE, etc. So this patch uses a more complex
and inefficient approach that acquires user stack pages, maps them to
kernel address space, and allows kernel to use STP directly push fp/lr
into the stack pages.

xol-stp
-------
uprobe-nop      ( 1 cpus):    1.566 ± 0.006M/s  (  1.566M/s/cpu)
uprobe-push     ( 1 cpus):    0.868 ± 0.001M/s  (  0.868M/s/cpu)
uprobe-ret      ( 1 cpus):    1.629 ± 0.001M/s  (  1.629M/s/cpu)
uretprobe-nop   ( 1 cpus):    0.871 ± 0.001M/s  (  0.871M/s/cpu)
uretprobe-push  ( 1 cpus):    0.616 ± 0.001M/s  (  0.616M/s/cpu)
uretprobe-ret   ( 1 cpus):    0.878 ± 0.002M/s  (  0.878M/s/cpu)

simulated-stp
-------------
uprobe-nop      ( 1 cpus):    1.544 ± 0.001M/s  (  1.544M/s/cpu)
uprobe-push     ( 1 cpus):    1.128 ± 0.002M/s  (  1.128M/s/cpu)
uprobe-ret      ( 1 cpus):    1.550 ± 0.005M/s  (  1.550M/s/cpu)
uretprobe-nop   ( 1 cpus):    0.872 ± 0.004M/s  (  0.872M/s/cpu)
uretprobe-push  ( 1 cpus):    0.714 ± 0.001M/s  (  0.714M/s/cpu)
uretprobe-ret   ( 1 cpus):    0.896 ± 0.001M/s  (  0.896M/s/cpu)

The profiling results based on the upstream kernel with spinlock
optimization patches [2] reveals the simulation of STP increase the
uprobe-push throughput by 29.3% (from 0.868M/s/cpu to 1.1238M/s/cpu) and
uretprobe-push by 15.9% (from 0.616M/s/cpu to 0.714M/s/cpu).

[0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com/
[1] https://lore.kernel.org/all/Zr3RN4zxF5XPgjEB@J2N7QTR9R3/
[2] https://lore.kernel.org/all/20240815014629.2685155-1-liaochang1@huawei.com/

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/include/asm/insn.h            |  1 +
 arch/arm64/kernel/probes/decode-insn.c   | 16 +++++
 arch/arm64/kernel/probes/decode-insn.h   |  1 +
 arch/arm64/kernel/probes/simulate-insn.c | 89 ++++++++++++++++++++++++
 arch/arm64/kernel/probes/simulate-insn.h |  1 +
 arch/arm64/kernel/probes/uprobes.c       | 21 ++++++
 arch/arm64/lib/insn.c                    |  5 ++
 7 files changed, 134 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index dd530d5c3d67..74e25debfa75 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -561,6 +561,7 @@ u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
 				  u32 insn, u64 imm);
 u32 aarch64_insn_decode_register(enum aarch64_insn_register_type type,
 					 u32 insn);
+u32 aarch64_insn_decode_ldst_size(u32 insn);
 u32 aarch64_insn_gen_branch_imm(unsigned long pc, unsigned long addr,
 				enum aarch64_insn_branch_type type);
 u32 aarch64_insn_gen_comp_branch_imm(unsigned long pc, unsigned long addr,
diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index be54539e309e..847a7a61ff6d 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -67,6 +67,22 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
 	return true;
 }
 
+bool aarch64_insn_is_stp_fp_lr_sp_64b(probe_opcode_t insn)
+{
+	/*
+	 * The 1st instruction on function entry often follows the
+	 * patten 'stp x29, x30, [sp, #imm]!' that pushing fp and lr
+	 * into stack.
+	 */
+	u32 opc = aarch64_insn_decode_ldst_size(insn);
+	u32 rt2 = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT2, insn);
+	u32 rn = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, insn);
+	u32 rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
+
+	return aarch64_insn_is_stp_pre(insn) &&
+	       (opc == 2) && (rt2 == 30) && (rn == 31) && (rt == 29);
+}
+
 /* Return:
  *   INSN_REJECTED     If instruction is one not allowed to kprobe,
  *   INSN_GOOD         If instruction is supported and uses instruction slot,
diff --git a/arch/arm64/kernel/probes/decode-insn.h b/arch/arm64/kernel/probes/decode-insn.h
index 8b758c5a2062..033ccab73da6 100644
--- a/arch/arm64/kernel/probes/decode-insn.h
+++ b/arch/arm64/kernel/probes/decode-insn.h
@@ -29,5 +29,6 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi);
 #endif
 enum probe_insn __kprobes
 arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *asi);
+bool aarch64_insn_is_stp_fp_lr_sp_64b(probe_opcode_t insn);
 
 #endif /* _ARM_KERNEL_KPROBES_ARM64_H */
diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
index 5e4f887a074c..3906851c07b2 100644
--- a/arch/arm64/kernel/probes/simulate-insn.c
+++ b/arch/arm64/kernel/probes/simulate-insn.c
@@ -8,6 +8,9 @@
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
+#include <linux/highmem.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
 
 #include <asm/ptrace.h>
 #include <asm/traps.h>
@@ -211,3 +214,89 @@ simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
 	 */
 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 }
+
+static inline
+bool stack_align_check(unsigned long sp)
+{
+	return (IS_ALIGNED(sp, 16) ||
+		!(read_sysreg(sctlr_el1) & SCTLR_EL1_SA0_MASK));
+}
+
+static inline
+void put_user_stack_pages(struct page **pages, int nr_pages)
+{
+	int i;
+
+	for (i = 0; i < nr_pages; i++)
+		put_page(pages[i]);
+}
+
+static inline
+int get_user_stack_pages(long start, long end, struct page **pages)
+{
+	int ret;
+	int nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
+
+	ret = get_user_pages_fast(start, nr_pages,
+				  FOLL_WRITE | FOLL_FORCE, pages);
+	if (unlikely(ret != nr_pages)) {
+		if (ret > 0)
+			put_user_stack_pages(pages, ret);
+		return 0;
+	}
+
+	return nr_pages;
+}
+
+static inline
+void *map_user_stack_pages(struct page **pages, int nr_pages)
+{
+	if (likely(nr_pages == 1))
+		return kmap_local_page(pages[0]);
+	else
+		return vmap(pages, nr_pages, VM_MAP, PAGE_KERNEL);
+}
+
+static inline
+void unmap_user_stack_pages(void *kaddr, int nr_pages)
+{
+	if (likely(nr_pages == 1))
+		kunmap_local(kaddr);
+	else
+		vunmap(kaddr);
+}
+
+void __kprobes
+simulate_stp_fp_lr_sp_64b(u32 opcode, long addr, struct pt_regs *regs)
+{
+	long imm7;
+	long new_sp;
+	int nr_pages;
+	void *kaddr, *dst;
+	struct page *pages[2] = { NULL };
+
+	imm7 = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_7, opcode);
+	new_sp = regs->sp + (sign_extend64(imm7, 6) << 3);
+	if (!stack_align_check(new_sp)) {
+		force_sig(SIGSEGV);
+		goto done;
+	}
+
+	nr_pages = get_user_stack_pages(new_sp, regs->sp, pages);
+	if (!nr_pages) {
+		force_sig(SIGSEGV);
+		goto done;
+	}
+
+	kaddr = map_user_stack_pages(pages, nr_pages);
+	dst = kaddr + (new_sp & ~PAGE_MASK);
+	asm volatile("stp %0, %1, [%2]"
+		     : : "r"(regs->regs[29]), "r"(regs->regs[30]), "r"(dst));
+
+	unmap_user_stack_pages(kaddr, nr_pages);
+	put_user_stack_pages(pages, nr_pages);
+
+done:
+	regs->sp = new_sp;
+	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
+}
diff --git a/arch/arm64/kernel/probes/simulate-insn.h b/arch/arm64/kernel/probes/simulate-insn.h
index efb2803ec943..733a47ffa2e5 100644
--- a/arch/arm64/kernel/probes/simulate-insn.h
+++ b/arch/arm64/kernel/probes/simulate-insn.h
@@ -17,5 +17,6 @@ void simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs);
 void simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs);
 void simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs);
 void simulate_nop(u32 opcode, long addr, struct pt_regs *regs);
+void simulate_stp_fp_lr_sp_64b(u32 opcode, long addr, struct pt_regs *regs);
 
 #endif /* _ARM_KERNEL_KPROBES_SIMULATE_INSN_H */
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index d49aef2657cd..c70862314fde 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -8,6 +8,7 @@
 #include <asm/cacheflush.h>
 
 #include "decode-insn.h"
+#include "simulate-insn.h"
 
 #define UPROBE_INV_FAULT_CODE	UINT_MAX
 
@@ -31,6 +32,21 @@ unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
 	return instruction_pointer(regs);
 }
 
+static enum probe_insn
+arm_uprobe_decode_special_insn(probe_opcode_t insn, struct arch_probe_insn *api)
+{
+	/*
+	 * When uprobe interact with VMSA features, such as MTE, POE, etc, it
+	 * give up the simulation of memory access related instructions.
+	 */
+	if (!system_supports_mte() && aarch64_insn_is_stp_fp_lr_sp_64b(insn)) {
+		api->handler = simulate_stp_fp_lr_sp_64b;
+		return INSN_GOOD_NO_SLOT;
+	}
+
+	return INSN_REJECTED;
+}
+
 int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		unsigned long addr)
 {
@@ -44,6 +60,11 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
 
+	if (arm_uprobe_decode_special_insn(insn, &auprobe->api)) {
+		auprobe->simulate = true;
+		return 0;
+	}
+
 	switch (arm_probe_decode_insn(insn, &auprobe->api)) {
 	case INSN_REJECTED:
 		return -EINVAL;
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index b008a9b46a7f..0635219d2196 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -238,6 +238,11 @@ static u32 aarch64_insn_encode_ldst_size(enum aarch64_insn_size_type type,
 	return insn;
 }
 
+u32 aarch64_insn_decode_ldst_size(u32 insn)
+{
+	return (insn & GENMASK(31, 30)) >> 30;
+}
+
 static inline long label_imm_common(unsigned long pc, unsigned long addr,
 				     long range)
 {
-- 
2.34.1


