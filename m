Return-Path: <bpf+bounces-57619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CBAAAD42A
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9AA1BA73B1
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888F31C1AAA;
	Wed,  7 May 2025 03:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cIzDSZUa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986731BFE00
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589393; cv=none; b=doexUe+/WOY0EIP8FUXmLHeopCZx/ZA8uyfT3/t2DVVwfP5cr8PBfwwsBdChVqxadlNC+TXthDZLbbDIDjoOq5uV4yYpuplm99lEgGuYPudsO/EJJ5Aaa8Y/IjfZivH+3U4ZTfbmsy7bAslE3MKkpF+JxsUfw1RL0RqAI4AGq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589393; c=relaxed/simple;
	bh=GlOTeG7w2UZXtMqz9n86jvtIuS+YSJuPF3GHrKLPJZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t6BWK7QEtaOgOjfgbj6M5lvtWc9srYub7ebhnmJkqaeC7Q0rX7Anvd3BGjIHhha6qHmYXrLAqqDkyytGFmOu/SgS0/e3hQzS9CLuUwH5JFIFZWLQsaioIqQmoLCb43kStrnRYZKa4jEV/10b2TR10jczz3AODVauUdmCZ71mz9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cIzDSZUa; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b090c7c2c6aso3441257a12.0
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 20:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746589391; x=1747194191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uxEgqRWNnCIbxPFGHN0DtpWce+dYhTac5Yxo7QchO30=;
        b=cIzDSZUa778yYGuHHj0Bq3T/LoWGjEMa9z65L7dRvCkAlxgXrViN9w7QONquISxG2x
         0ltWRPgL4iWbPJ7eOUEWu6Tz46mOdwjYsZYW98OIlq/Aypb/F5TH6Hs59QUVwjrSYtF9
         bzInTksekgJvUGjLsk7QmOLsJ7t+2FbJ/J7m+F0G5mHts3fPlj1ENM8uhNwucme2lEfu
         eAt433ewTgCg0Jorw4k4W4ECxCr3Ovsz8nlgZULCqMcbwO2q5/035LSQrUeipz7QZSsa
         wef2ISgT2rLAxdfNluiGfVd+Q1NUnIRHJz52tAJCJ2CAOKo6+u/6dtZOkLUzJDWCbCF0
         15Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746589391; x=1747194191;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uxEgqRWNnCIbxPFGHN0DtpWce+dYhTac5Yxo7QchO30=;
        b=AqllyI9u2NPqySyl3O4kE+zwdnFPZ7xE4JxYuwlSe87WEFHL+CjtQmfmrwpW7Th8sL
         aBe+UdVEm5LNqbNcVO9kCB+2BtFTtVkwqql0OFvCzm664nxEcYL8u0PCilB8pkCa5qp6
         typlr8tIJs7Wb2fXt2Ak3eEf0cMEISOBn4cooaVd/DPZlb5Cm96Sn1tjaCdBiPrPEV4z
         MCmH8pLkH0gnvuyRz3hOTslQc6GeKdxycVCLjT2zlA6GfVeQmQ8NDH32C7U3PeQBE3b0
         mWHRAV5Su3Zhd/EANXpMooBtdoEiJfD050qzXAIdCCBLFg+SXR1U863fjYVFKktgJ4BQ
         IMtg==
X-Gm-Message-State: AOJu0Yx5IlcX1LYq2MXVLDTR8zQjKtiwHRG0GggbyvAH8t0Whx4+U0vf
	LgMIofKtFJVuKSWLw3yGj2AukP3cnP8Q6G9mGptcTtq9SaDqHqnAzAxzPpyjph60OI0yXLRdzsn
	74wpaeY3AQf3L9u2DKYiJLHDJKflqkHZcQkuLiUJsPH046nvd3t8P/2JbkSAgS46GovPD5+0oXF
	2hMvv50q5cA5vLnzv3IG2rgxIPOk0ZzrNqvaa6eeg=
X-Google-Smtp-Source: AGHT+IHKxBND9jCab6HFwe4pJvHSVydGb2+kTstOAcdiQFsFXY5M29PHXlkh+RljB/HINF75zl2pV/LqwLoMZQ==
X-Received: from pjbdj15.prod.google.com ([2002:a17:90a:d2cf:b0:2fe:800f:23a])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:384f:b0:2fa:13d9:39c with SMTP id 98e67ed59e1d1-30aac19d7e0mr3239110a91.14.1746589390718;
 Tue, 06 May 2025 20:43:10 -0700 (PDT)
