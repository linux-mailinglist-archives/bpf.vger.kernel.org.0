Return-Path: <bpf+bounces-53012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7E0A4B7AD
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 06:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0471C166BC9
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 05:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EC31E521B;
	Mon,  3 Mar 2025 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0+P8la/e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EE11E0DE3
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980296; cv=none; b=NMaNHXlnhAGm7OkbpCcZCQrU2+hChbVl85OrAUCSUOc8eFoDdEPiPwS+BYmc3jRoEk508WvPEIi6xECUec/U6wsSTBLSMOuttngY9039fvpOZI9rYHw0LKFFmttR6afF2F/5UChJlM2yWpZUDwTWhB+MD9Ea/xdaGgJ+xUGSvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980296; c=relaxed/simple;
	bh=QPA0z4IkQ4stWUSFz7Vu1LHPkM1P0cuaG7fZq/w/Sls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bkhe1jImIO8eI/3zq53XdTKC+mLNgqGTb8tW0oNQUPOid2leBn+JdqRk6esN8ZqlTRd0CYbgriCZ5ZQv2tuJOYlzwmQWf68S1k+XL02xnxOZSMWMGx3eeRQlzFoYtDUbCywcRMa6wGNXJmLIo2ZFe4jhwp0BhEYCwhdpLyFLYVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0+P8la/e; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fee4c7ef4dso4620007a91.0
        for <bpf@vger.kernel.org>; Sun, 02 Mar 2025 21:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740980294; x=1741585094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VycOpllnvSzKdjd9R3576qTHHYaFrsKy4wd3sa7AubQ=;
        b=0+P8la/eYXy3FWfEiBbmIQjvDx5VkB4ip8BF3ysj0v+t4PgH8zHsilREalmwgAzzRU
         LrK8oib18OiLoLrxvBJBudHFV0xJkDfed154T63XazUQw4/Ap2YdeKqFt5ESObdeNM47
         Ize2kMOqvIWxkpj+kviZdkUGeespq8QeCyG7zy822RKB+lgMUHrswJVvro74WqCoTJ5k
         5vGXqDOpXz0dg0AnI4btpHtFSQw383wTvswkScgKbCVsV7cUxHjKwsTKSjMyaNPkUnKw
         XrgVmlM8EnbldtzD7B8Ov4cu5zK1BZSovOT59zp+20ApkRzj9/nXRDXj2z0xxlQiZkvI
         2xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740980294; x=1741585094;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VycOpllnvSzKdjd9R3576qTHHYaFrsKy4wd3sa7AubQ=;
        b=eozaeqXCRRQ5o2hFjoZC8Wn3QkJz7EqFW+AhwODDJlHQgZhWY4mvVw6QXy9y8cH7Oy
         1WNXCgrgkn4ijpfcsZglSlhcY0kVVhDX6vc99ZciJD9xG/dX5f0OMt8HXEaG46bJRLli
         zTTA/8a2RIt03dB9rmIuRMguq5Nq4eOfZCei+jNlRQJELO4E2A4p9xm60mE3wNkiQhjL
         Vjl0giVvZ983dtyJjeMRTTrVh0KdxDBnN3wA/pt6W2nDG+Tffzh4FvG9DXSfnEQpYYy4
         eTcgBqwiEtFPpKSpRuQ3mbfa6lB20FKcuIb9HlgrVFqCpoDUG+8Z8LoM43/C1Y/thx7+
         5YuA==
X-Gm-Message-State: AOJu0YycHIYJycj8QOU0D3hab7+87TDnoYQp/TLeZdBqfcfQsLYgNE8R
	JHWtWQ5DlpqBL++yjiYMDUpbErEMUROLLFvy2fq7AmiIsMN9p4OGIyASp4QYUsMHvztisMw65At
	mRsPdoH0cJrZxZ0fNQnjcjaLJgQG/1viI7jV1sAJO/b8v+HYqZ6B1eGrT2a7m0OKKkQXbows5Kt
	IGOtV2aFWfk7gLHaO9IrUFe3aB2akbdU6E9rSMtCY=
X-Google-Smtp-Source: AGHT+IHllqIaGVwHEYKEha98799p/W5J6WNyThFgS1lHfGtsfwVyB+AM3fp47cytXtmuvF7FgDBcYhz+Dj9rJA==
X-Received: from pjbpl16.prod.google.com ([2002:a17:90b:2690:b0:2fc:11a0:c546])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:384c:b0:2fe:8694:3956 with SMTP id 98e67ed59e1d1-2febab787d6mr21394914a91.16.1740980293845;
 Sun, 02 Mar 2025 21:38:13 -0800 (PST)
Date: Mon,  3 Mar 2025 05:38:07 +0000
In-Reply-To: <cover.1740978603.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740978603.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <ea2754510513dce17a1d8f4fcab07d9d769e7b08.1740978603.git.yepeilin@google.com>
Subject: [PATCH bpf-next v4 08/10] bpf, x86: Support load-acquire and
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


