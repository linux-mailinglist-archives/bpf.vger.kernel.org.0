Return-Path: <bpf+bounces-57015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A41AA3FCE
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DD1170BC2
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 00:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442E12DC786;
	Wed, 30 Apr 2025 00:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jAI4uq06"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2C52DC794
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974254; cv=none; b=lVx/A90ahWcJVG/Kn4ZeV8aLowDk62xlvEEXcP6l7roH6+FeV1noGmkxmy6y621cQytuqBkmwW8CAqEAB3gpWyxGQOZqkwGcRJdrDM1N9kWiLJrwKk8iDEvMl5sJ+pTPjzbovupscRKoxGK/ERedGmKXb47HOJVnksRap5W1lcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974254; c=relaxed/simple;
	bh=uL0IGTfqqROwHCZ1VRsCjz47lJPrGkF4ewrMsLldnLM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TqpdWJnjzlkThmDxKbuq2xh2Y+exbgVOX7eMKA9q4q5VhJoekJgTtZ3O9XNye9MjGsLAMuv6RlpD+l7etGz53/KS5Z4EU75YyjxWWMnyecyGyfyEjnIPpgw8/un6av+5w5S+XyQez/h+AowcclvFkxdUQMzeXPKsKfD6NxcPWmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jAI4uq06; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso7502896a91.1
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 17:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745974252; x=1746579052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qCSPF9Frgb/+2+wOixYxGK5ULBPAm5cfOGeKd85/fA=;
        b=jAI4uq06AeXCIUU4mkmx6A0xiGAQ5cJ7R+JrnRoWM8lZD6iW68h4tBS5lQfUJsfviD
         ZtGSZHkRdVHysC1z8G4hH98QevoAEXp52CAVhHikRt3TjcxWmpuilO6DWWju8nt5C2Mt
         SRANRfRg4Jv1PqY3wJ0D/1enTwTEzGzYIwSYvJLde1Z/6jqvDySdftktaEwYg29+c4FF
         FR8glEA7tLAyhQRQnjCyPLmfJbG/2j65nXKi5y8f5iT/HB4qxDlKXzkFB0WEslljVDuE
         OBN+kia/wQaJQR2odMUgHZprRicffMVku4cqBJT47CokzW358H2PD0A3FGDiNljlJkMm
         VgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745974252; x=1746579052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qCSPF9Frgb/+2+wOixYxGK5ULBPAm5cfOGeKd85/fA=;
        b=aLgCqygV5CK3YpJ+swTYrm42tnQnUzJwEFVt6cGGX341PB8OUFEFBUBNWIraBdyfwK
         S4pNk3LKuPfUtJ0VWzXd8i7Km6jOm1BRy/SgxHFe3j2/abeC8qUXM8arBotraTgTVm7w
         X7Nc+J+3S+OWBVKbFjpprXMAtxRJSS8h334yqgxcA+G3S2N2f6rkA3l+EXBAXsgw59d9
         Y9j+E3A9jCoPqQDMrdsisOJfH9yWhJa419W+S14UGyP9DsqllTmMx3Gmk/EsA9iS85cK
         7O7Gw3BKGDF6g/zJQcxO1nu/SARzLnE8sBAK7tI4JAwmgvPU+hcVQ0yOsKDmmNI87hwR
         Gm0w==
X-Gm-Message-State: AOJu0Yyr8zStRwLVhSE+m0cAmkA4NsQogpHmjRS5ZxVYz1ghQGV+zkbq
	3C9hpwktO8lDw0HjqrTGYcwAJxaICrT2twBKciZpizKrULvCRtnezpyXfPsjQUZpHT9K5WleddV
	QuIXG6v5ckxpOxWlgs/SNbQXuuZms3PBvfEi2zr3WODbOUEsjYo4W5kykmd+k4C2s7ztSRr/WHB
	7AMlnOB5fo7YkK7q6BlFFjahTktZ7YqSzln8Dt9SI=
