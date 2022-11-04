Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AA0619D6B
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 17:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiKDQhI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Nov 2022 12:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiKDQhH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 12:37:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5179F27156
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 09:37:06 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4EovcG007563
        for <bpf@vger.kernel.org>; Fri, 4 Nov 2022 09:37:06 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmpg372u4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 09:37:05 -0700
Received: from twshared19054.43.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 09:37:03 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4EB5F2117FE92; Fri,  4 Nov 2022 09:36:58 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 3/6] bpf: allow precision tracking for programs with subprogs
Date:   Fri, 4 Nov 2022 09:36:46 -0700
Message-ID: <20221104163649.121784-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221104163649.121784-1-andrii@kernel.org>
References: <20221104163649.121784-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PnIsokDLemCJdn2PDhOs_5QU-UUaokoW
X-Proofpoint-ORIG-GUID: PnIsokDLemCJdn2PDhOs_5QU-UUaokoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stop forcing precise=true for SCALAR registers when BPF program has any
subprograms. Current restriction means that any BPF program, as soon as
it uses subprograms, will end up not getting any of the precision
tracking benefits in reduction of number of verified states.

This patch keeps the fallback mark_all_scalars_precise() behavior if
precise marking has to cross function frames. E.g., if subprogram
requires R1 (first input arg) to be marked precise, ideally we'd need to
backtrack to the parent function and keep marking R1 and its
dependencies as precise. But right now we give up and force all the
SCALARs in any of the current and parent states to be forced to
precise=true. We can lift that restriction in the future.

But this patch fixes two issues identified when trying to enable
precision tracking for subprogs.

First, prevent "escaping" from top-most state in a global subprog. While
with entry-level BPF program we never end up requesting precision for
R1-R5 registers, because R2-R5 are not initialized (and so not readable
in correct BPF program), and R1 is PTR_TO_CTX, not SCALAR, and so is
implicitly precise. With global subprogs, though, it's different, as
global subprog a) can have up to 5 SCALAR input arguments, which might
get marked as precise=true and b) it is validated in isolation from its
main entry BPF program. b) means that we can end up exhausting parent
state chain and still not mark all registers in reg_mask as precise,
which would lead to verifier bug warning.

To handle that, we need to consider two cases. First, if the very first
state is not immediately "checkpointed" (i.e., stored in state lookup
hashtable), it will get correct first_insn_idx and last_insn_idx
instruction set during state checkpointing. As such, this case is
already handled and __mark_chain_precision() already handles that by
just doing nothing when we reach to the very first parent state.
st->parent will be NULL and we'll just stop. Perhaps some extra check
for reg_mask and stack_mask is due here, but this patch doesn't address
that issue.

More problematic second case is when global function's initial state is
immediately checkpointed before we manage to process the very first
instruction. This is happening because when there is a call to global
subprog from the main program the very first subprog's instruction is
marked as pruning point, so before we manage to process first
instruction we have to check and checkpoint state. This patch adds
a special handling for such "empty" state, which is identified by having
st->last_insn_idx set to -1. In such case, we check that we are indeed
validating global subprog, and with some sanity checking we mark input
args as precise if requested.

Note that we also initialize state->first_insn_idx with correct start
insn_idx offset. For main program zero is correct value, but for any
subprog it's quite confusing to not have first_insn_idx set. This
doesn't have any functional impact, but helps with debugging and state
printing. We also explicitly initialize state->last_insns_idx instead of
relying on is_state_visited() to do this with env->prev_insns_idx, which
will be -1 on the very first instruction. This concludes necessary
changes to handle specifically global subprog's precision tracking.

Second identified problem was missed handling of BPF helper functions
that call into subprogs (e.g., bpf_loop and few others). From precision
tracking and backtracking logic's standpoint those are effectively calls
into subprogs and should be called as BPF_PSEUDO_CALL calls.

This patch takes the least intrusive way and just checks against a short
list of current BPF helpers that do call subprogs, encapsulated in
is_callback_calling_function() function. But to prevent accidentally
forgetting to add new BPF helpers to this "list", we also do a sanity
check in __check_func_call, which has to be called for each such special
BPF helper, to validate that BPF helper is indeed recognized as
callback-calling one. This should catch any missed checks in the future.
Adding some special flags to be added in function proto definitions
seemed like an overkill in this case.

