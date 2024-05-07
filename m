Return-Path: <bpf+bounces-28916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE848BEADF
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0860B1C23E3C
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 17:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD8C16C86F;
	Tue,  7 May 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCM+bV+z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C915D5BB;
	Tue,  7 May 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715104497; cv=none; b=JBP12yhPEStZP58GLg1x+/AQkekvuHQmOuCfproUy+d1Lpf5LOf4ch2HHrmK4To4knWeVQpetwTXbTr0Ntz0v68QIAmDm5ts5RlwLxtaGuKUkn0KA9TYGmI3V44roblxJPh3OukE3nOBY+ySqB+T7L6vM8txfErN8CeEEq1e9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715104497; c=relaxed/simple;
	bh=uDjLVkavopOnCJiGjdVePDtNVdHPscLWRcS9JUdVQk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rn5I+EPYo2FpImXbpgtaFxu78VXxPerODdQTJ/KORLI5WsR7r3UL5HyAatbFVRyeN5GYDFyrRsLxMEKLvmu4eSDLYeBLHm9QLVLlROZvIYGcC8RQ0nq6+UajMauHQ9YOQLoWy5LjJ2+vrNTTmrKjan2TeuwWjvijn1+odS4T/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCM+bV+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F871C2BBFC;
	Tue,  7 May 2024 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715104496;
	bh=uDjLVkavopOnCJiGjdVePDtNVdHPscLWRcS9JUdVQk8=;
	h=From:To:Cc:Subject:Date:From;
	b=NCM+bV+zSSHM0SF7KwWG6eVUNX4KpeYhAiCETsZwjAFYNrx6sstPZrCFMyVhA4yEJ
	 AmLtuuuoqPJ0VrWPKbzCiDOEPoyXheVsO18eDOoHeYuIOVKGm+oHIjm0o12FuBJ5ca
	 ISiEgElsIrQpoTLRTqAIW5YZWbKJ7o3K0ZIFd2E+ZImeSS8gFR8ttp9QCGyZ8cvc2g
	 tZjFC/NOz6N4z5F7d5pI9SHkMmKu4hUrExjDm/78Ixh42XJP3yEQ5nczlO1hXYNQz1
	 M6QjT/AXAJ9yndG9gxobO5krXfrQBsm8YdmTD4r5p84gTS0WMGPvEyWkIgd+MXntSY
	 fgzrvg17DGtPA==
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
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf] powerpc/bpf: enforce full ordering for ATOMIC operations with BPF_FETCH
Date: Tue,  7 May 2024 17:54:39 +0000
Message-Id: <20240507175439.119467-1-puranjay@kernel.org>
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
 arch/powerpc/net/bpf_jit_comp32.c | 11 +++++++++++
 arch/powerpc/net/bpf_jit_comp64.c | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 2f39c50ca729..b635e5344e8a 100644
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
+			if (imm & BPF_FETCH)
+				EMIT(PPC_RAW_SYNC());
 			/* load value from memory into r0 */
 			EMIT(PPC_RAW_LWARX(_R0, tmp_reg, dst_reg, 0));
 
@@ -905,6 +914,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 
 			/* For the BPF_FETCH variant, get old data into src_reg */
 			if (imm & BPF_FETCH) {
+				/* Emit 'sync' to enforce full ordering */
+				EMIT(PPC_RAW_SYNC());
 				EMIT(PPC_RAW_MR(ret_reg, ax_reg));
 				if (!fp->aux->verifier_zext)
 					EMIT(PPC_RAW_LI(ret_reg - 1, 0)); /* higher 32-bit */
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 79f23974a320..27026f19605d 100644
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
+			if (imm & BPF_FETCH)
+				EMIT(PPC_RAW_SYNC());
 			/* load value from memory into TMP_REG_2 */
 			if (size == BPF_DW)
 				EMIT(PPC_RAW_LDARX(tmp2_reg, tmp1_reg, dst_reg, 0));
@@ -865,6 +874,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			PPC_BCC_SHORT(COND_NE, tmp_idx);
 
 			if (imm & BPF_FETCH) {
+				/* Emit 'sync' to enforce full ordering */
+				EMIT(PPC_RAW_SYNC());
 				EMIT(PPC_RAW_MR(ret_reg, _R0));
 				/*
 				 * Skip unnecessary zero-extension for 32-bit cmpxchg.
-- 
2.40.1


