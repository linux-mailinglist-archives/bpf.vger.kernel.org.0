Return-Path: <bpf+bounces-57617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F2FAAD428
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44CC983FC8
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C0D1B85CC;
	Wed,  7 May 2025 03:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DiJUjbRZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4405C1B4236
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 03:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589380; cv=none; b=M4rOxdwJhLpKJ8mGe6rQxLGyw8gMF5iZ7IcGTsCFnEFrZRzmomFkT+/cE2Ke56yyNNjwt9bjJ+wlNMbhSu+SdXGsVlZ5knEZHGmvu5QC5/i4FKyrWAmpcbrtXN4EEInD+3UIm6AUnHoScOnHTKOU5YSUef9XddsWWokDhk8kJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589380; c=relaxed/simple;
	bh=mSTdS/NQ77C9tGYW5orl0Juw1I/ta0O7TRsdzCeDJxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fNtL+tsoqMEdUBQTbPwinHLBNH6i/KaOoB01Aq583TRrv7O1hreOu/2C6Ua2DFHfUagNrF3gozLy4HW1/m6qdxLKIbPrrhCWxObsdlGzoiueDtRhbGcebtVauQVDZ0dyjaiaEHrkwSxGj8nnAO6VEH7ZpjjPk38BAzpUOsPYtQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DiJUjbRZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22e166874aeso35359825ad.0
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 20:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746589378; x=1747194178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ld9zxHoRs73MCS67KkHJ5RrzzAVO/S6RCQlVHrBj7a8=;
        b=DiJUjbRZjUPb/iY/EHbEB7MNLj99Z3VkjyoE9yphVnliEPxWkrK+VPd5iT0E6E+o55
         lGOr79CczS87xpiUBzJ/pEK3+9+iXVl1LWq+pwW//vaCMPRlpTZs2k7iWwxyucfWnGxa
         Yk5BvOsrOkk501XSlFL2X2TucXVub89K2xnzdjhHFWufAlcR0gJalhDVm0ypXlEWxXCk
         UP7f5auS4UGOWGZboaBVGXzMs5BzvG5yJ0eGJ6JWu9xfAG2RyLyqyd+8JFlF9XX0/vGN
         EW9C7BCbyJgjQndOm98dJhqkT6hIgE3VRBh9IMoUuGhoCWhBUtYXiukLB6dfHal9OXcR
         OjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746589378; x=1747194178;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ld9zxHoRs73MCS67KkHJ5RrzzAVO/S6RCQlVHrBj7a8=;
        b=IZAks18iXVekycINBgQgLrjsUvTdDecFSfQUerlTao66V9qehc5lSzBCCV1yjxcjVN
         5lNtvqgJk1sfGNtq5gRU43oShwdbCBaMmqgFyyE0bduqpcf4FsFqkolY4J7z/zjmLpxu
         I4qIPulT1IOnFG695A8jDnQL1dmtDzHhk6dJ29pw9I8GQdAmDAuZGkDma9/o1mZNNbIn
         QREjySoSOThFJmwcmOJMRfHqDi6vNFSDCke6Y+lKUFwXmLVFB1i2wXGRvowhaaWi0e1Z
         jFOeqsmMooxzL5Kx/TwSjywxU5oRKzdZpNzwvIRHWbklJvThGCOmMhAtG40fQgM9Xr27
         vnDA==
X-Gm-Message-State: AOJu0YzzWF2GUAPmJHIFHLp8inFlJRazbM7FLHf3QnrmY9OP8YFieW81
	cyzuJDNU21j4/TolKlfq/pXz7FZ9UotOEFzYGhpdMvl3950+dJ/XFN7t7S6DQPAU/wTOmb4YhQh
	t2PujU9izOKLhHPtpGC1nd2wVoKVdr0kQCZBsjl8bzH/+WJ5vMR2spWMHzB4+ZunN5Im2PVwTLt
	/6egAh8P8JJUoiAVKNp2DQsmWH7o5i71HLy0HrNEg=
