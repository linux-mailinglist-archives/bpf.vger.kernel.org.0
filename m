Return-Path: <bpf+bounces-20891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A33C1845021
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9691C23126
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CE13BB2A;
	Thu,  1 Feb 2024 04:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5uAY5OJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C413B78D
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761278; cv=none; b=tFqVq0hE4SN8VRQS+WXMQ7bMOKLxxMvym9O2iAgPNPJeX24fXCNe4olkSbA5ZCsgHw+v7ryKWL8AMR5GawKoIjA0kjroCRdlKO8KKSHMUjN/yOpPxEyuWBEwGx7HGFMxqqc8x70YoqeP+N6Mg1HqRY8LNgFvMKJBwhBDzugyJ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761278; c=relaxed/simple;
	bh=hEYvcM4+e5mMwgHu/M6fr5pKvJ2Q6QC5ZxpvtZXZr7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z/54crkQbnuZMe0LIoQ5Nkn/k4GoUkZ0YSaYeXiMULf4FwKx0MxsBGZ2cBD+YSPpMKaSi3JtToQ5XyeQ970nDUu5tuRFZpsD/6k4lZ9GOWCgI9woJgtyszdm1XqYxd8dIBZkvAjeM2MN0bFy0gg0r3unebielvIqUjGnKZOFtNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5uAY5OJ; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso605971a12.0
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706761274; x=1707366074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KogAFSQ6rYjm7jb5WlDa4cAynBRb/EBeu6/yjS/jYLA=;
        b=N5uAY5OJwod921gzF8xTwghR6QY1wa1lcWcAyg3ozO2mg/oB06M69Yt5v7uZR0/sxd
         WG+snkwA7ACqopiK5jjQQKeokz9p4+VqHaBZ1WP+ZItlOuFP7t2CjqZVZmVsFP8m2jD8
         ynrUc+puQwlORGbKenrW9jfbA3WpHoJHdsH5r391Pq9X2w34K/dAZix75pWO8Yuy4xOu
         OgckYPnfgUFfs9Z4ob0vapjVyBiWedeMQ29AGn5+4Z5hUFcJGQOFzLcGUnvmHBoHy8wW
         zIzSbvUzgWXC/dwDanF9axEdOD3bUyq0D9/UkDv/XeDPxVwFe17Y2RcQvzQFuVAA2cg4
         zzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761274; x=1707366074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KogAFSQ6rYjm7jb5WlDa4cAynBRb/EBeu6/yjS/jYLA=;
        b=pQoGuBDRezPZAZFR/JJrIMmBdVgT0Cecpsdd3nSNdDKyEIaW28ixoIinIuwTe2uZea
         l3qEg8eALXXNCSA+PrewDO8LuZ8F9dVkbQsmqGhFdKADkdxHdQiDWitiz6mETwmNrIJ9
         KFsYedqDbM8HGhM+ZVtwl4YXYfSmogJUHX5wG7luNcTUKBTi7KJMe2H5vBR9fhQkjoT9
         fEO6frM8+USA11LvoW4uYdhEmiqnB4l8cWBOSnElP4QF9Wcn1T3sdmCGQmZjwBaxe8Ju
         5N+lstbMCGGPz47KJKP+0LK3tmtxBYFFXyeHb+u3MiAt3c4NTyyI4ZWr28OowoexxLZ1
         JgOw==
X-Gm-Message-State: AOJu0YyadvidJDGHc1rpdBgoQKAiEpcHJL/Hve59Jn6FEto1aw7ieTvI
	hifDMd+gOzALqlPfEf2H6ObEI5UTRf74tnJV1EE/oRDSYRdq2SitCFFwRanJSco=
X-Google-Smtp-Source: AGHT+IERPIYZuyTYYvvoTFNr8wLdOE2AsNaNHcrqIeZBCdTGsd0SGmWsLMNVRwJ6o3C/wZosteZm6Q==
X-Received: by 2002:a05:6402:60a:b0:55f:4602:bf7d with SMTP id n10-20020a056402060a00b0055f4602bf7dmr2442058edv.26.1706761274066;
        Wed, 31 Jan 2024 20:21:14 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id b4-20020a056402138400b0055f2e703b52sm2653518edv.33.2024.01.31.20.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 20:21:13 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	Raj Sahu <rjsu26@vt.edu>,
	Dan Williams <djwillia@vt.edu>,
	Rishabh Iyer <rishabh.iyer@epfl.ch>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [RFC PATCH v1 02/14] bpf: Process global subprog's exception propagation
