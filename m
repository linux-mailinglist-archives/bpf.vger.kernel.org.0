Return-Path: <bpf+bounces-21591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FE184EF8A
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3F528D60C
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DCC567A;
	Fri,  9 Feb 2024 04:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxZg5sr3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389025673
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451606; cv=none; b=i8HJmOID2gT+hvnnnhX+Zc8Yxc+Z8y3A4jobJmuDABQq0p6HUMj1jrws6i2r0OyDgxFs489sT7mEmf9Ame9Ca42IiJGsahpLLK6IZe3uwoUjL+GIiw8urdPv6SxukkNvbEonuR6UhFetA9tksmc/PPwIRo/PtUeYanapJndF4jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451606; c=relaxed/simple;
	bh=dB2//4PPm1Yp4eBFeVV1EAhzCGAbJX2UDbaryxiReM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F7JHX4np7gc/rNuxvFN6se81A1gwRIj3IMFcR0fQSjenvT09Kon/4oX0VzkN4I8xGj3gt6/QZ6lLUyJPCqx9RuqcvYOnHWyq9Zc8icLyQ+9sd0Y4Hmd9jhQ/VjT2EgVVuDlSWY2Bq7e148UoRS62jEWJnPgL0wIxJhowdLRdmNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxZg5sr3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d73066880eso4405815ad.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451602; x=1708056402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r96UcfCBLUTrZkh0XKcSEOthU3NUKwaxo/e39vpFxwI=;
        b=QxZg5sr3lt5W9jQXvD3Q7QMXVjKJV8n6Xzw2QqUOssDnu3BwPE2JXS/aG78v2XGXJB
         W0ngbZGCyWNm0v7AIh2+wVfJ7MjhITVG1V06v0GAWlY1x3Nqt04yNuaB+KszgWPFSnFN
         Q9pu9WpX4EXBWJrLVAUH2KjPzfZZt7Px1t0pIzsLertmcpEB82cvNDfb6P5Uvcq9ynqL
         jZwiHqGgrD3h3Qn8GBHFTHlPZyO15mNC7YZM7IGAD6FUOlCHy6H5A2jS+cPz40riPqtt
         yIyFvFLra/llfp1NP7S6NpRawFwCIiEA6PwwirbiNRzFr9DZBc/yhUsIbnwgY663D2QC
         Gy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451602; x=1708056402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r96UcfCBLUTrZkh0XKcSEOthU3NUKwaxo/e39vpFxwI=;
        b=nMtmZAkzYiOK/0utAoLqW7dcGl0y6YVqeDCRaW5gRg2WcsIiAgCATkCYh1wBHtOUVD
         rpCsfL2TfSnzUIYRuFotFgJeRyn+dlGiVG7yybZfTIjSHKZu6WdlGKb/TX1AMBmoIKcG
         XOE5+ixHKDoYeU1nZgyg6R4GezX2Pp6Tv2JfNDpQpoHCEKzOiXbGM02sZbemUpAApccM
         Ww8GCu2rKobpZyH27pcVT8o5+n7wYKEn1qy4RiiRGU8OTtg4qKRL1xgyzfACEQ/SHe2h
         NfmlkmmGBMwSLcCD1jHu8Db+1SQaVuTi1Kmhe1PcsuaQLGxWcIZuoQG/IP/krPNBglVu
         bq1g==
X-Gm-Message-State: AOJu0YwmnceAh52iZTTgUDPy2JlWNLczeG3k1TtBicZkAEtN+D3jDltO
	zyaRXBdxIzX3YKT2qxjEKBh0+0LskSzbuFNBFz2XK5dYI7e+1oHdNqQ0ZBc3
