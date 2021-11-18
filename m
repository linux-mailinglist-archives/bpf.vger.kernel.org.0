Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C93D4551F8
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 02:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242077AbhKRBJt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 20:09:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38550 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237831AbhKRBJt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 20:09:49 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1AHLe7of032230
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 17:06:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Jj7Z9i/YGp87pxZCtpExCD5y3sA6b0hiIOlmrxfniHA=;
 b=ARdXxxrRc9KlYMC+QPpy31OObZqRqJ9W58Wjwexl5jT8E8Co1/CqlAEHR6QjUEKsD/AS
 Jp6lri2A3G15/3IFcb7mR4gE9HfADZrh6cBY9AHiMTMUx1UwRXOWVTtWWDk7cXjrwS/D
 sGYcRtlZTUCia5wHLLuzPn4STNnyd0uPIFE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3cd3ahvpvq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 17:06:49 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 17:06:48 -0800
Received: by devbig612.frc2.facebook.com (Postfix, from userid 115148)
        id 9A0BA4F5FAD4; Wed, 17 Nov 2021 17:06:47 -0800 (PST)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>,
        Joanne Koong <joannekoong@fb.com>
Subject: [PATCH bpf-next 1/3] bpf: Add bpf_for_each helper
Date:   Wed, 17 Nov 2021 17:04:02 -0800
Message-ID: <20211118010404.2415864-2-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211118010404.2415864-1-joannekoong@fb.com>
References: <20211118010404.2415864-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: USt1ilUgIXwcl6uZqTAH7zI9loMgnbwm
X-Proofpoint-ORIG-GUID: USt1ilUgIXwcl6uZqTAH7zI9loMgnbwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds the kernel-side and API changes for a new helper
function, bpf_for_each:

long bpf_for_each(u32 nr_interations, void *callback_fn,
void *callback_ctx, u64 flags);

bpf_for_each invokes the "callback_fn" nr_iterations number of times
or until the callback_fn returns 1.

A few things to please note:
~ The "u64 flags" parameter is currently unused but is included in
case a future use case for it arises.
~ In the kernel-side implementation of bpf_for_each (kernel/bpf/bpf_iter.=
c),
bpf_callback_t is used as the callback function cast.
~ A program can have nested bpf_for_each calls but the program must
still adhere to the verifier constraint of its stack depth (the stack dep=
th
cannot exceed MAX_BPF_STACK))
~ The next patch will include the tests and benchmark

Signed-off-by: Joanne Koong <joannekoong@fb.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       | 23 +++++++++++++++++++++++
 kernel/bpf/bpf_iter.c          | 32 ++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c           |  2 ++
 kernel/bpf/verifier.c          | 28 ++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 23 +++++++++++++++++++++++
 6 files changed, 109 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6deebf8bf78f..d9b69a896c91 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2107,6 +2107,7 @@ extern const struct bpf_func_proto bpf_get_socket_p=
tr_cookie_proto;
 extern const struct bpf_func_proto bpf_task_storage_get_proto;
 extern const struct bpf_func_proto bpf_task_storage_delete_proto;
 extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