X-Google-Smtp-Source: AGHT+IFsw7eIyMliPO+8jBXEus0UKFZjxJ91uLNaK+HuNCRnt938p3RW1qX7JnPDQCyzC4NYFHtPjV7M8h5pbQ==
X-Received: from pjbpb5.prod.google.com ([2002:a17:90b:3c05:b0:2ea:3a1b:f493])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2708:b0:305:2d68:8d57 with SMTP id 98e67ed59e1d1-30a343e8580mr924628a91.5.1745974252306;
 Tue, 29 Apr 2025 17:50:52 -0700 (PDT)
Date: Wed, 30 Apr 2025 00:50:47 +0000
In-Reply-To: <cover.1745970908.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1745970908.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <248aa4b0ef7e439e0446d25732af7246d119c6a9.1745970908.git.yepeilin@google.com>
Subject: [PATCH bpf-next 3/8] bpf, riscv64: Support load-acquire and
 store-release instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>, linux-riscv@lists.infradead.org, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, 
	Peilin Ye <yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Andrea Parri <parri.andrea@gmail.com>

Support BPF load-acquire (BPF_LOAD_ACQ) and store-release
(BPF_STORE_REL) instructions in the riscv64 JIT compiler.  For example,
consider the following 64-bit load-acquire (assuming little-endian):

  db 10 00 00 00 01 00 00  r1 = load_acquire((u64 *)(r1 + 0x0))
  95 00 00 00 00 00 00 00  exit

  opcode (0xdb): BPF_ATOMIC | BPF_DW | BPF_STX
  imm (0x00000100): BPF_LOAD_ACQ

The JIT compiler will emit an LD instruction followed by a FENCE R,RW
instruction for the above, e.g.:

  ld x7,0(x6)
  fence r,rw

Similarly, consider the following 16-bit store-release:

  cb 21 00 00 10 01 00 00  store_release((u16 *)(r1 + 0x0), w2)
  95 00 00 00 00 00 00 00  exit

  opcode (0xcb): BPF_ATOMIC | BPF_H | BPF_STX
  imm (0x00000110): BPF_STORE_REL

A FENCE RW,W instruction followed by an SH instruction will be emitted,
e.g.:

  fence rw,w
  sh x2,0(x4)

8-bit and 16-bit load-acquires are zero-extending (cf., LBU, LHU).  The
verifier always rejects misaligned load-acquires/store-releases (even if
BPF_F_ANY_ALIGNMENT is set), so the emitted load and store instructions
are guaranteed to be single-copy atomic.

Introduce primitives to emit the relevant (and the most common/used in
the kernel) fences, i.e. fences with R -> RW, RW -> W and RW -> RW.

Rename emit_atomic() to emit_atomic_rmw() to make it clear that it only
handles RMW atomics, and replace its is64 parameter to allow to perform
the required checks on the opsize (BPF_SIZE(code)).

Tested-by: Peilin Ye <yepeilin@google.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
[yepeilin@google.com: whitespace changes; cosmetic changes to commit
                      title and message]
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/riscv/net/bpf_jit.h        | 15 +++++++
 arch/riscv/net/bpf_jit_comp64.c | 77 ++++++++++++++++++++++++++++++---
 2 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 1d1c78d4cff1..e7b032dfd17f 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -608,6 +608,21 @@ static inline u32 rv_fence(u8 pred, u8 succ)
 	return rv_i_insn(imm11_0, 0, 0, 0, 0xf);
 }
 