X-Google-Smtp-Source: AGHT+IFUpiWxQisjVO0PbCrixpTCNRnHwhYPh0qYG3HnSQENaQkO0Gzq1JxGwOaFf4WBWFwhS6Il2UIOV1K3xA==
X-Received: from plqq5.prod.google.com ([2002:a17:902:c745:b0:223:69a1:46da])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf01:b0:223:fb3a:8647 with SMTP id d9443c01a7336-22e5ecac0f4mr27878445ad.41.1746589378365;
 Tue, 06 May 2025 20:42:58 -0700 (PDT)
Date: Wed,  7 May 2025 03:42:55 +0000
In-Reply-To: <cover.1746588351.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1746588351.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <fce89473a5748e1631d18a5917d953460d1ae0d0.1746588351.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 2/8] bpf, riscv64: Introduce emit_load_*() and emit_store_*()
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

We're planning to add support for the load-acquire and store-release
BPF instructions.  Define emit_load_<size>() and emit_store_<size>()
to enable/facilitate the (re)use of their code.

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com> # QEMU/RVA23
Tested-by: Peilin Ye <yepeilin@google.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
[yepeilin@google.com: cosmetic change to commit title]
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 242 +++++++++++++++++++-------------
 1 file changed, 143 insertions(+), 99 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp6=
4.c
index ca60db75199d..953b6a20c69f 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -473,6 +473,140 @@ static inline void emit_kcfi(u32 hash, struct rv_jit_=
context *ctx)
 		emit(hash, ctx);
 }
