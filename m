Return-Path: <bpf+bounces-44275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A119C0D42
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 18:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988D8284A7D
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FAB216E03;
	Thu,  7 Nov 2024 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4bsbi5K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286AF21219F
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731001875; cv=none; b=dIKNYL3bppyREDeRrMwRzJhOcB65jAvgfYi/fZz6EoPn/1Dd/LLNgaIOqBBCF8YwbsdFKTZm/it6oywKN2KIOnSFaOh3odrvQhP8DTQNREkx9xAOCagKGJyLYqVj08SKX1NTQ0t83HGEq05FS1hNyEwEsrjmrRGYPEBl6E+kEvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731001875; c=relaxed/simple;
	bh=rpwfH7UREpRTm452olMbgYsgD4sekufu1q1uCUALS8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVL1BIQY4jmrSmwouBkWJWujTpWgp6kXu0AAsxzj+ALBexD+GCPU3/cCcHqHiVj1amcCv3WsXxfcGnOqeiA4N9chNfFqYPgMk66R25n62XPc3jYx8JztQv64v2gPBWLmARR602VuSwGmUBCvPfmKAZZoAXt0KWLwAVAIQAeVLes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4bsbi5K; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2e2d09decso1870858a91.1
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731001873; x=1731606673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6W+T8L8Jx2OznMdQFey5kB1B1VvMQB1JGD/jHvtnTY=;
        b=D4bsbi5KB3P66B30rns5/ftR5xTpXlPuYrRTtT3j/viu8HEsf8drFgnMzQ+MR7vQKE
         bvwzLV5zixI86IJI86CtiGA7U0NyA8bIKhLzJxCESM815EBOAX5aoC2CKRmATR1e5TA8
         6eVamzWXwhxTnrK4oJ9zfqMN5j4nbYqEOQ7URhLEHzVuxxgIcaD9xjKm2Fq8R0c+2nOO
         3dlFnunC4OAGELmL4vEsXGs7VzH6sxJLJS3e9gWEmtjVoBegIK1LN9HT9vlraX61TXyj
         7gl1gvUNI6SLYVz4XUg0DdHBW9wyswDxTQW7AyQYryS93nETu/weRI0a09X5LBIC7bz+
         imog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731001873; x=1731606673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6W+T8L8Jx2OznMdQFey5kB1B1VvMQB1JGD/jHvtnTY=;
        b=hec/cvE90UpEARil1TvuqFGjj3LDKVEdQuTwKVwLVsNxZeXbBaJo3tXFFxWp1bvB6K
         d8cpM3cNjKPbjypUCfV3e3i+Ka55qdkFwDxarcUAvt61e3s4afo0Z9gHhOML8BjbONeP
         1+MJPNGR2wgEz571sngELivmID+uDs7G5jUwI1JocMh3c7nQertKdFeZnOp1/SkCE2i9
         C+T4xOuS1U0ddGKJIY821wAKAvIMMHNlh9/ykKe5gg+YuT+qnBoS2b9ZjIv2CtVRE69g
         v8R2YaSi4n8/1IXrJbDBWyu+GMS5Ej4J7VigBSRDj/EANEwA0mcXCl/UMgB9jSo56j/M
         2I6g==
X-Gm-Message-State: AOJu0YxFMPiKMH7WCpREXCDqw2R8bBH7hs3WQTk7vw42AH2Nrul11fvu
	cbSk53V+lPv1Qk7noYEQn2rFWW31P30zu8PB2Cg8cdcTzSaVROd1GMRORJO4
X-Google-Smtp-Source: AGHT+IEUdI+DsjckHSHQuOOn5U9Nev79dDhl5mvvQyzDe4CEsQ/SLtDn25/9+Bkra4+HquoN788yJQ==
X-Received: by 2002:a17:90b:17c7:b0:2da:88b3:cff8 with SMTP id 98e67ed59e1d1-2e9b0a4e2cdmr706690a91.6.1731001873152;
        Thu, 07 Nov 2024 09:51:13 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52b32sm1730686a91.5.2024.11.07.09.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:51:12 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 01/11] bpf: use branch predictions in opt_hard_wire_dead_code_branches()
Date: Thu,  7 Nov 2024 09:50:30 -0800
Message-ID: <20241107175040.1659341-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107175040.1659341-1-eddyz87@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consider dead code elimination problem for program like below:

    main:
      1: r1 = 42
      2: call <subprogram>;
      3: exit

    subprogram:
      4: r0 = 1
      5: if r1 != 42 goto +1
      6: r0 = 2
      7: exit;

Here verifier would visit every instruction and thus
bpf_insn_aux_data->seen flag would be set for both true (7)
and falltrhough (6) branches of conditional (5).
Hence opt_hard_wire_dead_code_branches() will not replace
conditional (5) with unconditional jump.

