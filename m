Return-Path: <bpf+bounces-47503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA69F9F9DBD
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 02:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF3D166227
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 01:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB6F3FBB3;
	Sat, 21 Dec 2024 01:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cca485p2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268BA1BF37
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 01:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734744353; cv=none; b=Mq8EutXZPYbKgQ22OunbFjyu2+R2RWfiOKNIhCmcO1r/MuCxZjpW8GCsUyUHkQkCiZ21TfrUXGCAPZ2pf3jepBYQ5wNsIcQje04VjxdeebzZPSE03ThT6IThRArZGR+aABKfMRXt7qIU12yX31JVGwKKeEcZbD/04PQ1SquFaNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734744353; c=relaxed/simple;
	bh=HieM+O12nJwUAZqYnUf0imp77QA9IQJTUEcK+710otI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s4aG9STYFJdkVfz0FuDRBUXfK2XLVsKB0IulxnuR8N7x10fY+YbHpQbqXXePgaJd15ME3BZbnQkA1H1NERMlJMEY8ZvZOD2pmxOM0CSq0c8Csv1bwhcO0WTiK0C2D+mjtrYUiKWMG/LHa31OdmKHZN3kRnOJQDBdBAIUMfdSwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cca485p2; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-29fd2a9dd35so1875611fac.1
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 17:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734744349; x=1735349149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mX9CpM+nPYklWRPu/tPXprtM/OQW3vEFNUZ72JhAffA=;
        b=cca485p2euhbSZf+RZFcA4JrEjCNX4GTstmI573NUzWNAXMaGU/fox+mD2Y85pEC4s
         k5PRBIL0niMOUOvpZhxvLMyxT6oQnqHj7OWbOREeS3LR/e4RL2Km3L6udVmfYGPk4Kfc
         HveUrq2Nd1o3KQH0qtV34fhcz82qlsbQB/H1tZXZQ34Iys9OCGYbY9FkLZhryJB1wp3O
         OFwzbkZ6oZ42Fuechz9dnJzGlA5Wz8JtBnMO38Z23FvtohzDnRwm2d8wQ7HJYVZVzosy
         WeGiktdSgtwz3iOgsz8yqplMV45F+VT9jL5RywNOKPOZdSeqPnMn+1AExaUJ/JKrOEdp
         DH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734744349; x=1735349149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mX9CpM+nPYklWRPu/tPXprtM/OQW3vEFNUZ72JhAffA=;
        b=LTf9QjxyOfBRKOgDlXRIX3E4YegdaA+KS3fGyAnuFziw+cft+KwWEyRIA83hXryFz8
         FKxduSVY3ceSpXS3DThFScZgp66uV/H1SLGT+FClszpYDE7ILbgqimLznkumt6CVPiUl
         gsep8M61QCmV4IB9mf3XD9k7cgKn4JdLOD8JYO5pkSGz5Lzjbcly0I4CjFXLcSzMVewD
         XuzdaN890GErEE3zSZ8HMSYI23evuoslVOopdKJaLhi0Pi5Brc3xO6zmV8OCu4C6qmkX
         Duo5N40IHoVw6i7jNDGt4D4qycratCjOG96hJoyMD4iOXQ0H4f/ly2B8ytSuQLF19IpW
         2s6Q==
X-Gm-Message-State: AOJu0YyP+KlUpnpAv2ZXIn3RQu5wvFffGRIlV1QV2TpgPhRJMJ7sq0oF
	Sh1WNzDktO0TYS38u8XBldrOoo9Bpyt8ydfQHmCmPkMBL4P/uoZo4/38NdDT9ks78B1tlGS4FY1
	lk8nyiQi5dG0m03wuabJ6Al5sEGbldHJHAKkh2fB3+I04vZsZgwjVtMsk2ws5Ot8h5iGo29779P
	AqQly7OvdbTgoOrdM1GDFHgZbEXmAoYA1cX/tktB0=
