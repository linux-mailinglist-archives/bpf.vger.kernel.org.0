Return-Path: <bpf+bounces-28450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE838B9D3D
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 17:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6551C21F6E
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D275915CD72;
	Thu,  2 May 2024 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCX5vmzJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D9715D5B7;
	Thu,  2 May 2024 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663157; cv=none; b=IbCCHSVpT/N4fWZawNR9YxeYA5fxlEZ0LPk8UXtsdCzu0uj0N2MugoI3Fl/ZFKF5433BC0jzB2/+DOCchhyroN9VLYs0SBxYQNWtb7QLKGCMl1x+/XeZk+rW+oIPu4k2Ca1/tcOQmlcWSsseoVfPbc4cEx/7zNwcDvb3X+y3Kt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663157; c=relaxed/simple;
	bh=dVkbPPOEYlOO5kBjSt35dRBCNkQAL05sdyArj2LEawg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMaVqAzoAwHGL5x6+WSnEMzh+uFmHSBqAh4QQ10cdS9odEixurOk3kWSniCxVwoffIkkAQbwnkFtFzWq02/E8/mBhoRmjDog6cJNARHMaJ0jRmYhgksYDFgYyRL5QNRVQxbfMfOwMby5mqHI8oUTVEtomfE4E3wXWOL5ZD1PFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCX5vmzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88079C113CC;
	Thu,  2 May 2024 15:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714663156;
	bh=dVkbPPOEYlOO5kBjSt35dRBCNkQAL05sdyArj2LEawg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCX5vmzJn9CwfI6v+x26P/3ngqI3XMjUPONi3BEMwyHq3mg5t9I1Fy/PuIkwIWZKj
	 DkNKuyNL6OwaNNNTRZGQM78S42qtv+JFEp2gc/BXUgYnYBKuAISGCTLHIzHgNn+iD7
	 2KqpbKs6th15e0dfWAQ9fPC/FAN3qjFpiey9Bo3krQPyd7DMbl78+F7ElPTfcGtbV0
	 iVobFiKq6Ttnhto95RzFeUQdVhcW7AMgKSWyGuZgRzx29WeLKa5pHEvuWuWppb2vKZ
	 klpVyLPIXfASbOvX34aYLMfGls9J9Cc0FO8oEpQFnLqyfJ+EX8XuVHJlylNiAioOnZ
	 GkSa3j6CcQahw==
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
Subject: [PATCH bpf-next v6 2/4] riscv, bpf: inline bpf_get_smp_processor_id()
Date: Thu,  2 May 2024 15:18:52 +0000
Message-Id: <20240502151854.9810-3-puranjay@kernel.org>
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

Inline the calls to bpf_get_smp_processor_id() in the riscv bpf jit.

RISCV saves the pointer to the CPU's task_struct in the TP (thread
pointer) register. This makes it trivial to get the CPU's processor id.
As thread_info is the first member of task_struct, we can read the
processor id from TP + offsetof(struct thread_info, cpu).

          RISCV64 JIT output for `call bpf_get_smp_processor_id`
	  ======================================================

                Before                           After
               --------                         -------

         auipc   t1,0x848c                  ld    a5,32(tp)
         jalr    604(t1)
         mv      a5,a0

Benchmark using [1] on Qemu.

./benchs/run_bench_trigger.sh glob-arr-inc arr-inc hash-inc

+---------------+------------------+------------------+--------------+
|      Name     |     Before       |       After      |   % change   |
|---------------+------------------+------------------+--------------|
| glob-arr-inc  | 1.077 ± 0.006M/s | 1.336 ± 0.010M/s |   + 24.04%   |
| arr-inc       | 1.078 ± 0.002M/s | 1.332 ± 0.015M/s |   + 23.56%   |
| hash-inc      | 0.494 ± 0.004M/s | 0.653 ± 0.001M/s |   + 32.18%   |
+---------------+------------------+------------------+--------------+

NOTE: This benchmark includes changes from this patch and the previous
      patch that implemented the per-cpu insn.

[1] https://github.com/anakryiko/linux/commit/8dec900975ef

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/riscv/net/bpf_jit_comp64.c | 26 ++++++++++++++++++++++++++
 include/linux/filter.h          |  1 +
 kernel/bpf/core.c               | 11 +++++++++++
 kernel/bpf/verifier.c           |  4 ++++
 4 files changed, 42 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 1f0159963b3e..a46ec7fb4489 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1493,6 +1493,22 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		bool fixed_addr;
 		u64 addr;
 
+		/* Inline calls to bpf_get_smp_processor_id()
+		 *
+		 * RV_REG_TP holds the address of the current CPU's task_struct and thread_info is
+		 * at offset 0 in task_struct.
+		 * Load cpu from thread_info:
+		 *     Set R0 to ((struct thread_info *)(RV_REG_TP))->cpu
+		 *
+		 * This replicates the implementation of raw_smp_processor_id() on RISCV
+		 */
+		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_get_smp_processor_id) {
+			/* Load current CPU number in R0 */
+			emit_ld(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu),
+				RV_REG_TP, ctx);
+			break;
+		}
+
 		mark_call(ctx);
 		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
 					    &addr, &fixed_addr);
@@ -2062,3 +2078,13 @@ bool bpf_jit_supports_percpu_insn(void)
 {
 	return true;
 }
+
+bool bpf_jit_inlines_helper_call(s32 imm)
+{
+	switch (imm) {
+	case BPF_FUNC_get_smp_processor_id:
+		return true;
+	default:
+		return false;
+	}
+}
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7a27f19bf44d..3e19bb62ed1a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -993,6 +993,7 @@ u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
+bool bpf_jit_inlines_helper_call(s32 imm);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 99b8b1c9a248..aa59af9f9bd9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2941,6 +2941,17 @@ bool __weak bpf_jit_needs_zext(void)
 	return false;
 }
 
+/* Return true if the JIT inlines the call to the helper corresponding to
+ * the imm.
+ *
+ * The verifier will not patch the insn->imm for the call to the helper if
+ * this returns true.
+ */
+bool __weak bpf_jit_inlines_helper_call(s32 imm)
+{
+	return false;
+}
+
 /* Return TRUE if the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool __weak bpf_jit_supports_subprog_tailcalls(void)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7360f04f9ec7..17a10d0686f3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20020,6 +20020,10 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
+		/* Skip inlining the helper call if the JIT does it. */
+		if (bpf_jit_inlines_helper_call(insn->imm))
+			goto next_insn;
+
 		if (insn->imm == BPF_FUNC_get_route_realm)
 			prog->dst_needed = 1;
 		if (insn->imm == BPF_FUNC_get_prandom_u32)
-- 
2.40.1


