Return-Path: <bpf+bounces-21572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A1D84EEC8
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 03:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3DE1F2717E
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 02:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4C41865;
	Fri,  9 Feb 2024 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3mhdUo3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFA3538A
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707444063; cv=none; b=Bh9MlaWTuQmjmQsABygpTV95HQYKuIGhiNmbGZwTMsFLqYORtmGTXqTjKLvrrvsS+XQUnXZdxfZQphQxnF5U6fro640pKxNrQPJX4p1FrcDHgNTgicgnl9taeyDi4nxfMNWNjy7+G9AbDqFI2H7iuyfLQ1oIKJbc8fz2J1sbpag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707444063; c=relaxed/simple;
	bh=efhGLILJ57/+vF/Ieq4VvkQt3oeiyRVeg5CoWmgvxCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YmcllMxsxNCUe7xKE22Ys83X9jvIXydN1xGU3NrL2dOqyE2FOGcLuVA/lJedjWE+z81XGsV4xMsk78CCS+t8DKJHQ/G7z1+nhOZVzf7wWC8LGklJe/uDUMhN7qkN36aXf1m9DCV5txdUxnvvH3FMBP045BT2NKq4ED4UBQuATac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3mhdUo3; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-604b4eed8fbso6604887b3.3
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 18:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707444060; x=1708048860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF0P5JrrO9sYXVn5vAyjxmAQ/pBHydjFb/O4TgrSsmw=;
        b=G3mhdUo35gNCVSUHPISWSgX8N+L8ubLe0QA9V1Scw/xFoJ+92IWPQsJRNdq1Cxe9S6
         ldNi4ku23kzG6puTgycc4GOfqq740W/xWvrmahEUD7RbBKSPo9rPTub/9Dul/YjUvPVp
         rUhnpyKzP42yADCFuKWgOAiv1Y+ufoOVrAo4XoSnlvNSeMjDt83OFn2ZD68DcrecIqSD
         dVIQXWIwvySuzkFT/PPK7LFQH/d/vspQSiI2nmkAhvYd23SxX/xyHip63rmkiwN9DB3h
         vwNDqTd9XiL045FuDqvJtEymtDmpN5dLvrI0J4S7CMP+6Mzh4LB2E2SIdaYSi4LdBv0N
         o7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707444060; x=1708048860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UF0P5JrrO9sYXVn5vAyjxmAQ/pBHydjFb/O4TgrSsmw=;
        b=GDpGwCYz/EnoEdI9IqUE2KrPQYPS4oRkMqzEx2XFK5/Xhx8w6sFyqlfu2iFJukBVvC
         kH6TH2K5j0e02CJ3bi9HOGpOWJX+q0OQuRWxuv5dow51o4sn/W/BUWnbNkXBRfa+hrbO
         l3TDDP0tiWM03hFdI7HnajlBlUCi/mwHjfOS4WoaMsfMnLowJ7Bsdu+fZU7flbYuWx/M
         cq3gjr15YKaMRV3FdMwI9SC42pjrF/g3aFYi/iAFdGtdHQ8Td+XdxSx46qJvazI9sPBt
         V3txVOFFs6yNss02XENYZ71Ay77w4rEVMEy5RC8LyuDqtbp305go+/1C4emWDup8KCYp
         XSDg==
X-Gm-Message-State: AOJu0Yyby9fQIaEq4KD67rEOSUwrX8TWXKc4tCoXHrua8gB/+bX4c6sN
	gLUsr917kBQDl3OrUvIPhsTBsd7byDlaXEObcN+QEK9gaHu9683YaBo+Hnw+nHU=