X-Google-Smtp-Source: AGHT+IGfrliDwZE1i61hVef4Ti0b/q6w3sxJFHTcveHuR3fqxkqIllRyaNGTn342Hd1OPEwwQ2hXiXno9ZAsAg==
X-Received: from oabwe11.prod.google.com ([2002:a05:6871:a60b:b0:289:3039:6009])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:6e06:b0:29e:1a11:ef26 with SMTP id 586e51a60fabf-2a7fb09141emr2948930fac.11.1734744349267;
 Fri, 20 Dec 2024 17:25:49 -0800 (PST)
Date: Sat, 21 Dec 2024 01:25:30 +0000
In-Reply-To: <cover.1734742802.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1734742802.git.yepeilin@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <6ca65dc2916dba7490c4fd7a8b727b662138d606.1734742802.git.yepeilin@google.com>
Subject: [PATCH RFC bpf-next v1 2/4] bpf: Introduce load-acquire and
 store-release instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, 
	David Vernet <dvernet@meta.com>, Dave Marchevsky <davemarchevsky@meta.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce BPF instructions with load-acquire and store-release
semantics, as discussed in [1].  The following new flags are defined:

  BPF_ATOMIC_LOAD         0x10
  BPF_ATOMIC_STORE        0x20
  BPF_ATOMIC_TYPE(imm)    ((imm) & 0xf0)

  BPF_RELAXED        0x0
  BPF_ACQUIRE        0x1
  BPF_RELEASE        0x2
  BPF_ACQ_REL        0x3
  BPF_SEQ_CST        0x4

  BPF_LOAD_ACQ       (BPF_ATOMIC_LOAD | BPF_ACQUIRE)
  BPF_STORE_REL      (BPF_ATOMIC_STORE | BPF_RELEASE)

A "load-acquire" is a BPF_STX | BPF_ATOMIC instruction with the 'imm'
field set to BPF_LOAD_ACQ (0x11).

Similarly, a "store-release" is a BPF_STX | BPF_ATOMIC instruction with
the 'imm' field set to BPF_STORE_REL (0x22).

Unlike existing atomic operations that only support BPF_W (32-bit) and
BPF_DW (64-bit) size modifiers, load-acquires and store-releases also
support BPF_B (8-bit) and BPF_H (16-bit).  An 8- or 16-bit load-acquire
zero-extends the value before writing it to a 32-bit register, just like
ARM64 instruction LDARH and friends.

As an example, consider the following 64-bit load-acquire BPF
instruction (assuming little-endian from now on):

  db 10 00 00 11 00 00 00  r0 = load_acquire((u64 *)(r1 + 0x0))

  opcode (0xdb): BPF_ATOMIC | BPF_DW | BPF_STX
  imm (0x00000011): BPF_LOAD_ACQ

For ARM64, an LDAR instruction will be generated by the JIT compiler for
the above:

  ldar  x7, [x0]

Similarly, a 16-bit BPF store-release:

  cb 21 00 00 22 00 00 00  store_release((u16 *)(r1 + 0x0), w2)

  opcode (0xcb): BPF_ATOMIC | BPF_H | BPF_STX
  imm (0x00000022): BPF_STORE_REL

An STLRH will be generated for it:

  stlrh  w1, [x0]

For a complete mapping for ARM64:

  load-acquire     8-bit  LDARB
 (BPF_LOAD_ACQ)   16-bit  LDARH
                  32-bit  LDAR (32-bit)
                  64-bit  LDAR (64-bit)
  store-release    8-bit  STLRB
 (BPF_STORE_REL)  16-bit  STLRH
                  32-bit  STLR (32-bit)
                  64-bit  STLR (64-bit)

