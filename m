Return-Path: <bpf+bounces-63652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A687B093DC
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 20:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8F45A2878
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF6E2FE383;
	Thu, 17 Jul 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoMYEtIa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4257E1DA10B;
	Thu, 17 Jul 2025 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752776695; cv=none; b=bIXjXldOHmVumYZHa7RkNUCo9tpMZI3xW8kmQEYcVT6wF3c9GTp43F5Ai9uX/2XMfCnLWmzQa99xKxHfPeBHMYmyMMRChxlN3Q52TJlNPJr4zs0yL7kiqd1Ueki54HqFn5bBfT5/C263AFq/0AsZO4EfoaSBG5urC6pmpx+wz6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752776695; c=relaxed/simple;
	bh=q8eKevXXi+UQ1OwFBOXGgOAL2sn/edb+P2x0UDs5fKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=al0oVs4yyNkE7ch6+gNS+nJ8Nu2pYl++AkoPn9hZ5HOo9FEsiJo/d6VTWgakybCqEeyhivwq7Pqx6GsDtYvFeGdM7W7w9REhP+4ZlTEOI+ynWySepVbpj821GnngJvKLm07fDOUP8bnRx3avnCljPyjM2fsUoJWMVh++F3Rll6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoMYEtIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF84C4CEE3;
	Thu, 17 Jul 2025 18:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752776694;
	bh=q8eKevXXi+UQ1OwFBOXGgOAL2sn/edb+P2x0UDs5fKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qoMYEtIa27OeLBqqivsgvtk/Vg6bQIfYI4P1QYVk02Hw6Ju50qVIus8U537TJRdjP
	 VXtKK2fQnkd5ns16zUWS3XPVeMo57KuaoEC7oe6cNTrTDlPIujqWj9VlbOjuudjHvV
	 cLOmbN9n8SGiB5zDtTMLL3RNIulyHc18vjxksuu73WyzqQsVxDSai9iIq0F8WKf1BC
	 yyUEn9q2Ff0ZqMBLhDD0fdI1P2I0QRfoZct7lPtdSK4WQ/JUsht+9yTDpQoasAdIxZ
	 yay6ikjovkyppqsgpUa3CX6zqAD55H53PWm//E7p5wWYe94cImRpGyYQJx4x9zR+XV
	 6hbWaOPtl30Mw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Naveen N Rao <naveen@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Peilin Ye <yepeilin@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	lkmm@lists.linux.dev
Subject: [PATCH bpf-next 1/1] powerpc64/bpf: Add jit support for load_acquire and store_release
Date: Thu, 17 Jul 2025 18:24:43 +0000
Message-ID: <20250717182446.9408-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250717182446.9408-1-puranjay@kernel.org>
References: <20250717182446.9408-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add JIT support for the load_acquire and store_release instructions. The
implementation is similar to the kernel where:

        load_acquire  => plain load -> lwsync
        store_release => lwsync -> plain store

