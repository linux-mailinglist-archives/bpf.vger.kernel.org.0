Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0202547619F
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 20:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbhLOTXF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 14:23:05 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11426 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344229AbhLOTXF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Dec 2021 14:23:05 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BFIA816012970
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 11:23:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=cF+aQbKVEthbstoBYSDFUKdzzwx8zRd7I4sf7WF4fUU=;
 b=qhq7On5/8fy+OaoXXCVDqZndexUZtbnS77AJStLa1U6Qz+o0yB56i6Y5iGh2tJ+RvGNJ
 aISeLrMkn9XPuIJgx3F945msVHhf/zkAB4+yDHwRlS3zpCl+TEQ6/2pIsD3zqjYGk4Op
 m4MN7EKtJ4tLj6QKDzlvIefvFygwlIx0wZk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cyga3u5ha-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 11:23:04 -0800
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 11:22:56 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 086B66B96BC; Wed, 15 Dec 2021 11:22:46 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>, <christylee@fb.com>,
        <christyc.y.lee@gmail.com>
Subject: [PATCH v2 bpf-next 1/3] Only print scratched registers and stack slots to verifier logs
Date:   Wed, 15 Dec 2021 11:22:23 -0800
Message-ID: <20211215192225.1278237-2-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215192225.1278237-1-christylee@fb.com>
References: <20211215192225.1278237-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 6TJF8cmSPI_SfXY3kS6-O4QBVjCDL0mL
X-Proofpoint-GUID: 6TJF8cmSPI_SfXY3kS6-O4QBVjCDL0mL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_11,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When printing verifier state for any log level, print full verifier
state only on function calls or on errors. Otherwise, only print the
registers and stack slots that were accessed.

Log size differences:

verif_scale_loop6 before: 234566564
verif_scale_loop6 after: 72143943
69% size reduction

kfree_skb before: 166406
kfree_skb after: 55386
69% size reduction

Before:

156: (61) r0 =3D *(u32 *)(r1 +0)
157: R0_w=3DinvP(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xfffffff=
f)) R1=3Dctx(id=3D0,off=3D0,imm=3D0) R2_w=3DinvP0 R10=3Dfp0 fp-8_w=3D0000=
0000 fp-16_w=3D00\
000000 fp-24_w=3D00000000 fp-32_w=3D00000000 fp-40_w=3D00000000 fp-48_w=3D=
00000000 fp-56_w=3D00000000 fp-64_w=3D00000000 fp-72_w=3D00000000 fp-80_w=
=3D00000\
000 fp-88_w=3D00000000 fp-96_w=3D00000000 fp-104_w=3D00000000 fp-112_w=3D=
00000000 fp-120_w=3D00000000 fp-128_w=3D00000000 fp-136_w=3D00000000 fp-1=
44_w=3D00\
000000 fp-152_w=3D00000000 fp-160_w=3D00000000 fp-168_w=3D00000000 fp-176=
_w=3D00000000 fp-184_w=3D00000000 fp-192_w=3D00000000 fp-200_w=3D00000000=
 fp-208\
_w=3D00000000 fp-216_w=3D00000000 fp-224_w=3D00000000 fp-232_w=3D00000000=
 fp-240_w=3D00000000 fp-248_w=3D00000000 fp-256_w=3D00000000 fp-264_w=3D0=
