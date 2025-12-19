Return-Path: <bpf+bounces-77198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3880ECD1758
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A00223015109
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD96E34B676;
	Fri, 19 Dec 2025 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDW6/vgK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFCA34B40C
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766169926; cv=none; b=j0bnKONGb1ZjFBHL3Bq9Xu4sS41I1liSWnITdslo7ArHhepVnzqtOH80u+e+md2kbgbDs1pM3jkrWBTcimWQmEwR7phbYvtKYRBj/xFWRHHJEOIPxkTSclv2gNRm6KdwrJ6m0G5Xi/t+R25IJ7IxtR7Limrpp4TKKA8rMQe+p2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766169926; c=relaxed/simple;
	bh=MX7u6YCAf8ISSlBSjmO63NiEj72J0NgYtomqNWx848Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCxQdSEo7XDJ/cd81qwkpFc22C8hm9qY2LWo0wLTr8AsenS/hFa3QoftbkwiGJnsDA0X+smpgc+fOTk0p84yW6/R4kjCRkuIZGqmDe4+qvZ08BfRCcZrLUaS4nViQ4pdHmFvBxKffPdsOxvHiE8Wi8/9tFZZ1CJzgQVjp57IOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDW6/vgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73704C4CEF1;
	Fri, 19 Dec 2025 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766169925;
	bh=MX7u6YCAf8ISSlBSjmO63NiEj72J0NgYtomqNWx848Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDW6/vgKTnJzLQNhfd/FgWJBM6F7bnYDZ7fWbB/Lq4456mxPv4v/tZKKPyhYmzhD0
	 mG32Jh7mT8vqC8XrthShEjEwQloJo1NKBd5qfUCZMGT2iFQt66cPH5eJtGWAdrSAIm
	 yPMkS6Ogp6J7o06tRP/BrTj3MvWSRUMQSawtD5byKMOlyrLl0aAyCYG2iP6rzYoKDY
	 MRMObERDYUbya6zAsXWX8HwNxRObnQtkCu3bDs8CtpsygQBSu96v6XdP7/KDFAj7/k
	 lmsSfq/PWDa+wkxOGRUbPD0YKqZ8+VYFZpK9Kl7bzuqkEO/krJQwGO80ZDRkzA8YrL
	 YcF7p3Wwb7gEg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v3 2/2] bpf: arm64: Optimize recursion detection by not using atomics
Date: Fri, 19 Dec 2025 10:44:18 -0800
Message-ID: <20251219184422.2899902-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219184422.2899902-1-puranjay@kernel.org>
References: <20251219184422.2899902-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF programs detect recursion using a per-CPU 'active' flag in struct
bpf_prog. The trampoline currently sets/clears this flag with atomic
operations.

On some arm64 platforms (e.g., Neoverse V2 with LSE), per-CPU atomic
operations are relatively slow. Unlike x86_64 - where per-CPU updates
can avoid cross-core atomicity, arm64 LSE atomics are always atomic
across all cores, which is unnecessary overhead for strictly per-CPU
state.

This patch removes atomics from the recursion detection path on arm64 by
changing 'active' to a per-CPU array of four u8 counters, one per
context: {NMI, hard-irq, soft-irq, normal}. The running context uses a
non-atomic increment/decrement on its element.  After increment,
recursion is detected by reading the array as a u32 and verifying that
only the expected element changed; any change in another element
indicates inter-context recursion, and a value > 1 in the same element
indicates same-context recursion.

For example, starting from {0,0,0,0}, a normal-context trigger changes
the array to {0,0,0,1}.  If an NMI arrives on the same CPU and triggers
the program, the array becomes {1,0,0,1}. When the NMI context checks
the u32 against the expected mask for normal (0x00000001), it observes
0x01000001 and correctly reports recursion. Same-context recursion is
detected analogously.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf.h | 32 +++++++++++++++++++++++++++++---
 kernel/bpf/core.c   |  3 ++-
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2da986136d26..da6a00dd313f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1746,6 +1746,8 @@ struct bpf_prog_aux {
 	struct bpf_map __rcu *st_ops_assoc;
 };
 
+#define BPF_NR_CONTEXTS        4       /* normal, softirq, hardirq, NMI */
+
 struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
 	u16			jited:1,	/* Is our filter JIT'ed? */
@@ -1772,7 +1774,7 @@ struct bpf_prog {
 		u8 tag[BPF_TAG_SIZE];
 	};
 	struct bpf_prog_stats __percpu *stats;
-	int __percpu		*active;
+	u8 __percpu		*active;	/* u8[BPF_NR_CONTEXTS] for recursion protection */
 	unsigned int		(*bpf_func)(const void *ctx,
 					    const struct bpf_insn *insn);
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
@@ -2006,12 +2008,36 @@ struct bpf_struct_ops_common_value {
 
 static inline bool bpf_prog_get_recursion_context(struct bpf_prog *prog)
 {
-	return this_cpu_inc_return(*(prog->active)) == 1;
+#ifdef CONFIG_ARM64
+	u8 rctx = interrupt_context_level();
+	u8 *active = this_cpu_ptr(prog->active);
+	u32 val;
+
+	preempt_disable();
+	active[rctx]++;
+	val = le32_to_cpu(*(__le32 *)active);
+	preempt_enable();
+	if (val != BIT(rctx * 8))
+		return false;
+
+	return true;
+#else
+	return this_cpu_inc_return(*(int __percpu *)(prog->active)) == 1;
+#endif
 }
 
 static inline void bpf_prog_put_recursion_context(struct bpf_prog *prog)
 {
-	this_cpu_dec(*(prog->active));
+#ifdef CONFIG_ARM64
+	u8 rctx = interrupt_context_level();
+	u8 *active = this_cpu_ptr(prog->active);
+
+	preempt_disable();
+	active[rctx]--;
+	preempt_enable();
+#else
+	this_cpu_dec(*(int __percpu *)(prog->active));
+#endif
 }
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c66316e32563..e0b8a8a5aaa9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -112,7 +112,8 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 		vfree(fp);
 		return NULL;
 	}
-	fp->active = alloc_percpu_gfp(int, bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
+	fp->active = __alloc_percpu_gfp(sizeof(u8[BPF_NR_CONTEXTS]), 4,
+					bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
 	if (!fp->active) {
 		vfree(fp);
 		kfree(aux);
-- 
2.47.3


