Return-Path: <bpf+bounces-57410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1182AAA7BA
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 02:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F75298487C
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 00:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4681933BC77;
	Mon,  5 May 2025 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utn7JSQX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC533BC62;
	Mon,  5 May 2025 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484644; cv=none; b=DmpMWk7GqynUKJtdCv1pI2pgZhvUHFpAK7pTt0jlu9X1xMyPw6LXGg+kXcWb+vvIPiEb/q2fbgSstYOdOjvX6JHbrjBRvLRxCGWK3F5xaWrkS0zKqOfNH4cRlZpDy3JfD94meK+ZNmrEk7h7eCLUYsKC0kJGtpOWIMsZkVowJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484644; c=relaxed/simple;
	bh=Hi88nQ4OudGHiPtOttkCQ9rUwlJB51TRq2s3n2L4px0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAwIcUj45QJQM1+3VkHm6hPDJR5JEwmxQIwqpDg6Dz1qHdf9cr664UHneh1O+342+kzjKKjxWN9v6Bpw8HDbhgtiiK4tGKv+mAurNIzjX259dxntHgmNgnRfAtzrkYenWWfdreCN4RPeZGOe7vULlIs6J81m7ihf+AIE/dl1bd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utn7JSQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB88C4CEE4;
	Mon,  5 May 2025 22:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484644;
	bh=Hi88nQ4OudGHiPtOttkCQ9rUwlJB51TRq2s3n2L4px0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utn7JSQX8NwkjUbCJlRQ/SMgOlzcoIee5seP1Ej4U/r7vO7+LETGVahGhzP5mcdiz
	 wZ+UL0ft6tEmh8YQwNKSoRuOXgUi/i5/dxTzxtiKk1w/Wl5W+anAMJOJY6bltTiq36
	 I8oYWNK/U663/qX0ZFxHion3cFJp7eN8RUIBRVULcwrsfWG3lnd1hN1s0kqdHNmA9H
	 ntbW2J2BrWstmNIorhdcmDEMeu1Wb6V+DfVEX+RFe6+T9OxABZtaDB86rp2YPDf/Qt
	 2RYm7nPlwXNlC2LP3d7a125k2gMiC0iUdUxD+aV+Cdb+uAbTrTMRNhAG2SwoNgqBxK
	 hq8JDNTW++xlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 580/642] bpf: Use kallsyms to find the function name of a struct_ops's stub function
Date: Mon,  5 May 2025 18:13:16 -0400
Message-Id: <20250505221419.2672473-580-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

[ Upstream commit 12fdd29d5d71d2987a1aec434b704d850a4d7fcb ]

In commit 1611603537a4 ("bpf: Create argument information for nullable arguments."),
it introduced a "__nullable" tagging at the argument name of a
stub function. Some background on the commit:
it requires to tag the stub function instead of directly tagging
the "ops" of a struct. This is because the btf func_proto of the "ops"
does not have the argument name and the "__nullable" is tagged at
the argument name.

To find the stub function of a "ops", it currently relies on a naming
convention on the stub function "st_ops__ops_name".
e.g. tcp_congestion_ops__ssthresh. However, the new kernel
sub system implementing bpf_struct_ops have missed this and
have been surprised that the "__nullable" and the to-be-landed
"__ref" tagging was not effective.

One option would be to give a warning whenever the stub function does
not follow the naming convention, regardless if it requires arg tagging
or not.

Instead, this patch uses the kallsyms_lookup approach and removes
the requirement on the naming convention. The st_ops->cfi_stubs has
all the stub function kernel addresses. kallsyms_lookup() is used to
lookup the function name. With the function name, BTF can be used to
find the BTF func_proto. The existing "__nullable" arg name searching
logic will then fall through.

One notable change is,
if it failed in kallsyms_lookup or it failed in looking up the stub
function name from the BTF, the bpf_struct_ops registration will fail.
This is different from the previous behavior that it silently ignored
the "st_ops__ops_name" function not found error.