X-Google-Smtp-Source: AGHT+IHl63h/g7sdLjHWxC+OIaQI+Yz84plR3UK9TbPUtHwFStY5GRLH2Aw7Nc+iB5xY0XGEzy9mcA==
X-Received: by 2002:a81:8946:0:b0:602:c1e2:c6ee with SMTP id z67-20020a818946000000b00602c1e2c6eemr133915ywf.44.1707444059579;
        Thu, 08 Feb 2024 18:00:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNWFguJlfk1Dj1bqsUxNz4k46THEomjxge1W6K6rV0mReAU0UJacRJjDNEZqvWA1H01Wls2NzWgSzHy/adAALTEn4OHMf+vJ90XxgZNyp7NsSTZ71PhYlhIK+oepcl1HnMqDWykOXkEmZKCaobrCGb9ssmVUfUEBrWvICxdyrJWAt7ZP6sxfxPPNb17mlHIYfGqjG3spsTzK/5nDiU/86Kix6mqrFYJ/cs/0GQePWD2qRyzaafnX7IHnOXpqGR+Y2rQasSzuO+6KPDOIcDd9P/G6z4KV1bUlI/yjagNKZybfw=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id h123-20020a0dc581000000b006041f5a308esm134982ywd.133.2024.02.08.18.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 18:00:59 -0800 (PST)
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
Subject: [PATCH bpf-next v7 3/4] bpf: Create argument information for nullable arguments.
Date: Thu,  8 Feb 2024 18:00:52 -0800
Message-Id: <20240209020053.1132710-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209020053.1132710-1-thinker.li@gmail.com>
References: <20240209020053.1132710-1-thinker.li@gmail.com>
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

For nullable arguments, this patch sets a struct bpf_ctx_arg_aux to label
their reg_type with PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This
makes the verifier to check programs and ensure that they properly check
the pointer. The programs should check if the pointer is null before
accessing the pointed memory.

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
 include/linux/bpf.h         |  21 ++++
 include/linux/btf.h         |   2 +
 kernel/bpf/bpf_struct_ops.c | 210 +++++++++++++++++++++++++++++++++---
 kernel/bpf/btf.c            |  27 +++++
 kernel/bpf/verifier.c       |   6 ++
 5 files changed, 254 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9a2ee9456989..b4efec1ace48 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1709,6 +1709,19 @@ struct bpf_struct_ops {
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
 
+/* Every member of a struct_ops type has an instance even a member is not
+ * an operator (function pointer). The "info" field will be assigned to
+ * prog->aux->ctx_arg_info of BPF struct_ops programs to provide the
+ * argument information required by the verifier to verify the program.
+ *
+ * btf_ctx_access() will lookup prog->aux->ctx_arg_info to find the
+ * corresponding entry for an given argument.
+ */
+struct bpf_struct_ops_arg_info {
+	struct bpf_ctx_arg_aux *info;
+	u32 cnt;
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
@@ -1790,6 +1806,7 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			     struct btf *btf,
 			     struct bpf_verifier_log *log);
 void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
+void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc);
 #else
 #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
 static inline bool bpf_try_module_get(const void *data, struct module *owner)
