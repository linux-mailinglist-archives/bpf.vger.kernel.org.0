Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B120C412A45
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 03:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhIUBdK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Sep 2021 21:33:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46496 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230168AbhIUBcy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Sep 2021 21:32:54 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KHwWqD006002
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 18:31:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=J+Y35pJLVB8iKljp+wn6W8IHV7LMC5bZ8fLbhIwGaDs=;
 b=H7psrf2LdNTvC+xJO8eEabeOWeWV84Sm6NmpuVOMxAgOWZzu33qUVQSSawne3LevV++d
 a6aJpKyv7lUC8MGi3xA//jBLqSHavao8gsKy/U28Mg85PouYJvTyhJH8KLr5lF+tFQ9Y
 g+TtZqiBXVyEvNchiffTDGx/JaSrwV772Zo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b6v27uns2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 18:31:26 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 18:31:25 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 33B4F2940D2A; Mon, 20 Sep 2021 18:31:15 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next 2/4] bpf: Support <8-byte scalar spill and refill
Date:   Mon, 20 Sep 2021 18:31:15 -0700
Message-ID: <20210921013115.1037089-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210921013102.1035356-1-kafai@fb.com>
References: <20210921013102.1035356-1-kafai@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: nJfAx9Xvwli1uxIwUcF_SqZuFLNjjlYQ
X-Proofpoint-ORIG-GUID: nJfAx9Xvwli1uxIwUcF_SqZuFLNjjlYQ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_11,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The verifier currently does not save the reg state when
spilling <8byte bounded scalar to the stack.  The bpf program
will be incorrectly rejected when this scalar is refilled to
the reg and then used to offset into a packet header.
The later patch has a simplified bpf prog from a real use case
to demonstrate this case.  The current work around is
to reparse the packet again such that this offset scalar
is close to where the packet data will be accessed to
avoid the spill.  Thus, the header is parsed twice.

The llvm patch [1] will align the <8bytes spill to
the 8-byte stack address.  This can simplify the verifier
support by avoiding to store multiple reg states for
each 8 byte stack slot.

This patch changes the verifier to save the reg state when
spilling <8bytes scalar to the stack.  This reg state saving
is limited to spill aligned to the 8-byte stack address.
The current refill logic has already called coerce_reg_to_size(),
so coerce_reg_to_size() is not called on state->stack[spi].spilled_ptr
during spill.

When refilling in check_stack_read_fixed_off(),  it checks
the refill size is the same as the number of bytes marked with
STACK_SPILL before restoring the reg state.  When restoring
the reg state to state->regs[dst_regno], it needs
to avoid the state->regs[dst_regno].subreg_def being
over written because it has been marked by the check_reg_arg()
earlier [check_mem_access() is called after check_reg_arg() in
do_check()].  Reordering check_mem_access() and check_reg_arg()
will need a lot of changes in test_verifier's tests because
of the difference in verifier's error message.  Thus, the
patch here is to save the state->regs[dst_regno].subreg_def
first in check_stack_read_fixed_off().

There are cases that the verifier needs to scrub the spilled slot
from STACK_SPILL to STACK_MISC.  After this patch the spill is not always
in 8 bytes now, so it can no longer assume the other 7 bytes are always
marked as STACK_SPILL.  In particular, the scrub needs to avoid marking
an uninitialized byte from STACK_INVALID to STACK_MISC.  Otherwise, the
verifier will incorrectly accept bpf program reading uninitialized bytes
from the stack.  A new helper scrub_spilled_slot() is created for this
purpose.

[1]: https://reviews.llvm.org/D109073

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/verifier.c | 67 +++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2ad2a12c5482..7a8351604f67 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -620,6 +620,12 @@ static bool is_spilled_reg(const struct bpf_stack_stat=
e *stack)
 	return stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_SPILL;
 }
=20
+static void scrub_spilled_slot(u8 *stype)
+{
+	if (*stype !=3D STACK_INVALID)
+		*stype =3D STACK_MISC;
+}
+
 static void print_verifier_state(struct bpf_verifier_env *env,
 				 const struct bpf_func_state *state)
 {
@@ -2634,15 +2640,21 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 }
=20
 static void save_register_state(struct bpf_func_state *state,
-				int spi, struct bpf_reg_state *reg)
+				int spi, struct bpf_reg_state *reg,
+				int size)
 {
 	int i;
=20
 	state->stack[spi].spilled_ptr =3D *reg;
-	state->stack[spi].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
+	if (size =3D=3D BPF_REG_SIZE)
+		state->stack[spi].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
=20
-	for (i =3D 0; i < BPF_REG_SIZE; i++)
-		state->stack[spi].slot_type[i] =3D STACK_SPILL;
+	for (i =3D BPF_REG_SIZE; i > BPF_REG_SIZE - size; i--)
+		state->stack[spi].slot_type[i - 1] =3D STACK_SPILL;
+
+	/* size < 8 bytes spill */
+	for (; i; i--)
+		scrub_spilled_slot(&state->stack[spi].slot_type[i - 1]);
 }
