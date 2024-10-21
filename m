Return-Path: <bpf+bounces-42621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11209A6A96
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 15:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7299D284BE3
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9701F8917;
	Mon, 21 Oct 2024 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aAE/BQ5u"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBBE1F9400
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517985; cv=none; b=RAqaxnXDBtFDGRCp6sfGvpovN3IlTWFLPZfqwbztW6bqf9d4j7/+rIw9VPzS2NVUiJr8+32LeKtkm0cySimr9oPg/54be5YbnwWIfMK41P9FG0jYTJ9ClRpRveW8Pe38vRKNaF2+1bsmfg7kDskjtleyqH0U5eEURdEa1iT3BLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517985; c=relaxed/simple;
	bh=y1MhfUHbW9bFrohLvIqKd4pYEJhEqFvhfNmn1YVgCDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4HMwI32/mKtv4u3hdz6cyuXejAnEiFtk7dw/ovNfimd5w8Bl8e2VHmrChzNFVQw5AElk6p9pyz5sfP9/jTDlr0fsQqvjjLr+MxWpSolxXG+1OzYaspeJlRgjZPl+v7GUNQusCjXEeaad/+Ef17m39hZcew3oS3U3zYORb5XBQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aAE/BQ5u; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729517980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWCoRxD2VEdzF1sLzKyFXuJE1yx+GR1ex+u/p/I/GH8=;
	b=aAE/BQ5uepzzaCKtYMMpsYvXQY74D+pFhXMc3HsJWU1ujBxJppIcaB4G/DtzMmtsDtrNCh
	lI+BFa6bpH498A+IUPMJDBGddeJTLf52e6LcCAPnwGqcaToGeN3foWmOC9GXvf/+57GMuN
	snOGjuHKGagkZ+RvNLNG/dE/vEO7Zm8=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	jolsa@kernel.org,
	eddyz87@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 1/2] bpf, x64: Propagate tailcall info only for tail_call_reachable subprogs
Date: Mon, 21 Oct 2024 21:39:28 +0800
Message-ID: <20241021133929.67782-2-leon.hwang@linux.dev>
In-Reply-To: <20241021133929.67782-1-leon.hwang@linux.dev>
References: <20241021133929.67782-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the x86_64 JIT, when calling a function, tailcall info is propagated if
the program is tail_call_reachable, regardless of whether the function is a
subprog, helper, or kfunc. However, this propagation is unnecessary for
not-tail_call_reachable subprogs, helpers, or kfuncs.

The verifier can determine if a subprog is tail_call_reachable. Therefore,
it can be optimized to only propagate tailcall info when the callee is
subprog and the subprog is actually tail_call_reachable.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 4 +++-
 kernel/bpf/verifier.c       | 6 ++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 06b080b61aa57..6ad6886ecfc88 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2124,10 +2124,12 @@ st:			if (is_imm8(insn->off))
 
 			/* call */
 		case BPF_JMP | BPF_CALL: {
+			bool pseudo_call = src_reg == BPF_PSEUDO_CALL;
+			bool subprog_tail_call_reachable = dst_reg;
 			u8 *ip = image + addrs[i - 1];
 
 			func = (u8 *) __bpf_call_base + imm32;
-			if (tail_call_reachable) {
+			if (pseudo_call && subprog_tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
 				ip += 7;
 			}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f514247ba8ba8..6e7e42c7bc7b1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19990,6 +19990,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 			insn[0].imm = (u32)addr;
 			insn[1].imm = addr >> 32;
 		}
+
+		if (bpf_pseudo_call(insn))
+			/* In the x86_64 JIT, tailcall information can only be
+			 * propagated if the subprog is tail_call_reachable.
+			 */
+			insn->dst_reg = env->subprog_info[subprog].tail_call_reachable;
 	}
 
 	err = bpf_prog_alloc_jited_linfo(prog);
-- 
2.44.0