0000000 f\
p-272_w=3D00000000 fp-280_w=3D00000000 fp-288_w=3D00000000 fp-296_w=3D000=
00000 fp-304_w=3D00000000 fp-312_w=3D00000000 fp-320_w=3D00000000 fp-328_=
w=3D00000\
000 fp-336_w=3D00000000 fp-344_w=3D00000000 fp-352_w=3D00000000 fp-360_w=3D=
00000000 fp-368_w=3D00000000 fp-376_w=3D00000000 fp-384_w=3D00000000 fp-3=
92_w=3D\
00000000 fp-400_w=3D00000000 fp-408_w=3D00000000 fp-416_w=3D00000000 fp-4=
24_w=3D00000000 fp-432_w=3D00000000 fp-440_w=3D00000000 fp-448_w=3D000000=
00
; return skb->len;
157: (95) exit
Func#4 is safe for any args that match its prototype
Validating get_constant() func#5...
158: R1=3DinvP(id=3D0) R10=3Dfp0
; int get_constant(long val)
158: (bf) r0 =3D r1
159: R0_w=3DinvP(id=3D1) R1=3DinvP(id=3D1) R10=3Dfp0
; return val - 122;
159: (04) w0 +=3D -122
160: R0_w=3DinvP(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xfffffff=
f)) R1=3DinvP(id=3D1) R10=3Dfp0
; return val - 122;
160: (95) exit
Func#5 is safe for any args that match its prototype
Validating get_skb_ifindex() func#6...
161: R1=3DinvP(id=3D0) R2=3Dctx(id=3D0,off=3D0,imm=3D0) R3=3DinvP(id=3D0)=
 R10=3Dfp0
; int get_skb_ifindex(int val, struct __sk_buff *skb, int var)
161: (bc) w0 =3D w3
162: R0_w=3DinvP(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xfffffff=
f)) R1=3DinvP(id=3D0) R2=3Dctx(id=3D0,off=3D0,imm=3D0) R3=3DinvP(id=3D0) =
R10=3Dfp0

After:

156: (61) r0 =3D *(u32 *)(r1 +0)
157: R0_w=3DinvP(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xfffffff=
f)) R1=3Dctx(id=3D0,off=3D0,imm=3D0)
; return skb->len;
157: (95) exit
Func#4 is safe for any args that match its prototype
Validating get_constant() func#5...
158: R1=3DinvP(id=3D0) R10=3Dfp0
; int get_constant(long val)
158: (bf) r0 =3D r1
159: R0_w=3DinvP(id=3D1) R1=3DinvP(id=3D1)
; return val - 122;
159: (04) w0 +=3D -122
160: R0_w=3DinvP(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xfffffff=
f))
; return val - 122;
160: (95) exit
Func#5 is safe for any args that match its prototype
Validating get_skb_ifindex() func#6...
161: R1=3DinvP(id=3D0) R2=3Dctx(id=3D0,off=3D0,imm=3D0) R3=3DinvP(id=3D0)=
 R10=3Dfp0
; int get_skb_ifindex(int val, struct __sk_buff *skb, int var)
161: (bc) w0 =3D w3
162: R0_w=3DinvP(id=3D0,umax_value=3D4294967295,var_off=3D(0x0; 0xfffffff=
f)) R3=3DinvP(id=3D0)

Signed-off-by: Christy Lee <christylee@fb.com>
---
 include/linux/bpf_verifier.h                  |  7 +++
 kernel/bpf/verifier.c                         | 62 ++++++++++++++++++-
 .../testing/selftests/bpf/prog_tests/align.c  | 30 ++++-----
 3 files changed, 82 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 182b16a91084..c555222c97d6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -474,6 +474,13 @@ struct bpf_verifier_env {
 	/* longest register parentage chain walked for liveness marking */
 	u32 longest_mark_read_walk;
 	bpfptr_t fd_array;
+
+	/* bit mask to keep track of whether a register has been accessed
+	 * since the last time the function state was pritned
+	 */
+	u32 scratched_regs;
+	/* Same as scratched_regs but for stack slots */
+	u64 scratched_stack_slots;
 };
=20
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d74e8a99412e..f4228864a3e9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -608,6 +608,44 @@ static const char *kernel_type_name(const struct btf=
* btf, u32 id)
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
 }
=20
+static void mark_reg_scratched(struct bpf_verifier_env *env, u32 regno)
+{
+	env->scratched_regs |=3D 1U << regno;
+}
+
+static void mark_stack_slot_scratched(struct bpf_verifier_env *env, u32 =
spi)
+{
+	env->scratched_stack_slots |=3D 1UL << spi;
+}
+
+static bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
+{
+	return (env->scratched_regs >> regno) & 1;
+}
+
+static bool stack_slot_scratched(const struct bpf_verifier_env *env, u64=
 regno)
