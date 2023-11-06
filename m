Return-Path: <bpf+bounces-14322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5F97E2DF4
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 21:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F5828099B
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1F2E62E;
	Mon,  6 Nov 2023 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abzkk/kO"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5EF2E627
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 20:13:16 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82631739
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 12:13:13 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5af5b532d8fso56490977b3.2
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 12:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699301592; x=1699906392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tHRTpLxqGHYbnzxD/bUNB0ypaKDoCjVvSiWbmiPtgI=;
        b=abzkk/kO/RXf8cKpWICa7Knjl4XgE243UsrCmuIPewiFLIFbMHC3wBLuzopsIkDJ9a
         ZFTF3J0aI1Yz2BlOYqXnQGyDMURdC2H9ithyoulKF4Gyq57Jc2KM/nv96wiRVJm4D4xy
         U0BUmWlHcK/EWGcr6gi9UxpnPWRVLlUk9EAf1iQLYn2Q9INrLNORdegH/tYN9aNQAq19
         Z6coH6IA4mlSE+lW0C8u3JHVy7yL66XgicHnpT4rU9pVV+zAP0aV7I8r0xhTuhh1m0z9
         mOMskJKjHrOEpk+yH1RkV6EGm41mWd3AQ2cb1DpRcofMYmioLIgTSoRftcyYMGiMkrr4
         oCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699301592; x=1699906392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tHRTpLxqGHYbnzxD/bUNB0ypaKDoCjVvSiWbmiPtgI=;
        b=j1iHc6eP91LclLyfEdjUQV5osuCgyuCsHlOgjbRRBBiVAsTW+tAaiSZGWA1hSjvg7S
         vzuy6tnK8CPbYOxpIV4QirXwmYvUboJVnZBImnhg+sParM7gdinXFHZtZjNO3dTd6+bi
         Uc84mJxSFRMHZK+QxXQPjOjDAGWCacdbn2+bJ+MSq1l/71hcriFFkd6aCSwRkDqE6bgk
         WBt0txVD0tD6KOyz56Bjmxta2mqlpfhkGYETSVmwXrsjIMJ0k382JYHfFklskBuVVu/k
         qmZ0dvdLagWXJmtvPOChGFfvwR4wVZ0GmJomsBfTiaXCj99GauArf3I79MeB5Zrt/e4x
         wlgg==
X-Gm-Message-State: AOJu0Yw3ATmhLsvzChQ3Jn6SeJGC7ka+NlQbuuO8TScBJSzH5JhEEhdl
	Pkm5sYhxiAv1PpjpveCfsVs1Fh7dR4M=
X-Google-Smtp-Source: AGHT+IFYmkIJFv/DGjplsu8kGAN61mKmMsPfqGaV4gvlbVBT/o8xYHp7DUSucBa5dGXV0ZT+hnJvpg==
X-Received: by 2002:a81:49d3:0:b0:5a7:b973:db3c with SMTP id w202-20020a8149d3000000b005a7b973db3cmr13204772ywa.34.1699301592268;
        Mon, 06 Nov 2023 12:13:12 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:446d:cdea:6fa5:5630])
        by smtp.gmail.com with ESMTPSA id e65-20020a816944000000b0058427045833sm4760611ywc.133.2023.11.06.12.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 12:13:11 -0800 (PST)
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
Subject: [PATCH bpf-next v11 09/13] bpf: validate value_type
Date: Mon,  6 Nov 2023 12:12:48 -0800
Message-Id: <20231106201252.1568931-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106201252.1568931-1-thinker.li@gmail.com>
References: <20231106201252.1568931-1-thinker.li@gmail.com>
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
 include/linux/bpf.h         | 14 ++++++
 kernel/bpf/bpf_struct_ops.c | 93 ++++++++++++++++++++++++-------------
 2 files changed, 74 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c287f42b2e48..48e97a255945 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3231,4 +3231,18 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+#ifdef CONFIG_BPF_JIT
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
+#endif /* CONFIG_BPF_JIT */
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index d1af0ebaf02f..2d853431bf09 100644
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
 
@@ -80,8 +69,8 @@ static DEFINE_MUTEX(update_mutex);
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
@@ -112,11 +101,49 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
 
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
@@ -137,14 +164,6 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	}
 	sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
 
