Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3184C6ED55D
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 21:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjDXT3p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 15:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDXT3o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 15:29:44 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5566130E6
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 12:29:39 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OFn02M032311
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 12:29:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=HcZnXbx1+SoTuKuSjwaqgahzFUCNT1T92p90d7iwiYE=;
 b=CyS9mu9J7RoIHLyydV67r8+q23rbu3u+zE34H44a58OmTcbZ1Qbp4HjYWEL7qaW6D/7C
 Fbp+AwGRPPagQa3Oy1bxO5t1RZcDOUrBTLbVMenFYfR+9lMaf7CQg5ld5t7/cQtGmCtO
 uaOUmsAreiUILmaI4VRdMRUVWu2OZPjqhAc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q5vqm1nv2-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 12:29:38 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 12:29:34 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 9DE9C1CBB0FCE; Mon, 24 Apr 2023 12:29:26 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next] bpf: Disable bpf_refcount_acquire kfunc calls until race conditions are fixed
Date:   Mon, 24 Apr 2023 12:29:24 -0700
Message-ID: <20230424192924.1549667-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GTeeCPeOXcFqmpI38W9OebzOeHc18xa_
X-Proofpoint-GUID: GTeeCPeOXcFqmpI38W9OebzOeHc18xa_
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As reported by Kumar in [0], the shared ownership implementation for BPF
programs has some race conditions which need to be addressed before it
can safely be used. This patch does so in a minimal way instead of
ripping out shared ownership entirely, as proper fixes for the issues
raised will follow ASAP, at which point this patch's commit can be
reverted to re-enable shared ownership.

The patch removes the ability to call bpf_refcount_acquire_impl from BPF
programs. Programs can only bump refcount and obtain a new owning
reference using this kfunc, so removing the ability to call it
effectively disables shared ownership.

Instead of changing success / failure expectations for
bpf_refcount-related selftests, this patch just disables them from
running for now.

  [0]: https://lore.kernel.org/bpf/d7hyspcow5wtjcmw4fugdgyp3fwhljwuscp3xyut=
5qnwivyeru@ysdq543otzv2/

Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/helpers.c                          |  1 -
 kernel/bpf/verifier.c                         | 21 +++----------------
 .../bpf/prog_tests/refcounted_kptr.c          |  2 --
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8d368fa353f9..3886b9815a25 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2325,7 +2325,6 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0d73139ee4d8..9926046f30c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9579,7 +9579,6 @@ enum kfunc_ptr_arg_type {
 enum special_kfunc_type {
 	KF_bpf_obj_new_impl,
 	KF_bpf_obj_drop_impl,
-	KF_bpf_refcount_acquire_impl,
 	KF_bpf_list_push_front_impl,
 	KF_bpf_list_push_back_impl,
 	KF_bpf_list_pop_front,
@@ -9600,7 +9599,6 @@ enum special_kfunc_type {
 BTF_SET_START(special_kfunc_set)
 BTF_ID(func, bpf_obj_new_impl)
 BTF_ID(func, bpf_obj_drop_impl)
-BTF_ID(func, bpf_refcount_acquire_impl)
 BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_pop_front)
@@ -9619,7 +9617,6 @@ BTF_SET_END(special_kfunc_set)
 BTF_ID_LIST(special_kfunc_list)
 BTF_ID(func, bpf_obj_new_impl)
 BTF_ID(func, bpf_obj_drop_impl)
-BTF_ID(func, bpf_refcount_acquire_impl)
 BTF_ID(func, bpf_list_push_front_impl)
 BTF_ID(func, bpf_list_push_back_impl)
 BTF_ID(func, bpf_list_pop_front)
@@ -9929,8 +9926,7 @@ static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
=20
 static bool is_bpf_graph_api_kfunc(u32 btf_id)
 {
-	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id) ||
-	       btf_id =3D=3D special_kfunc_list[KF_bpf_refcount_acquire_impl];
+	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id);
 }
=20
 static bool is_callback_calling_kfunc(u32 btf_id)
@@ -10691,8 +10687,7 @@ static int check_kfunc_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 	if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, t)) {
 		/* Only exception is bpf_obj_new_impl */
 		if (meta.btf !=3D btf_vmlinux ||
-		    (meta.func_id !=3D special_kfunc_list[KF_bpf_obj_new_impl] &&
-		     meta.func_id !=3D special_kfunc_list[KF_bpf_refcount_acquire_impl])=
) {
+		    (meta.func_id !=3D special_kfunc_list[KF_bpf_obj_new_impl])) {
 			verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n");
 			return -EINVAL;
 		}
@@ -10740,15 +10735,6 @@ static int check_kfunc_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
 				insn_aux->obj_new_size =3D ret_t->size;
 				insn_aux->kptr_struct_meta =3D
 					btf_find_struct_meta(ret_btf, ret_btf_id);
-			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_refcount_acqui=
re_impl]) {
-				mark_reg_known_zero(env, regs, BPF_REG_0);
-				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
-				regs[BPF_REG_0].btf =3D meta.arg_refcount_acquire.btf;
-				regs[BPF_REG_0].btf_id =3D meta.arg_refcount_acquire.btf_id;
-
-				insn_aux->kptr_struct_meta =3D
-					btf_find_struct_meta(meta.arg_refcount_acquire.btf,
-							     meta.arg_refcount_acquire.btf_id);
 			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_pop_front=
] ||
 				   meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_pop_back]) {
 				struct btf_field *field =3D meta.arg_list_head.field;
@@ -17417,8 +17403,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 		insn_buf[2] =3D addr[1];
 		insn_buf[3] =3D *insn;
 		*cnt =3D 4;
-	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl] =
||
-		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_refcount_acquire_impl]=
) {
+	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl])=
 {
 		struct btf_struct_meta *kptr_struct_meta =3D env->insn_aux_data[insn_idx=
].kptr_struct_meta;
 		struct bpf_insn addr[2] =3D { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_=
meta) };
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/too=
ls/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index 2ab23832062d..595cbf92bff5 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -9,10 +9,8 @@
=20
 void test_refcounted_kptr(void)
 {
-	RUN_TESTS(refcounted_kptr);
 }
=20
 void test_refcounted_kptr_fail(void)
 {
-	RUN_TESTS(refcounted_kptr_fail);
 }
--=20
2.34.1

