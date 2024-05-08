Return-Path: <bpf+bounces-29069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 399958BFCB5
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 13:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83C51F21C82
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 11:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3765682D64;
	Wed,  8 May 2024 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxYC+23D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F081AD0;
	Wed,  8 May 2024 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169271; cv=none; b=q9dIBxKo0GdZcZB+B3XGfrs0OMlMyJ/0p3eTOtisvWmAn4ldvUaGuHumTLcLaCyF0qu8T7XJBML8Qronbt2qFmsPkU+lJMslV/eQzLIvTHaAWmW+ZALQMQK1xsHbl1+w6AaR9rNXVhVpNai5KaFIwqdXWbkEV7QjfezP+zEcwU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169271; c=relaxed/simple;
	bh=6SikNqtY91pwhlwXY/mT/hxrDvEXZ56J2/ACEwNQ8kc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KL/8VW6HslOoEbq9lfAPphffcW5x4rVkXg3+L7UVdGKmPJ8IcOVtQ5/gd5Rl6TDxxluI/wXwJKPId8bs2fa8xXk2VDBTZreDCSEdULOhl2Xrzopkul5Yl+ouMYW6EbDCaetzNFJHb+DU5jg1kzoAqxkv5NUxOqklNm+4Af8k0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxYC+23D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C50C113CC;
	Wed,  8 May 2024 11:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715169270;
	bh=6SikNqtY91pwhlwXY/mT/hxrDvEXZ56J2/ACEwNQ8kc=;
	h=From:To:Cc:Subject:Date:From;
	b=OxYC+23D+pxvJkWt5e534tyf3OwgABM2L1Z81vkR2K22YD5z8VvCDC6XTjCRAlPb8
	 vY2fOlQP6Btto9oO/8EU5urb6bbWAeOREvbicuyZAOMW+vLanIZleSgZpG7vdQFbgR
	 6+OX3Kyi62rxfpBaqVp3CMBbXoq4YFYH9Y37UN7MVTf6w/JcUgEz1CEmUmv97G1O3k
	 U85neZ1fjcDQhBq2oeCZlkfDW43XthanWMOo+aZ4lY4ygGU9BzqQxUqMtOSu2ssE9+
	 bAtv2SD4AuD/X/bLurjSyu2Zk8v3layv3iGz0Ok0jLIDcPMR/WI0zhqb3QB3xmB5cR
	 yf3xR4fCouZAg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf v2] powerpc/bpf: enforce full ordering for ATOMIC operations with BPF_FETCH
Date: Wed,  8 May 2024 11:54:04 +0000
Message-Id: <20240508115404.74823-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux Kernel Memory Model [1][2] requires RMW operations that have a
return value to be fully ordered.

BPF atomic operations with BPF_FETCH (including BPF_XCHG and
BPF_CMPXCHG) return a value back so they need to be JITed to fully
ordered operations. POWERPC currently emits relaxed operations for
these.

We can show this by running the following litmus-test:

PPC SB+atomic_add+fetch

{
0:r0=x;  (* dst reg assuming offset is 0 *)
0:r1=2;  (* src reg *)
0:r2=1;
0:r4=y;  (* P0 writes to this, P1 reads this *)
0:r5=z;  (* P1 writes to this, P0 reads this *)
0:r6=0;

1:r2=1;
1:r4=y;
1:r5=z;
}

P0                      | P1            ;
stw         r2, 0(r4)   | stw  r2,0(r5) ;
                        |               ;
loop:lwarx  r3, r6, r0  |               ;
mr          r8, r3      |               ;
add         r3, r3, r1  | sync          ;
stwcx.      r3, r6, r0  |               ;
bne         loop        |               ;
mr          r1, r8      |               ;
                        |               ;
lwa         r7, 0(r5)   | lwa  r7,0(r4) ;

~exists(0:r7=0 /\ 1:r7=0)

