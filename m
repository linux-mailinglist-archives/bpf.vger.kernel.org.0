Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D201590B78
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 07:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiHLFYx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 01:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLFYw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 01:24:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BFBA00E4
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:51 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BLdcHA013963
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=W2kitG9IvK8m8vHLDcDAZekjFmUhHc//Sf6vO4wswF4=;
 b=Tml43IBcRtF4rNYLR9Cb91abwTkh5ln3Q5dx5i8aJ+wL2+XA6ryeYMkn1XgH4T1ypfm1
 3iSgYjUgU8buTbaYtRtumB0Dh6AA9S5Id5VWF6/tVL36ExePdUyx3WuICKJFfUPl2b8A
 kdh7EKNK72D8E1fn7ilHXWCr7QNoTd2559k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hw9vgsx3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:51 -0700
Received: from twshared0646.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 11 Aug 2022 22:24:49 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id DCFCDDF8C486; Thu, 11 Aug 2022 22:24:45 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 5/6] bpf: Populate struct argument info in btf_func_model
Date:   Thu, 11 Aug 2022 22:24:45 -0700
Message-ID: <20220812052445.524459-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812052419.520522-1-yhs@fb.com>
References: <20220812052419.520522-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aw88Uq-LH8qvDMD22MMOIMoCFwd7toBj
X-Proofpoint-GUID: aw88Uq-LH8qvDMD22MMOIMoCFwd7toBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_03,2022-08-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add struct argument support in btf_ctx_access() and btf_distill_func_prot=
o().
The arch-specific code will handle whether and how such struct arguments
are supported.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/btf.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 903719b89238..f38ae0e908fd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5339,7 +5339,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
 	struct bpf_verifier_log *log =3D info->log;
 	const struct btf_param *args;
 	const char *tag_value;
-	u32 nr_args, arg;
+	u32 nr_args, arg, curr_tid =3D 0;
 	int i, ret;
=20
 	if (off % 8) {
@@ -5385,6 +5385,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
 			 */
 			if (!t)
 				return true;
+			curr_tid =3D t->type;
 			t =3D btf_type_by_id(btf, t->type);
 			break;
 		case BPF_MODIFY_RETURN:
@@ -5394,7 +5395,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
 			if (!t)
 				return false;
=20
-			t =3D btf_type_skip_modifiers(btf, t->type, NULL);
+			t =3D btf_type_skip_modifiers(btf, t->type, &curr_tid);
 			if (!btf_type_is_small_int(t)) {
 				bpf_log(log,
 					"ret type %s not allowed for fmod_ret\n",
@@ -5411,15 +5412,25 @@ bool btf_ctx_access(int off, int size, enum bpf_a=
ccess_type type,
 		if (!t)
 			/* Default prog with MAX_BPF_FUNC_REG_ARGS args */
 			return true;
+		curr_tid =3D args[arg].type;
 		t =3D btf_type_by_id(btf, args[arg].type);
 	}
=20
 	/* skip modifiers */
-	while (btf_type_is_modifier(t))
+	while (btf_type_is_modifier(t)) {
+		curr_tid =3D t->type;
 		t =3D btf_type_by_id(btf, t->type);
+	}
 	if (btf_type_is_small_int(t) || btf_is_any_enum(t))
 		/* accessing a scalar */
 		return true;
+	if (__btf_type_is_struct(t) && curr_tid) {
+		info->reg_type =3D PTR_TO_BTF_ID;
+		info->btf =3D btf;
+		info->btf_id =3D curr_tid;
+		return true;
+	}
+
 	if (!btf_type_is_ptr(t)) {
 		bpf_log(log,
 			"func '%s' arg%d '%s' has type %s. Only pointer access is allowed\n",
@@ -5878,7 +5889,7 @@ static int __get_type_size(struct btf *btf, u32 btf=
_id,
 	if (!t)
 		return -EINVAL;
 	*ret_type =3D t;
-	if (btf_type_is_ptr(t))
+	if (btf_type_is_ptr(t) || __btf_type_is_struct(t))
 		/* kernel size of pointer. Not BPF's size of pointer*/
 		return sizeof(void *);
 	if (btf_type_is_int(t) || btf_is_any_enum(t))
@@ -5901,8 +5912,10 @@ int btf_distill_func_proto(struct bpf_verifier_log=
 *log,
 		/* BTF function prototype doesn't match the verifier types.
 		 * Fall back to MAX_BPF_FUNC_REG_ARGS u64 args.
 		 */
-		for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
+		for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
 			m->arg_size[i] =3D 8;
+			m->arg_flags[i] =3D 0;
+		}
 		m->ret_size =3D 8;
 		m->nr_args =3D MAX_BPF_FUNC_REG_ARGS;
 		return 0;
@@ -5944,7 +5957,12 @@ int btf_distill_func_proto(struct bpf_verifier_log=
 *log,
 				tname);
 			return -EINVAL;
 		}
-		m->arg_size[i] =3D ret;
+		if (__btf_type_is_struct(t)) {
+			m->arg_flags[i] =3D BTF_FMODEL_STRUCT_ARG;
+			m->arg_size[i] =3D t->size;
+		} else {
+			m->arg_size[i] =3D ret;
+		}
 	}
 	m->nr_args =3D nargs;
 	return 0;
--=20
2.30.2

