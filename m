Return-Path: <bpf+bounces-53150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B694A4D082
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 02:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FB5168C10
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 01:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F3E86359;
	Tue,  4 Mar 2025 01:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2dqfWPPh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0D86328
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 01:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050399; cv=none; b=fAPhtwDbQOjE68C5t/ydcorYfKWhYdKYC5Aw+uTRmNdmFvgNDbWJWgNIAdeIayAu4p6IeHsyKAbGsZX1/g2TN9Cxqu2lax72kxM8AVWp5OyNIalAxpPfepxBZnpF06WjnpFo+pyO6IDqeaWq5ynRjifAZ8/Sf6PASodOch+l6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050399; c=relaxed/simple;
	bh=IOnqgj0XTH757S36DJspSbk0YPI+XFopVV55XSeDweM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cIVYzYcq+LLs5YEvOreYTjk0hYHyqIVz2Wk0YZqudmZbEmH4dgDPkLo5LkMccTIj6lauri6mRX+TgUOnNh20LHG+8rjYHf+Juo1SNbgHysgBxqkN71HCL/WX2FiJauMCJK2nHmx5G7rVnVgV4fDct+ry2LcEy9IOjBkXVHvxXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2dqfWPPh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22355de1de8so88378755ad.1
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 17:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741050397; x=1741655197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8j2BSjmna2ghQKBcJTnNrRFDhjm44gnJpM2ihIwsNrg=;
        b=2dqfWPPhupd99PkzCE1WTIvR+8oysd9nHU3ocPA3+gm8sxBLwY75eOq6Fe0g/UnZik
         p9GAsb7F4K6WWW01Xgdp5CsMfhQDKBKAiqvJAsrh/Dtr0oAHivLy56d3uUPlt2SH6qLX
         /JyY9yJhZb9mJ8CO78QOzlCFMThuJz69JSYLblBYkBtf/3bQs1P9zISQOD19bKW5dDrM
         f67YV90ORTnihUx4fdfrFp/+tsS1wIve9ytH30pCDXb+1m+bKrkUoenmXwvbMs2574fF
         81VXJlF8+vfCQRVG/z/qwqHYGZGS4dDt+yxqa1ykxf9Sf3dqtQAkRnBKbU3VnXVmvNOO
         fpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741050397; x=1741655197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8j2BSjmna2ghQKBcJTnNrRFDhjm44gnJpM2ihIwsNrg=;
        b=ep+hDbYeTj82TSSqUmmmkX59wuLhlBooSQoPHTv5LXZ5Pc6VQxFhW0ozZ3FMs34YR8
         Z4M21VYdwr3Kh82rj5v2pcZwgFsGbX3k9RD4SiKvnlpvvBR4jt02GFicKgTXa1aQwInk
         S4j2sNMPxkA7T1CQMbW2a3uvYtNXP5445GpmzIOU5bDOtjvYsoR+9GcQyDBtGhJf7q6g
         Iipz9k5xmHuda6CMDgX9WdxpWw7NwpcTGqmp/mQVV1y14ygWdQlcVI7BfM3zIptDwASz
         YQxyPyfEVf6v5MjT8yoe7jllcqGgfXz44l861QnFdEtTOHRWc58f0Os7WvyUsSVFxhip
         nGuA==
X-Gm-Message-State: AOJu0YyRbjT/ZulHlMLI5QDIx9H5s9Kvl5pR4bbD00PBZL/KP2VK0l8i
	yCdMuCJQkKJ95vH0uiyGEaC9oQJ3peFHQJUs8tndFLtI4qAQb4luR4wCydqtuv9PwHAYlGbLKFY
	k5yZAU3gMwQjZ/vKFMISyqIyEef9PG422t/LywYJkG80wUakIc4OV31XFjDG/VG2YXbqua47uUJ
	ff4IR+WkQDc+OBynnwL96VOKxfEcf8n1P5F/YcAWQ=
