Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E50A45AB4D
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 19:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhKWShi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 13:37:38 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238991AbhKWShi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 13:37:38 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANG8W1u004969
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 10:34:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=s9ydZvLayEn1HLsbySOVy3u56ay367kW4RR8WPXCJ6I=;
 b=oW+W5axOXeqZYKBfOgZJPMww/dDXkhgFFrf0N7M4RGzxwgHv7GFV1+KnGUSxZSgDPwhm
 x4Tq6xmB9bc8lZcT4Uou4+M9x7Nq0dx/dgqKWGBs446CKcvyCbsnxMBRccvh/5zPD47n
 kf8cLfkcDZSh5Ygn8eVKwLrT0kwxkfS7+xA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ch3jah58d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 10:34:30 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 23 Nov 2021 10:34:29 -0800
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 71E2B533D309; Tue, 23 Nov 2021 10:34:21 -0800 (PST)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <Kernel-team@fb.com>, Joanne Koong <joannekoong@fb.com>
Subject: [PATCH v2 bpf-next 1/4] bpf: Add bpf_loop helper
Date:   Tue, 23 Nov 2021 10:34:06 -0800
Message-ID: <20211123183409.3599979-2-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123183409.3599979-1-joannekoong@fb.com>
References: <20211123183409.3599979-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: UYW7Q1jxfrDNVLmxn6Sbcv2qsMFNr6H2
X-Proofpoint-GUID: UYW7Q1jxfrDNVLmxn6Sbcv2qsMFNr6H2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_06,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds the kernel-side and API changes for a new helper
function, bpf_loop:

long bpf_loop(u32 nr_loops, void *callback_fn, void *callback_ctx,
u64 flags);

where long (*callback_fn)(u32 index, void *ctx);

bpf_loop invokes the "callback_fn" **nr_loops** times or until the
callback_fn returns 1. The callback_fn can only return 0 or 1, and
this is enforced by the verifier. The callback_fn index is zero-indexed.

A few things to please note:
~ The "u64 flags" parameter is currently unused but is included in
case a future use case for it arises.
~ In the kernel-side implementation of bpf_loop (kernel/bpf/bpf_iter.c),
bpf_callback_t is used as the callback function cast.
~ A program can have nested bpf_loop calls but the program must
still adhere to the verifier constraint of its stack depth (the stack dep=
th
cannot exceed MAX_BPF_STACK))
~ Recursive callback_fns do not pass the verifier, due to the call stack
for these being too deep.
~ The next patch will include the tests and benchmark

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       | 25 +++++++++
 kernel/bpf/bpf_iter.c          | 35 ++++++++++++
 kernel/bpf/helpers.c           |  2 +
 kernel/bpf/verifier.c          | 97 +++++++++++++++++++++-------------
 tools/include/uapi/linux/bpf.h | 25 +++++++++
 6 files changed, 148 insertions(+), 37 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cc7a0c36e7df..cad0829710be 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2164,6 +2164,7 @@ extern const struct bpf_func_proto bpf_sk_setsockop=
t_proto;
 extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
 extern const struct bpf_func_proto bpf_kallsyms_lookup_name_proto;
 extern const struct bpf_func_proto bpf_find_vma_proto;