With the above changes, it's possible to remove forceful setting of
reg->precise to true in __mark_reg_unknown, which turns on precision
tracking both inside subprogs and entry progs that have subprogs. No
warnings or errors were detected across all the selftests, but also when
validating with veristat against internal Meta BPF objects and Cilium
objects. Further, in some BPF programs there are noticeable reduction in
number of states and instructions validated due to more effective
precision tracking, especially benefiting syncookie test.

$ ./veristat -C -e file,prog,insns,states ~/baseline-results.csv ~/subprog-precise-results.csv  | grep -v '+0'
File                                      Program                     Total insns (A)  Total insns (B)  Total insns (DIFF)  Total states (A)  Total states (B)  Total states (DIFF)
----------------------------------------  --------------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------
pyperf600_bpf_loop.bpf.linked1.o          on_event                               3966             3678       -288 (-7.26%)               306               276         -30 (-9.80%)
pyperf_global.bpf.linked1.o               on_event                               7563             7530        -33 (-0.44%)               520               517          -3 (-0.58%)
pyperf_subprogs.bpf.linked1.o             on_event                              36358            36934       +576 (+1.58%)              2499              2531         +32 (+1.28%)
setget_sockopt.bpf.linked1.o              skops_sockopt                          3965             4038        +73 (+1.84%)               343               347          +4 (+1.17%)
test_cls_redirect_subprogs.bpf.linked1.o  cls_redirect                          64965            64901        -64 (-0.10%)              4619              4612          -7 (-0.15%)
test_misc_tcp_hdr_options.bpf.linked1.o   misc_estab                             1491             1307      -184 (-12.34%)               110               100         -10 (-9.09%)
test_pkt_access.bpf.linked1.o             test_pkt_access                         354              349         -5 (-1.41%)                25                24          -1 (-4.00%)
test_sock_fields.bpf.linked1.o            egress_read_sock_fields                 435              375       -60 (-13.79%)                22                20          -2 (-9.09%)
test_sysctl_loop2.bpf.linked1.o           sysctl_tcp_mem                         1508             1501         -7 (-0.46%)                29                28          -1 (-3.45%)
test_tc_dtime.bpf.linked1.o               egress_fwdns_prio100                    468              435        -33 (-7.05%)                45                41          -4 (-8.89%)
test_tc_dtime.bpf.linked1.o               ingress_fwdns_prio100                   398              408        +10 (+2.51%)                42                39          -3 (-7.14%)
test_tc_dtime.bpf.linked1.o               ingress_fwdns_prio101                  1096              842      -254 (-23.18%)                97                73        -24 (-24.74%)
test_tcp_hdr_options.bpf.linked1.o        estab                                  2758             2408      -350 (-12.69%)               208               181        -27 (-12.98%)
test_urandom_usdt.bpf.linked1.o           urand_read_with_sema                    466              448        -18 (-3.86%)                31                28          -3 (-9.68%)
test_urandom_usdt.bpf.linked1.o           urand_read_without_sema                 466              448        -18 (-3.86%)                31                28          -3 (-9.68%)
test_urandom_usdt.bpf.linked1.o           urandlib_read_with_sema                 466              448        -18 (-3.86%)                31                28          -3 (-9.68%)
test_urandom_usdt.bpf.linked1.o           urandlib_read_without_sema              466              448        -18 (-3.86%)                31                28          -3 (-9.68%)
test_xdp_noinline.bpf.linked1.o           balancer_ingress_v6                    4302             4294         -8 (-0.19%)               257               256          -1 (-0.39%)
xdp_synproxy_kern.bpf.linked1.o           syncookie_tc                         583722           405757   -177965 (-30.49%)             35846             25735     -10111 (-28.21%)
xdp_synproxy_kern.bpf.linked1.o           syncookie_xdp                        609123           479055   -130068 (-21.35%)             35452             29145      -6307 (-17.79%)
----------------------------------------  --------------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 62 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c708eb30664..c1169ee1bc7c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -504,6 +504,15 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 	return func_id == BPF_FUNC_dynptr_data;
 }
 
