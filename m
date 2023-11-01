Return-Path: <bpf+bounces-13827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0047DE6DB
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670AF281882
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 20:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636919BD4;
	Wed,  1 Nov 2023 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEziiP/K"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FEF14A99
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:45:36 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4BD110
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 13:45:33 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d9ac9573274so207569276.0
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 13:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698871532; x=1699476332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhZO17U8NjZpS95j8+E/j2LC6k05zoq1S5dO1aam3hc=;
        b=kEziiP/K9KHEm1herHwPunSG367aPRfgo8OV+NV5XLLyyHcdQSGMtFuLvBjm28mHUd
         MAq8BIQriNNutRe1SpK1aggWR49Hu4Mze5Pn6BIO0UhbO1xzFeP5BXK8k2orElHuayxa
         QX2wMAYN+LVePE7T6iRAkEHM0rn5B1ru/iohCLHpThIWogZb8vgVeS3mqOaBuBmgB1da
         zey7k0aFM/W3V5m6d9DWgGXjq6yMZGZ5AVWLP3G7lvBfgcgDNQrgPKStIfreDJw3qUqq
         Y2ColR8dQBU0qY+X2G+IWYferynGuFQpFj/dUvDja7skKdbIBOyxNJ0F9lu7tjcTD0RU
         U2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698871532; x=1699476332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhZO17U8NjZpS95j8+E/j2LC6k05zoq1S5dO1aam3hc=;
        b=YHCtks2swdOeC+I/F3iBKnMhE4oEi+oTh6jqzLtq2h/tU70pPemAgZIMcE7suQDY2S
         osUI8PggBka+roZ6dRojuGPr7TWeuB92eomtp5/CesPG9HxCTmg8ojS/OPQNbAegn5B8
         neVQZpxr3mbAzVoHRKkO/VKzPoIt5QlKKVp0RqJrsHggRcsOg3jJ4/HAwShI2qAJrWmS
         6xF93yavrC5iTetkl6Rp2XEXxSeR0hIs+GotOkgofC+wgzGGHV5d8REXkelOlTn8+Xg9
         RQNjHgUdZN4HqdqXGzvPhLIYGV0CLI7s8NGDjod+ecru7GuIz6NFG6Xd88S/9GyrAFCn
         fMXw==
X-Gm-Message-State: AOJu0YwwJ2Q+dN0xPditUozRs97lVsh2EEeA0CDBNry+U0yr6e4BvBT+
	Aposb2svujFnFe0RH78NRUwaXVqj5S4=
X-Google-Smtp-Source: AGHT+IHcTPjTT8v7INgWduE/n5pHw5sSesOCa3hXTYBez7IjZfQ1IY3ZHcohZkxC9Mt9fF0P8Fzs6g==
X-Received: by 2002:a25:d0f:0:b0:d9a:b522:a4f5 with SMTP id 15-20020a250d0f000000b00d9ab522a4f5mr13534189ybn.40.1698871532205;
        Wed, 01 Nov 2023 13:45:32 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:eea0:6f66:c57d:6b7c])
        by smtp.gmail.com with ESMTPSA id o83-20020a25d756000000b00da086d6921fsm342386ybg.50.2023.11.01.13.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 13:45:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 06/12] bpf: hold module for bpf_struct_ops_map.
Date: Wed,  1 Nov 2023 13:45:13 -0700
Message-Id: <20231101204519.677870-7-thinker.li@gmail.com>
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

To ensure that a module remains accessible whenever a struct_ops object of
a struct_ops type provided by the module is still in use.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c | 69 ++++++++++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f0ed874d5ac3..c287f42b2e48 100644
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
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 4ba6181ed1c4..be9bee970c9c 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -387,6 +387,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops_desc->type;
 	struct bpf_tramp_links *tlinks;
+	struct module *mod = NULL;
 	void *udata, *kdata;
 	int prog_fd, err;
 	void *image, *image_end;
@@ -424,6 +425,14 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		goto unlock;
 	}
 
+	if (st_map->btf != btf_vmlinux) {
+		mod = btf_try_get_module(st_map->btf);
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
@@ -713,16 +737,16 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
 
 	st_map->btf = btf_vmlinux;
@@ -731,7 +755,15 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	set_vm_flush_reset_perms(st_map->image);
 	bpf_map_init_from_attr(map, attr);
 
+	module_put(mod);
+
 	return map;
+
+errout_free:
+	__bpf_struct_ops_map_free(map);
+errout:
+	module_put(mod);
+	return ERR_PTR(ret);
 }
 
 static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
@@ -813,6 +845,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 		 * bpf_struct_ops_link_create() fails to register.
 		 */
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
+		module_put(st_map->st_ops_desc->st_ops->owner);
 		bpf_map_put(&st_map->map);
 	}
 	kfree(st_link);
@@ -859,6 +892,10 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	if (!bpf_struct_ops_valid_to_reg(new_map))
 		return -EINVAL;
 
+	/* The old map is holding the refcount for the owner module.  The
+	 * ownership of the owner module refcount is going to be
+	 * transferred from the old map to the new map.
+	 */
 	if (!st_map->st_ops_desc->st_ops->update)
 		return -EOPNOTSUPP;
 
@@ -904,6 +941,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	struct bpf_link_primer link_primer;
 	struct bpf_struct_ops_map *st_map;
 	struct bpf_map *map;
+	struct btf *btf;
 	int err;
 
 	map = bpf_map_get(attr->link_create.map_fd);
@@ -928,8 +966,15 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	if (err)
 		goto err_out;
 
+	/* Hold the owner module until the struct_ops is unregistered. */
+	btf = st_map->btf;
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


