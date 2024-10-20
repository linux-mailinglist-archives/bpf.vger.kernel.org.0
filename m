Return-Path: <bpf+bounces-42532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA449A5600
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 21:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13691C20D9C
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 19:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD041957F4;
	Sun, 20 Oct 2024 19:14:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF9173
	for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451650; cv=none; b=qcTH8jauIfTK1uviRb7c2xwpNoGVjF/4DEHrHZnL94CRmWg4Rdz/H2EyjwG62vd3dANkMIkJXM1G7f0iGVbvA/RAHroS545wNrChDAre4SdWNVahpkL3rC/xHbBP02tI1pfkP+r7XMgHLgNpnEiX1rD1afiB1058BTNBYNHnoA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451650; c=relaxed/simple;
	bh=cjLFpBBgpOmZ4h14abktXnX1AOvfqFN3y+T6AHZyMdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ME0k/u/0a6vU0FRQetlUQ31+b0ffBawcBjupIlXx0VblUv6s/dhyHYkn+pYryv2qNJKLVULav+aHKC0XvXJCauJYSKuEn+h6IQS1iT6YXLXe9SW2OZVJI6BXXUbA0OcQCC4+BMXz5qyhKirC7rJRFrhLZJjWOHzr1pZqeYnqtbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id DE293A465E16; Sun, 20 Oct 2024 12:13:53 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v6 2/9] bpf: Rename bpf_struct_ops_arg_info to bpf_struct_ops_func_info
