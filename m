Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD22B615C3B
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 07:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiKBGWs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Nov 2022 02:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKBGWr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 02:22:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB5A26109
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 23:22:45 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A25BR6l007444
        for <bpf@vger.kernel.org>; Tue, 1 Nov 2022 23:22:45 -0700
Received: from maileast.thefacebook.com ([163.114.130.3])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kjvgscc6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 23:22:44 -0700
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 23:22:44 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B91FE20F58A5B; Tue,  1 Nov 2022 23:22:31 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/6] bpf: stop setting precise in current state
Date:   Tue, 1 Nov 2022 23:22:19 -0700
Message-ID: <20221102062221.2019833-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221102062221.2019833-1-andrii@kernel.org>
References: <20221102062221.2019833-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: D6t5JSL9TygsIfN3mmxBG_KbUuD-vom0
X-Proofpoint-GUID: D6t5JSL9TygsIfN3mmxBG_KbUuD-vom0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_02,2022-11-01_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Setting reg->precise to true in current state is not necessary from
correctness standpoint, but it does pessimise the whole precision (or
rather "imprecision", because that's what we want to keep as much as
possible) tracking. Why is somewhat subtle and my best attempt to
explain this is recorded in an extensive comment for __mark_chain_precise()
function. Some more careful thinking and code reading is probably required
still to grok this completely, unfortunately. Whiteboarding and a bunch
of extra handwaiving in person would be even more helpful, but is deemed
impractical in Git commit.

Next patch pushes this imprecision property even further, building on top of
the insights described in this patch.

End results are pretty nice, we get reduction in number of total instructions
and states verified due to a better states reuse, as some of the states are now
more generic and permissive due to less unnecessary precise=true requirements.

SELFTESTS RESULTS
=================

$ ./veristat -C -e file,prog,insns,states ~/subprog-precise-results.csv ~/imprecise-early-results.csv | grep -v '+0'
File                                     Program                 Total insns (A)  Total insns (B)  Total insns (DIFF)  Total states (A)  Total states (B)  Total states (DIFF)
---------------------------------------  ----------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------
bpf_iter_ksym.bpf.linked1.o              dump_ksym                           347              285       -62 (-17.87%)                20                19          -1 (-5.00%)
pyperf600_bpf_loop.bpf.linked1.o         on_event                           3678             3736        +58 (+1.58%)               276               285          +9 (+3.26%)
setget_sockopt.bpf.linked1.o             skops_sockopt                      4038             3947        -91 (-2.25%)               347               343          -4 (-1.15%)
test_l4lb.bpf.linked1.o                  balancer_ingress                   4559             2611     -1948 (-42.73%)               118               105        -13 (-11.02%)
test_l4lb_noinline.bpf.linked1.o         balancer_ingress                   6279             6268        -11 (-0.18%)               237               236          -1 (-0.42%)
test_misc_tcp_hdr_options.bpf.linked1.o  misc_estab                         1307             1303         -4 (-0.31%)               100                99          -1 (-1.00%)
test_sk_lookup.bpf.linked1.o             ctx_narrow_access                   456              447         -9 (-1.97%)                39                38          -1 (-2.56%)
test_sysctl_loop1.bpf.linked1.o          sysctl_tcp_mem                     1389             1384         -5 (-0.36%)                26                25          -1 (-3.85%)
test_tc_dtime.bpf.linked1.o              egress_fwdns_prio101                518              485        -33 (-6.37%)                51                46          -5 (-9.80%)
test_tc_dtime.bpf.linked1.o              egress_host                         519              468        -51 (-9.83%)                50                44         -6 (-12.00%)
test_tc_dtime.bpf.linked1.o              ingress_fwdns_prio101               842             1000      +158 (+18.76%)                73                88        +15 (+20.55%)
xdp_synproxy_kern.bpf.linked1.o          syncookie_tc                     405757           373173     -32584 (-8.03%)             25735             22882      -2853 (-11.09%)
xdp_synproxy_kern.bpf.linked1.o          syncookie_xdp                    479055           371590   -107465 (-22.43%)             29145             22207      -6938 (-23.81%)
---------------------------------------  ----------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------

Slight regression in test_tc_dtime.bpf.linked1.o/ingress_fwdns_prio101
is left for a follow up, there might be some more precision-related bugs
in existing BPF verifier logic.

CILIUM RESULTS
==============

