Return-Path: <bpf+bounces-53151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66346A4D084
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 02:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C4C188FEB8
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 01:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865B23BBC9;
	Tue,  4 Mar 2025 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yR5Ts304"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F133132111
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050406; cv=none; b=RZgPL6DIf0np61J+lVKExyYKO5bLP9woCdVUaWBfbRY5uMIG0zXfysIy+h/BGwqWMLU8eZNaq6yny+OiWyp1XlEVmkTDv7Syi4EavfJYGIW7cLExQNjzrfioDxmRKizk8rFxqTva57mlkv5kKvl9cihCPT80Hjux3sljeJJ4jWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050406; c=relaxed/simple;
	bh=QPA0z4IkQ4stWUSFz7Vu1LHPkM1P0cuaG7fZq/w/Sls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Je47c8h4KUCnd+Nw0cFvIHJkaV/ZnKNtmJ9DUY2GASLERDHbZZc3xQaHRT2+fIBZz78+vNxMvNhCjX5eq8hHXigSOuZA9Rd6nvEh2TJTa/LTL04cZs1o8sJs8WzJMlYOm1PwUNAk+Zn188NLtOWWa59WedIWZae0rCqtIeybDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yR5Ts304; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso10715916a91.2
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 17:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741050404; x=1741655204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VycOpllnvSzKdjd9R3576qTHHYaFrsKy4wd3sa7AubQ=;
        b=yR5Ts304g/X0B+G1TMy+IvIj67JT7bMqCG2mmnzjeWlcx5iEcSTPXUWBjL620hlqnB
         slyqeNvCDP7bGvFqEieRL7BJiRkvjDuP9ElLRaZ9xTNAYxJB7cXOCgFWzzfHdtEH4yiz
         ZW2IDG1nsLl6q8cTS+q7YBm6JlTdIlH3RM4eehXTT4IPwtpEIuoik8uDBojD4wmyxXfH
         mtHpSs6WEy7TqvxyVB9m69ydzRyBBs7WWCQ452VpxfJL4qnB4hro2J/tXzeVBu5cEtba
         UPWDtPD1bUTOnl29ONdL7LVsjWtw3pLW4Qk4iXSDngP3kpfhZ+RYKcIqdbSCMaLUZ+hI
         w1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741050404; x=1741655204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VycOpllnvSzKdjd9R3576qTHHYaFrsKy4wd3sa7AubQ=;
        b=qmUI3uTctS8/XTwLlVZYRp7+nCi9oFgdGxWn/+f1XhCXOtdPCVPgIXq0ntgKxvbxAJ
         gG3rT1DFpbAaXDHT3dK1vBUh6snbqKj6kKuQuKdxHnvSZha7rSHOwvqm7FuuYn/vYk2x
         xaHqAN0oesD7czp43d2rrHr+kAF/6pivC1NQQqu9jLVujENcUridfl5QZP2xAhSEfpaK
         0R1Ec+0RNmS1sD2lKH3hx7/rgJQL/RswfRWQ14o36pqoRpubOa9OZ9lMpknrhdr1PYmC
         sjAVdaPVD5cfeVU6Dd314yhwWaATg1rbAHbkQV71+cvr1sgZVMrz+7SQHvDXop92LXXi
         wFRw==
X-Gm-Message-State: AOJu0YyOEhHJZk5RDzdolcbv9EhnDAkzq5uvZVpkkgbLL/Taw5shhgjd
	vRwW/S4uTVvzZxTyZTIBgxXB0QJHLPleRZ4q5rTcUy5ZT7VYYm3TjDkRB9mqb/zt499B1u+nyoi
	dv7NZ3gXDmJqKw5fVVCmFy3hMJfYyLsmdnoPz6STlhNv5SL2P87mqGOx2jDaqBcNjoOHXc2UdQG
	r72NZvnWkmAgpAYG+ed47hEIjJp0p67sgnafTdLm4=
