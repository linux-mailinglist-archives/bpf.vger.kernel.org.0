Return-Path: <bpf+bounces-21484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBB784DA62
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 07:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC154287421
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 06:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8022269306;
	Thu,  8 Feb 2024 06:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fllm0eue"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2717769300
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375074; cv=none; b=uYGb3u5owIatr7hDgYurAIPtOz/h6woZ7MzazjICHI1sTwO+Q3JWrkrJWu3RhIHpOjpqkTV0aEktVDsmk/RjOD9EDKes3cr/5V0bxw/u3hnboxDAy/9u4V9LAz+D66LHDitdUtXYBdQcWYjCWfQ5RasKhWf0hc99j0AbFMACDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375074; c=relaxed/simple;
	bh=lOrH4J3W0ygrZBMY0zgTUv9nMIp8xXzWMVxXEbhX1Po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ulD85/qx/8YGbmiutMNzK4Onh0F39FzmpH6ViFMFl1SzJDRLImYNrBxlCDAMmEyc5XJfo8ZosBGbVotKwBuUH86k3bAuJxmifG6wBoclvfERU59rdqfEzAllNZK3CLlGw3BzzJX/PCy9uB5KIFoamWW+nPO5PnoKJ5nTz2H8EbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fllm0eue; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60495209415so13838037b3.3
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 22:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707375071; x=1707979871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51F7VcLRf2Wd+gYo29Mip9pS2Z1Vgrk3wHLMj+uL3RU=;
        b=fllm0euep8ZJDoadr8gQjHsakcEscv2vb9RK11Yjcuzr4A06xTiMS9ULPisEfxBWp3
         pVVY85MscQmRL4nwyvwaYhgTfiQXGU2tdMuw80/m92kLrbu/2pmDfueGS9ZguNCzc8NU
         oreT9DXt1OZlOzlPYz89pGSZLxZihBkVu7CsDvFF3sq7u+OCY3N4ArL0aLxZUW/oJIfS
         kL5FGqMiEq1l61g8QsrYdqP0q1yCibGC+MSIdba7mqIH9xND5QhJ3BOg5nBgVczGG3cq
         yem+Fa9M6y8HJkXsefb/9Z7OreysM16wA5TzsZP2jFhp5TBPGMRACC/d90hDyYgjHiss
         pgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707375071; x=1707979871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51F7VcLRf2Wd+gYo29Mip9pS2Z1Vgrk3wHLMj+uL3RU=;
        b=Izlc179yVvID629iQRwmwQ29POT6IKsOvuiv1ZzR/bgGkLAlEFWzYybrKNxGyHMxoE
         pKUtagx1V7dHWWVQ9uGHKGBc9ujkYgFhwRKaVNbBVUjEk0jDW2egXLTMkH6iqVveTalH
         WJ5PgjuQaAhXHuNM16HNM1ChimjpylQC1ZPJzPU1H1VGxNAfLjNg5jYrEO9M9OamtBvw
         KcrUlcAl+sLAFEImERmqmU2Yx86P5eM3dSMNIkatPyCRlTS6HSfzOnxQTcWHjchWKW3S
         PGUtEeZEX7AA3o+TE/BNO+szcuySNehPA5aOFxJyvnZZVTY+iAdjFOWRb/LRW+aTssMD
         dWIg==
X-Gm-Message-State: AOJu0Yy2Aon5u0JJhYpUXUHjAKtrVKX+7tJToPaKZfQd4q0bXMU9N1PI
	EZfD3DhEFwdAtfM30+EvL+bWeKxvHjQYUVRKNgy2AawylFEbPcJzyp4cy4hoElc=
