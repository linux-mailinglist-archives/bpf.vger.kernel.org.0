Return-Path: <bpf+bounces-52853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 213D6A49149
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 07:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A9616FB6F
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 06:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5936E1C3F2B;
	Fri, 28 Feb 2025 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5OX2kXw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ACF1C3BE1
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 06:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740722460; cv=none; b=YWlLUmpXLgodhM3BBHCgSF1LivK8smddMqjgw+SgOiuys0iGO2WbFZvt1IDgqMPeG6JWjt8p0JhvmiGSd/RPdqS7tflQQZJ+MA2jmYpFfAftMqPWU6GqQgqMWMReoXOHHbtlDFoSjQf7VkfKxcqGQ72sFRO16SCs6X2hVNm7AnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740722460; c=relaxed/simple;
	bh=9CYslLjGQj+pYtFp2Y22d5m/fi+jgtYrKY2pqufWRnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWlnOViQ21q7xMwGO1u+RFej6H57fZBIWt55JXZjebsSDWi7foBYD4cDLTgoKBdKGIEkK/25WChcPv+uLBDN5loAq4ywYs+5j8zRluILleuXXEafgPrQFRKBgO9489Sf/F/zEPq5A/pYQzBKAnaH6Uzyppl989pg5bvfbT//VGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5OX2kXw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2211cd4463cso33467245ad.2
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 22:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740722458; x=1741327258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btYRi5/ZVgLv727boAqtCDIhTa5Idkq92tTUfjiDweU=;
        b=K5OX2kXwEeNxdwjABqIEbRKNgubRsa6kwCRM+wEKsJvaEq1BxVc4xQFxweggsFNW5x
         Z56B1ijPaWjEZlED6Wax3gJ3wJPZTktzPMU5+LR7vDIeK+A3OEtKkE2cGx2w7EVNmZyg
         OgdyjqHtQRqRY8rqs+ukJxnPNCVA9nIzOJlwx4yjBQOk+MJt13PN5wU5cAbdJtevDl1x
         999Z7StiQU1Rp/bZ0EmaUPXKTtkot7p5QsC0l/nBlITb3gWTnWDNW0eQRFLyt8KbyLJP
         GFAprpwPI87HkLP56itdiVUK5QCNX6pvuFAaCCQyXRm73/cTVThySxckCMirwo+j0ST5
         bcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740722458; x=1741327258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btYRi5/ZVgLv727boAqtCDIhTa5Idkq92tTUfjiDweU=;
        b=QgJyDFdGEzdAGqRAONThZ3SmJZnedgZ0GwFyEIn/4ZYEopJ5FOzU2LTb547TQ87ROn
         1isZ5ySmuuuSOTPaSR28DI1MSuR42xpZkjRWpJNsRQsXe37+aufwZji3ilV5r2vV3WSM
         rDkT8VJpL7H2LmVB1FGbT+kabhjyjVeETN7lM3+xi/yrw20FnBgREjspX7wUVokC+LnV
         Sp/R9b+YJOazWVHeBzbsCOlWjGgFuCL9zLZnvzbGzN4iHaKsKDibzW8NbwPV3DAvBS+o
         6QgoIrCjAdlvtG6yLMAXxrI86Y1tj3zOfVIZ5PEK55lvoMC5fjlnQDz9c74vSUptbl1Z
         JmGA==
X-Gm-Message-State: AOJu0YwzkdWTo5iFX64PB+pZiiK+7ij+EvdgnMQnbFAfc5aLzd/uydmw
	nY2dDxJ/iTMlRza2lEXojwbi41sXBNRJqNnixvpi/lphJ9QUw12qGTliXA==
X-Gm-Gg: ASbGncslVlIwKQbNKHs1tyGXO8lnNS+lBpJkqGb71t8zuxDwB8hiICC6iLVWplsSNFj
	lQKjn6HmzBjrO4ObSArZMSeHLrEWkH3jwmS5sxOxETRbg6/HofZbOhrKlA/mntEiZ/AadMYr9nr
	R+nDnBJ3GEbF7NHZ0Zx5R5/pUjzC5+Qw7thOWVPcXYjtBW+vcM/ssKRIGRN3DBpS1hxcNu8UlmG
	TrDfiQaWno8mPRG09FL98sG84O1H5+wTNIP+ZiFdt+Qw3+WqYeHT4aPqh6V4tfXuduSNzRuNn/O
	RY6L8nGTJ7rxl8YhIXXQwg==
