Return-Path: <bpf+bounces-29632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5DA8C3E8D
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 12:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B91CB2276B
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35212149C4A;
	Mon, 13 May 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXWewXdz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE60148FE3;
	Mon, 13 May 2024 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594605; cv=none; b=eJUpTHw1oQb5cca5m7TrQmYSkMBqWzkiUJ9s4QAAA/4CPWbXtctXXGl/me3QDF1WsZHrgtMjBBNerS2nbVjHTO29mBl4nTcS3DZBCIq9LPx5LE8HMSuhVgcm+cGLb1/H1lmjArt6gIcEtGqFEUUFKc0dM+JY1EMmgHzwbn0L558=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594605; c=relaxed/simple;
	bh=qPtmsc9aVaRFXH0vxN0wn2tJPuPbcbyFzlsOMSyAdDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KoKx9iMND9dBtCujOzY1fsDxLPff6x1xY3Iz9TajbLGoIweDNvYpQ7YoshH8RgJ11GrIm8gN2Z1+YXjMfpk4miVCAO4gQYQfMSrL7ERroAu9lF1hIpMGJ/5WqIZMTraKK0Jy/5mXZgSWIuIPiMQ6IpLOy6FueZRD+vtJnAr0I0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXWewXdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD32CC113CC;
	Mon, 13 May 2024 10:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715594604;
	bh=qPtmsc9aVaRFXH0vxN0wn2tJPuPbcbyFzlsOMSyAdDw=;
	h=From:To:Cc:Subject:Date:From;
	b=iXWewXdzUpD2uL70ydPKzG0bHJ7ydLietv9lbpsHyGyca9U5kTSqcrQE513aC4B1P
	 Te0GCtTrCA8qwlPbM01MAFr0y6KulARZCh2GnBe8PmjIsNI5FoG2EUaeSxCTw6rRCr
	 ihN1lHW5rCZeZZXeAZp/WsZ8fytdNXEw7kDaC8jZ4GgT4qwdpNmmpUvA5Ki6swjPZA
	 d39TUrqh8R6aU/2CLpF6zkveRZZvVpD9e9a7RoMyvvwaaswtuLG0pnMBmEAnQt84nf
	 NfnqZLDyWUPmLTT6bSrvjnMDaNklF7yCZdE5Vx90G+tEvXYypKtPVTZEOS8ic7ph/C
	 bbDPur+zXAffA==
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
Subject: [PATCH bpf v3] powerpc/bpf: enforce full ordering for ATOMIC operations with BPF_FETCH
Date: Mon, 13 May 2024 10:02:48 +0000
Message-Id: <20240513100248.110535-1-puranjay@kernel.org>
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
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
Changes in v2 -> v3:
v2: https://lore.kernel.org/all/20240508115404.74823-1-puranjay@kernel.org/
- Emit the sync outside the loop so it doesn't get executed everytime.
- Minor coding style changes.

Changes in v1 -> v2:
v1: https://lore.kernel.org/all/20240507175439.119467-1-puranjay@kernel.org/
- Don't emit `sync` for non-SMP kernels as that adds unessential overhead.
---

arch/powerpc/net/bpf_jit_comp32.c | 12 ++++++++++++
 arch/powerpc/net/bpf_jit_comp64.c | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 2f39c50ca729..35f64dcfa68e 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -852,6 +852,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 
 			/* Get offset into TMP_REG */
 			EMIT(PPC_RAW_LI(tmp_reg, off));
+			/*
+			 * Enforce full ordering for operations with BPF_FETCH by emitting a 'sync'
+			 * before and after the operation.
+			 *
+			 * This is a requirement in the Linux Kernel Memory Model.
+			 * See __cmpxchg_u32() in asm/cmpxchg.h as an example.
+			 */
+			if ((imm & BPF_FETCH) && IS_ENABLED(CONFIG_SMP))
+				EMIT(PPC_RAW_SYNC());
 			tmp_idx = ctx->idx * 4;
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
index 79f23974a320..884eef1b3973 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -803,6 +803,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 
 			/* Get offset into TMP_REG_1 */
 			EMIT(PPC_RAW_LI(tmp1_reg, off));
+			/*
+			 * Enforce full ordering for operations with BPF_FETCH by emitting a 'sync'
+			 * before and after the operation.
+			 *
+			 * This is a requirement in the Linux Kernel Memory Model.
+			 * See __cmpxchg_u64() in asm/cmpxchg.h as an example.
+			 */
+			if ((imm & BPF_FETCH) && IS_ENABLED(CONFIG_SMP))
+				EMIT(PPC_RAW_SYNC());
 			tmp_idx = ctx->idx * 4;
 			/* load value from memory into TMP_REG_2 */
 			if (size == BPF_DW)
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
2.40.1


