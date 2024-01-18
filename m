Return-Path: <bpf+bounces-19845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D614A8321B9
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 23:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12771C22C8E
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 22:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C5A1DA33;
	Thu, 18 Jan 2024 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IANQuUL8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162810E2
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705618170; cv=none; b=keX9ckOmdrJGVW1jnvQGGAqujpllmqDeOllZ8NWcpGtNMcxoNY7sOXsSWCVBil4aUSvLulSsOrM5/jCYeEP6GPlVgoAVBh60NAciE3wPSDuZQuwFrVmdyHGoNeA7Gv9XQLv3N2M3fQYFK1mJpOWFwaRtZECgr4cZEQsLrNbM2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705618170; c=relaxed/simple;
	bh=BFKqLK5qGxYek1rxZAvFri8WsKhMHpq53+Kbm626XjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oRQPT99O2/QMabsZmzrUQAO7G91cOpHgQIMPqgfk0FAKJatPh43nxJ/G4KPzI+/SV/5ID7TsbuyATYVB0WmE6YrjREsmiYrQjAZw7MUsWhcXEHGPrW9mLV/an+H/TMMniWqVI8OM8dCFdaQRuQQc/2/qmgifMD/3pDvH+1QiMKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IANQuUL8; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5edfcba97e3so1668737b3.2
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 14:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705618167; x=1706222967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S8xqz/8w+FqxUriGcGHSDiWhDO+7BZb5N/r4wH2kfyc=;
        b=IANQuUL8S0yJwGE1pAle4TsNvr6AucYeu3zfdy1j2v97KBpUylpCR4GKKyrmVmKatQ
         JGtcnW/xQjgqg//dhYHa4jlM8e2sZm6J705F3fZ35cQeRcjiuod2OHW8GYV8neeUUWd0
         AY6v6xi1x1lzi/7ENNBqU1OlfO1ytKPuLWLHTf05+GsiceqHFClP+qS0KIT7Wgj8W+YO
         G6PRZEEnEQSH9YFpgCJDVlX5SYmyVPAodyrdWPwLR29k4m2ubAG/Tn86LWNcoLja5gZp
         CkHTNU9LaWSCVnq06iJCtw/y+kUGXeL6X6bdqqjPskWn/ZNk+ifiN3EWrcFvf/BvIsWC
         7RFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705618167; x=1706222967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8xqz/8w+FqxUriGcGHSDiWhDO+7BZb5N/r4wH2kfyc=;
        b=d1g6mLgfKHgn/rggKt6HQIfFZVfsjtOteE6esbfQHXTUCpVObyLEeWGmCQCXpHtrPh
         6cpKln0//A9CxOdWWWYWbXdT+tZZhy14UzBBqhFJdHQAeBSNUHuSdfVE/u3F1FlhY/KW
         a6BAsaVEbFs5HAFTcZf+y10bnZD4B1O+OoteSX6pULOioj3jUk1HnCkgfZLLearaq/Jn
         LIsfQra/yd0n1+jbSrxZvMmMsDtoibcJeGpLvXa2Ay6uEBHC61i/mCo/yd5OPWKDTF+J
         ABXxzfsOv4AlMV2EoCVBPnWG3mKHH9MJuAWkt1Y9PxeIh6z9+mCUZsDUnopkgZ+0lWLN
         07SA==
X-Gm-Message-State: AOJu0Yyi6TL3fue5uAiE5w6moNUo0SS7S8WMeD070Anm76teyXfolKFU
	hap3TxNgy4aW4j64bGC4WYd4hnIwdE3aO8hn/Cgo1MN1hLOND6BTNNN+sx5l
