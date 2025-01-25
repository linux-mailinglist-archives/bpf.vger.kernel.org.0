Return-Path: <bpf+bounces-49750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A572BA1C073
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A627A2354
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C6F204689;
	Sat, 25 Jan 2025 02:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bi2U9wZp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4EC1FA26C
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 02:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737771558; cv=none; b=gJBaWpzdq8yYV4/iH0BNk6sOb6/jCO/Ny4LYH/cp+f0JT1EXEzT0BgzCy4QixLpV8/3jn4xoWczQJg0zx7XDbg72R7EtFIN1os/h+VHgn/exsBMDoDEjDI4WxQ92i5dq+vIuIfXg4/asxBzFS/wxmemaV4gj32e10/HiSFZ30Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737771558; c=relaxed/simple;
	bh=NllgFKw6vtsbjQq8bKvhSHXxpeTqsCYhCXJrfqLuyeI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UidZMP+4PY3utMT7ZPqKHWI17la9LiIS0mBDTCDlMmZRWBtKWqe3OkB+rBTOWQXn6k7SGrerdcTG74rMdZ7cvWRBJbV5670XTNvSRU0oJpSri4pk/O2B4M3Ldvy8YV0HaJwEOOpO6ypi3803sUMZ1D2m99+gSZ5MYOgVNtSgDtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bi2U9wZp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso5497036a91.1
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 18:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737771556; x=1738376356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3/pYcf0sANYo9TEsaEY4ONRLzSTmKybwrzwLYycpJYE=;
        b=bi2U9wZpzPvuc9YLs+d6lIGReufKyWEWIJtyLbSp2FM68dX7zStpdsAYniXpxstfFB
         YvVHvhoOMwSv02jCjBgO4Slszq2Lu0vslfmPc5disDzMtSG6cHqq7FjBdD4e1z5DnlBc
         wca4oOSAOvJfgUx5mw7o3h2Pexeimto53tGFm/pxJGgcAEy67YYW+lGYltXEF/ncxiDf
         nNpjb9Fyzj+d+KVUwkdD1gakmRlvMFpFVACxGdxpoVMggJ5Qp3dNVWbj/bvsQpzl+7Gf
         G5tXL6DjrpdnTnyHDyNK2hANIxyiVzthblht09WHEY1UYq6wYnUL3SOI9+8qTvVqedgP
         VtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737771556; x=1738376356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/pYcf0sANYo9TEsaEY4ONRLzSTmKybwrzwLYycpJYE=;
        b=dz50B7P05ZbFz7iEW0qYkwI7jPwNa1mG5kZVlp3VMVTxSAti5NL5KN0NbVAZ9zWbfE
         GrEnl4a4fQj2kxPlyJVGNZ+WyblGvfCCnrQdylffDdyU+pcBDZvo2WOfsEeScJmTYTQp
         iY83sLQT6gtVVOofp+3eGSyi+h/uKLIT3e26CQnpWILHxyNbyNw5BZc1NjiXejKzsZbi
         djzgHdyID/n+JgBWeyyg1QF4Tq818fEtlruV44guaNVxsIxmqo5tGX6hl5Lda5ruhlzs
         o8F4sx4xFHrNKXNAKzp+jH49WW/K5mFn2ELGFoOEWa7lKBsYaEHhjv8ao6FWCavYggaY
         e4pw==
X-Gm-Message-State: AOJu0Yxm1NGzDavI1CboMqm8MAyjlwIE4WgAY9yFRsUMGyESJGkY8MPQ
	gBnpA4eqXFd/Wmck5l+DfqA5hDaLNCtTJSFBDwxNcnqOuLKTPdUEyh6IkOULMtU3A4nHpqfsrB5
	1tl6zrHLlWXNZeZZtdXXsXyVw//BSYM9TGLbx2YHoe/tbqMv84vo2i9Ek2w+QTVy7ymrEFLDRJb
	GjWZMGlwIuAW6nTDoMjzHYmbjPyJZUviQpHxWuZNY=
X-Google-Smtp-Source: AGHT+IHLeumw4Cen/udsKyGtvAVMvHHnzYuG7MNiJRP+RmXCfv67AF/APEi6auE44B6c9jmN91D0FezxRYqdMA==
X-Received: from pjd4.prod.google.com ([2002:a17:90b:54c4:b0:2d3:d4ca:5fb0])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e4e:b0:2ee:fd53:2b17 with SMTP id 98e67ed59e1d1-2f782d97276mr45715232a91.29.1737771555858;
 Fri, 24 Jan 2025 18:19:15 -0800 (PST)
