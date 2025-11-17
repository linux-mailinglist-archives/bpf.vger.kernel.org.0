Return-Path: <bpf+bounces-74731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9502FC6452B
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 14:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7BE4384C9A
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1C932F755;
	Mon, 17 Nov 2025 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HppbCDwW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039B32F75B
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384867; cv=none; b=SnHbH1MyIa928QTGkcWQDPaZsVEa/VJVEBUkWWmLpZHycirYFNILuLji0RwbLsG/Mt621O3aFEJZHI7o4aI5QsolTAWQZZpI9hi3HVVbgm4LZaFu7kSzjMNEBvw4bk9rf1m+X8lMXbViTA/gHlJDD62Z2fVot0AOdclWGfFKuJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384867; c=relaxed/simple;
	bh=Q1M+cjS5n4zjN2Amm3C61bnSXG4bcirEdvMF2n2zQYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKmEecTv+95A0RLTXJLgWXZS57gY5JEgdTytfjRpkenuUreeCVwaNzrtNL9BHXaGE2BtL3LlPUANg7P/m+yIhK5ip2cOjIaP/KzAVKwnCJxnLdNFFEPqN5cDwZ6wp7y616nk5sq+nFu95NmyN2ylrCgL1jKjxOYHNdrP+VozMF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HppbCDwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A26C19422;
	Mon, 17 Nov 2025 13:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763384866;
	bh=Q1M+cjS5n4zjN2Amm3C61bnSXG4bcirEdvMF2n2zQYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HppbCDwWcoGI6NeaeA9fmt989YY3FEX9jTAmvgXmoUlfpPvB/OA0+c/OQiWO0+ZwS
	 Dwqcomtz0JcjzqhJlKKU1wjvGEjPGNBJvHf79nHjGWqNhZZwrUL4f/mFePpfpqpZV3
	 c2hPaQOM1gXIm9cSQ53n88vIwE3y7f4wzmd0zlRM7wigW4cJ44/oqh6WPT1yQuF28C
	 +33Shl3PhBpOrUgRGOM9vapG/Z+gjmrVJ0KicnX9xQBTMFwfr2Xr6vMzFg+WE3L6ec
	 lrIAZ/MqBGmROQkggine5POUP16kpkwQp8ImdujGxTSp5bnlraWuX1IgJ9my3yhq+H
	 TaA9hKlTu9wlw==
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
	kernel-team@meta.com,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v2 1/3] bpf: arm64: Add support for instructions array
Date: Mon, 17 Nov 2025 13:07:29 +0000
Message-ID: <20251117130732.11107-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117130732.11107-1-puranjay@kernel.org>
References: <20251117130732.11107-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the instructions array map type in the arm64 JIT by
calling bpf_prog_update_insn_ptrs() with the offsets that map
xlated_offset to the jited_offset in the final image. arm64 JIT already
has this offset array which was being used for
bpf_prog_fill_jited_linfo() and can be used directly for
bpf_prog_update_insn_ptrs.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 0c9a50a1e73e..4a2afc0cefc4 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2231,6 +2231,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		for (i = 0; i <= prog->len; i++)
 			ctx.offset[i] *= AARCH64_INSN_SIZE;
 		bpf_prog_fill_jited_linfo(prog, ctx.offset + 1);
+		/*
+		 * The bpf_prog_update_insn_ptrs function expects offsets to
+		 * point to the first byte of the jitted instruction (unlike
+		 * the bpf_prog_fill_jited_linfo above, which, for historical
+		 * reasons, expects to point to the next instruction)
+		 */
+		bpf_prog_update_insn_ptrs(prog, ctx.offset, ctx.ro_image);
 out_off:
 		if (!ro_header && priv_stack_ptr) {
 			free_percpu(priv_stack_ptr);
-- 
2.47.1