X-Google-Smtp-Source: AGHT+IHF3BLj5mjWleVYQrXGIvLzEYlz0BONXjtRiukWU4VsiMufPscnuEzPyeR7sHrJ2E23Uo3q+hcprby/RA==
X-Received: from pjbqa8.prod.google.com ([2002:a17:90b:4fc8:b0:2fa:210c:d068])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5747:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-2febaa924d4mr28642830a91.0.1741050403757;
 Mon, 03 Mar 2025 17:06:43 -0800 (PST)
Date: Tue,  4 Mar 2025 01:06:40 +0000
In-Reply-To: <cover.1741049567.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1741049567.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <d22bb3c69f126af1d962b7314f3489eff606a3b7.1741049567.git.yepeilin@google.com>
Subject: [PATCH bpf-next v6 5/6] bpf, x86: Support load-acquire and
 store-release instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Recently we introduced BPF load-acquire (BPF_LOAD_ACQ) and store-release
(BPF_STORE_REL) instructions.  For x86-64, simply implement them as
regular BPF_LDX/BPF_STX loads and stores.  The verifier always rejects
misaligned load-acquires/store-releases (even if BPF_F_ANY_ALIGNMENT is
set), so emitted MOV* instructions are guaranteed to be atomic.

Arena accesses are supported.  8- and 16-bit load-acquires are
zero-extending (i.e., MOVZBQ, MOVZWQ).

Rename emit_atomic{,_index}() to emit_atomic_rmw{,_index}() to make it
clear that they only handle read-modify-write atomics, and extend their
@atomic_op parameter from u8 to u32, since we are starting to use more
than the lowest 8 bits of the 'imm' field.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 99 ++++++++++++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 17 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index f0c31c940fb8..0263d98d92b0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1242,8 +1242,8 @@ static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
 }
 
-static int emit_atomic(u8 **pprog, u8 atomic_op,
-		       u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
+static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
+			   u32 dst_reg, u32 src_reg, s16 off, u8 bpf_size)
 {
 	u8 *prog = *pprog;
 
@@ -1283,8 +1283,9 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 	return 0;
 }
 
