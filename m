Return-Path: <bpf+bounces-49894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512F5A2008B
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FC93A4442
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 22:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609CB1DC05F;
	Mon, 27 Jan 2025 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SAQ3TV7A"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F311DB951
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 22:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738016862; cv=none; b=ZUq6VVVf1G+FDEr+nXpg5U7efIyEv5LFMrgCXIY29f83Cb45vJY+Nmv0G4eJz54ZMKN7fj3YDHryUSyZSne51iJvDNJ7+PNa+N4SDQ5/2C1Ih98Vrv0DQn6+CRVM7f3zxFOF4FftbaO72LPv76eUahR2oYS04tm7Nz4fROC+Mbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738016862; c=relaxed/simple;
	bh=qwyomT270OZ+fFb3gdzKk4djx/Ko77r3v8bKpEP4px8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8Hfl2ik8fh9R75OxFcO7tfbjsgfbnNOeQJYUGaWVs/CAluqJjRR/uSj5Ml3OWX0tZyITeXZU/vaWUAX1kPovSLZi7EbpPEnR9RFpEI2e1UgcDnlRw9dHVX4L50rsMSxL/6UihF6HhvRKLo/oF8QCk6aWczaj8LSWlo1eoHzzPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SAQ3TV7A; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738016852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xqa9vZ7LVdK9kXeVi7kfFjHKe8Rw9F9uB4xyC9o7Br0=;
	b=SAQ3TV7AIP9MASQYs92Kf9jrhFHAsQL7Npm7DWI6IN8u0545PA5F8GddR9+mjkwdjSn46A
	YFvRV/s/S/583tFISHJHqK4mSgRWgHqC7XQZoTMr+K/qNuBxyR37vOza4OWGPX6i+aZRif
	NvgnGbW3icKI2UNmEkPS1G5kb9hwyO4=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>
Subject: [PATCH bpf-next] bpf: Use kallsyms to find the function name of a struct_ops's stub function
Date: Mon, 27 Jan 2025 14:27:19 -0800
Message-ID: <20250127222719.2544255-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

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
---
 kernel/bpf/bpf_struct_ops.c | 98 +++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 54 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 040fb1cd840b..9b7f3b9c5262 100644
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
2.43.5