X-Google-Smtp-Source: AGHT+IF1XX2MhSM/LO2CyghiHgp2M0a1axk082AxrJPPTkzUSm6fuDm951Y0QMtQRmbzz1hhWppIoA==
X-Received: by 2002:a17:903:2287:b0:1d9:a29e:ff1a with SMTP id b7-20020a170903228700b001d9a29eff1amr536162plh.34.1707451602554;
        Thu, 08 Feb 2024 20:06:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7TFVefsK6YiLeFqnRQ+ngnAM3Iz9zc36ph1O0+RtguHwMKRjvVOYFFLDzlhm7GpceHe4QWZ/ukSU1k2THoo8Yh5tiJCf+N5NzpDvOH6PVcXVvr1DLsYcVrwwpgMureD9I4F9yvnBekkrpH4nQ5rAWXf+mvkPKcdk/4nhOKtazibWbS9zFESguuCqUyauUmA3uh3i7SXb3/y+uDn7yKkDIU3SU9QMGf6xHQZubzvwfv775vfmvAMkhvi34uCws6gTklKGRLS/S9Z1Xf7sGpXvGFH97phRnv3qgVxLHYnVzl5SX8QWnlFoVqxqpId9mbWPB5A7XDgRAeMZeixCaLHNbe6940Tr3mPQh4OCOoY2p4MV1oncWiw==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id kk7-20020a170903070700b001d8f99dbe4asm548739plb.4.2024.02.08.20.06.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:06:42 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 07/20] bpf: Add x86-64 JIT support for PROBE_MEM32 pseudo instructions.
Date: Thu,  8 Feb 2024 20:05:55 -0800
Message-Id: <20240209040608.98927-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW] instructions.
They are similar to PROBE_MEM instructions with the following differences:
- PROBE_MEM has to check that the address is in the kernel range with
  src_reg + insn->off >= TASK_SIZE_MAX + PAGE_SIZE check
- PROBE_MEM doesn't support store
- PROBE_MEM32 relies on the verifier to clear upper 32-bit in the register
- PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in %r12 in the prologue)
  Due to bpf_arena constructions such %r12 + %reg + off16 access is guaranteed
  to be within arena virtual range, so no address check at run-time.
- PROBE_MEM32 allows STX and ST. If they fault the store is a nop.
  When LDX faults the destination register is zeroed.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 183 +++++++++++++++++++++++++++++++++++-
 include/linux/bpf.h         |   1 +
 include/linux/filter.h      |   3 +
 3 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e1390d1e331b..883b7f604b9a 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -113,6 +113,7 @@ static int bpf_size_to_x86_bytes(int bpf_size)
 /* Pick a register outside of BPF range for JIT internal work */
 #define AUX_REG (MAX_BPF_JIT_REG + 1)
 #define X86_REG_R9 (MAX_BPF_JIT_REG + 2)
+#define X86_REG_R12 (MAX_BPF_JIT_REG + 3)
 
 /*
  * The following table maps BPF registers to x86-64 registers.
@@ -139,6 +140,7 @@ static const int reg2hex[] = {
 	[BPF_REG_AX] = 2, /* R10 temp register */
 	[AUX_REG] = 3,    /* R11 temp register */
 	[X86_REG_R9] = 1, /* R9 register, 6th function argument */
+	[X86_REG_R12] = 4, /* R12 callee saved */
 };
 
 static const int reg2pt_regs[] = {
@@ -167,6 +169,7 @@ static bool is_ereg(u32 reg)
 			     BIT(BPF_REG_8) |
 			     BIT(BPF_REG_9) |
 			     BIT(X86_REG_R9) |
+			     BIT(X86_REG_R12) |
 			     BIT(BPF_REG_AX));
 }
 
@@ -205,6 +208,17 @@ static u8 add_2mod(u8 byte, u32 r1, u32 r2)
 	return byte;
 }
 
+static u8 add_3mod(u8 byte, u32 r1, u32 r2, u32 index)
+{
+	if (is_ereg(r1))
+		byte |= 1;
+	if (is_ereg(index))
+		byte |= 2;
+	if (is_ereg(r2))
+		byte |= 4;
+	return byte;
+}
+
 /* Encode 'dst_reg' register into x86-64 opcode 'byte' */
 static u8 add_1reg(u8 byte, u32 dst_reg)
 {
@@ -887,6 +901,18 @@ static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int off)
 	*pprog = prog;
 }
 
+static void emit_insn_suffix_SIB(u8 **pprog, u32 ptr_reg, u32 val_reg, u32 index_reg, int off)
+{
+	u8 *prog = *pprog;
+
+	if (is_imm8(off)) {
+		EMIT3(add_2reg(0x44, BPF_REG_0, val_reg), add_2reg(0, ptr_reg, index_reg) /* SIB */, off);
+	} else {
+		EMIT2_off32(add_2reg(0x84, BPF_REG_0, val_reg), add_2reg(0, ptr_reg, index_reg) /* SIB */, off);
+	}
+	*pprog = prog;
+}
+
 /*
  * Emit a REX byte if it will be necessary to address these registers
  */