Date: Wed,  7 May 2025 03:43:07 +0000
In-Reply-To: <cover.1746588351.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1746588351.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <10e90e0eab042f924d35ad0d1c1f7ca29f673152.1746588351.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 4/8] bpf, riscv64: Skip redundant zext instruction
 after load-acquire
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, linux-riscv@lists.infradead.org, 
	Andrea Parri <parri.andrea@gmail.com>, 
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
	Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently, the verifier inserts a zext instruction right after every 8-,
16- or 32-bit load-acquire, which is already zero-extending.  Skip such
redundant zext instructions.

While we are here, update that already-obsolete comment about "skip the
next instruction" in build_body().  Also change emit_atomic_rmw()'s
parameters to keep it consistent with emit_atomic_ld_st().

Note that checking 'insn[1]' relies on 'insn' not being the last
instruction, which should have been guaranteed by the verifier; we
already use 'insn[1]' elsewhere in the file for similar purposes.
Additionally, we don't check if 'insn[1]' is actually a zext for our
load-acquire's dst_reg, or some other registers - in other words, here
we are relying on the verifier to always insert a redundant zext right
after a 8/16/32-bit load-acquire, for its dst_reg.

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com> # QEMU/RVA23
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 23 ++++++++++++++++++-----
 arch/riscv/net/bpf_jit_core.c   |  3 +--
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp6=
4.c
index 8767f032f2de..10e01ff06312 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -607,8 +607,13 @@ static void emit_store_64(u8 rd, s32 off, u8 rs, struc=
t rv_jit_context *ctx)
 	emit_sd(RV_REG_T1, 0, rs, ctx);
 }
=20
-static int emit_atomic_ld_st(u8 rd, u8 rs, s16 off, s32 imm, u8 code, stru=
ct rv_jit_context *ctx)
+static int emit_atomic_ld_st(u8 rd, u8 rs, const struct bpf_insn *insn,
+			     struct rv_jit_context *ctx)
 {
+	u8 code =3D insn->code;
+	s32 imm =3D insn->imm;
+	s16 off =3D insn->off;
+
 	switch (imm) {
 	/* dst_reg =3D load_acquire(src_reg + off16) */
 	case BPF_LOAD_ACQ:
@@ -627,6 +632,12 @@ static int emit_atomic_ld_st(u8 rd, u8 rs, s16 off, s3=
2 imm, u8 code, struct rv_
 			break;
 		}
 		emit_fence_r_rw(ctx);
+
+		/* If our next insn is a redundant zext, return 1 to tell
+		 * build_body() to skip it.
+		 */
+		if (BPF_SIZE(code) !=3D BPF_DW && insn_is_zext(&insn[1]))
+			return 1;
 		break;
 	/* store_release(dst_reg + off16, src_reg) */
 	case BPF_STORE_REL:
@@ -654,10 +665,12 @@ static int emit_atomic_ld_st(u8 rd, u8 rs, s16 off, s=
32 imm, u8 code, struct rv_
 	return 0;
 }
=20
-static int emit_atomic_rmw(u8 rd, u8 rs, s16 off, s32 imm, u8 code,
+static int emit_atomic_rmw(u8 rd, u8 rs, const struct bpf_insn *insn,
 			   struct rv_jit_context *ctx)
 {
-	u8 r0;
+	u8 r0, code =3D insn->code;
+	s16 off =3D insn->off;
+	s32 imm =3D insn->imm;
 	int jmp_offset;
 	bool is64;
=20
@@ -2026,9 +2039,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, st=
ruct rv_jit_context *ctx,
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
 		if (bpf_atomic_is_load_store(insn))
-			ret =3D emit_atomic_ld_st(rd, rs, off, imm, code, ctx);
+			ret =3D emit_atomic_ld_st(rd, rs, insn, ctx);
 		else
-			ret =3D emit_atomic_rmw(rd, rs, off, imm, code, ctx);
+			ret =3D emit_atomic_rmw(rd, rs, insn, ctx);
 		if (ret)
 			return ret;
 		break;
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index f8cd2f70a7fb..f6ca5cfa6b2f 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -26,9 +26,8 @@ static int build_body(struct rv_jit_context *ctx, bool ex=
tra_pass, int *offset)
 		int ret;
=20
 		ret =3D bpf_jit_emit_insn(insn, ctx, extra_pass);
-		/* BPF_LD | BPF_IMM | BPF_DW: skip the next instruction. */
 		if (ret > 0)
-			i++;
+			i++; /* skip the next instruction */
 		if (offset)
 			offset[i] =3D ctx->ninsns;
 		if (ret < 0)
--=20
2.49.0.967.g6a0df3ecc3-goog


