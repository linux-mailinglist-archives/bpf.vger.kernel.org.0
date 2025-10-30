Return-Path: <bpf+bounces-73004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475DEC1FF6D
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 13:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FDB3AB69E
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 12:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E246A29ACD8;
	Thu, 30 Oct 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAnudxwa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CBD263C69
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826640; cv=none; b=Wf1m5OTROFeapD0yvI9muoX9q6sCo0UW4+sHj7FZDOUR0MOHl5gHIUbfgFSX/o2K0k//dfRcCAzDIX7JGX7BsH1gu5XZkBRa82ZNcQKSPzkaFJBGFpF3bOHlEoF9k6VEjymEvDroQuqx8RGIxVY2ARD+IvViK6KuetnsaWvgl6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826640; c=relaxed/simple;
	bh=n3KPENZZWSHk6cA4RhMBjUhEZRostu43OlZa2kCLFJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gwP61jHgX7u7h2vzXbGnWpQFJMRXhh21cc1GWVlynNP5MZPo6aW7H7DcMaL5ScU19lwpamWmltiaQ7IhoYy/2qU1s0pcKkaFM/fjPp3yHm7urpqBUEw8oTns2tZD8jRz0OP5DieR37AKwllMo9W4zvm3FmswMsFZqrKotyGUR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAnudxwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2C3C4CEFF;
	Thu, 30 Oct 2025 12:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761826639;
	bh=n3KPENZZWSHk6cA4RhMBjUhEZRostu43OlZa2kCLFJE=;
	h=From:To:Cc:Subject:Date:From;
	b=gAnudxwaDREYPAUwEMG/NMjdW5nRzg168w7rSl5zkeA3z4cZg6KpA4L/hk7Kw1vJS
	 sdwfvdfAjevAAViLOh1cesu2nVGjgeWqtta6I95wUXhyLWAvuWpCtwbESq86uzp9AV
	 KOxZJ0Dd3yLvWJPDVeD+9yR5EJrD4bYFuMCQxSoI2Jh1H5awzlM492IaXpqZTZbhKS
	 zCO9gi6ku6pWdS1GAAv93NdF2S5d3T/oL4ULmYQMtzcJaAAlh+9nX+YTDNa79mS++U
	 d9pZ7nLzEysz9zXsTq6uZAJu2V0OUIkeqI0//q13v4AIwYS7xCahp+EqZCExXBb36J
	 QKK4z0rIVJFTA==
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
Subject: [PATCH bpf-next v2] bpf: arm64: fix BPF_ST into arena memory
Date: Thu, 30 Oct 2025 12:17:14 +0000
Message-ID: <20251030121715.55214-1-puranjay@kernel.org>
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
Changes in v1->v2:
v1: https://lore.kernel.org/bpf/20251030120146.50417-1-puranjay@kernel.org/

- Fix the build issue by declaring tmp3 in the right function.

---
 arch/arm64/net/bpf_jit_comp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index ab83089c3d8f..0c9a50a1e73e 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1213,6 +1213,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	u8 src = bpf2a64[insn->src_reg];
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 tmp2 = bpf2a64[TMP_REG_2];
+	const u8 tmp3 = bpf2a64[TMP_REG_3];
 	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
 	const u8 priv_sp = bpf2a64[PRIVATE_SP];
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


