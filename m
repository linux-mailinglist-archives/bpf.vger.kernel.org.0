Return-Path: <bpf+bounces-13625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D897B7DC079
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 20:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D15B2816D1
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A551A71A;
	Mon, 30 Oct 2023 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPXo/y6w"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAED1A5B9
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:28:22 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1B6C9
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 12:28:21 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5ac376d311aso46362977b3.1
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 12:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694100; x=1699298900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbbRUm8UtdCymYfOdGEq+RiiQ2gDaE+0khu+Mv1H/Tc=;
        b=PPXo/y6wqZZB/TNUR0S39+eH6Kv1rxe9HcCr4m1aPQLRFqXOuW5akDp20v+Zpv92Gj
         Y61X9cEPzzQCfd8bIGO4HqLYIwg2lTG/QYSEF/sWmwpAA8DYig82uVtnTJ+nio++zNBG
         h54ncVHrhaVMQC1NpycQTvQ3NVpgsg51vrrVMfDxl3I7jevKnikCxJY5FrbnyLGXiSet
         KSRlTgogabRf7E208tkxyb0yCGWl7TIl4X8w1nwBuGPTRBiF6sQze7qAZf6lUgUJ1SuW
         QeN5YQlpIVBI9CxlwFJdLmc/SsLLXzYDj1HcCyVjfiZDK9Y22D91hmB2GrxB2+rvPq5I
         UTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694100; x=1699298900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbbRUm8UtdCymYfOdGEq+RiiQ2gDaE+0khu+Mv1H/Tc=;
        b=EyjGY50yFYqWTEyCPKX4R2d93r0K7djE3xDLPtAwUVY/oX79R1PQy8uG50w3QT51Hv
         DN5T6JCuAKBkFI1wvFTe8MCormvqHKKr0kx5HFiiqAqxTthB/MYi5E5D5jOSzCytFDR8
         Aht9Egep3SpcVFORQ7i0qZgXE5Mqlwup1NE3+df4okw4FYAoHtUVOn3aQzkmpV3f9POP
         gCKchs8cF7QiVBtEsfYFeO0SJxSwLslvfExQfv0FzR19nN4KDFRltRI3rL8sF5l//phZ
         XnV03lhQpbeQdjwQW0K6BDDG5vQRIpTrIWOzJ5qxDtktP8FxejxqUkoTxRtmNA71Tenr
         /PdQ==
X-Gm-Message-State: AOJu0YxcY0TCYq7OnL/3ZOUa1m62U/52QTVLvPMPTQQQHW2E08IKOVcn
	aqxvUwwnctdCPL8mDpfdSBAjlKtBljU=
X-Google-Smtp-Source: AGHT+IEQTdTK5q8B4XmhLpajnwhIX4/UCXMgxe3invoX5xUJz3Mq/DPm/gh95xTrG+UABVgRg0u7SA==
X-Received: by 2002:a81:4c0f:0:b0:5a7:e445:fad9 with SMTP id z15-20020a814c0f000000b005a7e445fad9mr10375937ywa.35.1698694099811;
        Mon, 30 Oct 2023 12:28:19 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5b04:e8d1:ce5:8164])
        by smtp.gmail.com with ESMTPSA id n12-20020a819c4c000000b005b03d703564sm35821ywa.137.2023.10.30.12.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:28:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 04/10] bpf: hold module for bpf_struct_ops_map.
Date: Mon, 30 Oct 2023 12:28:04 -0700
Message-Id: <20231030192810.382942-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030192810.382942-1-thinker.li@gmail.com>
References: <20231030192810.382942-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

To ensure that a module remains accessible whenever a struct_ops object of
a struct_ops type provided by the module is still in use.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  1 +
 include/linux/btf.h         |  2 +-
 kernel/bpf/bpf_struct_ops.c | 70 ++++++++++++++++++++++++++++++-------
 3 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 77dd9a522d55..c993df3cf699 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1626,6 +1626,7 @@ struct bpf_struct_ops {
 	void (*unreg)(void *kdata);
 	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
+	struct module *owner;
 	const char *name;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 933a227573da..a8813605f2f6 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -576,7 +576,7 @@ struct bpf_struct_ops;
 struct bpf_struct_ops_desc;
 
 struct bpf_struct_ops_desc *
-btf_add_struct_ops(struct bpf_struct_ops *st_ops);
+btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops);
 const struct bpf_struct_ops_desc *
 btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 0bc21a39257d..b0b8cf9ed057 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -388,6 +388,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops_desc->type;
 	struct bpf_tramp_links *tlinks;
+	struct module *mod = NULL;
 	void *udata, *kdata;
 	int prog_fd, err;
 	void *image, *image_end;
@@ -425,6 +426,14 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		goto unlock;
 	}
 
