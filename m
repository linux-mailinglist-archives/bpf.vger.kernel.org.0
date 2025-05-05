Return-Path: <bpf+bounces-57423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF244AAAB0D
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 03:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B087E179980
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 01:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC982F6B41;
	Mon,  5 May 2025 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIPELxxi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB7286415;
	Mon,  5 May 2025 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486183; cv=none; b=Ca795aRyc8/oRPrIQZhjMk6RM/IHHQckSA4YyMwlRuY7/zWVaNQWy5fz0Xt8STVRtTC2N8vCjqRf2PiqQX3qjfUA4nTSDq9XOCJMsPua/5MfBo/o+j54SHhfJOe4EsdjhGHg1G2Py9feKo51AIZh4VMa/qNlPc1uh3pnkk6fkAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486183; c=relaxed/simple;
	bh=1DjXA4xhtAju2JK2yKoFPKHiiEEZ94BApzWqGwJt//w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0YSLn8ItLVJD6zorcOzEc4JPwNarjCV7Q+e+LsTa/YbXZP1JGTRfzD6KVURzVDvsxApMRjhph2iot6uxjvxv++S4cS/HtSGQYLyTz9oWTp2SrZtHopFZwxPwVkMfZ6Np9tnXqy4grTk/SVM2eo5V8m9jQLpPTMmyOLUFdWVT8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIPELxxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9254C4CEEF;
	Mon,  5 May 2025 23:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486181;
	bh=1DjXA4xhtAju2JK2yKoFPKHiiEEZ94BApzWqGwJt//w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nIPELxxiRq486yvmMlNnp3tLLlZc9nVSAnpgTMg9CAPC71Wb18xTHHgMPbMBLhmVl
	 EOCQN2JzvAbsFCBCYwhEQ71junsPS/XZu3rOZB0ejcSeXKZwq2nze7ia/U/6/SC3wk
	 GkPXNw4Mg/jmRZKH2wGzWin4P1RhWWpTX82QqqaowFkINslfjxLEBgAe73CTqGPaE1
	 zh5Hg+1VIyG2h/6U8B6Lntk9Q/lZDgOF2KS5sPW7LuAF2C3SVu12v90BGiR2h3Aeh2
	 8a8vNE8tWjo4f3zNPRuyEXO9hacXy4MgeVhbWs6IwY5GZ5v9c9pkmMkpoiLYb0VcPl
	 Ckum8mSacerew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 190/294] bpf: don't do clean_live_states when state->loop_entry->branches > 0
Date: Mon,  5 May 2025 18:54:50 -0400
Message-Id: <20250505225634.2688578-190-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index e443506b0a65a..eacb9b160afb0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15963,12 +15963,16 @@ static void clean_verifier_state(struct bpf_verifier_env *env,
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


