Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2272122BD25
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 06:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgGXEsK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 00:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXEsK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jul 2020 00:48:10 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EF7C0619D3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 21:48:10 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s189so1343383iod.2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 21:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztnuNnwRsx1mjoN0w2ERdkN7AgPng0pmojdp1TRmJY0=;
        b=N1nMfXyHGfwXTdJvhbmmKBRbYV8+iHDTDuiyRdFxtaw0ZYfWmSCxnSg8Z0SVjcyGqq
         Kfros6ZdSrGcT+7i9RMdQCTanfD9xLFzfl+a8GoerZZ0kTEeO+z3XNrhCMkQzTSfd5ZW
         TqoQHELhduNCAqH/vE9+wsKWIXvPs6PpDSAkEv8UUJhXgobXJt7rB6qPF7Wgwg8QYdqL
         1n46gJ7sHSgMZp0Zi8APt0F3Cb3TWLml25Vpx21Qx52pdR8XOwwE9qcY/FYRwzslkeqv
         zrAhodHT5f2ivtYM0+PwqdGFoGWc6KNsH3IFB7Oh8BJps/204By7LWbroTCtKYGMi2oE
         9VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztnuNnwRsx1mjoN0w2ERdkN7AgPng0pmojdp1TRmJY0=;
        b=fFgX+l3jG6d3FA4QFCagm8+ipeqCKNRiqbBsxI8FzTwUR9nVV4sqE8FD57i60QNl9o
         J1vLHK73xv71vYaO3Dwercd73SZlio5oZI604/U015oiX4JvCqpPEVg1UOfdCZHn7y7e
         wBP7ZZzZM7gR67X3X0Nd25M7hXwZX9CIerbVN0h8E+bYtHpqJtvmMcH0FNkUpzNRh2YB
         szXf/7UrvaMpemyUIzHnZ1zeVB70SnVvoA4nWddPSNaGY3S9PT4YdisCMZp8AWFSsnmc
         cqARIgj+DFo+PwF7qJwLQsQsxwsjy4znvlgZ7W0IctocU5xXj9yEUhTbFMJY8f2G3Mft
         UypQ==
X-Gm-Message-State: AOAM53091Uvs0375Euzy8zOpdXoXFiCz8LNmX2i+5ijGyTCabXqPzWsD
        77dnvfG3ClCdK6hrMQnS2FdS5DGXv3zdaA==
X-Google-Smtp-Source: ABdhPJwun3oyx6lotfC8ZNaatNHsT3K2qlTu5WYXlfT24hExe6N9b51eSw/a+Hm6xvW54ucWZCj4Yw==
X-Received: by 2002:a6b:1601:: with SMTP id 1mr7517711iow.155.1595566088789;
        Thu, 23 Jul 2020 21:48:08 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id o64sm2686579ilb.12.2020.07.23.21.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 21:48:08 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH v6 bpf-next 3/5] bpf: Make cgroup storages shared between programs on the same cgroup
Date:   Thu, 23 Jul 2020 23:47:43 -0500
Message-Id: <d5401c6106728a00890401190db40020a1f84ff1.1595565795.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595565795.git.zhuyifei@google.com>
References: <cover.1595565795.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

This change comes in several parts:

One, the restriction that the CGROUP_STORAGE map can only be used
by one program is removed. This results in the removal of the field
'aux' in struct bpf_cgroup_storage_map, and removal of relevant
code associated with the field, and removal of now-noop functions
bpf_free_cgroup_storage and bpf_cgroup_storage_release.

Second, we permit a key of type u64 as the key to the map.
Providing such a key type indicates that the map should ignore
attach type when comparing map keys. However, for simplicity newly
linked storage will still have the attach type at link time in
its key struct. cgroup_storage_check_btf is adapted to accept
u64 as the type of the key.

Third, because the storages are now shared, the storages cannot
be unconditionally freed on program detach. There could be two
ways to solve this issue:
* A. Reference count the usage of the storages, and free when the
     last program is detached.
* B. Free only when the storage is impossible to be referred to
     again, i.e. when either the cgroup_bpf it is attached to, or
     the map itself, is freed.
