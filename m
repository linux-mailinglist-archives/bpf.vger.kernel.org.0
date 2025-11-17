Return-Path: <bpf+bounces-74732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE61C6450D
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 14:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18A044ECB89
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB40532ED27;
	Mon, 17 Nov 2025 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kz8vwuCD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA832F754
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763384871; cv=none; b=DQUQRyMw2X4Clf3HiVvw4K++bpLfC1Nu1RhdmhobCUC8bAySIGbfVSwMl/gAxfOU5COj0cX0J1d5K6FZ7LWk2naGD90LArqMlEkBjxDQzbsz+xqaAJRFSRj+hFo5bkBBJMv69Fkt8TRnR/O4YzOeMM4IFOW2PA8+IL7XnkzJ8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763384871; c=relaxed/simple;
	bh=prEM5Jo/ZC59I00yQUqge0qmvdp5OKyC4ohGvj2V6xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPXb3Gg/mTDMvkYvMksfx0mJOGrGVX+bfuoVGAB6Nm/7wZIQlYKEBOXyb2KcWkbnX8f6HAbV0pM0AMDXrmixFLW4+Sh3poIuwdNm1vz1kHesBX45p9VNIX3/FNRbX4zfTL2JP6I6mm3ZMAzD+O5g27fir5B6krnujM3olyqNg7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kz8vwuCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB61C116B1;
	Mon, 17 Nov 2025 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763384870;
	bh=prEM5Jo/ZC59I00yQUqge0qmvdp5OKyC4ohGvj2V6xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kz8vwuCDM39rFY7RGEV9DQhLSUXp+yw/JymXQCHUS1WVgLC+dIgyaW48vVc3INshY
	 w8k4Kiu6zdfMJmwdTd4iG5EvEkqZesoQXzAeFwVXTx2+HxCOluOOfRRIcjiU4yEcJP
	 qMGXyH8SOX6kyh/LrGBxZ2gzGLIeJAAORMPEVIPvBZSoQY186Zf0zRX/lwWKWyjWlh
	 VbnGC5fYVg2bjiTGlDjCQU2+1kQrNwWZn/njs6zsieJ66/5CL9CFJoPFtgfYg3ODaH
	 wQ1hV9/1BpFQBpmo0G/lZcr+EnyDWaqltV/4sThypzRBxVUPixuzFmcDSDDBUyjdpE
	 tN7bMkEbCq6eA==
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
Subject: [PATCH bpf-next v2 2/3] bpf: arm64: Add support for indirect jumps
Date: Mon, 17 Nov 2025 13:07:30 +0000
Message-ID: <20251117130732.11107-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117130732.11107-1-puranjay@kernel.org>
References: <20251117130732.11107-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for a new instruction

	BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=0

which does an indirect jump to a location stored in Rx.  The register
Rx should have type PTR_TO_INSN. This new type assures that the Rx
register contains a value (or a range of values) loaded from a
correct jump table – map of type instruction array.

ARM64 JIT supports indirect jumps to all registers through the A64_BR()
macro, use it to implement this new instruction.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 4a2afc0cefc4..4cfb549f2b43 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1452,6 +1452,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		emit(A64_ASR(is64, dst, dst, imm), ctx);
 		break;
 
+	/* JUMP reg */
+	case BPF_JMP | BPF_JA | BPF_X:
+		emit(A64_BR(dst), ctx);
+		break;
 	/* JUMP off */
 	case BPF_JMP | BPF_JA:
 	case BPF_JMP32 | BPF_JA:
-- 
2.47.1


