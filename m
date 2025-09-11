Return-Path: <bpf+bounces-68068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58640B52574
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 03:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9C77B4E4C
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 01:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2543D1EE02F;
	Thu, 11 Sep 2025 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTgWybsu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E5F1C5D6A
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552697; cv=none; b=hKOEOBxMIn8VQVwcliiufZ7Y3fy2+t2pAY8v5tnjyYVF/r21zkdUhulVVmJZbdfB1jVXNCaFpvH8l8McUutkZWi1plbUj0nToYg7TNlxVnc2KjENZpA2m3hCmDUv3c2YxzQNB7DTJ1hxjbYImY6W9EZDZmJVNUTbuUXjEb36mZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552697; c=relaxed/simple;
	bh=Aqf8kVj6/ARTecvAWCs3T5EcF7oLaN0nwZQyccE6RTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKRHUHlWr69lUG4txHR/7+xIl6ohd9I1uxQvp7Ijn9aH1uVcyT5KTfIrKy/4/5qPvG/D3xyIYrlud3MT0zzxFsHONmpceXPL/c0B/6MsdOhdJRp0h/WSqdlETVj5Y/SGLlPxIUXhAx3pLSkPM4akZDvEGy/IpfR4FT0gpZXQ/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTgWybsu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24457f581aeso1218425ad.0
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 18:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757552695; x=1758157495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D+k/D6ELZ0ObojklHlhvYn817RTBkOBY2dyUZggU0s=;
        b=GTgWybsueVDU83hAzuEuxfHmf53+Koz+/u3lyCX5N4a3xBsAxs83IuPXDTSrAVtxHf
         Wnv8GQpdyKt2REyuaI/enGFz1teB+7nTRFm52tXp7zbBeznhnEuXkZn1TvD8EjOx2mX/
         h1V2ezjEJFRSHYI7umNgPBmQbgfnYVrbmLKSwiMDVsCo9Zgwp58DDubidfZqiYJHD7cx
         M6n4OKRMC4B6nJ9+zIaZkw50KDEt25lwxQG0GhkQVp7yVGfa0UIDOxCTKDVLJEHMYYnS
         RVEHXASgroxC77Y99Dvpy9lrnzsDtlbxRT+zZvb2MoA1/lAAsUYg/CjY1WLHnmX5Bgi1
         QoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757552695; x=1758157495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D+k/D6ELZ0ObojklHlhvYn817RTBkOBY2dyUZggU0s=;
        b=hPWF7ovooSCK/QndXj6jnJwYKjFnRZPWhrqcPMhm3XzJ8Gvu+F9mHUael+SJP6ePra
         iOkxF+wmVaYR+Qq9OUtgktybFEbZBjLqyRf9bRRs/xI9aWubgjkj6mu8axA1/6wjP864
         THcIWhqH/mXnkcqKk/AkYOuwhgmfcM8uijxWytoJNIdpiEou6aDowXFbR7obkLEDE47Z
         z5cuvV5oHcv+IpNRi8Va7DMckRMzJm8J7MiUIAB8lfymTieG2RxKwJA+wNALnzpVz/x6
         k+GKRQkS55qlrbcw/+TXsQMDAL/+nJDFGk5nOcLGiP4ELpTn//GOnDQwjrA1g3GoP11k
         B4BQ==
X-Gm-Message-State: AOJu0YyLJZQecovcdRo1qwTA7bN2drWYmho/xJftMzb1DTd8noTPdM57
	DIcdJt5IP8x1D7FWTgQygDG6UjfiZk4epfN9J+PHH4WlTsXJGnYQ3dYq0mJA5A==
X-Gm-Gg: ASbGncu7E4VbhxlHKQw3hmJGgB5K8p0wiDu10tOc6lQZ8PY2ofPPreJunM2alzHNy51
	xjGVldyE1KpZqlGv3ZKoWXTBEmqL+a5TFBUiG1G3m9IfQgzS4RJkyZHTAXkdAZTzZJjJRV0VTN7
	EqKcvgTWuYdjv48Qpv2CMXXn91fVhc8IRGnwq2VZAHtQPdiOR16X04VQDTz7nJYh9OB7oX564xJ
	NZJB+nx+rI1tShSZWH5GvexuPu/Sq5qmxe0BCyIEAJYxBKyjae0VX3hrFQD/f5vmtuHF234WWNT
	yPGQhLTRkhbrUmbJCv7QG24imj32R1DzH7tGqOO0qf3VEWD2ksJEsOJVuokLOfXm54OMbIe5NSB
	WanwjgzRLP9G7OnJuzEiB2YpMK6oKhscLH6kr8XMAX0LN
