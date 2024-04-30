Return-Path: <bpf+bounces-28308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C2B8B8321
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 01:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54C4B2166F
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 23:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131391C2331;
	Tue, 30 Apr 2024 23:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW15PHNu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2961C2327;
	Tue, 30 Apr 2024 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714520887; cv=none; b=CJjMJGFZAE0qVRPKv+vafEhAx1EEiTPnQK3hMug9YOATJ/oqroTYy/7rTdLTYtUVoup3EiCyEMzCNchwOrec2FDQjGzgsTdNi5XQlwDW1Rdt0ncU4dho+dIsjX0caS1lnCPlBy9qJb4t1n3beOY86iGCB5USANvzVB1tDi9Xytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714520887; c=relaxed/simple;
	bh=CJftWXVNhPrzRJ8tO7vV2W8FE8qYON08xPmi6fVAAdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPB78mJDXaeKGGwrOFi7X2dMxJtDDNbAF/hifBhaxoqaQbcmxGt21HqeVPUX/w1eY/EgYxZg3IhzVwTgmM1Xn/Oybvp5KRGfdHHe3XXJepJKP4JpHEbEzeX+EjNpf1GaWT916BGH4ZjhZB2r+MkOFTG7VWq/M1WaMlvLBaagU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW15PHNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3EFC4AF1B;
	Tue, 30 Apr 2024 23:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714520887;
	bh=CJftWXVNhPrzRJ8tO7vV2W8FE8qYON08xPmi6fVAAdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OW15PHNubEu4xCwocIM+Qm5Bb70vBbuA9qr4coQ00C6pV9cKp8NBbJOiSJDcEnlx+
	 /itoRLDRYZPh2QCIk+9VEZ0O3IGWVfrLoUCq4NJ4avE4j3HztGFDAzcAvWEydVV3lE
	 zpzf3hCSrPuEpZq7wXe2KyGZ8HOXO0Y1Dpru4FOXF3pZ5+uJqQRiLDM27DNO3WGNBl
	 aZcROQfzDsb7UjCZuvlX4uJA8ofTIOc0ZFITL5bsa1Q9r8kXgv4n76a/qnTGvdsavj
	 RNp4CbyoAyFtmbu1iDGVdoFJrmz03MNMnS7RlExPXRpOSbM7ABgGQSSclqkVQTb3+Q
	 bfmnrQPYBgc4Q==
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
Subject: [PATCH bpf-next v5 2/2] bpf, arm64: inline bpf_get_smp_processor_id() helper
Date: Tue, 30 Apr 2024 23:47:39 +0000
Message-Id: <20240430234739.79185-3-puranjay@kernel.org>
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

Inline calls to bpf_get_smp_processor_id() helper in the JIT by emitting
a read from struct thread_info. The SP_EL0 system register holds the
pointer to the task_struct and thread_info is the first member of this
struct. We can read the cpu number from the thread_info.

Here is how the ARM64 JITed assembly changes after this commit:

                                      ARM64 JIT
                                     ===========

              BEFORE                                    AFTER
             --------                                  -------

int cpu = bpf_get_smp_processor_id();        int cpu = bpf_get_smp_processor_id();

mov     x10, #0xfffffffffffff4d0             mrs     x10, sp_el0
movk    x10, #0x802b, lsl #16                ldr     w7, [x10, #24]
movk    x10, #0x8000, lsl #32
blr     x10
add     x7, x0, #0x0

               Performance improvement using benchmark[1]

./benchs/run_bench_trigger.sh glob-arr-inc arr-inc hash-inc

+---------------+-------------------+-------------------+--------------+
|      Name     |      Before       |        After      |   % change   |
|---------------+-------------------+-------------------+--------------|
| glob-arr-inc  | 23.380 ± 1.675M/s | 25.893 ± 0.026M/s |   + 10.74%   |
| arr-inc       | 23.928 ± 0.034M/s | 25.213 ± 0.063M/s |   + 5.37%    |
| hash-inc      | 12.352 ± 0.005M/s | 12.609 ± 0.013M/s |   + 2.08%    |
+---------------+-------------------+-------------------+--------------+

[1] https://github.com/anakryiko/linux/commit/8dec900975ef

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/include/asm/insn.h |  1 +
 arch/arm64/net/bpf_jit.h      |  2 ++
 arch/arm64/net/bpf_jit_comp.c | 23 +++++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 8de0e39b29f3..8c0a36f72d6f 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -138,6 +138,7 @@ enum aarch64_insn_special_register {
 enum aarch64_insn_system_register {
 	AARCH64_INSN_SYSREG_TPIDR_EL1	= 0x4684,
 	AARCH64_INSN_SYSREG_TPIDR_EL2	= 0x6682,
+	AARCH64_INSN_SYSREG_SP_EL0	= 0x4208,
 };
 
 enum aarch64_insn_variant {
diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index b627ef7188c7..b22ab2f97a30 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -302,5 +302,7 @@
 	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_TPIDR_EL1)
 #define A64_MRS_TPIDR_EL2(Rt) \
 	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_TPIDR_EL2)
+#define A64_MRS_SP_EL0(Rt) \
+	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_SP_EL0)
 
 #endif /* _BPF_JIT_H */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index ed8f9716d9d5..8084f3e61e0b 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1215,6 +1215,19 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		const u8 r0 = bpf2a64[BPF_REG_0];
 		bool func_addr_fixed;
 		u64 func_addr;
+		u32 cpu_offset = offsetof(struct thread_info, cpu);
+
+		/* Implement helper call to bpf_get_smp_processor_id() inline */
+		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_get_smp_processor_id) {
+			emit(A64_MRS_SP_EL0(tmp), ctx);
+			if (is_lsi_offset(cpu_offset, 2)) {
+				emit(A64_LDR32I(r0, tmp, cpu_offset), ctx);
+			} else {
+				emit_a64_mov_i(1, tmp2, cpu_offset, ctx);
+				emit(A64_LDR32(r0, tmp, tmp2), ctx);
+			}
+			break;
+		}
 
 		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
 					    &func_addr, &func_addr_fixed);
@@ -2541,6 +2554,16 @@ bool bpf_jit_supports_percpu_insn(void)
 	return true;
 }
 
+bool bpf_jit_inlines_helper_call(s32 imm)
+{
+	switch (imm) {
+	case BPF_FUNC_get_smp_processor_id:
+		return true;
+	}
+
+	return false;
+}
+
 void bpf_jit_free(struct bpf_prog *prog)
 {
 	if (prog->jited) {
-- 
2.40.1


