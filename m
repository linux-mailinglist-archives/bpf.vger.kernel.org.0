Return-Path: <bpf+bounces-19783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B00831113
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56BB2878AD
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB968F74;
	Thu, 18 Jan 2024 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buTdl2xH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0528F63
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542604; cv=none; b=T46AQgMrWE+Fyao6OvOPpAKy2LhB1oM/b7zsj2rDTCJi3ncU+K7R9FEtKsraQ9ryKPHkuFrO6fnqOjyoOqifLKncemu1zARhgSLrGalUoCNKRdb25pXP5AdIkQp76lF+NTzfsYvrFJGZNwSdg2ns3yJ0IhXnqs2trV2TxItplI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542604; c=relaxed/simple;
	bh=YkXgjQhs99cvbtD+yNvzYQVEedtPu49AtL14kMNPrr8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=EvRHIzyxUcuLjpPG3VnIiXvvOG8bkQjOVUA2Ud2ye/Sr2+Z26/A3NM2l1v+1IHeBtbkUS0237Jg7fJGmjTGg5LPN4XI/Q6CkuXzP6F0Jc7giNlUMxmT4RDy2C6kJPEChxUrKm2MHIbQAChyghEnE44Ti+mjPSjGn9Jy6+qQfehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buTdl2xH; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ff45c65e60so27821027b3.0
        for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 17:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542601; x=1706147401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWE4VyuLc5E19tVmnfM5joUqQyzcZVY0l3eaNkNzmcY=;
        b=buTdl2xHqYzTS5WOdgf2XJ+Rk7F7MYkt13jkhLE0qgKSWOgz+HHVZG22l6MK5TRc4c
         d8U0ciUHyHeXzgyaqwH5czSqKn8JZgWBvE2MGnGsjRk/wj+cxVMgVC9cuA0llIRVYFFf
         0QvMckWxEO5binB2sCyE2xEuiiKX8YA/+8Jwcs2t9xa6xbgRXNikX32XDe62BFBXAMNh
         tjRi90YQoYB6hjgHnv1QAsv+xkE0ra/AWuebNRhsp0DY8wvogqD5ssJF7Vyx3IKGVzCs
         AR5RXsTIzSLTSeEQQW6CyDoVw8lAxd9wJY2EJu/Q6g7LokZSscXO3hE5mc3iavusQ3Ic
         aTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542601; x=1706147401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWE4VyuLc5E19tVmnfM5joUqQyzcZVY0l3eaNkNzmcY=;
        b=F8n5l1ezJVf5FRq7IAi6hkE5wB+RsbIwgSr7hICxjkjlFxJu1qRB6bv2q2xTaY/5sC
         BQEb0XNqhNfKuAf0/O6bzVTepsRD9/lTgTvBeurn7ajDOSU+7npRU5Wc0nHbVAYuD3Zb
         FZB0jXrYkIvPnghu1BtqgFHI0kHsmrt42mTW7rF9GbGfUxpZR0kBYVZ4spX4k7CH6FOm
         1b5kBmpblY1yeDByTLY4bfYmDAl/rny16/+LmRxzRNiFLE9pMihn8Xdg7WBkkX09XHXQ
         ZIve/Lx4emwVyhHwZNULwPGCpePP6kTrcUUHaesBl980hmYuMXV/QviikdyP4w6JzXwF
         Qcmw==
X-Gm-Message-State: AOJu0YyAM1ylk1zm0yZTpEJIAftbsV+2s9deOtVbyxDhR7x5MuZY2BrT
	Jn9S3zADdKS9413HAA2+wquj8PBQkEvf+Wqo1+EUBlNL69AAk4KipYFE8ieG
X-Google-Smtp-Source: AGHT+IH4zGlG7TwVkWuzvDmIC27HfD+hYUcA2iUYtIuImeA/QhiJtHX/UmRt+D9TSoTmTuApp976Aw==
X-Received: by 2002:a0d:e644:0:b0:5f8:420e:468b with SMTP id p65-20020a0de644000000b005f8420e468bmr89685ywe.45.1705542601186;
        Wed, 17 Jan 2024 17:50:01 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b90:cd6a:b588:8d99])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05690c090900b005e5fff5c537sm6248606ywb.85.2024.01.17.17.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:50:00 -0800 (PST)
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
Subject: [PATCH bpf-next v16 10/14] bpf: validate value_type
Date: Wed, 17 Jan 2024 17:49:26 -0800
Message-Id: <20240118014930.1992551-11-thinker.li@gmail.com>
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