@@ -1814,6 +1831,10 @@ static inline void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struc
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
index f98f580de77a..98448eecbde3 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -116,17 +116,180 @@ static bool is_valid_value_type(struct btf *btf, s32 value_id,
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
+ * arg_info->info will be the list of struct bpf_ctx_arg_aux if success. If
+ * fails, it will be kept untouched.
+ */
+static int prepare_arg_info(struct btf *btf,
+			    const char *st_ops_name,
+			    const char *member_name,
+			    const struct btf_type *func_proto,
+			    struct bpf_struct_ops_arg_info *arg_info)
+{
+	const struct btf_type *stub_func_proto, *pointed_type;
+	const struct btf_param *stub_args, *args;
+	struct bpf_ctx_arg_aux *info, *info_buf;
+	u32 nargs, arg_no, info_cnt = 0;
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
+	info_buf = kcalloc(nargs, sizeof(*info_buf), GFP_KERNEL);
+	if (!info_buf)
+		return -ENOMEM;
+
+	/* Prepare info for every nullable argument */
+	info = info_buf;
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
+		    !btf_type_is_struct(pointed_type)) {
+			pr_warn("stub function %s__%s has %s tagging to an unsupported type\n",
+				st_ops_name, member_name, MAYBE_NULL_SUFFIX);
+			goto err_out;
+		}
+
+		offset = btf_ctx_arg_offset(btf, func_proto, arg_no);
+		if (offset < 0) {
+			pr_warn("stub function %s__%s has an invalid trampoline ctx offset for arg#%u\n",
+				st_ops_name, member_name, arg_no);
+			goto err_out;
+		}
+
+		/* Fill the information of the new argument */
+		info->reg_type =
+			PTR_TRUSTED | PTR_TO_BTF_ID | PTR_MAYBE_NULL;
+		info->btf_id = arg_btf_id;
+		info->btf = btf;
+		info->offset = offset;
+
+		info++;
+		info_cnt++;
+	}
+
+	if (info_cnt) {
+		arg_info->info = info_buf;
+		arg_info->cnt = info_cnt;
+	} else {
+		kfree(info_buf);
+	}
+
+	return 0;
+
+err_out:
+	kfree(info_buf);
+
+	return -EINVAL;
+}
+
+/* Clean up the arg_info in a struct bpf_struct_ops_desc.
+ *
+ * The callers should pass the length of st_ops_desc->arg_info.
+ */
+void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_ops_desc)
+{
+	struct bpf_struct_ops_arg_info *arg_info;
+	int i;
+
+	arg_info = st_ops_desc->arg_info;
+	if (!arg_info)
+		return;
+
+	for (i = 0; i < btf_type_vlen(st_ops_desc->type); i++)
+		kfree(arg_info[i].info);
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
@@ -160,6 +323,17 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	if (!is_valid_value_type(btf, value_id, t, value_name))
 		return -EINVAL;
 
+	arg_info = kcalloc(btf_type_vlen(t), sizeof(*arg_info),
+			   GFP_KERNEL);
+	if (!arg_info)
+		return -ENOMEM;
+
+	st_ops_desc->arg_info = arg_info;
+	st_ops_desc->type = t;
+	st_ops_desc->type_id = type_id;
+	st_ops_desc->value_id = value_id;
+	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
+
 	for_each_member(i, t, member) {
 		const struct btf_type *func_proto;
 
@@ -167,40 +341,52 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
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
 
-	st_ops_desc->type_id = type_id;
-	st_ops_desc->type = t;
-	st_ops_desc->value_id = value_id;
-	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
-
 	return 0;
+
+errout:
+	bpf_struct_ops_desc_release(st_ops_desc);
+
+	return err;
 }
 
 static int bpf_struct_ops_map_get_next_key(struct bpf_map *map, void *key,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index db53bb76387e..533f02b92c94 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1699,6 +1699,13 @@ static void btf_free_struct_meta_tab(struct btf *btf)
 static void btf_free_struct_ops_tab(struct btf *btf)
 {
 	struct btf_struct_ops_tab *tab = btf->struct_ops_tab;
+	int i;
+
+	if (!tab)
+		return;
+
+	for (i = 0; i < tab->cnt; i++)
+		bpf_struct_ops_desc_release(&tab->ops[i]);
 
 	kfree(tab);
 	btf->struct_ops_tab = NULL;
@@ -6130,6 +6137,26 @@ static bool prog_args_trusted(const struct bpf_prog *prog)
 	}
 }
 
+int btf_ctx_arg_offset(struct btf *btf, const struct btf_type *func_proto,
+		       u32 arg_no)
+{
+	const struct btf_param *args;
+	const struct btf_type *t;
+	int off = 0, i;
+	u32 sz;
+
+	args = btf_params(func_proto);
+	for (i = 0; i < arg_no; i++) {
+		t = btf_type_by_id(btf, args[i].type);
+		t = btf_resolve_size(btf, t, &sz);
+		if (IS_ERR(t))
+			return PTR_ERR(t);
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
index c92d6af7d975..72ca27f49616 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20419,6 +20419,12 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		}
 	}
 
+	/* btf_ctx_access() used this to provide argument type info */
+	prog->aux->ctx_arg_info =
+		st_ops_desc->arg_info[member_idx].info;
+	prog->aux->ctx_arg_info_size =
+		st_ops_desc->arg_info[member_idx].cnt;
+
 	prog->aux->attach_func_proto = func_proto;
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
-- 
2.34.1


