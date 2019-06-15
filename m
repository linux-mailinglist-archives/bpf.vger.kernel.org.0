Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E634D471CC
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2019 21:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfFOTMd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 15 Jun 2019 15:12:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbfFOTMc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 15 Jun 2019 15:12:32 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5FJA7s1032437
        for <bpf@vger.kernel.org>; Sat, 15 Jun 2019 12:12:31 -0700
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t4v07h7a7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 15 Jun 2019 12:12:31 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sat, 15 Jun 2019 12:12:30 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 332DA760AA7; Sat, 15 Jun 2019 12:12:28 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 1/9] bpf: track spill/fill of constants
Date:   Sat, 15 Jun 2019 12:12:17 -0700
Message-ID: <20190615191225.2409862-2-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190615191225.2409862-1-ast@kernel.org>
References: <20190615191225.2409862-1-ast@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906150181
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Compilers often spill induction variables into the stack,
hence it is necessary for the verifier to track scalar values
of the registers through stack slots.

Also few bpf programs were incorrectly rejected in the past,
since the verifier was not able to track such constants while
they were used to compute offsets into packet headers.

Tracking constants through the stack significantly decreases
the chances of state pruning, since two different constants
are considered to be different by state equivalency.
End result that cilium tests suffer serious degradation in the number
of states processed and corresponding verification time increase.

                     before  after
bpf_lb-DLB_L3.o      1838    6441
bpf_lb-DLB_L4.o      3218    5908
bpf_lb-DUNKNOWN.o    1064    1064
bpf_lxc-DDROP_ALL.o  26935   93790
bpf_lxc-DUNKNOWN.o   34439   123886
bpf_netdev.o         9721    31413
bpf_overlay.o        6184    18561
bpf_lxc_jit.o        39389   359445

After further debugging turned out that cillium progs are
getting hurt by clang due to the same constant tracking issue.
Newer clang generates better code by spilling less to the stack.
Instead it keeps more constants in the registers which
hurts state pruning since the verifier already tracks constants
in the registers:
                  old clang  new clang
                         (no spill/fill tracking introduced by this patch)
bpf_lb-DLB_L3.o      1838    1923
bpf_lb-DLB_L4.o      3218    3077
bpf_lb-DUNKNOWN.o    1064    1062
bpf_lxc-DDROP_ALL.o  26935   166729
bpf_lxc-DUNKNOWN.o   34439   174607
bpf_netdev.o         9721    8407
bpf_overlay.o        6184    5420
bpf_lcx_jit.o        39389   39389

The final table is depressing:
                  old clang  old clang    new clang  new clang
                           const spill/fill        const spill/fill
bpf_lb-DLB_L3.o      1838    6441          1923      8128
bpf_lb-DLB_L4.o      3218    5908          3077      6707
bpf_lb-DUNKNOWN.o    1064    1064          1062      1062
bpf_lxc-DDROP_ALL.o  26935   93790         166729    380712
bpf_lxc-DUNKNOWN.o   34439   123886        174607    440652
bpf_netdev.o         9721    31413         8407      31904
bpf_overlay.o        6184    18561         5420      23569
bpf_lxc_jit.o        39389   359445        39389     359445

Tracking constants in the registers hurts state pruning already.
Adding tracking of constants through stack hurts pruning even more.
The later patch address this general constant tracking issue
with coarse/precise logic.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 kernel/bpf/verifier.c | 90 +++++++++++++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8d1786357a09..6c13d86569a6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1378,6 +1378,23 @@ static bool register_is_null(struct bpf_reg_state *reg)
 	return reg->type == SCALAR_VALUE && tnum_equals_const(reg->var_off, 0);
 }
 
+static bool register_is_const(struct bpf_reg_state *reg)
+{
+	return reg->type == SCALAR_VALUE && tnum_is_const(reg->var_off);
+}
+
+static void save_register_state(struct bpf_func_state *state,
+				int spi, struct bpf_reg_state *reg)
+{
+	int i;
+
+	state->stack[spi].spilled_ptr = *reg;
+	state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
+
+	for (i = 0; i < BPF_REG_SIZE; i++)
+		state->stack[spi].slot_type[i] = STACK_SPILL;
+}
+
 /* check_stack_read/write functions track spill/fill of registers,
  * stack boundary and alignment are checked in check_mem_access()
  */