Reviewed-by: Josh Don <joshdon@google.com>
Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/arm64/include/asm/insn.h  |  8 ++++
 arch/arm64/lib/insn.c          | 34 ++++++++++++++
 arch/arm64/net/bpf_jit.h       | 20 ++++++++
 arch/arm64/net/bpf_jit_comp.c  | 85 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/bpf.h       | 13 ++++++
 kernel/bpf/core.c              | 41 +++++++++++++++-
 kernel/bpf/disasm.c            | 14 ++++++
 kernel/bpf/verifier.c          | 32 +++++++++----
 tools/include/uapi/linux/bpf.h | 13 ++++++
 9 files changed, 246 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index e390c432f546..bbfdbe570ff6 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -188,8 +188,10 @@ enum aarch64_insn_ldst_type {
 	AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX,
 	AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX,
 	AARCH64_INSN_LDST_STORE_PAIR_POST_INDEX,
+	AARCH64_INSN_LDST_LOAD_ACQ,
 	AARCH64_INSN_LDST_LOAD_EX,
 	AARCH64_INSN_LDST_LOAD_ACQ_EX,
+	AARCH64_INSN_LDST_STORE_REL,
 	AARCH64_INSN_LDST_STORE_EX,
 	AARCH64_INSN_LDST_STORE_REL_EX,
 	AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET,
@@ -351,6 +353,8 @@ __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
 __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
 __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
 __AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
+__AARCH64_INSN_FUNCS(load_acq,  0x3FC08000, 0x08C08000)
+__AARCH64_INSN_FUNCS(store_rel, 0x3FC08000, 0x08808000)
 __AARCH64_INSN_FUNCS(load_ex,	0x3F400000, 0x08400000)
 __AARCH64_INSN_FUNCS(store_ex,	0x3F400000, 0x08000000)
 __AARCH64_INSN_FUNCS(mops,	0x3B200C00, 0x19000400)
@@ -602,6 +606,10 @@ u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 				     int offset,
 				     enum aarch64_insn_variant variant,
 				     enum aarch64_insn_ldst_type type);
+u32 aarch64_insn_gen_load_acq_store_rel(enum aarch64_insn_register reg,
+					enum aarch64_insn_register base,
+					enum aarch64_insn_size_type size,
+					enum aarch64_insn_ldst_type type);
 u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 				   enum aarch64_insn_register base,
 				   enum aarch64_insn_register state,
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index b008a9b46a7f..80e5b191d96a 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -540,6 +540,40 @@ u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 					     offset >> shift);
 }
 
+u32 aarch64_insn_gen_load_acq_store_rel(enum aarch64_insn_register reg,
+					enum aarch64_insn_register base,
+					enum aarch64_insn_size_type size,
+					enum aarch64_insn_ldst_type type)
+{
+	u32 insn;
+
+	switch (type) {
+	case AARCH64_INSN_LDST_LOAD_ACQ:
+		insn = aarch64_insn_get_load_acq_value();
+		break;
+	case AARCH64_INSN_LDST_STORE_REL:
+		insn = aarch64_insn_get_store_rel_value();
+		break;
+	default:
+		pr_err("%s: unknown load-acquire/store-release encoding %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn = aarch64_insn_encode_ldst_size(size, insn);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
+					    reg);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn,
+					    base);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT2, insn,
+					    AARCH64_INSN_REG_ZR);
+
+	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RS, insn,
+					    AARCH64_INSN_REG_ZR);
+}
+
 u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 				   enum aarch64_insn_register base,
 				   enum aarch64_insn_register state,
diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index b22ab2f97a30..a3b0e693a125 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -119,6 +119,26 @@
 	aarch64_insn_gen_load_store_ex(Rt, Rn, Rs, A64_SIZE(sf), \
 				       AARCH64_INSN_LDST_STORE_REL_EX)
 
