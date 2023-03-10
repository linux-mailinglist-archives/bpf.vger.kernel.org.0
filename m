Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63D86B5553
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 00:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjCJXIF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 18:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCJXID (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 18:08:03 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544C4CC07
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:07:59 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32AM60nu023368
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:07:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=W74Cdb8SP5/W9C5GE6xabPQ9i9GblOQeXnEmczfbnFM=;
 b=JLBHWpl3Cr4UufbmCQx5pUroHZPVHE/Aq6y3Pg4NcoXeWtn07z29QKPCiaU+p2UDuKPB
 fDWuBy5KBIkiA4DCgAmxigeLix37CtRVsz6I6IoEFYXb1fWIJgy0JxqEpZJ7HvacOqic
 1H8n8RN0dNFSnhpIBky/3apChLNEo0/jrI0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p7p0xhcfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 15:07:58 -0800
Received: from twshared4298.02.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Mar 2023 15:07:56 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id BAB591902A20B; Fri, 10 Mar 2023 15:07:45 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 2/3] bpf: Allow local kptrs to be exchanged via bpf_kptr_xchg
Date:   Fri, 10 Mar 2023 15:07:42 -0800
Message-ID: <20230310230743.2320707-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310230743.2320707-1-davemarchevsky@fb.com>
References: <20230310230743.2320707-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vK_ZUwIrh5mM76S0wCgbedNwtMF71lBz
X-Proofpoint-GUID: vK_ZUwIrh5mM76S0wCgbedNwtMF71lBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The previous patch added necessary plumbing for verifier and runtime to
know what to do with non-kernel PTR_TO_BTF_IDs in map values, but didn't
provide any way to get such local kptrs into a map value. This patch
modifies verifier handling of bpf_kptr_xchg to allow MEM_ALLOC kptr
types.

check_reg_type is modified accept MEM_ALLOC-flagged input to
bpf_kptr_xchg despite such types not being in btf_ptr_types. This could
have been done with a MAYBE_MEM_ALLOC equivalent to MAYBE_NULL, but
bpf_kptr_xchg is the only helper that I can forsee using
MAYBE_MEM_ALLOC, so keep it special-cased for now.

The verifier tags bpf_kptr_xchg retval MEM_ALLOC if and only if the BTF
associated with the retval is not kernel BTF.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 073c56dbec63..519d465407ef 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7123,6 +7123,9 @@ static int check_reg_type(struct bpf_verifier_env *=
env, u32 regno,
 	if (arg_type & PTR_MAYBE_NULL)
 		type &=3D ~PTR_MAYBE_NULL;
=20
+	if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg && type & MEM_ALLOC)
+		type &=3D ~MEM_ALLOC;
+
 	for (i =3D 0; i < ARRAY_SIZE(compatible->types); i++) {
 		expected =3D compatible->types[i];
 		if (expected =3D=3D NOT_INIT)
@@ -7185,7 +7188,8 @@ static int check_reg_type(struct bpf_verifier_env *=
env, u32 regno,
 		break;
 	}
 	case PTR_TO_BTF_ID | MEM_ALLOC:
-		if (meta->func_id !=3D BPF_FUNC_spin_lock && meta->func_id !=3D BPF_FU=
NC_spin_unlock) {
+		if (meta->func_id !=3D BPF_FUNC_spin_lock && meta->func_id !=3D BPF_FU=
NC_spin_unlock &&
+		    meta->func_id !=3D BPF_FUNC_kptr_xchg) {
 			verbose(env, "verifier internal error: unimplemented handling of MEM_=
ALLOC\n");
 			return -EFAULT;
 		}
@@ -9151,6 +9155,8 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 		if (func_id =3D=3D BPF_FUNC_kptr_xchg) {
 			ret_btf =3D meta.kptr_field->kptr.btf;
 			ret_btf_id =3D meta.kptr_field->kptr.btf_id;
+			if (!btf_is_kernel(ret_btf))
+				regs[BPF_REG_0].type |=3D MEM_ALLOC;
 		} else {
 			if (fn->ret_btf_id =3D=3D BPF_PTR_POISON) {
 				verbose(env, "verifier internal error:");
--=20
2.34.1