X-Google-Smtp-Source: AGHT+IH9GV4+T6B4AcFN/dpjE9nmPcGHui7cS7pOfTLIrotP8XYFOkzNsMf5BNwrCvmiYAzqK7eThw==
X-Received: by 2002:a0d:f1c2:0:b0:5ff:6aac:42f7 with SMTP id a185-20020a0df1c2000000b005ff6aac42f7mr1428600ywf.99.1705618167029;
        Thu, 18 Jan 2024 14:49:27 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1f9b:f40:3dcf:f334])
        by smtp.gmail.com with ESMTPSA id u141-20020a0deb93000000b005ff943cb42esm476555ywe.41.2024.01.18.14.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 14:49:26 -0800 (PST)
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
Subject: [RFC bpf-next v2] bpf, selftests/bpf: Support PTR_MAYBE_NULL for struct_ops arguments.
Date: Thu, 18 Jan 2024 14:49:22 -0800
Message-Id: <20240118224922.336006-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

For nullable arguments, this patch sets an arg_info to label them with
PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This enforces the verifier to
check programs and ensure that they properly check the pointer. The
programs should check if the pointer is null before reading/writing the
pointed memory.

The implementer of a struct_ops should annotate the arguments that can be
null. The implementer should define a stub function (empty) as a
placeholder for each defined operator. The name of a stub function should
be in the pattern "<st_op_type>_stub_<operator name>". For example, for
test_maybe_null of struct bpf_testmod_ops, it's stub function name should
be "bpf_testmod_ops_stub_test_maybe_null". You mark an argument nullable by
suffixing the argument name with "__nullable" at the stub function.  Here
is the example in bpf_testmod.c.

  static int bpf_testmod_ops_stub_test_maybe_null(int dummy, struct
		task_struct *task__nullable)
  {
          return 0;
  }

This means that the argument 1 (2nd) of bpf_testmod_ops->test_maybe_null,
which is a function pointer that can be null. With this annotation, the
verifier will understand how to check programs using this arguments.  A BPF
program that implement test_maybe_null should check the pointer to make
sure it is not null before using it. For example,

  if (task__nullable)
      save_tgid = task__nullable->tgid

Without the check, the verifier will reject the program.

Since we already has stub functions for kCFI, we just reuse these stub
functions with the naming convention mentioned earlier. These stub
functions with the naming convention is only required if there are nullable
arguments to annotate. For functions without nullable arguments, stub
functions are not necessary for the purpose of this patch.

Major changes from v1:

 - Annotate arguments by suffixing argument names with "__nullable" at
   stub functions.
