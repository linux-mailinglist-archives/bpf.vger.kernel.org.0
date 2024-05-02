Return-Path: <bpf+bounces-28452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C7C8B9D41
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 17:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4632895C2
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 15:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0806715E5CF;
	Thu,  2 May 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhDthDON"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5D15E5A7;
	Thu,  2 May 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663163; cv=none; b=mPuwwp2HWlgUXH7zPfINggBSubD6WsBlKqcxRcsuBBwFxKifNDEuPhy7vSAuzpAcNiD/G8OA9AWsSMNVbXFB2OaITj4TsWADHLOru6Z3qF1828iuBxNWGyEh9J5f0Vjcm10cXj6xKQtZNsm55mN15e0LSuEwEFFcUfZCo3BLZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663163; c=relaxed/simple;
	bh=wLtf6Vhthcho1ROwU7Gg0KD5v6EHV93qrM8f17IjXSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpNMf4m+9c1NdlRmHhujvsE7VzTCdphFmQ3mmOGW2g/6CPKAf0NTyB83J4LHE+kN/vuAuMiDxxGTgkOe7yBo7pjjy82WwbAnG7GJMdXVt1f8XessCtCSZQKWmQNZvFuuS7H4jw2ESpZdTyyfRJcuedhTCJgCeT9oOjcehLDEF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhDthDON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66FDC4AF18;
	Thu,  2 May 2024 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714663163;
	bh=wLtf6Vhthcho1ROwU7Gg0KD5v6EHV93qrM8f17IjXSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhDthDON+xN2zOmrVb86uMduxB9JoK+964Ynr9bscOVgfionZPZrWJuvcY9km+UhX
	 ujzzBdg6NEu+3i6KDHx6wvxjG4VNQ7BzbffVoP5ehB73JQQb2sR1Oxk/72OauDKTe5
	 TCeXXMRQQWFYmD114mphR44vWjKccBc/JS5VUXKOz6BYLUZxGYBtJH0kW7IKJDC6Yr
	 6rmZRdh8ywgwCD86LQe5g0B2R0TkMqqqThoJB48ipEnVJezZPCiuy4gGrbVMnS7b4o
	 uK3Q7Eo7fcehiOqPO3jVliARlb3kqHbIwEZ7LpYiAv0g/pwcTY+EeFmxT/dxC7CVq0
	 kCnqQ1VqAU+Qg==
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
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v6 4/4] bpf, arm64: inline bpf_get_smp_processor_id() helper
Date: Thu,  2 May 2024 15:18:54 +0000
Message-Id: <20240502151854.9810-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240502151854.9810-1-puranjay@kernel.org>
References: <20240502151854.9810-1-puranjay@kernel.org>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/arm64/include/asm/insn.h |  1 +
 arch/arm64/net/bpf_jit.h      |  2 ++
 arch/arm64/net/bpf_jit_comp.c | 25 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+)

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
index ed8f9716d9d5..1cebe9c92f51 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1215,6 +1215,21 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		const u8 r0 = bpf2a64[BPF_REG_0];
 		bool func_addr_fixed;
 		u64 func_addr;
+		u32 cpu_offset;
+
+		/* Implement helper call to bpf_get_smp_processor_id() inline */
+		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_get_smp_processor_id) {
+			cpu_offset = offsetof(struct thread_info, cpu);
+
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
@@ -2541,6 +2556,16 @@ bool bpf_jit_supports_percpu_insn(void)
 	return true;
 }
 
+bool bpf_jit_inlines_helper_call(s32 imm)
+{
+	switch (imm) {
+	case BPF_FUNC_get_smp_processor_id:
+		return true;
+	default:
+		return false;
+	}
+}
+
 void bpf_jit_free(struct bpf_prog *prog)
 {
 	if (prog->jited) {
-- 
2.40.1


