Return-Path: <bpf+bounces-51812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66B9A39478
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 09:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531783ABA1D
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 08:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B8222ACE7;
	Tue, 18 Feb 2025 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekXCbqmh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727E22ACF2
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865811; cv=none; b=fA8qzCZY1n0LyNUDNAMoT56J7K0fHXLg1qDZwa8SwR6ZlrpZGXwxzcOB5PyvbTzlicvX0g4kMt2ikVAA4adD9ZZcfxMCcdrsi2y+8d4bjFC/MCUpiUOEVoJ21/BLlPnIC3dL/XhVsUWub1Tj2IewA+W4Kce4Upixoht7PZNwQog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865811; c=relaxed/simple;
	bh=WMuYdfirGkka6sEk1aFk6epeQLlBFo0fQ95FgWIuqcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OEc6wDefIjAr5ZV9xs/COvOA8JYYrgQCBknJBgkrfSxAKQ4ESjQ6W6Jysgl3CN9Cl/mKfRCbOS2mTwxijSlwrslAUiRpXeDivHgdIEhxQjYAsUpMHCcZ7FY9ccKW6k9DwxKtZzlv5iB1xXt9UdQVeoyled80xDm0lBS2WjtFLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekXCbqmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194A2C4CEE2;
	Tue, 18 Feb 2025 08:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739865810;
	bh=WMuYdfirGkka6sEk1aFk6epeQLlBFo0fQ95FgWIuqcE=;
	h=From:To:Cc:Subject:Date:From;
	b=ekXCbqmhU6dQFX+CX91/tDnqZxRFTKu83Gy0z4HfeDKwJzBUXot7btiW+4yUcGj2t
	 KWZxMDHK2rCBGQQVcR96OdKFwEBFY7NO4iaQvB5ErkSWT+0wdaY/CDt/G+SCBSdJ16
	 0wVdILp2xDgVJ3Kzyq+8iWll954LslaMx1CjIi+m1wc6eYkWYaTrStRDt2R4pEihOU
	 5LEMve55qtAUzV1mpn5d2PVFIvfT7AepM80iHlAE7PjJsf9h0gJdYQRFiJ0CEjGWyx
	 OXDewwEbrKF1YJPTMZ7USnXDrcSXemwZiQK/EGPTnz0Eb81dk3naS73tZ+2xGJyvVz
	 sacpu9UFb6rQg==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	kernel-team@meta.com,
	song@kernel.org,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH bpf-next] bpf: arm64: Silent "UBSAN: negation-overflow" warning
Date: Tue, 18 Feb 2025 00:02:40 -0800
Message-ID: <20250218080240.2431257-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With UBSAN, test_bpf.ko triggers warnings like:

UBSAN: negation-overflow in arch/arm64/net/bpf_jit_comp.c:1333:28
negation of -2147483648 cannot be represented in type 's32' (aka 'int'):

Silent these warnings by casting imm to u32 first.

Fixes: fd868f148189 ("bpf, arm64: Optimize ADD,SUB,JMP BPF_K using arm64 add/sub immediates")
Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 8446848edddb..7409c8acbde3 100644
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
2.43.5


