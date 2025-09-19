Return-Path: <bpf+bounces-68887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F86B87B56
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CE51CC1C58
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75CC26F285;
	Fri, 19 Sep 2025 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lclcwDjp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6A25A659
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248344; cv=none; b=Sshs5xWMt7x18/NDVu/+aQWYP48PPbeu8kg+dG3gCQevT3KGpcTEq8HPvjkHPmP8Rci2Cmgh/zXD8EGVEaaDHmVqsSm0gm15j9NVENLE5V2WqdZk/Bz7G4dWrK6HgridwtPMO47bRE7qyD0z9eBAcb4oXKfkeMEG6zuXgIraHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248344; c=relaxed/simple;
	bh=3AP7tDNBwbKxIIdKEkUG2Lh/GQxqPm32Fg10se2P3iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDtIgZ11RfSNSh4mvILbM9NLd8yVeXJxaFy0/udpVgwTcuJzAOGi2QdeOwOBHM2IbL1jhtgkVwNPS7CIZZGSHQXYCLTysOuoKxOXVsY/rqRUVO/TMYgUsFLh5TiP3iNk0X4iLk/AMMfB5FU3RnvR0DDH81OEnzkKJ+cDMoLOn14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lclcwDjp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24cde6c65d1so15897215ad.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758248342; x=1758853142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kmCfuIKBDf7ZwugWWzh73e25+MucpGgkKyll8ZY0ic=;
        b=lclcwDjpSqbJ0Xl8B+rVri0D/gux0CfWqPg3wTpJyi/yyXQkSnxE3qlz9AhtXkRRb6
         IIrhn7yj0DbxdFIX7HAZt6N+RQ3F4FLdqkYAEnWoETc4JraK+akKYr4I/fIJa8lDthxP
         Nsb82URUbcrakF+sdb/IhHytsnOZCosJVEz5GJhsdx1nf/PULBuLoho+Jx1B/PusASvm
         EmHq5bil2cqZyD7/xBlizpWAqRxB6rgl0wgQnEE/0BdFuOdERbcLCXO1tAJDVEoCpK+k
         gyrxB2asfBG5Hj4NM7ELPQcNHLZRPIeCqP6qSZ01npqyo8NyU38CRroWXoD6bTgNgsEt
         +NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248342; x=1758853142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kmCfuIKBDf7ZwugWWzh73e25+MucpGgkKyll8ZY0ic=;
        b=hXz3Ive2g45esJcjP0pCyFScBgjSEZw5TcjoYg9KbyubXhEh6hRgCdWIgCtuo14BfV
         SKehQD4Ye1XChTZ+d0lUTKqN9s6rV25rsy75lrV2Dxj7MGAuZGx47CBvzaCtiVOPrd0Q
         oYuwzlNMdwOg0PSNfFznUk7LGDIx61AqIi2+HB1FzgPr6NbEF3LyFK+nckUbid4nT1L+
         gQ5fb7pKS4RTPZql0BT0nxQHWy6uunxTV69nb4atLrDOZIYQhhX55fNop4L9gPfMW44F
         1GZGnSz3GhG0wmhSA8oCuBDMUxjh07tkg3SlaD21TRbr6l1xQsMfH88x70TPp0/fhC7R
         zt6w==
X-Gm-Message-State: AOJu0YyWmyq8cnL6XL8XatTNLeBYdEUyymPyAvUJ/sXv9mRrMy5156Kw
	Su8L0CzQRO4ISUkSyOYBMm/cmdAxqoevbioZZNBVVl9IFGoPCt/YqqxM1+COHQ==
X-Gm-Gg: ASbGnctMloLAeHOzy7fg1OJekXI5BU7JE+yUgKlLMyLkfupiwvxm0EEGRCHEe3E2ZbR
	YxaZRtkoHr4SnvZg+U96jfNDEUoUqdx2zIKRBqXsUN3PkJdVMSC7HR4ePpIa1bnUmFpS/tQkRmR
	bfMgeVq2Obs/2+IZv0xrlnvy/DeznkOMHRdbd2x2Ozl+XeEPkTNVXS2GSOuYV0X15OL0b1pekvN
	pzEiwt+X3WDj6aYOMTMUL7m5nT+lh/9a2+DXhrDAFtXbm/GFJlhIAp5jrbnFlJn6GtVKNu/13Fy
	oddY6rU8uoOT3HpoBkQLmryhInrDcgcU3yFevWmeJGkky8JasQmWGE/45hW1uFVm0aHMaigyyjN
	W6XgdG3tEU5KfG3jK
X-Google-Smtp-Source: AGHT+IEkpzA2wE+DHTSCH0+RFQr9Mg8aUP4R9HAnXzNZs+X2eiYVD6QTCal9duZA9B4QFWaRJNOQAQ==
X-Received: by 2002:a17:903:2310:b0:246:ceda:ebeb with SMTP id d9443c01a7336-269ba503f0dmr22830475ad.33.1758248341806;
        Thu, 18 Sep 2025 19:19:01 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033a3e5sm39186235ad.126.2025.09.18.19.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:19:01 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 01/12] bpf: bpf_verifier_state->cleaned flag instead of REG_LIVE_DONE
Date: Thu, 18 Sep 2025 19:18:34 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v3-1-c3cd27bacc60@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
References: <20250918-callchain-sensitive-liveness-v3-0-c3cd27bacc60@gmail.com>
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
index 6625570ac23de25553a70ba97cb41ed01143492b..02bfe3e4a2f01ed702fa14ee49374444fb7efe2d 100644
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
@@ -3589,11 +3590,6 @@ static int mark_reg_read(struct bpf_verifier_env *env,
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
@@ -18501,7 +18497,6 @@ static void clean_func_state(struct bpf_verifier_env *env,
 	for (i = 0; i < BPF_REG_FP; i++) {
 		live = st->regs[i].live;
 		/* liveness must not touch this register anymore */
-		st->regs[i].live |= REG_LIVE_DONE;
 		if (!(live & REG_LIVE_READ))
 			/* since the register is unused, clear its state
 			 * to make further comparison simpler
@@ -18512,7 +18507,6 @@ static void clean_func_state(struct bpf_verifier_env *env,
 	for (i = 0; i < st->allocated_stack / BPF_REG_SIZE; i++) {
 		live = st->stack[i].spilled_ptr.live;
 		/* liveness must not touch this stack slot anymore */
-		st->stack[i].spilled_ptr.live |= REG_LIVE_DONE;
 		if (!(live & REG_LIVE_READ)) {
 			__mark_reg_not_init(env, &st->stack[i].spilled_ptr);
 			for (j = 0; j < BPF_REG_SIZE; j++)
@@ -18526,6 +18520,7 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
 {
 	int i;
 
+	st->cleaned = true;
 	for (i = 0; i <= st->curframe; i++)
 		clean_func_state(env, st->frame[i]);
 }
@@ -18553,7 +18548,7 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
  * their final liveness marks are already propagated.
  * Hence when the verifier completes the search of state list in is_state_visited()
  * we can call this clean_live_states() function to mark all liveness states
- * as REG_LIVE_DONE to indicate that 'parent' pointers of 'struct bpf_reg_state'
+ * as st->cleaned to indicate that 'parent' pointers of 'struct bpf_reg_state'
  * will not be used.
  * This function also clears the registers and stack for states that !READ
  * to simplify state merging.
@@ -18576,7 +18571,7 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
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