Option A has the side effect that, when the user detach and
reattach a program, whether the program gets a fresh storage
depends on whether there is another program attached using that
storage. This could trigger races if the user is multi-threaded,
and since nondeterminism in data races is evil, go with option B.

The both the map and the cgroup_bpf now tracks their associated
storages, and the storage unlink and free are removed from
cgroup_bpf_detach and added to cgroup_bpf_release and
cgroup_storage_map_free. The latter also new holds the cgroup_mutex
to prevent any races with the former.

Fourth, on attach, we reuse the old storage if the key already
exists in the map, via cgroup_storage_lookup. If the storage
does not exist yet, we create a new one, and publish it at the
last step in the attach process. This does not create a race
condition because for the whole attach the cgroup_mutex is held.
We keep track of an array of new storages that was allocated
and if the process fails only the new storages would get freed.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 include/linux/bpf-cgroup.h |  12 ++-
 kernel/bpf/cgroup.c        |  67 +++++++-----
 kernel/bpf/core.c          |  12 ---
 kernel/bpf/local_storage.c | 216 ++++++++++++++++++++-----------------
 4 files changed, 164 insertions(+), 143 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 2c6f26670acc..64f367044e25 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -46,7 +46,8 @@ struct bpf_cgroup_storage {
 	};
 	struct bpf_cgroup_storage_map *map;
 	struct bpf_cgroup_storage_key key;
-	struct list_head list;
+	struct list_head list_map;
+	struct list_head list_cg;
 	struct rb_node node;
 	struct rcu_head rcu;
 };
@@ -78,6 +79,9 @@ struct cgroup_bpf {
 	struct list_head progs[MAX_BPF_ATTACH_TYPE];
 	u32 flags[MAX_BPF_ATTACH_TYPE];
 
+	/* list of cgroup shared storages */
+	struct list_head storages;
+
 	/* temp storage for effective prog array used by prog_attach/detach */
 	struct bpf_prog_array *inactive;
 
@@ -161,6 +165,9 @@ static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
 		this_cpu_write(bpf_cgroup_storage[stype], storage[stype]);
 }
 
+struct bpf_cgroup_storage *
+cgroup_storage_lookup(struct bpf_cgroup_storage_map *map,
+		      void *key, bool locked);
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
 					enum bpf_cgroup_storage_type stype);
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
@@ -169,7 +176,6 @@ void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
 			     enum bpf_attach_type type);
 void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
 int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *map);
-void bpf_cgroup_storage_release(struct bpf_prog_aux *aux, struct bpf_map *map);
 
 int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
 int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
@@ -383,8 +389,6 @@ static inline void bpf_cgroup_storage_set(
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) {}
 static inline int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux,
 					    struct bpf_map *map) { return 0; }
