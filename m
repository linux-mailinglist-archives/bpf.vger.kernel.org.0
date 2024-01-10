Return-Path: <bpf+bounces-19346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B143C82A3D3
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 23:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A98328A7D1
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 22:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1964F887;
	Wed, 10 Jan 2024 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQKQ8PSB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0D4F1E5
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 22:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5f68af028afso40725767b3.2
        for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 14:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704925076; x=1705529876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3ioYdmbrJ5aQC1sqNU7k+GdQgllGkoGI3IJe3FGjeE=;
        b=XQKQ8PSBnd6z0szrXO7CfF63XD2v00zCvkJmFVwtbWms9MKbKT3vzmQdGTkwn46kWd
         JU2XCQwjTdi5INXPbmHF7f3ffHzFghnGaf8ImixdGMeWC0JQ6QMFQNGE9id9T8O14B/W
         QHEIwKwHrRgRb6IjLmH6/OrJLwh1ryGEolqd1/QByqNVwA6kkQxwIbgCD3DI2QJpxkvh
         9TxNvJmLwt5EZYgN8lEh/6UhrxN7RsIVM7dE4WIBa+03zH1NhvQ8Xcwjxh8Ql4gGt6y/
         u7+mjB1h8gtkTHYjjCDKylOBsDU5NILDM4pFC30wLuF9JKBKY5C1WsUczDS/LxSsGWex
         uegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925076; x=1705529876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3ioYdmbrJ5aQC1sqNU7k+GdQgllGkoGI3IJe3FGjeE=;
        b=mur3R1KX9yaA297GkWKuvYBBe+nnV6Iovdzvn+bvnKL8d7fQhR5bcesFsZUqWY2BEA
         z1k364vgx8YoCAmQd7zuZQGDTATw7pYuHa+gMph29Y6McDzDMuDqBMeiPDDd8lDRwsDb
         9iQg0PmU3qQ8j1tb8CG+ZkYutq4VaSpKUmYzZhQuM3yGE2hoJNHFemfwDQKvnnpIFd4W
         d7V8y5FlgnIOxFXbOUErh0mIb+4gZeRymdMRt3UxQEtLCfvN9IPpDO1hBMaaSXuwHmHt
         aWwlofBL4PWiJmxf7DfefoJORNZ0ybWgwjpzR5D/1hsWpTxpv/vvw8ckQYXn5XyJwcDe
         yn2g==
X-Gm-Message-State: AOJu0YwVQD4uOI78Za1xRvx7aMISPkWai52f10ZJXRVB8gz1xlrY5CLX
	QuZPGe9SekuCG7tjGtvdCOy/3nxnNVM=
X-Google-Smtp-Source: AGHT+IEtQAxVCVcJ3YN8WK2l4HgABfrGF+4d++KvDpwNBk7dfS9juAtj+OjTSzaKLHhZtl981ICdoQ==
X-Received: by 2002:a0d:d784:0:b0:5e8:e422:fa9b with SMTP id z126-20020a0dd784000000b005e8e422fa9bmr290092ywd.88.1704925075519;
        Wed, 10 Jan 2024 14:17:55 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b02f:5810:3abc:c82])
        by smtp.gmail.com with ESMTPSA id x62-20020a818741000000b005f576de678bsm1944053ywf.54.2024.01.10.14.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:17:55 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	davemarchevsky@meta.com,
	dvernet@meta.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next] bpf, selftests/bpf: Support PTR_MAYBE_NULL for struct_ops arguments.
Date: Wed, 10 Jan 2024 14:17:50 -0800
Message-Id: <20240110221750.798813-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Allow passing a null pointer to the operators provided by a struct_ops
object. This is an RFC to collect feedbacks/opinions.

The function pointers that are passed to struct_ops operators (the function
pointers) are always considered reliable until now. They cannot be
null. However, in certain scenarios, it should be possible to pass null
pointers to these operators. For instance, sched_ext may pass a null
pointer in the struct task type to an operator that is provided by its
struct_ops objects.

The proposed solution here is to add PTR_MAYBE_NULL annotations to
arguments and create instances of struct bpf_ctx_arg_aux (arg_info) for
these arguments. These arg_infos will be installed at
prog->aux->ctx_arg_info and will be checked by the BPF verifier when
loading the programs. When a struct_ops program accesses arguments in the
ctx, the verifier will call btf_ctx_access() (through
bpf_verifier_ops->is_valid_access) to verify the access. btf_ctx_access()
will check arg_info and use the information of the matched arg_info to
properly set reg_type.

For nullable arguments, it sets an arg_info to annotate them with
PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This enforces the verifier to
check programs and ensure that they properly check the pointer. The
programs should check if the pointer is null before reading/writing the
pointed memory.

