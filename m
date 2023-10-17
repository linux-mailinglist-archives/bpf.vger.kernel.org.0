Return-Path: <bpf+bounces-12447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181577CC8B0
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE831C20D0C
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCA79CA55;
	Tue, 17 Oct 2023 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UppGAfeW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D6B4735D
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 16:23:17 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D947A9E
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:23:15 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9beb865a40so2464072276.1
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697559795; x=1698164595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUcW83e55Bna8gBEv5q3MMNy5IQNTEE5zYJyBPrfHXs=;
        b=UppGAfeW6FNpy0f4f7umIzMm9RRNRurAxfmYr8mv+Tu1+1TcyjRzVNcMcbSk9hfNnX
         AV5DoEheKHnR8nD9I7wPufRSjohck3TxhyzXUHar1Wkj85/G5FuPSkUX9wmP8RGZR3U5
         xuwyhfjVDHlJdScy1pZ2QBjYLpLLECFug3WwwTa0fl+Z8XO9SwT8v6JBQ46QbbuZKXar
         I7ga0b9+scp9lYdQMalsc1VQOr/SZXzxRDbV/AUNaGknLIJmC4JQh+Si6Oos+yZwM4NR
         6iei4iVQJjITUSpcOQ2epnGguGeACvyCVp9j2bIC9etIytlmlQAz2RMjMvGrlVE1GXkz
         PwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697559795; x=1698164595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUcW83e55Bna8gBEv5q3MMNy5IQNTEE5zYJyBPrfHXs=;
        b=BFNbxY7J38ThtLvuyDUOpg1xe3YirPqdrxJl7oqFfr8KEYZmccwb3X1ZLTlkuDXJaq
         EWJaImRm7rslRwKunLxC+le7MOaklsBsgHAZ6+FdzziI2Lws10iz1wV2Gye71AkgJuFm
         aL4HSpYtCvIqvKcPQXBRs/0B48Oge7mSqxjOtarSbKvPaebjMsOfoMANjlUBQSQ/ruR7
         mUGReLTS7+JXbir2PKPo3iNm5W5cerrWUaN31Ks76oCFD/ipAN7CJtphTEsaSDcsy8S/
         FHXeWrHIxnCmKV5+YVsRLJe95Pt4TcYS5ruWYOTh95YorqRBYgI33B0eF4IbbNgpT2Cw
         hsZQ==
X-Gm-Message-State: AOJu0YxLQ1uk4QUU27h/0u4VVoexa52MxClMAVWOJhBeDgRpgcOKv8xl
	06OspeQLF5/I3PYlBEQngveTP+GUuSk=
X-Google-Smtp-Source: AGHT+IFa10qHzncqL3x4/ybcP9EWJ4Z/YH4iVwSWsKyvq6ECWpI95c0WYfTv4ReToAQWSvEuFhlvmQ==
X-Received: by 2002:a25:b214:0:b0:d9a:63f5:10d6 with SMTP id i20-20020a25b214000000b00d9a63f510d6mr3181068ybj.26.1697559794703;
        Tue, 17 Oct 2023 09:23:14 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ed01:b54a:4364:93cc])
        by smtp.gmail.com with ESMTPSA id r189-20020a2544c6000000b00d814d8dfd69sm623645yba.27.2023.10.17.09.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:23:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 4/9] bpf: validate value_type
Date: Tue, 17 Oct 2023 09:23:01 -0700
Message-Id: <20231017162306.176586-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017162306.176586-1-thinker.li@gmail.com>
References: <20231017162306.176586-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

A value_type should consist of three components: refcnt, state, and data.
refcnt and state has been move to struct bpf_struct_ops_common_value to
make it easier to check the value type.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 88 +++++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index b561245fe235..69703584fa4a 100644
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
 
 static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 				    struct btf *btf,
@@ -130,14 +164,6 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
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
@@ -152,6 +178,16 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
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
 
@@ -201,7 +237,7 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 {
 	struct bpf_struct_ops *st_ops;
-	s32 module_id;
+	s32 module_id, common_value_id;
 	u32 i;
 
 	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
@@ -215,6 +251,14 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
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
 		st_ops = bpf_struct_ops[i];
@@ -278,7 +322,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 
 	kvalue = &st_map->kvalue;
 	/* Pair with smp_store_release() during map_update */
-	state = smp_load_acquire(&kvalue->state);
+	state = smp_load_acquire(&kvalue->common.state);
 	if (state == BPF_STRUCT_OPS_STATE_INIT) {
 		memset(value, 0, map->value_size);
 		return 0;
@@ -289,7 +333,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 	 */
 	uvalue = value;
 	memcpy(uvalue, st_map->uvalue, map->value_size);
-	uvalue->state = state;
+	uvalue->common.state = state;
 
 	/* This value offers the user space a general estimate of how
 	 * many sockets are still utilizing this struct_ops for TCP
@@ -297,7 +341,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 	 * should sufficiently meet our present goals.
 	 */
 	refcnt = atomic64_read(&map->refcnt) - atomic64_read(&map->usercnt);
-	refcount_set(&uvalue->refcnt, max_t(s64, refcnt, 0));
+	refcount_set(&uvalue->common.refcnt, max_t(s64, refcnt, 0));
 
 	return 0;
 }
@@ -408,7 +452,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (err)
 		return err;
 
-	if (uvalue->state || refcount_read(&uvalue->refcnt))
+	if (uvalue->common.state || refcount_read(&uvalue->common.refcnt))
 		return -EINVAL;
 
 	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
@@ -420,7 +464,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 
 	mutex_lock(&st_map->lock);
 
-	if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT) {
+	if (kvalue->common.state != BPF_STRUCT_OPS_STATE_INIT) {
 		err = -EBUSY;
 		goto unlock;
 	}
@@ -533,7 +577,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		 *
 		 * Pair with smp_load_acquire() during lookup_elem().
 		 */
-		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_READY);
+		smp_store_release(&kvalue->common.state, BPF_STRUCT_OPS_STATE_READY);
 		goto unlock;
 	}
 
@@ -551,7 +595,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		 * It ensures the above udata updates (e.g. prog->aux->id)
 		 * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
 		 */
-		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);
+		smp_store_release(&kvalue->common.state, BPF_STRUCT_OPS_STATE_INUSE);
 		goto unlock;
 	}
 
@@ -582,7 +626,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 	if (st_map->map.map_flags & BPF_F_LINK)
 		return -EOPNOTSUPP;
 
-	prev_state = cmpxchg(&st_map->kvalue.state,
+	prev_state = cmpxchg(&st_map->kvalue.common.state,
 			     BPF_STRUCT_OPS_STATE_INUSE,
 			     BPF_STRUCT_OPS_STATE_TOBEFREE);
 	switch (prev_state) {
@@ -676,7 +720,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_map *map;
 	int ret;
 
-	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf_vmlinux);
+	st_ops = bpf_struct_ops_find_value(btf_vmlinux, attr->btf_vmlinux_value_type_id);
 	if (!st_ops)
 		return ERR_PTR(-ENOTSUPP);
 
@@ -805,7 +849,7 @@ static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 	return map->map_type == BPF_MAP_TYPE_STRUCT_OPS &&
 		map->map_flags & BPF_F_LINK &&
 		/* Pair with smp_store_release() during map_update */
-		smp_load_acquire(&st_map->kvalue.state) == BPF_STRUCT_OPS_STATE_READY;
+		smp_load_acquire(&st_map->kvalue.common.state) == BPF_STRUCT_OPS_STATE_READY;
 }
 
 static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
-- 
2.34.1