=20
 /* check_stack_{read,write}_fixed_off functions track spill/fill of regist=
ers,
@@ -2689,7 +2701,7 @@ static int check_stack_write_fixed_off(struct bpf_ver=
ifier_env *env,
 			env->insn_aux_data[insn_idx].sanitize_stack_spill =3D true;
 	}
=20
-	if (reg && size =3D=3D BPF_REG_SIZE && register_is_bounded(reg) &&
+	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
 	    !register_is_null(reg) && env->bpf_capable) {
 		if (dst_reg !=3D BPF_REG_FP) {
 			/* The backtracking logic can only recognize explicit
@@ -2702,7 +2714,7 @@ static int check_stack_write_fixed_off(struct bpf_ver=
ifier_env *env,
 			if (err)
 				return err;
 		}
-		save_register_state(state, spi, reg);
+		save_register_state(state, spi, reg, size);
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size !=3D BPF_REG_SIZE) {
@@ -2714,7 +2726,7 @@ static int check_stack_write_fixed_off(struct bpf_ver=
ifier_env *env,
 			verbose(env, "cannot spill pointers to stack into stack frame of the ca=
ller\n");
 			return -EINVAL;
 		}
-		save_register_state(state, spi, reg);
+		save_register_state(state, spi, reg, size);
 	} else {
 		u8 type =3D STACK_MISC;
=20
@@ -2723,7 +2735,7 @@ static int check_stack_write_fixed_off(struct bpf_ver=
ifier_env *env,
 		/* Mark slots as STACK_MISC if they belonged to spilled ptr. */
 		if (is_spilled_reg(&state->stack[spi]))
 			for (i =3D 0; i < BPF_REG_SIZE; i++)
-				state->stack[spi].slot_type[i] =3D STACK_MISC;
+				scrub_spilled_slot(&state->stack[spi].slot_type[i]);
=20
 		/* only mark the slot as written if all 8 bytes were written
 		 * otherwise read propagation may incorrectly stop too soon
@@ -2926,23 +2938,50 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
 	struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
 	int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE;
 	struct bpf_reg_state *reg;
-	u8 *stype;
+	u8 *stype, type;
=20
 	stype =3D reg_state->stack[spi].slot_type;
 	reg =3D &reg_state->stack[spi].spilled_ptr;
=20
 	if (is_spilled_reg(&reg_state->stack[spi])) {
 		if (size !=3D BPF_REG_SIZE) {
+			u8 scalar_size =3D 0;
+
 			if (reg->type !=3D SCALAR_VALUE) {
 				verbose_linfo(env, env->insn_idx, "; ");
 				verbose(env, "invalid size of register fill\n");
 				return -EACCES;
 			}
-			if (dst_regno >=3D 0) {
+
+			mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
+			if (dst_regno < 0)
+				return 0;
+
+			for (i =3D BPF_REG_SIZE; i > 0 && stype[i - 1] =3D=3D STACK_SPILL; i--)
+				scalar_size++;
+
+			if (!(off % BPF_REG_SIZE) && size =3D=3D scalar_size) {
+				/* The earlier check_reg_arg() has decided the
+				 * subreg_def for this insn.  Save it first.
+				 */
+				s32 subreg_def =3D state->regs[dst_regno].subreg_def;
+
+				state->regs[dst_regno] =3D *reg;
+				state->regs[dst_regno].subreg_def =3D subreg_def;
+			} else {
+				for (i =3D 0; i < size; i++) {
+					type =3D stype[(slot - i) % BPF_REG_SIZE];
+					if (type =3D=3D STACK_SPILL)
+						continue;
+					if (type =3D=3D STACK_MISC)
+						continue;
+					verbose(env, "invalid read from stack off %d+%d size %d\n",
+						off, i, size);
+					return -EACCES;
+				}
 				mark_reg_unknown(env, state->regs, dst_regno);
-				state->regs[dst_regno].live |=3D REG_LIVE_WRITTEN;
 			}
-			mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
+			state->regs[dst_regno].live |=3D REG_LIVE_WRITTEN;
 			return 0;
 		}
 		for (i =3D 1; i < BPF_REG_SIZE; i++) {
@@ -2973,8 +3012,6 @@ static int check_stack_read_fixed_off(struct bpf_veri=
fier_env *env,
 		}
 		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
 	} else {
-		u8 type;
-
 		for (i =3D 0; i < size; i++) {
 			type =3D stype[(slot - i) % BPF_REG_SIZE];
 			if (type =3D=3D STACK_MISC)
@@ -4532,7 +4569,7 @@ static int check_stack_range_initialized(
 			if (clobber) {
 				__mark_reg_unknown(env, &state->stack[spi].spilled_ptr);
 				for (j =3D 0; j < BPF_REG_SIZE; j++)
-					state->stack[spi].slot_type[j] =3D STACK_MISC;
+					scrub_spilled_slot(&state->stack[spi].slot_type[j]);
 			}
 			goto mark;
 		}
--=20
2.30.2