To test the correctness of the implementation, following selftests were
run:

  [fedora@linux-kernel bpf]$ sudo ./test_progs -a \
  verifier_load_acquire,verifier_store_release,atomics
  #11/1    atomics/add:OK
  #11/2    atomics/sub:OK
  #11/3    atomics/and:OK
  #11/4    atomics/or:OK
  #11/5    atomics/xor:OK
  #11/6    atomics/cmpxchg:OK
  #11/7    atomics/xchg:OK
  #11      atomics:OK
  #519/1   verifier_load_acquire/load-acquire, 8-bit:OK
  #519/2   verifier_load_acquire/load-acquire, 8-bit @unpriv:OK
  #519/3   verifier_load_acquire/load-acquire, 16-bit:OK
  #519/4   verifier_load_acquire/load-acquire, 16-bit @unpriv:OK
  #519/5   verifier_load_acquire/load-acquire, 32-bit:OK
  #519/6   verifier_load_acquire/load-acquire, 32-bit @unpriv:OK
  #519/7   verifier_load_acquire/load-acquire, 64-bit:OK
  #519/8   verifier_load_acquire/load-acquire, 64-bit @unpriv:OK
  #519/9   verifier_load_acquire/load-acquire with uninitialized
  src_reg:OK
  #519/10  verifier_load_acquire/load-acquire with uninitialized src_reg
  @unpriv:OK
  #519/11  verifier_load_acquire/load-acquire with non-pointer src_reg:OK
  #519/12  verifier_load_acquire/load-acquire with non-pointer src_reg
  @unpriv:OK
  #519/13  verifier_load_acquire/misaligned load-acquire:OK
  #519/14  verifier_load_acquire/misaligned load-acquire @unpriv:OK
  #519/15  verifier_load_acquire/load-acquire from ctx pointer:OK
  #519/16  verifier_load_acquire/load-acquire from ctx pointer @unpriv:OK
  #519/17  verifier_load_acquire/load-acquire with invalid register R15:OK
  #519/18  verifier_load_acquire/load-acquire with invalid register R15
  @unpriv:OK
  #519/19  verifier_load_acquire/load-acquire from pkt pointer:OK
  #519/20  verifier_load_acquire/load-acquire from flow_keys pointer:OK
  #519/21  verifier_load_acquire/load-acquire from sock pointer:OK
  #519     verifier_load_acquire:OK
  #556/1   verifier_store_release/store-release, 8-bit:OK
  #556/2   verifier_store_release/store-release, 8-bit @unpriv:OK
  #556/3   verifier_store_release/store-release, 16-bit:OK
  #556/4   verifier_store_release/store-release, 16-bit @unpriv:OK
  #556/5   verifier_store_release/store-release, 32-bit:OK
  #556/6   verifier_store_release/store-release, 32-bit @unpriv:OK
  #556/7   verifier_store_release/store-release, 64-bit:OK
  #556/8   verifier_store_release/store-release, 64-bit @unpriv:OK
  #556/9   verifier_store_release/store-release with uninitialized
  src_reg:OK
  #556/10  verifier_store_release/store-release with uninitialized src_reg
  @unpriv:OK
  #556/11  verifier_store_release/store-release with uninitialized
  dst_reg:OK
  #556/12  verifier_store_release/store-release with uninitialized dst_reg
  @unpriv:OK
  #556/13  verifier_store_release/store-release with non-pointer
  dst_reg:OK
  #556/14  verifier_store_release/store-release with non-pointer dst_reg
  @unpriv:OK
  #556/15  verifier_store_release/misaligned store-release:OK
  #556/16  verifier_store_release/misaligned store-release @unpriv:OK
  #556/17  verifier_store_release/store-release to ctx pointer:OK
  #556/18  verifier_store_release/store-release to ctx pointer @unpriv:OK
  #556/19  verifier_store_release/store-release, leak pointer to stack:OK
  #556/20  verifier_store_release/store-release, leak pointer to stack
  @unpriv:OK
  #556/21  verifier_store_release/store-release, leak pointer to map:OK
  #556/22  verifier_store_release/store-release, leak pointer to map
  @unpriv:OK
  #556/23  verifier_store_release/store-release with invalid register
  R15:OK
  #556/24  verifier_store_release/store-release with invalid register R15
  @unpriv:OK
  #556/25  verifier_store_release/store-release to pkt pointer:OK
  #556/26  verifier_store_release/store-release to flow_keys pointer:OK
  #556/27  verifier_store_release/store-release to sock pointer:OK
  #556     verifier_store_release:OK
  Summary: 3/55 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/powerpc/include/asm/ppc-opcode.h        |  1 +
 arch/powerpc/net/bpf_jit_comp64.c            | 82 ++++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h |  3 +-
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 4312bcb913a42..8053b24afc395 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -425,6 +425,7 @@
 #define PPC_RAW_SC()			(0x44000002)
 #define PPC_RAW_SYNC()			(0x7c0004ac)
 #define PPC_RAW_ISYNC()			(0x4c00012c)