-	value_id = btf_find_by_name_kind(btf, value_name,
-					 BTF_KIND_STRUCT);
-	if (value_id < 0) {
-		pr_warn("Cannot find struct %s in btf_vmlinux\n",
-			value_name);
-		return;
-	}
-
 	type_id = btf_find_by_name_kind(btf, st_ops->name,
 					BTF_KIND_STRUCT);
 	if (type_id < 0) {
@@ -159,6 +178,16 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		return;
 	}
 
+	value_id = btf_find_by_name_kind(btf, value_name,
+					 BTF_KIND_STRUCT);
+	if (value_id < 0) {
+		pr_warn("Cannot find struct %s in btf_vmlinux\n",
+			value_name);
+		return;
+	}
+	if (!is_valid_value_type(btf, value_id, t, value_name))
+		return;
+
 	for_each_member(i, t, member) {
 		const struct btf_type *func_proto;
 
@@ -218,8 +247,6 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 	}
 }
 
-extern struct btf *btf_vmlinux;
-
 static const struct bpf_struct_ops_desc *
 bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
 {
@@ -275,7 +302,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 
 	kvalue = &st_map->kvalue;
 	/* Pair with smp_store_release() during map_update */
-	state = smp_load_acquire(&kvalue->state);
+	state = smp_load_acquire(&kvalue->common.state);
 	if (state == BPF_STRUCT_OPS_STATE_INIT) {
 		memset(value, 0, map->value_size);
 		return 0;
@@ -286,7 +313,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 	 */
 	uvalue = value;
 	memcpy(uvalue, st_map->uvalue, map->value_size);
-	uvalue->state = state;
+	uvalue->common.state = state;
 
 	/* This value offers the user space a general estimate of how
 	 * many sockets are still utilizing this struct_ops for TCP
@@ -294,7 +321,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 	 * should sufficiently meet our present goals.
 	 */
 	refcnt = atomic64_read(&map->refcnt) - atomic64_read(&map->usercnt);
-	refcount_set(&uvalue->refcnt, max_t(s64, refcnt, 0));
+	refcount_set(&uvalue->common.refcnt, max_t(s64, refcnt, 0));
 
 	return 0;
 }
@@ -408,7 +435,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (err)
 		return err;
 
-	if (uvalue->state || refcount_read(&uvalue->refcnt))
+	if (uvalue->common.state || refcount_read(&uvalue->common.refcnt))
 		return -EINVAL;
 
 	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
@@ -420,7 +447,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 
 	mutex_lock(&st_map->lock);
 
-	if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT) {
+	if (kvalue->common.state != BPF_STRUCT_OPS_STATE_INIT) {
 		err = -EBUSY;
 		goto unlock;
 	}
@@ -542,7 +569,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		 *
 		 * Pair with smp_load_acquire() during lookup_elem().
 		 */
-		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_READY);
+		smp_store_release(&kvalue->common.state, BPF_STRUCT_OPS_STATE_READY);
 		goto unlock;
 	}
 
@@ -560,7 +587,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		 * It ensures the above udata updates (e.g. prog->aux->id)
 		 * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
 		 */
-		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);
+		smp_store_release(&kvalue->common.state, BPF_STRUCT_OPS_STATE_INUSE);
 		/* Hold the owner module until the struct_ops is
 		 * unregistered
 		 */
@@ -596,7 +623,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 	if (st_map->map.map_flags & BPF_F_LINK)
 		return -EOPNOTSUPP;
 
-	prev_state = cmpxchg(&st_map->kvalue.state,
+	prev_state = cmpxchg(&st_map->kvalue.common.state,
 			     BPF_STRUCT_OPS_STATE_INUSE,
 			     BPF_STRUCT_OPS_STATE_TOBEFREE);
 	switch (prev_state) {
@@ -847,7 +874,7 @@ static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 	return map->map_type == BPF_MAP_TYPE_STRUCT_OPS &&
 		map->map_flags & BPF_F_LINK &&
 		/* Pair with smp_store_release() during map_update */
-		smp_load_acquire(&st_map->kvalue.state) == BPF_STRUCT_OPS_STATE_READY;
+		smp_load_acquire(&st_map->kvalue.common.state) == BPF_STRUCT_OPS_STATE_READY;
 }
 
 static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
-- 
2.34.1