+/* Load-acquire & store-release */
+#define A64_LDAR(Rt, Rn, size)  \
+	aarch64_insn_gen_load_acq_store_rel(Rt, Rn, AARCH64_INSN_SIZE_##size, \
+					    AARCH64_INSN_LDST_LOAD_ACQ)
+#define A64_STLR(Rt, Rn, size)  \
+	aarch64_insn_gen_load_acq_store_rel(Rt, Rn, AARCH64_INSN_SIZE_##size, \
+					    AARCH64_INSN_LDST_STORE_REL)
+
+/* Rt = [Rn] (load acquire) */
+#define A64_LDARB(Wt, Xn)	A64_LDAR(Wt, Xn, 8)
+#define A64_LDARH(Wt, Xn)	A64_LDAR(Wt, Xn, 16)
+#define A64_LDAR32(Wt, Xn)	A64_LDAR(Wt, Xn, 32)
+#define A64_LDAR64(Xt, Xn)	A64_LDAR(Xt, Xn, 64)
+
+/* [Rn] = Rt (store release) */
+#define A64_STLRB(Wt, Xn)	A64_STLR(Wt, Xn, 8)
+#define A64_STLRH(Wt, Xn)	A64_STLR(Wt, Xn, 16)
+#define A64_STLR32(Wt, Xn)	A64_STLR(Wt, Xn, 32)
+#define A64_STLR64(Xt, Xn)	A64_STLR(Xt, Xn, 64)
+
 /*
  * LSE atomics
  *
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 66708b95493a..15fc0f391f14 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -634,6 +634,80 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	return 0;
 }
 
+static inline bool is_atomic_load_store(const s32 imm)
+{
+	const s32 type = BPF_ATOMIC_TYPE(imm);
+
+	return type == BPF_ATOMIC_LOAD || type == BPF_ATOMIC_STORE;
+}
+
+static int emit_atomic_load_store(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s16 off = insn->off;
+	const u8 code = insn->code;
+	const bool arena = BPF_MODE(code) == BPF_PROBE_ATOMIC;
+	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
+	const u8 dst = bpf2a64[insn->dst_reg];
+	const u8 src = bpf2a64[insn->src_reg];
+	const u8 tmp = bpf2a64[TMP_REG_1];
+	u8 ptr;
+
+	if (BPF_ATOMIC_TYPE(insn->imm) == BPF_ATOMIC_LOAD)
+		ptr = src;
+	else
+		ptr = dst;
+
+	if (off) {
+		emit_a64_mov_i(true, tmp, off, ctx);
+		emit(A64_ADD(true, tmp, tmp, ptr), ctx);
+		ptr = tmp;
+	}
+	if (arena) {
+		emit(A64_ADD(true, tmp, ptr, arena_vm_base), ctx);
+		ptr = tmp;
+	}
+
+	switch (insn->imm) {
+	case BPF_LOAD_ACQ:
+		switch (BPF_SIZE(code)) {
+		case BPF_B:
+			emit(A64_LDARB(dst, ptr), ctx);
+			break;
+		case BPF_H:
+			emit(A64_LDARH(dst, ptr), ctx);
+			break;
+		case BPF_W:
+			emit(A64_LDAR32(dst, ptr), ctx);
+			break;
+		case BPF_DW:
+			emit(A64_LDAR64(dst, ptr), ctx);
+			break;
+		}
+		break;
+	case BPF_STORE_REL:
+		switch (BPF_SIZE(code)) {
+		case BPF_B:
+			emit(A64_STLRB(src, ptr), ctx);
+			break;
+		case BPF_H:
+			emit(A64_STLRH(src, ptr), ctx);
+			break;
+		case BPF_W:
+			emit(A64_STLR32(src, ptr), ctx);
+			break;
+		case BPF_DW:
+			emit(A64_STLR64(src, ptr), ctx);
+			break;
+		}
+		break;
+	default:
+		pr_err_once("unknown atomic load/store op code %02x\n", insn->imm);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_ARM64_LSE_ATOMICS
 static int emit_lse_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 {
@@ -1641,11 +1715,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			return ret;
 		break;
 
+	case BPF_STX | BPF_ATOMIC | BPF_B:
+	case BPF_STX | BPF_ATOMIC | BPF_H:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_B:
+	case BPF_STX | BPF_PROBE_ATOMIC | BPF_H:
 	case BPF_STX | BPF_PROBE_ATOMIC | BPF_W:
 	case BPF_STX | BPF_PROBE_ATOMIC | BPF_DW:
-		if (cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
+		if (is_atomic_load_store(insn->imm))
+			ret = emit_atomic_load_store(insn, ctx);
+		else if (cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
 			ret = emit_lse_atomic(insn, ctx);
 		else
 			ret = emit_ll_sc_atomic(insn, ctx);
@@ -2669,7 +2749,8 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 	switch (insn->code) {
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		if (!cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
+		if (!is_atomic_load_store(insn->imm) &&
+		    !cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
 			return false;
 	}
 	return true;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2acf9b336371..4a20a125eb46 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -51,6 +51,19 @@
 #define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
 #define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
 
+#define BPF_ATOMIC_LOAD		0x10
+#define BPF_ATOMIC_STORE	0x20
+#define BPF_ATOMIC_TYPE(imm)	((imm) & 0xf0)
+
+#define BPF_RELAXED	0x00
+#define BPF_ACQUIRE	0x01
+#define BPF_RELEASE	0x02
+#define BPF_ACQ_REL	0x03
+#define BPF_SEQ_CST	0x04
+
+#define BPF_LOAD_ACQ	(BPF_ATOMIC_LOAD | BPF_ACQUIRE)		/* load-acquire */
+#define BPF_STORE_REL	(BPF_ATOMIC_STORE | BPF_RELEASE)	/* store-release */
+
 enum bpf_cond_pseudo_jmp {
 	BPF_MAY_GOTO = 0,
 };
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index da729cbbaeb9..ab082ab9d535 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1663,14 +1663,17 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
 	INSN_3(JMP, JSET, K),			\
 	INSN_2(JMP, JA),			\
 	INSN_2(JMP32, JA),			\
