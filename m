Return-Path: <bpf+bounces-68839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8587BB8683F
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AF07C0A91
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D72D3737;
	Thu, 18 Sep 2025 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcO1uGMB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0D027FB3E
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221288; cv=none; b=KWLTN34lkOk08VSmDXYfP1M0X9oyhjW5f+zyK1I3P1Rx4Tru8fl58ZgTAKlXDxLgW7I1pGybxtbYYW3cOT+j1AoTd9b92gtRoxGIsYNt0m8WCAyEqv/Nq4bwMkD0c1JjCBZnvM7jaLeNX6fwUGUzkrFWtlURng4QbVjxGIyl1VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221288; c=relaxed/simple;
	bh=VTWNNWnpi5XtWZiMqEqKnvZTyCqWWJ4OzSIhVCKBfF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNvtsYrvWSgRhWXLPFwd+/hs9uyaKLjqUcZE0/+5Cl7pRgM0kX09nOjXyE/ENNVDPo/tlMjMUo79MKC5K2GyFaHKnlLTro7tnqUWciyl05c3oKbKCgT4mxduZTxoVDFjTrUzUcpjhU+bIJRfg+TqACPGXk0LC6dfQyPtRQh6aGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcO1uGMB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-25669596921so14427485ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758221285; x=1758826085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm2F0ug5fEr3S4MXVJUC5Ox4b4HMEpY7jEu0OpLsbTc=;
        b=CcO1uGMB6ik37zKu+aB/doRuO5EoEhOGaqpHRBSkY4kZiP8a0dUGruZP89bWd82NRk
         j/1V6Gf8yLsGMNjwNTdztiIgxa+EYdrqEKWsIzVRHDi4VsHwHsYYlUW69Sh+dLuYh32D
         5fZOFvCyNWoWL+5gh8beAJtPKv1h6qAs/H1DZFHezNsCvYfXjk6mb2W13dTD+gYQTRwE
         ORBKleBcvWwx2eD87ZChzxJX2rPNDfIpXO705KGFwy8hPgiiNsIvHtGG6XY1m7FyPksE
         PnWFO0j6Q//FmfDPhHsIyJFPpL86pMTU4P8prSiWugJh1xoWvBycmvi6aY4b5G1wv6ij
         z/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221285; x=1758826085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qm2F0ug5fEr3S4MXVJUC5Ox4b4HMEpY7jEu0OpLsbTc=;
        b=cajzj9NtpETVeeLo6/lfYZoABjK8siG5CypmdEanrHLa4L2a3aIBobRYX/wANQDfGq
         S8pMZhfF0FbP6I39bbMfeaTQvW3wq2nYtsz9c5D+MYSUMthbyYiIEUL3l+ko4Pbp7gJZ
         HlxjmzL/Oz1RqMgNM9++OK0GcuxsHklPJs2VISs974uFo6RrhwwnTOH0vYOXAoiprUh0
         hlLvBThFy+6vgKLaJGUU96bAvvBU68a7GonNfpE0jVuzf3vkq20k/OSlux1d7O6LlMYP
         gMu9YZ+JWlKQ4yEq8TWu6ZpwDT2/qYOWMygcc/o+k2UwRtYimmBLJSI6ZFJWwoJi9/Ir
         naIw==
X-Gm-Message-State: AOJu0YyNl7ZegCh3FUEfKd7/JpaOZyo/29ymehR4sSb7KVk3HD3QjKIm
	QXMmtsc0LLOtpmPfn87LEGz9TDt8mf7x19jmiZOEgXj2ONL93xiuhttLImtKiA5S
X-Gm-Gg: ASbGncs1WRMO8xsrSOcJrIldeFmf6wdnei4cY1sjR62yjxe5XLivZ4HWevJnCzajskh
	zx++II8RKx6y/RGCwnp0v488PKPHUq1clNbwNBfgBWajXxu1kCwSMdzPvndKzy3b/3IfryaPGil
	H8+tYEs2PNYE57qJSkeIucG7Yrqq6izWsjQadjHraM+kMHWd9a9o9ZdFVQ9vn7OxnpgTkr6Arky
	GIvH/B7RuQd3jN6W/zJKwgKuDrkL7NKdclUQw25aq6L8JloaBAnlJYAzmIygmulYS17eGR0Qe2k
	EhRgmUYrdkvOiJmu9tERnqO0PRm24f9MFGJHC5FsNCM69hBAjsbK3I9yMrmM/rw2kwoXLZfA9jj
	X5szMALp5w9Yq4C83s4cl2Zr+04fUh9D1eik=
X-Google-Smtp-Source: AGHT+IH3mha8DdoYbB1zBzqwrY+24fbRiBVqF556xei8/R2IRMaTDKFRIcKi09r+jUE8nrO7oOELag==
X-Received: by 2002:a17:902:d545:b0:24c:cf58:c5c3 with SMTP id d9443c01a7336-269ba459c58mr8186685ad.23.1758221285331;
        Thu, 18 Sep 2025 11:48:05 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm32361505ad.90.2025.09.18.11.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:48:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 01/12] bpf: bpf_verifier_state->cleaned flag instead of REG_LIVE_DONE
