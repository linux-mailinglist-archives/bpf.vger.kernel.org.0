Return-Path: <bpf+bounces-21371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E4584BFB8
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 23:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35321C24656
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 22:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CA11BDE0;
	Tue,  6 Feb 2024 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZFm2OWQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3911BDE1
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257112; cv=none; b=MGwlpiA/EeyYwKnWFUJvds6Nuj1I18vOvYLItCS9V1jy2LOGMvJyriwMqBqh+heU5aDedKqOLZw80zAyE8o52eIIUq1p2MGw3ZiCvRRbByxda5v1dUMV5tQe2AuJzvfc3GvrXfVi3dFbVff3ciU9kaBEF3D/1Bn8b89l2Y/vbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257112; c=relaxed/simple;
	bh=L7zX8SsqUigxmPRtqcJkNCYI2d9YxxxYxslLVW+XN0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dV/sQhKmeZTijqOwfD6BQtt2CL5Sp59KETuX3n4bEW4URQAXaoUN92XklngBavfIz+2lUtEVWFzCYL5XtLT68S7szX4aiMTFIBa0qoEDhqJvYPbOGf1I0ekNugHlJ/M/8UPAz8PArylprAccIKECniDrlVT53pLrosOqPW9LHrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZFm2OWQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e065abd351so3882b3a.3
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 14:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707257109; x=1707861909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6enFVSH9RvXWbj69sDWzp9NqEgt7n2TNQMLPChkoghg=;
        b=CZFm2OWQZWKls1Eskc725uaecVWlwEth36SARCJvOMiAK7UqaItbtCf5Sv4XKDrkMR
         V7x0hQJUlKzLZCFd7NuO2ClYVNo7Xo3n4tXCVW22/Y+nlHxkFzZFwOHtZ/BivXf3agPD
         bhZviTHn59fXnYVaPrpRAYkb9UulrCsq6esNHNld6QSJe7aqzzJgrGfwIKhyNkjFFNqs
         C/o/u/XvehPhZ/onMljwBKfDrOcHcTFjtVf2tAVk8Yd93GYhU4fYSHWWtwSDsWyGMRIg
         p8RISotiHHCaZ4RasCu+j3GLbz1cxXIFunl7dUMOa3oNvn0nprDMvWC2Gp4PkexiVrLN
         YOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707257109; x=1707861909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6enFVSH9RvXWbj69sDWzp9NqEgt7n2TNQMLPChkoghg=;
        b=EuZiFkK7A7WZdW1pKercCX5bLl1DxbekV1r7tHVb8xID3tng3Cy1Xcq70t4EkwJ6Ak
         qXw+dkp9lKKV2zIQTfsfoBgQInEyIcgp7MplxXlCkVM9j3dwZbtQc8BvQ9siozPhbQ9x
         IgQj5HOTcZWSKKACQoGjEdyDtpfix2ZTqdvTbgD7TBDIFf6n7pg5gWbmuXZb1Y6h7vks
         CBsY8b8FNUU3LAgXsUV3Aojmged3u8xeCRSKz2rz4hNostNVwr4SO9nYBDJ4pgVwnXBc
         p7ZbWTzXAt9aJZESKIyE5TANQFsmyK37vl44S6GZLTjBM5CvxLlWiTpF08VlRwGU87HB
         TVGQ==
X-Gm-Message-State: AOJu0Yxj6wkQMDSUX9qVILt8Kr94nEXQ7tefvXfrjh0Yxtwh+Drnqu/9
	InPPNwC0/XW+q9MVEV3q8ybqVyPW7m/QZQD3Ng6TAEY6xSHyvaH46yeorODf
X-Google-Smtp-Source: AGHT+IFJTMJzd37fFoOyeiC8Vlz2bibOaLXp0NCvLZHx/AUz1x1BcqEdisFhlYf4KrANb3jkuOV5FQ==
X-Received: by 2002:a17:90a:fc82:b0:296:a70f:e96b with SMTP id ci2-20020a17090afc8200b00296a70fe96bmr810904pjb.46.1707257109520;
        Tue, 06 Feb 2024 14:05:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWTlE2SqXoxgbHIhq0G2pAApG/U2NZcA5v2musiC9iAqVjKj1tmWN0x2jXiNzl+bSHzBLchN9EcCVA65jMPupfxr+IPyW3uB1BbgGJucFcciAKDPSma9ckJXdxkGwr5dryD0TmNxrXOI2eGFoxgjmbe1V9Glj5vQ9bUH+pRBiCH+njQ0ko5+lmzLDx4II82tzdKWQNT8vvskJIIsUrU5j8iu7kXOy+/2GbiZmkj3OH58FJns8wJnBYFa+KhP1PyQYlDzNsXXw9Uq3cD256jC+iitZhaf55/mvjP
Received: from localhost.localdomain ([2620:10d:c090:400::4:27bf])
        by smtp.gmail.com with ESMTPSA id pd3-20020a17090b1dc300b00290f9e8b4f9sm2275950pjb.46.2024.02.06.14.05.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 14:05:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 06/16] bpf: Add x86-64 JIT support for PROBE_MEM32 pseudo instructions.
Date: Tue,  6 Feb 2024 14:04:31 -0800
Message-Id: <20240206220441.38311-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
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
index 42f22bc881f0..a0d737bb86d1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1460,6 +1460,7 @@ struct bpf_prog_aux {
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