---
 include/linux/bpf.h                           |  17 +++
 kernel/bpf/btf.c                              | 134 +++++++++++++++++-
 kernel/bpf/verifier.c                         |   5 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  27 +++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   4 +
 .../prog_tests/test_struct_ops_maybe_null.c   |  39 +++++
 .../bpf/progs/struct_ops_maybe_null.c         |  27 ++++
 .../bpf/progs/struct_ops_maybe_null_fail.c    |  25 ++++
 8 files changed, 271 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a2522fcfe57c..d7a73a34b8c7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1413,6 +1413,7 @@ struct bpf_ctx_arg_aux {
 	u32 offset;
 	enum bpf_reg_type reg_type;
 	u32 btf_id;
+	struct btf *btf;
 };
 
 struct btf_mod_pair {
@@ -1679,6 +1680,11 @@ struct bpf_struct_ops {
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
 
+struct bpf_struct_ops_member_arg_info {
+	struct bpf_ctx_arg_aux *arg_info;
+	u32 arg_info_cnt;
+};
+
 struct bpf_struct_ops_desc {
 	struct bpf_struct_ops *st_ops;
 
@@ -1686,6 +1692,9 @@ struct bpf_struct_ops_desc {
 	const struct btf_type *value_type;
 	u32 type_id;
 	u32 value_id;
+
+	struct bpf_ctx_arg_aux *ctx_arg_info;
+	struct bpf_struct_ops_member_arg_info *member_arg_info;
 };
 
 enum bpf_struct_ops_state {
@@ -3303,4 +3312,12 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
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
index 81db591b4a22..4a8f59f89fe2 100644
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
@@ -8488,6 +8493,129 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 	return !strncmp(reg_name, arg_name, cmp_len);
 }
 
+#define MAYBE_NULL_SUFFIX "__nullable"
+#define MAX_STUB_NAME 128
+
+static const  struct btf_type *
+find_stub_func_proto(struct btf *btf, const char *st_op_name, const char *fptr_name)
+{
+	char stub_func_name[MAX_STUB_NAME];
+	const struct btf_type *t, *func_proto;
+	s32 btf_id;
+
+	snprintf(stub_func_name, MAX_STUB_NAME, "%s_stub_%s", st_op_name, fptr_name);
+	btf_id = btf_find_by_name_kind(btf, stub_func_name, BTF_KIND_FUNC);
+	if (btf_id < 0)
+		return NULL;
+	t = btf_type_by_id(btf, btf_id);
+	if (!t)
+		return NULL;
+	func_proto = btf_type_by_id(btf, t->type);
+
+	return func_proto;
+}
+
+static int
+init_arg_info(struct btf *btf, struct bpf_struct_ops *st_ops,
+	      struct btf_struct_ops_tab *tab)
+{
+	const struct btf_type *t, *func_proto, *stub_func_proto, *ptr_type;
+	const struct btf_member *m;
+	const struct btf_param *args;
+	const char *member_name;
+	const char *arg_name;
+	u32 i, nargs, nmembers, arg_no = 0;
+	s32 btf_id;
+	struct bpf_ctx_arg_aux *ctx_arg_info = NULL, *arg_info;;
+	struct bpf_struct_ops_member_arg_info *member_arg_info;
+	int arg_info_len = 0;
+	int err;
+
+	btf_id = btf_find_by_name_kind(btf, st_ops->name, BTF_KIND_STRUCT);
+	if (btf_id < 0)
+		return btf_id;
+
+	t = btf_type_by_id(btf, btf_id);
+	if (!t)
+		return -EINVAL;
+
+	if (!btf_type_is_struct(t))
+		return -EINVAL;
+
+	nmembers = btf_type_vlen(t);
+	member_arg_info = kzalloc(sizeof(*member_arg_info) * nmembers, GFP_KERNEL);
+	m = btf_members(t);
+	for (i = 0; i < nmembers; i++) {
+		func_proto = btf_type_resolve_func_ptr(btf, m[i].type, NULL);
+		if (!func_proto)
+			continue;
+
+		member_name = btf_name_by_offset(btf, m[i].name_off);
+		stub_func_proto = find_stub_func_proto(btf, st_ops->name, member_name);
+		if (!stub_func_proto)
+			continue;
+
+		nargs = btf_type_vlen(stub_func_proto);
+		if (nargs > MAX_BPF_FUNC_ARGS) {
+			err = -EINVAL;
+			goto errout;
+		}
+
+		args = btf_params(stub_func_proto);
+		for (arg_no = 0; arg_no < nargs; arg_no++) {
+			arg_name = btf_name_by_offset(btf, args[arg_no].name_off);
+			if (strlen(arg_name) < sizeof(MAYBE_NULL_SUFFIX) ||
+			    strcmp(arg_name + strlen(arg_name) - sizeof(MAYBE_NULL_SUFFIX) + 1,
+				   MAYBE_NULL_SUFFIX))
+				/* not a XXX__nullable arg */
+				continue;
+			/* should be a pointer to a struct type */
+			ptr_type = btf_type_resolve_ptr(btf, args[arg_no].type, NULL);
+			if (!ptr_type || !btf_type_is_struct(ptr_type)) {
+				err = -EINVAL;
+				goto errout;
+			}
+
+			ctx_arg_info = krealloc(ctx_arg_info,
+						sizeof(*ctx_arg_info) * (arg_info_len + 1),
+						GFP_KERNEL);
+			if (!ctx_arg_info) {
+				err = -ENOMEM;
+				goto errout;
+			}
+
+			arg_info = &ctx_arg_info[arg_info_len++];
+			arg_info->reg_type = PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL;
+			if (!btf_type_resolve_ptr(btf, args[arg_no].type, &arg_info->btf_id)) {
+				err = -EINVAL;
+				goto errout;
+			}
+			arg_info->btf = btf;
+			arg_info->offset = arg_no * sizeof(u64);
+			member_arg_info[i].arg_info_cnt++;
+		}
+	}
+
+	/* Initialize member_arg_info for every member */
+	arg_info = ctx_arg_info;
+	for (i = 0; i < nmembers; i++) {
+		if (!member_arg_info[i].arg_info_cnt)
+			continue;
+		member_arg_info[i].arg_info = arg_info;
+		arg_info += member_arg_info[i].arg_info_cnt;
+	}
+
+	tab->ops[btf->struct_ops_tab->cnt].ctx_arg_info = ctx_arg_info;
+	tab->ops[btf->struct_ops_tab->cnt].member_arg_info = member_arg_info;
+
+	return 0;
+
+errout:
+	kfree(member_arg_info);
+	kfree(ctx_arg_info);
+	return err;
+}
+
 static int
 btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops,
 		   struct bpf_verifier_log *log)
@@ -8530,6 +8658,9 @@ btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops,
 
 	tab->ops[btf->struct_ops_tab->cnt].st_ops = st_ops;
 
+	if (init_arg_info(btf, st_ops, tab) < 0)
+		return -EINVAL;
+
 	err = bpf_struct_ops_desc_init(&tab->ops[btf->struct_ops_tab->cnt], btf, log);
 	if (err)
 		return err;
@@ -8609,4 +8740,5 @@ int register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 
 	return err;
 }
+
 EXPORT_SYMBOL_GPL(register_bpf_struct_ops);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 60f08f468399..64a4b3f0c449 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20231,8 +20231,8 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct btf_type *t, *func_proto;
 	const struct bpf_struct_ops_desc *st_ops_desc;
 	const struct bpf_struct_ops *st_ops;
-	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
+	const struct btf_member *member;
 	u32 btf_id, member_idx;
 	struct btf *btf;
 	const char *mname;
@@ -20289,6 +20289,9 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		}
 	}
 
