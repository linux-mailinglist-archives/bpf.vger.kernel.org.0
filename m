Return-Path: <bpf+bounces-68842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFECB86824
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76931C2691D
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455AC2D5C6E;
	Thu, 18 Sep 2025 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQC6lf3c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA73327B357
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221290; cv=none; b=RvO+y2ebm7MEI54L9h4jB9RSQs3hz475N1YNuBIy2wTLTwCPKwHIwol9J/vy8tAOgodK4o2FdBay95oHw5pOYojLvYrFRk96Sjgl8kTGdcqMK/J37Gkg0sukPrhDKTo6GbP2TBgdpvQ7ewx/jDXe1djR6l7+O+38KjSA56x1kp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221290; c=relaxed/simple;
	bh=MDQoZZE4dNsZ1ecf1cfkTD9jNT5fZ4bbgLfprFR/TF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXUYU3n4pSiw7gEauRHyqjsoSzQVEyOe+BJAg57e9ebmS7G2kv1XV/k49eXpukKpz4WCgKeu9OTTy2+gdHgBcEbbYnfWaJEeyep2SbpKfoe6b5h64bwQCWMmI4hMd/wEvYTQS++rw5U17NiuohFRItG8Jm5JDVUZ3ZaZ3CpSCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQC6lf3c; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24c8ef94e5dso10804195ad.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758221288; x=1758826088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsouY0OTlF7WnD6pHJQCgeWk1rUlG2YvLJAMy3YR7Lw=;
        b=dQC6lf3cw/DgqVK7j7bbMmSJw9K3nx4ki/lniEv4Y+/txl6/h8CGdiH/XDLmGkY66g
         NpuvjXYh+xUAn+eGgQbILfSwe8X9QcmdeZyxYiJc1SBBfnUrXpFYqLYAxFJjwzmOwnIs
         sVQVyXijwxja1GkfBEQimr0WiLTLvFEY/l5HRKjFL24GJaxk/1v8EDgPTQkX2lKZxyT/
         1ynNeUuAMmNVqzh3kSIhRQX+xnX3k/jX7Dfp9+n3MKFOpfGc//9hycLcWntuVnStsUcH
         G3MFZ0DloPjYZs6WGTNlZL0XFMsofA0kuKxJnJEGdCSUvy5pGKlH1SJ5Rwava7ky22DF
         dQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758221288; x=1758826088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsouY0OTlF7WnD6pHJQCgeWk1rUlG2YvLJAMy3YR7Lw=;
        b=UPOWsMIIuZ0V1RYiI/5HiC5iRQ1eB9ukqqSBtFcQ97O0XUv+H5vGdTI2vSZdy4mUS2
         mIZPp0x7dYauwD75eubXE81RxuijXxV7//zjiteTWwnoVtwQH76xuY7AGcPoyKV+bEfy
         yT4weU0tMzHiXPrDb40doHaZ73U38yA5rUoUPyuVa3TZFE0YK45CEEgSiYuPzttaP9mv
         6/GbTI4zkhJqYfjJNN04+5zMNheHmhckVAJUePLeI27HoGde1P9+0EImDzDD/yl9vqRO
         BbhmzBZ/+AdiO+S/U1ledTpKO89pVqgtyl3OKZ9lW+3G1kVMcjMOUQDq3hcwO2MLF2/V
         p5VA==
X-Gm-Message-State: AOJu0YxiJtvcoC8RCpa7MsU9uZmZDZsgXPx57ckaI1h5GlX/AUrP0qmb
	3Xnze9kuUBX+8SP2Mlbc+C7b0NvaPwjizICq3sqJxwRBi59/QuXEDKGLZUSowZRu