+static inline void emit_fence_r_rw(struct rv_jit_context *ctx)
+{
+	emit(rv_fence(0x2, 0x3), ctx);
+}
+
+static inline void emit_fence_rw_w(struct rv_jit_context *ctx)
+{
+	emit(rv_fence(0x3, 0x1), ctx);
+}
+
+static inline void emit_fence_rw_rw(struct rv_jit_context *ctx)
+{
+	emit(rv_fence(0x3, 0x3), ctx);
+}
+
 static inline u32 rv_nop(void)
 {
 	return rv_i_insn(0, 0, 0, 0, 0x13);
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 953b6a20c69f..b71a9c88fb4f 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -607,11 +607,65 @@ static void emit_store_64(u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
 	emit_sd(RV_REG_T1, 0, rs, ctx);
 }
 
-static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
-			struct rv_jit_context *ctx)
+static int emit_atomic_ld_st(u8 rd, u8 rs, s16 off, s32 imm, u8 code, struct rv_jit_context *ctx)
+{
+	switch (imm) {
+	/* dst_reg = load_acquire(src_reg + off16) */
+	case BPF_LOAD_ACQ:
+		switch (BPF_SIZE(code)) {
+		case BPF_B:
+			emit_load_8(false, rd, off, rs, ctx);
+			break;
+		case BPF_H:
+			emit_load_16(false, rd, off, rs, ctx);
+			break;
+		case BPF_W:
+			emit_load_32(false, rd, off, rs, ctx);
+			break;
+		case BPF_DW:
+			emit_load_64(false, rd, off, rs, ctx);
+			break;
+		}
+		emit_fence_r_rw(ctx);
+		break;
+	/* store_release(dst_reg + off16, src_reg) */
+	case BPF_STORE_REL:
+		emit_fence_rw_w(ctx);
+		switch (BPF_SIZE(code)) {
+		case BPF_B:
+			emit_store_8(rd, off, rs, ctx);
+			break;
+		case BPF_H:
+			emit_store_16(rd, off, rs, ctx);
+			break;
+		case BPF_W:
+			emit_store_32(rd, off, rs, ctx);
+			break;
+		case BPF_DW:
+			emit_store_64(rd, off, rs, ctx);
+			break;
+		}
+		break;
+	default:
+		pr_err_once("bpf-jit: invalid atomic load/store opcode %02x\n", imm);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int emit_atomic_rmw(u8 rd, u8 rs, s16 off, s32 imm, u8 code,
+			   struct rv_jit_context *ctx)
 {
 	u8 r0;
 	int jmp_offset;
+	bool is64;
+
+	if (BPF_SIZE(code) != BPF_W && BPF_SIZE(code) != BPF_DW) {
+		pr_err_once("bpf-jit: 1- and 2-byte RMW atomics are not supported\n");
+		return -EINVAL;
+	}
+	is64 = BPF_SIZE(code) == BPF_DW;
 
 	if (off) {
 		if (is_12b_int(off)) {
@@ -688,9 +742,14 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
 		     rv_sc_w(RV_REG_T3, rs, rd, 0, 1), ctx);
 		jmp_offset = ninsns_rvoff(-6);
 		emit(rv_bne(RV_REG_T3, 0, jmp_offset >> 1), ctx);
-		emit(rv_fence(0x3, 0x3), ctx);
+		emit_fence_rw_rw(ctx);
 		break;
+	default:
+		pr_err_once("bpf-jit: invalid atomic RMW opcode %02x\n", imm);
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 #define BPF_FIXUP_OFFSET_MASK   GENMASK(26, 0)
@@ -1259,7 +1318,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 {
 	bool is64 = BPF_CLASS(insn->code) == BPF_ALU64 ||
 		    BPF_CLASS(insn->code) == BPF_JMP;
-	int s, e, rvoff, ret, i = insn - ctx->prog->insnsi;
+	int s, e, rvoff, ret = 0, i = insn - ctx->prog->insnsi;
 	struct bpf_prog_aux *aux = ctx->prog->aux;
 	u8 rd = -1, rs = -1, code = insn->code;
 	s16 off = insn->off;
@@ -1962,10 +2021,14 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_STX | BPF_MEM | BPF_DW:
 		emit_store_64(rd, off, rs, ctx);
 		break;
+	case BPF_STX | BPF_ATOMIC | BPF_B:
+	case BPF_STX | BPF_ATOMIC | BPF_H:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		emit_atomic(rd, rs, off, imm,
-			    BPF_SIZE(code) == BPF_DW, ctx);
+		if (bpf_atomic_is_load_store(insn))
+			ret = emit_atomic_ld_st(rd, rs, off, imm, code, ctx);
+		else
+			ret = emit_atomic_rmw(rd, rs, off, imm, code, ctx);
 		break;
 
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
@@ -2050,7 +2113,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		return -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)
-- 
2.49.0.901.g37484f566f-goog


