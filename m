Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5C3413EB7
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 02:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhIVAvP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 20:51:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55698 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhIVAvP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 20:51:15 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLH2LD005458
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 17:49:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3wZL20nAF2XEAAnrU623v+gAeIHh8UoyyXAllPrQ+cg=;
 b=iPqLzS8ohVF7whsMwqM61yMOJGl75WrVlf5ilEOlNu5pGI0t9SC2SRh1GBeAlE1ihNTZ
 h8gfu69keACrvrxEN6P95xLGHgjgJ3X/5ct22A/1sHrfNUQ4W3l5eWlb4kSvSBKFgfhK
 t+CSHGVcm3wAQGjYxqvYSiylCdQ1/lJr8bw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q61h5cr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 17:49:46 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 17:49:44 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id E747429416FF; Tue, 21 Sep 2021 17:49:34 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v2 bpf-next 1/4] bpf: Check the other end of slot_type for STACK_SPILL
Date:   Tue, 21 Sep 2021 17:49:34 -0700
Message-ID: <20210922004934.624194-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922004928.622871-1-kafai@fb.com>
References: <20210922004928.622871-1-kafai@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: _N5zhS9fpvThi9OLncwvzFnG8Di3pLtE
X-Proofpoint-GUID: _N5zhS9fpvThi9OLncwvzFnG8Di3pLtE
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Every 8 bytes of the stack is tracked by a bpf_stack_state.
Within each bpf_stack_state, there is a 'u8 slot_type[8]' to track
the type of each byte.  Verifier tests slot_type[0] =3D=3D STACK_SPILL
to decide if the spilled reg state is saved.  Verifier currently only
saves the reg state if the whole 8 bytes are spilled to the stack,
so checking the slot_type[7] is the same as checking slot_type[0].

The later patch will allow verifier to save the bounded scalar
reg also for <8 bytes spill.  There is a llvm patch [1] to ensure
the <8 bytes spill will be 8-byte aligned,  so checking
slot_type[7] instead of slot_type[0] is required.

While at it, this patch refactors the slot_type[0] =3D=3D STACK_SPILL
test into a new function is_spilled_reg() and change the
slot_type[0] check to slot_type[7] check in there also.

[1] https://reviews.llvm.org/D109073

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/verifier.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e76b55917905..2ad2a12c5482 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -612,6 +612,14 @@ static const char *kernel_type_name(const struct btf* =
btf, u32 id)
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
 }
=20
+/* The reg state of a pointer or a bounded scalar was saved when
+ * it was spilled to the stack.
+ */
+static bool is_spilled_reg(const struct bpf_stack_state *stack)
+{
+	return stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_SPILL;
+}
+
 static void print_verifier_state(struct bpf_verifier_env *env,
 				 const struct bpf_func_state *state)
 {
@@ -717,7 +725,7 @@ static void print_verifier_state(struct bpf_verifier_en=
v *env,
 			continue;
 		verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
 		print_liveness(env, state->stack[i].spilled_ptr.live);
-		if (state->stack[i].slot_type[0] =3D=3D STACK_SPILL) {
+		if (is_spilled_reg(&state->stack[i])) {
 			reg =3D &state->stack[i].spilled_ptr;
 			t =3D reg->type;
 			verbose(env, "=3D%s", reg_type_str[t]);
@@ -2373,7 +2381,7 @@ static void mark_all_scalars_precise(struct bpf_verif=
ier_env *env,
 				reg->precise =3D true;
 			}
 			for (j =3D 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
-				if (func->stack[j].slot_type[0] !=3D STACK_SPILL)
+				if (!is_spilled_reg(&func->stack[j]))
 					continue;
 				reg =3D &func->stack[j].spilled_ptr;
 				if (reg->type !=3D SCALAR_VALUE)
@@ -2415,7 +2423,7 @@ static int __mark_chain_precision(struct bpf_verifier=
_env *env, int regno,
 	}
=20
 	while (spi >=3D 0) {
-		if (func->stack[spi].slot_type[0] !=3D STACK_SPILL) {
+		if (!is_spilled_reg(&func->stack[spi])) {
 			stack_mask =3D 0;
 			break;
 		}
@@ -2514,7 +2522,7 @@ static int __mark_chain_precision(struct bpf_verifier=
_env *env, int regno,
 				return 0;
 			}
=20
-			if (func->stack[i].slot_type[0] !=3D STACK_SPILL) {
+			if (!is_spilled_reg(&func->stack[i])) {
 				stack_mask &=3D ~(1ull << i);
 				continue;
 			}
@@ -2713,7 +2721,7 @@ static int check_stack_write_fixed_off(struct bpf_ver=
ifier_env *env,
 		/* regular write of data into stack destroys any spilled ptr */
 		state->stack[spi].spilled_ptr.type =3D NOT_INIT;
 		/* Mark slots as STACK_MISC if they belonged to spilled ptr. */
-		if (state->stack[spi].slot_type[0] =3D=3D STACK_SPILL)
+		if (is_spilled_reg(&state->stack[spi]))
 			for (i =3D 0; i < BPF_REG_SIZE; i++)
 				state->stack[spi].slot_type[i] =3D STACK_MISC;
=20
@@ -2923,7 +2931,7 @@ static int check_stack_read_fixed_off(struct bpf_veri=
fier_env *env,
 	stype =3D reg_state->stack[spi].slot_type;
 	reg =3D &reg_state->stack[spi].spilled_ptr;
=20
-	if (stype[0] =3D=3D STACK_SPILL) {
+	if (is_spilled_reg(&reg_state->stack[spi])) {
 		if (size !=3D BPF_REG_SIZE) {
 			if (reg->type !=3D SCALAR_VALUE) {
 				verbose_linfo(env, env->insn_idx, "; ");
@@ -4514,11 +4522,11 @@ static int check_stack_range_initialized(
 			goto mark;
 		}
=20
-		if (state->stack[spi].slot_type[0] =3D=3D STACK_SPILL &&
+		if (is_spilled_reg(&state->stack[spi]) &&
 		    state->stack[spi].spilled_ptr.type =3D=3D PTR_TO_BTF_ID)
 			goto mark;
=20
-		if (state->stack[spi].slot_type[0] =3D=3D STACK_SPILL &&
+		if (is_spilled_reg(&state->stack[spi]) &&
 		    (state->stack[spi].spilled_ptr.type =3D=3D SCALAR_VALUE ||
 		     env->allow_ptr_leaks)) {
 			if (clobber) {
@@ -10356,9 +10364,9 @@ static bool stacksafe(struct bpf_verifier_env *env,=
 struct bpf_func_state *old,
 			 * return false to continue verification of this path
 			 */
 			return false;
-		if (i % BPF_REG_SIZE)
+		if (i % BPF_REG_SIZE !=3D BPF_REG_SIZE - 1)
 			continue;
-		if (old->stack[spi].slot_type[0] !=3D STACK_SPILL)
+		if (!is_spilled_reg(&old->stack[spi]))
 			continue;
 		if (!regsafe(env, &old->stack[spi].spilled_ptr,
 			     &cur->stack[spi].spilled_ptr, idmap))
@@ -10565,7 +10573,7 @@ static int propagate_precision(struct bpf_verifier_=
env *env,
 	}
=20
 	for (i =3D 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
-		if (state->stack[i].slot_type[0] !=3D STACK_SPILL)
+		if (!is_spilled_reg(&state->stack[i]))
 			continue;
 		state_reg =3D &state->stack[i].spilled_ptr;
 		if (state_reg->type !=3D SCALAR_VALUE ||
--=20
2.30.2