X-Google-Smtp-Source: AGHT+IHToiZhxOu+vroL0dFClCPGK5/MERs9Y5jfYB9s2D1UmTntIYgxA8NYtghWCnFwnHFzET0/3g==
X-Received: by 2002:a81:c40c:0:b0:604:788d:267f with SMTP id j12-20020a81c40c000000b00604788d267fmr7390413ywi.6.1707375070571;
        Wed, 07 Feb 2024 22:51:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWA/F3+f3jSt69VoHW03616jRt2Aox/PG9GZZvMKklyT4uN8f+e8DVWvw4exQLBGOgDhk+SQ6/aPKj5GQENHocd1c18OJmcV5DPxtiQPBlw5OpiWiyNWeCQaD7Qa83DZQ3J+4xM6Ya2QPqla688IRstSjRfpo4oKLp9vWDZaY+ZnnquflQ9wzO8HQtAXLj2QxbNnHzIXFUyPfOEbnOmRuLxphLIIjGTr7dXVzfPjjg605PIkdLAHk0qblT920esl0CuarppzwBkoafkNA9sPeXIcyA8x6gxlqvDKxEakBmt6hQ=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1d02:e957:f461:9a61])
        by smtp.gmail.com with ESMTPSA id u203-20020a8184d4000000b0060467650c64sm596917ywf.62.2024.02.07.22.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 22:51:10 -0800 (PST)
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
Subject: [PATCH bpf-next v6 3/4] bpf: Create argument information for nullable arguments.
Date: Wed,  7 Feb 2024 22:51:02 -0800
Message-Id: <20240208065103.2154768-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208065103.2154768-1-thinker.li@gmail.com>
References: <20240208065103.2154768-1-thinker.li@gmail.com>
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
 include/linux/bpf.h         |  22 ++++
 include/linux/btf.h         |   2 +
 kernel/bpf/bpf_struct_ops.c | 197 ++++++++++++++++++++++++++++++++++--
 kernel/bpf/btf.c            |  33 ++++++
 kernel/bpf/verifier.c       |   6 ++
 5 files changed, 253 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9a2ee9456989..6908bd2360ea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1709,6 +1709,19 @@ struct bpf_struct_ops {
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
 
+/* Every member of a struct_ops type has an instance even a member is not
+ * an operator (function pointer). The "arg_info" field will be assigned to
+ * prog->aux->ctx_arg_info of BPF struct_ops programs to provide the
+ * argument information required by the verifier to verify the program.
+ *
+ * btf_ctx_access() will lookup prog->aux->ctx_arg_info to find the
+ * corresponding entry for an given argument.
+ */
+struct bpf_struct_ops_arg_info {
+	struct bpf_ctx_arg_aux *arg_info;
+	u32 arg_info_cnt;
+};
+
 struct bpf_struct_ops_desc {
 	struct bpf_struct_ops *st_ops;
 
@@ -1716,6 +1729,9 @@ struct bpf_struct_ops_desc {
 	const struct btf_type *value_type;
 	u32 type_id;
 	u32 value_id;
+
+	/* Collection of argument information for each member */
+	struct bpf_struct_ops_arg_info *arg_info;
 };
 
 enum bpf_struct_ops_state {
@@ -1790,6 +1806,8 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			     struct btf *btf,
 			     struct bpf_verifier_log *log);
 void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
+void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc,
+				 int len);
 #else
 #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
 static inline bool bpf_try_module_get(const void *data, struct module *owner)
@@ -1814,6 +1832,10 @@ static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struc
 {
 }
 
+static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc, int len)
+{
+}
+
 #endif
 
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
diff --git a/include/linux/btf.h b/include/linux/btf.h
index df76a14c64f6..15ee845e6b38 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -498,6 +498,8 @@ static inline void *btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
 bool btf_param_match_suffix(const struct btf *btf,
 			    const struct btf_param *arg,
 			    const char *suffix);
+int btf_ctx_arg_offset(struct btf *btf, const struct btf_type *func_proto,
+		       u32 arg_no);
 
 struct bpf_verifier_log;
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index f98f580de77a..e9cc8c847736 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -116,17 +116,177 @@ static bool is_valid_value_type(struct btf *btf, s32 value_id,
 	return true;
 }
 