Date: Sun, 20 Oct 2024 12:13:53 -0700
Message-ID: <20241020191353.2105313-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241020191341.2104841-1-yonghong.song@linux.dev>
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the subsequent patch, some not argument information will be added to
struct bpf_struct_ops_arg_info. So let us rename the struct to
bpf_struct_ops_func_info. No functionality change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h         |  4 ++--
 kernel/bpf/bpf_struct_ops.c | 36 ++++++++++++++++++------------------
 kernel/bpf/verifier.c       |  4 ++--
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6ad8ace7075a..f3884ce2603d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1773,7 +1773,7 @@ struct bpf_struct_ops {
  * btf_ctx_access() will lookup prog->aux->ctx_arg_info to find the
  * corresponding entry for an given argument.
  */
-struct bpf_struct_ops_arg_info {
+struct bpf_struct_ops_func_info {
 	struct bpf_ctx_arg_aux *info;
 	u32 cnt;
 };
@@ -1787,7 +1787,7 @@ struct bpf_struct_ops_desc {
 	u32 value_id;
=20
 	/* Collection of argument information for each member */
-	struct bpf_struct_ops_arg_info *arg_info;
+	struct bpf_struct_ops_func_info *func_info;
 };
=20
 enum bpf_struct_ops_state {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index fda3dd2ee984..8279b5a57798 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -182,11 +182,11 @@ find_stub_func_proto(const struct btf *btf, const c=
har *st_op_name,
 /* Prepare argument info for every nullable argument of a member of a
  * struct_ops type.
  *
- * Initialize a struct bpf_struct_ops_arg_info according to type info of
+ * Initialize a struct bpf_struct_ops_func_info according to type info o=
f
  * the arguments of a stub function. (Check kCFI for more information ab=
out
  * stub functions.)
  *
- * Each member in the struct_ops type has a struct bpf_struct_ops_arg_in=
fo
+ * Each member in the struct_ops type has a struct bpf_struct_ops_func_i=
nfo
  * to provide an array of struct bpf_ctx_arg_aux, which in turn provides
  * the information that used by the verifier to check the arguments of t=
he
  * BPF struct_ops program assigned to the member. Here, we only care abo=
ut
@@ -196,14 +196,14 @@ find_stub_func_proto(const struct btf *btf, const c=
har *st_op_name,
  * prog->aux->ctx_arg_info of BPF struct_ops programs and passed to the
  * verifier. (See check_struct_ops_btf_id())
  *
- * arg_info->info will be the list of struct bpf_ctx_arg_aux if success.=
 If
+ * func_info->info will be the list of struct bpf_ctx_arg_aux if success=
. If
  * fails, it will be kept untouched.
  */
-static int prepare_arg_info(struct btf *btf,
+static int prepare_func_info(struct btf *btf,
 			    const char *st_ops_name,
 			    const char *member_name,
 			    const struct btf_type *func_proto,
-			    struct bpf_struct_ops_arg_info *arg_info)
+			    struct bpf_struct_ops_func_info *func_info)
 {
 	const struct btf_type *stub_func_proto, *pointed_type;
 	const struct btf_param *stub_args, *args;
@@ -282,8 +282,8 @@ static int prepare_arg_info(struct btf *btf,
 	}
=20
 	if (info_cnt) {
-		arg_info->info =3D info_buf;
-		arg_info->cnt =3D info_cnt;
+		func_info->info =3D info_buf;
+		func_info->cnt =3D info_cnt;
 	} else {
 		kfree(info_buf);
 	}
@@ -296,17 +296,17 @@ static int prepare_arg_info(struct btf *btf,
 	return -EINVAL;
 }
=20
-/* Clean up the arg_info in a struct bpf_struct_ops_desc. */
+/* Clean up the func_info in a struct bpf_struct_ops_desc. */
 void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc=
)
 {
-	struct bpf_struct_ops_arg_info *arg_info;
+	struct bpf_struct_ops_func_info *func_info;
 	int i;
=20
-	arg_info =3D st_ops_desc->arg_info;
+	func_info =3D st_ops_desc->func_info;
 	for (i =3D 0; i < btf_type_vlen(st_ops_desc->type); i++)
-		kfree(arg_info[i].info);
+		kfree(func_info[i].info);
=20
-	kfree(arg_info);
+	kfree(func_info);
 }
=20
 int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
@@ -314,7 +314,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_de=
sc *st_ops_desc,
 			     struct bpf_verifier_log *log)
 {
 	struct bpf_struct_ops *st_ops =3D st_ops_desc->st_ops;
-	struct bpf_struct_ops_arg_info *arg_info;
+	struct bpf_struct_ops_func_info *func_info;
 	const struct btf_member *member;
 	const struct btf_type *t;
 	s32 type_id, value_id;
@@ -359,12 +359,12 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_=
desc *st_ops_desc,
 	if (!is_valid_value_type(btf, value_id, t, value_name))
 		return -EINVAL;
=20
-	arg_info =3D kcalloc(btf_type_vlen(t), sizeof(*arg_info),
+	func_info =3D kcalloc(btf_type_vlen(t), sizeof(*func_info),
 			   GFP_KERNEL);
-	if (!arg_info)
+	if (!func_info)
 		return -ENOMEM;
=20
-	st_ops_desc->arg_info =3D arg_info;
+	st_ops_desc->func_info =3D func_info;
 	st_ops_desc->type =3D t;
 	st_ops_desc->type_id =3D type_id;
 	st_ops_desc->value_id =3D value_id;
@@ -403,9 +403,9 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_de=
sc *st_ops_desc,
 			goto errout;
 		}
=20
-		err =3D prepare_arg_info(btf, st_ops->name, mname,
+		err =3D prepare_func_info(btf, st_ops->name, mname,
 				       func_proto,
-				       arg_info + i);
+				       func_info + i);
 		if (err)
 			goto errout;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 45bea4066272..ccfe159cfbde 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21880,9 +21880,9 @@ static int check_struct_ops_btf_id(struct bpf_ver=
ifier_env *env)
=20
 	/* btf_ctx_access() used this to provide argument type info */
 	prog->aux->ctx_arg_info =3D
-		st_ops_desc->arg_info[member_idx].info;
+		st_ops_desc->func_info[member_idx].info;
 	prog->aux->ctx_arg_info_size =3D
-		st_ops_desc->arg_info[member_idx].cnt;
+		st_ops_desc->func_info[member_idx].cnt;
=20
 	prog->aux->attach_func_proto =3D func_proto;
 	prog->aux->attach_func_name =3D mname;
--=20
2.43.5


