Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65F46D51B5
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 22:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjDCUB3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 16:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjDCUB2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 16:01:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE54D7
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 13:01:27 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333HMhEV019878
        for <bpf@vger.kernel.org>; Mon, 3 Apr 2023 13:01:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=2Ta2dU20vaOM41HbzD0uPtCkl5UZZ1mOElaAunpyGKY=;
 b=jvvc4smdXLerDInT5p/LNZzDQfafhikSXr9JISuoflw0mpm0A7R1Jmerz/W8Uu5EYmyo
 Wv7zQcsTjm8gWpJSz2EccuQf4PCi2C8W2KVqOq3BzI4Ynpyt5+9C8/eCWoPNMvCVqNVr
 PSi6VSaDHF8gRsRW+q2tMVcvn9z/8T2w1Z0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pqxk23136-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 13:01:27 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 3 Apr 2023 13:00:33 -0700
Received: from twshared8568.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 3 Apr 2023 13:00:32 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 839B51B13701E; Mon,  3 Apr 2023 13:00:28 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next] bpf: Fix struct_meta lookup for bpf_obj_free_fields kfunc call
Date:   Mon, 3 Apr 2023 13:00:27 -0700
Message-ID: <20230403200027.2271029-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: eHXoWJY1BDcI_q9f0w6RFz9baJRcCU74
X-Proofpoint-ORIG-GUID: eHXoWJY1BDcI_q9f0w6RFz9baJRcCU74
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_obj_drop_impl has a void return type. In check_kfunc_call, the "else
if" which sets insn_aux->kptr_struct_meta for bpf_obj_drop_impl is
surrounded by a larger if statement which checks btf_type_is_ptr. As a
result:

  * The bpf_obj_drop_impl-specific code will never execute
  * The btf_struct_meta input to bpf_obj_drop is always NULL
  * __bpf_obj_drop_impl will always see a NULL btf_record when called
    from BPF program, and won't call bpf_obj_free_fields
  * program-allocated kptrs which have fields that should be cleaned up
    by bpf_obj_free_fields may instead leak resources

This patch adds a btf_type_is_void branch to the larger if and moves
special handling for bpf_obj_drop_impl there, fixing the issue.

Fixes: ac9f06050a35 ("bpf: Introduce bpf_obj_drop")
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
This was previously sent to apply against bpf tree
(https://lore.kernel.org/bpf/20230403173125.1056883-1-davemarchevsky@fb.com=
/),
but we decided to go through bpf-next instead.

 kernel/bpf/verifier.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 92ae4e8ab87b..eaf9c5291cf0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10743,10 +10743,6 @@ static int check_kfunc_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
 				insn_aux->obj_new_size =3D ret_t->size;
 				insn_aux->kptr_struct_meta =3D
 					btf_find_struct_meta(ret_btf, ret_btf_id);
-			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl]=
) {
-				insn_aux->kptr_struct_meta =3D
-					btf_find_struct_meta(meta.arg_obj_drop.btf,
-							     meta.arg_obj_drop.btf_id);
 			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_pop_front=
] ||
 				   meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_pop_back]) {
 				struct btf_field *field =3D meta.arg_list_head.field;
@@ -10875,7 +10871,15 @@ static int check_kfunc_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
=20
 		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].id)
 			regs[BPF_REG_0].id =3D ++env->id_gen;
-	} /* else { add_kfunc_call() ensures it is btf_type_is_void(t) } */
+	} else if (btf_type_is_void(t)) {
+		if (meta.btf =3D=3D btf_vmlinux && btf_id_set_contains(&special_kfunc_se=
t, meta.func_id)) {
+			if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_obj_drop_impl]) {
+				insn_aux->kptr_struct_meta =3D
+					btf_find_struct_meta(meta.arg_obj_drop.btf,
+							     meta.arg_obj_drop.btf_id);
+			}
+		}
+	}
=20
 	nargs =3D btf_type_vlen(meta.func_proto);
 	args =3D (const struct btf_param *)(meta.func_proto + 1);
--=20
2.34.1

