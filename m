Return-Path: <bpf+bounces-21096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C05847C10
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5ACB1C252CC
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8837212F38D;
	Fri,  2 Feb 2024 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVtzq38Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1C1332B9
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911529; cv=none; b=XQJyQYZWfJ+pT6MPXhNUY4Ee9fNGu4rNuyERAyHso2ZVFZMx9Ouf9jG6O4JpXEHjE6W+6deA9xNI2PKzO30DEw8qcidFO8jiGoUuBQHjaF5ANwldB+VtBo0ty8g8C3JOcZs3UrMd9S1lr1kObsRcxFstyzBZU3booo9xGYLf3Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911529; c=relaxed/simple;
	bh=/7Ho3TRxPV8XjZUr5rSuIMZAtg2tGDqN8LRgh17y82U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/mdj2XpMM71xoJAVVOnuomdQMTZEWqqmyMcpXgfu/hMMMMtApFfpfn8KJHjpRUve+VidyHgiRSemu5fd9qHnsm1PGuLMlKOdkQFLdLZ0f1jUD6o3U8kcCyCGKGlJeDiI8sIZFC/Hr0NCxhreRZYfSWyrOfwt3xrtDLHm52PJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVtzq38Q; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-604123a7499so25960097b3.3
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706911525; x=1707516325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeVpuuTTBYqimzLK3aKrYuDQuVv5st0y794mGeHOTzI=;
        b=lVtzq38QoOZFQRGUJvmHut/LNj0h+wzrHrHRXd0HXhYvQVFKXYKgNjHSjPJX2VogkA
         ryWNS1SwfA8HgZkdhW7emriHqbdS78slNxRnxTM1bmk2BHA5SMi4I+j3ncHtoJgPbUkK
         OxFM/ppYoIm1km/bjEVXuslsuyRuz4njG5Ok9FsgdEvZ+dkZ/S3PdflbFWApCrOzbw5+
         exvptL4eVKbPneED+R06/PDRhomVK9GUWM79+DtNb+47vI7MHzfZdPj44V9rYPc+pxC3
         yBUPzTSHx99aVfmh5Qro4yEHhMI1zm7AkXYd5ggoWTKSpPXT3ghKC1R0RNfQrFmMJMtD
         RsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911525; x=1707516325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeVpuuTTBYqimzLK3aKrYuDQuVv5st0y794mGeHOTzI=;
        b=SBYvd+GbfiXeocOkmHwQ+o/twQQeArR0+b0qRnfZpLyWEK102bP8qfxzQe4JtNE4/M
         6+sPsBJTXD8JZUtXSAxsWFz7hskrrUV6BWSs3VXVrEtQxefEqbdNgp0UpoGMI88Yk9eE
         j4gg73WiXPDs1g9A6++BdbaX9vjMJpJXxEW12NlzokH3sQxmPcojtdTkPxQdZL0l1tEy
         wjR+eQy84P9G2gCRfdBCKzUb3Z7IO/j27uJ/pS8GPJ1RdU3BFdY03o0ckqa//STPj/ww
         62yCQ5Qv6d9DRSXLj4vTMj9t6kZnoRZscYMbuCC3JlmQKxzgPydLWVCxR/D3UisvrB07
         /K+g==
X-Gm-Message-State: AOJu0YxcNa96l5b7bvufAZAsDUos1p1Xw3vvotMOteRjeO3SHbTP/1vM
	a0qjX/a1mYAx5Szi2XjBGERaU7/KTqQPkP5gl9G7MZBxwltZ8gN9rHIqbfRNyds=
