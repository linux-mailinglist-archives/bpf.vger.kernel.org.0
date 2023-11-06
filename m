Return-Path: <bpf+bounces-14321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A98C7E2DF5
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 21:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC04EB20C0A
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 20:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E962E63A;
	Mon,  6 Nov 2023 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6L4nHjd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9212D792
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 20:13:15 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04F7172A
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 12:13:12 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5ac376d311aso56788967b3.1
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 12:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699301591; x=1699906391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsQh0U8Ut+Ze5QIgdaKASFEkrR0wI3OYmnOt8zrjhrw=;
        b=W6L4nHjdojQviHXb42LiPlbeW6AmTj/jwtlkYuvbS2Utxm9S1H/48QNBAzwGui8vY6
         nltTTFYT8K5Jo42Ghn0YG0otxJ/utOtayXqkvGsDHzaxCQSc2hDM4rthSIdrBSBJ/6y/
         6yUJVSQVJ4MzYfCfahivgY1JVpscACwvzzhRfNrNKWh5zC0uOzQNUhMPRL4GY4Oo3iWb
         ruTHRGXi5pAhEsqikTK4YClH3N+Z5FQITpir2iBVBFbh02tJyvM9qzP48e2zwMyPwdN2
         P1Vx8C0k1nFXurZsQb348k5w0KhGmnOdcL8AMDLMd/Ah3k/fjDj8qBJkR9+CpTxE/d2p
         ZYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699301591; x=1699906391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsQh0U8Ut+Ze5QIgdaKASFEkrR0wI3OYmnOt8zrjhrw=;
        b=D3q455RWHLAHzZSxngekTt+p7O/YjQyJ6fs5fdz2NYb2Ldyx0K3dSUo0VrGeTOaUNv
         GsU69QlLFZ1ZBxmatd2WnY1Oq5fYt7WGwMPb15zDXASQfus6uoIqiVq07BywTIGg4aIl
         AjruvH4gzdXG0aTI6aeGnmKnuqTXvfLzp/gGK8oChdKCTsV9WmAK4sMplCNyLsGsHmaW
         OrKK/u5PTJyyPHwUwtMx6dHc4u2qbSW9zmfV6Y9YHOO0aVOvGVw2q/lbKUw8GPrpw7rf
         N9MN8t1Izj9C8kZKlcmdkAh0gT/n8QdPwbHsg7iQiUkGaLzx0Z+vt22rh6C9D0Wsg0+8
         sgXQ==
X-Gm-Message-State: AOJu0YzEMMnKyR3C6nwvAUihu8ImYU9dxtlSlNZULn93J3AIbdF01fqo
	7kWnTEsFqlxaFWqcC7LF2yG9jSX/nFI=
X-Google-Smtp-Source: AGHT+IGQCGNBRcTJxQ9+T3ig6m81sS4VMw6DcJHpU8uCYPST6xfuzALf2SYU/w6bBoUbHSv79EtxFw==
X-Received: by 2002:a0d:d784:0:b0:5a7:ec51:9218 with SMTP id z126-20020a0dd784000000b005a7ec519218mr12276777ywd.25.1699301590786;
        Mon, 06 Nov 2023 12:13:10 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:446d:cdea:6fa5:5630])
        by smtp.gmail.com with ESMTPSA id e65-20020a816944000000b0058427045833sm4760611ywc.133.2023.11.06.12.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 12:13:10 -0800 (PST)
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
Subject: [PATCH bpf-next v11 08/13] bpf: hold module for bpf_struct_ops_map.
Date: Mon,  6 Nov 2023 12:12:47 -0800
Message-Id: <20231106201252.1568931-9-thinker.li@gmail.com>
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

To ensure that a module remains accessible whenever a struct_ops object of
a struct_ops type provided by the module is still in use.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/bpf_struct_ops.c  | 40 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 10 +++++++++
 4 files changed, 52 insertions(+)

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
index 2fb1b21f989a..d1af0ebaf02f 100644
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
@@ -746,6 +770,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	set_vm_flush_reset_perms(st_map->image);
 	bpf_map_init_from_attr(map, attr);
 
+	module_put(mod);
+
 	return map;
 
 errout_free:
@@ -753,6 +779,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	btf = NULL;		/* has been released */
 errout:
 	btf_put(btf);
+	module_put(mod);
 
 	return ERR_PTR(ret);
 }
@@ -836,6 +863,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 		 * bpf_struct_ops_link_create() fails to register.
 		 */
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
+		module_put(st_map->st_ops_desc->st_ops->owner);
 		bpf_map_put(&st_map->map);
 	}
 	kfree(st_link);
@@ -882,6 +910,10 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	if (!bpf_struct_ops_valid_to_reg(new_map))
 		return -EINVAL;
 
+	/* The old map is holding the refcount for the owner module.  The
+	 * ownership of the owner module refcount is going to be
+	 * transferred from the old map to the new map.
+	 */
 	if (!st_map->st_ops_desc->st_ops->update)
 		return -EOPNOTSUPP;
 
@@ -927,6 +959,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	struct bpf_link_primer link_primer;
 	struct bpf_struct_ops_map *st_map;
 	struct bpf_map *map;
+	struct btf *btf;
 	int err;
 
 	map = bpf_map_get(attr->link_create.map_fd);
@@ -951,8 +984,15 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
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


