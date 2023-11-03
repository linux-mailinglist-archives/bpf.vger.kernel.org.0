Return-Path: <bpf+bounces-14179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFA67E0C26
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 00:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D541B281694
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E49426294;
	Fri,  3 Nov 2023 23:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dV2BC91D"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB4262A9
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 23:22:26 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42986A2
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 16:22:24 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6ce2add34c9so1391625a34.1
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 16:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699053743; x=1699658543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayberL86/HCmF2fgm3//iP2euqJ8xASrv0kldsY+oc8=;
        b=dV2BC91DNJhMoVY6DnVnhEtOJw3QbnebYVp1h/CX4yrPzDmmkq4ACSGVv0YNqzOBxh
         kQmt+AFsCi8rXtpwitOJBUbEVsAF06h/EM9BjdQscEFKquSHKyj0EXhDXY94SuxzJjUB
         EcwwUIpUvxeghn2CZvNSpfl/M4B0uP5nqJdYWm3Xod+ARHXKBWsYFF6eLBhsOk3s9/jb
         9T/DDoSKYwbK2MTgzbaRX5vCAZ7EUMWgOdwhA0eB4I0AJ/w/SYLntjPP1Lwz3gIpOon8
         UnFQiXHX37hwTbjBQfWR9bkfeQcvmBM7HYSm9j+sDQc9iCvZYJkzjAE26eoXMaiLAHMJ
         N5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053743; x=1699658543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayberL86/HCmF2fgm3//iP2euqJ8xASrv0kldsY+oc8=;
        b=XgNOlvZbP/TJWdeU6c0th2QHaTDiHd58DNEQ/wnMliLbVUUzfl7RxemF7oLOzx7iia
         /EANmuJ439d/TsGhRWxVK1r66ebZocJ2IR0I7kx8YKSq8UdN7hXA7e1THYRPmyfMaeW8
         FIhE8w0APGaE6YHLKaCFcjdmd0PE5LNCfiroNfgGUm97IItkyN7u5tVyjbtxZANDOGDK
         HUpPJgUUE7TMmgipcVEbuMw+QFdYx7fh/FsXkP89rqVmSfqQ8Vo5q+/rGDtZ6FhDSfSa
         ONT1iohq7l6TJOk3YHM+Gf7Byd8kfwv2ZNpsZouL88/xfGfvzNja55H3RAnfDUPwgXIQ
         krFA==
X-Gm-Message-State: AOJu0YzhGOUKNY6LuBXxsyqX0kt9MzWwsXh3d9B8E1qwojR6S0gPeErX
	EeVG+i0VtZGo81LC7JVohkKANGd/0IQ=
X-Google-Smtp-Source: AGHT+IFl0EnvjCNM3CXHmpyn5OTT7YhGH7vmC6sP5JP8OUHDiraEFJHWghoOaLG/74tyBu0ozGWEJA==
X-Received: by 2002:a05:6830:3145:b0:6d3:132a:5350 with SMTP id c5-20020a056830314500b006d3132a5350mr16471094ots.11.1699053743270;
        Fri, 03 Nov 2023 16:22:23 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:287:9d8c:4ad:9459])
        by smtp.gmail.com with ESMTPSA id 186-20020a4a14c3000000b0057b8baf00bbsm532288ood.22.2023.11.03.16.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:22:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v10 08/13] bpf: hold module for bpf_struct_ops_map.
