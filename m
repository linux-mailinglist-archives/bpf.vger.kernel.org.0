Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DC85A812D
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 17:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiHaP04 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 11:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiHaP0z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 11:26:55 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF3CD7D22
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:26:54 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VEhAAn031631
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:26:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Ykg+0GYpl2cJ4uvzmvvMjqpS5RGAGHKbLyF6fJH22OE=;
 b=aE03PVs9uGBaUj0qxHG6u4DscI4+aAFBvnw9u9IxHYLCVqe0fqTO2o17lE8rLMY6MqTx
 9W4qPIkocESfzqWS/840qUjYIPc5ZW/3MO5ouFyzBH9YfXftK0Am79Q5U+XyzFBNQ0Fb
 JgS0oMw+w7ixMKPEa2XbTdFZ4nksI+Y/xYc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9a6jahxp-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 08:26:54 -0700
Received: from twshared2273.16.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 08:26:53 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D508FECDECBD; Wed, 31 Aug 2022 08:26:46 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v4 1/8] bpf: Allow struct argument in trampoline based programs
Date:   Wed, 31 Aug 2022 08:26:46 -0700
Message-ID: <20220831152646.2078089-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220831152641.2077476-1-yhs@fb.com>
References: <20220831152641.2077476-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9l4D81NUf4PPURHWwmS2gEYUvhHJEzrx
X-Proofpoint-GUID: 9l4D81NUf4PPURHWwmS2gEYUvhHJEzrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_09,2022-08-31_03,2022-06-22_01
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
 kernel/bpf/btf.c    | 45 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 43 insertions(+), 6 deletions(-)

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
index 903719b89238..ea94527e5d70 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5328,6 +5328,34 @@ static bool is_int_ptr(struct btf *btf, const stru=
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
+	if (!func_proto)
+		return off / 8;
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
@@ -5347,7 +5375,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
 			tname, off);
 		return false;
 	}
-	arg =3D off / 8;
+	arg =3D get_ctx_arg_idx(btf, t, off);
 	args =3D (const struct btf_param *)(t + 1);
 	/* if (t =3D=3D NULL) Fall back to default BPF prog with
 	 * MAX_BPF_FUNC_REG_ARGS u64 arguments.
@@ -5417,7 +5445,7 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
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
@@ -5881,7 +5909,7 @@ static int __get_type_size(struct btf *btf, u32 btf=
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
@@ -5901,8 +5929,10 @@ int btf_distill_func_proto(struct bpf_verifier_log=
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
@@ -5916,7 +5946,7 @@ int btf_distill_func_proto(struct bpf_verifier_log =
*log,
 		return -EINVAL;
 	}
 	ret =3D __get_type_size(btf, func->type, &t);
-	if (ret < 0) {
+	if (ret < 0 || __btf_type_is_struct(t)) {
 		bpf_log(log,
 			"The function %s return type %s is unsupported.\n",
 			tname, btf_kind_str[BTF_INFO_KIND(t->info)]);
@@ -5932,7 +5962,9 @@ int btf_distill_func_proto(struct bpf_verifier_log =
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
@@ -5945,6 +5977,7 @@ int btf_distill_func_proto(struct bpf_verifier_log =
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

