Return-Path: <bpf+bounces-13503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D1A7DA242
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97978282563
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E843FB26;
	Fri, 27 Oct 2023 21:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9HWXNQo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B233FE25
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 21:17:19 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D721B4
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:17:17 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a877e0f0d8so31864477b3.1
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698441436; x=1699046236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtQSZS91O/ZfohhpIVNb26hgw+iTTPVxW1DcYX3R1Fs=;
        b=P9HWXNQoDJCgHNAxaKR3hIA9tOOxikzmNWUzGu9nyo2FkqRudA6/gIDB5jtoPVG7zx
         2pTuQJkYRIky3JQc1VPigfHDD6KX7RLiTFSUHGELHxYn0DVe/SsASxySTWIw4DMCGseQ
         pLgwEd5m1wIGxg2VibDZeGQqI+y0lLuwLw1uupTM0iFuOreKBFUZ5smxBhFnAIeWk5I6
         vFA50kogynfGUoP4gxvrtNjADmkG1SMtcMFDiC8nWUhLssX8IRbxBx42v5iVHMG7Voui
         RD2brvbnPRGnxg2U0Aama9RMkWV4m3O/FlDUOH9Eqw54HX5DPt+hukQMwGoBtLlhvif6
         amCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698441436; x=1699046236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtQSZS91O/ZfohhpIVNb26hgw+iTTPVxW1DcYX3R1Fs=;
        b=FMM6pv/WL/ar1WoGE0Kl7xLd4wk3mhg7XbLtsnEpu613rQkMEC7bMjMNzrUOJlvkNE
         ok8mI6i346BoGrO6tArJPJ5SWzJfx0E+U9RfmyTS3wP905o1vjCMPqBGaWreGRljm2hE
         NTywCVCrdZ3qznLe7VSUDTOmPDNhQHSKjIsR/YVvcOWKvEpI/ot2YXyQ3wOUsvXKXZKa
         DcZKI77YutteH0D6zNfhMocRcZlMLVWnUzyb5ZHglTVPFigVe0CLDlJ2bW/IxYyPR8ey
         kGeTONqUOw3InroYOZvCF/vFAJ8F7ToaJsF3RoWS8N33Fg9BrrhzcB/pQhhgpaSpK5ZP
         NJwQ==
X-Gm-Message-State: AOJu0YxQAQ3Xr5wNmw/aEgPbRH1BZWUhckZHLl65qLWaGISE+MP6TLqG
	tXxmSaoevpJzuK/kfKEuArGSvCMsmXI=
X-Google-Smtp-Source: AGHT+IEAErlGRSSXgHqCYiARhoz1CoV7fWM6+6og4BPi9WH5xbrYKNn/4a81X0kL9WVFw2krKuBrSA==
X-Received: by 2002:a81:cb0b:0:b0:5a5:575:e944 with SMTP id q11-20020a81cb0b000000b005a50575e944mr11900959ywi.4.1698441436185;
        Fri, 27 Oct 2023 14:17:16 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:41cd:a94b:292d:cd8])
        by smtp.gmail.com with ESMTPSA id e133-20020a81698b000000b0059a34cfa2a5sm1080174ywc.67.2023.10.27.14.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 14:17:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 05/10] bpf: validate value_type
Date: Fri, 27 Oct 2023 14:16:57 -0700
Message-Id: <20231027211702.1374597-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027211702.1374597-1-thinker.li@gmail.com>
References: <20231027211702.1374597-1-thinker.li@gmail.com>
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
 kernel/bpf/bpf_struct_ops.c | 86 ++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index b0b8cf9ed057..256516aba632 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -20,9 +20,11 @@ enum bpf_struct_ops_state {
 	BPF_STRUCT_OPS_STATE_READY,
 };
 
-#define BPF_STRUCT_OPS_COMMON_VALUE			\
-	refcount_t refcnt;				\
-	enum bpf_struct_ops_state state
+struct bpf_struct_ops_common_value {
+	refcount_t refcnt;
+	enum bpf_struct_ops_state state;
+};
+#define BPF_STRUCT_OPS_COMMON_VALUE struct bpf_struct_ops_common_value common
 
 struct bpf_struct_ops_value {
 	BPF_STRUCT_OPS_COMMON_VALUE;
@@ -109,6 +111,38 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
 };
 
 static const struct btf_type *module_type;