X-Google-Smtp-Source: AGHT+IFCkqe5Su3A/KszaXIJ3glBVbR1cCalBrCaui+hJxckXoNCJNw/TOlxgc16IBYFiZPES3ZaBg==
X-Received: by 2002:a05:6a20:4308:b0:1ee:e46d:58b3 with SMTP id adf61e73a8af0-1f2f4c90419mr2969886637.4.1740722458220;
        Thu, 27 Feb 2025 22:00:58 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003eb97sm2927018b3a.148.2025.02.27.22.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 22:00:57 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 2/3] bpf: use register liveness information for func_states_equal
Date: Thu, 27 Feb 2025 22:00:31 -0800
Message-ID: <20250228060032.1425870-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228060032.1425870-1-eddyz87@gmail.com>
References: <20250228060032.1425870-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Liveness analysis DFA computes a set of registers that are live before
each instruction. Leverage this information to skip the comparison of
dead registers in `func_states_equal()`. This helps with the
convergence of iterator-based loops, as `bpf_reg_state->live` marks
can't be used when loops are processed. For now, enable this only in
privileged mode.

Verification performance impact on selftests and sched_ext is listed
below. (Using `veristat -C -f "insns_pct>5" -f "!insns<200"` filters).

selftests:

File                  Program                        Insns (A)  Insns (B)  Insns     (DIFF)  States (A)  States (B)  States  (DIFF)
--------------------  -----------------------------  ---------  ---------  ----------------  ----------  ----------  --------------
arena_htab_asm.bpf.o  arena_htab_asm                       445        413      -32 (-7.19%)          37          33    -4 (-10.81%)
arena_list.bpf.o      arena_list_add                      1822        833    -989 (-54.28%)          37          22   -15 (-40.54%)
dynptr_success.bpf.o  test_dynptr_copy                     267        203     -64 (-23.97%)          22          16    -6 (-27.27%)
dynptr_success.bpf.o  test_dynptr_copy_xdp                 719        615    -104 (-14.46%)          68          58   -10 (-14.71%)
iters.bpf.o           checkpoint_states_deletion         22154       1211  -20943 (-94.53%)         918          40  -878 (-95.64%)
iters.bpf.o           clean_live_states                   1348        588    -760 (-56.38%)         136          66   -70 (-51.47%)
iters.bpf.o           iter_nested_deeply_iters             367        300     -67 (-18.26%)          43          37    -6 (-13.95%)
iters.bpf.o           iter_nested_iters                    772        632    -140 (-18.13%)          72          62   -10 (-13.89%)
iters.bpf.o           iter_pass_iter_ptr_to_subprog        285        243     -42 (-14.74%)          30          26    -4 (-13.33%)
iters.bpf.o           iter_subprog_iters                   808        664    -144 (-17.82%)          68          59    -9 (-13.24%)
iters.bpf.o           loop_state_deps2                     356        321      -35 (-9.83%)          35          32     -3 (-8.57%)
iters_css.bpf.o       iter_css_for_each                    296        267      -29 (-9.80%)          32          29     -3 (-9.38%)
pyperf600_iter.bpf.o  on_event                            6379       2591   -3788 (-59.38%)         286         192   -94 (-32.87%)
test_usdt.bpf.o       usdt12                              1983       1803     -180 (-9.08%)         143         136     -7 (-4.90%)

sched_ext:

