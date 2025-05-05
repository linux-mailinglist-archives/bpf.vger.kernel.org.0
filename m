Return-Path: <bpf+bounces-57400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B0AAA58A
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 01:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6C71885E68
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116183146C7;
	Mon,  5 May 2025 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wyl32Uc3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A493146AD;
	Mon,  5 May 2025 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484220; cv=none; b=i/O92AITGgkwJqBcglDjbuGuN6oXoX9qFdXllaxa3bre3/4fEfYRuUEe52VFWC5XVsDy64Us0B33a6wS9ioffqfhZsr/PH/diHjBa/ilEPuNamBTcXBAIBpE+2Q6y+KFSGJdWoGvZtDQYbt+rFRY/pNipvubapnl3p/gjmougcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484220; c=relaxed/simple;
	bh=pN19U5GexfpUfJs301Z3WJb90/7HhGH4vgB1dxv/6/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRWba5SCCaPOQnCqG4kXHaofnLXjQ7cPQjZWwaEo5v+afFgDz404CZoyza9hKiwGQZ/cnmZCliitl/ZGkMm4Rn2tCV/WEy186krUIZ60pGejIBav3Vq6KySOjkV3uRAvbqAIsv4HQ1OkcN9/D1WQceGrNHTp2Vxeb2h5GUD6BHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wyl32Uc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA42C4CEEF;
	Mon,  5 May 2025 22:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484220;
	bh=pN19U5GexfpUfJs301Z3WJb90/7HhGH4vgB1dxv/6/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wyl32Uc3kRfN29Uhn2rLmQ2bDMxxwSgWUnMxqN4xFHSd8lTv32tV9cBmuP/qf5CsP
	 kkzZUb/obfmSTdPzZTxl2lB/otCWwZqP1qmpQj0mRRffjvC9tw8w2BS3TGW5hjRKH1
	 6CqgJ1Ke6v9hx5vYYOh6s3Lg75IsR5eB8tw7W+grHIvfZk4jw3u3e7cNZsA9Gf6PGA
	 W08Y4neN+WEjE7FuPcE+uGCP7XK1U0HA02lufaSufPnNIiSDy/hSLqCuK7LlGvl5dU
	 6Q+wlWdwR/D175SzcCbS6aQqR4qAWnjT5vgYJMJPIkdQ0UqaLs8+yzE2cLB7x1vQ9V
	 bYCyvsqyo/ibg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 394/642] bpf: don't do clean_live_states when state->loop_entry->branches > 0
Date: Mon,  5 May 2025 18:10:10 -0400
Message-Id: <20250505221419.2672473-394-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit 9e63fdb0cbdf3268c86638a8274f4d5549a82820 ]