A value_type should consist of three components: refcnt, state, and data.
refcnt and state has been move to struct bpf_struct_ops_common_value to
make it easier to check the value type.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         | 12 +++++
 kernel/bpf/bpf_struct_ops.c | 93 ++++++++++++++++++++++++-------------
 2 files changed, 72 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a977ed75288c..1cfbb89944c5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1688,6 +1688,18 @@ struct bpf_struct_ops_desc {
 	u32 value_id;
 };
 
+enum bpf_struct_ops_state {
+	BPF_STRUCT_OPS_STATE_INIT,
+	BPF_STRUCT_OPS_STATE_INUSE,
+	BPF_STRUCT_OPS_STATE_TOBEFREE,
+	BPF_STRUCT_OPS_STATE_READY,
+};
+
+struct bpf_struct_ops_common_value {
+	refcount_t refcnt;
+	enum bpf_struct_ops_state state;
+};
+
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
 const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 61486f6595ea..f5763f240722 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -13,19 +13,8 @@
 #include <linux/btf_ids.h>
 #include <linux/rcupdate_wait.h>
 
-enum bpf_struct_ops_state {
-	BPF_STRUCT_OPS_STATE_INIT,
-	BPF_STRUCT_OPS_STATE_INUSE,
-	BPF_STRUCT_OPS_STATE_TOBEFREE,
-	BPF_STRUCT_OPS_STATE_READY,
-};
-
-#define BPF_STRUCT_OPS_COMMON_VALUE			\
-	refcount_t refcnt;				\
-	enum bpf_struct_ops_state state
-
 struct bpf_struct_ops_value {
-	BPF_STRUCT_OPS_COMMON_VALUE;
+	struct bpf_struct_ops_common_value common;
 	char data[] ____cacheline_aligned_in_smp;
 };
 
@@ -81,8 +70,8 @@ static DEFINE_MUTEX(update_mutex);
 #define BPF_STRUCT_OPS_TYPE(_name)				\
 extern struct bpf_struct_ops bpf_##_name;			\
 								\
-struct bpf_struct_ops_##_name {						\
-	BPF_STRUCT_OPS_COMMON_VALUE;				\
+struct bpf_struct_ops_##_name {					\
+	struct bpf_struct_ops_common_value common;		\
 	struct _name data ____cacheline_aligned_in_smp;		\
 };
 #include "bpf_struct_ops_types.h"
@@ -113,11 +102,49 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
 
 BTF_ID_LIST(st_ops_ids)
 BTF_ID(struct, module)
+BTF_ID(struct, bpf_struct_ops_common_value)
 
 enum {
 	IDX_MODULE_ID,
+	IDX_ST_OPS_COMMON_VALUE_ID,
 };
 
+extern struct btf *btf_vmlinux;
+
+static bool is_valid_value_type(struct btf *btf, s32 value_id,
+				const struct btf_type *type,
+				const char *value_name)
+{
+	const struct btf_type *common_value_type;
+	const struct btf_member *member;
+	const struct btf_type *vt, *mt;
+
+	vt = btf_type_by_id(btf, value_id);
+	if (btf_vlen(vt) != 2) {
+		pr_warn("The number of %s's members should be 2, but we get %d\n",
+			value_name, btf_vlen(vt));
+		return false;
+	}
+	member = btf_type_member(vt);
+	mt = btf_type_by_id(btf, member->type);
+	common_value_type = btf_type_by_id(btf_vmlinux,
+					   st_ops_ids[IDX_ST_OPS_COMMON_VALUE_ID]);
+	if (mt != common_value_type) {
+		pr_warn("The first member of %s should be bpf_struct_ops_common_value\n",
+			value_name);
+		return false;
+	}
+	member++;
+	mt = btf_type_by_id(btf, member->type);
+	if (mt != type) {
+		pr_warn("The second member of %s should be %s\n",
+			value_name, btf_name_by_offset(btf, type->name_off));
+		return false;
+	}
+
+	return true;
+}
+
 static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 				     struct btf *btf,
 				     struct bpf_verifier_log *log)