The implementer of a struct_ops should annotate the arguments that is
PTR_MAYBE_NULL. Here is the example in bpf_testmod.c.

  struct bpf_struct_ops_arg_info testmod_arg_info[] = {
          ST_OPS_ARG_MAYBE_NULL(struct bpf_testmod_ops, test_maybe_null, 1),
  };

This means that the argument 1 (2nd) of bpf_testmod_ops->test_maybe_null,
which is a function pointer, should be PTR_MAYBE_NULL. With this
annotation, the verifier will understand how to check programs using this
arguments.

The struct bpf_struct_ops_arg_info above should be set in the
struct bpf_struct_ops. For example,

  struct bpf_struct_ops bpf_bpf_testmod_ops = {
            ……
            .arg_info = testmod_arg_info,
            .arg_info_cnt = ARRAY_SIZE(testmod_arg_info),
  };

== Future Work ==

We require an improved method for annotating arguments. Initially, we
anticipated annotating arguments by appending a suffix to argument names,
such as arg1__maybe_null. However, this approach does not function for
function pointers due to compiler limitations. Nevertheless, it does work
for functions. To resolve this, we need compiler support to enable the
inclusion of argument names in the DWARF for function pointer types.
---
 include/linux/bpf.h                           |  20 ++++
 kernel/bpf/btf.c                              | 106 +++++++++++++++++-
 kernel/bpf/verifier.c                         |  14 ++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  25 ++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   4 +
 .../prog_tests/test_struct_ops_maybe_null.c   |  39 +++++++
 .../bpf/progs/struct_ops_maybe_null.c         |  27 +++++
 .../bpf/progs/struct_ops_maybe_null_fail.c    |  25 +++++
 8 files changed, 255 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fd49a9a5ae5c..6cbd5d5ef415 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1413,6 +1413,7 @@ struct bpf_ctx_arg_aux {
 	u32 offset;
 	enum bpf_reg_type reg_type;
 	u32 btf_id;
+	struct btf *btf;
 };
 
 struct btf_mod_pair {
@@ -1609,6 +1610,12 @@ struct bpf_link_primer {
 	u32 id;
 };
 
+struct bpf_struct_ops_arg_info {
+	u32 op_off;
+	u32 arg_no;
+	enum bpf_reg_type reg_type;
+};
+
 struct bpf_struct_ops_value;
 struct btf_member;
 
@@ -1677,6 +1684,9 @@ struct bpf_struct_ops {
 	struct module *owner;
 	const char *name;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
+
+	u32 arg_info_cnt;
+	struct bpf_struct_ops_arg_info *arg_info;
 };
 
 struct bpf_struct_ops_desc {
@@ -1686,6 +1696,8 @@ struct bpf_struct_ops_desc {
 	const struct btf_type *value_type;
 	u32 type_id;
 	u32 value_id;
+
+	struct bpf_ctx_arg_aux *ctx_arg_info;
 };
 
 enum bpf_struct_ops_state {
@@ -3302,4 +3314,12 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+#define ST_OPS_ARG_FLAGS(type, fptr, argno, flags)			\
+	{ .op_off = offsetof(type, fptr) * 8, .arg_no = argno, .reg_type = flags, }
+
+#define ST_OPS_ARG_MAYBE_NULL(type, fptr, argno)			\
+	ST_OPS_ARG_FLAGS(type, fptr, argno,				\
+			 PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL)
+
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 81db591b4a22..dae8c3ad35be 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1699,6 +1699,11 @@ static void btf_free_struct_meta_tab(struct btf *btf)
 static void btf_free_struct_ops_tab(struct btf *btf)
 {
 	struct btf_struct_ops_tab *tab = btf->struct_ops_tab;
+	int i;
+
+	if (tab)
+		for (i = 0; i < tab->cnt; i++)
+			kfree(tab->ops[i].ctx_arg_info);
 
 	kfree(tab);
 	btf->struct_ops_tab = NULL;
@@ -6086,7 +6091,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			}
 
 			info->reg_type = ctx_arg_info->reg_type;
-			info->btf = btf_vmlinux;
+			info->btf = ctx_arg_info->btf ? ctx_arg_info->btf : btf_vmlinux;
 			info->btf_id = ctx_arg_info->btf_id;
 			return true;
 		}
@@ -8488,11 +8493,62 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 	return !strncmp(reg_name, arg_name, cmp_len);
 }
 
+static s32 find_member_type_offset(struct btf *btf, u32 btf_id, u32 offset)
+{
+	const struct btf_type *t;
+	const struct btf_member *m;
+	u32 i, n;
+
+	t = btf_type_by_id(btf, btf_id);
+	if (!t)
+		return 0;
+
+	if (!btf_type_is_struct(t))
+		return 0;
+
+	n = btf_type_vlen(t);
+	m = btf_members(t);
+	for (i = 0; i < n; i++) {
+		if (m[i].offset == offset)
+			return m[i].type;
+	}
+
+	return 0;
+}
+
+static s32 find_arg_id_offset(struct btf *btf, u32 btf_id, u32 offset,
+			      u32 arg_no)
+{
+	const struct btf_type *func_proto;
+	s32 member_type_id, arg_type_id;
+	const struct btf_param *args;
+	u32 nargs;
+
+	member_type_id = find_member_type_offset(btf,
+						 btf_id,
+						 offset);
+	if (member_type_id < 0)
+		return -EINVAL;
+	func_proto = btf_type_resolve_func_ptr(btf, member_type_id, NULL);
+	if (!func_proto)
+		return -EINVAL;
+	nargs = btf_type_vlen(func_proto);
+	args = btf_params(func_proto);
+
+	if (!btf_type_resolve_ptr(btf, args[arg_no].type, &arg_type_id))
+		return -EINVAL;
+
+	return arg_type_id;
+}
+
 static int
 btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops,
 		   struct bpf_verifier_log *log)
 {
+	struct bpf_struct_ops_arg_info *prev, *arg_info;
+	struct bpf_ctx_arg_aux *arg_aux, *ctx_arg_info;
 	struct btf_struct_ops_tab *tab, *new_tab;
+	s32 btf_id;
 	int i, err;
 
 	if (!btf)
@@ -8530,13 +8586,56 @@ btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops,
 
 	tab->ops[btf->struct_ops_tab->cnt].st_ops = st_ops;
 
+	btf_id = btf_find_by_name_kind(btf, st_ops->name, BTF_KIND_STRUCT);
+	if (btf_id < 0)
+		return -EINVAL;
+
+	if (st_ops->arg_info_cnt) {
+		ctx_arg_info = kmalloc(sizeof(*ctx_arg_info) *
+				       st_ops->arg_info_cnt,
+				       GFP_KERNEL);
+		if (!ctx_arg_info)
+			return -ENOMEM;
+
+		arg_aux = ctx_arg_info;
+		for (i = 0; i < st_ops->arg_info_cnt; i++) {
+			/* Make sure all arg_info are in order */
+			prev = &st_ops->arg_info[i - 1];
+			arg_info = &st_ops->arg_info[i];
+			if (i && (arg_info->op_off < prev->op_off ||
+			    (arg_info->op_off == prev->op_off &&
+			     arg_info->arg_no <= prev->arg_no))) {
+				err = -EINVAL;
+				goto errout;
+			}
+			arg_aux->reg_type = arg_info->reg_type;
+			arg_aux->btf_id = find_arg_id_offset(btf,
+							     btf_id,
+							     arg_info->op_off,
+							     arg_info->arg_no);
+			if (arg_aux->btf_id < 0) {
+				err = -EINVAL;
+				goto errout;
+			}
+			arg_aux->offset = arg_info->arg_no * 8;
+			arg_aux->btf = btf;
+			arg_aux++;
+		}
+	}
+	tab->ops[btf->struct_ops_tab->cnt].ctx_arg_info = ctx_arg_info;
+
 	err = bpf_struct_ops_desc_init(&tab->ops[btf->struct_ops_tab->cnt], btf, log);
 	if (err)
-		return err;
+		goto errout;
 
 	btf->struct_ops_tab->cnt++;
 
 	return 0;
+
+errout:
+	kfree(ctx_arg_info);
+
+	return err;
 }
 
 const struct bpf_struct_ops_desc *