+	/* Atomic operations. */		\
+	INSN_3(STX, ATOMIC, B),			\
+	INSN_3(STX, ATOMIC, H),			\
+	INSN_3(STX, ATOMIC, W),			\
+	INSN_3(STX, ATOMIC, DW),		\
 	/* Store instructions. */		\
 	/*   Register based. */			\
 	INSN_3(STX, MEM,  B),			\
 	INSN_3(STX, MEM,  H),			\
 	INSN_3(STX, MEM,  W),			\
 	INSN_3(STX, MEM,  DW),			\
-	INSN_3(STX, ATOMIC, W),			\
-	INSN_3(STX, ATOMIC, DW),		\
 	/*   Immediate based. */		\
 	INSN_3(ST, MEM, B),			\
 	INSN_3(ST, MEM, H),			\
@@ -2169,6 +2172,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 
 	STX_ATOMIC_DW:
 	STX_ATOMIC_W:
+	STX_ATOMIC_H:
+	STX_ATOMIC_B:
 		switch (IMM) {
 		ATOMIC_ALU_OP(BPF_ADD, add)
 		ATOMIC_ALU_OP(BPF_AND, and)
@@ -2196,6 +2201,38 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 					(atomic64_t *)(unsigned long) (DST + insn->off),
 					(u64) BPF_R0, (u64) SRC);
 			break;