@@ -138,14 +165,6 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	}
 	sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
 
-	value_id = btf_find_by_name_kind(btf, value_name,
-					 BTF_KIND_STRUCT);
-	if (value_id < 0) {
-		pr_warn("Cannot find struct %s in %s\n",
-			value_name, btf_get_name(btf));
-		return;
-	}
-
 	type_id = btf_find_by_name_kind(btf, st_ops->name,
 					BTF_KIND_STRUCT);
 	if (type_id < 0) {
@@ -160,6 +179,16 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		return;
 	}
 
+	value_id = btf_find_by_name_kind(btf, value_name,
+					 BTF_KIND_STRUCT);
+	if (value_id < 0) {
+		pr_warn("Cannot find struct %s in %s\n",
+			value_name, btf_get_name(btf));
+		return;
+	}
+	if (!is_valid_value_type(btf, value_id, t, value_name))
+		return;
+
 	for_each_member(i, t, member) {
 		const struct btf_type *func_proto;
 
@@ -219,8 +248,6 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 	}
 }
 
-extern struct btf *btf_vmlinux;
-
 static const struct bpf_struct_ops_desc *
 bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
 {
@@ -276,7 +303,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 
 	kvalue = &st_map->kvalue;
 	/* Pair with smp_store_release() during map_update */
-	state = smp_load_acquire(&kvalue->state);
+	state = smp_load_acquire(&kvalue->common.state);
 	if (state == BPF_STRUCT_OPS_STATE_INIT) {
 		memset(value, 0, map->value_size);
 		return 0;
@@ -287,7 +314,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 	 */
 	uvalue = value;
 	memcpy(uvalue, st_map->uvalue, map->value_size);
-	uvalue->state = state;
+	uvalue->common.state = state;
 
 	/* This value offers the user space a general estimate of how
 	 * many sockets are still utilizing this struct_ops for TCP
@@ -295,7 +322,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 	 * should sufficiently meet our present goals.
 	 */
 	refcnt = atomic64_read(&map->refcnt) - atomic64_read(&map->usercnt);
-	refcount_set(&uvalue->refcnt, max_t(s64, refcnt, 0));
+	refcount_set(&uvalue->common.refcnt, max_t(s64, refcnt, 0));
 
 	return 0;
 }
@@ -413,7 +440,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (err)
 		return err;
 
-	if (uvalue->state || refcount_read(&uvalue->refcnt))
+	if (uvalue->common.state || refcount_read(&uvalue->common.refcnt))
 		return -EINVAL;
 
 	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
@@ -425,7 +452,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 
 	mutex_lock(&st_map->lock);
 
-	if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT) {
+	if (kvalue->common.state != BPF_STRUCT_OPS_STATE_INIT) {
 		err = -EBUSY;
 		goto unlock;
 	}
@@ -540,7 +567,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		 *
 		 * Pair with smp_load_acquire() during lookup_elem().
 		 */
-		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_READY);
+		smp_store_release(&kvalue->common.state, BPF_STRUCT_OPS_STATE_READY);
 		goto unlock;
 	}
 
@@ -558,7 +585,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		 * It ensures the above udata updates (e.g. prog->aux->id)
 		 * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
 		 */
-		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);
+		smp_store_release(&kvalue->common.state, BPF_STRUCT_OPS_STATE_INUSE);
 		goto unlock;
 	}
 
@@ -588,7 +615,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 	if (st_map->map.map_flags & BPF_F_LINK)
 		return -EOPNOTSUPP;
 
-	prev_state = cmpxchg(&st_map->kvalue.state,
+	prev_state = cmpxchg(&st_map->kvalue.common.state,
 			     BPF_STRUCT_OPS_STATE_INUSE,
 			     BPF_STRUCT_OPS_STATE_TOBEFREE);
 	switch (prev_state) {
@@ -850,7 +877,7 @@ static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 	return map->map_type == BPF_MAP_TYPE_STRUCT_OPS &&
 		map->map_flags & BPF_F_LINK &&
 		/* Pair with smp_store_release() during map_update */
-		smp_load_acquire(&st_map->kvalue.state) == BPF_STRUCT_OPS_STATE_READY;
+		smp_load_acquire(&st_map->kvalue.common.state) == BPF_STRUCT_OPS_STATE_READY;
 }
 
 static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
-- 
2.34.1


