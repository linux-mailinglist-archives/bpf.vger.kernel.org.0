Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBE44EFDE1
	for <lists+bpf@lfdr.de>; Sat,  2 Apr 2022 04:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbiDBCBu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Apr 2022 22:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiDBCBu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 22:01:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC771107DE
        for <bpf@vger.kernel.org>; Fri,  1 Apr 2022 18:59:58 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2320C0FS010120
        for <bpf@vger.kernel.org>; Fri, 1 Apr 2022 18:59:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=70srlhutmjnjY9JyfzgBb0DjWeUajsQcCAbsIjPLGyI=;
 b=Jclsz+L00KCZvjCdafSoRGddzLnGeHaCoSwbYEJLDoICGa0iW+Glb2YJxOzxFDt24ZV4
 eUjGD4M8Rxz+lElsg63qx9L1Wi58HjRk0pXYP/rJAtPzghYjmmthJS4cohhU9nSUWI/G
 XSzKzeLYSZtva1oFjOkiloJHBEdhhKXe8sg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f69yn8w4v-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 01 Apr 2022 18:59:58 -0700
Received: from twshared14141.02.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 18:59:55 -0700
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id BD729A790678; Fri,  1 Apr 2022 18:59:43 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 2/7] bpf: Add MEM_RELEASE as a bpf_type_flag
Date:   Fri, 1 Apr 2022 18:58:21 -0700
Message-ID: <20220402015826.3941317-3-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220402015826.3941317-1-joannekoong@fb.com>
References: <20220402015826.3941317-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ywG0R8roB23m9I0mIAAEZkxZ2e_q1e7u
X-Proofpoint-ORIG-GUID: ywG0R8roB23m9I0mIAAEZkxZ2e_q1e7u
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

Currently, we hardcode in the verifier which functions are release
functions. We have no way of differentiating which argument is the one
to be released (we assume it will always be the first argument).

This patch adds MEM_RELEASE as a bpf_type_flag. This allows us to
determine which argument in the function needs to be released, and
removes having to hardcode a list of release functions into the
verifier.

Please note that currently, we only support one release argument in a
helper function. In the future, if/when we need to support several
release arguments within the function, MEM_RELEASE is necessary
since there needs to be a way of differentiating which arguments are the
release ones.

In the near future, MEM_RELEASE will be used by dynptr helper functions
such as bpf_free.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h          |  4 +++-
 include/linux/bpf_verifier.h |  3 +--
 kernel/bpf/btf.c             |  3 ++-
 kernel/bpf/ringbuf.c         |  4 ++--
 kernel/bpf/verifier.c        | 42 ++++++++++++++++++------------------
 net/core/filter.c            |  2 +-
 6 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6f2558da9d4a..cb9f42866cde 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -344,7 +344,9 @@ enum bpf_type_flag {
=20
 	MEM_UNINIT		=3D BIT(5 + BPF_BASE_TYPE_BITS),
=20
-	__BPF_TYPE_LAST_FLAG	=3D MEM_UNINIT,
+	MEM_RELEASE		=3D BIT(6 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	=3D MEM_RELEASE,
 };
=20
 /* Max number of base types. */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c1fc4af47f69..7a01adc9e13f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -523,8 +523,7 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
 		      const struct bpf_reg_state *reg, int regno);
 int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
-			   enum bpf_arg_type arg_type,
-			   bool is_release_func);
+			   enum bpf_arg_type arg_type, bool arg_release);
 int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_re=
g_state *reg,
 			     u32 regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *re=
g,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0918a39279f6..e5b765a84aec 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5830,7 +5830,8 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env,
 		ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
=20
-		ret =3D check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE, rel);
+		ret =3D check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE,
+					     rel && reg->ref_obj_id);
 		if (ret < 0)
 			return ret;
=20
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 710ba9de12ce..a723aa484ce4 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -404,7 +404,7 @@ BPF_CALL_2(bpf_ringbuf_submit, void *, sample, u64, f=
lags)
 const struct bpf_func_proto bpf_ringbuf_submit_proto =3D {
 	.func		=3D bpf_ringbuf_submit,
 	.ret_type	=3D RET_VOID,
-	.arg1_type	=3D ARG_PTR_TO_ALLOC_MEM,
+	.arg1_type	=3D ARG_PTR_TO_ALLOC_MEM | MEM_RELEASE,
 	.arg2_type	=3D ARG_ANYTHING,
 };
