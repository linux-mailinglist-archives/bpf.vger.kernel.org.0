Return-Path: <bpf+bounces-57016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC80AA3FD8
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4873BA912
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 00:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E681FC3;
	Wed, 30 Apr 2025 00:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nUjypCly"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43538B67F
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974261; cv=none; b=rrW+yMSWspdfJdyAx9E6BMCMwtqzOVyqBVehZTrLRCv26C04dvnl0cgGtqVHGm+4LhF3dQSCrR7okq3kk5x7c8GAm9H2v3Mnef4mi6c9PftYt7FVZDxa5RZuFPB2dcZzRXofeSi5UZ9OwJVD20546hbcU5fzbEqkf6WeeaN+XY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974261; c=relaxed/simple;
	bh=E7JzEb1ndk9qNS9JPtmwKt+qeSRjHmFkJQHTTUIT/WI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=excc7I3vs4isu6fO4AAu4op8JQpi9fPPh3fuGnVL8bmyzlj12QTxJ4ED98XrrJKLf/AVKyK7l32PUapMTuYR9E0GL/Uz6pZcruxVQ7u42H5wCoFZVkpQOxnenuLkhH+FaA2UsYliTf6nQ9EX53h/uGXVRdSbVXuDOU3WCJ7N2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nUjypCly; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7395095a505so4955449b3a.1
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 17:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745974259; x=1746579059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ABOqan36lZIveWEkLasL+8eAvkOggPga+/54lThTXZA=;
        b=nUjypClyRysuEB1NbOpmNMPBV4t2bZqN/TpzSE55spO5iwvMnwQcKMpKarxJRzoW63
         /JYAIG+5P66R31S6QpiM8Sem+afBMI/5Si1cFlgfS4YXaRoL4RL1R6nMipqYPh1sNFQJ
         uA4X1OOKQvyCLYisULcxoMBsuhtRhGUIxS498st6TYQjpBMOCnTYKBX7kBUSsc+f5vEG
         ygx6iPWToAQqsb7/iHk3MjSrNywXl8IjgNf0AOuQlo5OR1/7XNUYQjO2XHdD4J6YzGPQ
         VFsJSKOVKOSwsrV+PsREnloUrjrZNSeNTvlQeTNqNLNe5TxKPwq66wEjrd1bemHTHX5m
         CERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745974259; x=1746579059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABOqan36lZIveWEkLasL+8eAvkOggPga+/54lThTXZA=;
        b=T8Omw2waxBM7IXN2LvHWC88B6lECRpe2smoHMmZj6bYInucOBEVwYNBrHkfyRvB+GJ
         SvOOlMjaq7Vp1Acb5RCzNGY/kukDKoJLlazNkXe6rcPaRP6UiAvLQBUMgkU3cMJwOqY+
         KK0NhLiuXcAdcjOZl3z0W/f0dmsvBA7EkuiuSQv5RsRelUvnVHhJOU/5M4HYeJurt17F
         nHG2EF0KMmmrB3bnRwcdJdC85JYC4JBmZXLbA8CaatFtc4IwDK2TTnD2cvsXKZHM8FXZ
         fHWOMiyDqLZMaiKpu66CnKbV06UMID2zEFf+FULmU4AZ+19jA2vVVp97dNNjgAuLNrAb
         iyKQ==
X-Gm-Message-State: AOJu0YzGhX3DN4c1Pcs1to+qyMO3/6tco5T8pnLarFTdfFUgp8KIQX5B
	r/4/Dkf+ARcBtX3PrqZQncQGdcix/YotnqD7b9s1H4OZ+BfAnufw5nuf2OLJNvX50oOpQyTbWHB
	xKsUPzlwKgg0FyZkd0Ya7q4M8GnPQKQ80bCVvy+VX5tZASi156/F/NwF6ltzXYVEf/TIt3W+XCP
	ykBWeYfJTFbvXdOV+Y2Zsxmr4IGlQrelWK9bfKGYw=
