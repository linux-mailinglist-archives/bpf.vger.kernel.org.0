Return-Path: <bpf+bounces-57618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71037AAD429
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FD3983F27
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E4218D656;
	Wed,  7 May 2025 03:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g02OlIKX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2911B422A
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 03:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589387; cv=none; b=bIhaKTOXZlVXAHSJrpv01pmW9Q3AqA0TVtKpe+FMEE6zv9wi7etXgOfNX4bzDnIPUk7YmZfASOcjTHWIl8xhlA7kI0cQqI3awoyWQFihgkkWk2VWD06VzcqUtHGpNWa5Rbgwvw8/pr5E7OkXjuNxUydothfwlSnFOvm3kviFyqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589387; c=relaxed/simple;
	bh=fHSXJ2ROG5aUkKzH1Slv6j+YF920rqEanoUYY12rcUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=onaqGelSVVscTE2g0IbYxDpvayJDoAXQjO8CYN6KL0OlKnQ07Ksu/L6YNQTK4RMBf4+/lPLlOvv5f120TVmy+B9C/GZ19GGf7IvYbJDwdTN45xd8NsjBkukX2ZWIrL61+rEnGr3F+MlshlPRN1JZilC/u5nmug2/ZsdVDLdv3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g02OlIKX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af8d8e0689eso6521612a12.2
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 20:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746589385; x=1747194185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZ9+VVlu9UVnVt8rYB8A7FfAZEwt5x79n4OT+/YhqGE=;
        b=g02OlIKXuheLJ1f/GDltoKYWmjLbyHWRqe2CzelpCSK3IOLCT+0TG6GrsivS5j/X94
         HfL6zhA6pW2C0e0aqXfX31FQxZsl3UsHlgf0OCg5jQ2vq47vm/WGhcURsahJWI9h8q+F
         hB1+fPrhpOH1zwwLLYjWTI54Xh1hhkEhFQ8A2JEMHlfV09oHW/rlnDYnJ6sS7Q6kThnx
         9++rW9QMLSKm7Rti8PgiIKS1QjXDPapL5/Wt87JUPf3iVQtcJytUw7dLGMM99ee3+0h+
         ZFh+ddDZogTpi1PuRUXH3ERJ6J/JZQIIUqAn1s5icVPhtbV60DIDJm8cncAly66gVmc7
         uo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746589385; x=1747194185;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XZ9+VVlu9UVnVt8rYB8A7FfAZEwt5x79n4OT+/YhqGE=;
        b=KF1s6u1Xl4ERaoq5SkIYJoVe8Kbrl9sTTBf1Qzyt8sAsEF2xFuCYlpp54y6/z5NtoI
         DlHFb6ivx010Wb+lqj+5Ci59R4yTwMVImoPgYoACUY8xuMu6zwqJudfnzyZs4jPH5qnR
         w0gxUNwTfcP/WBobUn+Jfj9u7FRMkUPAkWne58tUChmMW7vYhSK20osCA/BIXRVeCCHX
         ksD2jdCmRz0zrpdQ+Deo/AGG59bmZRXaCbfaqY6Ff/b9WVcITctW0LxqhlJWMWSm5ZKj
         SU/aFnOFT/sjk3TQ+wVrIKy2ucvPeHsC6JAqD+B7Fw+5S8ixHst9W8KcbJ67yev3JgeJ
         QceQ==
X-Gm-Message-State: AOJu0Yyv4Wj2d7XV3DgnR4kQjBtDw8GUQWJYCESA1iUH05AZpokBtWm5
	RphySRYBXngf+GgEOzFOvyUMqkAso6AIGHKA5xpzOKyeQXnK5TN6GuKGub88XNL7EwWIYBOZ1xj
	RqyL2NOB+UIhusylsXmYmz144WPpGngy+dQ0+3kLMqN5r4FD7BM5Atz7KNMqfTd9AdlEJ8TamQO
	uJ9mVnI88US5wtpiyByUvnzkT+zXtsagixYeGKoxU=
