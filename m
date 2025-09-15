Return-Path: <bpf+bounces-68405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96046B58212
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E8F4C233E
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 16:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47853288C81;
	Mon, 15 Sep 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdUTmD+E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE7213E6D
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953741; cv=none; b=lx0IZ33nsjmtm2hvbxU/Nf8+GYmTFmJzIdD+/DvZ4RrXW2MZN8GYtyQ1Fa+1PRko0tkyF9+cQPV/xXpEVtUeQ3jiRRJkdAVL6UMRCdcbtGUTLVxmqMcLTM+g4QNcjnJ43NYKcUQotJfVW0MEB3/vx3YTFKCKfNsk7fmMQLG7WbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953741; c=relaxed/simple;
	bh=cP4Lk6YGep27An8ml7Oo3bCe/cOQhK4OUJP9XgSrO9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D77UetokyKLNsWmn7bjdt3v6p2zxZGtd6MX56L5aqbjLW8twXg7amfA4exfq3k2P2rRmafPavtdPW07t3NoL7YSnf7Dyslvf1APOUB4RBC5cux/GHN0dcdHtNra1holc6fBL7Mmke+GI3HjkRp2Tq4ygLTntV90lHvcVypTGgEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdUTmD+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5F8C4CEF1;
	Mon, 15 Sep 2025 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757953741;
	bh=cP4Lk6YGep27An8ml7Oo3bCe/cOQhK4OUJP9XgSrO9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qdUTmD+ETxkJM3EDIP3Zenjrt8BABScezyd5a0PuviJx6hJr6niPEVHFEKkH6j3XA
	 N5NWfR/aYn2z3bVjmtvqu7/9B0EhotU14LulNfYkzyhrYzDbFksGJbXC+hfwyy3fbI
	 uy7DwuG7RwKkrYCWxon9c7kvuonVPlgAFg2EzSp/YwN/ra2qYP2w1DBXcXEUPlxZbd
	 ONUnI3C+ZYpYNClBvQRWxFU4Okrr0EG2uABsWwIX3NaLrhhB0fjjpxOr/TLh54SehX
	 QOFIOXZqWQaw7xOWndnASDMYcMwPcbitMGXwuMvZ1aWN58rbEVNmIPvKZykf2O3vh4
	 wR+6pg0vYEuJw==
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
Subject: [PATCH bpf-next v3 2/3] bpf, arm64: Add support for signed arena loads
Date: Mon, 15 Sep 2025 16:28:46 +0000
Message-ID: <20250915162848.54282-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915162848.54282-1-puranjay@kernel.org>
References: <20250915162848.54282-1-puranjay@kernel.org>
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
index f2b85a10add2..7233acec69ce 100644
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


