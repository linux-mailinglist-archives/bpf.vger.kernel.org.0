Return-Path: <bpf+bounces-9862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF6379DFCA
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 08:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505DA1C20ADB
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 06:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B2B15AC6;
	Wed, 13 Sep 2023 06:15:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D71A45
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 06:15:09 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BE4172E
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:08 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59b4ec8d9c1so56745637b3.0
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694585707; x=1695190507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1LKzJ6YZFzFyC4YtfRyRU3+GJp/YWkGmDQRoXVoGGM=;
        b=kvi0ZHU0UBAVuuFrG7C3Y9EeqA2uf2+UuFcWkWtXDfxXKua+zx0hE0cgS9PNeaL1/g
         9B1xSkKB/PN1dQQWX3GwX/SBVmwQRMaf20ojz1XaNwMRQyW3JnGETr7Teu2VizEYMKHW
         hJF2EkiDjXLBNs4yivwbXi6ByL+utAosfzKTiHRVTTUpmW4h+gINBTserOFXMFjXfmEE
         tR/k48eiVh1LsJ5P1MsR7nmfvu4RHPJuUDprnOD6QcaMuWz/3zFhwcgxd32baSvMde8V
         Rm5Z4Oyn9E/OjvVg7OeK/hmHgjpBw1H8IWqhPJTvyLcEtcXR7x8yDVbyx1SYp/pypB04
         bwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694585707; x=1695190507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1LKzJ6YZFzFyC4YtfRyRU3+GJp/YWkGmDQRoXVoGGM=;
        b=s7aYexIxaxxjLeuRIfkZHrpVYDLHndzM1mmY43LenxOLurUZzKA6gYULMBNw6PZIzZ
         DtJ7/b4T18QErtnk/tMtkkjlPtyHJBag8p41oIYQxk7TVZii/cUXlyEVK5hB20Cxz/11
         zjijLFp+Guu2CIP4BDOB+tHWVOlv7/9AlfSZnqWNaJ9S0cKWA8YR1nEPOlw193GW9hJT
         Ske+UuG4R16kP8sD1jofU0viPj56qZddFSLbBZh4mT8t65Gddfa3h5ijYnDSMHsTzy2R
         3lCHuRITF9ZKX29I91BnV7lkbNgg8mZDwc6xa3s4nWR6kdsMdcOvgSuyokl6N73ieW8G
         Ngow==
X-Gm-Message-State: AOJu0YxUb56S5Ja3bSpMtagJQ2/GXvt/1ElFKL1GAYlZ11AQmLUEdWpw
	z5gRFREEOctRE1c6nP8DpESdYHAbkEY=
X-Google-Smtp-Source: AGHT+IFP79V0KcagCozfgefAVMJBlS+00bspCxOWmVgwM7ZK5yhu7jgnJ21Ot8k6VL6RVqHOUV17jQ==
X-Received: by 2002:a81:b051:0:b0:59b:c805:de60 with SMTP id x17-20020a81b051000000b0059bc805de60mr810245ywk.45.1694585707169;
        Tue, 12 Sep 2023 23:15:07 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34c0:240e:9597:d8ed])
        by smtp.gmail.com with ESMTPSA id b132-20020a0dd98a000000b0057a5302e2fesm2961454ywe.5.2023.09.12.23.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 23:15:06 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v2 1/9] bpf: refactory struct_ops type initialization to a function.
Date: Tue, 12 Sep 2023 23:14:41 -0700
Message-Id: <20230913061449.1918219-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913061449.1918219-1-thinker.li@gmail.com>
References: <20230913061449.1918219-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Move most of code to bpf_struct_ops_init_one() that can be use to
initialize new struct_ops types registered dynamically.
---
 kernel/bpf/bpf_struct_ops.c | 157 +++++++++++++++++++-----------------
 1 file changed, 83 insertions(+), 74 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index fdc3e8705a3c..1662875e0ebe 100644
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