$ ./veristat -C -e file,prog,insns,states ~/subprog-precise-results-cilium.csv ~/imprecise-early-results-cilium.csv | grep -v '+0'
File           Program                         Total insns (A)  Total insns (B)  Total insns (DIFF)  Total states (A)  Total states (B)  Total states (DIFF)
-------------  ------------------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------
bpf_host.o     cil_from_host                               762              556      -206 (-27.03%)                43                37         -6 (-13.95%)
bpf_host.o     tail_handle_nat_fwd_ipv4                  23541            23426       -115 (-0.49%)              1538              1537          -1 (-0.07%)
bpf_host.o     tail_nodeport_nat_egress_ipv4             33592            33566        -26 (-0.08%)              2163              2161          -2 (-0.09%)
bpf_lxc.o      tail_handle_nat_fwd_ipv4                  23541            23426       -115 (-0.49%)              1538              1537          -1 (-0.07%)
bpf_overlay.o  tail_nodeport_nat_egress_ipv4             33581            33543        -38 (-0.11%)              2160              2157          -3 (-0.14%)
bpf_xdp.o      tail_handle_nat_fwd_ipv4                  21659            20920       -739 (-3.41%)              1440              1376         -64 (-4.44%)
bpf_xdp.o      tail_handle_nat_fwd_ipv6                  17084            17039        -45 (-0.26%)               907               905          -2 (-0.22%)
bpf_xdp.o      tail_lb_ipv4                              73442            73430        -12 (-0.02%)              4370              4369          -1 (-0.02%)
bpf_xdp.o      tail_lb_ipv6                             152114           151895       -219 (-0.14%)              6493              6479         -14 (-0.22%)
bpf_xdp.o      tail_nodeport_nat_egress_ipv4             17377            17200       -177 (-1.02%)              1125              1111         -14 (-1.24%)
bpf_xdp.o      tail_nodeport_nat_ingress_ipv6             6405             6397         -8 (-0.12%)               309               308          -1 (-0.32%)
bpf_xdp.o      tail_rev_nodeport_lb4                      7126             6934       -192 (-2.69%)               414               402         -12 (-2.90%)
bpf_xdp.o      tail_rev_nodeport_lb6                     18059            17905       -154 (-0.85%)              1105              1096          -9 (-0.81%)
-------------  ------------------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 103 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cf9e20da8f6b..2ec9d1452d4f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2756,8 +2756,11 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 
 	/* big hammer: mark all scalars precise in this path.
 	 * pop_stack may still get !precise scalars.
+	 * We also skip current state and go straight to first parent state,
+	 * because precision markings in current non-checkpointed state are
+	 * not needed. See why in the comment in __mark_chain_precision below.
 	 */
-	for (; st; st = st->parent)
+	for (st = st->parent; st; st = st->parent) {
 		for (i = 0; i <= st->curframe; i++) {
 			func = st->frame[i];
 			for (j = 0; j < BPF_REG_FP; j++) {
@@ -2775,8 +2778,88 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 				reg->precise = true;
 			}
 		}
+	}
 }
 
