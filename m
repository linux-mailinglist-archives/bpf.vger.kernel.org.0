Return-Path: <bpf+bounces-1641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B1771F85F
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 04:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC392819A1
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 02:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C0D15C3;
	Fri,  2 Jun 2023 02:27:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600CD15A3
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 02:27:07 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E6D195
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 19:27:03 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351NtGeN005118
	for <bpf@vger.kernel.org>; Thu, 1 Jun 2023 19:27:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wEpYHCqmxsS8+kFTO4SOb2VhUOHcTo0DuZ5l1z/dDsk=;
 b=RCbA26toQR7gU5ZPnEctfJWyM2Q5HBErsml2165XikRyn0LAVOFEg2jYxoZ/zGVZMyhz
 hixXKtegcnGMdF41fEGTCf0ae8O5Ppx09Y/aSKm96JOS0sD8CySJ7umGuyhYoqXKg6Qs
 N+/wrLaHoXhpbUwymoY5aukuSVTKXyJvlaA= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qxt1kpuad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 19:27:02 -0700
Received: from twshared19038.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 19:27:02 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 19C4A1EF7C8B7; Thu,  1 Jun 2023 19:26:53 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 2/9] bpf: Set kptr_struct_meta for node param to list and rbtree insert funcs
Date: Thu, 1 Jun 2023 19:26:40 -0700
Message-ID: <20230602022647.1571784-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602022647.1571784-1-davemarchevsky@fb.com>
References: <20230602022647.1571784-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qCB4MmxFU26-GOmJaFUENHPSIfwmMb4Z
X-Proofpoint-GUID: qCB4MmxFU26-GOmJaFUENHPSIfwmMb4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0f04e7fe4843..43d26b65a3ad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10475,6 +10475,8 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_ver=
ifier_env *env,
 			node_off, btf_name_by_offset(reg->btf, t->name_off));
 		return -EINVAL;
 	}
+	meta->arg_btf =3D reg->btf;
+	meta->arg_btf_id =3D reg->btf_id;
=20
 	if (node_off !=3D field->graph_root.node_offset) {
 		verbose(env, "arg#1 offset=3D%d, but expected %s at offset=3D%d in str=
uct %s\n",
@@ -11040,6 +11042,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 	    meta.func_id =3D=3D special_kfunc_list[KF_bpf_rbtree_add_impl]) {
 		release_ref_obj_id =3D regs[BPF_REG_2].ref_obj_id;
 		insn_aux->insert_off =3D regs[BPF_REG_2].off;
+		insn_aux->kptr_struct_meta =3D btf_find_struct_meta(meta.arg_btf, meta=
.arg_btf_id);
 		err =3D ref_convert_owning_non_owning(env, release_ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d conversion of owning ref to non-owning fail=
ed\n",
--=20
2.34.1