X-Google-Smtp-Source: AGHT+IGee8CjxHuE+fTKMsjU8D0cCXBoWCrLT+rxy5LlJoqjMBE2arB+jybuQDw4G2PPVrxlLI6BiQ==
X-Received: by 2002:a0d:ddcc:0:b0:5ff:58f1:9944 with SMTP id g195-20020a0dddcc000000b005ff58f19944mr3605767ywe.30.1706911525553;
        Fri, 02 Feb 2024 14:05:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXlyIctVXlcb+ASGLD7BTS+b2xv8yQBL1Y/zoMzzRiWhSnMSxWf1GoN15quZxU3sL2JZHr9/EUBgUC24IPYktPViHmntBTQz+QZzC1zVQFzvRVYZ/YIx3od+OLzYKxfHqSF/upifSeuWaY0trB3j5wQ+7qJQ2p6AIDhGEt12AGvoWW6hvUctmk6v2kBnib3VVcfJfi4Etxaz14bSbPicO0OJU5us58fkC7Ec/7261hp2kwTTw7kWv3Fp7IMeWdRzy+YYUs3XKrXZfqRRKCjLEPTJDMLqOx/M651Ur0yMrqzXwQ=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b98b:e4f8:58e3:c2f])
        by smtp.gmail.com with ESMTPSA id z70-20020a814c49000000b006042345d3e2sm630696ywa.141.2024.02.02.14.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:05:25 -0800 (PST)
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
Subject: [RFC bpf-next v4 5/6] bpf: Create argument information for nullable arguments.
Date: Fri,  2 Feb 2024 14:05:15 -0800
Message-Id: <20240202220516.1165466-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202220516.1165466-1-thinker.li@gmail.com>
References: <20240202220516.1165466-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Collect argument information from the type information of stub functions to
mark arguments of BPF struct_ops programs with PTR_MAYBE_NULL if they are
nullable.  A nullable argument is annotated by suffixing "__nullable" at
the argument name of stub function.

For nullable arguments, this patch sets an arg_info to label their reg_type
with PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This makes the verifier
to check programs and ensure that they properly check the pointer. The
programs should check if the pointer is null before accessing the pointed
memory.

The implementer of a struct_ops type should annotate the arguments that can
be null. The implementer should define a stub function (empty) as a
placeholder for each defined operator. The name of a stub function should
be in the pattern "<st_op_type>__<operator name>". For example, for
test_maybe_null of struct bpf_testmod_ops, it's stub function name should
be "bpf_testmod_ops__test_maybe_null". You mark an argument nullable by
suffixing the argument name with "__nullable" at the stub function.

Since we already has stub functions for kCFI, we just reuse these stub
functions with the naming convention mentioned earlier. These stub
functions with the naming convention is only required if there are nullable
arguments to annotate. For functions having not nullable arguments, stub
functions are not necessary for the purpose of this patch.

