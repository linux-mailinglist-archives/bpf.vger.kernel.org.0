Return-Path: <bpf+bounces-17279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC7880B0F3
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 758EAB20C5C
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A337264D;
	Sat,  9 Dec 2023 00:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2mbwRUK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49E2171F
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 16:27:14 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5d3758fdd2eso26366557b3.0
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 16:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702081633; x=1702686433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btc/MsJLI+X/urxNiZXzC+8XMLmtUZ3lzSYU9f3riGI=;
        b=M2mbwRUKZ407U6fHbUZStlVwdjwtQUfTHVQ++kK/L/2JjffaWy9dc5NG05IBkVLwHV
         B/mf8l/956rSQmVRVJHfYlqvIbZCZJtMPxtkV9JXOmHy65CCU+EMNe23EKv9tZUKmo4e
         XdEmifalfLQbFzCqKzFKAtq1C+onf2nqItTR1VntmZTMfeAbYgmjYnonsSjX0E8WxwWe
         OI+2kJRWXoVvxE3LpSVOiRSxmfaNgSwtndz3BqOznBG+szkAWypTHU0xSjH7LXIGaZHP
         y5bkBfUhP0QoHikl7KZfJLE6RjlqRM5/Rd6giW3/nkESTOc6vFksl0CL88lctUNTkJ7Y
         ucXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081633; x=1702686433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btc/MsJLI+X/urxNiZXzC+8XMLmtUZ3lzSYU9f3riGI=;
        b=ij5FD3hC9QY7A/iwLL73gJkiu4Ip8pa7M3jvkK8FEByy05IjFkItnlPEw0GBSoIJSV
         g0arDa5jrNqz7I5nAhNbw3VCmSzEWjkDq2dheOuirh1rNy1I0otlZZHhePhYymNa71AP
         9GVA16rfFiaDV9a8vRA3vZ1Yd4VKgr2oOWDz6tqdhQ+ocwQ+jkhmXCpHUkD6l/Qrk9id
         jfP1ipCnvczo64oJ+FvxzqiWYxlnBcLFAFo5GXvNg1RVrUkzCQgGrPhMo4731Q4FwRmb
         AtMgol4OWr/me5L6HBdRkqIJ+54+T3v+8dOICOWSnJ82fp/oWN5iFtYqRdR79Y++XYBI
         128A==
X-Gm-Message-State: AOJu0YzBXJGrBCZBtC9fxED1geKh2x+uvocT2RU6xWXb/HVygdg5qymX
	gdsv0ugGoPhfzkUPncMzd3+f/Y71lcoYIg==
X-Google-Smtp-Source: AGHT+IGc0a7Wkd4pukicHFGI/ymJHCHYp1fm9KN4GG7Ej2qm2Xs4F9ZR5hzoInhJ+74+Vjx+aNh4JA==
X-Received: by 2002:a0d:dd94:0:b0:5d7:1941:356a with SMTP id g142-20020a0ddd94000000b005d71941356amr756042ywe.81.1702081633635;
        Fri, 08 Dec 2023 16:27:13 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm1057450ywf.42.2023.12.08.16.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 16:27:13 -0800 (PST)
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
Subject: [PATCH bpf-next v13 01/14] bpf: refactory struct_ops type initialization to a function.
Date: Fri,  8 Dec 2023 16:26:56 -0800
Message-Id: <20231209002709.535966-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209002709.535966-1-thinker.li@gmail.com>
References: <20231209002709.535966-1-thinker.li@gmail.com>
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
index 63cf4128fc05..6935a88ed190 100644
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


