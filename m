Return-Path: <bpf+bounces-38473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D056A96517D
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 23:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C0B1F23992
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1B318A92C;
	Thu, 29 Aug 2024 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="su8kfk71"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397B1B8EA1
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965736; cv=none; b=G+wlt5m5IgqTgJWIwMYuj/lmfrTnZpHamoG55QFHCHFZco38KxXntU+7lNS0RCVx8Ze1Gh8sXP0YZvps2Je+srZ5kzOrCcvEJVadZn0b98xvNpNE9hvz7P5zxD1cw8vQt5gK/GPcQgWIZlqbCaBKeAzOvHXAczwHtZbcrnH9tL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965736; c=relaxed/simple;
	bh=efNiXJpYKRNsy/qTDEDhMsnzxwKfmfPky0fNC0/Zims=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rt8fPQAPnI1fPtHqJ9xGvL4Jisa3oEctvz5rG5Kj42xWHF7QUUbnZCa2LihI1Tht1e6RrdWYAxfjp5IM20GIzTNcw86WL0f6MOaO5RC8kz4zhZSb8QZIgDLQtCfbdnR0o7A970QCC9fi+3mOM7EhEaTo3RRgyOurMBccIoUvo9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=su8kfk71; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724965732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LO1dwmGLdY15rFlT/sg3JvzQPE6AVXs0aupxoL24uho=;
	b=su8kfk71gNvRHPqO+SNgoX30S0WxuHqJp22OjwdaJs1jkWWPqlclp3Ld0mRMEtK8FJyynm
	ZJdulcvZeGQvxsbHxGAf3Qh9Opnq5f2N2CVIjYceigWL7t3U4ID8x659HijLvb3/TkcTVb
	HE7VkcLTdskJqzC/81hUjY1ppklw470=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 2/9] bpf: Adjust BPF_JMP that jumps to the 1st insn of the prologue
Date: Thu, 29 Aug 2024 14:08:24 -0700
Message-ID: <20240829210833.388152-3-martin.lau@linux.dev>
In-Reply-To: <20240829210833.388152-1-martin.lau@linux.dev>
References: <20240829210833.388152-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The next patch will add a ctx ptr saving instruction
"(r1 = *(u64 *)(r10 -8)" at the beginning for the main prog
when there is an epilogue patch (by the .gen_epilogue() verifier
ops added in the next patch).

There is one corner case if the bpf prog has a BPF_JMP that jumps
to the 1st instruction. It needs an adjustment such that
those BPF_JMP instructions won't jump to the newly added
ctx saving instruction.
The commit 5337ac4c9b80 ("bpf: Fix the corner case with may_goto and jump to the 1st insn.")
has the details on this case.

Note that the jump back to 1st instruction is not limited to the
ctx ptr saving instruction. The same also applies to the prologue.
A later test, pro_epilogue_goto_start.c, has a test for the prologue
only case.

Thus, this patch does one adjustment after gen_prologue and
the future ctx ptr saving. It is done by
adjust_jmp_off(env->prog, 0, delta) where delta has the total
number of instructions in the prologue and
the future ctx ptr saving instruction.

The adjust_jmp_off(env->prog, 0, delta) assumes that the
prologue does not have a goto 1st instruction itself.
To accommodate the prologue might have a goto 1st insn itself,
this patch changes the adjust_jmp_off() to skip considering
the instructions between [tgt_idx, tgt_idx + delta).

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 261849384ea8..03e974129c05 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19286,6 +19286,9 @@ static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		u8 code = insn->code;
 
+		if (tgt_idx <= i && i < tgt_idx + delta)
+			continue;
+
 		if ((BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32) ||
 		    BPF_OP(code) == BPF_CALL || BPF_OP(code) == BPF_EXIT)
 			continue;
@@ -19704,6 +19707,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 	}
 
+	if (delta)
+		WARN_ON(adjust_jmp_off(env->prog, 0, delta));
+
 	if (bpf_prog_is_offloaded(env->prog->aux))
 		return 0;
 
-- 
2.43.5


