Return-Path: <bpf+bounces-6618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C434476BE82
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78436281B72
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E2E253CE;
	Tue,  1 Aug 2023 20:36:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FEE4DC94
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 20:36:42 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E322106
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 13:36:41 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 371H5w1t023661
	for <bpf@vger.kernel.org>; Tue, 1 Aug 2023 13:36:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=UYjCpGlp2WdTzKY/HBP+jLoXVGfp9zIigCSc6wdSQw8=;
 b=bV7xoL0CWjpfcmzQFt+s9DLcV7MaaPXwKIDoD3HrCutN1LFOMBfwNshpmF94/WcAUFSv
 +L5Qix2fW/eyoMWNaaNmJzv8/aGP8youP9fEccUflQ0t9YPX25MTuvnAncfpWXqwUkUV
 JKGw+mfIm22b/wcPu/qHZjBovLS4A80Z+zg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3s6wjknqtj-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 13:36:40 -0700
Received: from twshared6136.05.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 13:36:38 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 90BD622048673; Tue,  1 Aug 2023 13:36:33 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 1/7] bpf: Ensure kptr_struct_meta is non-NULL for collection insert and refcount_acquire
Date: Tue, 1 Aug 2023 13:36:24 -0700
Message-ID: <20230801203630.3581291-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801203630.3581291-1-davemarchevsky@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nl5QsguhX9q3Jdt0zriyqk5s38H3yP8U
X-Proofpoint-GUID: nl5QsguhX9q3Jdt0zriyqk5s38H3yP8U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_18,2023-08-01_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

It's straightforward to prove that kptr_struct_meta must be non-NULL for
any valid call to these kfuncs:

  * btf_parse_struct_metas in btf.c creates a btf_struct_meta for any
    struct in user BTF with a special field (e.g. bpf_refcount,
    {rb,list}_node). These are stored in that BTF's struct_meta_tab.

  * __process_kf_arg_ptr_to_graph_node in verifier.c ensures that nodes
    have {rb,list}_node field and that it's at the correct offset.
    Similarly, check_kfunc_args ensures bpf_refcount field existence for
    node param to bpf_refcount_acquire.

  * So a btf_struct_meta must have been created for the struct type of
    node param to these kfuncs

  * That BTF and its struct_meta_tab are guaranteed to still be around.
    Any arbitrary {rb,list} node the BPF program interacts with either:
    came from bpf_obj_new or a collection removal kfunc in the same
    program, in which case the BTF is associated with the program and
    still around; or came from bpf_kptr_xchg, in which case the BTF was
    associated with the map and is still around

Instead of silently continuing with NULL struct_meta, which caused
confusing bugs such as those addressed by commit 2140a6e3422d ("bpf: Set
kptr_struct_meta for node param to list and rbtree insert funcs"), let's
error out. Then, at runtime, we can confidently say that the
implementations of these kfuncs were given a non-NULL kptr_struct_meta,
meaning that special-field-specific functionality like
bpf_obj_free_fields and the bpf_obj_drop change introduced later in this
series are guaranteed to execute.

This patch doesn't change functionality, just makes it easier to reason
about existing functionality.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7b1af016841..ec37e84a11c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18271,6 +18271,13 @@ static int fixup_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 		struct btf_struct_meta *kptr_struct_meta =3D env->insn_aux_data[insn_i=
dx].kptr_struct_meta;
 		struct bpf_insn addr[2] =3D { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struc=
t_meta) };
=20
+		if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_refcount_acquire_im=
pl] &&
+		    !kptr_struct_meta) {
+			verbose(env, "verifier internal error: kptr_struct_meta expected at i=
nsn_idx %d\n",
+				insn_idx);
+			return -EFAULT;
+		}
+
 		insn_buf[0] =3D addr[0];
 		insn_buf[1] =3D addr[1];
 		insn_buf[2] =3D *insn;
@@ -18278,6 +18285,7 @@ static int fixup_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_list_push_bac=
k_impl] ||
 		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_list_push_front_impl=
] ||
 		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl]) {
+		struct btf_struct_meta *kptr_struct_meta =3D env->insn_aux_data[insn_i=
dx].kptr_struct_meta;
 		int struct_meta_reg =3D BPF_REG_3;
 		int node_offset_reg =3D BPF_REG_4;
=20
@@ -18287,6 +18295,12 @@ static int fixup_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 			node_offset_reg =3D BPF_REG_5;
 		}
=20
+		if (!kptr_struct_meta) {
+			verbose(env, "verifier internal error: kptr_struct_meta expected at i=
nsn_idx %d\n",
+				insn_idx);
+			return -EFAULT;
+		}
+
 		__fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_=
meta_reg,
 						node_offset_reg, insn, insn_buf, cnt);
 	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_=
ctx] ||
--=20
2.34.1


