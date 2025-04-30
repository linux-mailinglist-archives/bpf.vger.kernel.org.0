Return-Path: <bpf+bounces-57014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29C6AA3FD7
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412A65A27EA
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 00:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED891FDA;
	Wed, 30 Apr 2025 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRx5oWDo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABEB2DC78D
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974236; cv=none; b=gYFjCeQVxIuzDkuetsltYDrmkGTy1+WSWtl57omE0XK7L4GCPsZap1WeCrWdvWGv1CDWmcG4AjK3uAJtwwoqeQ9eDKMTKF2Q8ZQpr0pt4tZzZlz0YCaok7IHLPApad9n14Ha18s2wH61GvoEZWWFf95a7sULkhG9TMnIbuweNtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974236; c=relaxed/simple;
	bh=Exg+Z3hGGbg9tzNWpAJ+wwRyKDS8jRc4XIJqc7o3L0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VlGbBcMgWuRy277j8ga3POx5iBf84d5TBanOOixiw/F+tF0MGs5Bac7HLFgo0taqp87p0I14JE++MW7PcOgYt0clgQ7+xkXeZimaq/G0dVLYmGv8bvJFHDxHCSMEIssKwg1Qw1TINx1J1Y2YZM3vib0bBbv4LIjETi2vj4oisyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRx5oWDo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73c09e99069so6614005b3a.0
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 17:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745974234; x=1746579034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYsvpTSFuwaN3Xhjb+Bga83BKgbo4zszHWjKjZxV+xU=;
        b=YRx5oWDoYqJEpaFo6rTugiulz1xtSe4RXqEgUq5QMDkbN6o2HYfcMJuqDwCOShin82
         L6Z00zbE46QPQ9WvX74mA/zH6ZSf8fQBwHSD8WSTk0lReUHjjQdNMmy+XLvpoYb7ab8B
         WjK1xpkFrCDWhXv5dB2467P2ue3mxzbh8oLV4YjC44I24lufGGPfqGkzg/CSvt+7uOS7
         0/gW/B5rFlyalxypZy2hID71iZjT7YYHlk8Xzd0nyN/Lq5/DPbre3sQrcwHUO13N5WhI
         47zqteBlEghrky7KPbnlkx89fx1+vokB5QB7sgYoBVJXSYTcHbRCZAyHSVni85TuNCuN
         1w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745974234; x=1746579034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYsvpTSFuwaN3Xhjb+Bga83BKgbo4zszHWjKjZxV+xU=;
        b=L6I7cO2jgpWEd0PHipxsTUbWD6uJVmV99gUZDD4ED3ObwQHza5tiOzgCX8heIpsLgH
         uClN/N1500cNYuE2YC8s6avs/yMvIMFJ8TUgm1fhzkMCtfteSXoxM5Ly/iPtY/6ipHiy
         cW21nkJkmn5sSn93TyX0WkGOyL40qhvJ5ihzNuT1d6hg2cFqIM06dsds6e3B+NTDc6xn
         WISbgYCUyqkotFoS9vQosrbPUZde/YfFIV4vUiaw3w/z+vymqOAo/sTHmVV2IHQSuprA
         Dd8uhpXEjOMJBjbVkiSMIdYpzHce/l1zE4lIRJq0M3I3ov2W6a2YxPjuBlGkIVJc9xBY
         fl/Q==
X-Gm-Message-State: AOJu0YxInlB70jQ4WFQheQvOZ+GwdqEaVzzLL/tOQCd6xK/IuY7H7uXy
	EGLuC9xhGR4HxUb+1HwduMcV41Cw19w/PZ7MEn54cPsLpR7XBatMk7TI2sc/gGQz8jQ9LxRdC3C
	B8xJ3M+sSz9/1d6bTcCIULyDAeKJTJV2PwmfwegNT7IbGsCJEIUe6vtikAYhCIPa0qyTEUoz7F0
	yuOzU0vF4gs0DtNk1TCMzOajzffZL+hjK7k8g8xII=