verifier.c:is_state_visited() uses RANGE_WITHIN states comparison rules
for cached states that have loop_entry with non-zero branches count
(meaning that loop_entry's verification is not yet done).

The RANGE_WITHIN rules in regsafe()/stacksafe() require register and
stack objects types to be identical in current and old states.

verifier.c:clean_live_states() replaces registers and stack spills
with NOT_INIT/STACK_INVALID marks, if these registers/stack spills are
not read in any child state. This means that clean_live_states() works
against loop convergence logic under some conditions. See selftest in
the next patch for a specific example.

Mitigate this by prohibiting clean_verifier_state() when
state->loop_entry->branches > 0.

This undoes negative verification performance impact of the
copy_verifier_state() fix from the previous patch.
Below is comparison between master and current patch.

selftests:

File                                Program                       Insns (A)  Insns (B)  Insns    (DIFF)  States (A)  States (B)  States  (DIFF)
----------------------------------  ----------------------------  ---------  ---------  ---------------  ----------  ----------  --------------
arena_htab.bpf.o                    arena_htab_llvm                     717        423   -294 (-41.00%)          57          37   -20 (-35.09%)
arena_htab_asm.bpf.o                arena_htab_asm                      597        445   -152 (-25.46%)          47          37   -10 (-21.28%)
arena_list.bpf.o                    arena_list_add                     1493       1822   +329 (+22.04%)          30          37    +7 (+23.33%)
arena_list.bpf.o                    arena_list_del                      309        261    -48 (-15.53%)          23          15    -8 (-34.78%)
iters.bpf.o                         checkpoint_states_deletion        18125      22154  +4029 (+22.23%)         818         918  +100 (+12.22%)
iters.bpf.o                         iter_nested_deeply_iters            593        367   -226 (-38.11%)          67          43   -24 (-35.82%)
iters.bpf.o                         iter_nested_iters                   813        772     -41 (-5.04%)          79          72     -7 (-8.86%)
iters.bpf.o                         iter_subprog_check_stacksafe        155        135    -20 (-12.90%)          15          14     -1 (-6.67%)
iters.bpf.o                         iter_subprog_iters                 1094        808   -286 (-26.14%)          88          68   -20 (-22.73%)
iters.bpf.o                         loop_state_deps2                    479        356   -123 (-25.68%)          46          35   -11 (-23.91%)
iters.bpf.o                         triple_continue                      35         31     -4 (-11.43%)           3           3     +0 (+0.00%)
kmem_cache_iter.bpf.o               open_coded_iter                      63         59      -4 (-6.35%)           7           6    -1 (-14.29%)
mptcp_subflow.bpf.o                 _getsockopt_subflow                 501        446    -55 (-10.98%)          25          23     -2 (-8.00%)
pyperf600_iter.bpf.o                on_event                          12339       6379  -5960 (-48.30%)         441         286  -155 (-35.15%)
verifier_bits_iter.bpf.o            max_words                            92         84      -8 (-8.70%)           8           7    -1 (-12.50%)
verifier_iterating_callbacks.bpf.o  cond_break2                         113        192    +79 (+69.91%)          12          21    +9 (+75.00%)

sched_ext:

File               Program                 Insns (A)  Insns (B)  Insns      (DIFF)  States (A)  States (B)  States    (DIFF)
-----------------  ----------------------  ---------  ---------  -----------------  ----------  ----------  ----------------
bpf.bpf.o          layered_dispatch            11485       9039    -2446 (-21.30%)         848         662    -186 (-21.93%)
bpf.bpf.o          layered_dump                 7422       5022    -2400 (-32.34%)         681         298    -383 (-56.24%)
bpf.bpf.o          layered_enqueue             16854      13753    -3101 (-18.40%)        1611        1308    -303 (-18.81%)
bpf.bpf.o          layered_init              1000001       5549  -994452 (-99.45%)       84672         523  -84149 (-99.38%)
bpf.bpf.o          layered_runnable             3149       1899    -1250 (-39.70%)         288         151    -137 (-47.57%)
bpf.bpf.o          p2dq_init                    2343       1936     -407 (-17.37%)         201         170     -31 (-15.42%)
bpf.bpf.o          refresh_layer_cpumasks      16487       1285   -15202 (-92.21%)        1770         120   -1650 (-93.22%)
bpf.bpf.o          rusty_select_cpu             1937       1386     -551 (-28.45%)         177         125     -52 (-29.38%)
scx_central.bpf.o  central_dispatch              636        600       -36 (-5.66%)          63          59       -4 (-6.35%)
scx_central.bpf.o  central_init                  913        632     -281 (-30.78%)          48          39      -9 (-18.75%)
scx_nest.bpf.o     nest_init                     636        601       -35 (-5.50%)          60          58       -2 (-3.33%)
scx_pair.bpf.o     pair_dispatch             1000001       1914  -998087 (-99.81%)       58169         142  -58027 (-99.76%)
scx_qmap.bpf.o     qmap_dispatch                2393       2187      -206 (-8.61%)         196         174     -22 (-11.22%)
scx_qmap.bpf.o     qmap_init                   16367      22777    +6410 (+39.16%)         603         768    +165 (+27.36%)

'layered_init' and 'pair_dispatch' hit 1M on master, but are verified
ok with this patch.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20250215110411.3236773-4-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2801472c0ae4..68715b18df5e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17830,12 +17830,16 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
 static void clean_live_states(struct bpf_verifier_env *env, int insn,
 			      struct bpf_verifier_state *cur)
 {
+	struct bpf_verifier_state *loop_entry;
 	struct bpf_verifier_state_list *sl;
 
 	sl = *explored_state(env, insn);
 	while (sl) {
 		if (sl->state.branches)
 			goto next;
+		loop_entry = get_loop_entry(&sl->state);
+		if (loop_entry && loop_entry->branches)
+			goto next;
 		if (sl->state.insn_idx != insn ||
 		    !same_callsites(&sl->state, cur))
 			goto next;
-- 
2.39.5