To cover such cases:
- add two fields in struct bpf_insn_aux_data:
  - true_branch_taken;
  - false_branch_taken;
- adjust check_cond_jmp_op() to set the fields according to jump
  predictions;
- handle these flags in the opt_hard_wire_dead_code_branches():
  - true_branch_taken && !false_branch_taken
    always jump, replace instruction with 'goto off';
  - !true_branch_taken && false_branch_taken
    always falltrhough, replace with 'goto +0';
  - true_branch_taken && false_branch_taken
    jump and falltrhough are possible, don't change the instruction;
  - !true_branch_taken && !false_branch_taken
    neither jump, nor falltrhough are possible, if condition itself
    must be a dead code (should be removed by opt_remove_dead_code).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  4 +++-
 kernel/bpf/verifier.c        | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4513372c5bc8..ed4eacfd4db7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -570,7 +570,9 @@ struct bpf_insn_aux_data {
 	struct btf_struct_meta *kptr_struct_meta;
 	u64 map_key_state; /* constant (32 bit) key tracking for maps */
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
-	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
+	bool seen; /* this insn was processed by the verifier at env->pass_cnt */
+	bool true_branch_taken; /* for cond jumps, set if verifier ever took true branch */
+	bool false_branch_taken; /* for cond jumps, set if verifier ever took false branch */
 	bool sanitize_stack_spill; /* subject to Spectre v4 sanitation */
 	bool zext_dst; /* this insn zero extends dst reg */
 	bool needs_zext; /* alu op needs to clear upper bits */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7958d6ff6b73..3bae0bbc1da9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13265,7 +13265,7 @@ static void sanitize_mark_insn_seen(struct bpf_verifier_env *env)
 	 * rewrite/sanitize them.
 	 */
 	if (!vstate->speculative)
-		env->insn_aux_data[env->insn_idx].seen = env->pass_cnt;
+		env->insn_aux_data[env->insn_idx].seen = env->pass_cnt > 0;
 }
 
 static int sanitize_err(struct bpf_verifier_env *env,
@@ -15484,6 +15484,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 {
 	struct bpf_verifier_state *this_branch = env->cur_state;
 	struct bpf_verifier_state *other_branch;
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[*insn_idx];
 	struct bpf_reg_state *regs = this_branch->frame[this_branch->curframe]->regs;
 	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg = NULL;
 	struct bpf_reg_state *eq_branch_regs;
@@ -15510,6 +15511,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 				insn->off, insn->imm);
 			return -EINVAL;
 		}
+		aux->true_branch_taken = true;
+		aux->false_branch_taken = true;
 		prev_st = find_prev_entry(env, cur_st->parent, idx);
 
 		/* branch out 'fallthrough' insn as a new state to explore */
@@ -15579,6 +15582,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		 * the fall-through branch for simulation under speculative
 		 * execution.
 		 */
+		aux->true_branch_taken = true;
 		if (!env->bypass_spec_v1 &&
 		    !sanitize_speculative_path(env, insn, *insn_idx + 1,
 					       *insn_idx))
@@ -15592,6 +15596,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		 * program will go. If needed, push the goto branch for
 		 * simulation under speculative execution.
 		 */
+		aux->false_branch_taken = true;
 		if (!env->bypass_spec_v1 &&
 		    !sanitize_speculative_path(env, insn,
 					       *insn_idx + insn->off + 1,
@@ -15602,6 +15607,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		return 0;
 	}
 
+	aux->true_branch_taken = true;
+	aux->false_branch_taken = true;
+
 	/* Push scalar registers sharing same ID to jump history,
 	 * do this before creating 'other_branch', so that both
 	 * 'this_branch' and 'other_branch' share this history
@@ -19288,7 +19296,7 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 {
 	struct bpf_insn_aux_data *old_data = env->insn_aux_data;
 	struct bpf_insn *insn = new_prog->insnsi;
-	u32 old_seen = old_data[off].seen;
+	bool old_seen = old_data[off].seen;
 	u32 prog_len;
 	int i;
 
@@ -19608,9 +19616,9 @@ static void opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env)
 		if (!insn_is_cond_jump(insn->code))
 			continue;
 
-		if (!aux_data[i + 1].seen)
+		if (aux_data[i].true_branch_taken && !aux_data[i].false_branch_taken)
 			ja.off = insn->off;
-		else if (!aux_data[i + 1 + insn->off].seen)
+		else if (!aux_data[i].true_branch_taken && aux_data[i].false_branch_taken)
 			ja.off = 0;
 		else
 			continue;
-- 
2.47.0


