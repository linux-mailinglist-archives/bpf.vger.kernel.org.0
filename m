Return-Path: <bpf+bounces-37157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 604B7951642
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 10:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848141C213FD
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 08:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B4B13D520;
	Wed, 14 Aug 2024 08:13:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE356394;
	Wed, 14 Aug 2024 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623199; cv=none; b=FtkCI9rdR6wEwL47qioo1kmneqtUwJWko/ZnItUZRo6Wke8mLIpDerNfrvnVv/ZCcgmpOllhraUfM2Gbxtj7Ch0Lo2ky5D5c1PzXDNUJKmBseqmWTmdyR9Z+Zt0KkvYvggYGwKe0gER02XYbauq4IUeuYS96dfcyTLU2JkY7Wno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623199; c=relaxed/simple;
	bh=MGDQcVscA9rJ1A+eZT5iYZE4lC8HyxO0eR2ZAnsUjAg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uz5MgJcSke6gbXvvBPWys3+vYt3ZzQgVcG4EqzTv+qhBwZJ1SC1rbdFMsKUy61nh08jccF0PRSSU5SUvIqI0RjJXoYzIjjlfnMmQ1GBjBYw1OUDokwdwsnWCRXYi7k6zEKs/JnAYnB8S9heOT4oSLGPfpS80XOqorKh5LbF5kak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WkLbZ6WLTzcdRD;
	Wed, 14 Aug 2024 16:12:58 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id B3A981400C9;
	Wed, 14 Aug 2024 16:13:13 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 14 Aug
 2024 16:13:13 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mhiramat@kernel.org>,
	<oleg@redhat.com>, <peterz@infradead.org>, <puranjay@kernel.org>,
	<ast@kernel.org>, <andrii@kernel.org>, <xukuohai@huawei.com>,
	<revest@chromium.org>, <liaochang1@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH] arm64: insn: Simulate nop and push instruction for better uprobe performance
Date: Wed, 14 Aug 2024 08:03:56 +0000
Message-ID: <20240814080356.2639544-1-liaochang1@huawei.com>
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

As Andrii pointed out, the uprobe/uretprobe selftest bench run into a
counterintuitive result that nop and push variants are much slower than
ret variant [0]. The root cause lies in the arch_probe_analyse_insn(),
which excludes 'nop' and 'stp' from the emulatable instructions list.
This force the kernel returns to userspace and execute them out-of-line,
then trapping back to kernel for running uprobe callback functions. This
leads to a significant performance overhead compared to 'ret' variant,
which is already emulated.

Typicall uprobe is installed on 'nop' for USDT and on function entry
which starts with the instrucion 'stp x29, x30, [sp, #imm]!' to push lr
and fp into stack regardless kernel or userspace binary. In order to
improve the performance of handling uprobe for common usecases. This
patch supports the emulation of Arm64 equvialents instructions of 'nop'
and 'push'. The benchmark results below indicates the performance gain
of emulation is obvious.

On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Arm64 cores@2.4GHz.

xol (1 cpus)
------------
uprobe-nop:  0.916 ± 0.001M/s (0.916M/prod)
uprobe-push: 0.908 ± 0.001M/s (0.908M/prod)
uprobe-ret:  1.855 ± 0.000M/s (1.855M/prod)
uretprobe-nop:  0.640 ± 0.000M/s (0.640M/prod)
uretprobe-push: 0.633 ± 0.001M/s (0.633M/prod)
uretprobe-ret:  0.978 ± 0.003M/s (0.978M/prod)

emulation (1 cpus)
-------------------
uprobe-nop:  1.862 ± 0.002M/s  (1.862M/prod)
uprobe-push: 1.743 ± 0.006M/s  (1.743M/prod)
uprobe-ret:  1.840 ± 0.001M/s  (1.840M/prod)
uretprobe-nop:  0.964 ± 0.004M/s  (0.964M/prod)
uretprobe-push: 0.936 ± 0.004M/s  (0.936M/prod)
uretprobe-ret:  0.940 ± 0.001M/s  (0.940M/prod)

As shown above, the performance gap between 'nop/push' and 'ret'
variants has been significantly reduced. Due to the emulation of 'push'
instruction needs to access userspace memory, it spent more cycles than
the other.

[0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com/

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/include/asm/insn.h            | 21 ++++++++++++++++++
 arch/arm64/kernel/probes/decode-insn.c   | 18 +++++++++++++--
 arch/arm64/kernel/probes/decode-insn.h   |  3 ++-
 arch/arm64/kernel/probes/simulate-insn.c | 28 ++++++++++++++++++++++++
 arch/arm64/kernel/probes/simulate-insn.h |  2 ++
 arch/arm64/kernel/probes/uprobes.c       |  2 +-
 6 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 8c0a36f72d6f..a246e6e550ba 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -549,6 +549,27 @@ static __always_inline bool aarch64_insn_uses_literal(u32 insn)
 	       aarch64_insn_is_prfm_lit(insn);
 }
 