=20
@@ -417,7 +417,7 @@ BPF_CALL_2(bpf_ringbuf_discard, void *, sample, u64, =
flags)
 const struct bpf_func_proto bpf_ringbuf_discard_proto =3D {
 	.func		=3D bpf_ringbuf_discard,
 	.ret_type	=3D RET_VOID,
-	.arg1_type	=3D ARG_PTR_TO_ALLOC_MEM,
+	.arg1_type	=3D ARG_PTR_TO_ALLOC_MEM | MEM_RELEASE,
 	.arg2_type	=3D ARG_ANYTHING,
 };
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 90280d5666be..80e53303713e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -471,15 +471,12 @@ static bool type_may_be_null(u32 type)
 	return type & PTR_MAYBE_NULL;
 }
=20
-/* Determine whether the function releases some resources allocated by a=
nother
- * function call. The first reference type argument will be assumed to b=
e
- * released by release_reference().
+/* Determine whether the type releases some resources allocated by a
+ * previous function call.
  */
-static bool is_release_function(enum bpf_func_id func_id)
+static bool type_is_release_mem(u32 type)
 {
-	return func_id =3D=3D BPF_FUNC_sk_release ||
-	       func_id =3D=3D BPF_FUNC_ringbuf_submit ||
-	       func_id =3D=3D BPF_FUNC_ringbuf_discard;
+	return type & MEM_RELEASE;
 }
=20
 static bool may_be_acquire_function(enum bpf_func_id func_id)
@@ -5364,13 +5361,11 @@ static int check_reg_type(struct bpf_verifier_env=
 *env, u32 regno,
=20
 int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
-			   enum bpf_arg_type arg_type,
-			   bool is_release_func)
+			   enum bpf_arg_type arg_type, bool arg_release)
 {
-	bool fixed_off_ok =3D false, release_reg;
-	enum bpf_reg_type type =3D reg->type;
+	bool fixed_off_ok =3D false;
=20
-	switch ((u32)type) {
+	switch ((u32)reg->type) {
 	case SCALAR_VALUE:
 	/* Pointer types where reg offset is explicitly allowed: */
 	case PTR_TO_PACKET:
@@ -5393,18 +5388,15 @@ int check_func_arg_reg_off(struct bpf_verifier_en=
v *env,
 	 * fixed offset.
 	 */
 	case PTR_TO_BTF_ID:
-		/* When referenced PTR_TO_BTF_ID is passed to release function,
-		 * it's fixed offset must be 0. We rely on the property that
-		 * only one referenced register can be passed to BPF helpers and
-		 * kfuncs. In the other cases, fixed offset can be non-zero.
+		/* If a referenced PTR_TO_BTF_ID will be released, its fixed offset
+		 * must be 0.
 		 */
-		release_reg =3D is_release_func && reg->ref_obj_id;
-		if (release_reg && reg->off) {
+		if (arg_release && reg->off) {
 			verbose(env, "R%d must have zero offset when passed to release func\n=
",
 				regno);
 			return -EINVAL;
 		}
-		/* For release_reg =3D=3D true, fixed_off_ok must be false, but we
+		/* For arg_release =3D=3D true, fixed_off_ok must be false, but we
 		 * already checked and rejected reg->off !=3D 0 above, so set to
 		 * true to allow fixed offset for all other cases.
 		 */
@@ -5424,6 +5416,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 	struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regno];
 	enum bpf_arg_type arg_type =3D fn->arg_type[arg];
 	enum bpf_reg_type type =3D reg->type;
+	bool arg_release;
 	int err =3D 0;
=20
 	if (arg_type =3D=3D ARG_DONTCARE)
@@ -5464,7 +5457,14 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
 	if (err)
 		return err;
=20
-	err =3D check_func_arg_reg_off(env, reg, regno, arg_type, is_release_fu=
nction(meta->func_id));
+	arg_release =3D type_is_release_mem(arg_type);
+	if (arg_release && !reg->ref_obj_id) {
+		verbose(env, "R%d arg #%d is an unacquired reference and hence cannot =
be released\n",
+			regno, arg + 1);
+		return -EINVAL;
+	}
+
+	err =3D check_func_arg_reg_off(env, reg, regno, arg_type, arg_release);
 	if (err)
 		return err;
=20
@@ -6693,7 +6693,7 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 			return err;
 	}
=20
-	if (is_release_function(func_id)) {
+	if (meta.ref_obj_id) {
 		err =3D release_reference(env, meta.ref_obj_id);
 		if (err) {
 			verbose(env, "func %s#%d reference has not been acquired before\n",
diff --git a/net/core/filter.c b/net/core/filter.c
index 9aafec3a09ed..a935ce7a63bc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6621,7 +6621,7 @@ static const struct bpf_func_proto bpf_sk_release_p=
roto =3D {
 	.func		=3D bpf_sk_release,
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
-	.arg1_type	=3D ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+	.arg1_type	=3D ARG_PTR_TO_BTF_ID_SOCK_COMMON | MEM_RELEASE,
 };
=20
 BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
--=20
2.30.2

