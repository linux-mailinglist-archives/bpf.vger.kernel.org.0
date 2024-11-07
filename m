Return-Path: <bpf+bounces-44242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3329C07EA
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 14:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907871C23BF4
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC03212181;
	Thu,  7 Nov 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G+kSUBBQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F3DDBE
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 13:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987174; cv=none; b=QpH0nfAIcw23ypgXrmzI7GYtiTbJzgWAvtJe0a5WEYDyb+R584yGZG+liu8sqgYtsZXm52hoShPsZRS3V/7ek444nq7uHiQXx0ABcCDh9d3OHITuKrkO9xgMemgmNqvMMSUIulk6TDLwIy8zMG/rT0mWQm2o/kI9Z2IhmtYb1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987174; c=relaxed/simple;
	bh=fdTQ9aZKgBKGtnWGo2PP1uEKKKRlXWoR270RBYI4zB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJ3Vqd41qqovlfYLTifLcu2HDFTx0H3jlIkIRn0OQ7ATENsz0C4zYoPAb6Ctq9nGezZwcayUlavzzCl7gkWfRtcnFEZfdJ54dMKGeceMZx1EKzYGrF1pGr9O7QYEZuz36MmKkQV6VOCcKesUDqBpW0+XWwAKnbsvIXAnzJiXr0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G+kSUBBQ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730987171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oD1+J4uq1ErhHD7Mu2ctcQZ1ODAdxrxM0c4KuZqSxk=;
	b=G+kSUBBQse5U8e1+6dPMW31cMueXsobE1k/l5ODHMUvn5OQE0DvrGtqE9TlXVZITexcoMN
	ny2KKC0BgOHXdvy0hH3yq9dYnnJ7p6TQ1kyVhbdv4G9iZBZaJeI+SJDrhTfUGFfdN7E9C/
	hapnLwbIB0TwTgBN//qVfgixQ8NkcNo=
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
Subject: [PATCH bpf-next v3 1/2] bpf, x64: Propagate tailcall info only for subprogs
Date: Thu,  7 Nov 2024 21:45:28 +0800
Message-ID: <20241107134529.8602-2-leon.hwang@linux.dev>
In-Reply-To: <20241107134529.8602-1-leon.hwang@linux.dev>
References: <20241107134529.8602-1-leon.hwang@linux.dev>
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

Acked-by: Yonghong Song <yonghong.song@linux.dev>
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