@@ -968,6 +994,37 @@ static void emit_ldsx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 	*pprog = prog;
 }
 
+static void emit_ldx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 index_reg, int off)
+{
+	u8 *prog = *pprog;
+
+	switch (size) {
+	case BPF_B:
+		/* movzx rax, byte ptr [rax + r12 + off] */
+		EMIT3(add_3mod(0x40, src_reg, dst_reg, index_reg), 0x0F, 0xB6);
+		break;
+	case BPF_H:
+		/* movzx rax, word ptr [rax + r12 + off] */
+		EMIT3(add_3mod(0x40, src_reg, dst_reg, index_reg), 0x0F, 0xB7);
+		break;
+	case BPF_W:
+		/* mov eax, dword ptr [rax + r12 + off] */
+		EMIT2(add_3mod(0x40, src_reg, dst_reg, index_reg), 0x8B);
+		break;
+	case BPF_DW:
+		/* mov rax, qword ptr [rax + r12 + off] */
+		EMIT2(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x8B);
+		break;
+	}
+	emit_insn_suffix_SIB(&prog, src_reg, dst_reg, index_reg, off);
+	*pprog = prog;
+}
+
+static void emit_ldx_r12(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
+{
+	emit_ldx_index(pprog, size, dst_reg, src_reg, X86_REG_R12, off);
+}
+
 /* STX: *(u8*)(dst_reg + off) = src_reg */
 static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
@@ -1002,6 +1059,71 @@ static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 	*pprog = prog;
 }
 
+/* STX: *(u8*)(dst_reg + index_reg + off) = src_reg */
+static void emit_stx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 index_reg, int off)
+{
+	u8 *prog = *pprog;
+
+	switch (size) {
+	case BPF_B:
+		/* mov byte ptr [rax + r12 + off], al */
+		EMIT2(add_3mod(0x40, dst_reg, src_reg, index_reg), 0x88);
+		break;
+	case BPF_H:
+		/* mov word ptr [rax + r12 + off], ax */
+		EMIT3(0x66, add_3mod(0x40, dst_reg, src_reg, index_reg), 0x89);
+		break;
+	case BPF_W:
+		/* mov dword ptr [rax + r12 + 1], eax */
+		EMIT2(add_3mod(0x40, dst_reg, src_reg, index_reg), 0x89);
+		break;
+	case BPF_DW:
+		/* mov qword ptr [rax + r12 + 1], rax */
+		EMIT2(add_3mod(0x48, dst_reg, src_reg, index_reg), 0x89);
+		break;
+	}
+	emit_insn_suffix_SIB(&prog, dst_reg, src_reg, index_reg, off);
+	*pprog = prog;
+}
+
+static void emit_stx_r12(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
+{
+	emit_stx_index(pprog, size, dst_reg, src_reg, X86_REG_R12, off);
+}
+
+/* ST: *(u8*)(dst_reg + index_reg + off) = imm32 */
+static void emit_st_index(u8 **pprog, u32 size, u32 dst_reg, u32 index_reg, int off, int imm)
+{
+	u8 *prog = *pprog;
+
+	switch (size) {
+	case BPF_B:
+		/* mov byte ptr [rax + r12 + off], imm8 */
+		EMIT2(add_3mod(0x40, dst_reg, 0, index_reg), 0xC6);
+		break;
+	case BPF_H:
+		/* mov word ptr [rax + r12 + off], imm16 */
+		EMIT3(0x66, add_3mod(0x40, dst_reg, 0, index_reg), 0xC7);
+		break;
+	case BPF_W:
+		/* mov dword ptr [rax + r12 + 1], imm32 */
+		EMIT2(add_3mod(0x40, dst_reg, 0, index_reg), 0xC7);
+		break;
+	case BPF_DW:
+		/* mov qword ptr [rax + r12 + 1], imm32 */
+		EMIT2(add_3mod(0x48, dst_reg, 0, index_reg), 0xC7);
+		break;
+	}
+	emit_insn_suffix_SIB(&prog, dst_reg, 0, index_reg, off);
+	EMIT(imm, bpf_size_to_x86_bytes(size));
+	*pprog = prog;
+}
+
+static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
+{
+	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
+}
+
 static int emit_atomic(u8 **pprog, u8 atomic_op,
 		       u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
@@ -1043,12 +1165,15 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 	return 0;
 }
 
+#define DONT_CLEAR 1
+
 bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 {
 	u32 reg = x->fixup >> 8;
 
 	/* jump over faulting load and clear dest register */
-	*(unsigned long *)((void *)regs + reg) = 0;
+	if (reg != DONT_CLEAR)
+		*(unsigned long *)((void *)regs + reg) = 0;
 	regs->ip += x->fixup & 0xff;
 	return true;
 }
@@ -1147,11 +1272,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 	bool tail_call_seen = false;
 	bool seen_exit = false;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
+	u64 arena_vm_start;
 	int i, excnt = 0;
 	int ilen, proglen = 0;
 	u8 *prog = temp;
 	int err;
 
+	arena_vm_start = bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
+
 	detect_reg_usage(insn, insn_cnt, callee_regs_used,
 			 &tail_call_seen);
 
@@ -1172,8 +1300,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 		push_r12(&prog);
 		push_callee_regs(&prog, all_callee_regs_used);
 	} else {
+		if (arena_vm_start)
+			push_r12(&prog);
 		push_callee_regs(&prog, callee_regs_used);
 	}