This patch will prepare a list of struct bpf_ctx_arg_aux, aka arg_info, for
each member field of a struct_ops type.  "arg_info" will be assigned to
"prog->aux->ctx_arg_info" of BPF struct_ops programs in
check_struct_ops_btf_id() so that it can be used by btf_ctx_access() later
to set reg_type properly for the verifier.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  17 ++++
 kernel/bpf/bpf_struct_ops.c | 166 ++++++++++++++++++++++++++++++++++--
 kernel/bpf/btf.c            |  14 +++
 kernel/bpf/verifier.c       |   6 ++
 4 files changed, 198 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9a2ee9456989..63ef5cbfd213 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1709,6 +1709,19 @@ struct bpf_struct_ops {
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
 
+/* Every member of a struct_ops type has an instance even the member is not
+ * an operator (function pointer). The "arg_info" field will be assigned to
+ * prog->aux->arg_info of BPF struct_ops programs to provide the argument
+ * information required by the verifier to verify the program.
+ *
+ * btf_ctx_access() will lookup prog->aux->arg_info to find the
+ * corresponding entry for an given argument.
+ */
+struct bpf_struct_ops_member_arg_info {
+	struct bpf_ctx_arg_aux *arg_info;
+	u32 arg_info_cnt;
+};
+
 struct bpf_struct_ops_desc {
 	struct bpf_struct_ops *st_ops;
 
@@ -1716,6 +1729,10 @@ struct bpf_struct_ops_desc {
 	const struct btf_type *value_type;
 	u32 type_id;
 	u32 value_id;
+
+	/* Collection of argument information for each member */
+	struct bpf_struct_ops_member_arg_info *member_arg_info;
+	u32 member_arg_info_cnt;
 };
 
 enum bpf_struct_ops_state {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index f98f580de77a..313f6ceabcf4 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -116,17 +116,148 @@ static bool is_valid_value_type(struct btf *btf, s32 value_id,
 	return true;
 }
 
+#define MAYBE_NULL_SUFFIX "__nullable"
+#define MAX_STUB_NAME 128
+
+static int match_nullable_suffix(const char *name)
+{
+	int suffix_len, len;
+
+	if (!name)
+		return 0;
+
+	suffix_len = sizeof(MAYBE_NULL_SUFFIX) - 1;
+	len = strlen(name);
+	if (len < suffix_len)
+		return 0;
+
+	return !strcmp(name + len - suffix_len, MAYBE_NULL_SUFFIX);
+}
+
+/* Return the type info of a stub function, if it exists.
+ *
+ * The name of the stub function is made up of the name of the struct_ops
+ * and the name of the function pointer member, separated by "__". For
+ * example, if the struct_ops is named "foo_ops" and the function pointer
+ * member is named "bar", the stub function name would be "foo_ops__bar".
+ */
+static const  struct btf_type *
+find_stub_func_proto(struct btf *btf, const char *st_op_name,
+		     const char *member_name)
+{
+	char stub_func_name[MAX_STUB_NAME];
+	const struct btf_type *t, *func_proto;
+	s32 btf_id;
+
+	snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s",
+		 st_op_name, member_name);
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
+/* Prepare argument info for every nullable argument of a member of a
+ * struct_ops type.
+ *
+ * Create and initialize a list of struct bpf_struct_ops_member_arg_info
+ * according to type info of the arguments of the stub functions. (Check
+ * kCFI for more information about stub functions.)
+ *
+ * Each member in the struct_ops type has a struct
+ * bpf_struct_ops_member_arg_info to provide an array of struct
+ * bpf_ctx_arg_aux, which in turn provides the information that used by the
+ * verifier to check the arguments of the BPF struct_ops program assigned
+ * to the member. Here, we only care about the arguments that are marked as
+ * __nullable.
+ *
+ * The array of struct bpf_ctx_arg_aux is eventually assigned to
+ * prog->aux->ctx_arg_info of BPF struct_ops programs and passed to the
+ * verifier. (See check_struct_ops_btf_id())
+ */
+static int prepare_arg_info(struct btf *btf,
+			    const char *st_ops_name,
+			    const char *member_name,
+			    struct bpf_struct_ops_member_arg_info *member_arg_info)
+{
+	const struct btf_type *stub_func_proto, *ptr_type;
+	struct bpf_ctx_arg_aux *arg_info, *ai_buf = NULL;
+	const struct btf_param *args;
+	u32 nargs, arg_no = 0;
+	const char *arg_name;
+	s32 arg_btf_id;
+
+	stub_func_proto = find_stub_func_proto(btf, st_ops_name, member_name);
+	if (!stub_func_proto)
+		return 0;
+
+	nargs = btf_type_vlen(stub_func_proto);
+	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
+		pr_warn("Cannot support #%u args in stub func %s_stub_%s\n",
+			nargs, st_ops_name, member_name);
+		return -EINVAL;
+	}
+
+	ai_buf = kcalloc(nargs, sizeof(*ai_buf), GFP_KERNEL);
+	if (!ai_buf)
+		return -ENOMEM;
+
+	args = btf_params(stub_func_proto);
+	for (arg_no = 0; arg_no < nargs; arg_no++) {
+		/* Skip arguments that is not suffixed with
+		 * "__nullable".
+		 */
+		arg_name = btf_name_by_offset(btf,
+					      args[arg_no].name_off);
+		if (!match_nullable_suffix(arg_name))
+			continue;
+
+		/* Should be a pointer to struct, array, scalar, or enum */
+		ptr_type = btf_type_resolve_ptr(btf, args[arg_no].type,
+						&arg_btf_id);
+		if (!ptr_type ||
+		    (!btf_type_is_struct(ptr_type) &&
+		     !btf_type_is_array(ptr_type) &&
+		     !btf_type_is_scalar(ptr_type) &&
+		     !btf_is_any_enum(ptr_type))) {
+			kfree(ai_buf);
+			return -EINVAL;
+		}
+
+		/* Fill the information of the new argument */
+		arg_info = ai_buf + member_arg_info->arg_info_cnt++;
+		arg_info->reg_type =
+			PTR_TRUSTED | PTR_MAYBE_NULL | PTR_TO_BTF_ID;
+		arg_info->btf_id = arg_btf_id;
+		arg_info->btf = btf;
+		arg_info->offset = arg_no * sizeof(u64);
+	}
+
+	if (!member_arg_info->arg_info_cnt)
+		kfree(ai_buf);
+	else
+		member_arg_info->arg_info = ai_buf;
+
+	return 0;
+}
+
 int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			     struct btf *btf,
 			     struct bpf_verifier_log *log)
 {
+	struct bpf_struct_ops_member_arg_info *member_arg_info;
 	struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
 	const struct btf_member *member;
 	const struct btf_type *t;
 	s32 type_id, value_id;
 	char value_name[128];
 	const char *mname;
-	int i;
+	int i, err;
 
 	if (strlen(st_ops->name) + VALUE_PREFIX_LEN >=
 	    sizeof(value_name)) {
@@ -160,6 +291,11 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	if (!is_valid_value_type(btf, value_id, t, value_name))
 		return -EINVAL;
 
+	member_arg_info = kcalloc(btf_type_vlen(t), sizeof(*member_arg_info),
+				  GFP_KERNEL);
+	if (!member_arg_info)
+		return -ENOMEM;
+
 	for_each_member(i, t, member) {
 		const struct btf_type *func_proto;
 
@@ -167,13 +303,15 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		if (!*mname) {
 			pr_warn("anon member in struct %s is not supported\n",
 				st_ops->name);
-			return -EOPNOTSUPP;
+			err = -EOPNOTSUPP;
+			goto errout;
 		}
 
 		if (__btf_member_bitfield_size(t, member)) {
 			pr_warn("bit field member %s in struct %s is not supported\n",
 				mname, st_ops->name);
-			return -EOPNOTSUPP;
+			err = -EOPNOTSUPP;
+			goto errout;
 		}
 
 		func_proto = btf_type_resolve_func_ptr(btf,
@@ -185,14 +323,24 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 					   &st_ops->func_models[i])) {
 			pr_warn("Error in parsing func ptr %s in struct %s\n",
 				mname, st_ops->name);
-			return -EINVAL;
+			err = -EINVAL;
+			goto errout;
 		}
+
+		err = prepare_arg_info(btf, st_ops->name, mname,
+				       member_arg_info + i);
+		if (err)
+			goto errout;
 	}
 
+	st_ops_desc->member_arg_info = member_arg_info;
+	st_ops_desc->member_arg_info_cnt = btf_type_vlen(t);
+
 	if (st_ops->init(btf)) {
 		pr_warn("Error in init bpf_struct_ops %s\n",
 			st_ops->name);
-		return -EINVAL;
+		err = -EINVAL;
+		goto errout;
 	}
 
 	st_ops_desc->type_id = type_id;
@@ -201,6 +349,14 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
 
 	return 0;
+
+errout:
+	while (i > 0)
+		kfree(member_arg_info[--i].arg_info);
+	kfree(member_arg_info);
+	st_ops_desc->member_arg_info = NULL;
+
+	return err;
 }
 
 static int bpf_struct_ops_map_get_next_key(struct bpf_map *map, void *key,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 20d2160b3db5..fd192f69eb78 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1699,6 +1699,20 @@ static void btf_free_struct_meta_tab(struct btf *btf)
 static void btf_free_struct_ops_tab(struct btf *btf)
 {
 	struct btf_struct_ops_tab *tab = btf->struct_ops_tab;
+	struct bpf_struct_ops_member_arg_info *ma_info;
+	int i, j;
+	u32 cnt;
+
+	if (tab)
+		for (i = 0; i < tab->cnt; i++) {
+			ma_info = tab->ops[i].member_arg_info;
+			if (ma_info) {
+				cnt = tab->ops[i].member_arg_info_cnt;
+				for (j = 0; j < cnt; j++)
+					kfree(ma_info[j].arg_info);
+			}
+			kfree(ma_info);
+		}
 
 	kfree(tab);
 	btf->struct_ops_tab = NULL;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cd4d780e5400..d1d1c2836bc2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20373,6 +20373,12 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		}
 	}
 
+	/* btf_ctx_access() used this to provide argument type info */
+	prog->aux->ctx_arg_info =
+		st_ops_desc->member_arg_info[member_idx].arg_info;
+	prog->aux->ctx_arg_info_size =
+		st_ops_desc->member_arg_info[member_idx].arg_info_cnt;
+
 	prog->aux->attach_func_proto = func_proto;
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
-- 
2.34.1