-static int emit_atomic_index(u8 **pprog, u8 atomic_op, u32 size,
-			     u32 dst_reg, u32 src_reg, u32 index_reg, int off)
+static int emit_atomic_rmw_index(u8 **pprog, u32 atomic_op, u32 size,
+				 u32 dst_reg, u32 src_reg, u32 index_reg,
+				 int off)
 {
 	u8 *prog = *pprog;
 
@@ -1297,7 +1298,7 @@ static int emit_atomic_index(u8 **pprog, u8 atomic_op, u32 size,
 		EMIT1(add_3mod(0x48, dst_reg, src_reg, index_reg));
 		break;
 	default:
-		pr_err("bpf_jit: 1 and 2 byte atomics are not supported\n");
+		pr_err("bpf_jit: 1- and 2-byte RMW atomics are not supported\n");
 		return -EFAULT;
 	}
 
@@ -1331,6 +1332,49 @@ static int emit_atomic_index(u8 **pprog, u8 atomic_op, u32 size,
 	return 0;
 }
 
+static int emit_atomic_ld_st(u8 **pprog, u32 atomic_op, u32 dst_reg,
+			     u32 src_reg, s16 off, u8 bpf_size)
+{
+	switch (atomic_op) {
+	case BPF_LOAD_ACQ:
+		/* dst_reg = smp_load_acquire(src_reg + off16) */
+		emit_ldx(pprog, bpf_size, dst_reg, src_reg, off);
+		break;
+	case BPF_STORE_REL:
+		/* smp_store_release(dst_reg + off16, src_reg) */
+		emit_stx(pprog, bpf_size, dst_reg, src_reg, off);
+		break;
+	default:
+		pr_err("bpf_jit: unknown atomic load/store opcode %02x\n",
+		       atomic_op);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
+				   u32 dst_reg, u32 src_reg, u32 index_reg,
+				   int off)
+{
+	switch (atomic_op) {
+	case BPF_LOAD_ACQ:
+		/* dst_reg = smp_load_acquire(src_reg + idx_reg + off16) */
+		emit_ldx_index(pprog, size, dst_reg, src_reg, index_reg, off);
+		break;
+	case BPF_STORE_REL:
+		/* smp_store_release(dst_reg + idx_reg + off16, src_reg) */
+		emit_stx_index(pprog, size, dst_reg, src_reg, index_reg, off);
+		break;
+	default:
+		pr_err("bpf_jit: unknown atomic load/store opcode %02x\n",
+		       atomic_op);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 #define DONT_CLEAR 1
 
 bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
@@ -2113,6 +2157,13 @@ st:			if (is_imm8(insn->off))
 			}
 			break;
 
+		case BPF_STX | BPF_ATOMIC | BPF_B:
+		case BPF_STX | BPF_ATOMIC | BPF_H:
+			if (!bpf_atomic_is_load_store(insn)) {
+				pr_err("bpf_jit: 1- and 2-byte RMW atomics are not supported\n");
+				return -EFAULT;
+			}
+			fallthrough;
 		case BPF_STX | BPF_ATOMIC | BPF_W:
 		case BPF_STX | BPF_ATOMIC | BPF_DW:
 			if (insn->imm == (BPF_AND | BPF_FETCH) ||
@@ -2148,10 +2199,10 @@ st:			if (is_imm8(insn->off))
 				EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
 				      add_2reg(0xC0, AUX_REG, real_src_reg));
 				/* Attempt to swap in new value */
-				err = emit_atomic(&prog, BPF_CMPXCHG,
-						  real_dst_reg, AUX_REG,
-						  insn->off,
-						  BPF_SIZE(insn->code));
+				err = emit_atomic_rmw(&prog, BPF_CMPXCHG,
+						      real_dst_reg, AUX_REG,
+						      insn->off,
+						      BPF_SIZE(insn->code));
 				if (WARN_ON(err))
 					return err;
 				/*
@@ -2166,17 +2217,35 @@ st:			if (is_imm8(insn->off))
 				break;
 			}
 
-			err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
-					  insn->off, BPF_SIZE(insn->code));
+			if (bpf_atomic_is_load_store(insn))
+				err = emit_atomic_ld_st(&prog, insn->imm, dst_reg, src_reg,
+							insn->off, BPF_SIZE(insn->code));
+			else
+				err = emit_atomic_rmw(&prog, insn->imm, dst_reg, src_reg,
+						      insn->off, BPF_SIZE(insn->code));
 			if (err)
 				return err;
 			break;
 
+		case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
+		case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:
+			if (!bpf_atomic_is_load_store(insn)) {
+				pr_err("bpf_jit: 1- and 2-byte RMW atomics are not supported\n");
+				return -EFAULT;
+			}
+			fallthrough;
 		case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
 		case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
 			start_of_ldx = prog;
-			err = emit_atomic_index(&prog, insn->imm, BPF_SIZE(insn->code),
-						dst_reg, src_reg, X86_REG_R12, insn->off);
+
+			if (bpf_atomic_is_load_store(insn))
+				err = emit_atomic_ld_st_index(&prog, insn->imm,
+							      BPF_SIZE(insn->code), dst_reg,
+							      src_reg, X86_REG_R12, insn->off);
+			else
+				err = emit_atomic_rmw_index(&prog, insn->imm, BPF_SIZE(insn->code),
+							    dst_reg, src_reg, X86_REG_R12,
+							    insn->off);
 			if (err)
 				return err;
 			goto populate_extable;
@@ -3771,12 +3840,8 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 	if (!in_arena)
 		return true;
 	switch (insn->code) {
-	case BPF_STX | BPF_ATOMIC | BPF_B:
-	case BPF_STX | BPF_ATOMIC | BPF_H:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		if (bpf_atomic_is_load_store(insn))
-			return false;
 		if (insn->imm == (BPF_AND | BPF_FETCH) ||
 		    insn->imm == (BPF_OR | BPF_FETCH) ||
 		    insn->imm == (BPF_XOR | BPF_FETCH))
-- 
2.48.1.711.g2feabab25a-goog


