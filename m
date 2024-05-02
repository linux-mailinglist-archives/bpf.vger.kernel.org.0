Return-Path: <bpf+bounces-28449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CB68B9D37
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 17:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2399C28253A
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 15:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2EE15B57F;
	Thu,  2 May 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWcVk3MI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7315B540;
	Thu,  2 May 2024 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663153; cv=none; b=Ur3jui6sQdoY+o1wCnXkqa7Uz+IDxVkUGdygeOmCqT0FRkyXT8eKG8i8VqISNm5zYLP42NzsHnSNhN/32R+G08DhPl17/pYDnYkuS5o4eKQCfTp/17ZXjeL+jkyJ4hAFVOpGTCw1LdFaByA450/sv5HRlKnr3GzUTkeKlkbvwtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663153; c=relaxed/simple;
	bh=NlOfpDA9479fClDBYpH3IncZJ/YB0fwZk2zOr/dFfoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8/S7X1XADp16SDAndogVrY9bbWFRfx4WXspSh1TDPqfNQi81MNLwVaG6dh8cLL/53Cs2LEEL3ascYFmD643MbV6dWGXLv5jDPklJKMJkW947iZFFDmy9aEtfAIda0vfnOT0YXDERvLsdguSNkJMvz/1fAwVeQb+OyVEjbbyaQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWcVk3MI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20DBC113CC;
	Thu,  2 May 2024 15:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714663153;
	bh=NlOfpDA9479fClDBYpH3IncZJ/YB0fwZk2zOr/dFfoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWcVk3MIlgLKK2+jBElztSJifGpt9ofuMwJESSDfi+LXIjP2CIV+w0MspPnRBiXSm
	 cDxCg/nqZShKg6CndhiHdrvQ64StPrG32oj2iqrGLOFlaxbKLf8N8YN3Do8aXtbdUy
	 9oN7nnZZ5lClKlHKDratrmhsBeVA8XegTWOWBB6Grbx2jnBtjiV070MSk+lWPupD47
	 MccQQtBp2FD61PNP77oVje61mJ++mTFBOPreG2mFopbfWOODeKJQ7VlcaOTTEqo67b
	 Pleh/IMYOy4sltl4R/HwCNjG1L/qrhmu0H+ZKrrMoaxO7mtPzcKZX0qim4CTv0rLpC
	 Fygozg1h3z30w==
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
Subject: [PATCH bpf-next v6 1/4] riscv, bpf: add internal-only MOV instruction to resolve per-CPU addrs
Date: Thu,  2 May 2024 15:18:51 +0000
Message-Id: <20240502151854.9810-2-puranjay@kernel.org>
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

Support an instruction for resolving absolute addresses of per-CPU
data from their per-CPU offsets. This instruction is internal-only and
users are not allowed to use them directly. They will only be used for
internal inlining optimizations for now between BPF verifier and BPF
JITs.

RISC-V uses generic per-cpu implementation where the offsets for CPUs
are kept in an array called __per_cpu_offset[cpu_number]. RISCV stores
the address of the task_struct in TP register. The first element in
task_struct is struct thread_info, and we can get the cpu number by
reading from the TP register + offsetof(struct thread_info, cpu).

Once we have the cpu number in a register we read the offset for that
cpu from address: &__per_cpu_offset + cpu_number << 3. Then we add this
offset to the destination register.

To measure the improvement from this change, the benchmark in [1] was
used on Qemu:

Before:
glob-arr-inc   :    1.127 ± 0.013M/s
arr-inc        :    1.121 ± 0.004M/s
hash-inc       :    0.681 ± 0.052M/s

After:
glob-arr-inc   :    1.138 ± 0.011M/s
arr-inc        :    1.366 ± 0.006M/s
hash-inc       :    0.676 ± 0.001M/s

[1] https://github.com/anakryiko/linux/commit/8dec900975ef

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/riscv/net/bpf_jit_comp64.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 15e482f2c657..1f0159963b3e 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -12,6 +12,7 @@
 #include <linux/stop_machine.h>
 #include <asm/patch.h>
 #include <asm/cfi.h>
+#include <asm/percpu.h>
 #include "bpf_jit.h"
 
 #define RV_FENTRY_NINSNS 2
@@ -1089,6 +1090,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_or(RV_REG_T1, rd, RV_REG_T1, ctx);
 			emit_mv(rd, RV_REG_T1, ctx);
 			break;
+		} else if (insn_is_mov_percpu_addr(insn)) {
+			if (rd != rs)
+				emit_mv(rd, rs, ctx);
+#ifdef CONFIG_SMP
+			/* Load current CPU number in T1 */
+			emit_ld(RV_REG_T1, offsetof(struct thread_info, cpu),
+				RV_REG_TP, ctx);
+			/* << 3 because offsets are 8 bytes */
+			emit_slli(RV_REG_T1, RV_REG_T1, 3, ctx);
+			/* Load address of __per_cpu_offset array in T2 */
+			emit_addr(RV_REG_T2, (u64)&__per_cpu_offset, extra_pass, ctx);
+			/* Add offset of current CPU to  __per_cpu_offset */
+			emit_add(RV_REG_T1, RV_REG_T2, RV_REG_T1, ctx);
+			/* Load __per_cpu_offset[cpu] in T1 */
+			emit_ld(RV_REG_T1, 0, RV_REG_T1, ctx);
+			/* Add the offset to Rd */
+			emit_add(rd, rd, RV_REG_T1, ctx);
+#endif
 		}
 		if (imm == 1) {
 			/* Special mov32 for zext */
@@ -2038,3 +2057,8 @@ bool bpf_jit_supports_arena(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_percpu_insn(void)
+{
+	return true;
+}
-- 
2.40.1


