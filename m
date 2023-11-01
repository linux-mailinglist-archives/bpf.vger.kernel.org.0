Return-Path: <bpf+bounces-13822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7F87DE6D1
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C99128197D
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 20:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA93E8485;
	Wed,  1 Nov 2023 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZaLYWj3"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A768D883E
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:45:27 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8BE10D
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 13:45:26 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso183833276.3
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698871525; x=1699476325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P89SVJtq5j8zsLeBIQYzZ3INapX8tpzdjvC7+Jnea5w=;
        b=LZaLYWj3oUBBsVslQbuuW7rOmHTAOpEQGSVTHgwIrzA/5bdY73w7uoeyLZRVFEZRfa
         n6zw/93YFAyrt+6flzotWDLA37Gs4p304HzpevLzoh2JsXacVR7Nv9ahO+hWIf6AvkwU
         KroxecRpBvI/ikXhkjsGPhm38149MiqCbZQaC4QI/zdVqY+1YNx4+6V3vQE3jOgF7Gyg
         q9C4MYUUmrtE3uSGGDbJLxcgw3PWLREB6r1vkd66ApKPvl0V3xidwhX/1Io2EV7MmJ6w
         iMwI08DUkfLanGBbCzUWyuAZeyOiQoIrvILp1Yv+Z+4MF/t4P2Hrddsz5FEWrZwD9Qlc
         WVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698871525; x=1699476325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P89SVJtq5j8zsLeBIQYzZ3INapX8tpzdjvC7+Jnea5w=;
        b=WtWHMrWN2JcHS5M4gAly6PmoBBpVwifA63LMwTdJ3qXrsl5ltHyWDrDOqdNXjSp0Cy
         oSkW1bYvDAViznashCTI/r8d1Wi3a1ASlNUFUcOp0dCkfJiRUi0KtI498SY+FYbEzsoS
         KG8JX5iHsj0sUbhN5PHvz9wU95aRub5ZLJwVjsATHfVFrjqTY9lIrtTO2rOrwgNanlap
         MOU3MklkZKhgDw1sOKn31Aj1JcfQoIvlzHmJewJ4Ip479r2N8SfiYGcL/mbDgGW5ZA3A
         sVJKVDG4tCXZHHr0TuDae1Q5zrfvjdibhAJgPbnGUvozwElTNk8d96FLNN2zyb8ABz4V
         nS2w==
X-Gm-Message-State: AOJu0Yy6dXUfA/9yXXsr6jQtwb2o9DUyYkLkOGRAlGFQrsmYk7yfMnrI
	/X3hh0GKK0kh88MvbpSV9HKr+IDr4BM=
X-Google-Smtp-Source: AGHT+IE13it2Jnnlmb3+SjaDeL/H/nNw+ixHCsY12g1mpqZMuvSE4D5I/9IlyVrSBDhBPeHEItlGAw==
X-Received: by 2002:a25:6884:0:b0:d9a:c450:91a8 with SMTP id d126-20020a256884000000b00d9ac45091a8mr13545627ybc.63.1698871524970;
        Wed, 01 Nov 2023 13:45:24 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:eea0:6f66:c57d:6b7c])
        by smtp.gmail.com with ESMTPSA id o83-20020a25d756000000b00da086d6921fsm342386ybg.50.2023.11.01.13.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 13:45:24 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v9 01/12] bpf: refactory struct_ops type initialization to a function.
Date: Wed,  1 Nov 2023 13:45:08 -0700
Message-Id: <20231101204519.677870-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101204519.677870-1-thinker.li@gmail.com>
References: <20231101204519.677870-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Move the majority of the code to bpf_struct_ops_init_one(), which can then
be utilized for the initialization of newly registered dynamically
allocated struct_ops types in the following patches.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 157 +++++++++++++++++++-----------------
 1 file changed, 83 insertions(+), 74 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index db6176fb64dc..627cf1ea840a 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -110,102 +110,111 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
 
 static const struct btf_type *module_type;
 
