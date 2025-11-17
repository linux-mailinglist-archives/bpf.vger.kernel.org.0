Return-Path: <bpf+bounces-74683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E230DC61F75
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 01:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97DBF352FEB
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 00:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629731C54A9;
	Mon, 17 Nov 2025 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THqWYE+c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14C7261A
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 00:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763340436; cv=none; b=Vm1m3ZPemqeBTHrOvclJpEp8bDY3p58sFTD/3bAcveei6FmX9H2eEWmCWeYLM02tuKNsbtBmS3UlUkSZ2vc3IRFnJk+pLZGD5/eHh3BimImL0JUu4MpUXQL8OFKKL3GWO15ngB5zSIzsh9nQ89PGxQmoomFza48v2rBc6ED/pGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763340436; c=relaxed/simple;
	bh=ryhcmIpqI4T2MVr1XTaj+b7GXxgULrcErPHTWGQ2rLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akApeDHOfHalrH3a987VPf2Dck4odiyGOuDjMq9AgHXrA/CVZxcbn3N537x3sXQt0gWk8UjBd+vPZmeXEheG8Q+EKdKdG9YY0x9ICF2SHf+VgzRvO7F6Ex2ki+CCHHzjPUok4gbiYCirRPMJ3ykryyhtyNOlSEg+kbLq4SAIOBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THqWYE+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209D7C113D0;
	Mon, 17 Nov 2025 00:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763340436;
	bh=ryhcmIpqI4T2MVr1XTaj+b7GXxgULrcErPHTWGQ2rLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=THqWYE+cWOyKEVxlPXR/sv02kGc5o0+qnRLkAS+0rsQMPgDymrJU6wDg81W/pktp3
	 f00F8lYO14SpgAsKHCCiDeOsn0ZiPnxsE59TRsEFguA/gQ6+BtJ9VpZJNKghm1LlzA
	 adqjq8PtnyauX8YkNyYAZZCUIHNFRto9nJUg80rcUA8cV2I3mfVdZ+RIT9fik0fabH
	 600a+9qZV8zKKnS41zq07rvqCsgt6SYJXhT2PsvC/bFTYcHms/9G04W3Tkhxdae/vc
	 GSOxmuBB6zAgFMa+5IUTHdpkjffYZtNDvyNnRn/HEpesb7CVyXlMbwRJrgrlsrrOAq
	 oy3XGu5IUH8ig==
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
Subject: [PATCH bpf-next 2/4] bpf: arm64: Add support for indirect jumps
Date: Mon, 17 Nov 2025 00:46:37 +0000
Message-ID: <20251117004656.33292-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117004656.33292-1-puranjay@kernel.org>
References: <20251117004656.33292-1-puranjay@kernel.org>
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
2.47.3


