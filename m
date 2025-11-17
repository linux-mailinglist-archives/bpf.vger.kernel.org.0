Return-Path: <bpf+bounces-74682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06358C61F66
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 01:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8D6B220872
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 00:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AB81A5B8A;
	Mon, 17 Nov 2025 00:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPLtyLw2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9614C9D
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 00:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763340433; cv=none; b=jOx0reP1QrvdlNnnHa7NxYHTqyreGckasnRMdYQmJRQGU/v8/j3jaJEeI58CQJ8q5f1TVLKC3HWbDMKoJ78TPRXpSsGwTDxIpncme4UAut/E5C3RtLVBg+wTlheVLAPyNQ2jIO0bjk2gJ58V5Rl8j4pL899Iut+tDD38e2dUbHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763340433; c=relaxed/simple;
	bh=WY+JV5cuRePFToeQK6+E8hY7pYGZlIA9A9OWsS50QOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDmUpHlhkShO0aEvj4XW9CTKiYh2QGnZMv8uZweQ0sm0Q6avkgQ+008DN43qIJysl4zi/Tok3gwKbu228TSv52Y9kDiF+kHBZI3tip30BCx4tK7Tza+O+A5cjTQO8+PcEgXX7T0OrhbDeoz8qnpkmlamw4LNxLLUPb4LMf/1FEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPLtyLw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F7DC4CEF5;
	Mon, 17 Nov 2025 00:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763340432;
	bh=WY+JV5cuRePFToeQK6+E8hY7pYGZlIA9A9OWsS50QOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPLtyLw2EfS4DfYRFfaVsKPUNG0TYDqBCgiEk0NsCkdcw6wBOFUM9Ruyl9ZM8id2e
	 YVt1oXkyQ6MZCmOuFSqaJkq36Hictj3TFLK458edtzl0PVjyi1VRMO2aJvMzT2Fv1I
	 jefdkuo9YKcNZgJogil2NiDozYKdzlxAJv9luC3W2bbTij79SiERSWsSR0TDjz/uUJ
	 lZpm5J0uCd7eSCZKWKX1/DQCHBxsXNJxlVRFYnQ2/AZ54/sLdEdTHXASScToJR0CUM
	 g27Tt7q6NJgi0yFKBIAPiAS9wmCVPBw6CXi0erKXwNRkqoTVDMdTeoS66Es2StZJks
	 jH3LoMDA3LbKg==
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
Subject: [PATCH bpf-next 1/4] bpf: arm64: Add support for instructions array
Date: Mon, 17 Nov 2025 00:46:36 +0000
Message-ID: <20251117004656.33292-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117004656.33292-1-puranjay@kernel.org>
References: <20251117004656.33292-1-puranjay@kernel.org>
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
2.47.3


