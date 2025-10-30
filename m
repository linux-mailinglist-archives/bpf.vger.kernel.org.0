Return-Path: <bpf+bounces-73000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A43AC1FEAE
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 13:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2151887C08
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 12:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5E32FDC29;
	Thu, 30 Oct 2025 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHhB0RfJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420292DCF46
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825723; cv=none; b=sRxHws8JQJOT6Vku62XdQMJTi3Frl1akJdfB5P4jYUJ5jrzS6kxiY+paef/J3TER1iuSqSdo6f2a7fPzfqxN5t4KSMjaY8w7gzWq0XXugLYmZR+oBwkbTrGaUD5kWhbWpwE2y2HVXdni+222nOfZbz2WA0F501REMDrsG5V+uRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825723; c=relaxed/simple;
	bh=tqbFpTb6t2q6ia4agdkN3MeKEtbum6WozehSxxq3d3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HkKfcYDWuJeUEzMwcj+d3VM1aVCzYhRMQiUeyI5FPnf1ZIcr+/xEpfBhgx5Q27V6aRksXCSvwrAaVF9tYFABsg15wfdx6M5wMLisDAZkx1P9fMBC7xEy1PokMH/vnvyXUEvmdsaGvXn4gPdtSZvTCJhEmyAPCdfsJevIenFo9j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHhB0RfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB7EC4CEF1;
	Thu, 30 Oct 2025 12:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761825722;
	bh=tqbFpTb6t2q6ia4agdkN3MeKEtbum6WozehSxxq3d3E=;
	h=From:To:Cc:Subject:Date:From;
	b=sHhB0RfJAsEGi71NSy1RMKXEy/48Zifbi4dZIwXRacHaGJvGnLnwHJh7mkN2H/etR
	 yS/SK6Bf6ZjQj9NWvx/l++JEjzkSDDrOlAUiczng15OnWE+SmKm9VTUR9q8q/DJz7S
	 mvb+rHCrG5NfO+NN2pLvT2DdLNaZCpo9wIadsUcxQ1IfVsgVnyxytD9m4rSrO/ldSE
	 SYfsy6NB0RMMVs28V/RqPVYHHrKYlgiZo5IaubMte+OMCmyscmlJm94KYczNcSN4E5
	 CtcqkY2n+jfb7/fjQy8FjLpdCMPeqISRsx2msBvriLZq7awcH1vKwKgDgG13QU3WrA
	 EjnQ4nNjfeDpg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: arm64: fix BPF_ST into arena memory
Date: Thu, 30 Oct 2025 12:01:45 +0000
Message-ID: <20251030120146.50417-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arm64 JIT supports BPF_ST with BPF_PROBE_MEM32 (arena) by using the
tmp2 register to hold the dst + arena_vm_base value and using tmp2 as the
new dst register. But this is broken because in case is_lsi_offset()
returns false the tmp2 will be clobbered by emit_a64_mov_i(1, tmp2, off,
ctx); and hence the emitted store instruction will be of the form:

	strb    w10, [x11, x11]

Fix this by using the third temporary register to hold the dst +
arena_vm_base.

Fixes: 339af577ec05 ("bpf: Add arm64 JIT support for PROBE_MEM32 pseudo instructions.")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index ab83089c3d8f..348540b8e02d 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -785,6 +785,7 @@ static int emit_lse_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const u8 src = bpf2a64[insn->src_reg];
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 tmp2 = bpf2a64[TMP_REG_2];
+	const u8 tmp3 = bpf2a64[TMP_REG_3];
 	const bool isdw = BPF_SIZE(code) == BPF_DW;
 	const bool arena = BPF_MODE(code) == BPF_PROBE_ATOMIC;
 	const s16 off = insn->off;
@@ -1757,8 +1758,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
 		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
-			emit(A64_ADD(1, tmp2, dst, arena_vm_base), ctx);
-			dst = tmp2;
+			emit(A64_ADD(1, tmp3, dst, arena_vm_base), ctx);
+			dst = tmp3;
 		}
 		if (dst == fp) {
 			dst_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
-- 
2.47.3