@@ -8587,7 +8686,7 @@ int register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 {
 	struct bpf_verifier_log *log;
 	struct btf *btf;
-	int err = 0;
+	int err;
 
 	btf = btf_get_module_btf(st_ops->owner);
 	if (!btf)
@@ -8609,4 +8708,5 @@ int register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 
 	return err;
 }
+
 EXPORT_SYMBOL_GPL(register_bpf_struct_ops);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 60f08f468399..190735f3eaf5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8200,6 +8200,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | MEM_RCU:
 	case PTR_TO_BTF_ID | PTR_MAYBE_NULL:
+	case PTR_TO_BTF_ID | PTR_MAYBE_NULL | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_RCU:
 	{
 		/* For bpf_sk_release, it needs to match against first member
@@ -20231,11 +20232,12 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct btf_type *t, *func_proto;
 	const struct bpf_struct_ops_desc *st_ops_desc;
 	const struct bpf_struct_ops *st_ops;
-	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
+	const struct btf_member *member;
 	u32 btf_id, member_idx;
 	struct btf *btf;
 	const char *mname;
+	int i, j;
 
 	if (!prog->gpl_compatible) {
 		verbose(env, "struct ops programs must have a GPL compatible license\n");
@@ -20289,6 +20291,16 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		}
 	}
 
+	for (i = 0; i < st_ops->arg_info_cnt; i++) {
+		if (st_ops->arg_info[i].op_off != member->offset)
+			continue;
+		prog->aux->ctx_arg_info = &st_ops_desc->ctx_arg_info[i];
+		for (j = i + 1; j < st_ops->arg_info_cnt; j++)
+			if (st_ops->arg_info[j].op_off != member->offset)
+				break;
+		prog->aux->ctx_arg_info_size = j - i;
+	}
+
 	prog->aux->attach_func_proto = func_proto;
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index fe945d093378..64e966acfb1b 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -555,7 +555,12 @@ static int bpf_dummy_reg(void *kdata)
 	struct bpf_testmod_ops *ops = kdata;
 	int r;
 
-	r = ops->test_2(4, 3);
+	if (ops->test_maybe_null)
+		r = ops->test_maybe_null(0, NULL);
+	else if (ops->test_non_maybe_null)
+		r = ops->test_non_maybe_null(0, NULL);
+	else
+		r = ops->test_2(4, 3);
 
 	return 0;
 }
@@ -574,9 +579,25 @@ static int bpf_testmod_test_2(int a, int b)
 	return 0;
 }
 
+static int bpf_testmod_test_maybe_null(int dummy, struct task_struct *task)
+{
+	return 0;
+}
+
+static int bpf_testmod_test_non_maybe_null(int dummy, struct task_struct *task)
+{
+	return 0;
+}
+
 static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_1 = bpf_testmod_test_1,
 	.test_2 = bpf_testmod_test_2,
+	.test_maybe_null = bpf_testmod_test_maybe_null,
+	.test_non_maybe_null = bpf_testmod_test_non_maybe_null,
+};
+
+struct bpf_struct_ops_arg_info testmod_arg_info[] = {
+	ST_OPS_ARG_MAYBE_NULL(struct bpf_testmod_ops, test_maybe_null, 1),
 };
 
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
@@ -588,6 +609,8 @@ struct bpf_struct_ops bpf_bpf_testmod_ops = {
 	.cfi_stubs = &__bpf_testmod_ops,
 	.name = "bpf_testmod_ops",
 	.owner = THIS_MODULE,
+	.arg_info = testmod_arg_info,
+	.arg_info_cnt = ARRAY_SIZE(testmod_arg_info),
 };
 
 extern int bpf_fentry_test1(int a);
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index ca5435751c79..846b472e4810 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -5,6 +5,8 @@
 
 #include <linux/types.h>
 
+struct task_struct;
+
 struct bpf_testmod_test_read_ctx {
 	char *buf;
 	loff_t off;
@@ -31,6 +33,8 @@ struct bpf_iter_testmod_seq {
 struct bpf_testmod_ops {
 	int (*test_1)(void);
 	int (*test_2)(int a, int b);
+	int (*test_maybe_null)(int dummy, struct task_struct *task);
+	int (*test_non_maybe_null)(int dummy, struct task_struct *task);
 };
 
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
new file mode 100644
index 000000000000..4477dfcf1cd7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <time.h>
+
+#include "struct_ops_maybe_null.skel.h"
+#include "struct_ops_maybe_null_fail.skel.h"
+
+static void maybe_null(void)
+{
+	struct struct_ops_maybe_null *skel;
+
+	skel = struct_ops_maybe_null__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_and_load"))
+		return;
+	
+	struct_ops_maybe_null__destroy(skel);
+}
+
+static void maybe_null_fail(void)
+{
+	struct struct_ops_maybe_null_fail *skel;
+
+	skel = struct_ops_maybe_null_fail__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load"))
+		return;
+	
+	struct_ops_maybe_null_fail__destroy(skel);
+}
+
+void test_struct_ops_maybe_null(void)
+{
+	if (test__start_subtest("maybe_null"))
+		maybe_null();
+	if (test__start_subtest("maybe_null_fail"))
+		maybe_null_fail();
+}
+
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
new file mode 100644
index 000000000000..adbbb17865fb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+u64 tgid = 0;
+
+SEC("struct_ops/test_maybe_null")
+int BPF_PROG(test_maybe_null, int dummy, struct task_struct *task)
+{
+	if (task == NULL)
+		tgid = 0;
+	else
+		tgid = task->tgid;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_1 = {
+	.test_maybe_null = (void *)test_maybe_null,
+};
+
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
new file mode 100644
index 000000000000..2f7a9b6ef864
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+int tgid = 0;
+
+SEC("struct_ops/test_maybe_null")
+int BPF_PROG(test_maybe_null, int dummy, struct task_struct *task)
+{
+	tgid = task->tgid;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_1 = {
+	.test_maybe_null = (void *)test_maybe_null,
+};
+
+
-- 
2.34.1