X-Google-Smtp-Source: AGHT+IHMFVFXTGrDVd9x5858ClA+Gk2DWA83ey2KUBnYUZZWILbffdfIN3GcvNxLKe0VYjy7GhV1/A==
X-Received: by 2002:a17:902:dac6:b0:250:de70:cf9c with SMTP id d9443c01a7336-25174ff62d3mr242970875ad.47.1757552695105;
        Wed, 10 Sep 2025 18:04:55 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd61eaa27sm545511a91.1.2025.09.10.18.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:04:54 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 04/10] bpf: declare a few utility functions as internal api
Date: Wed, 10 Sep 2025 18:04:29 -0700
Message-ID: <20250911010437.2779173-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911010437.2779173-1-eddyz87@gmail.com>
References: <20250911010437.2779173-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
index ac16da8b49dc..93563564bde5 100644
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
index 8673b955a6cd..5658e1e1d5c5 100644
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
@@ -11004,7 +11002,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 					       "At callback return", "R0");
 			return -EINVAL;
 		}
-		if (!calls_callback(env, callee->callsite)) {
+		if (!bpf_calls_callback(env, callee->callsite)) {
 			verifier_bug(env, "in callback at %d, callsite %d !calls_callback",
 				     *insn_idx, callee->callsite);
 			return -EFAULT;
@@ -17269,7 +17267,7 @@ static void mark_subprog_changes_pkt_data(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *subprog;
 
-	subprog = find_containing_subprog(env, off);
+	subprog = bpf_find_containing_subprog(env, off);
 	subprog->changes_pkt_data = true;
 }
 
@@ -17277,7 +17275,7 @@ static void mark_subprog_might_sleep(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *subprog;
 
-	subprog = find_containing_subprog(env, off);
+	subprog = bpf_find_containing_subprog(env, off);
 	subprog->might_sleep = true;
 }
 
@@ -17291,8 +17289,8 @@ static void merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
 {
 	struct bpf_subprog_info *caller, *callee;
 
-	caller = find_containing_subprog(env, t);
-	callee = find_containing_subprog(env, w);
+	caller = bpf_find_containing_subprog(env, t);
+	callee = bpf_find_containing_subprog(env, w);
 	caller->changes_pkt_data |= callee->changes_pkt_data;
 	caller->might_sleep |= callee->might_sleep;
 }
@@ -17362,7 +17360,7 @@ static void mark_calls_callback(struct bpf_verifier_env *env, int idx)
 	env->insn_aux_data[idx].calls_callback = true;
 }
 
-static bool calls_callback(struct bpf_verifier_env *env, int insn_idx)
+bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx)
 {
 	return env->insn_aux_data[insn_idx].calls_callback;
 }
@@ -19410,7 +19408,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 					goto hit;
 				}
 			}
-			if (calls_callback(env, insn_idx)) {
+			if (bpf_calls_callback(env, insn_idx)) {
 				if (states_equal(env, &sl->state, cur, RANGE_WITHIN))
 					goto hit;
 				goto skip_inf_loop_check;
@@ -24136,7 +24134,7 @@ static bool can_jump(struct bpf_insn *insn)
 	return false;
 }
 
-static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
+int bpf_insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
 {
 	struct bpf_insn *insn = &prog->insnsi[idx];
 	int i = 0, insn_sz;
@@ -24352,7 +24350,7 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 			u16 new_out = 0;
 			u16 new_in = 0;
 
-			succ_num = insn_successors(env->prog, insn_idx, succ);
+			succ_num = bpf_insn_successors(env->prog, insn_idx, succ);
 			for (int s = 0; s < succ_num; ++s)
 				new_out |= state[succ[s]].in;
 			new_in = (new_out & ~live->def) | live->use;
@@ -24521,7 +24519,7 @@ static int compute_scc(struct bpf_verifier_env *env)
 				stack[stack_sz++] = w;
 			}
 			/* Visit 'w' successors */
-			succ_cnt = insn_successors(env->prog, w, succ);
+			succ_cnt = bpf_insn_successors(env->prog, w, succ);
 			for (j = 0; j < succ_cnt; ++j) {
 				if (pre[succ[j]]) {
 					low[w] = min(low[w], low[succ[j]]);
-- 
2.47.3