X-Google-Smtp-Source: AGHT+IE7M891EJTho95tx1UxJpaGA/omWB37pXHj9T2PWEUKzyyDN1PoHqFl1Dal/se2wYInDNaDudJsn8p+6Q==
X-Received: from pfqz13.prod.google.com ([2002:aa7:9e4d:0:b0:732:51fc:618f])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:eccc:b0:215:6489:cfb8 with SMTP id d9443c01a7336-22368f6365emr297247725ad.10.1741050397044;
 Mon, 03 Mar 2025 17:06:37 -0800 (PST)
Date: Tue,  4 Mar 2025 01:06:33 +0000
In-Reply-To: <cover.1741049567.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1741049567.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <51664a1300710238ba2d4d95142b57a52c4f0cae.1741049567.git.yepeilin@google.com>
Subject: [PATCH bpf-next v6 4/6] bpf, arm64: Support load-acquire and
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

Support BPF load-acquire (BPF_LOAD_ACQ) and store-release
(BPF_STORE_REL) instructions in the arm64 JIT compiler.  For example
(assuming little-endian):

  db 10 00 00 00 01 00 00  r0 = load_acquire((u64 *)(r1 + 0x0))
  95 00 00 00 00 00 00 00  exit

  opcode (0xdb): BPF_ATOMIC | BPF_DW | BPF_STX
  imm (0x00000100): BPF_LOAD_ACQ

The JIT compiler would emit an LDAR instruction for the above, e.g.:

  ldar  x7, [x0]

Similarly, consider the following 16-bit store-release:

  cb 21 00 00 10 01 00 00  store_release((u16 *)(r1 + 0x0), w2)
  95 00 00 00 00 00 00 00  exit

  opcode (0xcb): BPF_ATOMIC | BPF_H | BPF_STX
  imm (0x00000110): BPF_STORE_REL

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

Acked-by: Xu Kuohai <xukuohai@huawei.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/arm64/net/bpf_jit.h      | 20 ++++++++
 arch/arm64/net/bpf_jit_comp.c | 90 ++++++++++++++++++++++++++++++++---
 2 files changed, 104 insertions(+), 6 deletions(-)

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
index bdda5a77bb16..70d7c89d3ac9 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -647,6 +647,81 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	return 0;
 }
 
+static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s32 imm = insn->imm;
+	const s16 off = insn->off;
+	const u8 code = insn->code;
+	const bool arena = BPF_MODE(code) == BPF_PROBE_ATOMIC;
+	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
+	const u8 dst = bpf2a64[insn->dst_reg];
+	const u8 src = bpf2a64[insn->src_reg];
+	const u8 tmp = bpf2a64[TMP_REG_1];
+	u8 reg;
+
+	switch (imm) {
+	case BPF_LOAD_ACQ:
+		reg = src;
+		break;
+	case BPF_STORE_REL:
+		reg = dst;
+		break;
+	default:
+		pr_err_once("unknown atomic load/store op code %02x\n", imm);
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
+	switch (imm) {
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
+		pr_err_once("unexpected atomic load/store op code %02x\n",
+			    imm);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_ARM64_LSE_ATOMICS
 static int emit_lse_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 {
@@ -1641,11 +1716,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
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
+		if (bpf_atomic_is_load_store(insn))
+			ret = emit_atomic_ld_st(insn, ctx);
+		else if (cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
 			ret = emit_lse_atomic(insn, ctx);
 		else
 			ret = emit_ll_sc_atomic(insn, ctx);
@@ -2667,13 +2748,10 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 	if (!in_arena)
 		return true;
 	switch (insn->code) {
-	case BPF_STX | BPF_ATOMIC | BPF_B:
-	case BPF_STX | BPF_ATOMIC | BPF_H:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		if (bpf_atomic_is_load_store(insn))
-			return false;
-		if (!cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
+		if (!bpf_atomic_is_load_store(insn) &&
+		    !cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
 			return false;
 	}
 	return true;
-- 
2.48.1.711.g2feabab25a-goog