+	if (arena_vm_start)
+		emit_mov_imm64(&prog, X86_REG_R12,
+			       arena_vm_start >> 32, (u32) arena_vm_start);
 
 	ilen = prog - temp;
 	if (rw_image)
@@ -1564,6 +1697,52 @@ st:			if (is_imm8(insn->off))
 			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
 			break;
 
+		case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
+		case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
+		case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
+		case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
+			start_of_ldx = prog;
+			emit_st_r12(&prog, BPF_SIZE(insn->code), dst_reg, insn->off, insn->imm);
+			goto populate_extable;
+
+			/* LDX: dst_reg = *(u8*)(src_reg + r12 + off) */
+		case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
+		case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
+		case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
+		case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
+		case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
+		case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
+		case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
+		case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
+			start_of_ldx = prog;
+			if (BPF_CLASS(insn->code) == BPF_LDX)
+				emit_ldx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+			else
+				emit_stx_r12(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
+populate_extable:
+			{
+				struct exception_table_entry *ex;
+				u8 *_insn = image + proglen + (start_of_ldx - temp);
+				s64 delta;
+
+				if (!bpf_prog->aux->extable)
+					break;
+
+				ex = &bpf_prog->aux->extable[excnt++];
+
+				delta = _insn - (u8 *)&ex->insn;
+				/* switch ex to rw buffer for writes */
+				ex = (void *)rw_image + ((void *)ex - (void *)image);
+
+				ex->insn = delta;
+
+				ex->data = EX_TYPE_BPF;
+
+				ex->fixup = (prog - start_of_ldx) |
+					((BPF_CLASS(insn->code) == BPF_LDX ? reg2pt_regs[dst_reg] : DONT_CLEAR) << 8);
+			}
+			break;
+
 			/* LDX: dst_reg = *(u8*)(src_reg + off) */
 		case BPF_LDX | BPF_MEM | BPF_B:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_B:
@@ -2036,6 +2215,8 @@ st:			if (is_imm8(insn->off))
 				pop_r12(&prog);
 			} else {
 				pop_callee_regs(&prog, callee_regs_used);
+				if (arena_vm_start)
+					pop_r12(&prog);
 			}
 			EMIT1(0xC9);         /* leave */
 			emit_return(&prog, image + addrs[i - 1] + (prog - temp));
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index de557c6c42e0..26419a57bf9f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1463,6 +1463,7 @@ struct bpf_prog_aux {
 	bool xdp_has_frags;
 	bool exception_cb;
 	bool exception_boundary;
+	struct bpf_arena *arena;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index fee070b9826e..cd76d43412d0 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -72,6 +72,9 @@ struct ctl_table_header;
 /* unused opcode to mark special ldsx instruction. Same as BPF_IND */
 #define BPF_PROBE_MEMSX	0x40
 
+/* unused opcode to mark special load instruction. Same as BPF_MSH */
+#define BPF_PROBE_MEM32	0xa0
+
 /* unused opcode to mark call to interpreter with arguments */
 #define BPF_CALL_ARGS	0xe0
 
-- 
2.34.1


