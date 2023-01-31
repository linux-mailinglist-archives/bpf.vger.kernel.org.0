Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27868349B
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjAaSDV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjAaSCt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:02:49 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41234221
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:02:48 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VGmaGj027305
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:02:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lVqKxdn608vWxRlFLy77OHiQbWO7wTMHsnXhuYOV1GE=;
 b=SM5vsQBgPx3+QdvKnoazID9/GW5hgT68muaUf2Fnfl1WFCkJiPwlSjE7urczUsSupW4n
 TgSz9hCUZzkBBcEXQYYuFsQCamQwM/neOq2FVb+o0zKG6mbJyUFZHzaEN4J1ui9VE0Ni
 pnmxngDGysRvLYKok4f21XKeAPCSaGPZ/CI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nf4c619f4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:02:48 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 31 Jan 2023 10:02:47 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 6B1A915D5BB74; Tue, 31 Jan 2023 10:00:21 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v3 bpf-next 08/11] bpf: Special verifier handling for bpf_rbtree_{remove, first}
Date:   Tue, 31 Jan 2023 10:00:13 -0800
Message-ID: <20230131180016.3368305-9-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230131180016.3368305-1-davemarchevsky@fb.com>
References: <20230131180016.3368305-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: iYFYq2yOU0KfcA1AZygBrPcfcrEHaPhP
X-Proofpoint-ORIG-GUID: iYFYq2yOU0KfcA1AZygBrPcfcrEHaPhP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Newly-added bpf_rbtree_{remove,first} kfuncs have some special properties
that require handling in the verifier:

  * both bpf_rbtree_remove and bpf_rbtree_first return the type containin=
g
    the bpf_rb_node field, with the offset set to that field's offset,
    instead of a struct bpf_rb_node *
    * mark_reg_graph_node helper added in previous patch generalizes
      this logic, use it

  * bpf_rbtree_remove's node input is a node that's been inserted
    in the tree - a non-owning reference.

  * bpf_rbtree_remove must invalidate non-owning references in order to
    avoid aliasing issue. Use previously-added
    invalidate_non_owning_refs helper to mark this function as a
    non-owning ref invalidation point.

  * Unlike other functions, which convert one of their input arg regs to
    non-owning reference, bpf_rbtree_first takes no arguments and just
    returns a non-owning reference (possibly null)
    * For now verifier logic for this is special-cased instead of
      adding new kfunc flag.

This patch, along with the previous one, complete special verifier
handling for all rbtree API functions added in this series.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4a0c38d83eff..460065e75fba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9443,10 +9443,20 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 				verbose(env, "arg#%d expected pointer to allocated object\n", i);
 				return -EINVAL;
 			}
-			if (!reg->ref_obj_id) {
+			if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove]) {
+				if (reg->ref_obj_id) {
+					verbose(env, "rbtree_remove node input must be non-owning ref\n");
+					return -EINVAL;
+				}
+				if (in_rbtree_lock_required_cb(env)) {
+					verbose(env, "rbtree_remove not allowed in rbtree cb\n");
+					return -EINVAL;
+				}
+			} else if (!reg->ref_obj_id) {
 				verbose(env, "allocated object must be referenced\n");
 				return -EINVAL;
 			}
+
 			ret =3D process_kf_arg_ptr_to_rbtree_node(env, reg, regno, meta);
 			if (ret < 0)
 				return ret;
@@ -9691,11 +9701,12 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 				   meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_pop_back]) {
 				struct btf_field *field =3D meta.arg_list_head.field;
=20
-				mark_reg_known_zero(env, regs, BPF_REG_0);
-				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
-				regs[BPF_REG_0].btf =3D field->graph_root.btf;
-				regs[BPF_REG_0].btf_id =3D field->graph_root.value_btf_id;
-				regs[BPF_REG_0].off =3D field->graph_root.node_offset;
+				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
+			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remov=
e] ||
+				   meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_first]) {
+				struct btf_field *field =3D meta.arg_rbtree_root.field;
+
+				mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
 			} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern=
_ctx]) {
 				mark_reg_known_zero(env, regs, BPF_REG_0);
 				regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_TRUSTED;
@@ -9761,7 +9772,13 @@ static int check_kfunc_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
 			if (is_kfunc_ret_null(&meta))
 				regs[BPF_REG_0].id =3D id;
 			regs[BPF_REG_0].ref_obj_id =3D id;
+		} else if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_first]=
) {
+			ref_set_non_owning_lock(env, &regs[BPF_REG_0]);
 		}
+
+		if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_remove])
+			invalidate_non_owning_refs(env, &env->cur_state->active_lock);
+
 		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].i=
d)
 			regs[BPF_REG_0].id =3D ++env->id_gen;
 	} /* else { add_kfunc_call() ensures it is btf_type_is_void(t) } */
--=20
2.30.2

