Return-Path: <bpf+bounces-27715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73098B1130
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 19:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8AB31C2554F
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF37616D338;
	Wed, 24 Apr 2024 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zou6bT3k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE416DECF;
	Wed, 24 Apr 2024 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980167; cv=none; b=J8HQbxGzxhRckaS90rOgC28IklvmX4Lrrsakb1914H+UjubVCR0Q/Kh8E4IB4jmC5iavk8KNsfA46oujenK2E18IWSAuNJuZ6gcuPoOmDT3wkTasZ5QrUX71wR+lrtL7GUs2dwYYGk6kpM6/MtiRrvnhhADYxtUXF/J2yW+wzWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980167; c=relaxed/simple;
	bh=FCXCpVbEo7vIvFYp4OCyiBsqhCLvLa3LgXOg2ugWL4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrqxlIjh1tuoOyB/aI07Qq97fkIsjai1hyrnVJagn+DxrwQF8LWFKu2OECSGK34gnAkyqgLdIyJY/vgJVIcuSlGXkYfhqIoscVRUsDBcbYIv8PQswggzPLyeWfTPLoGEMCssYRqLErPKbivuPKhvQ/fBYF6C9owA7TbvS7SY/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zou6bT3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F998C113CD;
	Wed, 24 Apr 2024 17:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713980166;
	bh=FCXCpVbEo7vIvFYp4OCyiBsqhCLvLa3LgXOg2ugWL4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zou6bT3kJB4Z59o91dJd1D91lUG/QZ7+1rEqTxMBWwUzlqSpekL1YLh+GGhwJWptJ
	 WqXw9+Q0iL5y5p9drFYaButeIugf26dOKbjf7FDJmVaZ6Loo/o+W1lbRNT3GiJPdmX
	 0mssMvBx0qOXr5wWZfkkZRgFmHVNGTLZ1cqLin/X27mMQiF+cjWlUkdBbbZQ2Laai4
	 dPUDbcpMD/vQMLlJSBoJYgbfV0vK56M/0I1644jfjjOfIAoREe7FAxQkKS9SMEY3se
	 rSw7fpOjZ3EwXp+41u+oTxiMGWEkJiUNKl29RraqUMwj9SIFANJoyRHKk2oHDgLfpR
	 JILYj8rGSVqig==
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
Subject: [PATCH bpf-next v2 2/2] bpf, arm64: inline bpf_get_smp_processor_id() helper
Date: Wed, 24 Apr 2024 17:35:50 +0000
Message-Id: <20240424173550.16359-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240424173550.16359-1-puranjay@kernel.org>
References: <20240424173550.16359-1-puranjay@kernel.org>
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
                                                (bf) r0 = r0
                                                (61) r0 = *(u32 *)(r0 +0)

				      ARM64 JIT
				     ===========

              BEFORE                                       AFTER
             --------                                     -------

int cpu = bpf_get_smp_processor_id();      int cpu = bpf_get_smp_processor_id();
mov     x10, #0xfffffffffffff4d0           mov     x7, #0xffff8000ffffffff
movk    x10, #0x802b, lsl #16              movk    x7, #0x8207, lsl #16
movk    x10, #0x8000, lsl #32              movk    x7, #0x2008
blr     x10                                mrs     x10, tpidr_el1
add     x7, x0, #0x0                       add     x7, x7, x10
                                           ldr     w7, [x7]

Performance improvement using benchmark[1]

             BEFORE                                       AFTER
            --------                                     -------

glob-arr-inc   :   23.817 ± 0.019M/s      glob-arr-inc   :   24.631 ± 0.027M/s
arr-inc        :   23.253 ± 0.019M/s      arr-inc        :   23.742 ± 0.023M/s
hash-inc       :   12.258 ± 0.010M/s      hash-inc       :   12.625 ± 0.004M/s

[1] https://github.com/anakryiko/linux/commit/8dec900975ef

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9715c88cc025..3373be261889 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20205,7 +20205,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
 		/* Implement bpf_get_smp_processor_id() inline. */
 		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
 		    prog->jit_requested && bpf_jit_supports_percpu_insn()) {
@@ -20214,11 +20214,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			 * changed in some incompatible and hard to support
 			 * way, it's fine to back out this inlining logic
 			 */
+#if defined(CONFIG_X86_64)
 			insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
 			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
 			cnt = 3;
+#elif defined(CONFIG_ARM64)
+			struct bpf_insn cpu_number_addr[2] = { BPF_LD_IMM64(BPF_REG_0, (u64)&cpu_number) };
 
+			insn_buf[0] = cpu_number_addr[0];
+			insn_buf[1] = cpu_number_addr[1];
+			insn_buf[2] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+			insn_buf[3] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
+			cnt = 4;
+#endif
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
-- 
2.40.1


