Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3A84EFDE5
	for <lists+bpf@lfdr.de>; Sat,  2 Apr 2022 04:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbiDBCBx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Apr 2022 22:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbiDBCBw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 22:01:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ACB1210B1
        for <bpf@vger.kernel.org>; Fri,  1 Apr 2022 19:00:02 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2320C0Hi010051
        for <bpf@vger.kernel.org>; Fri, 1 Apr 2022 19:00:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=yWyo9wle+OPUYWmhnQNY+u3XNwCfXyzp0jBcCo5nm/I=;
 b=Zrl486P61V95yjEloWZ4vBGU7AUz/lLyJkAzo3FWk8O4MxEy2SpPAIi/wPs+O/rWLhxb
 QQ36Vpf8SOXm/u7eNPsTo7yYEtcziUcxeL/FGc1mclsDeVUhwpg0WYusEPn+CZqmfIXV
 UpcVz3Wf0HJrS+VVRDrOvnRuTy4qxu8GcEY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f69yn8w55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 01 Apr 2022 19:00:01 -0700
Received: from twshared41237.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 19:00:00 -0700
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 26EB5A790680; Fri,  1 Apr 2022 18:59:44 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 6/7] bpf: Dynptr support for ring buffers
Date:   Fri, 1 Apr 2022 18:58:25 -0700
Message-ID: <20220402015826.3941317-7-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220402015826.3941317-1-joannekoong@fb.com>
References: <20220402015826.3941317-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-GUID: hA0Jc5rGP1E40ftJD6lBXSM9ci6vL3t_
X-Proofpoint-ORIG-GUID: hA0Jc5rGP1E40ftJD6lBXSM9ci6vL3t_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_08,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joanne Koong <joannelkoong@gmail.com>

Currently, our only way of writing dynamically-sized data into a ring
buffer is through bpf_ringbuf_output but this incurs an extra memcpy
cost. bpf_ringbuf_reserve + bpf_ringbuf_commit avoids this extra
memcpy, but it can only safely support reservation sizes that are
statically known since the verifier cannot guarantee that the bpf
program won=E2=80=99t access memory outside the reserved space.

The bpf_dynptr abstraction allows for dynamically-sized ring buffer
reservations without the extra memcpy.

There are 3 new APIs:

long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flags, struc=
t bpf_dynptr *ptr);
void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags);
void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags);

These closely follow the functionalities of the original ringbuf APIs.
For example, all ringbuffer dynptrs that have been reserved must be
either submitted or discarded before the program exits.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h            | 10 ++++-
 include/uapi/linux/bpf.h       | 30 ++++++++++++++
 kernel/bpf/helpers.c           |  6 +++
 kernel/bpf/ringbuf.c           | 71 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          | 17 ++++++--
 tools/include/uapi/linux/bpf.h | 30 ++++++++++++++
 6 files changed, 160 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cded9753fb7f..2672360172c5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -352,7 +352,10 @@ enum bpf_type_flag {
 	/* DYNPTR points to dynamically allocated memory. */
 	DYNPTR_TYPE_MALLOC	=3D BIT(8 + BPF_BASE_TYPE_BITS),
=20
-	__BPF_TYPE_LAST_FLAG	=3D DYNPTR_TYPE_MALLOC,
+	/* DYNPTR points to a ringbuf record. */
+	DYNPTR_TYPE_RINGBUF	=3D BIT(9 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	=3D DYNPTR_TYPE_RINGBUF,
 };
=20
 /* Max number of base types. */
@@ -2255,6 +2258,9 @@ extern const struct bpf_func_proto bpf_ringbuf_rese=
rve_proto;
 extern const struct bpf_func_proto bpf_ringbuf_submit_proto;
 extern const struct bpf_func_proto bpf_ringbuf_discard_proto;
 extern const struct bpf_func_proto bpf_ringbuf_query_proto;
+extern const struct bpf_func_proto bpf_ringbuf_reserve_dynptr_proto;
+extern const struct bpf_func_proto bpf_ringbuf_submit_dynptr_proto;
+extern const struct bpf_func_proto bpf_ringbuf_discard_dynptr_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto;
@@ -2418,6 +2424,8 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_LOCAL,
 	/* Memory allocated dynamically by the kernel for the dynptr */
 	BPF_DYNPTR_TYPE_MALLOC,
+	/* Underlying data is a ringbuf record */
+	BPF_DYNPTR_TYPE_RINGBUF,
 };