+#define MAYBE_NULL_SUFFIX "__nullable"
+#define MAX_STUB_NAME 128
+
+/* Return the type info of a stub function, if it exists.
+ *
+ * The name of a stub function is made up of the name of the struct_ops and
+ * the name of the function pointer member, separated by "__". For example,
+ * if the struct_ops type is named "foo_ops" and the function pointer
+ * member is named "bar", the stub function name would be "foo_ops__bar".
+ */
+static const struct btf_type *
+find_stub_func_proto(struct btf *btf, const char *st_op_name,
+		     const char *member_name)
+{
+	char stub_func_name[MAX_STUB_NAME];
+	const struct btf_type *func_type;
+	s32 btf_id;
+	int cp;
+
+	cp = snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s",
+		      st_op_name, member_name);
+	if (cp >= MAX_STUB_NAME) {
+		pr_warn("Stub function name too long\n");
+		return NULL;
+	}
+	btf_id = btf_find_by_name_kind(btf, stub_func_name, BTF_KIND_FUNC);
+	if (btf_id < 0)
+		return NULL;
+	func_type = btf_type_by_id(btf, btf_id);
+	if (!func_type)
+		return NULL;
+
+	return btf_type_by_id(btf, func_type->type); /* FUNC_PROTO */
+}
+
+/* Prepare argument info for every nullable argument of a member of a
+ * struct_ops type.
+ *
+ * Initialize a struct bpf_struct_ops_arg_info according to type info of
+ * the arguments of a stub function. (Check kCFI for more information about
+ * stub functions.)
+ *
+ * Each member in the struct_ops type has a struct bpf_struct_ops_arg_info
+ * to provide an array of struct bpf_ctx_arg_aux, which in turn provides
+ * the information that used by the verifier to check the arguments of the
+ * BPF struct_ops program assigned to the member. Here, we only care about
+ * the arguments that are marked as __nullable.
+ *
+ * The array of struct bpf_ctx_arg_aux is eventually assigned to
+ * prog->aux->ctx_arg_info of BPF struct_ops programs and passed to the
+ * verifier. (See check_struct_ops_btf_id())
+ *
+ * all_arg_info->arg_info will be the list of struct bpf_ctx_arg_aux if
+ * success. If fails, it will be kept untouched.
+ */
+static int prepare_arg_info(struct btf *btf,
+			    const char *st_ops_name,
+			    const char *member_name,
+			    const struct btf_type *func_proto,
+			    struct bpf_struct_ops_arg_info *all_arg_info)
+{
+	const struct btf_type *stub_func_proto, *pointed_type;
+	struct bpf_ctx_arg_aux *arg_info, *arg_info_buf;
+	const struct btf_param *stub_args, *args;
+	u32 nargs, arg_no, arg_info_cnt = 0;
+	s32 arg_btf_id;
+	int offset;
+
+	stub_func_proto = find_stub_func_proto(btf, st_ops_name, member_name);
+	if (!stub_func_proto)
+		return 0;
+
+	/* Check if the number of arguments of the stub function is the same
+	 * as the number of arguments of the function pointer.
+	 */
+	nargs = btf_type_vlen(func_proto);
+	if (nargs != btf_type_vlen(stub_func_proto)) {
+		pr_warn("the number of arguments of the stub function %s__%s does not match the number of arguments of the member %s of struct %s\n",
+			st_ops_name, member_name, member_name, st_ops_name);
+		return -EINVAL;
+	}
+
+	args = btf_params(func_proto);
+	stub_args = btf_params(stub_func_proto);
+
+	arg_info_buf = kcalloc(nargs, sizeof(*arg_info_buf), GFP_KERNEL);
+	if (!arg_info_buf)
+		return -ENOMEM;
+
+	/* Prepare arg_info for every nullable argument */
+	arg_info = arg_info_buf;
+	for (arg_no = 0; arg_no < nargs; arg_no++) {
+		/* Skip arguments that is not suffixed with
+		 * "__nullable".
+		 */
+		if (!btf_param_match_suffix(btf, &stub_args[arg_no],
+					    MAYBE_NULL_SUFFIX))
+			continue;
+
+		/* Should be a pointer to struct */
+		pointed_type = btf_type_resolve_ptr(btf,
+						    args[arg_no].type,
+						    &arg_btf_id);
+		if (!pointed_type ||
+		    !btf_type_is_struct(pointed_type))
+			goto err_out;
+
+		offset = btf_ctx_arg_offset(btf, func_proto, arg_no);
+		if (offset < 0)
+			goto err_out;
+
+		/* Fill the information of the new argument */
+		arg_info->reg_type =
+			PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
+		arg_info->btf_id = arg_btf_id;
+		arg_info->btf = btf;
+		arg_info->offset = offset;
+
+		arg_info++;
+		arg_info_cnt++;
+	}
+
+	if (arg_info_cnt) {
+		all_arg_info->arg_info = arg_info_buf;
+		all_arg_info->arg_info_cnt = arg_info_cnt;
+	} else {
+		kfree(arg_info_buf);
+	}
+
+	return 0;
+
+err_out:
+	kfree(arg_info_buf);
+
+	return -EINVAL;
+}
+
+/* Clean up the arg_info in a struct bpf_struct_ops_desc.
+ *
+ * The callers should pass the length of st_ops_desc->arg_info.  The length
+ * can not be derived from std_ops_desc->type since the list may be
+ * incomplete.
+ */
+void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc,
+				 int len)
+{
+	struct bpf_struct_ops_arg_info *arg_info;
+	int i;
+
+	arg_info = st_ops_desc->arg_info;
+	if (!arg_info)
+		return;
+
+	for (i = 0; i < len; i++)
+		kfree(arg_info[i].arg_info);
+
+	kfree(arg_info);
+}
+
 int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			     struct btf *btf,
 			     struct bpf_verifier_log *log)
 {
 	struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
+	struct bpf_struct_ops_arg_info *arg_info;
 	const struct btf_member *member;
 	const struct btf_type *t;
 	s32 type_id, value_id;
 	char value_name[128];
 	const char *mname;
-	int i;
+	int i, err;
 
 	if (strlen(st_ops->name) + VALUE_PREFIX_LEN >=
 	    sizeof(value_name)) {
@@ -160,6 +320,12 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	if (!is_valid_value_type(btf, value_id, t, value_name))
 		return -EINVAL;
 
+	arg_info = kcalloc(btf_type_vlen(t), sizeof(*arg_info),
+			   GFP_KERNEL);
+	if (!arg_info)
+		return -ENOMEM;
+
+	st_ops_desc->arg_info = arg_info;
 	for_each_member(i, t, member) {
 		const struct btf_type *func_proto;
 
@@ -167,32 +333,44 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
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
 						       member->type,
 						       NULL);
-		if (func_proto &&
-		    btf_distill_func_proto(log, btf,
+		if (!func_proto)
+			continue;
+
+		if (btf_distill_func_proto(log, btf,
 					   func_proto, mname,
 					   &st_ops->func_models[i])) {
 			pr_warn("Error in parsing func ptr %s in struct %s\n",
 				mname, st_ops->name);
-			return -EINVAL;
+			err = -EINVAL;
+			goto errout;
 		}
+
+		err = prepare_arg_info(btf, st_ops->name, mname,
+				       func_proto,
+				       arg_info + i);
+		if (err)
+			goto errout;
 	}
 
 	if (st_ops->init(btf)) {
 		pr_warn("Error in init bpf_struct_ops %s\n",
 			st_ops->name);
-		return -EINVAL;
+		err = -EINVAL;
+		goto errout;
 	}
 
 	st_ops_desc->type_id = type_id;
@@ -201,6 +379,11 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
 
 	return 0;
+
+errout:
+	bpf_struct_ops_desc_release(st_ops_desc, i);
+
+	return err;
 }
 
 static int bpf_struct_ops_map_get_next_key(struct bpf_map *map, void *key,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e3508b8008a2..554a57a0eaa5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1699,6 +1699,14 @@ static void btf_free_struct_meta_tab(struct btf *btf)
 static void btf_free_struct_ops_tab(struct btf *btf)
 {
 	struct btf_struct_ops_tab *tab = btf->struct_ops_tab;
+	int i;
+
+	if (!tab)
+		return;
+
+	for (i = 0; i < tab->cnt; i++)
+		bpf_struct_ops_desc_release(&tab->ops[i],
+					    btf_type_vlen(tab->ops[i].type));
 
 	kfree(tab);
 	btf->struct_ops_tab = NULL;
@@ -6130,6 +6138,31 @@ static bool prog_args_trusted(const struct bpf_prog *prog)
 	}
 }
 
+int btf_ctx_arg_offset(struct btf *btf, const struct btf_type *func_proto,
+		       u32 arg_no)
+{
+	const struct btf_param *args;
+	const struct btf_type *t;
+	int off = 0, i;
+	u32 sz, nargs;
+
+	nargs = btf_type_vlen(func_proto);
+	/* It is the return value if arg_no == nargs */
+	if (arg_no > nargs)
+		return -EINVAL;
+
+	args = btf_params(func_proto);
+	for (i = 0; i < arg_no; i++) {
+		t = btf_type_by_id(btf, args[i].type);
+		t = btf_resolve_size(btf, t, &sz);
+		if (IS_ERR(t))
+			return -EINVAL;
+		off += roundup(sz, 8);
+	}
+
+	return off;
+}
+
 bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    const struct bpf_prog *prog,
 		    struct bpf_insn_access_aux *info)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7edd70eec7dd..7826d6e6a09b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20415,6 +20415,12 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		}
 	}
 
+	/* btf_ctx_access() used this to provide argument type info */
+	prog->aux->ctx_arg_info =
+		st_ops_desc->arg_info[member_idx].arg_info;
+	prog->aux->ctx_arg_info_size =
+		st_ops_desc->arg_info[member_idx].arg_info_cnt;
+
 	prog->aux->attach_func_proto = func_proto;
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
-- 
2.34.1