X-Google-Smtp-Source: AGHT+IHDsfr6K/xh6p7tpN54bW5XPrAGmzEBjUpdz1fyQMUjC+FLOSn9Y1qnxExjMJLfqqPWGSuzMoh4lQRVsA==
X-Received: from pfjt22.prod.google.com ([2002:a05:6a00:21d6:b0:73c:28d4:aca4])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e0e:b0:737:6e1f:29da with SMTP id d2e1a72fcca58-74038abfa63mr1850483b3a.21.1745974234407;
 Tue, 29 Apr 2025 17:50:34 -0700 (PDT)
Date: Wed, 30 Apr 2025 00:50:29 +0000
In-Reply-To: <cover.1745970908.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1745970908.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <3fd92afabeb9ed92a513b2c0aac091b69dbb76aa.1745970908.git.yepeilin@google.com>
Subject: [PATCH bpf-next 2/8] bpf, riscv64: Introduce emit_load_*() and emit_store_*()
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

We're planning to add support for the load-acquire and store-release
BPF instructions.  Define emit_load_<size>() and emit_store_<size>()
to enable/facilitate the (re)use of their code.

Tested-by: Peilin Ye <yepeilin@google.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
[yepeilin@google.com: cosmetic change to commit title]
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 242 +++++++++++++++++++-------------
 1 file changed, 143 insertions(+), 99 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index ca60db75199d..953b6a20c69f 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -473,6 +473,140 @@ static inline void emit_kcfi(u32 hash, struct rv_jit_context *ctx)
 		emit(hash, ctx);
 }
 
