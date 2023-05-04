Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55526F6469
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 07:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjEDFeJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 01:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEDFeH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 01:34:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54C71FC9
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 22:34:06 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3440qUlf017028
        for <bpf@vger.kernel.org>; Wed, 3 May 2023 22:34:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=r9s6tunHtJxz3JCJdvJIt+aUgRn9CEJNZ/7pL2SWZYU=;
 b=e/p3Yc+m5p1LdFMKRnFoVU1XbpKO0vO/S+4cb/RgpQfYjfidTbRjVlh8hi8pNXGtGXW/
 vBZeD5nDkUL/C8nPMztNLzDEZYjYie8cDkt4T1L8FTpKaa/CeR1j7nyLtuRyZ21siXpH
 TadXKDfD0lt4Qg70Esho64G1sZndyg6dTKQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3qbkgnfnxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 22:34:05 -0700
Received: from twshared1349.05.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 22:34:04 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 4AF8C1D7BFC54; Wed,  3 May 2023 22:33:46 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 2/9] bpf: Set kptr_struct_meta for node param to list and rbtree insert funcs
Date:   Wed, 3 May 2023 22:33:31 -0700
Message-ID: <20230504053338.1778690-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230504053338.1778690-1-davemarchevsky@fb.com>
References: <20230504053338.1778690-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JIuR-41nxpviloKh3NuGUTP-I-bXk02n
X-Proofpoint-ORIG-GUID: JIuR-41nxpviloKh3NuGUTP-I-bXk02n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_02,2023-05-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In verifier.c, fixup_kfunc_call uses struct bpf_insn_aux_data's
kptr_struct_meta field to pass information about local kptr types to
various helpers and kfuncs at runtime. The recent bpf_refcount series
added a few functions to the set that need this information:

  * bpf_refcount_acquire
    * Needs to know where the refcount field is in order to increment
  * Graph collection insert kfuncs: bpf_rbtree_add, bpf_list_push_{front,=
back}
    * Were migrated to possibly fail by the bpf_refcount series. If
      insert fails, the input node is bpf_obj_drop'd. bpf_obj_drop needs
      the kptr_struct_meta in order to decr refcount and properly free
      special fields.

Unfortunately the verifier handling of collection insert kfuncs was not
modified to actually populate kptr_struct_meta. Accordingly, when the
node input to those kfuncs is passed to bpf_obj_drop, it is done so
without the information necessary to decr refcount.

This patch fixes the issue by populating kptr_struct_meta for those
kfuncs.

Fixes: d2dcc67df910 ("bpf: Migrate bpf_rbtree_add and bpf_list_push_{fron=
t,back} to possibly fail")
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6f39534ded2e..26c072e34834 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -299,6 +299,7 @@ struct bpf_kfunc_call_arg_meta {
 	union {
 		struct btf_and_id arg_obj_drop;
 		struct btf_and_id arg_refcount_acquire;
+		struct btf_and_id arg_graph_node;
 	};
 	struct {
 		struct btf_field *field;
@@ -10158,6 +10159,8 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_ver=
ifier_env *env,
 			node_off, btf_name_by_offset(reg->btf, t->name_off));
 		return -EINVAL;
 	}
+	meta->arg_graph_node.btf =3D reg->btf;
+	meta->arg_graph_node.btf_id =3D reg->btf_id;
=20
 	if (node_off !=3D field->graph_root.node_offset) {
 		verbose(env, "arg#1 offset=3D%d, but expected %s at offset=3D%d in str=
uct %s\n",
@@ -10720,6 +10723,8 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 	    meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 		release_ref_obj_id =3D regs[BPF_REG_2].ref_obj_id;
 		insn_aux->insert_off =3D regs[BPF_REG_2].off;
+		insn_aux->kptr_struct_meta =3D btf_find_struct_meta(meta.arg_graph_nod=
e.btf,
+								  meta.arg_graph_node.btf_id);
 		err =3D ref_convert_owning_non_owning(env, release_ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d conversion of owning ref to non-owning fail=
ed\n",
--=20
2.34.1

