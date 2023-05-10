Return-Path: <bpf+bounces-309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9CF6FE653
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 23:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A392815C0
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 21:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD7A1D2D6;
	Wed, 10 May 2023 21:31:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1D921CF5
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 21:31:05 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A8B2716
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 14:30:59 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AHqOkm024239
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 14:30:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=O0a+dfk/ZqJxha0rbLp+Ih+BYX4Xe9mOTc4JUldQM/A=;
 b=LnFXymylKFKk/WhNNHxMVQjx0QfIfF6/BzF2t7eXKVZKAIxRmcMEH80UskUtmnesLl3l
 RT+LJXRY/3zMZlaeHW/lNKHH9NmZiUvG59wIua+jfUDNU+6v4pK7SU40oEWXUpLM+qW/
 cjfVWCZAVdZSm5RpKeWFPh4Cq3wolziRuqo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qgfvbhha4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 14:30:59 -0700
Received: from twshared31955.05.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 14:30:57 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 150901DD8F979; Wed, 10 May 2023 14:30:49 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH bpf-next] bpf: Remove anonymous union in bpf_kfunc_call_arg_meta
Date: Wed, 10 May 2023 14:30:47 -0700
Message-ID: <20230510213047.1633612-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: A3lV0uY2OGt-PBLIqs9efVsauY9H37bn
X-Proofpoint-ORIG-GUID: A3lV0uY2OGt-PBLIqs9efVsauY9H37bn
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For kfuncs like bpf_obj_drop and bpf_refcount_acquire - which take
user-defined types as input - the verifier needs to track the specific
type passed in when checking a particular kfunc call. This requires
tracking (btf, btf_id) tuple. In commit 7c50b1cb76ac
("bpf: Add bpf_refcount_acquire kfunc") I added an anonymous union with
inner structs named after the specific kfuncs tracking this information,
with the goal of making it more obvious which kfunc this data was being
tracked / expected to be tracked on behalf of.

In a recent series adding a new user of this tuple, Alexei mentioned
that he didn't like this union usage as it doesn't really help with
readability or bug-proofing ([0]). In an offline convo we agreed to
have the tuple be fields (arg_btf, arg_btf_id), with comments in
bpf_kfunc_call_arg_meta definition enumerating the uses of the fields by
kfunc-specific handling logic. Such a pattern is used by struct
bpf_reg_state without trouble.

Accordingly, this patch removes the anonymous union in favor of arg_btf
and arg_btf_id fields and comment enumerating their current uses. The
patch also removes struct btf_and_id, which was only being used by the
removed union's inner structs.

This is a mechanical change, existing linked_list and rbtree tests will
validate that correct (btf, btf_id) are being passed.

  [0]: https://lore.kernel.org/bpf/20230505021707.vlyiwy57vwxglbka@dhcp-172=
-26-102-232.dhcp.thefacebook.com

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 754129d41225..5c636276d907 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -279,11 +279,6 @@ struct bpf_call_arg_meta {
 	struct btf_field *kptr_field;
 };
=20
-struct btf_and_id {
-	struct btf *btf;
-	u32 btf_id;
-};
-
 struct bpf_kfunc_call_arg_meta {
 	/* In parameters */
 	struct btf *btf;
@@ -302,10 +297,18 @@ struct bpf_kfunc_call_arg_meta {
 		u64 value;
 		bool found;
 	} arg_constant;
-	union {
-		struct btf_and_id arg_obj_drop;
-		struct btf_and_id arg_refcount_acquire;
-	};
+
+	/* arg_btf and arg_btf_id are used by kfunc-specific handling,
+	 * generally to pass info about user-defined local kptr types to later
+	 * verification logic
+	 *   bpf_obj_drop
+	 *     Record the local kptr type to be drop'd
+	 *   bpf_refcount_acquire (via KF_ARG_PTR_TO_REFCOUNTED_KPTR arg type)
+	 *     Record the local kptr type to be refcount_incr'd
+	 */
+	struct btf *arg_btf;
+	u32 arg_btf_id;
+
 	struct {
 		struct btf_field *field;
 	} arg_list_head;
@@ -10680,8 +10683,8 @@ static int check_kfunc_args(struct bpf_verifier_env=
 *env, struct bpf_kfunc_call_
 			}
 			if (meta->btf =3D=3D btf_vmlinux &&
 			    meta->func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl]) {
-				meta->arg_obj_drop.btf =3D reg->btf;
-				meta->arg_obj_drop.btf_id =3D reg->btf_id;
+				meta->arg_btf =3D reg->btf;
+				meta->arg_btf_id =3D reg->btf_id;
 			}
 			break;
 		case KF_ARG_PTR_TO_DYNPTR:
@@ -10892,8 +10895,8 @@ static int check_kfunc_args(struct bpf_verifier_env=
 *env, struct bpf_kfunc_call_
 				verbose(env, "bpf_refcount_acquire calls are disabled for now\n");
 				return -EINVAL;
 			}
-			meta->arg_refcount_acquire.btf =3D reg->btf;
-			meta->arg_refcount_acquire.btf_id =3D reg->btf_id;
+			meta->arg_btf =3D reg->btf;
+			meta->arg_btf_id =3D reg->btf_id;
 			break;
 		}
 	}
@@ -11125,12 +11128,12 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_refcount_acqui=
re_impl]) {
 				mark_reg_known_zero(env, regs, BPF_REG_0);
 				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
-				regs[BPF_REG_0].btf =3D meta.arg_refcount_acquire.btf;
-				regs[BPF_REG_0].btf_id =3D meta.arg_refcount_acquire.btf_id;
+				regs[BPF_REG_0].btf =3D meta.arg_btf;
+				regs[BPF_REG_0].btf_id =3D meta.arg_btf_id;
=20
 				insn_aux->kptr_struct_meta =3D
-					btf_find_struct_meta(meta.arg_refcount_acquire.btf,
-							     meta.arg_refcount_acquire.btf_id);
+					btf_find_struct_meta(meta.arg_btf,
+							     meta.arg_btf_id);
 			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_pop_front=
] ||
 				   meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_pop_back]) {
 				struct btf_field *field =3D meta.arg_list_head.field;
@@ -11260,8 +11263,8 @@ static int check_kfunc_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 		if (meta.btf =3D=3D btf_vmlinux && btf_id_set_contains(&special_kfunc_se=
t, meta.func_id)) {
 			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl]) {
 				insn_aux->kptr_struct_meta =3D
-					btf_find_struct_meta(meta.arg_obj_drop.btf,
-							     meta.arg_obj_drop.btf_id);
+					btf_find_struct_meta(meta.arg_btf,
+							     meta.arg_btf_id);
 			}
 		}
 	}
--=20
2.34.1