+extern const struct bpf_func_proto bpf_loop_proto;
=20
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a69e4b04ffeb..ea37f0ab4231 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4957,6 +4957,30 @@ union bpf_attr {
  *		**-ENOENT** if *task->mm* is NULL, or no vma contains *addr*.
  *		**-EBUSY** if failed to try lock mmap_lock.
  *		**-EINVAL** for invalid **flags**.
+ *
+ * long bpf_loop(u32 nr_loops, void *callback_fn, void *callback_ctx, u6=
4 flags)
+ *	Description
+ *		For **nr_loops**, call **callback_fn** function
+ *		with **callback_ctx** as the context parameter.
+ *		The **callback_fn** should be a static function and
+ *		the **callback_ctx** should be a pointer to the stack.
+ *		The **flags** is used to control certain aspects of the helper.
+ *		Currently, the **flags** must be 0. Currently, nr_loops is
+ *		limited to 1 << 23 (~8 million) loops.
+ *
+ *		long (\*callback_fn)(u32 index, void \*ctx);
+ *
+ *		where **index** is the current index in the loop. The index
+ *		is zero-indexed.
+ *
+ *		If **callback_fn** returns 0, the helper will continue to the next
+ *		loop. If return value is 1, the helper will skip the rest of
+ *		the loops and return. Other return values are not used now,
+ *		and will be rejected by the verifier.
+ *
+ *	Return
+ *		The number of loops performed, **-EINVAL** for invalid **flags** or
+ *		if **nr_loops** exceeds the maximum number of loops.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5140,6 +5164,7 @@ union bpf_attr {
 	FN(skc_to_unix_sock),		\
 	FN(kallsyms_lookup_name),	\
 	FN(find_vma),			\
+	FN(loop),			\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index b2ee45064e06..1a29f650e3e0 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -714,3 +714,38 @@ const struct bpf_func_proto bpf_for_each_map_elem_pr=
oto =3D {
 	.arg3_type	=3D ARG_PTR_TO_STACK_OR_NULL,
 	.arg4_type	=3D ARG_ANYTHING,
 };
+
+/* maximum number of loops */
+#define MAX_LOOPS	BIT(23)
+
+BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callbac=
k_ctx,
+	   u64, flags)
+{
+	bpf_callback_t callback =3D (bpf_callback_t)callback_fn;
+	u64 ret;
+	u32 i;
+
+	if (flags || nr_loops > MAX_LOOPS)
+		return -EINVAL;
+
+	for (i =3D 0; i < nr_loops; i++) {
+		ret =3D callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0);
+		/* return value: 0 - continue, 1 - stop and return */
+		if (ret) {
+			i++;
+			break;
+		}
+	}
+
+	return i;
+}
+
+const struct bpf_func_proto bpf_loop_proto =3D {
+	.func		=3D bpf_loop,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_ANYTHING,
+	.arg2_type	=3D ARG_PTR_TO_FUNC,
+	.arg3_type	=3D ARG_PTR_TO_STACK_OR_NULL,
+	.arg4_type	=3D ARG_ANYTHING,
+};
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1ffd469c217f..52188004a9c3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1378,6 +1378,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_ringbuf_query_proto;
 	case BPF_FUNC_for_each_map_elem:
 		return &bpf_for_each_map_elem_proto;
+	case BPF_FUNC_loop:
+		return &bpf_loop_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0763cca139a7..d674769d411b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6085,6 +6085,27 @@ static int set_map_elem_callback_state(struct bpf_=
verifier_env *env,
 	return 0;
 }
=20
+static int set_loop_callback_state(struct bpf_verifier_env *env,
+				   struct bpf_func_state *caller,
+				   struct bpf_func_state *callee,
+				   int insn_idx)
+{
+	/* bpf_loop(u32 nr_loops, void *callback_fn, void *callback_ctx,
+	 *	    u64 flags);
+	 * callback_fn(u32 index, void *callback_ctx);
+	 */
+	callee->regs[BPF_REG_1].type =3D SCALAR_VALUE;
+	callee->regs[BPF_REG_2] =3D caller->regs[BPF_REG_3];
+
+	/* unused */
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+
+	callee->in_callback_fn =3D true;
+	return 0;
+}
+
 static int set_timer_callback_state(struct bpf_verifier_env *env,
 				    struct bpf_func_state *caller,
 				    struct bpf_func_state *callee,
@@ -6458,13 +6479,7 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 			return err;
 	}