+static bool is_callback_calling_function(enum bpf_func_id func_id)
+{
+	return func_id == BPF_FUNC_for_each_map_elem ||
+	       func_id == BPF_FUNC_timer_set_callback ||
+	       func_id == BPF_FUNC_find_vma ||
+	       func_id == BPF_FUNC_loop ||
+	       func_id == BPF_FUNC_user_ringbuf_drain;
+}
+
 static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
 					const struct bpf_map *map)
 {
@@ -1677,7 +1686,7 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 	reg->type = SCALAR_VALUE;
 	reg->var_off = tnum_unknown;
 	reg->frameno = 0;
-	reg->precise = env->subprog_cnt > 1 || !env->bpf_capable;
+	reg->precise = !env->bpf_capable;
 	__mark_reg_unbounded(reg);
 }
 
@@ -2646,6 +2655,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 		if (opcode == BPF_CALL) {
 			if (insn->src_reg == BPF_PSEUDO_CALL)
 				return -ENOTSUPP;
+			/* BPF helpers that invoke callback subprogs are
+			 * equivalent to BPF_PSEUDO_CALL above
+			 */
+			if (insn->src_reg == 0 && is_callback_calling_function(insn->imm))
+				return -ENOTSUPP;
 			/* regular helper call sets R0 */
 			*reg_mask &= ~1;
 			if (*reg_mask & 0x3f) {
@@ -2809,12 +2823,42 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 		return 0;
 	if (!reg_mask && !stack_mask)
 		return 0;
+
 	for (;;) {
 		DECLARE_BITMAP(mask, 64);
 		u32 history = st->jmp_history_cnt;
 
 		if (env->log.level & BPF_LOG_LEVEL2)
 			verbose(env, "last_idx %d first_idx %d\n", last_idx, first_idx);
+
+		if (last_idx < 0) {
+			/* we are at the entry into subprog, which
+			 * is expected for global funcs, but only if
+			 * requested precise registers are R1-R5
+			 * (which are global func's input arguments)
+			 */
+			if (st->curframe == 0 &&
+			    st->frame[0]->subprogno > 0 &&
+			    st->frame[0]->callsite == BPF_MAIN_FUNC &&
+			    stack_mask == 0 && (reg_mask & ~0x3e) == 0) {
+				bitmap_from_u64(mask, reg_mask);
+				for_each_set_bit(i, mask, 32) {
+					reg = &st->frame[0]->regs[i];
+					if (reg->type != SCALAR_VALUE) {
+						reg_mask &= ~(1u << i);
+						continue;
+					}
+					reg->precise = true;
+				}
+				return 0;
+			}
+
+			verbose(env, "BUG backtracing func entry subprog %d reg_mask %x stack_mask %llx\n",
+				st->frame[0]->subprogno, reg_mask, stack_mask);
+			WARN_ONCE(1, "verifier backtracking bug");
+			return -EFAULT;
+		}
+
 		for (i = last_idx;;) {
 			if (skip_first) {
 				err = 0;
@@ -6602,6 +6646,10 @@ typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee,
 				   int insn_idx);
 
+static int set_callee_state(struct bpf_verifier_env *env,
+			    struct bpf_func_state *caller,
+			    struct bpf_func_state *callee, int insn_idx);
+
 static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx, int subprog,
 			     set_callee_state_fn set_callee_state_cb)
@@ -6652,6 +6700,16 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 	}
 
+	/* set_callee_state is used for direct subprog calls, but we are
+	 * interested in validating only BPF helpers that can call subprogs as
+	 * callbacks
+	 */
+	if (set_callee_state_cb != set_callee_state && !is_callback_calling_function(insn->imm)) {
+		verbose(env, "verifier bug: helper %s#%d is not marked as callback-calling\n",
+			func_id_name(insn->imm), insn->imm);
+		return -EFAULT;
+	}
+
 	if (insn->code == (BPF_JMP | BPF_CALL) &&
 	    insn->src_reg == 0 &&
 	    insn->imm == BPF_FUNC_timer_set_callback) {
@@ -14571,6 +14629,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 			BPF_MAIN_FUNC /* callsite */,
 			0 /* frameno */,
 			subprog);
+	state->first_insn_idx = env->subprog_info[subprog].start;
+	state->last_insn_idx = -1;
 
 	regs = state->frame[state->curframe]->regs;
 	if (subprog || env->prog->type == BPF_PROG_TYPE_EXT) {
-- 
2.30.2

