Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97458182B
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 19:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiGZRMJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 13:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbiGZRMI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 13:12:08 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E811215712
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:12:07 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QFdgF7020190
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:12:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DoYU7s+4Er0VUvH66TE3drbEU+ToApj02lKKEZM+eyA=;
 b=mvMJPCyjHnU+dTR1E8ngh9y5+60K5VOpVJqNqoJLBOg6uqCYJ0vTpsmHAuMOOtWPEXPC
 E/OhM7N29bZIt0UJVOG0Uejknoelr7ZsyXwlqVfUN95KHle7DjUDNB/IFpKeapGOS9ui
 Dr9C1AVXUzYv2DWCU9Kjz3FsyiekmcOFdmw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hgett1xbs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:12:07 -0700
Received: from twshared1866.09.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 10:12:05 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 13EBFD40EB09; Tue, 26 Jul 2022 10:12:02 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 6/7] bpf: Populate struct value info in btf_func_model
Date:   Tue, 26 Jul 2022 10:12:02 -0700
Message-ID: <20220726171202.714640-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726171129.708371-1-yhs@fb.com>
References: <20220726171129.708371-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2-YMM3IVD2pFYeIC7YuuyUrmQqDdo85y
X-Proofpoint-GUID: 2-YMM3IVD2pFYeIC7YuuyUrmQqDdo85y
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_05,2022-07-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add struct value support in btf_ctx_access() and btf_distill_func_proto().
Reject if a struct argument size is greater than 16 as struct size greater =
than
16 likely passed in memory ([1], see function X86_64ABIInfo::postMerge()).

 [1] https://github.com/llvm/llvm-project/blob/main/clang/lib/CodeGen/Targe=
tInfo.cpp

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/btf.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3bbcc985a651..c4c19c89611b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5339,7 +5339,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acces=
s_type type,
 	struct bpf_verifier_log *log =3D info->log;
 	const struct btf_param *args;
 	const char *tag_value;
-	u32 nr_args, arg;
+	u32 nr_args, arg, curr_tid =3D 0;
 	int i, ret;
=20
 	if (off % 8) {
@@ -5385,6 +5385,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acces=
s_type type,
 			 */
 			if (!t)
 				return true;
+			curr_tid =3D t->type;
 			t =3D btf_type_by_id(btf, t->type);
 			break;
 		case BPF_MODIFY_RETURN:
@@ -5394,7 +5395,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acces=
s_type type,
 			if (!t)
 				return false;
=20
-			t =3D btf_type_skip_modifiers(btf, t->type, NULL);
+			t =3D btf_type_skip_modifiers(btf, t->type, &curr_tid);
 			if (!btf_type_is_small_int(t)) {
 				bpf_log(log,
 					"ret type %s not allowed for fmod_ret\n",
@@ -5411,15 +5412,25 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
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
@@ -5878,7 +5889,7 @@ static int __get_type_size(struct btf *btf, u32 btf_i=
d,
 	if (!t)
 		return -EINVAL;
 	*ret_type =3D t;
-	if (btf_type_is_ptr(t))
+	if (btf_type_is_ptr(t) || __btf_type_is_struct(t))
 		/* kernel size of pointer. Not BPF's size of pointer*/
 		return sizeof(void *);
 	if (btf_type_is_int(t) || btf_is_any_enum(t))
@@ -5894,9 +5905,14 @@ int btf_distill_func_proto(struct bpf_verifier_log *=
log,
 {
 	const struct btf_param *args;
 	const struct btf_type *t;
-	u32 i, nargs;
+	u32 i, j =3D 0, nargs;
 	int ret;
=20
+	for (i =3D 0; i < MAX_BPF_FUNC_STRUCT_ARGS; i++) {
+		m->struct_arg_idx[i] =3D 0;
+		m->struct_arg_bsize[i] =3D 0;
+	}
+
 	if (!func) {
 		/* BTF function prototype doesn't match the verifier types.
 		 * Fall back to MAX_BPF_FUNC_REG_ARGS u64 args.
@@ -5944,6 +5960,25 @@ int btf_distill_func_proto(struct bpf_verifier_log *=
log,
 				tname);
 			return -EINVAL;
 		}
+		if (__btf_type_is_struct(t)) {
+			if (t->size > 16) {
+				bpf_log(log,
+					"The function %s arg%d struct size exceeds 16 bytes.\n",
+					tname, i);
+				return -EINVAL;
+			}
+
+			if (j =3D=3D MAX_BPF_FUNC_STRUCT_ARGS) {
+				bpf_log(log,
+					"The function %s has more than %d struct/union args.\n",
+					tname, MAX_BPF_FUNC_STRUCT_ARGS);
+				return -EINVAL;
+			}
+
+			m->struct_arg_idx[j] =3D i;
+			m->struct_arg_bsize[j] =3D t->size;
+			j++;
+		}
 		m->arg_size[i] =3D ret;
 	}
 	m->nr_args =3D nargs;
--=20
2.30.2