X-Google-Smtp-Source: AGHT+IHdddzj77XHhSHINniLU11jO45Ia6D6O+Nfkg/uiniU8HQiKK7yRkvfJa8QrxS3/oIfYMIff4ezEHlJYw==
X-Received: from pjbsc5.prod.google.com ([2002:a17:90b:5105:b0:2fc:2c9c:880])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2343:b0:22e:421b:49ad with SMTP id d9443c01a7336-22e5edf7a66mr25507985ad.46.1746589384548;
 Tue, 06 May 2025 20:43:04 -0700 (PDT)
Date: Wed,  7 May 2025 03:43:01 +0000
In-Reply-To: <cover.1746588351.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1746588351.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <3059c560e537ad43ed19055d2ebbd970c698095a.1746588351.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 3/8] bpf, riscv64: Support load-acquire and
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
Content-Transfer-Encoding: quoted-printable

From: Andrea Parri <parri.andrea@gmail.com>

Support BPF load-acquire (BPF_LOAD_ACQ) and store-release
(BPF_STORE_REL) instructions in the riscv64 JIT compiler.  For example,
consider the following 64-bit load-acquire (assuming little-endian):

  db 10 00 00 00 01 00 00  r1 =3D load_acquire((u64 *)(r1 + 0x0))
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

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com> # QEMU/RVA23
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Peilin Ye <yepeilin@google.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/riscv/net/bpf_jit.h        | 15 +++++++
 arch/riscv/net/bpf_jit_comp64.c | 75 ++++++++++++++++++++++++++++++---
 2 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
index 1d1c78d4cff1..e7b032dfd17f 100644
--- a/arch/riscv/net/bpf_jit.h
+++ b/arch/riscv/net/bpf_jit.h
@@ -608,6 +608,21 @@ static inline u32 rv_fence(u8 pred, u8 succ)
 	return rv_i_insn(imm11_0, 0, 0, 0, 0xf);
 }
=20
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
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp6=
4.c
index 953b6a20c69f..8767f032f2de 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -607,11 +607,65 @@ static void emit_store_64(u8 rd, s32 off, u8 rs, stru=
ct rv_jit_context *ctx)
 	emit_sd(RV_REG_T1, 0, rs, ctx);
 }
=20
-static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
-			struct rv_jit_context *ctx)
+static int emit_atomic_ld_st(u8 rd, u8 rs, s16 off, s32 imm, u8 code, stru=
ct rv_jit_context *ctx)
+{
+	switch (imm) {
+	/* dst_reg =3D load_acquire(src_reg + off16) */
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
+	if (BPF_SIZE(code) !=3D BPF_W && BPF_SIZE(code) !=3D BPF_DW) {
+		pr_err_once("bpf-jit: 1- and 2-byte RMW atomics are not supported\n");
+		return -EINVAL;
+	}
+	is64 =3D BPF_SIZE(code) =3D=3D BPF_DW;
=20
 	if (off) {
 		if (is_12b_int(off)) {
@@ -688,9 +742,14 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm=
, bool is64,
 		     rv_sc_w(RV_REG_T3, rs, rd, 0, 1), ctx);
 		jmp_offset =3D ninsns_rvoff(-6);
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
=20
 #define BPF_FIXUP_OFFSET_MASK   GENMASK(26, 0)
@@ -1962,10 +2021,16 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, =
struct rv_jit_context *ctx,
 	case BPF_STX | BPF_MEM | BPF_DW:
 		emit_store_64(rd, off, rs, ctx);
 		break;
+	case BPF_STX | BPF_ATOMIC | BPF_B:
+	case BPF_STX | BPF_ATOMIC | BPF_H:
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
-		emit_atomic(rd, rs, off, imm,
-			    BPF_SIZE(code) =3D=3D BPF_DW, ctx);
+		if (bpf_atomic_is_load_store(insn))
+			ret =3D emit_atomic_ld_st(rd, rs, off, imm, code, ctx);
+		else
+			ret =3D emit_atomic_rmw(rd, rs, off, imm, code, ctx);
+		if (ret)
+			return ret;
 		break;
=20
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
--=20
2.49.0.967.g6a0df3ecc3-goog