+#define PPC_RAW_LWSYNC()		(0x7c2004ac)
 
 /*
  * Define what the VSX XX1 form instructions will look like, then add
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index a25a6ffe7d7cc..025524378443e 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -409,6 +409,71 @@ asm (
 "		blr				;"
 );
 
+static int emit_atomic_ld_st(const struct bpf_insn insn, struct codegen_context *ctx, u32 *image)
+{
+	u32 code = insn.code;
+	u32 dst_reg = bpf_to_ppc(insn.dst_reg);
+	u32 src_reg = bpf_to_ppc(insn.src_reg);
+	u32 size = BPF_SIZE(code);
+	u32 tmp1_reg = bpf_to_ppc(TMP_REG_1);
+	u32 tmp2_reg = bpf_to_ppc(TMP_REG_2);
+	s16 off = insn.off;
+	s32 imm = insn.imm;
+
+	switch (imm) {
+	case BPF_LOAD_ACQ:
+		switch (size) {
+		case BPF_B:
+			EMIT(PPC_RAW_LBZ(dst_reg, src_reg, off));
+			break;
+		case BPF_H:
+			EMIT(PPC_RAW_LHZ(dst_reg, src_reg, off));
+			break;
+		case BPF_W:
+			EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off));
+			break;
+		case BPF_DW:
+			if (off % 4) {
+				EMIT(PPC_RAW_LI(tmp1_reg, off));
+				EMIT(PPC_RAW_LDX(dst_reg, src_reg, tmp1_reg));
+			} else {
+				EMIT(PPC_RAW_LD(dst_reg, src_reg, off));
+			}
+			break;
+		}
+		EMIT(PPC_RAW_LWSYNC());
+		break;
+	case BPF_STORE_REL:
+		EMIT(PPC_RAW_LWSYNC());
+		switch (size) {
+		case BPF_B:
+			EMIT(PPC_RAW_STB(src_reg, dst_reg, off));
+			break;
+		case BPF_H:
+			EMIT(PPC_RAW_STH(src_reg, dst_reg, off));
+			break;
+		case BPF_W:
+			EMIT(PPC_RAW_STW(src_reg, dst_reg, off));
+			break;
+		case BPF_DW:
+			if (off % 4) {
+				EMIT(PPC_RAW_LI(tmp2_reg, off));
+				EMIT(PPC_RAW_STDX(src_reg, dst_reg, tmp2_reg));
+			} else {
+				EMIT(PPC_RAW_STD(src_reg, dst_reg, off));
+			}
+			break;
+		}
+		break;
+	default:
+		pr_err_ratelimited("unexpected atomic load/store op code %02x\n",
+				   imm);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Assemble the body code between the prologue & epilogue */
 int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
 		       u32 *addrs, int pass, bool extra_pass)
@@ -898,8 +963,25 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		/*
 		 * BPF_STX ATOMIC (atomic ops)
 		 */
+		case BPF_STX | BPF_ATOMIC | BPF_B:
+		case BPF_STX | BPF_ATOMIC | BPF_H:
 		case BPF_STX | BPF_ATOMIC | BPF_W:
 		case BPF_STX | BPF_ATOMIC | BPF_DW:
+			if (bpf_atomic_is_load_store(&insn[i])) {
+				ret = emit_atomic_ld_st(insn[i], ctx, image);
+				if (ret)
+					return ret;
+
+				if (size != BPF_DW && insn_is_zext(&insn[i + 1]))
+					addrs[++i] = ctx->idx * 4;
+				break;
+			} else if (size == BPF_B || size == BPF_H) {
+				pr_err_ratelimited(
+					"eBPF filter atomic op code %02x (@%d) unsupported\n",
+					code, i);
+				return -EOPNOTSUPP;
+			}
+
 			save_reg = tmp2_reg;
 			ret_reg = src_reg;
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 530752ddde8e4..c1cfd297aabf1 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -229,7 +229,8 @@
 
 #if __clang_major__ >= 18 && defined(ENABLE_ATOMICS_TESTS) &&		\
 	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
-	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
+	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) || \
+	  (defined(__TARGET_ARCH_powerpc))
 #define CAN_USE_LOAD_ACQ_STORE_REL
 #endif
 
-- 
2.47.1