-void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
+static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
+				    struct btf *btf,
+				    struct bpf_verifier_log *log)
 {
-	s32 type_id, value_id, module_id;
 	const struct btf_member *member;
-	struct bpf_struct_ops *st_ops;
 	const struct btf_type *t;
+	s32 type_id, value_id;
 	char value_name[128];
 	const char *mname;
-	u32 i, j;
+	int i;
 
-	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
-#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct bpf_struct_ops_##_name);
-#include "bpf_struct_ops_types.h"
-#undef BPF_STRUCT_OPS_TYPE
+	if (strlen(st_ops->name) + VALUE_PREFIX_LEN >=
+	    sizeof(value_name)) {
+		pr_warn("struct_ops name %s is too long\n",
+			st_ops->name);
+		return;
+	}
+	sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
 
-	module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
-	if (module_id < 0) {
-		pr_warn("Cannot find struct module in btf_vmlinux\n");
+	value_id = btf_find_by_name_kind(btf, value_name,
+					 BTF_KIND_STRUCT);
+	if (value_id < 0) {
+		pr_warn("Cannot find struct %s in btf_vmlinux\n",
+			value_name);
 		return;
 	}
-	module_type = btf_type_by_id(btf, module_id);
 
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		st_ops = bpf_struct_ops[i];
+	type_id = btf_find_by_name_kind(btf, st_ops->name,
+					BTF_KIND_STRUCT);
+	if (type_id < 0) {
+		pr_warn("Cannot find struct %s in btf_vmlinux\n",
+			st_ops->name);
+		return;
+	}
+	t = btf_type_by_id(btf, type_id);
+	if (btf_type_vlen(t) > BPF_STRUCT_OPS_MAX_NR_MEMBERS) {
+		pr_warn("Cannot support #%u members in struct %s\n",
+			btf_type_vlen(t), st_ops->name);
+		return;
+	}
 
-		if (strlen(st_ops->name) + VALUE_PREFIX_LEN >=
-		    sizeof(value_name)) {
-			pr_warn("struct_ops name %s is too long\n",
+	for_each_member(i, t, member) {
+		const struct btf_type *func_proto;
+
+		mname = btf_name_by_offset(btf, member->name_off);
+		if (!*mname) {
+			pr_warn("anon member in struct %s is not supported\n",
 				st_ops->name);
-			continue;
+			break;
 		}
-		sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
 
-		value_id = btf_find_by_name_kind(btf, value_name,
-						 BTF_KIND_STRUCT);
-		if (value_id < 0) {
-			pr_warn("Cannot find struct %s in btf_vmlinux\n",
-				value_name);
-			continue;
+		if (__btf_member_bitfield_size(t, member)) {
+			pr_warn("bit field member %s in struct %s is not supported\n",
+				mname, st_ops->name);
+			break;
 		}
 
-		type_id = btf_find_by_name_kind(btf, st_ops->name,
-						BTF_KIND_STRUCT);
-		if (type_id < 0) {
-			pr_warn("Cannot find struct %s in btf_vmlinux\n",
-				st_ops->name);
-			continue;
-		}
-		t = btf_type_by_id(btf, type_id);
-		if (btf_type_vlen(t) > BPF_STRUCT_OPS_MAX_NR_MEMBERS) {
-			pr_warn("Cannot support #%u members in struct %s\n",
-				btf_type_vlen(t), st_ops->name);
-			continue;
+		func_proto = btf_type_resolve_func_ptr(btf,
+						       member->type,
+						       NULL);
+		if (func_proto &&
+		    btf_distill_func_proto(log, btf,
+					   func_proto, mname,
+					   &st_ops->func_models[i])) {
+			pr_warn("Error in parsing func ptr %s in struct %s\n",
+				mname, st_ops->name);
+			break;
 		}
+	}
 
-		for_each_member(j, t, member) {
-			const struct btf_type *func_proto;
+	if (i == btf_type_vlen(t)) {
+		if (st_ops->init(btf)) {
+			pr_warn("Error in init bpf_struct_ops %s\n",
+				st_ops->name);
+		} else {
+			st_ops->type_id = type_id;
+			st_ops->type = t;
+			st_ops->value_id = value_id;
+			st_ops->value_type = btf_type_by_id(btf,
+							    value_id);
+		}
+	}
+}
 
-			mname = btf_name_by_offset(btf, member->name_off);
-			if (!*mname) {
-				pr_warn("anon member in struct %s is not supported\n",
-					st_ops->name);
-				break;
-			}
+void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
+{
+	struct bpf_struct_ops *st_ops;
+	s32 module_id;
+	u32 i;
 
-			if (__btf_member_bitfield_size(t, member)) {
-				pr_warn("bit field member %s in struct %s is not supported\n",
-					mname, st_ops->name);
-				break;
-			}
+	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
+#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct bpf_struct_ops_##_name);
+#include "bpf_struct_ops_types.h"
+#undef BPF_STRUCT_OPS_TYPE
 
-			func_proto = btf_type_resolve_func_ptr(btf,
-							       member->type,
-							       NULL);
-			if (func_proto &&
-			    btf_distill_func_proto(log, btf,
-						   func_proto, mname,
-						   &st_ops->func_models[j])) {
-				pr_warn("Error in parsing func ptr %s in struct %s\n",
-					mname, st_ops->name);
-				break;
-			}
-		}
+	module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
+	if (module_id < 0) {
+		pr_warn("Cannot find struct module in btf_vmlinux\n");
+		return;
+	}
+	module_type = btf_type_by_id(btf, module_id);
 
-		if (j == btf_type_vlen(t)) {
-			if (st_ops->init(btf)) {
-				pr_warn("Error in init bpf_struct_ops %s\n",
-					st_ops->name);
-			} else {
-				st_ops->type_id = type_id;
-				st_ops->type = t;
-				st_ops->value_id = value_id;
-				st_ops->value_type = btf_type_by_id(btf,
-								    value_id);
-			}
-		}
+	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
+		st_ops = bpf_struct_ops[i];
+		bpf_struct_ops_init_one(st_ops, btf, log);
 	}
 }
 
-- 
2.34.1