+extern const struct bpf_func_proto bpf_for_each_proto;
 extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
 extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
 extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bd0c9f0487f6..ea5098920ed2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4750,6 +4750,28 @@ union bpf_attr {
  *		The number of traversed map elements for success, **-EINVAL** for
  *		invalid **flags**.
  *
+ * long bpf_for_each(u32 nr_iterations, void *callback_fn, void *callbac=
k_ctx, u64 flags)
+ *	Description
+ *		For **nr_iterations**, call **callback_fn** function with
+ *		**callback_ctx** as the context parameter.
+ *		The **callback_fn** should be a static function and
+ *		the **callback_ctx** should be a pointer to the stack.
+ *		The **flags** is used to control certain aspects of the helper.
+ *		Currently, the **flags** must be 0.
+ *
+ *		long (\*callback_fn)(u32 index, void \*ctx);
+ *
+ *		where **index** is the current index in the iteration. The index
+ *		is zero-indexed.
+ *
+ *		If **callback_fn** returns 0, the helper will continue to the next
+ *		iteration. If return value is 1, the helper will skip the rest of
+ *		the iterations and return. Other return values are not used now.
+ *
+ *	Return
+ *		The number of iterations performed, **-EINVAL** for invalid **flags*=
*
+ *		or a null **callback_fn**.
+ *
  * long bpf_snprintf(char *str, u32 str_size, const char *fmt, u64 *data=
, u32 data_len)
  *	Description
  *		Outputs a string into the **str** buffer of size **str_size**
@@ -5105,6 +5127,7 @@ union bpf_attr {
 	FN(sock_from_file),		\
 	FN(check_mtu),			\
 	FN(for_each_map_elem),		\
+	FN(for_each),			\
 	FN(snprintf),			\
 	FN(sys_bpf),			\
 	FN(btf_find_by_name_kind),	\
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index b2ee45064e06..cb742c50898a 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -714,3 +714,35 @@ const struct bpf_func_proto bpf_for_each_map_elem_pr=
oto =3D {
 	.arg3_type	=3D ARG_PTR_TO_STACK_OR_NULL,
 	.arg4_type	=3D ARG_ANYTHING,
 };
+
+BPF_CALL_4(bpf_for_each, u32, nr_iterations, void *, callback_fn, void *=
, callback_ctx,
+	   u64, flags)
+{
+	bpf_callback_t callback =3D (bpf_callback_t)callback_fn;
+	u64 err;
+	u32 i;
+
+	if (flags)
+		return -EINVAL;
+
+	for (i =3D 0; i < nr_iterations; i++) {
+		err =3D callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0);
+		/* return value: 0 - continue, 1 - stop and return */
+		if (err) {
+			i++;
+			break;
+		}
+	}
+
+	return i;
+}
+
+const struct bpf_func_proto bpf_for_each_proto =3D {
+	.func		=3D bpf_for_each,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_ANYTHING,
+	.arg2_type	=3D ARG_PTR_TO_FUNC,
+	.arg3_type	=3D ARG_PTR_TO_STACK_OR_NULL,
+	.arg4_type	=3D ARG_ANYTHING,
+};
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1ffd469c217f..ac10e1b3859f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1378,6 +1378,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_ringbuf_query_proto;
 	case BPF_FUNC_for_each_map_elem:
 		return &bpf_for_each_map_elem_proto;
+	case BPF_FUNC_for_each:
+		return &bpf_for_each_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3c8aa7df1773..7c9cc4f01104 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6103,6 +6103,27 @@ static int set_map_elem_callback_state(struct bpf_=
verifier_env *env,
 	return 0;
 }
=20
+static int set_for_each_callback_state(struct bpf_verifier_env *env,
+				       struct bpf_func_state *caller,
+				       struct bpf_func_state *callee,
+				       int insn_idx)
+{
+	/* bpf_for_each(u32 nr_iterations, void *callback_fn, void *callback_ct=
x,
+	 *		u64 flags);
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
@@ -6482,6 +6503,13 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 			return -EINVAL;
 	}
=20
+	if (func_id =3D=3D BPF_FUNC_for_each) {
+		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_for_each_callback_state);
+		if (err < 0)
+			return -EINVAL;
+	}
+
 	if (func_id =3D=3D BPF_FUNC_timer_set_callback) {
 		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
 					set_timer_callback_state);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index bd0c9f0487f6..ea5098920ed2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4750,6 +4750,28 @@ union bpf_attr {
  *		The number of traversed map elements for success, **-EINVAL** for
  *		invalid **flags**.
  *
+ * long bpf_for_each(u32 nr_iterations, void *callback_fn, void *callbac=
k_ctx, u64 flags)
+ *	Description
+ *		For **nr_iterations**, call **callback_fn** function with
+ *		**callback_ctx** as the context parameter.
+ *		The **callback_fn** should be a static function and
+ *		the **callback_ctx** should be a pointer to the stack.
+ *		The **flags** is used to control certain aspects of the helper.
+ *		Currently, the **flags** must be 0.
+ *
+ *		long (\*callback_fn)(u32 index, void \*ctx);
+ *
+ *		where **index** is the current index in the iteration. The index
+ *		is zero-indexed.
+ *
+ *		If **callback_fn** returns 0, the helper will continue to the next
+ *		iteration. If return value is 1, the helper will skip the rest of
+ *		the iterations and return. Other return values are not used now.
+ *
+ *	Return
+ *		The number of iterations performed, **-EINVAL** for invalid **flags*=
*
+ *		or a null **callback_fn**.
+ *
  * long bpf_snprintf(char *str, u32 str_size, const char *fmt, u64 *data=
, u32 data_len)
  *	Description
  *		Outputs a string into the **str** buffer of size **str_size**
@@ -5105,6 +5127,7 @@ union bpf_attr {
 	FN(sock_from_file),		\
 	FN(check_mtu),			\
 	FN(for_each_map_elem),		\
+	FN(for_each),			\
 	FN(snprintf),			\
 	FN(sys_bpf),			\
 	FN(btf_find_by_name_kind),	\
--=20
2.30.2