Date: Thu,  1 Feb 2024 04:20:57 +0000
Message-Id: <20240201042109.1150490-3-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201042109.1150490-1-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5104; i=memxor@gmail.com; h=from:subject; bh=hEYvcM4+e5mMwgHu/M6fr5pKvJ2Q6QC5ZxpvtZXZr7E=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBluxwM/i/OmtJvvXOj8D85wSqhw344HLfCrxryb JGh92eQOcGJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZbscDAAKCRBM4MiGSL8R yh8+D/9hiK/05rQE7XTTTHt499WIh6e2jOaSD5Me+DJY7RMHrcWusB0w+wIVNohUHwGSXS0ffkq kaYoWbuHzLZCM3nCcOxdBACtSfxapTZLyYdyGuYa3qDHW8WHmZqWY5sr36E7Q+s0H5+JbMcYwXi Z04KfQzpyo92o1v1ZMrhYD9UxWmF15GcNEq3YEnUfp/RCPvbNEP6sz0zUkLSLttpT1B0zhBQxbb 5tE0nSrPqc9UniknJLD9JvsjimF1KtP4n6e23MpfvR+4scZ5ll3ZK6fyeRAO+HOxNg/DjoMxHiH urHHKwxqjcCBhDajFEjVsxiKQskGDqbtCtlkxLjrJ35xr4vg20u70MEgsdro3R0LNGuwV1TNIAX gH4yQcecWHfMMB38zhJIWELdtlqxEoCeWjv/i5hOIcCWsG8MvWZaFqJtupZa0dV/3xSGbsFlNKC QDp5LVH1nYm5Geq8IH7LMMbDW1ct8ng8UyJxhOTegsbEwUeydpZfxKD2B63BN4v3z/CjonT6fne LRN3jdY7hC132YM4UhJk8ifZKNqC14soeLYXg3BeV+oFcI6Y6qjqdXcRweGis9IYjKIRs5zcfPh MmezqQRXpsrFtUKhmOLc+la5+doLHgyQspcbv2T2yjYZuNOTwnzS2W9f0YKyWh9LAiHEQiDPUn3 ssItqeSaaOTN39A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Global subprogs are not descended during symbolic execution, but we
summarized whether they can throw an exception (reachable from another
exception throwing subprog) in mark_exception_reachable_subprogs added
by the previous patch.

We must now ensure that we explore the path of the program where
invoking the call instruction leads to an exception being thrown, so
that we can correctly reject programs where it is not permissible to
throw an exception.  For instance, it might be permissible to throw from
a global subprog, but its caller may hold references. Without this
patch, the verifier will accept such programs.

To do this, we use push_stack to push a separate branch into the branch
stack of the verifier, with the same current and previous insn_idx.
Then, we set a bit in the verifier state of the branch to indicate that
the next instruction it will process is of a global subprog call which
will throw an exception. When we encounter this instruction, this bit
will be cleared.

Special care must be taken to update the state pruning logic, as without
any changes, it is possible that we end up pruning when popping the
exception throwing state for exploration. Therefore, while we can never
have the 'global_subprog_call_exception' bit set in the verifier state
of an explored state, we will see it in the current state, and use this
to reject pruning requests and continue its exploration.

Note that we process the exception after processing the call
instruction, similar to how we do a process_bpf_exit_full jump in case
of bpf_throw kfuncs.

Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1d666b6c21e6..5482701e6ad9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -426,6 +426,7 @@ struct bpf_verifier_state {
 	 * while they are still in use.
 	 */
 	bool used_as_loop_entry;
+	bool global_subprog_call_exception;
 
 	/* first and last insn idx of this verifier state */
 	u32 first_insn_idx;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bba53c4e3a0c..622c638b123b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1418,6 +1418,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->dfs_depth = src->dfs_depth;
 	dst_state->callback_unroll_depth = src->callback_unroll_depth;
 	dst_state->used_as_loop_entry = src->used_as_loop_entry;
+	dst_state->global_subprog_call_exception = src->global_subprog_call_exception;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
@@ -9497,6 +9498,15 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 		verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
 			subprog, sub_name);
+		if (subprog_info(env, subprog)->is_throw_reachable && !env->cur_state->global_subprog_call_exception) {
+			struct bpf_verifier_state *branch = push_stack(env, env->insn_idx, env->prev_insn_idx, false);
+
+			if (!branch) {
+				verbose(env, "verifier internal error: cannot push branch to explore exception of global subprog\n");
+				return -EFAULT;
+			}
+			branch->global_subprog_call_exception = true;
+		}
 		/* mark global subprog for verifying after main prog */
 		subprog_aux(env, subprog)->called = true;
 		clear_caller_saved_regs(env, caller->regs);
@@ -9505,6 +9515,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		mark_reg_unknown(env, caller->regs, BPF_REG_0);
 		caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
 
+		if (env->cur_state->global_subprog_call_exception)
+			verbose(env, "Func#%d ('%s') may throw exception, exploring program path where exception is thrown\n",
+				subprog, sub_name);
 		/* continue with next insn after call */
 		return 0;
 	}
@@ -16784,6 +16797,10 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->active_rcu_lock != cur->active_rcu_lock)
 		return false;
 
+	/* Prevent pruning to explore state where global subprog call throws an exception. */
+	if (cur->global_subprog_call_exception)
+		return false;
+
 	/* for states to be equal callsites have to be the same
 	 * and all frame states need to be equivalent
 	 */
@@ -17675,6 +17692,11 @@ static int do_check(struct bpf_verifier_env *env)
 				}
 				if (insn->src_reg == BPF_PSEUDO_CALL) {
 					err = check_func_call(env, insn, &env->insn_idx);
+					if (!err && env->cur_state->global_subprog_call_exception) {
+						env->cur_state->global_subprog_call_exception = false;
+						exception_exit = true;
+						goto process_bpf_exit_full;
+					}
 				} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 					err = check_kfunc_call(env, insn, &env->insn_idx);
 					if (!err && is_bpf_throw_kfunc(insn)) {
-- 
2.40.1