+	if (st_ops_desc->btf != btf_vmlinux) {
+		mod = btf_try_get_module(st_ops_desc->btf);
+		if (!mod) {
+			err = -EINVAL;
+			goto unlock;
+		}
+	}
+
 	memcpy(uvalue, value, map->value_size);
 
 	udata = &uvalue->data;
@@ -552,6 +561,10 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		 * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
 		 */
 		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);
+		/* Hold the owner module until the struct_ops is
+		 * unregistered
+		 */
+		mod = NULL;
 		goto unlock;
 	}
 
@@ -568,6 +581,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	memset(uvalue, 0, map->value_size);
 	memset(kvalue, 0, map->value_size);
 unlock:
+	module_put(mod);
 	kfree(tlinks);
 	mutex_unlock(&st_map->lock);
 	return err;
@@ -588,6 +602,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 	switch (prev_state) {
 	case BPF_STRUCT_OPS_STATE_INUSE:
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
+		module_put(st_map->st_ops_desc->st_ops->owner);
 		bpf_map_put(map);
 		return 0;
 	case BPF_STRUCT_OPS_STATE_TOBEFREE:
@@ -674,6 +689,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	size_t st_map_size;
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
+	struct module *mod = NULL;
 	struct bpf_map *map;
 	int ret;
 
@@ -681,9 +697,17 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	if (!st_ops_desc)
 		return ERR_PTR(-ENOTSUPP);
 
+	if (st_ops_desc->btf != btf_vmlinux) {
+		mod = btf_try_get_module(st_ops_desc->btf);
+		if (!mod)
+			return ERR_PTR(-EINVAL);
+	}
+
 	vt = st_ops_desc->value_type;
-	if (attr->value_size != vt->size)
-		return ERR_PTR(-EINVAL);
+	if (attr->value_size != vt->size) {
+		ret = -EINVAL;
+		goto errout;
+	}
 
 	t = st_ops_desc->type;
 
@@ -694,17 +718,17 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		(vt->size - sizeof(struct bpf_struct_ops_value));
 
 	st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
-	if (!st_map)
-		return ERR_PTR(-ENOMEM);
+	if (!st_map) {
+		ret = -ENOMEM;
+		goto errout;
+	}
 
 	st_map->st_ops_desc = st_ops_desc;
 	map = &st_map->map;
 
 	ret = bpf_jit_charge_modmem(PAGE_SIZE);
-	if (ret) {
-		__bpf_struct_ops_map_free(map);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto errout_free;
 
 	st_map->image = bpf_jit_alloc_exec(PAGE_SIZE);
 	if (!st_map->image) {
@@ -713,23 +737,32 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		 * here.
 		 */
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
-		__bpf_struct_ops_map_free(map);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto errout_free;
 	}
 	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
 	st_map->links =
 		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_links *),
 				   NUMA_NO_NODE);
 	if (!st_map->uvalue || !st_map->links) {
-		__bpf_struct_ops_map_free(map);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto errout_free;
 	}
 
 	mutex_init(&st_map->lock);
 	set_vm_flush_reset_perms(st_map->image);
 	bpf_map_init_from_attr(map, attr);
 
+	module_put(mod);
+
 	return map;
+
+errout_free:
+	__bpf_struct_ops_map_free(map);
+	btf = NULL;		/* has been released */
+errout:
+	module_put(mod);
+	return ERR_PTR(ret);
 }
 
 static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
@@ -811,6 +844,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 		 * bpf_struct_ops_link_create() fails to register.
 		 */
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
+		module_put(st_map->st_ops_desc->st_ops->owner);
 		bpf_map_put(&st_map->map);
 	}
 	kfree(st_link);
@@ -857,6 +891,10 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	if (!bpf_struct_ops_valid_to_reg(new_map))
 		return -EINVAL;
 
+	/* The old map is holding the refcount for the owner module.  The
+	 * ownership of the owner module refcount is going to be
+	 * transferred from the old map to the new map.
+	 */
 	if (!st_map->st_ops_desc->st_ops->update)
 		return -EOPNOTSUPP;
 
@@ -902,6 +940,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	struct bpf_link_primer link_primer;
 	struct bpf_struct_ops_map *st_map;
 	struct bpf_map *map;
+	struct btf *btf;
 	int err;
 
 	map = bpf_map_get(attr->link_create.map_fd);
@@ -926,8 +965,15 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	if (err)
 		goto err_out;
 
+	/* Hold the owner module until the struct_ops is unregistered. */
+	btf = st_map->st_ops_desc->btf;
+	if (btf != btf_vmlinux && !btf_try_get_module(btf)) {
+		err = -EINVAL;
+		goto err_out;
+	}
 	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data);
 	if (err) {
+		module_put(st_map->st_ops_desc->st_ops->owner);
 		bpf_link_cleanup(&link_primer);
 		link = NULL;
 		goto err_out;
-- 
2.34.1


