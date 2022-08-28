Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251D25A3B1C
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 04:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiH1Cyv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 22:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiH1Cyu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 22:54:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C761F5F51
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:54:48 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27RMxH84028151
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:54:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8T2EXd+gP/VsAo0mC7F1T/ilUu2sGywJmyWoVYxYXmc=;
 b=ALAjcDJTPTUWCxjBsxVxuxacACZLCH8iRCWsCZL2xgvuQUIj46ufpGERIKPIlU9z8STa
 6f1kRwfX3X5EdyUT8e8wwFjRFVeol9AS+T3CWrCbfY6NgTvR3zOsWEu5cJUJn82g+OFe
 dP4L3BVw77PuJc4bvPJMHCmIDkIHYg/ziRc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7jk4am60-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:54:48 -0700
Received: from twshared29104.24.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 27 Aug 2022 19:54:46 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id A90B8EA747E0; Sat, 27 Aug 2022 19:54:43 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 1/7] bpf: Allow struct argument in trampoline based programs
Date:   Sat, 27 Aug 2022 19:54:43 -0700
Message-ID: <20220828025443.143456-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220828025438.142798-1-yhs@fb.com>
References: <20220828025438.142798-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4QbRzpNAA6nzoFANqktOOAJVGIN7MY4_
X-Proofpoint-GUID: 4QbRzpNAA6nzoFANqktOOAJVGIN7MY4_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_10,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow struct argument in trampoline based programs where
the struct size should be <=3D 16 bytes. In such cases, the argument
will be put into up to 2 registers for bpf, x86_64 and arm64
architectures.

To support arch-specific trampoline manipulation,
add arg_flags for additional struct information about arguments
in btf_func_model. Such information will be used in arch specific
function arch_prepare_bpf_trampoline() to prepare argument access
properly in trampoline.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h |  4 ++++
 kernel/bpf/btf.c    | 42 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9c1674973e03..4d32f125f4af 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -727,10 +727,14 @@ enum bpf_cgroup_storage_type {
  */
 #define MAX_BPF_FUNC_REG_ARGS 5
=20
+/* The argument is a structure. */
+#define BTF_FMODEL_STRUCT_ARG		BIT(0)
+
 struct btf_func_model {
 	u8 ret_size;
 	u8 nr_args;
 	u8 arg_size[MAX_BPF_FUNC_ARGS];
+	u8 arg_flags[MAX_BPF_FUNC_ARGS];
 };
=20
 /* Restore arguments before returning from trampoline to let original fu=
nction
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 903719b89238..4a081bfb4c8a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5328,6 +5328,31 @@ static bool is_int_ptr(struct btf *btf, const stru=
ct btf_type *t)
 	return btf_type_is_int(t);
 }
=20
+static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_=
proto,
+			   int off)
+{
+	const struct btf_param *args;
+	const struct btf_type *t;
+	u32 offset =3D 0, nr_args;
+	int i;
+
+	nr_args =3D btf_type_vlen(func_proto);
+	args =3D (const struct btf_param *)(func_proto + 1);
+	for (i =3D 0; i < nr_args; i++) {
+		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
+		offset +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
+		if (off < offset)
+			return i;
+	}
+
+	t =3D btf_type_skip_modifiers(btf, func_proto->type, NULL);
+	offset +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
+	if (off < offset)
+		return nr_args;
+
+	return nr_args + 1;
+}
+
 bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    const struct bpf_prog *prog,
 		    struct bpf_insn_access_aux *info)
@@ -5347,7 +5372,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
 			tname, off);
 		return false;
 	}
-	arg =3D off / 8;
+	arg =3D t =3D=3D NULL ? (off / 8) :  get_ctx_arg_idx(btf, t, off);
 	args =3D (const struct btf_param *)(t + 1);
 	/* if (t =3D=3D NULL) Fall back to default BPF prog with
 	 * MAX_BPF_FUNC_REG_ARGS u64 arguments.
@@ -5417,7 +5442,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
 	/* skip modifiers */
 	while (btf_type_is_modifier(t))
 		t =3D btf_type_by_id(btf, t->type);
-	if (btf_type_is_small_int(t) || btf_is_any_enum(t))
+	if (btf_type_is_small_int(t) || btf_is_any_enum(t) || __btf_type_is_str=
uct(t))
 		/* accessing a scalar */
 		return true;
 	if (!btf_type_is_ptr(t)) {
@@ -5881,7 +5906,7 @@ static int __get_type_size(struct btf *btf, u32 btf=
_id,
 	if (btf_type_is_ptr(t))
 		/* kernel size of pointer. Not BPF's size of pointer*/
 		return sizeof(void *);
-	if (btf_type_is_int(t) || btf_is_any_enum(t))
+	if (btf_type_is_int(t) || btf_is_any_enum(t) || __btf_type_is_struct(t)=
)
 		return t->size;
 	return -EINVAL;
 }
@@ -5901,8 +5926,10 @@ int btf_distill_func_proto(struct bpf_verifier_log=
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
@@ -5916,7 +5943,7 @@ int btf_distill_func_proto(struct bpf_verifier_log =
*log,
 		return -EINVAL;
 	}
 	ret =3D __get_type_size(btf, func->type, &t);
-	if (ret < 0) {
+	if (ret < 0 || __btf_type_is_struct(t)) {
 		bpf_log(log,
 			"The function %s return type %s is unsupported.\n",
 			tname, btf_kind_str[BTF_INFO_KIND(t->info)]);
@@ -5932,7 +5959,9 @@ int btf_distill_func_proto(struct bpf_verifier_log =
*log,
 			return -EINVAL;
 		}
 		ret =3D __get_type_size(btf, args[i].type, &t);
-		if (ret < 0) {
+
+		/* No support of struct argument size greater than 16 bytes */
+		if (ret < 0 || ret > 16) {
 			bpf_log(log,
 				"The function %s arg%d type %s is unsupported.\n",
 				tname, i, btf_kind_str[BTF_INFO_KIND(t->info)]);
@@ -5945,6 +5974,7 @@ int btf_distill_func_proto(struct bpf_verifier_log =
*log,
 			return -EINVAL;
 		}
 		m->arg_size[i] =3D ret;
+		m->arg_flags[i] =3D __btf_type_is_struct(t) ? BTF_FMODEL_STRUCT_ARG : =
0;
 	}
 	m->nr_args =3D nargs;
 	return 0;
--=20
2.30.2

