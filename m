Return-Path: <bpf+bounces-38204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC0496183D
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 21:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF832853B1
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 19:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20D51D31A6;
	Tue, 27 Aug 2024 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NAbeTppr"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FCE2E62B
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788350; cv=none; b=WVSNHAMo/DQV+sKLAmaUIZG6ATV3jLS/zAQFym1PhZPtsUlvAJtmwUXJf0yxruv+UpgFyR3PO3fHMNt/I0Rz969I7I8B/nI72GrywcJNOwWv6hNMCSxgfHIDP6hbBI5bn0jwHh5CWp+ls799o/+UkKQJFq9u37rbFevkOZPDMhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788350; c=relaxed/simple;
	bh=qk8Tn02mQwqoLnSFPAHZVYIhZIWX+pqyPAFCALFvTSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpjUpXIoJ+Eb9J6lrC8JviL/Pi1KoCJTB2ko0ZUaAtH5jNWPCa9MguhzUvXcx1v+C5cC23xrH+UswDpLOu8mXIU1+shRxWHICsh40tlua87VZQHnjLrhv+2KD+twJUwYyJMo8U7SSNkS+jmM5dLdIOg7A33TPnfBMrF9ZeW/OGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NAbeTppr; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724788346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAsnNtMpDoQTqmFDe7F/b8kSH/wEdPGGpu28sItv6iw=;
	b=NAbeTpprwOK/gRb0TRU/+VgwNYNCzmkbTTL294QW5FJ388Ucubli0SkGVWeOTmtxwcsh24
	q7ZN9Wmgj9GuyJTibNsv5Cl8hHVu22T3zfjljDmjJigX7U2wXK7Djt6ZyXV8L1QtHZwFel
	H5TEPn18rJ6VuK6tNYQMA6o8KMq7FMY=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v4 bpf-next 2/9] bpf: Adjust BPF_JMP that jumps to the 1st insn of the prologue
Date: Tue, 27 Aug 2024 12:52:08 -0700
Message-ID: <20240827195208.1435815-1-martin.lau@linux.dev>
In-Reply-To: <20240827194834.1423815-1-martin.lau@linux.dev>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
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
adjust_jmp_off() needs to skip the prologue instructions. This patch
adds a skip_cnt argument to the adjust_jmp_off(). The skip_cnt is the
number of instructions at the beginning that does not need adjustment.
adjust_jmp_off(prog, 0, delta, delta) is used in this patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/verifier.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b408692a12d7..8714b83c5fb8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19277,14 +19277,14 @@ static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 of
  * For all jmp insns in a given 'prog' that point to 'tgt_idx' insn adjust the
  * jump offset by 'delta'.
  */
-static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
+static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta, u32 skip_cnt)
 {
-	struct bpf_insn *insn = prog->insnsi;
+	struct bpf_insn *insn = prog->insnsi + skip_cnt;
 	u32 insn_cnt = prog->len, i;
 	s32 imm;
 	s16 off;
 
-	for (i = 0; i < insn_cnt; i++, insn++) {
+	for (i = skip_cnt; i < insn_cnt; i++, insn++) {
 		u8 code = insn->code;
 
 		if ((BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32) ||
@@ -19705,6 +19705,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 	}
 
+	if (delta)
+		WARN_ON(adjust_jmp_off(env->prog, 0, delta, delta));
+
 	if (bpf_prog_is_offloaded(env->prog->aux))
 		return 0;
 
@@ -21136,7 +21139,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		 * to insn after BPF_ST that inits may_goto count.
 		 * Adjustment will succeed because bpf_patch_insn_data() didn't fail.
 		 */
-		WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1));
+		WARN_ON(adjust_jmp_off(env->prog, subprog_start, 1, 0));
 	}
 
 	/* Since poke tab is now finalized, publish aux to tracker. */
-- 
2.43.5