X-Gm-Gg: ASbGncsGHDUUQS6WLsf5yQGA9xX9dnNjOpD4PFpDmp9rGzaghUiqiE81LBUgYdXCJRb
	kKiDILNhKBYVeWqNYOPcJFJjKx+bmW/P29JzBXkif2K0/vNPnV8Dm5GD+wAItsQwNJyHkunsU4P
	g8S/HU/JDquTuZsNfiTfHdUreE9+m68qFLW2jnjMk/EC4kDdJjYuzIqfn+YEcZ2IOTQU11lB4W6
	uo7nDElEnMFRfoIHvZniAkcT6uCB41KV4PNe9HPEEt8oAzjn8PoWf+xYzKujBgUvcnZ7rIYxPWX
	qNeyw0WKnlACyE+eAulOXY0AUmszhlR+RvxZ4hw0Bj2jZYOJ4ggI3enDEqhn/0kLcvMknysKWau
	dvvX4439T65ZCBR2+l7riLONi+CuyaF0Q6jM=
X-Google-Smtp-Source: AGHT+IHyu8DyPv+by/idKy9+KwoibaKC+TmFmGnrEXwUYdAWopCq7nMcVjG7lqkq8d5002Xeo2Va3g==
X-Received: by 2002:a17:902:f54b:b0:265:b60f:d18 with SMTP id d9443c01a7336-269b755bd68mr9344395ad.1.1758221287884;
        Thu, 18 Sep 2025 11:48:07 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm32361505ad.90.2025.09.18.11.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 11:48:07 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 04/12] bpf: declare a few utility functions as internal api
Date: Thu, 18 Sep 2025 11:47:33 -0700
Message-ID: <20250918-callchain-sensitive-liveness-v2-4-214ed2653eee@gmail.com>
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

Namely, rename the following functions and add prototypes to
bpf_verifier.h:
- find_containing_subprog -> bpf_find_containing_subprog
- insn_successors         -> bpf_insn_successors
- calls_callback          -> bpf_calls_callback
- fmt_stack_mask          -> bpf_fmt_stack_mask

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  5 +++++
 kernel/bpf/verifier.c        | 34 ++++++++++++++++------------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ac16da8b49dc1c1e2ba371df785ca32aa7c5415a..93563564bde5947d08fad7b33f9e38b16942fa31 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1065,4 +1065,9 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 void print_insn_state(struct bpf_verifier_env *env, const struct bpf_verifier_state *vstate,
 		      u32 frameno);
 
+struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off);
+int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2]);
+void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
+bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx);
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edda360a3c370e5fbe036ae55c9b16cd37a58486..d516c1d721ba500c9ab5dcf36a24a693003bb794 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2964,7 +2964,7 @@ static int cmp_subprogs(const void *a, const void *b)
 }
 
 /* Find subprogram that contains instruction at 'off' */
-static struct bpf_subprog_info *find_containing_subprog(struct bpf_verifier_env *env, int off)
+struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *vals = env->subprog_info;
 	int l, r, m;
@@ -2989,7 +2989,7 @@ static int find_subprog(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *p;
 
-	p = find_containing_subprog(env, off);
+	p = bpf_find_containing_subprog(env, off);
 	if (!p || p->start != off)
 		return -ENOENT;
 	return p - env->subprog_info;
@@ -4196,7 +4196,7 @@ static void fmt_reg_mask(char *buf, ssize_t buf_sz, u32 reg_mask)
 	}
 }
 /* format stack slots bitmask, e.g., "-8,-24,-40" for 0x15 mask */
-static void fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
+void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
 {
 	DECLARE_BITMAP(mask, 64);
 	bool first = true;
@@ -4251,8 +4251,6 @@ static void bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_histo
 	}
 }
 
-static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
-
 /* For given verifier state backtrack_insn() is called from the last insn to
  * the first insn. Its purpose is to compute a bitmask of registers and
  * stack slots that needs precision in the parent verifier state.
@@ -4279,7 +4277,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_reg_mask(bt));
 		verbose(env, "mark_precise: frame%d: regs=%s ",
 			bt->frame, env->tmp_str_buf);
-		fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
+		bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
 		verbose(env, "stack=%s before ", env->tmp_str_buf);
 		verbose(env, "%d: ", idx);
 		verbose_insn(env, insn);
@@ -4480,7 +4478,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 * backtracking, as these registers are set by the function
 			 * invoking callback.
 			 */