+{
+	return (env->scratched_stack_slots >> regno) & 1;
+}
+
+static bool verifier_state_scratched(const struct bpf_verifier_env *env)
+{
+	return env->scratched_regs || env->scratched_stack_slots;
+}
+
+static void mark_verifier_state_clean(struct bpf_verifier_env *env)
+{
+	env->scratched_regs =3D 0U;
+	env->scratched_stack_slots =3D 0UL;
+}
+
+/* Used for printing the entire verifier state. */
+static void mark_verifier_state_scratched(struct bpf_verifier_env *env)
+{
+	env->scratched_regs =3D ~0U;
+	env->scratched_stack_slots =3D ~0UL;
+}
+
 /* The reg state of a pointer or a bounded scalar was saved when
  * it was spilled to the stack.
  */
@@ -636,6 +674,8 @@ static void print_verifier_state(struct bpf_verifier_=
env *env,
 		t =3D reg->type;
 		if (t =3D=3D NOT_INIT)
 			continue;
+		if (!reg_scratched(env, i))
+			continue;
 		verbose(env, " R%d", i);
 		print_liveness(env, reg->live);
 		verbose(env, "=3D%s", reg_type_str[t]);
@@ -725,6 +765,8 @@ static void print_verifier_state(struct bpf_verifier_=
env *env,
 		types_buf[BPF_REG_SIZE] =3D 0;
 		if (!valid)
 			continue;
+		if (!stack_slot_scratched(env, i))
+			continue;
 		verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
 		print_liveness(env, state->stack[i].spilled_ptr.live);
 		if (is_spilled_reg(&state->stack[i])) {
@@ -750,6 +792,7 @@ static void print_verifier_state(struct bpf_verifier_=
env *env,
 	if (state->in_async_callback_fn)
 		verbose(env, " async_cb");
 	verbose(env, "\n");
+	mark_verifier_state_clean(env);
 }
=20
 /* copy array src of length n * size bytes to dst. dst is reallocated if=
 it's too
@@ -1540,6 +1583,7 @@ static void init_func_state(struct bpf_verifier_env=
 *env,
 	state->frameno =3D frameno;
 	state->subprogno =3D subprogno;
 	init_reg_state(env, state);
+	mark_verifier_state_scratched(env);
 }
=20
 /* Similar to push_stack(), but for async callbacks */
@@ -2227,6 +2271,8 @@ static int check_reg_arg(struct bpf_verifier_env *e=
nv, u32 regno,
 		return -EINVAL;
 	}
=20
+	mark_reg_scratched(env, regno);
+
 	reg =3D &regs[regno];
 	rw64 =3D is_reg64(env, insn, regno, reg, t);
 	if (t =3D=3D SRC_OP) {
@@ -2836,6 +2882,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
 			env->insn_aux_data[insn_idx].sanitize_stack_spill =3D true;
 	}
=20
+	mark_stack_slot_scratched(env, spi);
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
 	    !register_is_null(reg) && env->bpf_capable) {
 		if (dst_reg !=3D BPF_REG_FP) {
@@ -2957,6 +3004,7 @@ static int check_stack_write_var_off(struct bpf_ver=
ifier_env *env,
 		slot =3D -i - 1;
 		spi =3D slot / BPF_REG_SIZE;
 		stype =3D &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
+		mark_stack_slot_scratched(env, spi);
=20
 		if (!env->allow_ptr_leaks
 				&& *stype !=3D NOT_INIT
@@ -6009,8 +6057,10 @@ static int __check_func_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 	*insn_idx =3D env->subprog_info[subprog].start - 1;
=20
 	if (env->log.level & BPF_LOG_LEVEL) {
+		mark_verifier_state_scratched(env);
 		verbose(env, "caller:\n");
 		print_verifier_state(env, caller);
+		mark_verifier_state_scratched(env);
 		verbose(env, "callee:\n");
 		print_verifier_state(env, callee);
 	}
@@ -6226,8 +6276,10 @@ static int prepare_func_exit(struct bpf_verifier_e=
nv *env, int *insn_idx)
=20
 	*insn_idx =3D callee->callsite + 1;
 	if (env->log.level & BPF_LOG_LEVEL) {
+		mark_verifier_state_scratched(env);
 		verbose(env, "returning from callee:\n");
 		print_verifier_state(env, callee);
+		mark_verifier_state_scratched(env);
 		verbose(env, "to caller at %d:\n", *insn_idx);
 		print_verifier_state(env, caller);
 	}
@@ -8248,11 +8300,13 @@ static int adjust_reg_min_max_vals(struct bpf_ver=
ifier_env *env,
=20
 	/* Got here implies adding two SCALAR_VALUEs */
 	if (WARN_ON_ONCE(ptr_reg)) {
+		mark_verifier_state_scratched(env);
 		print_verifier_state(env, state);
 		verbose(env, "verifier internal error: unexpected ptr_reg\n");
 		return -EINVAL;
 	}
 	if (WARN_ON(!src_reg)) {
+		mark_verifier_state_scratched(env);
 		print_verifier_state(env, state);
 		verbose(env, "verifier internal error: no src_reg\n");
 		return -EINVAL;
@@ -11256,9 +11310,10 @@ static int do_check(struct bpf_verifier_env *env=
)
 		if (need_resched())
 			cond_resched();
=20
-		if (env->log.level & BPF_LOG_LEVEL2 ||
+		if ((env->log.level & BPF_LOG_LEVEL2) ||
 		    (env->log.level & BPF_LOG_LEVEL && do_print_state)) {
-			if (env->log.level & BPF_LOG_LEVEL2)
+			if (verifier_state_scratched(env) &&
+			    (env->log.level & BPF_LOG_LEVEL2))
 				verbose(env, "%d:", env->insn_idx);
 			else
 				verbose(env, "\nfrom %d to %d%s:",
@@ -11487,6 +11542,7 @@ static int do_check(struct bpf_verifier_env *env)
 				if (err)
 					return err;
 process_bpf_exit:
+				mark_verifier_state_scratched(env);
 				update_branch_counts(env, env->cur_state);
 				err =3D pop_stack(env, &prev_insn_idx,
 						&env->insn_idx, pop_log);
@@ -14147,6 +14203,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr)
 		}
 	}
=20
+	mark_verifier_state_clean(env);
+
 	if (IS_ERR(btf_vmlinux)) {
 		/* Either gcc or pahole or kernel are broken. */
 		verbose(env, "in-kernel BTF is malformed\n");
diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testi=
ng/selftests/bpf/prog_tests/align.c
index 837f67c6bfda..aeb2080a67f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -39,8 +39,8 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{1, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
-			{1, "R10=3Dfp0"},
+			{0, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
+			{0, "R10=3Dfp0"},
 			{1, "R3_w=3Dinv2"},
 			{2, "R3_w=3Dinv4"},
 			{3, "R3_w=3Dinv8"},
@@ -67,8 +67,8 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{1, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
-			{1, "R10=3Dfp0"},
+			{0, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
+			{0, "R10=3Dfp0"},
 			{1, "R3_w=3Dinv1"},
 			{2, "R3_w=3Dinv2"},
 			{3, "R3_w=3Dinv4"},
@@ -96,8 +96,8 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{1, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
-			{1, "R10=3Dfp0"},
+			{0, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
+			{0, "R10=3Dfp0"},
 			{1, "R3_w=3Dinv4"},
 			{2, "R3_w=3Dinv8"},
 			{3, "R3_w=3Dinv10"},
@@ -118,8 +118,8 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{1, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
-			{1, "R10=3Dfp0"},
+			{0, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
+			{0, "R10=3Dfp0"},
 			{1, "R3_w=3Dinv7"},
 			{2, "R3_w=3Dinv7"},
 			{3, "R3_w=3Dinv14"},
@@ -161,13 +161,13 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{7, "R0_w=3Dpkt(id=3D0,off=3D8,r=3D8,imm=3D0)"},
+			{6, "R0_w=3Dpkt(id=3D0,off=3D8,r=3D8,imm=3D0)"},
 			{7, "R3_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
 			{8, "R3_w=3Dinv(id=3D0,umax_value=3D510,var_off=3D(0x0; 0x1fe))"},
 			{9, "R3_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
 			{10, "R3_w=3Dinv(id=3D0,umax_value=3D2040,var_off=3D(0x0; 0x7f8))"},
 			{11, "R3_w=3Dinv(id=3D0,umax_value=3D4080,var_off=3D(0x0; 0xff0))"},
-			{18, "R3=3Dpkt_end(id=3D0,off=3D0,imm=3D0)"},
+			{13, "R3_w=3Dpkt_end(id=3D0,off=3D0,imm=3D0)"},
 			{18, "R4_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
 			{19, "R4_w=3Dinv(id=3D0,umax_value=3D8160,var_off=3D(0x0; 0x1fe0))"},
 			{20, "R4_w=3Dinv(id=3D0,umax_value=3D4080,var_off=3D(0x0; 0xff0))"},
@@ -234,10 +234,10 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{4, "R5_w=3Dpkt(id=3D0,off=3D0,r=3D0,imm=3D0)"},
+			{3, "R5_w=3Dpkt(id=3D0,off=3D0,r=3D0,imm=3D0)"},
 			{5, "R5_w=3Dpkt(id=3D0,off=3D14,r=3D0,imm=3D0)"},
 			{6, "R4_w=3Dpkt(id=3D0,off=3D14,r=3D0,imm=3D0)"},
-			{10, "R2=3Dpkt(id=3D0,off=3D0,r=3D18,imm=3D0)"},
+			{9, "R2=3Dpkt(id=3D0,off=3D0,r=3D18,imm=3D0)"},
 			{10, "R5=3Dpkt(id=3D0,off=3D14,r=3D18,imm=3D0)"},
 			{10, "R4_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
 			{14, "R4_w=3Dinv(id=3D0,umax_value=3D65535,var_off=3D(0x0; 0xffff))"}=
,
@@ -296,7 +296,7 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{8, "R2_w=3Dpkt(id=3D0,off=3D0,r=3D8,imm=3D0)"},
+			{6, "R2_w=3Dpkt(id=3D0,off=3D0,r=3D8,imm=3D0)"},
 			{8, "R6_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
 			/* Offset is added to packet pointer R5, resulting in
 			 * known fixed offset, and variable offset from R6.
@@ -386,7 +386,7 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{8, "R2_w=3Dpkt(id=3D0,off=3D0,r=3D8,imm=3D0)"},
+			{6, "R2_w=3Dpkt(id=3D0,off=3D0,r=3D8,imm=3D0)"},
 			{8, "R6_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
 			/* Adding 14 makes R6 be (4n+2) */
 			{9, "R6_w=3Dinv(id=3D0,umin_value=3D14,umax_value=3D1034,var_off=3D(0=
x2; 0x7fc))"},
@@ -458,7 +458,7 @@ static struct bpf_align_test tests[] =3D {
 			/* Checked s>=3D0 */
 			{9, "R5=3Dinv(id=3D0,umin_value=3D2,umax_value=3D9223372036854775806,=
var_off=3D(0x2; 0x7ffffffffffffffc)"},
 			/* packet pointer + nonnegative (4n+2) */
-			{11, "R6_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin_value=3D2,umax_value=3D922=
3372036854775806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
+			{12, "R6_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin_value=3D2,umax_value=3D922=
3372036854775806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
 			{13, "R4_w=3Dpkt(id=3D1,off=3D4,r=3D0,umin_value=3D2,umax_value=3D922=
3372036854775806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
 			/* NET_IP_ALIGN + (4n+2) =3D=3D (4n), alignment is fine.
 			 * We checked the bounds, but it might have been able
--=20
2.30.2