The "tcp_congestion_ops", "sched_ext_ops", and "hid_bpf_ops" can still be
registered successfully after this patch. There is struct_ops_maybe_null
selftest to cover the "__nullable" tagging.

Other minor changes:
1. Removed the "%s__%s" format from the pr_warn because the naming
   convention is removed.
2. The existing bpf_struct_ops_supported() is also moved earlier
   because prepare_arg_info needs to use it to decide if the
   stub function is NULL before calling the prepare_arg_info.

Cc: Tejun Heo <tj@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Link: https://lore.kernel.org/r/20250127222719.2544255-1-martin.lau@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/bpf_struct_ops.c | 98 +++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 54 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 040fb1cd840b6..9b7f3b9c52622 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -146,39 +146,6 @@ void bpf_struct_ops_image_free(void *image)
 }
 
 #define MAYBE_NULL_SUFFIX "__nullable"
-#define MAX_STUB_NAME 128
-
-/* Return the type info of a stub function, if it exists.
- *
- * The name of a stub function is made up of the name of the struct_ops and
- * the name of the function pointer member, separated by "__". For example,
- * if the struct_ops type is named "foo_ops" and the function pointer
- * member is named "bar", the stub function name would be "foo_ops__bar".
- */
-static const struct btf_type *
-find_stub_func_proto(const struct btf *btf, const char *st_op_name,
-		     const char *member_name)
-{
-	char stub_func_name[MAX_STUB_NAME];
-	const struct btf_type *func_type;
-	s32 btf_id;
-	int cp;
-
-	cp = snprintf(stub_func_name, MAX_STUB_NAME, "%s__%s",
-		      st_op_name, member_name);
-	if (cp >= MAX_STUB_NAME) {
-		pr_warn("Stub function name too long\n");
-		return NULL;
-	}
-	btf_id = btf_find_by_name_kind(btf, stub_func_name, BTF_KIND_FUNC);
-	if (btf_id < 0)
-		return NULL;
-	func_type = btf_type_by_id(btf, btf_id);
-	if (!func_type)
-		return NULL;
-
-	return btf_type_by_id(btf, func_type->type); /* FUNC_PROTO */
-}
 
 /* Prepare argument info for every nullable argument of a member of a
  * struct_ops type.
@@ -203,27 +170,42 @@ find_stub_func_proto(const struct btf *btf, const char *st_op_name,
 static int prepare_arg_info(struct btf *btf,
 			    const char *st_ops_name,
 			    const char *member_name,
-			    const struct btf_type *func_proto,
+			    const struct btf_type *func_proto, void *stub_func_addr,
 			    struct bpf_struct_ops_arg_info *arg_info)
 {
 	const struct btf_type *stub_func_proto, *pointed_type;
 	const struct btf_param *stub_args, *args;
 	struct bpf_ctx_arg_aux *info, *info_buf;
 	u32 nargs, arg_no, info_cnt = 0;
+	char ksym[KSYM_SYMBOL_LEN];
+	const char *stub_fname;
+	s32 stub_func_id;
 	u32 arg_btf_id;
 	int offset;
 
-	stub_func_proto = find_stub_func_proto(btf, st_ops_name, member_name);
-	if (!stub_func_proto)
-		return 0;
+	stub_fname = kallsyms_lookup((unsigned long)stub_func_addr, NULL, NULL, NULL, ksym);
+	if (!stub_fname) {
+		pr_warn("Cannot find the stub function name for the %s in struct %s\n",
+			member_name, st_ops_name);
+		return -ENOENT;
+	}
+
+	stub_func_id = btf_find_by_name_kind(btf, stub_fname, BTF_KIND_FUNC);
+	if (stub_func_id < 0) {
+		pr_warn("Cannot find the stub function %s in btf\n", stub_fname);
+		return -ENOENT;
+	}
+
+	stub_func_proto = btf_type_by_id(btf, stub_func_id);
+	stub_func_proto = btf_type_by_id(btf, stub_func_proto->type);
 
 	/* Check if the number of arguments of the stub function is the same
 	 * as the number of arguments of the function pointer.
 	 */
 	nargs = btf_type_vlen(func_proto);
 	if (nargs != btf_type_vlen(stub_func_proto)) {
-		pr_warn("the number of arguments of the stub function %s__%s does not match the number of arguments of the member %s of struct %s\n",
-			st_ops_name, member_name, member_name, st_ops_name);
+		pr_warn("the number of arguments of the stub function %s does not match the number of arguments of the member %s of struct %s\n",
+			stub_fname, member_name, st_ops_name);
 		return -EINVAL;
 	}
 