Date: Fri,  3 Nov 2023 16:21:57 -0700
Message-Id: <20231103232202.3664407-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103232202.3664407-1-thinker.li@gmail.com>
References: <20231103232202.3664407-1-thinker.li@gmail.com>
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
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/bpf_struct_ops.c  | 66 +++++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c        | 10 ++++++
 4 files changed, 66 insertions(+), 12 deletions(-)

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
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 24213a99cc79..c1461342f19e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -598,6 +598,7 @@ struct bpf_verifier_env {
 	u32 prev_insn_idx;
 	struct bpf_prog *prog;		/* eBPF program being verified */
 	const struct bpf_verifier_ops *ops;
+	struct module *attach_btf_mod;	/* The owner module of prog->aux->attach_btf */
 	struct bpf_verifier_stack_elem *head; /* stack of verifier states to be processed */
 	int stack_size;			/* number of states to be processed */
 	bool strict_alignment;		/* perform strict pointer alignment checks */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 8aaaa5121a56..d1af0ebaf02f 100644
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
@@ -675,6 +690,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	size_t st_map_size;
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
+	struct module *mod = NULL;
 	struct bpf_map *map;
 	struct btf *btf;
 	int ret;
@@ -684,6 +700,14 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		btf = btf_get_by_fd(attr->value_type_btf_obj_fd);
 		if (IS_ERR(btf))
 			return ERR_PTR(PTR_ERR(btf));
+
+		if (btf != btf_vmlinux) {
+			mod = btf_try_get_module(btf);
+			if (!mod) {
+				ret = -EINVAL;
+				goto errout;
+			}
+		}
 	} else {
 		btf = btf_vmlinux;
 		btf_get(btf);
@@ -696,8 +720,10 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	}
 
 	vt = st_ops_desc->value_type;
-	if (attr->value_size != vt->size)
-		return ERR_PTR(-EINVAL);
+	if (attr->value_size != vt->size) {
+		ret = -EINVAL;
+		goto errout;
+	}
 
 	t = st_ops_desc->type;
 
@@ -708,18 +734,18 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 		(vt->size - sizeof(struct bpf_struct_ops_value));
 
 	st_map = bpf_map_area_alloc(st_map_size, NUMA_NO_NODE);
-	if (!st_map)
-		return ERR_PTR(-ENOMEM);
+	if (!st_map) {
+		ret = -ENOMEM;
+		goto errout;
+	}
 
 	st_map->btf = btf;
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
@@ -728,22 +754,24 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
 
 errout_free:
@@ -751,6 +779,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	btf = NULL;		/* has been released */
 errout:
 	btf_put(btf);
+	module_put(mod);
 
 	return ERR_PTR(ret);
 }
@@ -834,6 +863,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 		 * bpf_struct_ops_link_create() fails to register.
 		 */
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
+		module_put(st_map->st_ops_desc->st_ops->owner);
 		bpf_map_put(&st_map->map);
 	}
 	kfree(st_link);
@@ -880,6 +910,10 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	if (!bpf_struct_ops_valid_to_reg(new_map))
 		return -EINVAL;
 
+	/* The old map is holding the refcount for the owner module.  The
+	 * ownership of the owner module refcount is going to be
+	 * transferred from the old map to the new map.
+	 */
 	if (!st_map->st_ops_desc->st_ops->update)
 		return -EOPNOTSUPP;
 
@@ -925,6 +959,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	struct bpf_link_primer link_primer;
 	struct bpf_struct_ops_map *st_map;
 	struct bpf_map *map;
+	struct btf *btf;
 	int err;
 
 	map = bpf_map_get(attr->link_create.map_fd);
@@ -949,8 +984,15 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3f446f76d4bf..20d6d9665983 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20095,6 +20095,14 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf = prog->aux->attach_btf;
+	if (btf != btf_vmlinux) {
+		/* Make sure st_ops is valid through the lifetime of env */
+		env->attach_btf_mod = btf_try_get_module(btf);
+		if (!env->attach_btf_mod) {
+			verbose(env, "owner module of btf is not found\n");
+			return -ENOTSUPP;
+		}
+	}
 
 	btf_id = prog->aux->attach_btf_id;
 	st_ops_desc = bpf_struct_ops_find(btf, btf_id);
@@ -20808,6 +20816,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		env->prog->expected_attach_type = 0;
 
 	*prog = env->prog;
+
+	module_put(env->attach_btf_mod);
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
-- 
2.34.1