+/*
+ * __mark_chain_precision() backtracks BPF program instruction sequence and
+ * chain of verifier states making sure that register *regno* (if regno >= 0)
+ * and/or stack slot *spi* (if spi >= 0) are marked as precisely tracked
+ * SCALARS, as well as any other registers and slots that contribute to
+ * a tracked state of given registers/stack slots, depending on specific BPF
+ * assembly instructions (see backtrack_insns() for exact instruction handling
+ * logic). This backtracking relies on recorded jmp_history and is able to
+ * traverse entire chain of parent states. This process ends only when all the
+ * necessary registers/slots and their transitive dependencies are marked as
+ * precise.
+ *
+ * One important and subtle aspect is that precise marks *do not matter* in
+ * the currently verified state (current state). It is important to understand
+ * why this is the case.
+ *
+ * First, note that current state is the state that is not yet "checkpointed",
+ * i.e., it is not yet put into env->explored_states, and it has no children
+ * states as well. It's ephemeral, and can end up either a) being discarded if
+ * compatible explored state is found at some point or BPF_EXIT instruction is
+ * reached or b) checkpointed and put into env->explored_states, branching out
+ * into one or more children states.
+ *
+ * In the former case, precise markings in current state are completely
+ * ignored by state comparison code (see regsafe() for details). Only
+ * checkpointed ("old") state precise markings are important, and if old
+ * state's register/slot is precise, regsafe() assumes current state's
+ * register/slot as precise and checks value ranges exactly and precisely. If
+ * states turn out to be compatible, current state's necessary precise
+ * markings and any required parent states' precise markings are enforced
+ * after the fact with propagate_precision() logic, after the fact. But it's
+ * important to realize that in this case, even after marking current state
+ * registers/slots as precise, we immediately discard current state. So what
+ * actually matters is any of the precise markings propagated into current
+ * state's parent states, which are always checkpointed (due to b) case above).
+ * As such, for scenario a) it doesn't matter if current state has precise
+ * markings set or not.
+ *
+ * Now, for the scenario b), checkpointing and forking into child(ren)
+ * state(s). Note that before current state gets to checkpointing step, any
+ * processed instruction always assumes precise SCALAR register/slot
+ * knowledge: if precise value or range is useful to prune jump branch, BPF
+ * verifier takes this opportunity enthusiastically. Similarly, when
+ * register's value is used to calculate offset or memory address, exact
+ * knowledge of SCALAR range is assumed, checked, and enforced. So, similar to
+ * what we mentioned above about state comparison ignoring precise markings
+ * during state comparison, BPF verifier ignores and also assumes precise
+ * markings *at will* during instruction verification process. But as verifier
+ * assumes precision, it also propagates any precision dependencies across
+ * parent states, which are not yet finalized, so can be further restricted
+ * based on new knowledge gained from restrictions enforced by their children
+ * states. This is so that once those parent states are finalized, i.e., when
+ * they have no more active children state, state comparison logic in
+ * is_state_visited() would enforce strict and precise SCALAR ranges, if
+ * required for correctness.
+ *
+ * To build a bit more intuition, note also that once a state is checkpointed,
+ * the path we took to get to that state is not important. This is crucial
+ * property for state pruning. When state is checkpointed and finalized at
+ * some instruction index, it can be correctly and safely used to "short
+ * circuit" any *compatible* state that reaches exactly the same instruction
+ * index. I.e., if we jumped to that instruction from a completely different
+ * code path than original finalized state was derived from, it doesn't
+ * matter, current state can be discarded because from that instruction
+ * forward having a compatible state will ensure we will safely reach the
+ * exit. States describe preconditions for further exploration, but completely
+ * forget the history of how we got here.
+ *
+ * This also means that even if we needed precise SCALAR range to get to
+ * finalized state, but from that point forward *that same* SCALAR register is
+ * never used in a precise context (i.e., it's precise value is not needed for
+ * correctness), it's correct and safe to mark such register as "imprecise"
+ * (i.e., precise marking set to false). This is what we rely on when we do
+ * not set precise marking in current state. If no child state requires
+ * precision for any given SCALAR register, it's safe to dictate that it can
+ * be imprecise. If any child state does require this register to be precise,
+ * we'll mark it precise later retroactively during precise markings
+ * propagation from child state to parent states.
+ */
 static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int regno,
 				  int spi)
 {
@@ -2794,6 +2877,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 	if (!env->bpf_capable)
 		return 0;
 
+	/* Do sanity checks against current state of register and/or stack
+	 * slot, but don't set precise flag in current state, as precision
+	 * tracking in the current state is unnecessary.
+	 */
 	func = st->frame[frame];
 	if (regno >= 0) {
 		reg = &func->regs[regno];
@@ -2801,11 +2888,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 			WARN_ONCE(1, "backtracing misuse");
 			return -EFAULT;
 		}
-		if (!reg->precise)
-			new_marks = true;
-		else
-			reg_mask = 0;
-		reg->precise = true;
+		new_marks = true;
 	}
 
 	while (spi >= 0) {
@@ -2818,11 +2901,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 			stack_mask = 0;
 			break;
 		}
-		if (!reg->precise)
-			new_marks = true;
-		else
-			stack_mask = 0;
-		reg->precise = true;
+		new_marks = true;
 		break;
 	}
 
@@ -11577,7 +11656,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		if (env->explore_alu_limits)
 			return false;
 		if (rcur->type == SCALAR_VALUE) {
-			if (!rold->precise && !rcur->precise)
+			if (!rold->precise)
 				return true;
 			/* new val must satisfy old val knowledge */
 			return range_within(rold, rcur) &&
-- 
2.30.2

