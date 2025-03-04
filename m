Return-Path: <bpf+bounces-53231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8DEA4EDE5
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 20:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE4F3AEF61
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 19:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1331277035;
	Tue,  4 Mar 2025 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRqpHElg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64612673BA
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117850; cv=none; b=nma9TxvkxLsqgM/4EcVE0RZsR7zkeJdC+V/fFBo5KUrHagNmD/3dEkiJS27HcMxRka8D/v0LGekE4cBQce1Y5+QWqqRn1R86IBPYyE/jlqPRrP6kZO/kc6t5+CTlXakIE2uKqbUOw9z/V1KiZIu3iVFMOMf96MroWNLHrfdRLm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117850; c=relaxed/simple;
	bh=bdK1a6w4IspygRnEUmoh3NEzHbpFJTWAuHGgoK8xrhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WI0aNm3+ta0PThAIIKbH4YNDtLJebA3W77KfoBR7ysF02Y5Fi9I3t6j6z+8e6eiOU/6hIwDU0Ftf9u+ZEdT47kqTfJW6bg5DVl5KL5Yvn2NFEaOeN27mc1ik7Cp44DFrprBqELvIKrmcKqFMEApch3WP/QS28RKOjDKQEVm/wlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRqpHElg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223a3c035c9so2190485ad.1
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741117848; x=1741722648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEYeXqxPPHDC+QxBWGbAgIZnDp1R2nCkSmg4EaCF6+g=;
        b=kRqpHElgVH6eFnvIi2A4QkpIdJjoPB+gdF4YR4kvixeyMJsHE41g6j2Qr0H2jK9UgO
         Dcc4Kuw1og1TVZB4WOc/8rsv7+RXD8seFSSsyfLkB4IvN1xcVwPuAYvbEppNEbL+hmok
         TI2B1xCx8Ft4Rr7ukrysIMq/f2/evNosjPIaHc+MfLbMcvsDzSF3yxwZuWQ4+Xd98IC3
         0+O88g0yOLzLgtIT2RuuFkYnOxJm1GhyRqzpf+la+TEPgwKE0SGRbgxmOcuxg2/YROrY
         mbUGQytok2P/aI8XsyViCkGr9H5lYJMnRXUeLMTqhqw05uaWNT6BwTJx2DsDoWqP8mcJ
         DKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117848; x=1741722648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEYeXqxPPHDC+QxBWGbAgIZnDp1R2nCkSmg4EaCF6+g=;
        b=fNyiSX2ESjUgV0uKpq/578oX2qkC4vF3S+mEZWErZsGcA94HWAROrb99CUA7F8ckip
         Zu/wyrtE/k9gxHd7YWxBIFQ3J0bibVcfxZM1crTApz8vElmwhfV9vl5NuFhEjnO2krwo
         1vhd893b97mFH3Umh6KzLDrBAz5BnblqA/1SAsbXf65zmgA3UOsygPMKil82fqqXSHsg
         xgJxKaA0MXxYh/TBM9e9AR8d4tikxJ9ACsxNjxHfv2lXVUn8TlmPF4KrmYDeMLu+37GW
         H9/UDvyVMQ/IkiSdTYUC8KxOUWkp3xyAQDudUtW3q8dqy9I+RfPvkQb+lbNuWhg2ZbsO
         PMIg==
X-Gm-Message-State: AOJu0Yyxlx7p7ym1sUEnQxUoC4Gu3cTrKBt/QZKHuNgaKaQdhPMl0YBe
	FFwhSl0JiefiGOyzDBA66sO3cL/tmplgB3PQqWJXiJC9hou7TbyzdIt1cA==
X-Gm-Gg: ASbGncv49i7f0WR5uQpy3kYyDpXiK7vu1LR8T79WZplh2W5bK6eU+YPh6bA5RCCOchB
	TuoMFC8bJoJbAV2HGZwjEAv87wFc6XO3N/v1WfxZ5eCIaq68tNhccfwuG07Gq3mt5yTn+4r5DOo
	cWyRyJCGeCdaEmZZ6RzVyncTxDI1X3gjcHRR4ij31bnBrL2UchBAvrC6FVJIGFiKA9pUdAC/57V
	K/9aN4s97WYIkHokncgddHo8yVQsOIYwsfkLxcSS5ADIopJi/f942jknpspfXsfqNERWaxxqn/t
	TxgxoVl5lBPIKExaDRhACUeLGHz9BMkPFEMALbMi
X-Google-Smtp-Source: AGHT+IHWSuNnetzwoPvsNf1XS8ZFcjfdnYtarema29RyVjKTh8kPQf2YoHyHlUks/9+fnC/ayxiUaQ==
X-Received: by 2002:a17:902:e881:b0:21f:6dcf:fd2b with SMTP id d9443c01a7336-223d91344aemr72721035ad.1.1741117847599;
        Tue, 04 Mar 2025 11:50:47 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bc6sm98560925ad.126.2025.03.04.11.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:50:47 -0800 (PST)
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
Subject: [PATCH bpf-next v3 4/5] bpf: use register liveness information for func_states_equal
Date: Tue,  4 Mar 2025 11:50:23 -0800
Message-ID: <20250304195024.2478889-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304195024.2478889-1-eddyz87@gmail.com>
References: <20250304195024.2478889-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Liveness analysis DFA computes a set of registers live before each
instruction. Leverage this information to skip comparison of dead
registers in func_states_equal(). This helps with convergance of
iterator processing loops, as bpf_reg_state->live marks can't be used
when loops are processed.

