Return-Path: <bpf+bounces-27922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6D98B36FA
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 14:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719211C21C48
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 12:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE103146A7A;
	Fri, 26 Apr 2024 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wqf1Cp+L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2DA146A62;
	Fri, 26 Apr 2024 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133647; cv=none; b=k4Ym1dIewsUWy2KwJa9yzdnWLUS/3yJqm5kU4gzFj6bnDkcSI2qjFP39ijrmkOGPI5eb6zkhZWd0tZWSpkkTIUiwM59XQw/dvPN9ZPLDnfx9Z2HuiiwxIQsMjkZVi8qsML2FUwnrB0tL198D/zThi5SaQQj3rm4A/NB2KA50UVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133647; c=relaxed/simple;
	bh=wwOo7Qalbj5LGH+Uol2Kxq1QroiMAQbRn89m80qF1hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddF5bfwhIrtO0dzrJkj1imacQJ+ZXzLZvVbTIUv1C/F0SECnUoN1Onm/cK4nE0CbYeq+dppYcIpqMI7z7LGo5Ha4rcqnVj+nDdMLOWlu5Lp2027rgaMWmqp+P8jvTfYr7Jfm6tg9RpqIF+x8fNpld12MWS91X6Ct/ijwbw70XDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wqf1Cp+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFA4C113CD;
	Fri, 26 Apr 2024 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714133647;
	bh=wwOo7Qalbj5LGH+Uol2Kxq1QroiMAQbRn89m80qF1hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wqf1Cp+LfX9tULU0HyRGnDeMCjKen3b6QQDxRgGRuwAOuj5zbDCwVCKJhd6Auo08o
	 B8pZrXZMAP5IDBLwE4CD69u9MCDX+5lGz3aytu4cFT6NezNCUyof9nt0CGFJ4LdqqH
	 OSzFvR0EG1Jq5AwOg97W36gELTUZaDggc9TxZ+cniSes9RMNhAaYl/p/vr7t8VNKRL
	 Fqm0tEbdObc+W3DUtSF7mCNOR3m/AvCsEvQSaA+VUlsTzIOzkO7SVTB/Ou4VK2ROF9
	 OQA1ipw7x+LCI+/G2ni7UaGuPcCUc9PlDEZil5BL3pGoMFnQuhkZ4yZSQNnkHzt9Df
	 1qa2PZ05giUcA==
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
	bpf@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v3 2/2] bpf, arm64: inline bpf_get_smp_processor_id() helper
Date: Fri, 26 Apr 2024 12:13:49 +0000
Message-Id: <20240426121349.97651-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240426121349.97651-1-puranjay@kernel.org>
References: <20240426121349.97651-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As ARM64 JIT now implements BPF_MOV64_PERCPU_REG instruction, inline
bpf_get_smp_processor_id().

ARM64 uses the per-cpu variable cpu_number to store the cpu id.

Here is how the BPF and ARM64 JITed assembly changes after this commit:

                                         BPF
         		                =====
              BEFORE                                       AFTER
             --------                                     -------

int cpu = bpf_get_smp_processor_id();           int cpu = bpf_get_smp_processor_id();
(85) call bpf_get_smp_processor_id#229032       (18) r0 = 0xffff800082072008
                                                (bf) r0 = &(void __percpu *)(r0)
                                                (61) r0 = *(u32 *)(r0 +0)

				      ARM64 JIT
				     ===========

              BEFORE                                       AFTER
             --------                                     -------

int cpu = bpf_get_smp_processor_id();           int cpu = bpf_get_smp_processor_id();
mov     x10, #0xfffffffffffff4d0                mov     x7, #0xffff8000ffffffff
movk    x10, #0x802b, lsl #16                   movk    x7, #0x8207, lsl #16
movk    x10, #0x8000, lsl #32                   movk    x7, #0x2008
blr     x10                                     mrs     x10, tpidr_el1
add     x7, x0, #0x0                            add     x7, x7, x10
                                                ldr     w7, [x7]

Performance improvement using benchmark[1]

             BEFORE                                       AFTER
            --------                                     -------

glob-arr-inc   :   23.817 ± 0.019M/s      glob-arr-inc   :   24.631 ± 0.027M/s
arr-inc        :   23.253 ± 0.019M/s      arr-inc        :   23.742 ± 0.023M/s
hash-inc       :   12.258 ± 0.010M/s      hash-inc       :   12.625 ± 0.004M/s

[1] https://github.com/anakryiko/linux/commit/8dec900975ef

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4e474ef44e9c..6ff4e63b2ef2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20273,20 +20273,31 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
-#ifdef CONFIG_X86_64
 		/* Implement bpf_get_smp_processor_id() inline. */
 		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
 		    prog->jit_requested && bpf_jit_supports_percpu_insn()) {
 			/* BPF_FUNC_get_smp_processor_id inlining is an
-			 * optimization, so if pcpu_hot.cpu_number is ever
+			 * optimization, so if cpu_number_addr is ever
 			 * changed in some incompatible and hard to support
 			 * way, it's fine to back out this inlining logic
 			 */
-			insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
-			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
-			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
-			cnt = 3;
+			u64 cpu_number_addr;
 
+#if defined(CONFIG_X86_64)
+			cpu_number_addr = (u64)&pcpu_hot.cpu_number;
+#elif defined(CONFIG_ARM64)
+			cpu_number_addr = (u64)&cpu_number;
+#else
+			goto next_insn;
+#endif
+			struct bpf_insn ld_cpu_number_addr[2] = {
+				BPF_LD_IMM64(BPF_REG_0, cpu_number_addr)
+			};
+			insn_buf[0] = ld_cpu_number_addr[0];
+			insn_buf[1] = ld_cpu_number_addr[1];
+			insn_buf[2] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+			insn_buf[3] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
+			cnt = 4;
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
@@ -20296,7 +20307,6 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			insn      = new_prog->insnsi + i + delta;
 			goto next_insn;
 		}
-#endif
 		/* Implement bpf_get_func_arg inline. */
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_arg) {
-- 
2.40.1