+static int emit_load_8(bool sign_ext, u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
+{
+	int insns_start;
+
+	if (is_12b_int(off)) {
+		insns_start = ctx->ninsns;
+		if (sign_ext)
+			emit(rv_lb(rd, off, rs), ctx);
+		else
+			emit(rv_lbu(rd, off, rs), ctx);
+		return ctx->ninsns - insns_start;
+	}
+
+	emit_imm(RV_REG_T1, off, ctx);
+	emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
+	insns_start = ctx->ninsns;
+	if (sign_ext)
+		emit(rv_lb(rd, 0, RV_REG_T1), ctx);
+	else
+		emit(rv_lbu(rd, 0, RV_REG_T1), ctx);
+	return ctx->ninsns - insns_start;
+}
+
+static int emit_load_16(bool sign_ext, u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
+{
+	int insns_start;
+
+	if (is_12b_int(off)) {
+		insns_start = ctx->ninsns;
+		if (sign_ext)
+			emit(rv_lh(rd, off, rs), ctx);
+		else
+			emit(rv_lhu(rd, off, rs), ctx);
+		return ctx->ninsns - insns_start;
+	}
+
+	emit_imm(RV_REG_T1, off, ctx);
+	emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
+	insns_start = ctx->ninsns;
+	if (sign_ext)
+		emit(rv_lh(rd, 0, RV_REG_T1), ctx);
+	else
+		emit(rv_lhu(rd, 0, RV_REG_T1), ctx);
+	return ctx->ninsns - insns_start;
+}
+
+static int emit_load_32(bool sign_ext, u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
+{
+	int insns_start;
+
+	if (is_12b_int(off)) {
+		insns_start = ctx->ninsns;
+		if (sign_ext)
+			emit(rv_lw(rd, off, rs), ctx);
+		else
+			emit(rv_lwu(rd, off, rs), ctx);
+		return ctx->ninsns - insns_start;
+	}
+
+	emit_imm(RV_REG_T1, off, ctx);
+	emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
+	insns_start = ctx->ninsns;
+	if (sign_ext)
+		emit(rv_lw(rd, 0, RV_REG_T1), ctx);
+	else
+		emit(rv_lwu(rd, 0, RV_REG_T1), ctx);
+	return ctx->ninsns - insns_start;
+}
+
+static int emit_load_64(bool sign_ext, u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
+{
+	int insns_start;
+
+	if (is_12b_int(off)) {
+		insns_start = ctx->ninsns;
+		emit_ld(rd, off, rs, ctx);
+		return ctx->ninsns - insns_start;
+	}
+
+	emit_imm(RV_REG_T1, off, ctx);
+	emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
+	insns_start = ctx->ninsns;
+	emit_ld(rd, 0, RV_REG_T1, ctx);
+	return ctx->ninsns - insns_start;
+}
+
+static void emit_store_8(u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
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
+static void emit_store_16(u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
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
+static void emit_store_32(u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
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
+static void emit_store_64(u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
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
@@ -1650,8 +1784,8 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
 	{
-		int insn_len, insns_start;
 		bool sign_ext;
+		int insn_len;
 
 		sign_ext = BPF_MODE(insn->code) == BPF_MEMSX ||
 			   BPF_MODE(insn->code) == BPF_PROBE_MEMSX;
@@ -1663,78 +1797,16 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 		switch (BPF_SIZE(code)) {
 		case BPF_B:
-			if (is_12b_int(off)) {
-				insns_start = ctx->ninsns;
-				if (sign_ext)
-					emit(rv_lb(rd, off, rs), ctx);
-				else
-					emit(rv_lbu(rd, off, rs), ctx);
-				insn_len = ctx->ninsns - insns_start;
-				break;
-			}
-
-			emit_imm(RV_REG_T1, off, ctx);
-			emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
-			insns_start = ctx->ninsns;
-			if (sign_ext)
-				emit(rv_lb(rd, 0, RV_REG_T1), ctx);
-			else
-				emit(rv_lbu(rd, 0, RV_REG_T1), ctx);
-			insn_len = ctx->ninsns - insns_start;
+			insn_len = emit_load_8(sign_ext, rd, off, rs, ctx);
 			break;
 		case BPF_H:
-			if (is_12b_int(off)) {
-				insns_start = ctx->ninsns;
-				if (sign_ext)
-					emit(rv_lh(rd, off, rs), ctx);
-				else
-					emit(rv_lhu(rd, off, rs), ctx);
-				insn_len = ctx->ninsns - insns_start;
-				break;
-			}
-
-			emit_imm(RV_REG_T1, off, ctx);
-			emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
-			insns_start = ctx->ninsns;
-			if (sign_ext)
-				emit(rv_lh(rd, 0, RV_REG_T1), ctx);
-			else
-				emit(rv_lhu(rd, 0, RV_REG_T1), ctx);
-			insn_len = ctx->ninsns - insns_start;
+			insn_len = emit_load_16(sign_ext, rd, off, rs, ctx);
 			break;
 		case BPF_W:
-			if (is_12b_int(off)) {
-				insns_start = ctx->ninsns;
-				if (sign_ext)
-					emit(rv_lw(rd, off, rs), ctx);
-				else
-					emit(rv_lwu(rd, off, rs), ctx);
-				insn_len = ctx->ninsns - insns_start;
-				break;
-			}
-
-			emit_imm(RV_REG_T1, off, ctx);
-			emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
-			insns_start = ctx->ninsns;
-			if (sign_ext)
-				emit(rv_lw(rd, 0, RV_REG_T1), ctx);
-			else
-				emit(rv_lwu(rd, 0, RV_REG_T1), ctx);
-			insn_len = ctx->ninsns - insns_start;
+			insn_len = emit_load_32(sign_ext, rd, off, rs, ctx);
 			break;
 		case BPF_DW:
-			if (is_12b_int(off)) {
-				insns_start = ctx->ninsns;
-				emit_ld(rd, off, rs, ctx);
-				insn_len = ctx->ninsns - insns_start;
-				break;
-			}
-
-			emit_imm(RV_REG_T1, off, ctx);
-			emit_add(RV_REG_T1, RV_REG_T1, rs, ctx);
-			insns_start = ctx->ninsns;
-			emit_ld(rd, 0, RV_REG_T1, ctx);
-			insn_len = ctx->ninsns - insns_start;
+			insn_len = emit_load_64(sign_ext, rd, off, rs, ctx);
 			break;
 		}
 
@@ -1879,44 +1951,16 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 	/* STX: *(size *)(dst + off) = src */
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
-- 
2.49.0.901.g37484f566f-goog