Date: Thu, 18 Sep 2025 11:47:30 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v2-1-214ed2653eee@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
References: <20250918-callchain-sensitive-liveness-v2-0-214ed2653eee@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Prepare for bpf_reg_state->live field removal by introducing a
separate flag to track if clean_verifier_state() had been applied to
the state. No functional changes.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/log.c             |  6 ++----
 kernel/bpf/verifier.c        | 13 ++++---------
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 020de62bd09cdd6e4692354192c747f32e7cc323..ac16da8b49dc1c1e2ba371df785ca32aa7c5415a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -45,7 +45,6 @@ enum bpf_reg_liveness {
 	REG_LIVE_READ64 = 0x2, /* likewise, but full 64-bit content matters */
 	REG_LIVE_READ = REG_LIVE_READ32 | REG_LIVE_READ64,
 	REG_LIVE_WRITTEN = 0x4, /* reg was written first, screening off later reads */
-	REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
 };
 
 #define ITER_PREFIX "bpf_iter_"
@@ -445,6 +444,7 @@ struct bpf_verifier_state {
 
 	bool speculative;
 	bool in_sleepable;
+	bool cleaned;
 
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index e4983c1303e76003ba971a71c5ff6b0c9aa751af..0d6d7bfb2fd05e3870c4741f657257187158fff6 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -545,14 +545,12 @@ static char slot_type_char[] = {
 static void print_liveness(struct bpf_verifier_env *env,
 			   enum bpf_reg_liveness live)
 {
-	if (live & (REG_LIVE_READ | REG_LIVE_WRITTEN | REG_LIVE_DONE))
-	    verbose(env, "_");
+	if (live & (REG_LIVE_READ | REG_LIVE_WRITTEN))
+		verbose(env, "_");
 	if (live & REG_LIVE_READ)
 		verbose(env, "r");
 	if (live & REG_LIVE_WRITTEN)
 		verbose(env, "w");
-	if (live & REG_LIVE_DONE)
-		verbose(env, "D");
 }
 
 #define UNUM_MAX_DECIMAL U16_MAX
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1029380f84db3e9a3033aed18dcb4fa62da1467e..861628f4baf8788b80a5cf5eba182db3372bdce2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1758,6 +1758,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 		return err;
 	dst_state->speculative = src->speculative;
 	dst_state->in_sleepable = src->in_sleepable;
+	dst_state->cleaned = src->cleaned;
 	dst_state->curframe = src->curframe;
 	dst_state->branches = src->branches;
 	dst_state->parent = src->parent;
@@ -3574,11 +3575,6 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 		/* if read wasn't screened by an earlier write ... */
 		if (writes && state->live & REG_LIVE_WRITTEN)
 			break;
-		if (verifier_bug_if(parent->live & REG_LIVE_DONE, env,
-				    "type %s var_off %lld off %d",
-				    reg_type_str(env, parent->type),
-				    parent->var_off.value, parent->off))
-			return -EFAULT;
 		/* The first condition is more likely to be true than the
 		 * second, checked it first.
 		 */
@@ -18476,7 +18472,6 @@ static void clean_func_state(struct bpf_verifier_env *env,
 	for (i = 0; i < BPF_REG_FP; i++) {
 		live = st->regs[i].live;
 		/* liveness must not touch this register anymore */
-		st->regs[i].live |= REG_LIVE_DONE;
 		if (!(live & REG_LIVE_READ))
 			/* since the register is unused, clear its state
 			 * to make further comparison simpler
@@ -18487,7 +18482,6 @@ static void clean_func_state(struct bpf_verifier_env *env,
 	for (i = 0; i < st->allocated_stack / BPF_REG_SIZE; i++) {
 		live = st->stack[i].spilled_ptr.live;
 		/* liveness must not touch this stack slot anymore */
-		st->stack[i].spilled_ptr.live |= REG_LIVE_DONE;
 		if (!(live & REG_LIVE_READ)) {
 			__mark_reg_not_init(env, &st->stack[i].spilled_ptr);
 			for (j = 0; j < BPF_REG_SIZE; j++)
@@ -18501,6 +18495,7 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
 {
 	int i;
 
+	st->cleaned = true;
 	for (i = 0; i <= st->curframe; i++)
 		clean_func_state(env, st->frame[i]);
 }
@@ -18528,7 +18523,7 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
  * their final liveness marks are already propagated.
  * Hence when the verifier completes the search of state list in is_state_visited()
  * we can call this clean_live_states() function to mark all liveness states
- * as REG_LIVE_DONE to indicate that 'parent' pointers of 'struct bpf_reg_state'
+ * as st->cleaned to indicate that 'parent' pointers of 'struct bpf_reg_state'
  * will not be used.
  * This function also clears the registers and stack for states that !READ
  * to simplify state merging.
@@ -18551,7 +18546,7 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 		if (sl->state.insn_idx != insn ||
 		    !same_callsites(&sl->state, cur))
 			continue;
-		if (sl->state.frame[0]->regs[0].live & REG_LIVE_DONE)
+		if (sl->state.cleaned)
 			/* all regs in this state in all frames were already marked */
 			continue;
 		if (incomplete_read_marks(env, &sl->state))

-- 
2.51.0

