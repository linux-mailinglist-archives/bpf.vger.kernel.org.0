Return-Path: <bpf+bounces-42536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBCD9A5605
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 21:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F5DDB22C71
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 19:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E81197512;
	Sun, 20 Oct 2024 19:16:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125817591
	for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451808; cv=none; b=TmaNqfKi/g86xhrq3Iu3dRKsFdFOEqH9v/wiEPeULQK42qhPnnJFZqD7cJpRc68eQMkzdVBam5mn2CrMYKGGyhie2Od2vZj+ONwbZqbW5Z2o36MqjSw62hH3Wpi9KK4Or0WkI75CDJSrUsjtANqoh0XhJHw5T8/b6KKnr05xEUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451808; c=relaxed/simple;
	bh=bg0jtOCBBYaaLeJxs1TMSh2/tbuHwCAOHxTp828WvLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ss9KsI5HZMrnaChpqT0gfP5DIR8g4glwrGGG89o9Yx1RcAxdwIn83KDK9yQ6/MxEQQqvg3CS56htFPrdtzh4Z1DBgmeSlVZ7EOaezAsbf35dpNdcjQShI59I2/S1Zm1IA0hnw/hYE8ScSz6EuDBFBLV1bGp4l/4a4Ik1KMI4Cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id AD415A465E2A; Sun, 20 Oct 2024 12:14:00 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v6 3/9] bpf: Support private stack for struct ops programs
Date: Sun, 20 Oct 2024 12:13:59 -0700
Message-ID: <20241020191400.2105605-1-yonghong.song@linux.dev>
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

To identify whether a st_ops program requests private stack or not,
the st_ops stub function is checked. If the stub function has the
following name
   <st_ops_name>__<member_name>__priv_stack
then the corresponding st_ops member func requests to use private
stack. The information that the private stack is requested or not
is encoded in struct bpf_struct_ops_func_info which will later be
used by verifier.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h         |  2 ++
 kernel/bpf/bpf_struct_ops.c | 35 +++++++++++++++++++++++++----------
 kernel/bpf/verifier.c       |  8 +++++++-
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f3884ce2603d..376e43fc72b9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1491,6 +1491,7 @@ struct bpf_prog_aux {
 	bool exception_boundary;
 	bool is_extended; /* true if extended by freplace program */
 	bool priv_stack_eligible;
+	bool priv_stack_always;
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_a=
rray */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_=
cnt */
 	struct bpf_arena *arena;
@@ -1776,6 +1777,7 @@ struct bpf_struct_ops {
 struct bpf_struct_ops_func_info {
 	struct bpf_ctx_arg_aux *info;
 	u32 cnt;
+	bool priv_stack_always;
 };
=20
 struct bpf_struct_ops_desc {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 8279b5a57798..2cd4bd086c7a 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -145,33 +145,44 @@ void bpf_struct_ops_image_free(void *image)
 }
=20
 #define MAYBE_NULL_SUFFIX "__nullable"
-#define MAX_STUB_NAME 128
+#define MAX_STUB_NAME 140
=20
 /* Return the type info of a stub function, if it exists.
  *
- * The name of a stub function is made up of the name of the struct_ops =
and
- * the name of the function pointer member, separated by "__". For examp=
le,
- * if the struct_ops type is named "foo_ops" and the function pointer
- * member is named "bar", the stub function name would be "foo_ops__bar"=
.
+ * The name of a stub function is made up of the name of the struct_ops,
+ * the name of the function pointer member and optionally "priv_stack"
+ * suffix, separated by "__". For example, if the struct_ops type is nam=
ed
+ * "foo_ops" and the function pointer  member is named "bar", the stub
+ * function name would be "foo_ops__bar". If a suffix "priv_stack" exist=
s,
+ * the stub function name would be "foo_ops__bar__priv_stack".
  */
 static const struct btf_type *
 find_stub_func_proto(const struct btf *btf, const char *st_op_name,
-		     const char *member_name)
+		     const char *member_name, bool *priv_stack_always)
 {
 	char stub_func_name[MAX_STUB_NAME];
 	const struct btf_type *func_type;
 	s32 btf_id;
 	int cp;
=20
-	cp =3D snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s",
+	cp =3D snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s__priv_stack",
 		      st_op_name, member_name);
 	if (cp >=3D MAX_STUB_NAME) {
 		pr_warn("Stub function name too long\n");
 		return NULL;
 	}
+
 	btf_id =3D btf_find_by_name_kind(btf, stub_func_name, BTF_KIND_FUNC);
-	if (btf_id < 0)
-		return NULL;
+	if (btf_id >=3D 0) {
+		*priv_stack_always =3D true;
+	} else {
+		cp =3D snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s",
+			      st_op_name, member_name);
+		btf_id =3D btf_find_by_name_kind(btf, stub_func_name, BTF_KIND_FUNC);
+		if (btf_id < 0)
+			return NULL;
+	}
+
 	func_type =3D btf_type_by_id(btf, btf_id);
 	if (!func_type)
 		return NULL;
@@ -209,10 +220,12 @@ static int prepare_func_info(struct btf *btf,
 	const struct btf_param *stub_args, *args;
 	struct bpf_ctx_arg_aux *info, *info_buf;
 	u32 nargs, arg_no, info_cnt =3D 0;
+	bool priv_stack_always =3D false;
 	u32 arg_btf_id;
 	int offset;
=20
-	stub_func_proto =3D find_stub_func_proto(btf, st_ops_name, member_name)=
;
+	stub_func_proto =3D find_stub_func_proto(btf, st_ops_name, member_name,
+					       &priv_stack_always);
 	if (!stub_func_proto)
 		return 0;
=20
@@ -226,6 +239,8 @@ static int prepare_func_info(struct btf *btf,
 		return -EINVAL;
 	}
=20
+	func_info->priv_stack_always =3D priv_stack_always;
+
 	if (!nargs)
 		return 0;
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ccfe159cfbde..25283ee6f86f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5995,6 +5995,8 @@ static bool bpf_enable_private_stack(struct bpf_ver=
ifier_env *env)
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 		return true;
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		return env->prog->aux->priv_stack_always;
 	case BPF_PROG_TYPE_TRACING:
 		if (env->prog->expected_attach_type !=3D BPF_TRACE_ITER)
 			return true;
@@ -6092,7 +6094,9 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
 			return -EACCES;
 		}
=20
-		if (!priv_stack_eligible && depth >=3D BPF_PRIV_STACK_MIN_SUBTREE_SIZE=
) {
+		if (!priv_stack_eligible &&
+		    (env->prog->aux->priv_stack_always ||
+		     depth >=3D BPF_PRIV_STACK_MIN_SUBTREE_SIZE)) {
 			subprog[orig_idx].priv_stack_eligible =3D true;
 			env->prog->aux->priv_stack_eligible =3D priv_stack_eligible =3D true;
 		}
@@ -21883,6 +21887,8 @@ static int check_struct_ops_btf_id(struct bpf_ver=
ifier_env *env)
 		st_ops_desc->func_info[member_idx].info;
 	prog->aux->ctx_arg_info_size =3D
 		st_ops_desc->func_info[member_idx].cnt;
+	prog->aux->priv_stack_always =3D
+		st_ops_desc->func_info[member_idx].priv_stack_always;
=20
 	prog->aux->attach_func_proto =3D func_proto;
 	prog->aux->attach_func_name =3D mname;
--=20
2.43.5


