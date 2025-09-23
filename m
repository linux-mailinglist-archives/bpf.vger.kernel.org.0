Return-Path: <bpf+bounces-69381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAE7B958D9
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 13:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1EC2E625D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E975D3218AF;
	Tue, 23 Sep 2025 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVp79N4E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6734B321262
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625356; cv=none; b=VPK5MnivgQ4ZNOGK2LqCTYC7x0firH198z+7IEpD4iyMSRLGnTxLo/YfhiEL2uR9SfZe4PHFbfTi1gY2kiViA9Jqa2tiCBDmqKJQjez2k68dOMFMSl6EGk5yU6F11qj+i18rnZrsvHn5G/DbMBDVjwUgeueoKVvFin8TYzrTDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625356; c=relaxed/simple;
	bh=PPUO6cK4PufHK7HoOJNEbCfMc/yR+i+ci3S6k+qMHW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+GzaxdZdG3vH9OwW/kP8APni4l2U77smGb7czP2qdvfpAlP9n4Jdi+/UVxtmJ7q6j+5Zb4HxWEVjdIAH5qAis7Ni27Fd+udC2gumylRicruzIY7u8iMszV3d+Ke6mMSpjvgwKuyKTZWvlIp1STX+XczjsQni8Q7g6ibnNTG8rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVp79N4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4867C4CEF5;
	Tue, 23 Sep 2025 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758625355;
	bh=PPUO6cK4PufHK7HoOJNEbCfMc/yR+i+ci3S6k+qMHW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVp79N4EPMfMRg2WPjZGbOwHf1InBB5HKzY257D5BNGSjp9AD5xopJu4AbIVvs/IU
	 mWcOMFJnHwEsW0310fhln+bU8tYDfvxpB9vqeXRzlrPeuAW1Bo5nqVmlj1ukdV7N1c
	 9M/0AqH1Ms3S6ErF/7HWZFMAkG99nPT+yj8KlhI/B+TT/i+Xb8lAAhToPwUDB3lwsf
	 kFowLxBjWw5emH6+nU7cS4JJrmiRCqWB/kBv3Vw9zKuVQYy8RvpOHkaET7xN0f1AKk
	 TG0VyXa6yPllKW7tA3YMMljnt2BNiglUvU1OjOv0HNe7GSPGLw6mhcx3AQTrkKt07g
	 WoWn8Qjg7lUqg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 2/3] bpf, arm64: Add support for signed arena loads
Date: Tue, 23 Sep 2025 11:01:50 +0000
Message-ID: <20250923110157.18326-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923110157.18326-1-puranjay@kernel.org>
References: <20250923110157.18326-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for signed loads from arena which are internally converted
to loads with mode set BPF_PROBE_MEM32SX by the verifier. The
implementation is similar to BPF_PROBE_MEMSX and BPF_MEMSX but for
BPF_PROBE_MEM32SX, arena_vm_base is added to the src register to form
the address.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 796938b535cd..288d9cc73919 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1133,12 +1133,14 @@ static int add_exception_handler(const struct bpf_insn *insn,
 		return 0;
 
 	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
-		BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
-			BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
-				BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
+	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
+	    BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
+	    BPF_MODE(insn->code) != BPF_PROBE_MEM32SX &&
+	    BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
 		return 0;
 
 	is_arena = (BPF_MODE(insn->code) == BPF_PROBE_MEM32) ||
+		   (BPF_MODE(insn->code) == BPF_PROBE_MEM32SX) ||
 		   (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC);
 
 	if (!ctx->prog->aux->extable ||
@@ -1659,7 +1661,11 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
-		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
+	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
+	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
+		    BPF_MODE(insn->code) == BPF_PROBE_MEM32SX) {
 			emit(A64_ADD(1, tmp2, src, arena_vm_base), ctx);
 			src = tmp2;
 		}
@@ -1671,7 +1677,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			off_adj = off;
 		}
 		sign_extend = (BPF_MODE(insn->code) == BPF_MEMSX ||
-				BPF_MODE(insn->code) == BPF_PROBE_MEMSX);
+				BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
+				 BPF_MODE(insn->code) == BPF_PROBE_MEM32SX);
 		switch (BPF_SIZE(code)) {
 		case BPF_W:
 			if (is_lsi_offset(off_adj, 2)) {
@@ -1879,9 +1886,11 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		if (ret)
 			return ret;
 
-		ret = add_exception_handler(insn, ctx, dst);
-		if (ret)
-			return ret;
+		if (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
+			ret = add_exception_handler(insn, ctx, dst);
+			if (ret)
+				return ret;
+		}
 		break;
 
 	default:
@@ -3064,11 +3073,6 @@ bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
 		if (!bpf_atomic_is_load_store(insn) &&
 		    !cpus_have_cap(ARM64_HAS_LSE_ATOMICS))
 			return false;
-		break;
-	case BPF_LDX | BPF_MEMSX | BPF_B:
-	case BPF_LDX | BPF_MEMSX | BPF_H:
-	case BPF_LDX | BPF_MEMSX | BPF_W:
-		return false;
 	}
 	return true;
 }
-- 
2.47.3


