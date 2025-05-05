Return-Path: <bpf+bounces-57398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C29AAA4E5
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 01:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17F846487F
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E86728A3E2;
	Mon,  5 May 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVxc0Y8f"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930B307954;
	Mon,  5 May 2025 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484090; cv=none; b=EIKkYFmoe2CD0TeVKHmWI+Ulm3HM/HrAgGNSRRSzcGDoFYc4M778LWzu9ZiSkdGFp/V96Ju65zY2aImB9eRON2OXPYBeDEI7lpjWfmv2rnSb0JPpEzAoCivOe6XQfScRBWBW06SWKY4xMoBPkLmV/b8YO+CM3uhdOWNYHZ9WDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484090; c=relaxed/simple;
	bh=pa0KwOgvcTdl4NeBIz0JuwFGhxRnO/vyrgpOmB9ZJ5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rD2quTzVXJsTS/l0XqJ/DPPnSfdajrrCW1RMso6dIivmIEem06V53c1e1UAjpvWTM5sPKwBzKJKLbLs4uxweVt8LW3exBvGs3lkntcl9KLEu9AglRkGMPS5r/aYZUtH3uNpjSMboTVg1CoeppPjSd57z2Gni9w0lxqJJOVxiipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVxc0Y8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7DFC4CEE4;
	Mon,  5 May 2025 22:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484089;
	bh=pa0KwOgvcTdl4NeBIz0JuwFGhxRnO/vyrgpOmB9ZJ5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YVxc0Y8foZWuHbYD2WQb2kxdUQsUBMk+70CX6YJ4n8ZXiQES+O47apdkqoNsboP45
	 tT5b7ot0HiDmlKXxUzz+A+qx8zt+W0ePfb6g+2nSx6o2EnttmuOHMMQRwUCOLUBpkd
	 XRm0n7JB5sXVghplkOLQPRz6Olg6Y9BEh1N97ecBENu84FpLfcb8zBb283wLXMpXEG
	 qgILhzVGjzr1eIwaN5mk8Y+VLrEJNNlrlJLrzqsCG8NX0jnu9N6B2Hj6MZzUwTNpyj
	 gkRF6CVBIfJP5cer3tRiBM/ZgRTcPO9n9PpmgQrQCiFkoiQvn+yfsmK0L8uTmFWVp4
	 RLSi4CKnwZJkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Song Liu <song@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	puranjay@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 345/642] bpf: arm64: Silence "UBSAN: negation-overflow" warning
Date: Mon,  5 May 2025 18:09:21 -0400
Message-Id: <20250505221419.2672473-345-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Song Liu <song@kernel.org>

[ Upstream commit 239860828f8660e2be487e2fbdae2640cce3fd67 ]

With UBSAN, test_bpf.ko triggers warnings like:

UBSAN: negation-overflow in arch/arm64/net/bpf_jit_comp.c:1333:28
negation of -2147483648 cannot be represented in type 's32' (aka 'int'):

Silence these warnings by casting imm to u32 first.

Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Song Liu <song@kernel.org>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/r/20250218080240.2431257-1-song@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 8446848edddb8..7409c8acbde35 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -272,7 +272,7 @@ static inline void emit_a64_add_i(const bool is64, const int dst, const int src,
 {
 	if (is_addsub_imm(imm)) {
 		emit(A64_ADD_I(is64, dst, src, imm), ctx);
-	} else if (is_addsub_imm(-imm)) {
+	} else if (is_addsub_imm(-(u32)imm)) {
 		emit(A64_SUB_I(is64, dst, src, -imm), ctx);
 	} else {
 		emit_a64_mov_i(is64, tmp, imm, ctx);
@@ -1159,7 +1159,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_ALU64 | BPF_SUB | BPF_K:
 		if (is_addsub_imm(imm)) {
 			emit(A64_SUB_I(is64, dst, dst, imm), ctx);
-		} else if (is_addsub_imm(-imm)) {
+		} else if (is_addsub_imm(-(u32)imm)) {
 			emit(A64_ADD_I(is64, dst, dst, -imm), ctx);
 		} else {
 			emit_a64_mov_i(is64, tmp, imm, ctx);
@@ -1330,7 +1330,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_JMP32 | BPF_JSLE | BPF_K:
 		if (is_addsub_imm(imm)) {
 			emit(A64_CMP_I(is64, dst, imm), ctx);
-		} else if (is_addsub_imm(-imm)) {
+		} else if (is_addsub_imm(-(u32)imm)) {
 			emit(A64_CMN_I(is64, dst, -imm), ctx);
 		} else {
 			emit_a64_mov_i(is64, tmp, imm, ctx);
-- 
2.39.5