Date: Sat, 25 Jan 2025 02:19:09 +0000
In-Reply-To: <cover.1737763916.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1737763916.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <1733f889a4b46d13844d1083b5cfba5005b22e86.1737763916.git.yepeilin@google.com>
Subject: [PATCH bpf-next v1 6/8] bpf, arm64: Support load-acquire and
 store-release instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Support BPF load-acquire (BPF_LOAD_ACQ) and store-release
(BPF_STORE_REL) instructions in the arm64 JIT compiler.  For example:

  db 10 00 00 11 00 00 00  r0 = load_acquire((u64 *)(r1 + 0x0))
  95 00 00 00 00 00 00 00  exit

  opcode (0xdb): BPF_ATOMIC | BPF_DW | BPF_STX
  imm (0x00000011): BPF_LOAD_ACQ

The JIT compiler would emit an LDAR instruction for the above, e.g.:

  ldar  x7, [x0]

Similarly, consider the following 16-bit store-release:

  cb 21 00 00 22 00 00 00  store_release((u16 *)(r1 + 0x0), w2)
  95 00 00 00 00 00 00 00  exit

  opcode (0xcb): BPF_ATOMIC | BPF_H | BPF_STX
  imm (0x00000022): BPF_ATOMIC_STORE | BPF_RELEASE

An STLRH instruction would be emitted, e.g.:

  stlrh  w1, [x0]

For a complete mapping:

  load-acquire     8-bit  LDARB
 (BPF_LOAD_ACQ)   16-bit  LDARH
                  32-bit  LDAR (32-bit)
                  64-bit  LDAR (64-bit)
  store-release    8-bit  STLRB
 (BPF_STORE_REL)  16-bit  STLRH
                  32-bit  STLR (32-bit)
                  64-bit  STLR (64-bit)

Arena accesses are supported.
bpf_jit_supports_insn(..., /*in_arena=*/true) always returns true for
BPF_LOAD_ACQ and BPF_STORE_REL instructions, as they don't depend on
ARM64_HAS_LSE_ATOMICS.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/arm64/net/bpf_jit.h      | 20 ++++++++
 arch/arm64/net/bpf_jit_comp.c | 92 ++++++++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 2 deletions(-)

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
index 8446848edddb..488cbe094551 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -647,6 +647,87 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
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
+	const s32 type = BPF_ATOMIC_TYPE(insn->imm);
+	const s16 off = insn->off;
+	const u8 code = insn->code;
+	const bool arena = BPF_MODE(code) == BPF_PROBE_ATOMIC;
+	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
+	const u8 dst = bpf2a64[insn->dst_reg];
+	const u8 src = bpf2a64[insn->src_reg];
+	const u8 tmp = bpf2a64[TMP_REG_1];
+	u8 reg;
+
+	switch (type) {
+	case BPF_ATOMIC_LOAD:
+		reg = src;
+		break;
+	case BPF_ATOMIC_STORE:
+		reg = dst;
+		break;
+	default:
+		pr_err_once("unknown atomic load/store op type %02x\n", type);
+		return -EINVAL;
+	}
+
+	if (off) {
+		emit_a64_add_i(1, tmp, reg, tmp, off, ctx);
+		reg = tmp;
+	}
+	if (arena) {
+		emit(A64_ADD(1, tmp, reg, arena_vm_base), ctx);
+		reg = tmp;
+	}
+
+	switch (insn->imm) {
+	case BPF_LOAD_ACQ:
+		switch (BPF_SIZE(code)) {
+		case BPF_B:
+			emit(A64_LDARB(dst, reg), ctx);
+			break;
+		case BPF_H:
+			emit(A64_LDARH(dst, reg), ctx);
+			break;
+		case BPF_W:
+			emit(A64_LDAR32(dst, reg), ctx);
+			break;
+		case BPF_DW:
+			emit(A64_LDAR64(dst, reg), ctx);
+			break;
+		}
+		break;
+	case BPF_STORE_REL:
+		switch (BPF_SIZE(code)) {
+		case BPF_B:
+			emit(A64_STLRB(src, reg), ctx);
+			break;
+		case BPF_H:
+			emit(A64_STLRH(src, reg), ctx);
+			break;
+		case BPF_W:
+			emit(A64_STLR32(src, reg), ctx);
+			break;
+		case BPF_DW:
+			emit(A64_STLR64(src, reg), ctx);
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
@@ -1641,11 +1722,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
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
@@ -2669,7 +2756,8 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 	switch (insn->code) {
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		if (!cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
+		if (!is_atomic_load_store(insn->imm) &&
+		    !cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
 			return false;
 	}
 	return true;
-- 
2.48.1.262.g85cc9f2d1e-goog


