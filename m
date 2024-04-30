Return-Path: <bpf+bounces-28307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359348B831F
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 01:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AD728508E
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 23:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5241C230D;
	Tue, 30 Apr 2024 23:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSA+FgDi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAC1C0DD6;
	Tue, 30 Apr 2024 23:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714520884; cv=none; b=s/WqerhFmUn5BAOLs1b3IYZtUR188qHvgz+T8kSmWMg6XAUK/R8SCypr8ezDoh9Bum22Ho4k16CQdBHTRNYGckkemkURPH1T2xf7Yh1obqvW5qzv7DPb4+8Wl28EourGFpr0ysMoRmYuFq52nL9b72cT3wo8Z6c9u40Ed14vO4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714520884; c=relaxed/simple;
	bh=TbPOTBmS82ynsL8h5jbyPu2ZW+Geh2onSqdzZPRv0KM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwZ6FvzAR94qjDMxvS1TPi9+7WgPPNxVVnetmsukzzMbomjzP76e+L206h1F7wUki9ojiyiLOXEolXqlG9bSA/F8Srq7VCUHj8zSrZtYruntaSu9EbxsraKehkridBlfKPAIo1XmdBfzsEM6WpQ+NQfCiOd8QlRpUr7Ds0rNo1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSA+FgDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5121CC2BBFC;
	Tue, 30 Apr 2024 23:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714520883;
	bh=TbPOTBmS82ynsL8h5jbyPu2ZW+Geh2onSqdzZPRv0KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSA+FgDi+93WO+AFQJliW6fz07aPhOuPF3H2U+c9iHEUTs8IdNonD5Nryx+QQYDyW
	 3UJni0G5GvaP455JRIG2yJyaN8i1FzTO9j/VLBbbVkx+O0itXnRVZwJ1qjBSeKWQ6g
	 1lSHCQ7k7q/ITIAcOJe7nfUQiNc7eOUl1n12R7UElCLp/jiadB6ncVGUJG3rqWbx5Z
	 pp+njNfqGUeHYTFeBpVeb/aKhm2ByJUsLSU3noLHUwltQcSBbD+FQzV/nWcTDf5oqb
	 oGGlEI7IUIMo+Hs9iUDdv7eoXJbO06sWhua7lV6mpBtFZcj/KW09ix8BUY+Jjozzb3
	 iaBTbY7Hq3VOg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	Florent Revest <revest@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v5 1/2] arm64, bpf: add internal-only MOV instruction to resolve per-CPU addrs
Date: Tue, 30 Apr 2024 23:47:38 +0000
Message-Id: <20240430234739.79185-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430234739.79185-1-puranjay@kernel.org>
References: <20240430234739.79185-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay12@gmail.com>

Support an instruction for resolving absolute addresses of per-CPU
data from their per-CPU offsets. This instruction is internal-only and
users are not allowed to use them directly. They will only be used for
internal inlining optimizations for now between BPF verifier and BPF
JITs.

Since commit 7158627686f0 ("arm64: percpu: implement optimised pcpu
access using tpidr_el1"), the per-cpu offset for the CPU is stored in
the tpidr_el1/2 register of that CPU.

To support this BPF instruction in the ARM64 JIT, the following ARM64
instructions are emitted:

mov dst, src		// Move src to dst, if src != dst
mrs tmp, tpidr_el1/2	// Move per-cpu offset of the current cpu in tmp.
add dst, dst, tmp	// Add the per cpu offset to the dst.

To measure the performance improvement provided by this change, the
benchmark in [1] was used:

Before:
glob-arr-inc   :   23.597 ± 0.012M/s
arr-inc        :   23.173 ± 0.019M/s
hash-inc       :   12.186 ± 0.028M/s

After:
glob-arr-inc   :   23.819 ± 0.034M/s
arr-inc        :   23.285 ± 0.017M/s
hash-inc       :   12.419 ± 0.011M/s

[1] https://github.com/anakryiko/linux/commit/8dec900975ef

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/include/asm/insn.h |  7 +++++++
 arch/arm64/lib/insn.c         | 11 +++++++++++
 arch/arm64/net/bpf_jit.h      |  6 ++++++
 arch/arm64/net/bpf_jit_comp.c | 14 ++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index db1aeacd4cd9..8de0e39b29f3 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -135,6 +135,11 @@ enum aarch64_insn_special_register {
 	AARCH64_INSN_SPCLREG_SP_EL2	= 0xF210
 };
 
+enum aarch64_insn_system_register {
+	AARCH64_INSN_SYSREG_TPIDR_EL1	= 0x4684,
+	AARCH64_INSN_SYSREG_TPIDR_EL2	= 0x6682,
+};
+
 enum aarch64_insn_variant {
 	AARCH64_INSN_VARIANT_32BIT,
 	AARCH64_INSN_VARIANT_64BIT
@@ -686,6 +691,8 @@ u32 aarch64_insn_gen_cas(enum aarch64_insn_register result,
 }
 #endif
 u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type);
+u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
+			 enum aarch64_insn_system_register sysreg);
 
 s32 aarch64_get_branch_offset(u32 insn);
 u32 aarch64_set_branch_offset(u32 insn, s32 offset);
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index a635ab83fee3..b008a9b46a7f 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -1515,3 +1515,14 @@ u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
 
 	return insn;
 }
+
+u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
+			 enum aarch64_insn_system_register sysreg)
+{
+	u32 insn = aarch64_insn_get_mrs_value();
+
+	insn &= ~GENMASK(19, 0);
+	insn |= sysreg << 5;
+	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT,
+					    insn, result);
+}
diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 23b1b34db088..b627ef7188c7 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -297,4 +297,10 @@
 #define A64_ADR(Rd, offset) \
 	aarch64_insn_gen_adr(0, offset, Rd, AARCH64_INSN_ADR_TYPE_ADR)
 
+/* MRS */
+#define A64_MRS_TPIDR_EL1(Rt) \
+	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_TPIDR_EL1)
+#define A64_MRS_TPIDR_EL2(Rt) \
+	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_TPIDR_EL2)
+
 #endif /* _BPF_JIT_H */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 76b91f36c729..ed8f9716d9d5 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -877,6 +877,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit(A64_ORR(1, tmp, dst, tmp), ctx);
 			emit(A64_MOV(1, dst, tmp), ctx);
 			break;
+		} else if (insn_is_mov_percpu_addr(insn)) {
+			if (dst != src)
+				emit(A64_MOV(1, dst, src), ctx);
+			if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
+				emit(A64_MRS_TPIDR_EL2(tmp), ctx);
+			else
+				emit(A64_MRS_TPIDR_EL1(tmp), ctx);
+			emit(A64_ADD(1, dst, dst, tmp), ctx);
+			break;
 		}
 		switch (insn->off) {
 		case 0:
@@ -2527,6 +2536,11 @@ bool bpf_jit_supports_arena(void)
 	return true;
 }
 
+bool bpf_jit_supports_percpu_insn(void)
+{
+	return true;
+}
+
 void bpf_jit_free(struct bpf_prog *prog)
 {
 	if (prog->jited) {
-- 
2.40.1


