Return-Path: <bpf+bounces-77199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 012D5CD1903
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 20:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74AD330019C7
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719D032AAC4;
	Fri, 19 Dec 2025 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDgyx7yv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1911D5CD4
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766171600; cv=none; b=XOGspwdkrYvfAkTBQfLnYDJUvY4ArT72qn0cEx8zTCS9UyhWVV1Z2WSvOs74CmLFPOwEPkhhdG+lSAtpekg8QDZApewDwheL706uuzjsu4XwleOMwkuqb7piMEDl9N7LWAFL1PplBzvDrxWakHo3ZSgn+SOhEJ0m7G9OZIYmN2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766171600; c=relaxed/simple;
	bh=bNjCGaEWJYJ9D3C/P+SCnczJupzEw0pdhQAN2wkW+FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULUdANp0/a/tYkR+aDnX2zUIkgEbywGL0R6BLmkSkpoY2pPljO/d1L9EzRVSrm2t+2+xyHPGXYV/EdtzZz/k+RV2Ed6jJm7S9ewjiAAZ1oyVadE+84jPFcAcMzJ0cXvSYspEuMZQ7UiXxOh0iPPuDR/ItSd7CvIEppw+n72v0Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDgyx7yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E50C4CEF1;
	Fri, 19 Dec 2025 19:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766171599;
	bh=bNjCGaEWJYJ9D3C/P+SCnczJupzEw0pdhQAN2wkW+FQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KDgyx7yvvBl7t6cWEy5UX965mT27TE6ZyhMo7X2huTva91K6g4pUPHG/nAy7PdEXU
	 6V04AAF2ogpTiCZ28pIsXv0nmqUagijrRI4NexZJZssL4fhHCgWgVcYsiZWCVr+fGf
	 4yfK5IbRiTpVTpX3FI5WwrnAGV2PDPt2nE55xZa/uWNn8n6bkhqtzoJdQF+bwvMkvd
	 dSsTquVb90K4NBQcrYkYNHYmuJILDuYDetNkGqovg6/rWWo1TZupCWHnbXORrMqWlz
	 rtovLyhNMj99Wjbgrq3IGxjNredqAs22YX223sNW51OMXZb36vJr5ZQnUk4AGgk/XS
	 3QGo47LsKqerA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next] bpf: arm64: fix sparse warnings
Date: Fri, 19 Dec 2025 11:13:08 -0800
Message-ID: <20251219191310.3204425-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ctx->image is declared as __le32 because arm64 instructions are LE
regardless of CPU's runtime endianness. emit_u32_data() emits raw data
and not instructions so cast the value to __le32 to fix the sparse
warning.

Cast function pointer to void * before doing arithmetic.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b6eb7a465ad2..0c4d44bcfbf4 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -118,7 +118,7 @@ static inline void emit(const u32 insn, struct jit_ctx *ctx)
 static inline void emit_u32_data(const u32 data, struct jit_ctx *ctx)
 {
 	if (ctx->image != NULL && ctx->write)
-		ctx->image[ctx->idx] = data;
+		ctx->image[ctx->idx] = (__force __le32)data;
 
 	ctx->idx++;
 }
@@ -3139,7 +3139,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
 			kfree(jit_data);
 		}
-		prog->bpf_func -= cfi_get_offset();
+		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
 		hdr = bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
 		priv_stack_ptr = prog->aux->priv_stack_ptr;

base-commit: ec439c38013550420aecc15988ae6acb670838c1
-- 
2.47.3


