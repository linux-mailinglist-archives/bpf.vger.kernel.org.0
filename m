Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49D6619D6D
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 17:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiKDQhV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 4 Nov 2022 12:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiKDQhR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 12:37:17 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5173F052
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 09:37:11 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Eod7R012984
        for <bpf@vger.kernel.org>; Fri, 4 Nov 2022 09:37:11 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmqbnet2e-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 09:37:10 -0700
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 09:37:08 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BF0012117FEC0; Fri,  4 Nov 2022 09:37:03 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 5/6] bpf: aggressively forget precise markings during state checkpointing
Date:   Fri, 4 Nov 2022 09:36:48 -0700
Message-ID: <20221104163649.121784-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221104163649.121784-1-andrii@kernel.org>
References: <20221104163649.121784-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qmpxSxRrUP3DfZXTh7hvsFXAFTb3ISiO
X-Proofpoint-GUID: qmpxSxRrUP3DfZXTh7hvsFXAFTb3ISiO
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

Exploit the property of about-to-be-checkpointed state to be able to
forget all precise markings up to that point even more aggressively. We
now clear all potentially inherited precise markings right before
checkpointing and branching off into child state. If any of children
states require precise knowledge of any SCALAR register, those will be
propagated backwards later on before this state is finalized, preserving
correctness.

There is a single selftests BPF program change, but tremendous one: 25x
reduction in number of verified instructions and states in
trace_virtqueue_add_sgs.

Cilium results are more modest, but happen across wider range of programs.

SELFTESTS RESULTS
=================

$ ./veristat -C -e file,prog,insns,states ~/imprecise-early-results.csv ~/imprecise-aggressive-results.csv | grep -v '+0'
File                 Program                  Total insns (A)  Total insns (B)  Total insns (DIFF)  Total states (A)  Total states (B)  Total states (DIFF)
-------------------  -----------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------
loop6.bpf.linked1.o  trace_virtqueue_add_sgs           398057            15114   -382943 (-96.20%)              8717               336      -8381 (-96.15%)
-------------------  -----------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------

CILIUM RESULTS
==============

$ ./veristat -C -e file,prog,insns,states ~/imprecise-early-results-cilium.csv ~/imprecise-aggressive-results-cilium.csv | grep -v '+0'
File           Program                           Total insns (A)  Total insns (B)  Total insns (DIFF)  Total states (A)  Total states (B)  Total states (DIFF)
-------------  --------------------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------
bpf_host.o     tail_handle_nat_fwd_ipv4                    23426            23221       -205 (-0.88%)              1537              1515         -22 (-1.43%)
bpf_host.o     tail_handle_nat_fwd_ipv6                    13009            12904       -105 (-0.81%)               719               708         -11 (-1.53%)
bpf_host.o     tail_nodeport_nat_ingress_ipv6               5261             5196        -65 (-1.24%)               247               243          -4 (-1.62%)
bpf_host.o     tail_nodeport_nat_ipv6_egress                3446             3406        -40 (-1.16%)               203               198          -5 (-2.46%)
bpf_lxc.o      tail_handle_nat_fwd_ipv4                    23426            23221       -205 (-0.88%)              1537              1515         -22 (-1.43%)
bpf_lxc.o      tail_handle_nat_fwd_ipv6                    13009            12904       -105 (-0.81%)               719               708         -11 (-1.53%)
bpf_lxc.o      tail_ipv4_ct_egress                          5074             4897       -177 (-3.49%)               255               248          -7 (-2.75%)
bpf_lxc.o      tail_ipv4_ct_ingress                         5100             4923       -177 (-3.47%)               255               248          -7 (-2.75%)
bpf_lxc.o      tail_ipv4_ct_ingress_policy_only             5100             4923       -177 (-3.47%)               255               248          -7 (-2.75%)
bpf_lxc.o      tail_ipv6_ct_egress                          4558             4536        -22 (-0.48%)               188               187          -1 (-0.53%)
bpf_lxc.o      tail_ipv6_ct_ingress                         4578             4556        -22 (-0.48%)               188               187          -1 (-0.53%)
bpf_lxc.o      tail_ipv6_ct_ingress_policy_only             4578             4556        -22 (-0.48%)               188               187          -1 (-0.53%)
bpf_lxc.o      tail_nodeport_nat_ingress_ipv6               5261             5196        -65 (-1.24%)               247               243          -4 (-1.62%)
bpf_overlay.o  tail_nodeport_nat_ingress_ipv6               5261             5196        -65 (-1.24%)               247               243          -4 (-1.62%)
bpf_overlay.o  tail_nodeport_nat_ipv6_egress                3482             3442        -40 (-1.15%)               204               201          -3 (-1.47%)
bpf_xdp.o      tail_nodeport_nat_egress_ipv4               17200            15619      -1581 (-9.19%)              1111              1010        -101 (-9.09%)
-------------  --------------------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff3fc21ce99b..d3b75aa0c54d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2774,6 +2774,31 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 	}
 }
 
+static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_func_state *func;
+	struct bpf_reg_state *reg;
+	int i, j;
+
+	for (i = 0; i <= st->curframe; i++) {
+		func = st->frame[i];
+		for (j = 0; j < BPF_REG_FP; j++) {
+			reg = &func->regs[j];
+			if (reg->type != SCALAR_VALUE)
+				continue;
+			reg->precise = false;
+		}
+		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
+			if (!is_spilled_reg(&func->stack[j]))
+				continue;
+			reg = &func->stack[j].spilled_ptr;
+			if (reg->type != SCALAR_VALUE)
+				continue;
+			reg->precise = false;
+		}
+	}
+}
+
 /*
  * __mark_chain_precision() backtracks BPF program instruction sequence and
  * chain of verifier states making sure that register *regno* (if regno >= 0)
@@ -2852,6 +2877,14 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
  * be imprecise. If any child state does require this register to be precise,
  * we'll mark it precise later retroactively during precise markings
  * propagation from child state to parent states.
+ *
+ * Skipping precise marking setting in current state is a mild version of
+ * relying on the above observation. But we can utilize this property even
+ * more aggressively by proactively forgetting any precise marking in the
+ * current state (which we inherited from the parent state), right before we
+ * checkpoint it and branch off into new child state. This is done by
+ * mark_all_scalars_imprecise() to hopefully get more permissive and generic
+ * finalized states which help in short circuiting more future states.
  */
 static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int regno,
 				  int spi)
@@ -12160,6 +12193,10 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	env->prev_jmps_processed = env->jmps_processed;
 	env->prev_insn_processed = env->insn_processed;
 
+	/* forget precise markings we inherited, see __mark_chain_precision */
+	if (env->bpf_capable)
+		mark_all_scalars_imprecise(env, cur);
+
 	/* add new state to the head of linked list */
 	new = &new_sl->state;
 	err = copy_verifier_state(new, cur);
-- 
2.30.2