@@ -1387,7 +1404,7 @@ static int check_stack_write(struct bpf_verifier_env *env,
 {
 	struct bpf_func_state *cur; /* state of the current function */
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE, err;
-	enum bpf_reg_type type;
+	struct bpf_reg_state *reg = NULL;
 
 	err = realloc_func_state(state, round_up(slot + 1, BPF_REG_SIZE),
 				 state->acquired_refs, true);
@@ -1404,27 +1421,37 @@ static int check_stack_write(struct bpf_verifier_env *env,
 	}
 
 	cur = env->cur_state->frame[env->cur_state->curframe];
-	if (value_regno >= 0 &&
-	    is_spillable_regtype((type = cur->regs[value_regno].type))) {
+	if (value_regno >= 0)
+		reg = &cur->regs[value_regno];
 
+	if (reg && size == BPF_REG_SIZE && register_is_const(reg) &&
+	    !register_is_null(reg) && env->allow_ptr_leaks) {
+		save_register_state(state, spi, reg);
+	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size != BPF_REG_SIZE) {
+			verbose_linfo(env, insn_idx, "; ");
 			verbose(env, "invalid size of register spill\n");
 			return -EACCES;
 		}
 
-		if (state != cur && type == PTR_TO_STACK) {
+		if (state != cur && reg->type == PTR_TO_STACK) {
 			verbose(env, "cannot spill pointers to stack into stack frame of the caller\n");
 			return -EINVAL;
 		}
 
-		/* save register state */
-		state->stack[spi].spilled_ptr = cur->regs[value_regno];
-		state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
+		if (!env->allow_ptr_leaks) {
+			bool sanitize = false;
 
-		for (i = 0; i < BPF_REG_SIZE; i++) {
-			if (state->stack[spi].slot_type[i] == STACK_MISC &&
-			    !env->allow_ptr_leaks) {
+			if (state->stack[spi].slot_type[0] == STACK_SPILL &&
+			    register_is_const(&state->stack[spi].spilled_ptr))
+				sanitize = true;
+			for (i = 0; i < BPF_REG_SIZE; i++)
+				if (state->stack[spi].slot_type[i] == STACK_MISC) {
+					sanitize = true;
+					break;
+				}
+			if (sanitize) {
 				int *poff = &env->insn_aux_data[insn_idx].sanitize_stack_off;
 				int soff = (-spi - 1) * BPF_REG_SIZE;
 
@@ -1447,8 +1474,8 @@ static int check_stack_write(struct bpf_verifier_env *env,
 				}
 				*poff = soff;
 			}
-			state->stack[spi].slot_type[i] = STACK_SPILL;
 		}
+		save_register_state(state, spi, reg);
 	} else {
 		u8 type = STACK_MISC;
 
@@ -1471,8 +1498,7 @@ static int check_stack_write(struct bpf_verifier_env *env,
 			state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
 
 		/* when we zero initialize stack slots mark them as such */
-		if (value_regno >= 0 &&
-		    register_is_null(&cur->regs[value_regno]))
+		if (reg && register_is_null(reg))
 			type = STACK_ZERO;
 
 		/* Mark slots affected by this stack write. */
@@ -1490,6 +1516,7 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE;
+	struct bpf_reg_state *reg;
 	u8 *stype;
 
 	if (reg_state->allocated_stack <= slot) {
@@ -1498,11 +1525,21 @@ static int check_stack_read(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 	stype = reg_state->stack[spi].slot_type;
+	reg = &reg_state->stack[spi].spilled_ptr;
 
 	if (stype[0] == STACK_SPILL) {
 		if (size != BPF_REG_SIZE) {
-			verbose(env, "invalid size of register spill\n");
-			return -EACCES;
+			if (reg->type != SCALAR_VALUE) {
+				verbose_linfo(env, env->insn_idx, "; ");
+				verbose(env, "invalid size of register fill\n");
+				return -EACCES;
+			}
+			if (value_regno >= 0) {
+				mark_reg_unknown(env, state->regs, value_regno);
+				state->regs[value_regno].live |= REG_LIVE_WRITTEN;
+			}
+			mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
+			return 0;
 		}
 		for (i = 1; i < BPF_REG_SIZE; i++) {
 			if (stype[(slot - i) % BPF_REG_SIZE] != STACK_SPILL) {
@@ -1513,17 +1550,14 @@ static int check_stack_read(struct bpf_verifier_env *env,
 
 		if (value_regno >= 0) {
 			/* restore register state from stack */
-			state->regs[value_regno] = reg_state->stack[spi].spilled_ptr;
+			state->regs[value_regno] = *reg;
 			/* mark reg as written since spilled pointer state likely
 			 * has its liveness marks cleared by is_state_visited()
 			 * which resets stack/reg liveness for state transitions
 			 */
 			state->regs[value_regno].live |= REG_LIVE_WRITTEN;
 		}
-		mark_reg_read(env, &reg_state->stack[spi].spilled_ptr,
-			      reg_state->stack[spi].spilled_ptr.parent,
-			      REG_LIVE_READ64);
-		return 0;
+		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
 	} else {
 		int zeros = 0;
 
@@ -1538,9 +1572,7 @@ static int check_stack_read(struct bpf_verifier_env *env,
 				off, i, size);
 			return -EACCES;
 		}
-		mark_reg_read(env, &reg_state->stack[spi].spilled_ptr,
-			      reg_state->stack[spi].spilled_ptr.parent,
-			      REG_LIVE_READ64);
+		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
 		if (value_regno >= 0) {
 			if (zeros == size) {
 				/* any size read into register is zero extended,
@@ -1553,8 +1585,8 @@ static int check_stack_read(struct bpf_verifier_env *env,
 			}
 			state->regs[value_regno].live |= REG_LIVE_WRITTEN;
 		}
-		return 0;
 	}
+	return 0;
 }
 
 static int check_stack_access(struct bpf_verifier_env *env,
@@ -2415,7 +2447,7 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
 {
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_func_state *state = func(env, reg);
-	int err, min_off, max_off, i, slot, spi;
+	int err, min_off, max_off, i, j, slot, spi;
 
 	if (reg->type != PTR_TO_STACK) {
 		/* Allow zero-byte read from NULL, regardless of pointer type */
@@ -2503,6 +2535,14 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
 			*stype = STACK_MISC;
 			goto mark;
 		}
+		if (state->stack[spi].slot_type[0] == STACK_SPILL &&
+		    state->stack[spi].spilled_ptr.type == SCALAR_VALUE) {
+			__mark_reg_unknown(&state->stack[spi].spilled_ptr);
+			for (j = 0; j < BPF_REG_SIZE; j++)
+				state->stack[spi].slot_type[j] = STACK_MISC;
+			goto mark;
+		}
+
 err:
 		if (tnum_is_const(reg->var_off)) {
 			verbose(env, "invalid indirect read from stack off %d+%d size %d\n",
-- 
2.20.0