Witnesses
Positive: 9 Negative: 3
Condition ~exists (0:r7=0 /\ 1:r7=0)
Observation SB+atomic_add+fetch Sometimes 3 9

This test shows that the older store in P0 is reordered with a newer
load to a different address. Although there is a RMW operation with
fetch between them. Adding a sync before and after RMW fixes the issue:

Witnesses
Positive: 9 Negative: 0
Condition ~exists (0:r7=0 /\ 1:r7=0)
Observation SB+atomic_add+fetch Never 0 9

[1] https://www.kernel.org/doc/Documentation/memory-barriers.txt
[2] https://www.kernel.org/doc/Documentation/atomic_t.txt

Fixes: 65112709115f ("powerpc/bpf/64: add support for BPF_ATOMIC bitwise operations")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
Changes in v1 -> v2:
v1: https://lore.kernel.org/all/20240507175439.119467-1-puranjay@kernel.org/
- Don't emit `sync` for non-SMP kernels as that adds unessential overhead.
---
 arch/powerpc/net/bpf_jit_comp32.c | 12 ++++++++++++
 arch/powerpc/net/bpf_jit_comp64.c | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 2f39c50ca729..0318b83f2e6a 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -853,6 +853,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			/* Get offset into TMP_REG */
 			EMIT(PPC_RAW_LI(tmp_reg, off));
 			tmp_idx = ctx->idx * 4;
+			/*
+			 * Enforce full ordering for operations with BPF_FETCH by emitting a 'sync'
+			 * before and after the operation.
+			 *
+			 * This is a requirement in the Linux Kernel Memory Model.
+			 * See __cmpxchg_u64() in asm/cmpxchg.h as an example.
+			 */
+			if (imm & BPF_FETCH && IS_ENABLED(CONFIG_SMP))
+				EMIT(PPC_RAW_SYNC());
 			/* load value from memory into r0 */
 			EMIT(PPC_RAW_LWARX(_R0, tmp_reg, dst_reg, 0));
 
@@ -905,6 +914,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 
 			/* For the BPF_FETCH variant, get old data into src_reg */
 			if (imm & BPF_FETCH) {
+				/* Emit 'sync' to enforce full ordering */
+				if (IS_ENABLED(CONFIG_SMP))
+					EMIT(PPC_RAW_SYNC());
 				EMIT(PPC_RAW_MR(ret_reg, ax_reg));
 				if (!fp->aux->verifier_zext)
 					EMIT(PPC_RAW_LI(ret_reg - 1, 0)); /* higher 32-bit */
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 79f23974a320..9a077f8acf7b 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -804,6 +804,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			/* Get offset into TMP_REG_1 */
 			EMIT(PPC_RAW_LI(tmp1_reg, off));
 			tmp_idx = ctx->idx * 4;
+			/*
+			 * Enforce full ordering for operations with BPF_FETCH by emitting a 'sync'
+			 * before and after the operation.
+			 *
+			 * This is a requirement in the Linux Kernel Memory Model.
+			 * See __cmpxchg_u64() in asm/cmpxchg.h as an example.
+			 */
+			if (imm & BPF_FETCH && IS_ENABLED(CONFIG_SMP))
+				EMIT(PPC_RAW_SYNC());
 			/* load value from memory into TMP_REG_2 */
 			if (size == BPF_DW)
 				EMIT(PPC_RAW_LDARX(tmp2_reg, tmp1_reg, dst_reg, 0));
@@ -865,6 +874,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			PPC_BCC_SHORT(COND_NE, tmp_idx);
 
 			if (imm & BPF_FETCH) {
+				/* Emit 'sync' to enforce full ordering */
+				if (IS_ENABLED(CONFIG_SMP))
+					EMIT(PPC_RAW_SYNC());
 				EMIT(PPC_RAW_MR(ret_reg, _R0));
 				/*
 				 * Skip unnecessary zero-extension for 32-bit cmpxchg.
-- 
2.42.0


