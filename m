Return-Path: <bpf+bounces-57401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43118AAA55F
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 01:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6710117267B
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A4727F73B;
	Mon,  5 May 2025 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax9zkSZF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63EA3146D1;
	Mon,  5 May 2025 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484221; cv=none; b=IiDLFaYl5xH4P4igBlTs+HZ0ynzmm/ywlo/HhIDNP/D8Od/Y30xXjonM2UhxSqTh/iDE/2hgr1iPGem8kgv4aITC/ImsXWXzO6DWlt7IHWmO2E3LsMKSOj1l+JxTzZgrzvHcgwwqc88/CEIP30aFzH1xKikpnYbEp9nElYxmtRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484221; c=relaxed/simple;
	bh=3twF76xqdfJ9X9Jww1ym6dYWJmuo43Q5mdhzfW3SvEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CxXUOUOeZpaAH9CFw+k9lqibT3JbbhKjnJUvymaeDBC6M/XykPsxSSOneF5e9US6GRbCfpRS1/R4fVqrL8kEPMfvwK9D5Vi/HdUePYnCHdthH7WOeEonuwpHI05Bb/Cfruk0VKgov0KbTQUNvkenkUo/qzIk7qVsHzSMW6ItVqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax9zkSZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33E3C4CEE4;
	Mon,  5 May 2025 22:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484221;
	bh=3twF76xqdfJ9X9Jww1ym6dYWJmuo43Q5mdhzfW3SvEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ax9zkSZFub2XvhMBxAkAkmPV044929KuyAC70EkrMv5Ybly9H1JPjM0PVEtxyOHDy
	 k7VhvT283WrmIWMRG7BpA+vAD8WQ0jmwAvLWSl0Jlq78szZjtMXVkIekPFkVG2Wxie
	 TZL8/n4ZVy7Zm5fMcNO6Wz2JoQ4HPTsSO+k44B5I8WJpLKpNc0SN4qq25Z3mUIjV0b
	 +vG76EvReDIkrYCRVQ4ZMg1raF6okisgUjVlBB2tdzdcQSh1iR9Jegj6+ugZ0b8Lze
	 2qn9b18+xFmcu0vEeIw/VCGy6clri7B9HBuqjVdepiFsvu7TDgeg0i+veqCYw1UfWB
	 EuLTNGUqALPaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 395/642] bpf: copy_verifier_state() should copy 'loop_entry' field
Date: Mon,  5 May 2025 18:10:11 -0400
Message-Id: <20250505221419.2672473-395-sashal@kernel.org>
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

[ Upstream commit bbbc02b7445ebfda13e4847f4f1413c6480a85a9 ]

The bpf_verifier_state.loop_entry state should be copied by
copy_verifier_state(). Otherwise, .loop_entry values from unrelated
states would poison env->cur_state.

Additionally, env->stack should not contain any states with
.loop_entry != NULL. The states in env->stack are yet to be verified,
while .loop_entry is set for states that reached an equivalent state.
This means that env->cur_state->loop_entry should always be NULL after
pop_stack().

See the selftest in the next commit for an example of the program that
is not safe yet is accepted by verifier w/o this fix.

This change has some verification performance impact for selftests:

File                                Program                       Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (DIFF)
----------------------------------  ----------------------------  ---------  ---------  --------------  ----------  ----------  -------------
arena_htab.bpf.o                    arena_htab_llvm                     717        426  -291 (-40.59%)          57          37  -20 (-35.09%)
arena_htab_asm.bpf.o                arena_htab_asm                      597        445  -152 (-25.46%)          47          37  -10 (-21.28%)
arena_list.bpf.o                    arena_list_del                      309        279    -30 (-9.71%)          23          14   -9 (-39.13%)
iters.bpf.o                         iter_subprog_check_stacksafe        155        141    -14 (-9.03%)          15          14    -1 (-6.67%)
iters.bpf.o                         iter_subprog_iters                 1094       1003    -91 (-8.32%)          88          83    -5 (-5.68%)
iters.bpf.o                         loop_state_deps2                    479        725  +246 (+51.36%)          46          63  +17 (+36.96%)
kmem_cache_iter.bpf.o               open_coded_iter                      63         59     -4 (-6.35%)           7           6   -1 (-14.29%)
verifier_bits_iter.bpf.o            max_words                            92         84     -8 (-8.70%)           8           7   -1 (-12.50%)
verifier_iterating_callbacks.bpf.o  cond_break2                         113        107     -6 (-5.31%)          12          12    +0 (+0.00%)

And significant negative impact for sched_ext:

File               Program                 Insns (A)  Insns (B)  Insns         (DIFF)  States (A)  States (B)  States      (DIFF)
-----------------  ----------------------  ---------  ---------  --------------------  ----------  ----------  ------------------
bpf.bpf.o          lavd_init                    7039      14723      +7684 (+109.16%)         490        1139     +649 (+132.45%)
bpf.bpf.o          layered_dispatch            11485      10548         -937 (-8.16%)         848         762       -86 (-10.14%)
bpf.bpf.o          layered_dump                 7422    1000001  +992579 (+13373.47%)         681       31178  +30497 (+4478.27%)
bpf.bpf.o          layered_enqueue             16854      71127     +54273 (+322.02%)        1611        6450    +4839 (+300.37%)
bpf.bpf.o          p2dq_dispatch                 665        791        +126 (+18.95%)          68          78       +10 (+14.71%)
bpf.bpf.o          p2dq_init                    2343       2980        +637 (+27.19%)         201         237       +36 (+17.91%)
bpf.bpf.o          refresh_layer_cpumasks      16487     674760   +658273 (+3992.68%)        1770       65370  +63600 (+3593.22%)
bpf.bpf.o          rusty_select_cpu             1937      40872    +38935 (+2010.07%)         177        3210   +3033 (+1713.56%)
scx_central.bpf.o  central_dispatch              636       2687      +2051 (+322.48%)          63         227     +164 (+260.32%)
scx_nest.bpf.o     nest_init                     636        815        +179 (+28.14%)          60          73       +13 (+21.67%)
scx_qmap.bpf.o     qmap_dispatch                2393       3580       +1187 (+49.60%)         196         253       +57 (+29.08%)
scx_qmap.bpf.o     qmap_dump                     233        318         +85 (+36.48%)          22          30        +8 (+36.36%)
scx_qmap.bpf.o     qmap_init                   16367      17436        +1069 (+6.53%)         603         669       +66 (+10.95%)

Note 'layered_dump' program, which now hits 1M instructions limit.
This impact would be mitigated in the next patch.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20250215110411.3236773-2-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 68715b18df5e2..0752e8e556389 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1661,6 +1661,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->callback_unroll_depth = src->callback_unroll_depth;
 	dst_state->used_as_loop_entry = src->used_as_loop_entry;
 	dst_state->may_goto_depth = src->may_goto_depth;
+	dst_state->loop_entry = src->loop_entry;
 	for (i = 0; i <= src->curframe; i++) {
 		dst = dst_state->frame[i];
 		if (!dst) {
@@ -19264,6 +19265,8 @@ static int do_check(struct bpf_verifier_env *env)
 						return err;
 					break;
 				} else {
+					if (WARN_ON_ONCE(env->cur_state->loop_entry))
+						env->cur_state->loop_entry = NULL;
 					do_print_state = true;
 					continue;
 				}
-- 
2.39.5


