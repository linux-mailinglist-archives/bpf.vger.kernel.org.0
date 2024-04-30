Return-Path: <bpf+bounces-28282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E08B7F55
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 19:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9589FB2140B
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 17:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC85E181B8F;
	Tue, 30 Apr 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOO7OhOn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32346184133;
	Tue, 30 Apr 2024 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499942; cv=none; b=A3xw3+EAsGNerUkMLcwwAoTiqXfDEz41ZiK7e9TC0X2YddMbDKb0zgTO61j2P2Vs/FdNmlyR6kXsZin3Kxq7lS3kf//yAZcBA4F55TgDWss2jDnEKWDBCAGoO+Bte1nIXx9p9MbWd1Gdj4dF04tiBi22zgy6uC7QkaSOLvdqJcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499942; c=relaxed/simple;
	bh=Wvx/3pXiVZjsGrp+teOKlOLjuKUzaKF+KK8AcSH3HgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=enZ0LF0CXcTzWmMKTFmyy6GYdG617XZcrlGRszSxkKbZ+BZlVCch+i0iuqNWf+n0ZvKx75Sxb8SLiBvD/x2+srkE6LAq6PQtn6o1ZCzk9YOvTQZ6OMCusdXDAbNAdSQ+hj4lslCbs5xMB9uyiVyxT3avvuKeowPEQGtaTfr9UQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOO7OhOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885D1C4AF17;
	Tue, 30 Apr 2024 17:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714499941;
	bh=Wvx/3pXiVZjsGrp+teOKlOLjuKUzaKF+KK8AcSH3HgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qOO7OhOn9XLshqvaybfK7bFe0eJuH5Av0Ybf7MV/Jn0CiLYmY5I92Qg9TjhhLzs/I
	 8RigUH/4VhbXPXQ1zHER+H8/A7eWLNO1FyAmMrwM7Mt8mbXoP5DqNcBsE7wpnsyZm7
	 z5F0POfbb+8Y/R4sNXBsEGjc54hFHz1tMTHH5pD6YjI0gu0mPRG+bW7p0UgMHmbDFp
	 6KXbDW269CXDV18gkJeHpjaH6t+BDnRoQbuUVpomshG9CqI51PUo7Uu8enRAIBdEjr
	 I0y1gGib+X9gJHN9kC1jshrY42KUzGeQy15KvxWB1tmK7kKsTNny44JhQcZqnaHF6l
	 DuEHWNnBGn2WQ==
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pu Lehui <pulehui@huawei.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v2 2/2] riscv, bpf: inline bpf_get_smp_processor_id()
Date: Tue, 30 Apr 2024 17:58:34 +0000
Message-Id: <20240430175834.33152-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240430175834.33152-1-puranjay@kernel.org>
References: <20240430175834.33152-1-puranjay@kernel.org>
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
---
 arch/riscv/net/bpf_jit_comp64.c | 26 ++++++++++++++++++++++++++
 include/linux/filter.h          |  1 +
 kernel/bpf/core.c               | 11 +++++++++++
 kernel/bpf/verifier.c           |  2 ++
 4 files changed, 40 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 99d7006f1420..5789b7afae47 100644
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
+	}
+
+	return false;
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
index 5d42db05315e..e78f766d7f91 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20013,6 +20013,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
+		if (bpf_jit_inlines_helper_call(insn->imm))
+			goto next_insn;
 		if (insn->imm == BPF_FUNC_get_route_realm)
 			prog->dst_needed = 1;
 		if (insn->imm == BPF_FUNC_get_prandom_u32)
-- 
2.40.1