X-Google-Smtp-Source: AGHT+IHR8EdraOTeSJWSciGTdGHVcTZQJUarxce25b/yrSiFsMjC5ucKt57s2owsMNSPbNpmZQTiX6NEqr7wMQ==
X-Received: from pfhr5.prod.google.com ([2002:a62:e405:0:b0:736:a134:94ad])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e05:b0:73e:2359:4115 with SMTP id d2e1a72fcca58-7403a82d834mr928914b3a.23.1745974259287;
 Tue, 29 Apr 2025 17:50:59 -0700 (PDT)
Date: Wed, 30 Apr 2025 00:50:55 +0000
In-Reply-To: <cover.1745970908.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1745970908.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <875edd356603dd5d7be30b79b97d8ee15ebc59b3.1745970908.git.yepeilin@google.com>
Subject: [PATCH bpf-next 4/8] bpf, riscv64: Skip redundant zext instruction
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

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 23 ++++++++++++++++++-----
 arch/riscv/net/bpf_jit_core.c   |  3 +--
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index b71a9c88fb4f..4cb50dbbe94b 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -607,8 +607,13 @@ static void emit_store_64(u8 rd, s32 off, u8 rs, struct rv_jit_context *ctx)
 	emit_sd(RV_REG_T1, 0, rs, ctx);
 }
 
-static int emit_atomic_ld_st(u8 rd, u8 rs, s16 off, s32 imm, u8 code, struct rv_jit_context *ctx)
+static int emit_atomic_ld_st(u8 rd, u8 rs, const struct bpf_insn *insn,
+			     struct rv_jit_context *ctx)
 {
+	u8 code = insn->code;
+	s32 imm = insn->imm;
+	s16 off = insn->off;
+
 	switch (imm) {
 	/* dst_reg = load_acquire(src_reg + off16) */
 	case BPF_LOAD_ACQ:
@@ -627,6 +632,12 @@ static int emit_atomic_ld_st(u8 rd, u8 rs, s16 off, s32 imm, u8 code, struct rv_
 			break;
 		}
 		emit_fence_r_rw(ctx);
+
+		/* If our next insn is a redundant zext, return 1 to tell
+		 * build_body() to skip it.
+		 */
+		if (BPF_SIZE(code) != BPF_DW && insn_is_zext(&insn[1]))
+			return 1;
 		break;
 	/* store_release(dst_reg + off16, src_reg) */
 	case BPF_STORE_REL:
@@ -654,10 +665,12 @@ static int emit_atomic_ld_st(u8 rd, u8 rs, s16 off, s32 imm, u8 code, struct rv_
 	return 0;
 }
 
-static int emit_atomic_rmw(u8 rd, u8 rs, s16 off, s32 imm, u8 code,
+static int emit_atomic_rmw(u8 rd, u8 rs, const struct bpf_insn *insn,
 			   struct rv_jit_context *ctx)
 {
-	u8 r0;
+	u8 r0, code = insn->code;
+	s16 off = insn->off;
+	s32 imm = insn->imm;
 	int jmp_offset;
 	bool is64;
 
@@ -2026,9 +2039,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_STX | BPF_ATOMIC | BPF_W:
 	case BPF_STX | BPF_ATOMIC | BPF_DW:
 		if (bpf_atomic_is_load_store(insn))
-			ret = emit_atomic_ld_st(rd, rs, off, imm, code, ctx);
+			ret = emit_atomic_ld_st(rd, rs, insn, ctx);
 		else
-			ret = emit_atomic_rmw(rd, rs, off, imm, code, ctx);
+			ret = emit_atomic_rmw(rd, rs, insn, ctx);
 		break;
 
 	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index f8cd2f70a7fb..f6ca5cfa6b2f 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -26,9 +26,8 @@ static int build_body(struct rv_jit_context *ctx, bool extra_pass, int *offset)
 		int ret;
 
 		ret = bpf_jit_emit_insn(insn, ctx, extra_pass);
-		/* BPF_LD | BPF_IMM | BPF_DW: skip the next instruction. */
 		if (ret > 0)
-			i++;
+			i++; /* skip the next instruction */
 		if (offset)
 			offset[i] = ctx->ninsns;
 		if (ret < 0)
-- 
2.49.0.901.g37484f566f-goog


