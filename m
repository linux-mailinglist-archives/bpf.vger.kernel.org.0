Return-Path: <bpf+bounces-64046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D45B0DAEC
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BD75621EE
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 13:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D281E4A9;
	Tue, 22 Jul 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3hHPjXu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2533221555
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191268; cv=none; b=LkMa38Sbzw4WPNEaDzH6xNwAEqCbdDHr3Y6CycdJQMrIt/YZEpYLjqkcUjmhZRiUFxhzT1droBvE8zN28BeeBZODRuNQVuLs2nBwET+dOCq+BVihW1fHBnl+Bwul8t9cuGQBEAkQtJZTHXLCH0dDF6C6cZ9easXWQVyPNTSn/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191268; c=relaxed/simple;
	bh=FVtYWPhnS81RWnGYc/7xfA8SLLR+4zw/mjH1VeiJ4X4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryEBC/CWVilnI2FmMiaaK9ujsasTZPWtLTVBXh/kgIBrHvmXLRiG2npme25ceidQ3eVq59HkgRM1xZygaik3Y0+cs/gyq/exwKv5VLHqanJRiS2wGBw0LRMODChGfg1p9FUFVRzHRpR/NYjf6qC1Y3QJkNOf6HewDYc9/uvX5Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3hHPjXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DDAC4CEEB;
	Tue, 22 Jul 2025 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753191267;
	bh=FVtYWPhnS81RWnGYc/7xfA8SLLR+4zw/mjH1VeiJ4X4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=b3hHPjXuj8iTp2lAyW4q7KldUiyvflDL7JVSmlQ4ohq7JMspxMEKIJ0Uf5S6WLz5h
	 X5E+wiKo9LBTY89ugGihAbygNwY/gQip/SFdfG3HTzzA3bkRR5pipK2pld0dJvf04q
	 WJ+aaiFsBub/0HN6PzMazh+KTeNolc9SzJYmLXQYjY+wAjfhzfUp6SAB60uiGcN2Qg
	 bKRdFDLmF304jv4DjSOC3kiFtbQe4goe5tKB9iEuXuCviU6ajw8wpAslz5G7q7BnMz
	 2wr+W3i/9xH6FzpLmWQ1yWUF67fVL9wQDuwSitZwccqGhKrvU2p/HWKSBuuTEnTiwd
	 ZByUe+kb3cP5w==
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/1] bpf, arm64: fix fp initialization for exception boundary
Date: Tue, 22 Jul 2025 13:34:09 +0000
Message-ID: <20250722133410.54161-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250722133410.54161-1-puranjay@kernel.org>
References: <20250722133410.54161-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the ARM64 BPF JIT when prog->aux->exception_boundary is set for a BPF
program, find_used_callee_regs() is not called because for a program
acting as exception boundary, all callee saved registers are saved.
find_used_callee_regs() sets `ctx->fp_used = true;` when it sees FP
being used in any of the instructions.

For programs acting as exception boundary, ctx->fp_used remains false
even if frame pointer is used by the program and therefore, FP is not
set-up for such programs in the prologue. This can cause the kernel to
crash due to a pagefault.

Fix it by setting ctx->fp_used = true for exception boundary programs as
fp is always saved in such programs.

Fixes: 5d4fa9ec5643 ("bpf, arm64: Avoid blindly saving/restoring all callee-saved registers")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 89b1b8c248c62..97ab651c0bd5d 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -412,6 +412,7 @@ static void push_callee_regs(struct jit_ctx *ctx)
 		emit(A64_PUSH(A64_R(23), A64_R(24), A64_SP), ctx);
 		emit(A64_PUSH(A64_R(25), A64_R(26), A64_SP), ctx);
 		emit(A64_PUSH(A64_R(27), A64_R(28), A64_SP), ctx);
+		ctx->fp_used = true;
 	} else {
 		find_used_callee_regs(ctx);
 		for (i = 0; i + 1 < ctx->nr_used_callee_reg; i += 2) {
-- 
2.47.1