-			if (subseq_idx >= 0 && calls_callback(env, subseq_idx))
+			if (subseq_idx >= 0 && bpf_calls_callback(env, subseq_idx))
 				for (i = BPF_REG_1; i <= BPF_REG_5; i++)
 					bt_clear_reg(bt, i);
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
@@ -4919,7 +4917,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env,
 					     bt_frame_reg_mask(bt, fr));
 				verbose(env, "mark_precise: frame%d: parent state regs=%s ",
 					fr, env->tmp_str_buf);
-				fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
+				bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
 					       bt_frame_stack_mask(bt, fr));
 				verbose(env, "stack=%s: ", env->tmp_str_buf);
 				print_verifier_state(env, st, fr, true);
@@ -11008,7 +11006,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 					       "At callback return", "R0");
 			return -EINVAL;
 		}
-		if (!calls_callback(env, callee->callsite)) {
+		if (!bpf_calls_callback(env, callee->callsite)) {
 			verifier_bug(env, "in callback at %d, callsite %d !calls_callback",
 				     *insn_idx, callee->callsite);
 			return -EFAULT;
@@ -17273,7 +17271,7 @@ static void mark_subprog_changes_pkt_data(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *subprog;
 
-	subprog = find_containing_subprog(env, off);
+	subprog = bpf_find_containing_subprog(env, off);
 	subprog->changes_pkt_data = true;
 }
 
@@ -17281,7 +17279,7 @@ static void mark_subprog_might_sleep(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *subprog;
 
-	subprog = find_containing_subprog(env, off);
+	subprog = bpf_find_containing_subprog(env, off);
 	subprog->might_sleep = true;
 }
 
@@ -17295,8 +17293,8 @@ static void merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
 {
 	struct bpf_subprog_info *caller, *callee;
 
-	caller = find_containing_subprog(env, t);
-	callee = find_containing_subprog(env, w);
+	caller = bpf_find_containing_subprog(env, t);
+	callee = bpf_find_containing_subprog(env, w);
 	caller->changes_pkt_data |= callee->changes_pkt_data;
 	caller->might_sleep |= callee->might_sleep;
 }
@@ -17366,7 +17364,7 @@ static void mark_calls_callback(struct bpf_verifier_env *env, int idx)
 	env->insn_aux_data[idx].calls_callback = true;
 }
 
-static bool calls_callback(struct bpf_verifier_env *env, int insn_idx)
+bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx)
 {
 	return env->insn_aux_data[insn_idx].calls_callback;
 }
@@ -19414,7 +19412,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 					goto hit;
 				}
 			}
-			if (calls_callback(env, insn_idx)) {
+			if (bpf_calls_callback(env, insn_idx)) {
 				if (states_equal(env, &sl->state, cur, RANGE_WITHIN))
 					goto hit;
 				goto skip_inf_loop_check;
@@ -24140,7 +24138,7 @@ static bool can_jump(struct bpf_insn *insn)
 	return false;
 }
 
-static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
+int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
 {
 	struct bpf_insn *insn = &prog->insnsi[idx];
 	int i = 0, insn_sz;
@@ -24356,7 +24354,7 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 			u16 new_out = 0;
 			u16 new_in = 0;
 
-			succ_num = insn_successors(env->prog, insn_idx, succ);
+			succ_num = bpf_insn_successors(env->prog, insn_idx, succ);
 			for (int s = 0; s < succ_num; ++s)
 				new_out |= state[succ[s]].in;
 			new_in = (new_out & ~live->def) | live->use;
@@ -24525,7 +24523,7 @@ static int compute_scc(struct bpf_verifier_env *env)
 				stack[stack_sz++] = w;
 			}
 			/* Visit 'w' successors */
-			succ_cnt = insn_successors(env->prog, w, succ);
+			succ_cnt = bpf_insn_successors(env->prog, w, succ);
 			for (j = 0; j < succ_cnt; ++j) {
 				if (pre[succ[j]]) {
 					low[w] = min(low[w], low[succ[j]]);

-- 
2.51.0