+static __always_inline bool aarch64_insn_is_nop(u32 insn)
+{
+	/* nop */
+	return aarch64_insn_is_hint(insn) &&
+	       ((insn & 0xFE0) == AARCH64_INSN_HINT_NOP);
+}
+
+static __always_inline bool aarch64_insn_is_stp_fp_lr_sp_64b(u32 insn)
+{
+	/*
+	 * The 1st instruction on function entry often follows the
+	 * patten 'stp x29, x30, [sp, #imm]!' that pushing fp and lr
+	 * into stack.
+	 */
+	return aarch64_insn_is_stp_pre(insn) &&
+	       (((insn >> 30) & 0x03) ==  2) && /* opc == 10 */
+	       (((insn >>  5) & 0x1F) == 31) && /* Rn  is sp */
+	       (((insn >> 10) & 0x1F) == 30) && /* Rt2 is x29 */
+	       (((insn >>  0) & 0x1F) == 29);	/* Rt  is x30 */
+}
+
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
 u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn);
 u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index 968d5fffe233..df7ca16fc763 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -73,8 +73,22 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
  *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
  */
 enum probe_insn __kprobes
-arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api)
+arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api,
+		      bool kernel)
 {
+	/*
+	 * While 'nop' and 'stp x29, x30, [sp, #imm]! instructions can
+	 * execute in the out-of-line slot, simulating them in breakpoint
+	 * handling offers better performance.
+	 */
+	if (aarch64_insn_is_nop(insn)) {
+		api->handler = simulate_nop;
+		return INSN_GOOD_NO_SLOT;
+	} else if (!kernel && aarch64_insn_is_stp_fp_lr_sp_64b(insn)) {
+		api->handler = simulate_stp_fp_lr_sp_64b;
+		return INSN_GOOD_NO_SLOT;
+	}
+
 	/*
 	 * Instructions reading or modifying the PC won't work from the XOL
 	 * slot.
@@ -157,7 +171,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
 		else
 			scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
 	}
-	decoded = arm_probe_decode_insn(insn, &asi->api);
+	decoded = arm_probe_decode_insn(insn, &asi->api, true);
 
 	if (decoded != INSN_REJECTED && scan_end)
 		if (is_probed_address_atomic(addr - 1, scan_end))
diff --git a/arch/arm64/kernel/probes/decode-insn.h b/arch/arm64/kernel/probes/decode-insn.h
index 8b758c5a2062..ec4607189933 100644
--- a/arch/arm64/kernel/probes/decode-insn.h
+++ b/arch/arm64/kernel/probes/decode-insn.h
@@ -28,6 +28,7 @@ enum probe_insn __kprobes
 arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi);
 #endif
 enum probe_insn __kprobes
-arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *asi);
+arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *asi,
+		      bool kernel);
 
 #endif /* _ARM_KERNEL_KPROBES_ARM64_H */
diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
index 22d0b3252476..0b1623fa7003 100644
--- a/arch/arm64/kernel/probes/simulate-insn.c
+++ b/arch/arm64/kernel/probes/simulate-insn.c
@@ -200,3 +200,31 @@ simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)
 
 	instruction_pointer_set(regs, instruction_pointer(regs) + 4);
 }
+
+void __kprobes
+simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
+{
+	instruction_pointer_set(regs, instruction_pointer(regs) + 4);
+}
+
+void __kprobes
+simulate_stp_fp_lr_sp_64b(u32 opcode, long addr, struct pt_regs *regs)
+{
+	long imm7;
+	u64 buf[2];
+	long new_sp;
+
+	imm7 = sign_extend64((opcode >> 15) & 0x7f, 6);
+	new_sp = regs->sp + (imm7 << 3);
+
+	buf[0] = regs->regs[29];
+	buf[1] = regs->regs[30];
+
+	if (copy_to_user((void __user *)new_sp, buf, sizeof(buf))) {
+		force_sig(SIGSEGV);
+		return;
+	}
+
+	regs->sp = new_sp;
+	instruction_pointer_set(regs, instruction_pointer(regs) + 4);
+}
diff --git a/arch/arm64/kernel/probes/simulate-insn.h b/arch/arm64/kernel/probes/simulate-insn.h
index e065dc92218e..733a47ffa2e5 100644
--- a/arch/arm64/kernel/probes/simulate-insn.h
+++ b/arch/arm64/kernel/probes/simulate-insn.h
@@ -16,5 +16,7 @@ void simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs);
 void simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs);
 void simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs);
 void simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs);
+void simulate_nop(u32 opcode, long addr, struct pt_regs *regs);
+void simulate_stp_fp_lr_sp_64b(u32 opcode, long addr, struct pt_regs *regs);
 
 #endif /* _ARM_KERNEL_KPROBES_SIMULATE_INSN_H */
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index d49aef2657cd..ec5881db3b7a 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -44,7 +44,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	insn = *(probe_opcode_t *)(&auprobe->insn[0]);
 
-	switch (arm_probe_decode_insn(insn, &auprobe->api)) {
+	switch (arm_probe_decode_insn(insn, &auprobe->api, false)) {
 	case INSN_REJECTED:
 		return -EINVAL;
 
-- 
2.34.1