+		case BPF_LOAD_ACQ:
+			switch (BPF_SIZE(insn->code)) {
+#define LOAD_ACQUIRE(SIZEOP, SIZE)				\
+			case BPF_##SIZEOP:			\
+				DST = (SIZE)smp_load_acquire(	\
+					(SIZE *)(unsigned long)(SRC + insn->off));	\
+				break;
+			LOAD_ACQUIRE(B,   u8)
+			LOAD_ACQUIRE(H,  u16)
+			LOAD_ACQUIRE(W,  u32)
+			LOAD_ACQUIRE(DW, u64)
+#undef LOAD_ACQUIRE
+			default:
+				goto default_label;
+			}
+			break;
+		case BPF_STORE_REL:
+			switch (BPF_SIZE(insn->code)) {
+#define STORE_RELEASE(SIZEOP, SIZE)			\
+			case BPF_##SIZEOP:		\
+				smp_store_release(	\
+					(SIZE *)(unsigned long)(DST + insn->off), (SIZE)SRC);	\
+				break;
+			STORE_RELEASE(B,   u8)
+			STORE_RELEASE(H,  u16)
+			STORE_RELEASE(W,  u32)
+			STORE_RELEASE(DW, u64)
+#undef STORE_RELEASE
+			default:
+				goto default_label;
+			}
+			break;
 
 		default:
 			goto default_label;
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 309c4aa1b026..2a354a44f209 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -267,6 +267,20 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == BPF_LOAD_ACQ) {
+			verbose(cbs->private_data, "(%02x) %s%d = load_acquire((%s *)(r%d %+d))\n",
+				insn->code,
+				BPF_SIZE(insn->code) == BPF_DW ? "r" : "w", insn->dst_reg,
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->src_reg, insn->off);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == BPF_STORE_REL) {
+			verbose(cbs->private_data, "(%02x) store_release((%s *)(r%d %+d), %s%d)\n",
+				insn->code,
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off,
+				BPF_SIZE(insn->code) == BPF_DW ? "r" : "w", insn->src_reg);
 		} else {
 			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fa40a0440590..dc3ecc925b97 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3480,7 +3480,7 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	if (class == BPF_STX) {
-		/* BPF_STX (including atomic variants) has multiple source
+		/* BPF_STX (including atomic variants) has one or more source
 		 * operands, one of which is a ptr. Check whether the caller is
 		 * asking about it.
 		 */
@@ -7550,6 +7550,8 @@ static int check_load(struct bpf_verifier_env *env, struct bpf_insn *insn, const
 
 static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
 {
+	const int bpf_size = BPF_SIZE(insn->code);
+	bool write_only = false;
 	int load_reg;
 	int err;
 
@@ -7564,17 +7566,21 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	case BPF_XOR | BPF_FETCH:
 	case BPF_XCHG:
 	case BPF_CMPXCHG:
+		if (bpf_size != BPF_W && bpf_size != BPF_DW) {
+			verbose(env, "invalid atomic operand size\n");
+			return -EINVAL;
+		}
+		break;
+	case BPF_LOAD_ACQ:
+		return check_load(env, insn, "atomic");
+	case BPF_STORE_REL:
+		write_only = true;
 		break;
 	default:
 		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
 		return -EINVAL;
 	}
 
-	if (BPF_SIZE(insn->code) != BPF_W && BPF_SIZE(insn->code) != BPF_DW) {
-		verbose(env, "invalid atomic operand size\n");
-		return -EINVAL;
-	}
-
 	/* check src1 operand */
 	err = check_reg_arg(env, insn->src_reg, SRC_OP);
 	if (err)
@@ -7615,6 +7621,9 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 		return -EACCES;
 	}
 
+	if (write_only)
+		goto skip_read_check;
+
 	if (insn->imm & BPF_FETCH) {
 		if (insn->imm == BPF_CMPXCHG)
 			load_reg = BPF_REG_0;
@@ -7636,14 +7645,15 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	 * case to simulate the register fill.
 	 */
 	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-			       BPF_SIZE(insn->code), BPF_READ, -1, true, false);
+			       bpf_size, BPF_READ, -1, true, false);
 	if (!err && load_reg >= 0)
 		err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-				       BPF_SIZE(insn->code), BPF_READ, load_reg,
-				       true, false);
+				       bpf_size, BPF_READ, load_reg, true,
+				       false);
 	if (err)
 		return err;
 
+skip_read_check:
 	if (is_arena_reg(env, insn->dst_reg)) {
 		err = save_aux_ptr_type(env, PTR_TO_ARENA, false);
 		if (err)
@@ -20320,7 +20330,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			   insn->code == (BPF_ST | BPF_MEM | BPF_W) ||
 			   insn->code == (BPF_ST | BPF_MEM | BPF_DW)) {
 			type = BPF_WRITE;
-		} else if ((insn->code == (BPF_STX | BPF_ATOMIC | BPF_W) ||
+		} else if ((insn->code == (BPF_STX | BPF_ATOMIC | BPF_B) ||
+			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_H) ||
+			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_W) ||
 			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_DW)) &&
 			   env->insn_aux_data[i + delta].ptr_type == PTR_TO_ARENA) {
 			insn->code = BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2acf9b336371..4a20a125eb46 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -51,6 +51,19 @@
 #define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
 #define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
 
+#define BPF_ATOMIC_LOAD		0x10
+#define BPF_ATOMIC_STORE	0x20
+#define BPF_ATOMIC_TYPE(imm)	((imm) & 0xf0)
+
+#define BPF_RELAXED	0x00
+#define BPF_ACQUIRE	0x01
+#define BPF_RELEASE	0x02
+#define BPF_ACQ_REL	0x03
+#define BPF_SEQ_CST	0x04
+
+#define BPF_LOAD_ACQ	(BPF_ATOMIC_LOAD | BPF_ACQUIRE)		/* load-acquire */
+#define BPF_STORE_REL	(BPF_ATOMIC_STORE | BPF_RELEASE)	/* store-release */
+
 enum bpf_cond_pseudo_jmp {
 	BPF_MAY_GOTO = 0,
 };
-- 
2.47.1.613.gc27f4b7a9f-goog