+static const struct btf_type *common_value_type;
+
+static bool is_valid_value_type(struct btf *btf, s32 value_id,
+				const struct btf_type *type,
+				const char *value_name)
+{
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
 
 static void bpf_struct_ops_init_one(struct bpf_struct_ops_desc *st_ops_desc,
 				    struct btf *btf,
@@ -130,14 +164,6 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops_desc *st_ops_desc,
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
@@ -152,6 +178,16 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops_desc *st_ops_desc,
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
 
@@ -199,7 +235,7 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops_desc *st_ops_desc,
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 {
 	struct bpf_struct_ops_desc *st_ops_desc;
-	s32 module_id;
+	s32 module_id, common_value_id;
 	u32 i;
 
 	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
@@ -213,6 +249,14 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 		return;
 	}
 	module_type = btf_type_by_id(btf, module_id);
+	common_value_id = btf_find_by_name_kind(btf,
+						"bpf_struct_ops_common_value",
+						BTF_KIND_STRUCT);
+	if (common_value_id < 0) {
+		pr_warn("Cannot find struct common_value in btf_vmlinux\n");
+		return;
+	}
+	common_value_type = btf_type_by_id(btf, common_value_id);
 
 	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
 		st_ops_desc = &bpf_struct_ops[i];
@@ -277,7 +321,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 
 	kvalue = &st_map->kvalue;
 	/* Pair with smp_store_release() during map_update */
-	state = smp_load_acquire(&kvalue->state);
+	state = smp_load_acquire(&kvalue->common.state);
 	if (state == BPF_STRUCT_OPS_STATE_INIT) {
 		memset(value, 0, map->value_size);
 		return 0;
@@ -288,7 +332,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 	 */
 	uvalue = value;
 	memcpy(uvalue, st_map->uvalue, map->value_size);
-	uvalue->state = state;
+	uvalue->common.state = state;
 
 	/* This value offers the user space a general estimate of how
 	 * many sockets are still utilizing this struct_ops for TCP
@@ -296,7 +340,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 	 * should sufficiently meet our present goals.
 	 */
 	refcnt = atomic64_read(&map->refcnt) - atomic64_read(&map->usercnt);
-	refcount_set(&uvalue->refcnt, max_t(s64, refcnt, 0));
+	refcount_set(&uvalue->common.refcnt, max_t(s64, refcnt, 0));
 
 	return 0;
 }
@@ -409,7 +453,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (err)
 		return err;
 
-	if (uvalue->state || refcount_read(&uvalue->refcnt))
+	if (uvalue->common.state || refcount_read(&uvalue->common.refcnt))
 		return -EINVAL;
 
 	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
@@ -421,7 +465,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 
 	mutex_lock(&st_map->lock);
 
-	if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT) {
+	if (kvalue->common.state != BPF_STRUCT_OPS_STATE_INIT) {
 		err = -EBUSY;
 		goto unlock;
 	}
@@ -542,7 +586,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		 *
 		 * Pair with smp_load_acquire() during lookup_elem().
 		 */
-		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_READY);
+		smp_store_release(&kvalue->common.state, BPF_STRUCT_OPS_STATE_READY);
 		goto unlock;
 	}
 
@@ -560,7 +604,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		 * It ensures the above udata updates (e.g. prog->aux->id)
 		 * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
 		 */
-		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);
+		smp_store_release(&kvalue->common.state, BPF_STRUCT_OPS_STATE_INUSE);
 		/* Hold the owner module until the struct_ops is
 		 * unregistered
 		 */
@@ -596,7 +640,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 	if (st_map->map.map_flags & BPF_F_LINK)
 		return -EOPNOTSUPP;
 
-	prev_state = cmpxchg(&st_map->kvalue.state,
+	prev_state = cmpxchg(&st_map->kvalue.common.state,
 			     BPF_STRUCT_OPS_STATE_INUSE,
 			     BPF_STRUCT_OPS_STATE_TOBEFREE);
 	switch (prev_state) {
@@ -828,7 +872,7 @@ static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 	return map->map_type == BPF_MAP_TYPE_STRUCT_OPS &&
 		map->map_flags & BPF_F_LINK &&
 		/* Pair with smp_store_release() during map_update */
-		smp_load_acquire(&st_map->kvalue.state) == BPF_STRUCT_OPS_STATE_READY;
+		smp_load_acquire(&st_map->kvalue.common.state) == BPF_STRUCT_OPS_STATE_READY;
 }
 
 static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
-- 
2.34.1