=20
+static int emit_load_8(bool sign_ext, u8 rd, s32 off, u8 rs, struct rv_jit=
_context *ctx)
+{
+	int insns_start;
+
+	if (is_12b_int(off)) {
+		insns_start =3D ctx->ninsns;
+		if (sign_ext)
+			emit(rv_lb(rd, off, rs), ctx);
+		else
+			emit(rv_lbu(rd, off, rs), ctx);
+		return ctx->ninsns - insns_start;
+	}
+
+	emit_imm(RV_REG_T1, off, ctx);
+	emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
+	insns_start =3D ctx->ninsns;
+	if (sign_ext)
+		emit(rv_lb(rd, 0, RV_REG_T1), ctx);
+	else
+		emit(rv_lbu(rd, 0, RV_REG_T1), ctx);
+	return ctx->ninsns - insns_start;
+}
+
+static int emit_load_16(bool sign_ext, u8 rd, s32 off, u8 rs, struct rv_ji=
t_context *ctx)
+{
+	int insns_start;
+
+	if (is_12b_int(off)) {
+		insns_start =3D ctx->ninsns;
+		if (sign_ext)
+			emit(rv_lh(rd, off, rs), ctx);
+		else
+			emit(rv_lhu(rd, off, rs), ctx);
+		return ctx->ninsns - insns_start;
+	}
+
+	emit_imm(RV_REG_T1, off, ctx);
+	emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
+	insns_start =3D ctx->ninsns;
+	if (sign_ext)
+		emit(rv_lh(rd, 0, RV_REG_T1), ctx);
+	else
+		emit(rv_lhu(rd, 0, RV_REG_T1), ctx);
+	return ctx->ninsns - insns_start;
+}
+
+static int emit_load_32(bool sign_ext, u8 rd, s32 off, u8 rs, struct rv_ji=
t_context *ctx)
+{
+	int insns_start;
+
+	if (is_12b_int(off)) {
+		insns_start =3D ctx->ninsns;
+		if (sign_ext)
+			emit(rv_lw(rd, off, rs), ctx);
+		else
+			emit(rv_lwu(rd, off, rs), ctx);
+		return ctx->ninsns - insns_start;
+	}
+
+	emit_imm(RV_REG_T1, off, ctx);
+	emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
+	insns_start =3D ctx->ninsns;
+	if (sign_ext)
+		emit(rv_lw(rd, 0, RV_REG_T1), ctx);
+	else
+		emit(rv_lwu(rd, 0, RV_REG_T1), ctx);
+	return ctx->ninsns - insns_start;
+}
+
+static int emit_load_64(bool sign_ext, u8 rd, s32 off, u8 rs, struct rv_ji=
t_context *ctx)
+{
+	int insns_start;
+
+	if (is_12b_int(off)) {
+		insns_start =3D ctx->ninsns;
+		emit_ld(rd, off, rs, ctx);
+		return ctx->ninsns - insns_start;
+	}
+
+	emit_imm(RV_REG_T1, off, ctx);
+	emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
+	insns_start =3D ctx->ninsns;
+	emit_ld(rd, 0, RV_REG_T1, ctx);
+	return ctx->ninsns - insns_start;
+}
+
+static void emit_store_8(u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx=
)
+{
+	if (is_12b_int(off)) {
+		emit(rv_sb(rd, off, rs), ctx);
+		return;
+	}
+
+	emit_imm(RV_REG_T1, off, ctx);
+	emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
+	emit(rv_sb(RV_REG_T1, 0, rs), ctx);
+}
+
+static void emit_store_16(u8 rd, s32 off, u8 rs, struct rv_jit_context *ct=
x)
+{
+	if (is_12b_int(off)) {
+		emit(rv_sh(rd, off, rs), ctx);
+		return;
+	}
+
+	emit_imm(RV_REG_T1, off, ctx);
+	emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
+	emit(rv_sh(RV_REG_T1, 0, rs), ctx);
+}
+
+static void emit_store_32(u8 rd, s32 off, u8 rs, struct rv_jit_context *ct=
x)
+{
+	if (is_12b_int(off)) {
+		emit_sw(rd, off, rs, ctx);
+		return;
+	}
+
+	emit_imm(RV_REG_T1, off, ctx);
+	emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
+	emit_sw(RV_REG_T1, 0, rs, ctx);
+}
+
+static void emit_store_64(u8 rd, s32 off, u8 rs, struct rv_jit_context *ct=
x)
+{
+	if (is_12b_int(off)) {
+		emit_sd(rd, off, rs, ctx);
+		return;
+	}
+
+	emit_imm(RV_REG_T1, off, ctx);
+	emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
+	emit_sd(RV_REG_T1, 0, rs, ctx);
+}
+
 static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
 			struct rv_jit_context *ctx)
 {
@@ -1650,8 +1784,8 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, st=
ruct rv_jit_context *ctx,
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
 	{
-		int insn_len, insns_start;
 		bool sign_ext;
+		int insn_len;
=20
 		sign_ext =3D BPF_MODE(insn->code) =3D=3D BPF_MEMSX ||
 			   BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX;
@@ -1663,78 +1797,16 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, =
struct rv_jit_context *ctx,
=20
 		switch (BPF_SIZE(code)) {
 		case BPF_B:
-			if (is_12b_int(off)) {
-				insns_start =3D ctx->ninsns;
-				if (sign_ext)
-					emit(rv_lb(rd, off, rs), ctx);
-				else
-					emit(rv_lbu(rd, off, rs), ctx);
-				insn_len =3D ctx->ninsns - insns_start;
-				break;
-			}
-
-			emit_imm(RV_REG_T1, off, ctx);
-			emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
-			insns_start =3D ctx->ninsns;
-			if (sign_ext)
-				emit(rv_lb(rd, 0, RV_REG_T1), ctx);
-			else
-				emit(rv_lbu(rd, 0, RV_REG_T1), ctx);
-			insn_len =3D ctx->ninsns - insns_start;
+			insn_len =3D emit_load_8(sign_ext, rd, off, rs, ctx);
 			break;
 		case BPF_H:
-			if (is_12b_int(off)) {
-				insns_start =3D ctx->ninsns;
-				if (sign_ext)
-					emit(rv_lh(rd, off, rs), ctx);
-				else
-					emit(rv_lhu(rd, off, rs), ctx);
-				insn_len =3D ctx->ninsns - insns_start;
-				break;
-			}
-
-			emit_imm(RV_REG_T1, off, ctx);
-			emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
-			insns_start =3D ctx->ninsns;
-			if (sign_ext)
-				emit(rv_lh(rd, 0, RV_REG_T1), ctx);
-			else
-				emit(rv_lhu(rd, 0, RV_REG_T1), ctx);
-			insn_len =3D ctx->ninsns - insns_start;
+			insn_len =3D emit_load_16(sign_ext, rd, off, rs, ctx);
 			break;
 		case BPF_W:
-			if (is_12b_int(off)) {
-				insns_start =3D ctx->ninsns;
-				if (sign_ext)
-					emit(rv_lw(rd, off, rs), ctx);
-				else
-					emit(rv_lwu(rd, off, rs), ctx);
-				insn_len =3D ctx->ninsns - insns_start;
-				break;
-			}
-
-			emit_imm(RV_REG_T1, off, ctx);
-			emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
-			insns_start =3D ctx->ninsns;
-			if (sign_ext)
-				emit(rv_lw(rd, 0, RV_REG_T1), ctx);
-			else
-				emit(rv_lwu(rd, 0, RV_REG_T1), ctx);
-			insn_len =3D ctx->ninsns - insns_start;
+			insn_len =3D emit_load_32(sign_ext, rd, off, rs, ctx);
 			break;
 		case BPF_DW:
-			if (is_12b_int(off)) {
-				insns_start =3D ctx->ninsns;
-				emit_ld(rd, off, rs, ctx);
-				insn_len =3D ctx->ninsns - insns_start;
-				break;
-			}
-
-			emit_imm(RV_REG_T1, off, ctx);
-			emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
-			insns_start =3D ctx->ninsns;
-			emit_ld(rd, 0, RV_REG_T1, ctx);
-			insn_len =3D ctx->ninsns - insns_start;
+			insn_len =3D emit_load_64(sign_ext, rd, off, rs, ctx);
 			break;
 		}
=20
@@ -1879,44 +1951,16 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, =
struct rv_jit_context *ctx,
=20
 	/* STX: *(size *)(dst + off) =3D src */
 	case BPF_STX | BPF_MEM | BPF_B:
-		if (is_12b_int(off)) {
-			emit(rv_sb(rd, off, rs), ctx);
-			break;
-		}
-
-		emit_imm(RV_REG_T1, off, ctx);
-		emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
-		emit(rv_sb(RV_REG_T1, 0, rs), ctx);
+		emit_store_8(rd, off, rs, ctx);
 		break;
 	case BPF_STX | BPF_MEM | BPF_H:
-		if (is_12b_int(off)) {
-			emit(rv_sh(rd, off, rs), ctx);
-			break;
-		}
-
-		emit_imm(RV_REG_T1, off, ctx);
-		emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
-		emit(rv_sh(RV_REG_T1, 0, rs), ctx);
+		emit_store_16(rd, off, rs, ctx);
 		break;
 	case BPF_STX | BPF_MEM | BPF_W:
-		if (is_12b_int(off)) {
-			emit_sw(rd, off, rs, ctx);
-			break;
-		}
-
-		emit_imm(RV_REG_T1, off, ctx);
-		emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
-		emit_sw(RV_REG_T1, 0, rs, ctx);
+		emit_store_32(rd, off, rs, ctx);
 		break;
 	case BPF_STX | BPF_MEM | BPF_DW:
-		if (is_12b_int(off)) {
-			emit_sd(rd, off, rs, ctx);
-			break;
-		}
-
-		emit_imm(RV_REG_T1, off, ctx);
-		emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
-		emit_sd(RV_REG_T1, 0, rs, ctx);
+		emit_store_64(rd, off, rs, ctx);
 		break;
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
--=20
2.49.0.967.g6a0df3ecc3-goog


