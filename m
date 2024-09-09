Return-Path: <bpf+bounces-39265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66985970F7C
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FCD2827E9
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C39C1AED5F;
	Mon,  9 Sep 2024 07:21:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0141AE859;
	Mon,  9 Sep 2024 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866475; cv=none; b=sJ/MCTZ8a4MNjqCZYMrseXv8kVkT+89+wF9UyebCgOwjBwrDiSRj+SwsTxlph2ChrX2YimVW4z3VQE3zlUqVVW4Nf9XdWNIbV06tYRcvlS5xaQRprEj3RqYjdibG7EkpEug9c7RYQ/uVSrlj6Iryo0658euAF1F+pA1iSccFw5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866475; c=relaxed/simple;
	bh=SyW8FxLsJBNl5HQ6QsV4oXouJe7wMWuil6vbtzaKY68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I6IbA9Lsxkf7S3vEc061QGzIbzpiqLqtdm9xCZ8h2lLF4NszU5LerUCV5GANrVDK5QglG+eFA2SGFkHgp6MuNY++9DNfUatWuzpcRwhjcYkFJKEIO6/SdXrgqW31Gy4WsRjLAhxPdzjtJr7ZNhJq3lq/h8YyFJs6kvZmlVA8lcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X2JBy3Hm1zyRgh;
	Mon,  9 Sep 2024 15:20:26 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id CE93B1401E9;
	Mon,  9 Sep 2024 15:21:09 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 9 Sep
 2024 15:21:09 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ast@kernel.org>,
	<puranjay@kernel.org>, <liaochang1@huawei.com>, <andrii@kernel.org>,
	<mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH v2] arm64: insn: Simulate nop instruction for better uprobe performance
Date: Mon, 9 Sep 2024 07:11:14 +0000
Message-ID: <20240909071114.1150053-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)

v2->v1:
1. Remove the simuation of STP and the related bits.
2. Use arm64_skip_faulting_instruction for single-stepping or FEAT_BTI
   scenario.

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

As Mark suggested [1], it is painful to emulate the correct atomicity
and ordering properties of STP, especially when it interacts with MTE,
POE, etc. So this patch just focus on the simuation of 'nop'. The
simluation of STP and related changes will be addressed in a separate
patch.

[0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com/
[1] https://lore.kernel.org/all/Zr3RN4zxF5XPgjEB@J2N7QTR9R3/

CC: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/include/asm/insn.h            |  6 ++++++
 arch/arm64/kernel/probes/decode-insn.c   |  9 +++++++++
 arch/arm64/kernel/probes/simulate-insn.c | 11 +++++++++++
 arch/arm64/kernel/probes/simulate-insn.h |  1 +
 4 files changed, 27 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 8c0a36f72d6f..dd530d5c3d67 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -549,6 +549,12 @@ static __always_inline bool aarch64_insn_uses_literal(u32 insn)
 	       aarch64_insn_is_prfm_lit(insn);
 }
 
+static __always_inline bool aarch64_insn_is_nop(u32 insn)
+{
+	return aarch64_insn_is_hint(insn) &&
+	       ((insn & 0xFE0) == AARCH64_INSN_HINT_NOP);
+}
+
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
 u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn);
 u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index 968d5fffe233..be54539e309e 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -75,6 +75,15 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
 enum probe_insn __kprobes
 arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api)
 {
+	/*
+	 * While 'nop' instruction can execute in the out-of-line slot,
+	 * simulating them in breakpoint handling offers better performance.
+	 */
+	if (aarch64_insn_is_nop(insn)) {
+		api->handler = simulate_nop;
+		return INSN_GOOD_NO_SLOT;
+	}
+
 	/*
 	 * Instructions reading or modifying the PC won't work from the XOL
 	 * slot.
diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
index 22d0b3252476..5e4f887a074c 100644
--- a/arch/arm64/kernel/probes/simulate-insn.c
+++ b/arch/arm64/kernel/probes/simulate-insn.c
@@ -200,3 +200,14 @@ simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)
 
 	instruction_pointer_set(regs, instruction_pointer(regs) + 4);
 }
+
+void __kprobes
+simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
+{
+	/*
+	 * Compared to instruction_pointer_set(), it offers better
+	 * compatibility with single-stepping and execution in target
+	 * guarded memory.
+	 */
+	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
+}
diff --git a/arch/arm64/kernel/probes/simulate-insn.h b/arch/arm64/kernel/probes/simulate-insn.h
index e065dc92218e..efb2803ec943 100644
--- a/arch/arm64/kernel/probes/simulate-insn.h
+++ b/arch/arm64/kernel/probes/simulate-insn.h
@@ -16,5 +16,6 @@ void simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs);
 void simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs);
 void simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs);
 void simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs);
+void simulate_nop(u32 opcode, long addr, struct pt_regs *regs);
 
 #endif /* _ARM_KERNEL_KPROBES_SIMULATE_INSN_H */
-- 
2.34.1


