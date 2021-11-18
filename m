Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02294562E6
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 19:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhKRSvZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 13:51:25 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32178 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229929AbhKRSvZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 13:51:25 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIF0Gmj004241
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 10:48:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6D0Jy85KJSCEb2mXRBM7089psX8lSQPaFllYMjyPPdA=;
 b=CryykkcOxzvlCQIFaa+V1CzVkaS9YZR8OsyR+NVQYopfb1qYrO6cat/jF0j2gCBIwM2v
 ksJcJ4vgLKCRbGvtXUtG7Zh+NxlF14RvVtbX+C+aKHGeYJAfmuglaCtmAjZg7V4lgVJz
 QPQhAd8HYUtPs3gW2XwO2V+HlBL6hMOnLnk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cds3f1txa-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 10:48:24 -0800
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 10:48:23 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 5E7F229A3F27; Thu, 18 Nov 2021 10:48:21 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next v2 2/3] bpf: reject program if a __user tagged memory accessed in kernel way
Date:   Thu, 18 Nov 2021 10:48:21 -0800
Message-ID: <20211118184821.1848389-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211118184810.1846996-1-yhs@fb.com>
References: <20211118184810.1846996-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: s_MW5zaofrnZT4Ve9sFSEJqQPXE-tT_3
X-Proofpoint-GUID: s_MW5zaofrnZT4Ve9sFSEJqQPXE-tT_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxlogscore=968 adultscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF verifier supports direct access, e.g., a->b. If "a" is a pointer
pointing to kernel memory, bpf verifier will allow user to write
code in C like a->b and bpf verifier will translate it to a kernel
load properly. If "a" is a pointer to user memory, it is expected
that bpf developer should be bpf_probe_read_user() helper to
get the value a->b. In the current mechanism, if "a" is a user pointer,
a->b access may trigger a page fault and the verifier generated
code will simulate bpf_probe_read() and return 0 for a->b, which
may not be correct value.

Now BTF contains __user information, it can check whether the
pointer points to a user memory or not. If it is, the verifier
can reject the program and force users to use bpf_probe_read_user()
helper explicitly.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 +
 include/linux/btf.h          |  5 +++++
 kernel/bpf/btf.c             | 13 +++++++++++--
 kernel/bpf/verifier.c        | 16 +++++++++++++---
 5 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cc7a0c36e7df..d09df9ec3100 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -473,6 +473,7 @@ struct bpf_insn_access_aux {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
+			bool is_user;
 		};
 	};
 	struct bpf_verifier_log *log; /* for verbose logs */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c8a78e830fca..2ddba4767118 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -66,6 +66,7 @@ struct bpf_reg_state {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
+			bool is_user;
 		};
=20
 		u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 203eef993d76..fcb6041f8fff 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -169,6 +169,11 @@ static inline bool btf_type_is_var(const struct btf_=
type *t)
 	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_VAR;
 }
=20
+static inline bool btf_type_is_type_tag(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_TYPE_TAG;
+}
+
 /* union is only a special case of struct:
  * all its offsetof(member) =3D=3D 0
  */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6b9d23be1e99..ea73a5c3bd24 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4999,6 +4999,14 @@ bool btf_ctx_access(int off, int size, enum bpf_ac=
cess_type type,
 	info->btf =3D btf;
 	info->btf_id =3D t->type;
 	t =3D btf_type_by_id(btf, t->type);
+
+	if (btf_type_is_type_tag(t)) {
+		const char *tag_value =3D __btf_name_by_offset(btf, t->name_off);
+
+		if (strcmp(tag_value, "user") =3D=3D 0)
+			info->is_user =3D true;
+	}
+
 	/* skip modifiers */
 	while (btf_type_is_modifier(t)) {
 		info->btf_id =3D t->type;
@@ -5010,8 +5018,9 @@ bool btf_ctx_access(int off, int size, enum bpf_acc=
ess_type type,
 			tname, arg, btf_kind_str[BTF_INFO_KIND(t->info)]);
 		return false;
 	}
-	bpf_log(log, "func '%s' arg%d has btf_id %d type %s '%s'\n",
-		tname, arg, info->btf_id, btf_kind_str[BTF_INFO_KIND(t->info)],
+	bpf_log(log, "func '%s' arg%d has btf_id %d is_user %d type %s '%s'\n",
+		tname, arg, info->btf_id, info->is_user,
+		btf_kind_str[BTF_INFO_KIND(t->info)],
 		__btf_name_by_offset(btf, t->name_off));
 	return true;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0763cca139a7..07ba7c8f6aa3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -647,7 +647,8 @@ static void print_verifier_state(struct bpf_verifier_=
env *env,
 			if (t =3D=3D PTR_TO_BTF_ID ||
 			    t =3D=3D PTR_TO_BTF_ID_OR_NULL ||
 			    t =3D=3D PTR_TO_PERCPU_BTF_ID)
-				verbose(env, "%s", kernel_type_name(reg->btf, reg->btf_id));
+				verbose(env, "%s,is_user=3D%d", kernel_type_name(reg->btf, reg->btf_=
id),
+					reg->is_user);
 			verbose(env, "(id=3D%d", reg->id);
 			if (reg_type_may_be_refcounted_or_null(t))
 				verbose(env, ",ref_obj_id=3D%d", reg->ref_obj_id);
@@ -3551,7 +3552,7 @@ static int check_packet_access(struct bpf_verifier_=
env *env, u32 regno, int off,
 /* check access to 'struct bpf_context' fields.  Supports fixed offsets =
only */
 static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
int off, int size,
 			    enum bpf_access_type t, enum bpf_reg_type *reg_type,
-			    struct btf **btf, u32 *btf_id)
+			    struct btf **btf, u32 *btf_id, bool *is_user)
 {
 	struct bpf_insn_access_aux info =3D {
 		.reg_type =3D *reg_type,
@@ -3572,6 +3573,7 @@ static int check_ctx_access(struct bpf_verifier_env=
 *env, int insn_idx, int off,
 		if (*reg_type =3D=3D PTR_TO_BTF_ID || *reg_type =3D=3D PTR_TO_BTF_ID_O=
R_NULL) {
 			*btf =3D info.btf;
 			*btf_id =3D info.btf_id;
+			*is_user =3D info.is_user;
 		} else {
 			env->insn_aux_data[insn_idx].ctx_field_size =3D info.ctx_field_size;
 		}
@@ -4116,6 +4118,13 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
 		return -EACCES;
 	}
=20
+	if (reg->is_user) {
+		verbose(env,
+			"R%d is ptr_%s access user memory: off=3D%d\n",
+			regno, tname, off);
+		return -EACCES;
+	}
+
 	if (env->ops->btf_struct_access) {
 		ret =3D env->ops->btf_struct_access(&env->log, reg->btf, t,
 						  off, size, atype, &btf_id);
@@ -4374,7 +4383,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 		if (err < 0)
 			return err;
=20
-		err =3D check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,=
 &btf_id);
+		err =3D check_ctx_access(env, insn_idx, off, size, t, &reg_type, &btf,=
 &btf_id, &is_user);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
 		if (!err && t =3D=3D BPF_READ && value_regno >=3D 0) {
@@ -4399,6 +4408,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 				    reg_type =3D=3D PTR_TO_BTF_ID_OR_NULL) {
 					regs[value_regno].btf =3D btf;
 					regs[value_regno].btf_id =3D btf_id;
+					regs[value_regno].is_user =3D is_user;
 				}
 			}
 			regs[value_regno].type =3D reg_type;
--=20
2.30.2

