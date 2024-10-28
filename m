Return-Path: <bpf+bounces-43306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091B79B3218
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 14:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94F21F22A78
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E441DC18F;
	Mon, 28 Oct 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VUrF6ZDX"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA3A1D5CDB
	for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123184; cv=none; b=e4+2iqtBNNrBPKnUtYgLPZemSPQNP8vSh1T4qepMNecJRmilfREeW6BhjYfQvFohWV5a8HS/fvq3+rZIOs2hYKqQPWnJd6Yg30IaClYWL9mYx7T/NzruFViXcNxsXCItgb0wBPuFGi0ADmBFfMy7SaE9uYbuk0IiTg4ha+R2oSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123184; c=relaxed/simple;
	bh=nG4czWWM1v4K9sX5y1DM6zg7yaLlGQvj3r8D9MhjkPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSEKuScatzhBvXyP8FKBy2zw8pF5O0D1chCYuvwvjCpURGTOUdQXmEKo4/rwZz+pX2+60S6GgmL6BTn3OqWr6Cz3q5xIIwW/hoKmc/klEHKnPgTF1fkqjR75ksWkkF+LUzkwZ6kff2R5EIplU3AViP3/AgK6M8Vtb+uyLWWjQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VUrF6ZDX; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730123178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OvRQz0mxYIFFyhd7wDrB8+fsS89iDjr0TgX/mpua0s=;
	b=VUrF6ZDXEnuQ+KS0mxUFoz81qQOpg6Q+eG28Qxq/QW0IJjOwtRe8Sc9Lm7uOS/4JT4sjb2
	BZv6B8ekDRcB47xfjZSPrBkzqGL4LfvODzriGBijT90oR9739QALNL0NXnPsbplNdoWcXs
	BD/lCJ1bSqXf1keNyTqnYxGxzxx9XO0=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	eddyz87@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [RESEND PATCH bpf-next v2 1/2] bpf, x64: Propagate tailcall info only for subprogs
Date: Mon, 28 Oct 2024 21:45:59 +0800
Message-ID: <20241028134601.95448-2-leon.hwang@linux.dev>
In-Reply-To: <20241028134601.95448-1-leon.hwang@linux.dev>
References: <20241028134601.95448-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In x64 JIT, propagate tailcall info only for subprogs, not for helpers
or kfuncs.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 06b080b61aa57..eb08cc6d66401 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2124,10 +2124,11 @@ st:			if (is_imm8(insn->off))
 
 			/* call */
 		case BPF_JMP | BPF_CALL: {
+			bool pseudo_call = src_reg == BPF_PSEUDO_CALL;
 			u8 *ip = image + addrs[i - 1];
 
 			func = (u8 *) __bpf_call_base + imm32;
-			if (tail_call_reachable) {
+			if (pseudo_call && tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
 				ip += 7;
 			}
-- 
2.44.0