=20
 /* The upper 4 bits of dynptr->size are reserved. Consequently, the
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c835e437cb28..778de0b052c1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5202,6 +5202,33 @@ union bpf_attr {
  *		Pointer to the underlying dynptr data, NULL if the ptr is
  *		read-only, if the dynptr is invalid, or if the offset and length
  *		is out of bounds.
+ *
+ * long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flags, s=
truct bpf_dynptr *ptr)
+ *	Description
+ *		Reserve *size* bytes of payload in a ring buffer *ringbuf*
+ *		through the dynptr interface. *flags* must be 0.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
+ *
+ * void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags)
+ *	Description
+ *		Submit reserved ring buffer sample, pointed to by *data*,
+ *		through the dynptr interface.
+ *
+ *		For more information on *flags*, please see
+ *		'bpf_ringbuf_submit'.
+ *	Return
+ *		Nothing. Always succeeds.
+ *
+ * void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags)
+ *	Description
+ *		Discard reserved ring buffer sample through the dynptr
+ *		interface.
+ *
+ *		For more information on *flags*, please see
+ *		'bpf_ringbuf_discard'.
+ *	Return
+ *		Nothing. Always succeeds.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5404,6 +5431,9 @@ union bpf_attr {
 	FN(dynptr_read),		\
 	FN(dynptr_write),		\
 	FN(dynptr_data),		\
+	FN(ringbuf_reserve_dynptr),	\
+	FN(ringbuf_submit_dynptr),	\
+	FN(ringbuf_discard_dynptr),	\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c1295fb5d9d4..7b1e467f0504 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1580,6 +1580,12 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_ringbuf_discard_proto;
 	case BPF_FUNC_ringbuf_query:
 		return &bpf_ringbuf_query_proto;
+	case BPF_FUNC_ringbuf_reserve_dynptr:
+		return &bpf_ringbuf_reserve_dynptr_proto;
+	case BPF_FUNC_ringbuf_submit_dynptr:
+		return &bpf_ringbuf_submit_dynptr_proto;
+	case BPF_FUNC_ringbuf_discard_dynptr:
+		return &bpf_ringbuf_discard_dynptr_proto;
 	case BPF_FUNC_for_each_map_elem:
 		return &bpf_for_each_map_elem_proto;
 	case BPF_FUNC_loop:
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index a723aa484ce4..cdbeeb4819ae 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -475,3 +475,74 @@ const struct bpf_func_proto bpf_ringbuf_query_proto =
=3D {
 	.arg1_type	=3D ARG_CONST_MAP_PTR,
 	.arg2_type	=3D ARG_ANYTHING,
 };
+
+BPF_CALL_4(bpf_ringbuf_reserve_dynptr, struct bpf_map *, map, u32, size,=
 u64, flags,
+	   struct bpf_dynptr_kern *, ptr)
+{
+	void *sample;
+	int err;
+
+	err =3D bpf_dynptr_check_size(size);
+	if (err) {
+		bpf_dynptr_set_null(ptr);
+		return err;
+	}
+
+	sample =3D (void *)____bpf_ringbuf_reserve(map, size, flags);
+
+	if (!sample) {
+		bpf_dynptr_set_null(ptr);
+		return -EINVAL;
+	}
+
+	bpf_dynptr_init(ptr, sample, BPF_DYNPTR_TYPE_RINGBUF, 0, size);
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_ringbuf_reserve_dynptr_proto =3D {
+	.func		=3D bpf_ringbuf_reserve_dynptr,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_CONST_MAP_PTR,
+	.arg2_type	=3D ARG_ANYTHING,
+	.arg3_type	=3D ARG_ANYTHING,
+	.arg4_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | MEM_UNINIT,
+};
+
+BPF_CALL_2(bpf_ringbuf_submit_dynptr, struct bpf_dynptr_kern *, ptr, u64=
, flags)
+{
+	if (!ptr->data)
+		return 0;
+
+	____bpf_ringbuf_submit(ptr->data, flags);
+
+	bpf_dynptr_set_null(ptr);
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_ringbuf_submit_dynptr_proto =3D {
+	.func		=3D bpf_ringbuf_submit_dynptr,
+	.ret_type	=3D RET_VOID,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | MEM_RELEASE,
+	.arg2_type	=3D ARG_ANYTHING,
+};
+
+BPF_CALL_2(bpf_ringbuf_discard_dynptr, struct bpf_dynptr_kern *, ptr, u6=
4, flags)
+{
+	if (!ptr->data)
+		return 0;
+
+	____bpf_ringbuf_discard(ptr->data, flags);
+
+	bpf_dynptr_set_null(ptr);
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_ringbuf_discard_dynptr_proto =3D {
+	.func		=3D bpf_ringbuf_discard_dynptr,
+	.ret_type	=3D RET_VOID,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | MEM_RELEASE,
+	.arg2_type	=3D ARG_ANYTHING,
+};
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7352ffb4f9a5..6336476eac7d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -679,7 +679,7 @@ static void mark_verifier_state_scratched(struct bpf_=
verifier_env *env)
=20
 static int arg_to_dynptr_type(enum bpf_arg_type arg_type, enum bpf_dynpt=
r_type *dynptr_type)
 {
-	int type =3D arg_type & (DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_MALLOC);
+	int type =3D arg_type & (DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_MALLOC | DYNPT=
R_TYPE_RINGBUF);
=20
 	switch (type) {
 	case DYNPTR_TYPE_LOCAL:
@@ -688,6 +688,9 @@ static int arg_to_dynptr_type(enum bpf_arg_type arg_t=
ype, enum bpf_dynptr_type *
 	case DYNPTR_TYPE_MALLOC:
 		*dynptr_type =3D BPF_DYNPTR_TYPE_MALLOC;
 		break;
+	case DYNPTR_TYPE_RINGBUF:
+		*dynptr_type =3D BPF_DYNPTR_TYPE_RINGBUF;
+		break;
 	default:
 		/* Can't have more than one type set and can't have no
 		 * type set
@@ -702,7 +705,7 @@ static bool dynptr_type_refcounted(struct bpf_func_st=
ate *state, int spi)
 {
 	enum bpf_dynptr_type type =3D state->stack[spi].spilled_ptr.dynptr_type=
;
=20
-	return type =3D=3D BPF_DYNPTR_TYPE_MALLOC;
+	return type =3D=3D BPF_DYNPTR_TYPE_MALLOC || type =3D=3D BPF_DYNPTR_TYP=
E_RINGBUF;
 }
=20
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg,
@@ -5842,6 +5845,8 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 					err_extra =3D "local ";
 				else if (arg_type & DYNPTR_TYPE_MALLOC)
 					err_extra =3D "malloc ";
+				else if (arg_type & DYNPTR_TYPE_RINGBUF)
+					err_extra =3D "ringbuf ";
 				verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
 					err_extra, arg + 1);
 				return -EINVAL;
@@ -5966,7 +5971,10 @@ static int check_map_func_compatibility(struct bpf=
_verifier_env *env,
 	case BPF_MAP_TYPE_RINGBUF:
 		if (func_id !=3D BPF_FUNC_ringbuf_output &&
 		    func_id !=3D BPF_FUNC_ringbuf_reserve &&
-		    func_id !=3D BPF_FUNC_ringbuf_query)
+		    func_id !=3D BPF_FUNC_ringbuf_query &&
+		    func_id !=3D BPF_FUNC_ringbuf_reserve_dynptr &&
+		    func_id !=3D BPF_FUNC_ringbuf_submit_dynptr &&
+		    func_id !=3D BPF_FUNC_ringbuf_discard_dynptr)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_STACK_TRACE:
@@ -6082,6 +6090,9 @@ static int check_map_func_compatibility(struct bpf_=
verifier_env *env,
 	case BPF_FUNC_ringbuf_output:
 	case BPF_FUNC_ringbuf_reserve:
 	case BPF_FUNC_ringbuf_query:
+	case BPF_FUNC_ringbuf_reserve_dynptr:
+	case BPF_FUNC_ringbuf_submit_dynptr:
+	case BPF_FUNC_ringbuf_discard_dynptr:
 		if (map->map_type !=3D BPF_MAP_TYPE_RINGBUF)
 			goto error;
 		break;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index c835e437cb28..778de0b052c1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5202,6 +5202,33 @@ union bpf_attr {
  *		Pointer to the underlying dynptr data, NULL if the ptr is
  *		read-only, if the dynptr is invalid, or if the offset and length
  *		is out of bounds.
+ *
+ * long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flags, s=
truct bpf_dynptr *ptr)
+ *	Description
+ *		Reserve *size* bytes of payload in a ring buffer *ringbuf*
+ *		through the dynptr interface. *flags* must be 0.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
+ *
+ * void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags)
+ *	Description
+ *		Submit reserved ring buffer sample, pointed to by *data*,
+ *		through the dynptr interface.
+ *
+ *		For more information on *flags*, please see
+ *		'bpf_ringbuf_submit'.
+ *	Return
+ *		Nothing. Always succeeds.
+ *
+ * void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags)
+ *	Description
+ *		Discard reserved ring buffer sample through the dynptr
+ *		interface.
+ *
+ *		For more information on *flags*, please see
+ *		'bpf_ringbuf_discard'.
+ *	Return
+ *		Nothing. Always succeeds.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5404,6 +5431,9 @@ union bpf_attr {
 	FN(dynptr_read),		\
 	FN(dynptr_write),		\
 	FN(dynptr_data),		\
+	FN(ringbuf_reserve_dynptr),	\
+	FN(ringbuf_submit_dynptr),	\
+	FN(ringbuf_discard_dynptr),	\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