File               Program                 Insns (A)  Insns (B)  Insns     (DIFF)  States (A)  States (B)  States   (DIFF)
-----------------  ----------------------  ---------  ---------  ----------------  ----------  ----------  ---------------
bpf.bpf.o          lavd_dispatch              154608     120590  -34018 (-22.00%)        8950        7065  -1885 (-21.06%)
bpf.bpf.o          lavd_init                    7330       6935     -395 (-5.39%)         516         480     -36 (-6.98%)
bpf.bpf.o          layered_dispatch             9039       5590   -3449 (-38.16%)         662         501   -161 (-24.32%)
bpf.bpf.o          layered_dump                 5022       3669   -1353 (-26.94%)         298         237    -61 (-20.47%)
bpf.bpf.o          layered_init                 5549       4298   -1251 (-22.54%)         523         423   -100 (-19.12%)
bpf.bpf.o          layered_init_task             270        234     -36 (-13.33%)          24          22      -2 (-8.33%)
bpf.bpf.o          layered_runnable             1899       1635    -264 (-13.90%)         151         125    -26 (-17.22%)
bpf.bpf.o          p2dq_dispatch                 659        533    -126 (-19.12%)          66          53    -13 (-19.70%)
bpf.bpf.o          p2dq_init                    1936       1560    -376 (-19.42%)         170         142    -28 (-16.47%)
bpf.bpf.o          refresh_layer_cpumasks       1285        785    -500 (-38.91%)         120          78    -42 (-35.00%)
bpf.bpf.o          rustland_init                 476        413     -63 (-13.24%)          37          34      -3 (-8.11%)
bpf.bpf.o          rustland_init                 476        413     -63 (-13.24%)          37          34      -3 (-8.11%)
bpf.bpf.o          rusty_select_cpu             1386       1110    -276 (-19.91%)         125         108    -17 (-13.60%)
bpf.bpf.o          rusty_set_cpumask            4558       4276     -282 (-6.19%)         323         313     -10 (-3.10%)
scx_central.bpf.o  central_dispatch              600        422    -178 (-29.67%)          59          43    -16 (-27.12%)
scx_central.bpf.o  central_init                  632        318    -314 (-49.68%)          39          28    -11 (-28.21%)
scx_nest.bpf.o     nest_init                     601        519     -82 (-13.64%)          58          51     -7 (-12.07%)
scx_pair.bpf.o     pair_dispatch                1914       1376    -538 (-28.11%)         142         111    -31 (-21.83%)
scx_qmap.bpf.o     qmap_dispatch                2187       1703    -484 (-22.13%)         174         141    -33 (-18.97%)
scx_qmap.bpf.o     qmap_init                   22777      18458   -4319 (-18.96%)         768         654   -114 (-14.84%)

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 8c23958bc471..39097835b326 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -733,6 +733,7 @@ struct bpf_verifier_env {
 	 * to writes with variable offset and to indirect (helper) accesses.
 	 */
 	bool allow_uninit_stack;
+	bool allow_liveregs_dfa;
 	bool bpf_capable;
 	bool bypass_spec_v1;
 	bool bypass_spec_v4;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ac7dc58d9b1..b6ab49ee31e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18358,15 +18358,20 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
  * the current state will reach 'bpf_exit' instruction safely
  */
 static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			      struct bpf_func_state *cur, enum exact_level exact)
+			      struct bpf_func_state *cur, u32 insn_idx, enum exact_level exact)
 {
-	int i;
+	u16 live_regs;
+	u16 i;
 
 	if (old->callback_depth > cur->callback_depth)
 		return false;
 
+	live_regs = env->allow_liveregs_dfa
+		    ? env->insn_aux_data[insn_idx].live_regs_before
+		    : 0xffff;
 	for (i = 0; i < MAX_BPF_REG; i++)
-		if (!regsafe(env, &old->regs[i], &cur->regs[i],
+		if ((BIT(i) & live_regs) &&
+		    !regsafe(env, &old->regs[i], &cur->regs[i],
 			     &env->idmap_scratch, exact))
 			return false;
 
@@ -18387,6 +18392,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 			 struct bpf_verifier_state *cur,
 			 enum exact_level exact)
 {
+	u32 insn_idx;
 	int i;
 
 	if (old->curframe != cur->curframe)
@@ -18410,9 +18416,12 @@ static bool states_equal(struct bpf_verifier_env *env,
 	 * and all frame states need to be equivalent
 	 */
 	for (i = 0; i <= old->curframe; i++) {
+		insn_idx = i == old->curframe
+			   ? env->insn_idx
+			   : old->frame[i + 1]->callsite;
 		if (old->frame[i]->callsite != cur->frame[i]->callsite)
 			return false;
-		if (!func_states_equal(env, old->frame[i], cur->frame[i], exact))
+		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx, exact))
 			return false;
 	}
 	return true;
@@ -23647,6 +23656,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		ret = compute_live_registers(env);
 		if (ret < 0)
 			goto skip_full_check;
+		env->allow_liveregs_dfa = true;
 	}
 
 	ret = mark_fastcall_patterns(env);
-- 
2.48.1