-static inline void bpf_cgroup_storage_release(struct bpf_prog_aux *aux,
-					      struct bpf_map *map) {}
 static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
 	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return NULL; }
 static inline void bpf_cgroup_storage_free(
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index ac53102e244a..957cce1d5168 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -37,17 +37,34 @@ static void bpf_cgroup_storages_free(struct bpf_cgroup_storage *storages[])
 }
 
 static int bpf_cgroup_storages_alloc(struct bpf_cgroup_storage *storages[],
-				     struct bpf_prog *prog)
+				     struct bpf_cgroup_storage *new_storages[],
+				     enum bpf_attach_type type,
+				     struct bpf_prog *prog,
+				     struct cgroup *cgrp)
 {
 	enum bpf_cgroup_storage_type stype;
+	struct bpf_cgroup_storage_key key;
+	struct bpf_map *map;
+
+	key.cgroup_inode_id = cgroup_id(cgrp);
+	key.attach_type = type;
 
 	for_each_cgroup_storage_type(stype) {
+		map = prog->aux->cgroup_storage[stype];
+		if (!map)
+			continue;
+
+		storages[stype] = cgroup_storage_lookup((void *)map, &key, false);
+		if (storages[stype])
+			continue;
+
 		storages[stype] = bpf_cgroup_storage_alloc(prog, stype);
 		if (IS_ERR(storages[stype])) {
-			storages[stype] = NULL;
-			bpf_cgroup_storages_free(storages);
+			bpf_cgroup_storages_free(new_storages);
 			return -ENOMEM;
 		}
+
+		new_storages[stype] = storages[stype];
 	}
 
 	return 0;
@@ -63,7 +80,7 @@ static void bpf_cgroup_storages_assign(struct bpf_cgroup_storage *dst[],
 }
 
 static void bpf_cgroup_storages_link(struct bpf_cgroup_storage *storages[],
-				     struct cgroup* cgrp,
+				     struct cgroup *cgrp,
 				     enum bpf_attach_type attach_type)
 {
 	enum bpf_cgroup_storage_type stype;
@@ -72,14 +89,6 @@ static void bpf_cgroup_storages_link(struct bpf_cgroup_storage *storages[],
 		bpf_cgroup_storage_link(storages[stype], cgrp, attach_type);
 }
 
-static void bpf_cgroup_storages_unlink(struct bpf_cgroup_storage *storages[])
-{
-	enum bpf_cgroup_storage_type stype;
-
-	for_each_cgroup_storage_type(stype)
-		bpf_cgroup_storage_unlink(storages[stype]);
-}
-
 /* Called when bpf_cgroup_link is auto-detached from dying cgroup.
  * It drops cgroup and bpf_prog refcounts, and marks bpf_link as defunct. It
  * doesn't free link memory, which will eventually be done by bpf_link's
@@ -101,22 +110,23 @@ static void cgroup_bpf_release(struct work_struct *work)
 	struct cgroup *p, *cgrp = container_of(work, struct cgroup,
 					       bpf.release_work);
 	struct bpf_prog_array *old_array;
+	struct list_head *storages = &cgrp->bpf.storages;
+	struct bpf_cgroup_storage *storage, *stmp;
+
 	unsigned int type;
 
 	mutex_lock(&cgroup_mutex);
 
 	for (type = 0; type < ARRAY_SIZE(cgrp->bpf.progs); type++) {
 		struct list_head *progs = &cgrp->bpf.progs[type];
-		struct bpf_prog_list *pl, *tmp;
+		struct bpf_prog_list *pl, *pltmp;
 
-		list_for_each_entry_safe(pl, tmp, progs, node) {
+		list_for_each_entry_safe(pl, pltmp, progs, node) {
 			list_del(&pl->node);
 			if (pl->prog)
 				bpf_prog_put(pl->prog);
 			if (pl->link)
 				bpf_cgroup_link_auto_detach(pl->link);
-			bpf_cgroup_storages_unlink(pl->storage);
-			bpf_cgroup_storages_free(pl->storage);
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key);
 		}
@@ -126,6 +136,11 @@ static void cgroup_bpf_release(struct work_struct *work)
 		bpf_prog_array_free(old_array);
 	}
 
+	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
+		bpf_cgroup_storage_unlink(storage);
+		bpf_cgroup_storage_free(storage);
+	}
+
 	mutex_unlock(&cgroup_mutex);
 
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
@@ -290,6 +305,8 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
 	for (i = 0; i < NR; i++)
 		INIT_LIST_HEAD(&cgrp->bpf.progs[i]);
 
+	INIT_LIST_HEAD(&cgrp->bpf.storages);
+
 	for (i = 0; i < NR; i++)
 		if (compute_effective_progs(cgrp, i, &arrays[i]))
 			goto cleanup;
@@ -422,7 +439,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
-	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
+	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_prog_list *pl;
 	int err;
 
@@ -455,17 +472,16 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (IS_ERR(pl))
 		return PTR_ERR(pl);
 
-	if (bpf_cgroup_storages_alloc(storage, prog ? : link->link.prog))
+	if (bpf_cgroup_storages_alloc(storage, new_storage, type,
+				      prog ? : link->link.prog, cgrp))
 		return -ENOMEM;
 
 	if (pl) {
 		old_prog = pl->prog;
-		bpf_cgroup_storages_unlink(pl->storage);
-		bpf_cgroup_storages_assign(old_storage, pl->storage);
 	} else {
 		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
 		if (!pl) {
-			bpf_cgroup_storages_free(storage);
+			bpf_cgroup_storages_free(new_storage);
 			return -ENOMEM;
 		}
 		list_add_tail(&pl->node, progs);
@@ -480,12 +496,11 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (err)
 		goto cleanup;
 
-	bpf_cgroup_storages_free(old_storage);
 	if (old_prog)
 		bpf_prog_put(old_prog);
 	else
 		static_branch_inc(&cgroup_bpf_enabled_key);
-	bpf_cgroup_storages_link(pl->storage, cgrp, type);
+	bpf_cgroup_storages_link(new_storage, cgrp, type);
 	return 0;
 
 cleanup:
@@ -493,9 +508,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 		pl->prog = old_prog;
 		pl->link = NULL;
 	}
-	bpf_cgroup_storages_free(pl->storage);
-	bpf_cgroup_storages_assign(pl->storage, old_storage);
-	bpf_cgroup_storages_link(pl->storage, cgrp, type);
+	bpf_cgroup_storages_free(new_storage);
 	if (!old_prog) {
 		list_del(&pl->node);
 		kfree(pl);
@@ -679,8 +692,6 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* now can actually delete it from this cgroup list */
 	list_del(&pl->node);
-	bpf_cgroup_storages_unlink(pl->storage);
-	bpf_cgroup_storages_free(pl->storage);
 	kfree(pl);
 	if (list_empty(progs))
 		/* last program was detached, reset flags to zero */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7be02e555ab9..bde93344164d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2097,24 +2097,12 @@ int bpf_prog_array_copy_info(struct bpf_prog_array *array,
 								     : 0;
 }
 
-static void bpf_free_cgroup_storage(struct bpf_prog_aux *aux)
-{
-	enum bpf_cgroup_storage_type stype;
-
-	for_each_cgroup_storage_type(stype) {
-		if (!aux->cgroup_storage[stype])
-			continue;
-		bpf_cgroup_storage_release(aux, aux->cgroup_storage[stype]);
-	}
-}
-
 void __bpf_free_used_maps(struct bpf_prog_aux *aux,
 			  struct bpf_map **used_maps, u32 len)
 {
 	struct bpf_map *map;
 	u32 i;
 
-	bpf_free_cgroup_storage(aux);
 	for (i = 0; i < len; i++) {
 		map = used_maps[i];
 		if (map->ops->map_poke_untrack)
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 51bd5a8cb01b..3b2c70197d78 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -9,6 +9,8 @@
 #include <linux/slab.h>
 #include <uapi/linux/btf.h>
 
+#include "../cgroup/cgroup-internal.h"
+
 DEFINE_PER_CPU(struct bpf_cgroup_storage*, bpf_cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE]);
 
 #ifdef CONFIG_CGROUP_BPF
@@ -20,7 +22,6 @@ struct bpf_cgroup_storage_map {
 	struct bpf_map map;
 
 	spinlock_t lock;
-	struct bpf_prog_aux *aux;
 	struct rb_root root;
 	struct list_head list;
 };
@@ -30,24 +31,41 @@ static struct bpf_cgroup_storage_map *map_to_storage(struct bpf_map *map)
 	return container_of(map, struct bpf_cgroup_storage_map, map);
 }
 
-static int bpf_cgroup_storage_key_cmp(
-	const struct bpf_cgroup_storage_key *key1,
-	const struct bpf_cgroup_storage_key *key2)
+static bool attach_type_isolated(const struct bpf_map *map)
 {
-	if (key1->cgroup_inode_id < key2->cgroup_inode_id)
-		return -1;
-	else if (key1->cgroup_inode_id > key2->cgroup_inode_id)
-		return 1;
-	else if (key1->attach_type < key2->attach_type)
-		return -1;
-	else if (key1->attach_type > key2->attach_type)
-		return 1;
+	return map->key_size == sizeof(struct bpf_cgroup_storage_key);
+}
+
+static int bpf_cgroup_storage_key_cmp(const struct bpf_cgroup_storage_map *map,
+				      const void *_key1, const void *_key2)
+{
+	if (attach_type_isolated(&map->map)) {
+		const struct bpf_cgroup_storage_key *key1 = _key1;
+		const struct bpf_cgroup_storage_key *key2 = _key2;
+
+		if (key1->cgroup_inode_id < key2->cgroup_inode_id)
+			return -1;
+		else if (key1->cgroup_inode_id > key2->cgroup_inode_id)
+			return 1;
+		else if (key1->attach_type < key2->attach_type)
+			return -1;
+		else if (key1->attach_type > key2->attach_type)
+			return 1;
+	} else {
+		const __u64 *cgroup_inode_id1 = _key1;
+		const __u64 *cgroup_inode_id2 = _key2;
+
+		if (*cgroup_inode_id1 < *cgroup_inode_id2)
+			return -1;
+		else if (*cgroup_inode_id1 > *cgroup_inode_id2)
+			return 1;
+	}
 	return 0;
 }
 
-static struct bpf_cgroup_storage *cgroup_storage_lookup(
-	struct bpf_cgroup_storage_map *map, struct bpf_cgroup_storage_key *key,
-	bool locked)
+struct bpf_cgroup_storage *
+cgroup_storage_lookup(struct bpf_cgroup_storage_map *map,
+		      void *key, bool locked)
 {
 	struct rb_root *root = &map->root;
 	struct rb_node *node;
@@ -61,7 +79,7 @@ static struct bpf_cgroup_storage *cgroup_storage_lookup(
 
 		storage = container_of(node, struct bpf_cgroup_storage, node);
 
-		switch (bpf_cgroup_storage_key_cmp(key, &storage->key)) {
+		switch (bpf_cgroup_storage_key_cmp(map, key, &storage->key)) {
 		case -1:
 			node = node->rb_left;
 			break;
@@ -93,7 +111,7 @@ static int cgroup_storage_insert(struct bpf_cgroup_storage_map *map,
 		this = container_of(*new, struct bpf_cgroup_storage, node);
 
 		parent = *new;
-		switch (bpf_cgroup_storage_key_cmp(&storage->key, &this->key)) {
+		switch (bpf_cgroup_storage_key_cmp(map, &storage->key, &this->key)) {
 		case -1:
 			new = &((*new)->rb_left);
 			break;
@@ -111,10 +129,9 @@ static int cgroup_storage_insert(struct bpf_cgroup_storage_map *map,
 	return 0;
 }
 
-static void *cgroup_storage_lookup_elem(struct bpf_map *_map, void *_key)
+static void *cgroup_storage_lookup_elem(struct bpf_map *_map, void *key)
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
-	struct bpf_cgroup_storage_key *key = _key;
 	struct bpf_cgroup_storage *storage;
 
 	storage = cgroup_storage_lookup(map, key, false);
@@ -124,17 +141,13 @@ static void *cgroup_storage_lookup_elem(struct bpf_map *_map, void *_key)
 	return &READ_ONCE(storage->buf)->data[0];
 }
 
-static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
+static int cgroup_storage_update_elem(struct bpf_map *map, void *key,
 				      void *value, u64 flags)
 {
-	struct bpf_cgroup_storage_key *key = _key;
 	struct bpf_cgroup_storage *storage;
 	struct bpf_storage_buffer *new;
 
-	if (unlikely(flags & ~(BPF_F_LOCK | BPF_EXIST | BPF_NOEXIST)))
-		return -EINVAL;
-
-	if (unlikely(flags & BPF_NOEXIST))
+	if (unlikely(flags & ~(BPF_F_LOCK | BPF_EXIST)))
 		return -EINVAL;
 
 	if (unlikely((flags & BPF_F_LOCK) &&
@@ -167,11 +180,10 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
 	return 0;
 }
 
-int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *_key,
+int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
 				   void *value)
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
-	struct bpf_cgroup_storage_key *key = _key;
 	struct bpf_cgroup_storage *storage;
 	int cpu, off = 0;
 	u32 size;
@@ -197,11 +209,10 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *_key,
 	return 0;
 }
 
-int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *_key,
+int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 				     void *value, u64 map_flags)
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
-	struct bpf_cgroup_storage_key *key = _key;
 	struct bpf_cgroup_storage *storage;
 	int cpu, off = 0;
 	u32 size;
@@ -232,12 +243,10 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *_key,
 	return 0;
 }
 
-static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key,
+static int cgroup_storage_get_next_key(struct bpf_map *_map, void *key,
 				       void *_next_key)
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
-	struct bpf_cgroup_storage_key *key = _key;
-	struct bpf_cgroup_storage_key *next = _next_key;
 	struct bpf_cgroup_storage *storage;
 
 	spin_lock_bh(&map->lock);
@@ -250,17 +259,23 @@ static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key,
 		if (!storage)
 			goto enoent;
 
-		storage = list_next_entry(storage, list);
+		storage = list_next_entry(storage, list_map);
 		if (!storage)
 			goto enoent;
 	} else {
 		storage = list_first_entry(&map->list,
-					 struct bpf_cgroup_storage, list);
+					 struct bpf_cgroup_storage, list_map);
 	}
 
 	spin_unlock_bh(&map->lock);
-	next->attach_type = storage->key.attach_type;
-	next->cgroup_inode_id = storage->key.cgroup_inode_id;
+
+	if (attach_type_isolated(&map->map)) {
+		struct bpf_cgroup_storage_key *next = _next_key;
+		*next = storage->key;
+	} else {
+		__u64 *next = _next_key;
+		*next = storage->key.cgroup_inode_id;
+	}
 	return 0;
 
 enoent:
@@ -275,7 +290,8 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 	struct bpf_map_memory mem;
 	int ret;
 
-	if (attr->key_size != sizeof(struct bpf_cgroup_storage_key))
+	if (attr->key_size != sizeof(struct bpf_cgroup_storage_key) &&
+	    attr->key_size != sizeof(__u64))
 		return ERR_PTR(-EINVAL);
 
 	if (attr->value_size == 0)
@@ -318,6 +334,17 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 static void cgroup_storage_map_free(struct bpf_map *_map)
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct list_head *storages = &map->list;
+	struct bpf_cgroup_storage *storage, *stmp;
+
+	mutex_lock(&cgroup_mutex);
+
+	list_for_each_entry_safe(storage, stmp, storages, list_map) {
+		bpf_cgroup_storage_unlink(storage);
+		bpf_cgroup_storage_free(storage);
+	}
+
+	mutex_unlock(&cgroup_mutex);
 
 	WARN_ON(!RB_EMPTY_ROOT(&map->root));
 	WARN_ON(!list_empty(&map->list));
@@ -335,49 +362,63 @@ static int cgroup_storage_check_btf(const struct bpf_map *map,
 				    const struct btf_type *key_type,
 				    const struct btf_type *value_type)
 {
-	struct btf_member *m;
-	u32 offset, size;
-
-	/* Key is expected to be of struct bpf_cgroup_storage_key type,
-	 * which is:
-	 * struct bpf_cgroup_storage_key {
-	 *	__u64	cgroup_inode_id;
-	 *	__u32	attach_type;
-	 * };
-	 */
+	if (attach_type_isolated(map)) {
+		struct btf_member *m;
+		u32 offset, size;
+
+		/* Key is expected to be of struct bpf_cgroup_storage_key type,
+		 * which is:
+		 * struct bpf_cgroup_storage_key {
+		 *	__u64	cgroup_inode_id;
+		 *	__u32	attach_type;
+		 * };
+		 */
+
+		/*
+		 * Key_type must be a structure with two fields.
+		 */
+		if (BTF_INFO_KIND(key_type->info) != BTF_KIND_STRUCT ||
+		    BTF_INFO_VLEN(key_type->info) != 2)
+			return -EINVAL;
+
+		/*
+		 * The first field must be a 64 bit integer at 0 offset.
+		 */
+		m = (struct btf_member *)(key_type + 1);
+		size = sizeof_field(struct bpf_cgroup_storage_key, cgroup_inode_id);
+		if (!btf_member_is_reg_int(btf, key_type, m, 0, size))
+			return -EINVAL;
+
+		/*
+		 * The second field must be a 32 bit integer at 64 bit offset.
+		 */
+		m++;
+		offset = offsetof(struct bpf_cgroup_storage_key, attach_type);
+		size = sizeof_field(struct bpf_cgroup_storage_key, attach_type);
+		if (!btf_member_is_reg_int(btf, key_type, m, offset, size))
+			return -EINVAL;
+	} else {
+		u32 int_data;
 
-	/*
-	 * Key_type must be a structure with two fields.
-	 */
-	if (BTF_INFO_KIND(key_type->info) != BTF_KIND_STRUCT ||
-	    BTF_INFO_VLEN(key_type->info) != 2)
-		return -EINVAL;
+		/*
+		 * Key is expected to be u64, which stores the cgroup_inode_id
+		 */
 
-	/*
-	 * The first field must be a 64 bit integer at 0 offset.
-	 */
-	m = (struct btf_member *)(key_type + 1);
-	size = sizeof_field(struct bpf_cgroup_storage_key, cgroup_inode_id);
-	if (!btf_member_is_reg_int(btf, key_type, m, 0, size))
-		return -EINVAL;
+		if (BTF_INFO_KIND(key_type->info) != BTF_KIND_INT)
+			return -EINVAL;
 
-	/*
-	 * The second field must be a 32 bit integer at 64 bit offset.
-	 */
-	m++;
-	offset = offsetof(struct bpf_cgroup_storage_key, attach_type);
-	size = sizeof_field(struct bpf_cgroup_storage_key, attach_type);
-	if (!btf_member_is_reg_int(btf, key_type, m, offset, size))
-		return -EINVAL;
+		int_data = *(u32 *)(key_type + 1);
+		if (BTF_INT_BITS(int_data) != 64 || BTF_INT_OFFSET(int_data))
+			return -EINVAL;
+	}
 
 	return 0;
 }
 
-static void cgroup_storage_seq_show_elem(struct bpf_map *map, void *_key,
+static void cgroup_storage_seq_show_elem(struct bpf_map *map, void *key,
 					 struct seq_file *m)
 {
 	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
-	struct bpf_cgroup_storage_key *key = _key;
 	struct bpf_cgroup_storage *storage;
 	int cpu;
 
@@ -426,38 +467,13 @@ const struct bpf_map_ops cgroup_storage_map_ops = {
 int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *_map)
 {
 	enum bpf_cgroup_storage_type stype = cgroup_storage_type(_map);
-	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
-	int ret = -EBUSY;
-
-	spin_lock_bh(&map->lock);
 
-	if (map->aux && map->aux != aux)
-		goto unlock;
 	if (aux->cgroup_storage[stype] &&
 	    aux->cgroup_storage[stype] != _map)
-		goto unlock;
+		return -EBUSY;
 
-	map->aux = aux;
 	aux->cgroup_storage[stype] = _map;
-	ret = 0;
-unlock:
-	spin_unlock_bh(&map->lock);
-
-	return ret;
-}
-
-void bpf_cgroup_storage_release(struct bpf_prog_aux *aux, struct bpf_map *_map)
-{
-	enum bpf_cgroup_storage_type stype = cgroup_storage_type(_map);
-	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
-
-	spin_lock_bh(&map->lock);
-	if (map->aux == aux) {
-		WARN_ON(aux->cgroup_storage[stype] != _map);
-		map->aux = NULL;
-		aux->cgroup_storage[stype] = NULL;
-	}
-	spin_unlock_bh(&map->lock);
+	return 0;
 }
 
 static size_t bpf_cgroup_storage_calculate_size(struct bpf_map *map, u32 *pages)
@@ -578,7 +594,8 @@ void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
 
 	spin_lock_bh(&map->lock);
 	WARN_ON(cgroup_storage_insert(map, storage));
-	list_add(&storage->list, &map->list);
+	list_add(&storage->list_map, &map->list);
+	list_add(&storage->list_cg, &cgroup->bpf.storages);
 	spin_unlock_bh(&map->lock);
 }
 
@@ -596,7 +613,8 @@ void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage)
 	root = &map->root;
 	rb_erase(&storage->node, root);
 
-	list_del(&storage->list);
+	list_del(&storage->list_map);
+	list_del(&storage->list_cg);
 	spin_unlock_bh(&map->lock);
 }
 
-- 
2.27.0