=20
-	if (func_id =3D=3D BPF_FUNC_tail_call) {
-		err =3D check_reference_leak(env);
-		if (err) {
-			verbose(env, "tail_call would lead to reference leak\n");
-			return err;
-		}
-	} else if (is_release_function(func_id)) {
+	if (is_release_function(func_id)) {
 		err =3D release_reference(env, meta.ref_obj_id);
 		if (err) {
 			verbose(env, "func %s#%d reference has not been acquired before\n",
@@ -6475,42 +6490,50 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
=20
 	regs =3D cur_regs(env);
=20
-	/* check that flags argument in get_local_storage(map, flags) is 0,
-	 * this is required because get_local_storage() can't return an error.
-	 */
-	if (func_id =3D=3D BPF_FUNC_get_local_storage &&
-	    !register_is_null(&regs[BPF_REG_2])) {
-		verbose(env, "get_local_storage() doesn't support non-zero flags\n");
-		return -EINVAL;
-	}
-
-	if (func_id =3D=3D BPF_FUNC_for_each_map_elem) {
-		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_map_elem_callback_state);
-		if (err < 0)
+	switch (func_id) {
+	case BPF_FUNC_tail_call:
+		err =3D check_reference_leak(env);
+		if (err) {
+			verbose(env, "tail_call would lead to reference leak\n");
+			return err;
+		}
+		break;
+	case BPF_FUNC_get_local_storage:
+		/* check that flags argument in get_local_storage(map, flags) is 0,
+		 * this is required because get_local_storage() can't return an error.
+		 */
+		if (!register_is_null(&regs[BPF_REG_2])) {
+			verbose(env, "get_local_storage() doesn't support non-zero flags\n");
 			return -EINVAL;
-	}
-
-	if (func_id =3D=3D BPF_FUNC_timer_set_callback) {
+		}
+		err =3D 0;
+		break;
+	case BPF_FUNC_for_each_map_elem:
 		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_timer_callback_state);
-		if (err < 0)
-			return -EINVAL;
-	}
-
-	if (func_id =3D=3D BPF_FUNC_find_vma) {
+					set_map_elem_callback_state) ? -EINVAL : 0;
+		break;
+	case BPF_FUNC_timer_set_callback:
 		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
-					set_find_vma_callback_state);
-		if (err < 0)
-			return -EINVAL;
-	}
-
-	if (func_id =3D=3D BPF_FUNC_snprintf) {
+					set_timer_callback_state) ? -EINVAL : 0;
+		break;
+	case BPF_FUNC_find_vma:
+		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_find_vma_callback_state) ? -EINVAL : 0;
+		break;
+	case BPF_FUNC_snprintf:
 		err =3D check_bpf_snprintf_call(env, regs);
-		if (err < 0)
-			return err;
+		break;
+	case BPF_FUNC_loop:
+		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_loop_callback_state) ? -EINVAL : 0;
+		break;
+	default:
+		err =3D 0;
 	}
=20
+	if (err)
+		return err;
+
 	/* reset caller saved regs */
 	for (i =3D 0; i < CALLER_SAVED_REGS; i++) {
 		mark_reg_not_init(env, regs, caller_saved[i]);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index a69e4b04ffeb..ea37f0ab4231 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4957,6 +4957,30 @@ union bpf_attr {
  *		**-ENOENT** if *task->mm* is NULL, or no vma contains *addr*.
  *		**-EBUSY** if failed to try lock mmap_lock.
  *		**-EINVAL** for invalid **flags**.
+ *
+ * long bpf_loop(u32 nr_loops, void *callback_fn, void *callback_ctx, u6=
4 flags)
+ *	Description
+ *		For **nr_loops**, call **callback_fn** function
+ *		with **callback_ctx** as the context parameter.
+ *		The **callback_fn** should be a static function and
+ *		the **callback_ctx** should be a pointer to the stack.
+ *		The **flags** is used to control certain aspects of the helper.
+ *		Currently, the **flags** must be 0. Currently, nr_loops is
+ *		limited to 1 << 23 (~8 million) loops.
+ *
+ *		long (\*callback_fn)(u32 index, void \*ctx);
+ *
+ *		where **index** is the current index in the loop. The index
+ *		is zero-indexed.
+ *
+ *		If **callback_fn** returns 0, the helper will continue to the next
+ *		loop. If return value is 1, the helper will skip the rest of
+ *		the loops and return. Other return values are not used now,
+ *		and will be rejected by the verifier.
+ *
+ *	Return
+ *		The number of loops performed, **-EINVAL** for invalid **flags** or
+ *		if **nr_loops** exceeds the maximum number of loops.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5140,6 +5164,7 @@ union bpf_attr {
 	FN(skc_to_unix_sock),		\
 	FN(kallsyms_lookup_name),	\
 	FN(find_vma),			\
+	FN(loop),			\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