This has certain performance impact for selftests, here is a veristat
listing using `-f "insns_pct>5" -f "!insns<200"`

selftests:

File                  Program                        States (A)  States (B)  States  (DIFF)
--------------------  -----------------------------  ----------  ----------  --------------
arena_htab.bpf.o      arena_htab_llvm                        37          35     -2 (-5.41%)
arena_htab_asm.bpf.o  arena_htab_asm                         37          33    -4 (-10.81%)
arena_list.bpf.o      arena_list_add                         37          22   -15 (-40.54%)
dynptr_success.bpf.o  test_dynptr_copy                       22          16    -6 (-27.27%)
dynptr_success.bpf.o  test_dynptr_copy_xdp                   68          58   -10 (-14.71%)
iters.bpf.o           checkpoint_states_deletion            918          40  -878 (-95.64%)
iters.bpf.o           clean_live_states                     136          66   -70 (-51.47%)
iters.bpf.o           iter_nested_deeply_iters               43          37    -6 (-13.95%)
iters.bpf.o           iter_nested_iters                      72          62   -10 (-13.89%)
iters.bpf.o           iter_pass_iter_ptr_to_subprog          30          26    -4 (-13.33%)
iters.bpf.o           iter_subprog_iters                     68          59    -9 (-13.24%)
iters.bpf.o           loop_state_deps2                       35          32     -3 (-8.57%)
iters_css.bpf.o       iter_css_for_each                      32          29     -3 (-9.38%)
pyperf600_iter.bpf.o  on_event                              286         192   -94 (-32.87%)

Total progs: 3578
Old success: 2061
New success: 2061
States diff min:  -95.64%
States diff max:    0.00%
-100 .. -90  %: 1
 -55 .. -45  %: 3
 -45 .. -35  %: 2
 -35 .. -25  %: 5
 -20 .. -10  %: 12
 -10 .. 0    %: 6

sched_ext:

File               Program                 States (A)  States (B)  States   (DIFF)
-----------------  ----------------------  ----------  ----------  ---------------
bpf.bpf.o          lavd_dispatch                 8950        7065  -1885 (-21.06%)
bpf.bpf.o          lavd_init                      516         480     -36 (-6.98%)
bpf.bpf.o          layered_dispatch               662         501   -161 (-24.32%)
bpf.bpf.o          layered_dump                   298         237    -61 (-20.47%)
bpf.bpf.o          layered_init                   523         423   -100 (-19.12%)
bpf.bpf.o          layered_init_task               24          22      -2 (-8.33%)
bpf.bpf.o          layered_runnable               151         125    -26 (-17.22%)
bpf.bpf.o          p2dq_dispatch                   66          53    -13 (-19.70%)
bpf.bpf.o          p2dq_init                      170         142    -28 (-16.47%)
bpf.bpf.o          refresh_layer_cpumasks         120          78    -42 (-35.00%)
bpf.bpf.o          rustland_init                   37          34      -3 (-8.11%)
bpf.bpf.o          rustland_init                   37          34      -3 (-8.11%)
bpf.bpf.o          rusty_select_cpu               125         108    -17 (-13.60%)
scx_central.bpf.o  central_dispatch                59          43    -16 (-27.12%)
scx_central.bpf.o  central_init                    39          28    -11 (-28.21%)
scx_nest.bpf.o     nest_init                       58          51     -7 (-12.07%)
scx_pair.bpf.o     pair_dispatch                  142         111    -31 (-21.83%)
scx_qmap.bpf.o     qmap_dispatch                  174         141    -33 (-18.97%)
scx_qmap.bpf.o     qmap_init                      768         654   -114 (-14.84%)

Total progs: 216
Old success: 186
New success: 186
States diff min:  -35.00%
States diff max:    0.00%
 -35 .. -25  %: 3
 -25 .. -20  %: 6
 -20 .. -15  %: 6
 -15 .. -5   %: 7
  -5 .. 0    %: 6

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b434251979b1..4edb2db0f889 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18500,15 +18500,17 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
  * the current state will reach 'bpf_exit' instruction safely
  */
 static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			      struct bpf_func_state *cur, enum exact_level exact)
+			      struct bpf_func_state *cur, u32 insn_idx, enum exact_level exact)
 {
-	int i;
+	u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
+	u16 i;
 
 	if (old->callback_depth > cur->callback_depth)
 		return false;
 
 	for (i = 0; i < MAX_BPF_REG; i++)
-		if (!regsafe(env, &old->regs[i], &cur->regs[i],
+		if (((1 << i) & live_regs) &&
+		    !regsafe(env, &old->regs[i], &cur->regs[i],
 			     &env->idmap_scratch, exact))
 			return false;
 
@@ -18529,6 +18531,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 			 struct bpf_verifier_state *cur,
 			 enum exact_level exact)
 {
+	u32 insn_idx;
 	int i;
 
 	if (old->curframe != cur->curframe)
@@ -18552,9 +18555,12 @@ static bool states_equal(struct bpf_verifier_env *env,
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
-- 
2.48.1


