Return-Path: <bpf+bounces-19774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70A831106
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8BDB227B6
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DAF28F1;
	Thu, 18 Jan 2024 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKoup1F+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625741C06
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542590; cv=none; b=Bxl4rpThUnlWNCfYd0nyQdrRTnAX0yH8j/Hs1du+qAxy0MiwrUIXKQ+oXNGw9toblspCcMhI+w9I2pnUrn+6GEs87YjsaoJnBCmgkSHar9AO3gXySc5jhfJw49anTmxZ7w5e6Kn5IcQek10Bnt4CBs2VlTHJIpwsJIH5g7PsBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542590; c=relaxed/simple;
	bh=WhyulcBtGgmzeiUjv5gl+rwywGAD/2U+TEUq6nyaCwk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=V6hjWjLMObr/e1PfE1oW7uEkP91mTx/bHGzDfrv/K+TAgmL5vL+jDctysEfuGFbaXSW62PcxvkjvmjsKgmuNJzZ1H2TxnCTXJy3CEqgxEGJZIvpqCuKwVEErmezX11K5aNLgMhaSO6XlFSNSeJia/m2726+JSsZwLQvSPED8AOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKoup1F+; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5fc2e997804so53564767b3.3
        for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 17:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542588; x=1706147388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM52mOpOXRsJ8K9AGybBKYuwruVPoyAuVHFy5zVCFqU=;
        b=CKoup1F+G0JEHJ9LArpCdt/BwKBjtoMOvUyCLbCLZLNq85qVXW4XYKbnxtV8h1U6C1
         ZYXpnW1SG+Xp5OHnkeWj9qE9QnhKFg9zYBwcnmmbNID4pwNY/kloLdxsSXMMWqzL97dT
         4s1w1xwVxyYQa72uc5Si1Z75b31qOklGddDyR1x6lmnltkSaW3wyuVIlY0/JYteGmNn5
         WVcz63/m0ERU6NRE+9nnKRJgersXCT8QCWnbW/aDoF17WrpLOZWBnzv+ou6tMcEr85Go
         1nk1eG4E8GpAdqGvTv2mKX7MdJ+tcE+iochZGqK7RLQuyKtta0Sw+Tg3a+wqb0Whywvi
         HOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542588; x=1706147388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rM52mOpOXRsJ8K9AGybBKYuwruVPoyAuVHFy5zVCFqU=;
        b=uIOTJW2b6va+M2ZhtyvO+ZykDcJFcSZAzBpKfcDzMFMFornxML7k0f8oEax+BYriAy
         Dbu0QDTm0mJhQtzmstdC1xx0qqkOtVC+TL+SUuwEs5e/IEqO/ZWDVbQOXP3OwhUn8R3a
         oSgAQBIbdtbUxRQhV6cf0mkV4aJxJeoEoOGEiPkyzWS+ihKR6RThzLKp3hJqktoMa6Pw
         7cR5dbx5NldjLeyqEovLuwHLJE+jii5rIwqm7+jwKz+XYxgyw4HTL5po5uS0Hk2p99mL
         10vh6fnG9w/rPJSF6MrKyuO85Qr6T0Hn86AY3GrmrlhKWfLgnsgsM34bHH4WkAIAFOuL
         yMOA==
X-Gm-Message-State: AOJu0YwqX/Jt0KApUFLVv0Vs8U4eLh7EzV/IzHScnG7Eu9mtRVi/Mzkh
	57wwR6teORySUVW42Hyb3Ox6Ujm7RWYRwLizO2DTNjCq2IUyfblQJxTFzv4G
X-Google-Smtp-Source: AGHT+IExp5niQYIq0V4ae7gBN7Nnr/a301URgRKO4bZrrxq+toQ6tCCNv0idC0YQ2QFB7JC9Xr2OtA==
X-Received: by 2002:a81:4746:0:b0:5fa:c41d:dc1c with SMTP id u67-20020a814746000000b005fac41ddc1cmr125459ywa.50.1705542587906;
        Wed, 17 Jan 2024 17:49:47 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b90:cd6a:b588:8d99])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05690c090900b005e5fff5c537sm6248606ywb.85.2024.01.17.17.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:49:46 -0800 (PST)
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
Subject: [PATCH bpf-next v16 01/14] bpf: refactory struct_ops type initialization to a function.
Date: Wed, 17 Jan 2024 17:49:17 -0800
Message-Id: <20240118014930.1992551-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118014930.1992551-1-thinker.li@gmail.com>
References: <20240118014930.1992551-1-thinker.li@gmail.com>
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
index 02068bd0e4d9..96cba76f4ac3 100644
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
index 51e8b4bee0c8..1f94c250ab49 100644
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