@@ -253,21 +235,21 @@ static int prepare_arg_info(struct btf *btf,
 						    &arg_btf_id);
 		if (!pointed_type ||
 		    !btf_type_is_struct(pointed_type)) {
-			pr_warn("stub function %s__%s has %s tagging to an unsupported type\n",
-				st_ops_name, member_name, MAYBE_NULL_SUFFIX);
+			pr_warn("stub function %s has %s tagging to an unsupported type\n",
+				stub_fname, MAYBE_NULL_SUFFIX);
 			goto err_out;
 		}
 
 		offset = btf_ctx_arg_offset(btf, func_proto, arg_no);
 		if (offset < 0) {
-			pr_warn("stub function %s__%s has an invalid trampoline ctx offset for arg#%u\n",
-				st_ops_name, member_name, arg_no);
+			pr_warn("stub function %s has an invalid trampoline ctx offset for arg#%u\n",
+				stub_fname, arg_no);
 			goto err_out;
 		}
 
 		if (args[arg_no].type != stub_args[arg_no].type) {
-			pr_warn("arg#%u type in stub function %s__%s does not match with its original func_proto\n",
-				arg_no, st_ops_name, member_name);
+			pr_warn("arg#%u type in stub function %s does not match with its original func_proto\n",
+				arg_no, stub_fname);
 			goto err_out;
 		}
 
@@ -324,6 +306,13 @@ static bool is_module_member(const struct btf *btf, u32 id)
 	return !strcmp(btf_name_by_offset(btf, t->name_off), "module");
 }
 
+int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff)
+{
+	void *func_ptr = *(void **)(st_ops->cfi_stubs + moff);
+
+	return func_ptr ? 0 : -ENOTSUPP;
+}
+
 int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			     struct btf *btf,
 			     struct bpf_verifier_log *log)
@@ -387,7 +376,10 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 
 	for_each_member(i, t, member) {
 		const struct btf_type *func_proto;
+		void **stub_func_addr;
+		u32 moff;
 
+		moff = __btf_member_bit_offset(t, member) / 8;
 		mname = btf_name_by_offset(btf, member->name_off);
 		if (!*mname) {
 			pr_warn("anon member in struct %s is not supported\n",
@@ -413,7 +405,11 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		func_proto = btf_type_resolve_func_ptr(btf,
 						       member->type,
 						       NULL);
-		if (!func_proto)
+
+		/* The member is not a function pointer or
+		 * the function pointer is not supported.
+		 */
+		if (!func_proto || bpf_struct_ops_supported(st_ops, moff))
 			continue;
 
 		if (btf_distill_func_proto(log, btf,
@@ -425,8 +421,9 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 			goto errout;
 		}
 
+		stub_func_addr = *(void **)(st_ops->cfi_stubs + moff);
 		err = prepare_arg_info(btf, st_ops->name, mname,
-				       func_proto,
+				       func_proto, stub_func_addr,
 				       arg_info + i);
 		if (err)
 			goto errout;
@@ -1152,13 +1149,6 @@ void bpf_struct_ops_put(const void *kdata)
 	bpf_map_put(&st_map->map);
 }
 
-int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff)
-{
-	void *func_ptr = *(void **)(st_ops->cfi_stubs + moff);
-
-	return func_ptr ? 0 : -ENOTSUPP;
-}
-
 static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
-- 
2.39.5