+	prog->aux->ctx_arg_info = st_ops_desc->member_arg_info[member_idx].arg_info;
+	prog->aux->ctx_arg_info_size = st_ops_desc->member_arg_info[member_idx].arg_info_cnt;
+
 	prog->aux->attach_func_proto = func_proto;
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index fe945d093378..bd98bb3734d4 100644
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
@@ -564,19 +569,31 @@ static void bpf_dummy_unreg(void *kdata)
 {
 }
 
-static int bpf_testmod_test_1(void)
+static int bpf_testmod_ops_stub_test_1(void)
 {
 	return 0;
 }
 
-static int bpf_testmod_test_2(int a, int b)
+static int bpf_testmod_ops_stub_test_2(int a, int b)
+{
+	return 0;
+}
+
+static int bpf_testmod_ops_stub_test_maybe_null(int dummy, struct task_struct *task__nullable)
+{
+	return 0;
+}
+
+static int bpf_testmod_ops_stub_test_non_maybe_null(int dummy, struct task_struct *task)
 {
 	return 0;
 }
 
 static struct bpf_testmod_ops __bpf_testmod_ops = {
-	.test_1 = bpf_testmod_test_1,
-	.test_2 = bpf_testmod_test_2,
+	.test_1 = bpf_testmod_ops_stub_test_1,
+	.test_2 = bpf_testmod_ops_stub_test_2,
+	.test_maybe_null = bpf_testmod_ops_stub_test_maybe_null,
+	.test_non_maybe_null = bpf_testmod_ops_stub_test_non_maybe_null,
 };
 
 struct bpf_struct_ops bpf_bpf_testmod_ops = {
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


