Return-Path: <bpf+bounces-18114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3158B815E02
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 09:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4FD2B21174
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D3D1C27;
	Sun, 17 Dec 2023 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDNzRxQ/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCD2582
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-77f552d4179so160703585a.1
        for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 00:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702800702; x=1703405502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwVf1U8g+MZbSnaa5yo6OgDz5D8Mxi41B3XdvtQjXiU=;
        b=UDNzRxQ/JMe+QYDi0kkl0Wpx7btG/7/9FMkfYGh2VSiW5aMtcvGSQVeAjJgerRITvI
         47eoVHGNDXCvss71wRJAmo7VBWr1oglZ3ytGbPSXNsJkd2GxuzGyUobUAxACAbzyXjN9
         bUzzi4iJ9Rf/OyLtedosF4+tMFrHmrATb9otZwl/qYTm+ZSzNkaterj0r2pa5UT7Psz9
         MBx1Oc/PspiGkt3AqPyar9TCP56F4eDbS9GuT/LbhMT+SnEhje+542n7aBh0KuEhK8QU
         6/dReATdcSMY/oLjLzv9dOSXSUXJPaE0K8AVkXFtwbLplVp/wQRDrNvXRzro1pdvinRE
         oFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800702; x=1703405502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwVf1U8g+MZbSnaa5yo6OgDz5D8Mxi41B3XdvtQjXiU=;
        b=qlDNAHgGm1yYhqwkVre4PQ3o++HT19XW6lYF4JKgTd9aDct4HJSTRykxbgcfodNjBy
         N4DDhEEfuWBXjp6FQsGmlYTwnsTMvuN+g+oEE0fkY3I3taSg33T0SRmCN3eX4NySMJ2T
         lsCdqxYI0WsoNcbJpzq2lWOF7bC6sy5cCaXZWzF/ZSfM/fx39hm8Si9oVSNNnYMKQVGO
         5DybNagNiSVbKkmPqXDjtljKZ4QnVUIjzYCdFhUZpQUWuMuYCWAnQbLQu729Uw89lHVL
         NUiKzt63yfzWCKGAgCxglZOjiXJgxsU/Q6aHXo2aL7knSIKHjpuj5l9u2biVU+yE0XA2
         9xlQ==
X-Gm-Message-State: AOJu0Yxa1p8sy3wKHBTrhtLkoJGoTb6NXRRqW88gTwdKFWCky0JumZP7
	WtKTEM1uTZ6tzKPX5v99HmrwP8oSfUU=
X-Google-Smtp-Source: AGHT+IH7Ub0/EwrmcJsH7MaA9Ooc5lLuq7KCE6ptqflHtoe/yrlaqVPF366RwX6ALyRI+izvLcw8Fg==
X-Received: by 2002:a05:620a:7f6:b0:780:db24:3c83 with SMTP id k22-20020a05620a07f600b00780db243c83mr1569769qkk.37.1702800701941;
        Sun, 17 Dec 2023 00:11:41 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf])
        by smtp.gmail.com with ESMTPSA id c85-20020a814e58000000b005e303826838sm3399415ywb.56.2023.12.17.00.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 00:11:41 -0800 (PST)
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
Subject: [PATCH bpf-next v14 01/14] bpf: refactory struct_ops type initialization to a function.
Date: Sun, 17 Dec 2023 00:11:18 -0800
Message-Id: <20231217081132.1025020-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217081132.1025020-1-thinker.li@gmail.com>
References: <20231217081132.1025020-1-thinker.li@gmail.com>
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
 include/linux/btf.h         |   1 +
 kernel/bpf/bpf_struct_ops.c | 157 +++++++++++++++++++-----------------
 kernel/bpf/btf.c            |   5 ++
 3 files changed, 89 insertions(+), 74 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 59d404e22814..1d852dad7473 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -137,6 +137,7 @@ struct btf_struct_metas {
 
 extern const struct file_operations btf_fops;
 
+const char *btf_get_name(const struct btf *btf);
 void btf_get(struct btf *btf);
 void btf_put(struct btf *btf);
 int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_sz);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 4d53c53fc5aa..5714e7e54f9c 100644
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
+		pr_warn("Cannot find struct %s in %s\n",
+			value_name, btf_get_name(btf));
 		return;
 	}
-	module_type = btf_type_by_id(btf, module_id);
 
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		st_ops = bpf_struct_ops[i];
+	type_id = btf_find_by_name_kind(btf, st_ops->name,
+					BTF_KIND_STRUCT);
+	if (type_id < 0) {
+		pr_warn("Cannot find struct %s in %s\n",
+			st_ops->name, btf_get_name(btf));
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
+		pr_warn("Cannot find struct module in %s\n", btf_get_name(btf));
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
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d56433bf8aba..46bf3a6f4bb0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1707,6 +1707,11 @@ static void btf_free_rcu(struct rcu_head *rcu)
 	btf_free(btf);
 }
 
+const char *btf_get_name(const struct btf *btf)
+{
+	return btf->name;
+}
+
 void btf_get(struct btf *btf)
 {
 	refcount_inc(&btf->refcnt);
-- 
2.34.1


