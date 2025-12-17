Return-Path: <bpf+bounces-76881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 287E4CC8E55
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 17:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54A7F3009634
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EDD3596F9;
	Wed, 17 Dec 2025 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egI0M1AI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8733596E3
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988936; cv=none; b=WeEbcopHmr2qoxOSeyyQdK2qrrPP131rmRNS21hZwn1amVvdO/Cri/N5BsA8KGd9MP+a//0nR87PqyvAogTVEjJt4CzA3Cd4mJolHZLaxscwqFKgjXmQXbn/hF9Zr0vF0qJkE2pIskx8PRiC11hjwrlUjY4UMQdWS23eTiCQfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988936; c=relaxed/simple;
	bh=HCLdkqos8jgOsZvqwhImnNfbte35GMxDvkafA1XfElo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAyXxU93HWIzmpXkpG5nVq+ZnA6e3PJv24/RxXA1vU8JBwhMWueY1jHA//44H4iQpxQQ+fXqWOTTgELzdhvi36Pg9glpzd91QVU4NLCbv74gXzKVP9PGgutIrDHvxDZ4SlD/T/CzMrElZqB2QsG+SjmyC0FSgJ9wQP5wO+9Vt/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egI0M1AI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD83C116B1;
	Wed, 17 Dec 2025 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765988936;
	bh=HCLdkqos8jgOsZvqwhImnNfbte35GMxDvkafA1XfElo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egI0M1AIrEBbMJetAc1UBEPFIajqxBKZbRxLmvkXxERiolgGty6gTq0EHqm9qHed9
	 uhr8NhZT4NCcwEN74RORq5QFMWd/eDiUI7Ple44y/RQaNiKm4oV7t2qpryk2HJlerW
	 8DLfHm5sNmJ0fnAk5TGmFVLRcbYbl8iAp+0MNd/NkTT9sgaQ0sgEAR8BIOqKYE3rjF
	 UeqTOjweNA4HJwLBkYinxyL2nPa+I+waoiHTyf7XBWTwyTfJ3efObKdXtryhAXU+kc
	 Or21X+YDQewACJMSBh6Nma8H+Bn/KHzj6pwl6QGZUnXxcefmUhgmNDeLH9qe8yaq9M
	 yoJ1l9vM2DmaQ==
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
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 2/2] bpf: arm64: Optimize recursion detection by not using atomics
Date: Wed, 17 Dec 2025 08:28:27 -0800
Message-ID: <20251217162830.2597286-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251217162830.2597286-1-puranjay@kernel.org>
References: <20251217162830.2597286-1-puranjay@kernel.org>
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

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf.h | 25 ++++++++++++++++++++++++-
 kernel/bpf/core.c   |  3 ++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2da986136d26..654fb94bf60c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -31,6 +31,7 @@
 #include <linux/static_call.h>
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
+#include <linux/unaligned.h>
 #include <asm/rqspinlock.h>
 
 struct bpf_verifier_env;
@@ -1746,6 +1747,8 @@ struct bpf_prog_aux {
 	struct bpf_map __rcu *st_ops_assoc;
 };
 
+#define BPF_NR_CONTEXTS        4       /* normal, softirq, hardirq, NMI */
+
 struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
 	u16			jited:1,	/* Is our filter JIT'ed? */
@@ -1772,7 +1775,7 @@ struct bpf_prog {
 		u8 tag[BPF_TAG_SIZE];
 	};
 	struct bpf_prog_stats __percpu *stats;
-	int __percpu		*active;
+	u8 __percpu		*active;	/* u8[BPF_NR_CONTEXTS] for rerecursion protection */
 	unsigned int		(*bpf_func)(const void *ctx,
 					    const struct bpf_insn *insn);
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
@@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
 
 static inline bool bpf_prog_get_recursion_context(struct bpf_prog *prog)
 {
+#ifdef CONFIG_ARM64
+	u8 rctx = interrupt_context_level();
+	u8 *active = this_cpu_ptr(prog->active);
+
+	active[rctx]++;
+	barrier();
+	if (get_unaligned_le32(active) != BIT(rctx * 8))
+		return false;
+
+	return true;
+#else
 	return this_cpu_inc_return(*(prog->active)) == 1;
+#endif
 }
 
 static inline void bpf_prog_put_recursion_context(struct bpf_prog *prog)
 {
+#ifdef CONFIG_ARM64
+	u8 rctx = interrupt_context_level();
+	u8 *active = this_cpu_ptr(prog->active);
+
+	barrier();
+	active[rctx]--;
+#else
 	this_cpu_dec(*(prog->active));
+#endif
 }
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c66316e32563..b5063acfcf92 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -112,7 +112,8 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
 		vfree(fp);
 		return NULL;
 	}
-	fp->active = alloc_percpu_gfp(int, bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
+	fp->active = __alloc_percpu_gfp(sizeof(u8[BPF_NR_CONTEXTS]), 8,
+					bpf_memcg_flags(GFP_KERNEL | gfp_extra_flags));
 	if (!fp->active) {
 		vfree(fp);
 		kfree(aux);
-- 
2.47.3


