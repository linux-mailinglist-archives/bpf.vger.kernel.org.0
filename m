Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7762115AE
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 00:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgGAWOU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 18:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgGAWOT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 18:14:19 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7860CC08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 15:14:19 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f6so11167575ioj.5
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 15:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P74nHhg/BNz/k28T4vM2Tn/LYp7rbYiPxgjLPbWYBNY=;
        b=IanBGaSSDhcuGXHa7rSlRSldi8kjYGwaOT1E6Oymqref1kxcYigRgkI+OCSCgLy3zs
         lyarP+J22LmeTLKAe/P/buqguDNGB85OxanF/1EviNSoooZIOWI9h+dAq6ZFE8XBB7Cz
         PtHYMuzsxlHJQn2Ddha9a6gQdbOPCHYMsvsCiIG+uT8vjYNMbEwb42nkQ9SYPgtOR31c
         0hAvk4zmKmyoA9EIowv8rIK2ubZI1r8d5UXi2EggxdyXsLfbQWAC/nJ9SYzgOi0aMxYF
         ++j/mvFbjPYaDkeVZ6FzSo8Y1XHvd4TeTqo+HoiuLvC3nxzxaUatfcwBm4SIWq5Xwrz8
         Wrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P74nHhg/BNz/k28T4vM2Tn/LYp7rbYiPxgjLPbWYBNY=;
        b=C8EPyjsqyx0ZD2RIvt5GdYMLMWD0J1pJeI7yc5Xxm/gVaNwFKJobUVN0YtQFCHemzG
         DDHFvFGj9ozMm/RC8ocUJjzTM3GO1E/YkwH0KBYfGpESWRDs8oIkegzmaRS1rkKhU4wt
         WivNKBjhzeV2BHs7wo5S4WwF3dH3NmMfKfiwk1hbZj+d27a8esrkJ3+RX41k/9lYmaWd
         RXfuHaCy9tit+H7dZ3W3EXl0kKKgW8Xl111mRQROBEKIV7x55pYbzcAWWv0UETZm9OKk
         gId2SjwRApHJMVigF7oKnAYkubnyyB235pri2aaTvFluilXwWmms7NnUTkQCl1qyXlf5
         Kn5Q==
X-Gm-Message-State: AOAM531X/FZGbpxH2kUQrhzC7mT5ntMOWMKz9IOHiF0WNCiH+Xe5t0ez
        3sW6Bb7hnyigD5ze0fObzsJvjY7hisNiVg==
X-Google-Smtp-Source: ABdhPJyJS3N5vpiH53CYbJXjE25+DBUg9tFfsBRMA2UXzt9xGsofvGEJ5s6S8pSLHPJlEuCWcRka9Q==
X-Received: by 2002:a6b:e007:: with SMTP id z7mr4291212iog.91.1593641658481;
        Wed, 01 Jul 2020 15:14:18 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id t83sm4051543ilb.47.2020.07.01.15.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 15:14:17 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>, YiFei Zhu <zhuyifei@google.com>
Subject: [RFC PATCH bpf-next 3/5] bpf: Make cgroup storages shared across attaches on the same cgroup
Date:   Wed,  1 Jul 2020 17:13:56 -0500
Message-Id: <695f8051ba309ba3f342da5c7235118b00d0af73.1593638618.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593638618.git.zhuyifei@google.com>
References: <cover.1593638618.git.zhuyifei@google.com>
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

Second, because there could be multiple attach types to the same
cgroup, the attach type is completely ignored on comparison in
the map key. Newly added keys have it zeroed. The only value in
the key that still matters is the cgroup inode.

Third, because the storages are now shared, the storages cannot
be unconditionally freed on program detach. There could be two
ways to solve this issue:
* A. Reference count the usage of the storages, and free when the
     last program is detached.
* B. Free only when the storage is impossible to be referred to
     again, i.e. when either the cgroup it is attached to, or the
     map itself, is freed.
Option A has the side effect that, when the user detach and
reattach a program, whether the program gets a fresh storage
depends on whether there is another program attached using that
storage. This could trigger races if the user is multi-threaded,
and since nondeterminism in data races is evil, go with option B.

The both the map and the cgroup now tracks their associated
storages, and the storage unlink and free are removed from
cgroup_bpf_detach and added to cgroup_bpf_release and
cgroup_storage_map_free. Storages are now always individually
unlinked so the function bpf_cgroup_storages_unlink is now unused
and removed.

Fourth, on attach, we reuse the old storage if the key already
exists in the map. Because the rbtree traversal holds the spinlock
of the map, during which we can't allocate a new storage if we
don't find an old storage, instead we preallocate the storage
unconditionally, and free the preallocated storage if we find an
old storage in the map. This results in a change of semantics in
bpf_cgroup_storage{,s}_link, and rename cgroup_storage_insert to
cgroup_storage_lookup_insert that does both lookup and conditionally
insert or free.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 include/linux/bpf-cgroup.h     | 15 +++----
 include/uapi/linux/bpf.h       |  2 +-
 kernel/bpf/cgroup.c            | 46 ++++++++------------
 kernel/bpf/core.c              | 12 ------
 kernel/bpf/local_storage.c     | 77 +++++++++++++++-------------------
 tools/include/uapi/linux/bpf.h |  2 +-
 6 files changed, 60 insertions(+), 94 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index c66c545e161a..fca58aae4851 100644
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
 
@@ -164,12 +168,11 @@ static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
 					enum bpf_cgroup_storage_type stype);
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
-void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
-			     struct cgroup *cgroup,
-			     enum bpf_attach_type type);
+struct bpf_cgroup_storage *
+bpf_cgroup_storage_link(struct bpf_cgroup_storage *new_storage,
+			struct cgroup *cgroup);
 void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
 int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *map);
-void bpf_cgroup_storage_release(struct bpf_prog_aux *aux, struct bpf_map *map);
 
 int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
 int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
@@ -380,8 +383,6 @@ static inline void bpf_cgroup_storage_set(
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) {}
 static inline int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux,
 					    struct bpf_map *map) { return 0; }
-static inline void bpf_cgroup_storage_release(struct bpf_prog_aux *aux,
-					      struct bpf_map *map) {}
 static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
 	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return NULL; }
 static inline void bpf_cgroup_storage_free(
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index da9bf35a26f8..af8f8817b9f7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -78,7 +78,7 @@ struct bpf_lpm_trie_key {
 
 struct bpf_cgroup_storage_key {
 	__u64	cgroup_inode_id;	/* cgroup inode id */
-	__u32	attach_type;		/* program attach type */
+	__u32	attach_type;		/* program attach type, unused */
 };
 
 /* BPF syscall commands, see bpf(2) man-page for details. */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4d76f16524cc..1b8483b63b9b 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -63,21 +63,13 @@ static void bpf_cgroup_storages_assign(struct bpf_cgroup_storage *dst[],
 }
 
 static void bpf_cgroup_storages_link(struct bpf_cgroup_storage *storages[],
-				     struct cgroup* cgrp,
-				     enum bpf_attach_type attach_type)
+				     struct cgroup *cgrp)
 {
 	enum bpf_cgroup_storage_type stype;
 
 	for_each_cgroup_storage_type(stype)
-		bpf_cgroup_storage_link(storages[stype], cgrp, attach_type);
-}
-
-static void bpf_cgroup_storages_unlink(struct bpf_cgroup_storage *storages[])
-{
-	enum bpf_cgroup_storage_type stype;
-
-	for_each_cgroup_storage_type(stype)
-		bpf_cgroup_storage_unlink(storages[stype]);
+		storages[stype] =
+			bpf_cgroup_storage_link(storages[stype], cgrp);
 }
 
 /* Called when bpf_cgroup_link is auto-detached from dying cgroup.
@@ -101,22 +93,23 @@ static void cgroup_bpf_release(struct work_struct *work)
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
@@ -126,6 +119,11 @@ static void cgroup_bpf_release(struct work_struct *work)
 		bpf_prog_array_free(old_array);
 	}
 
+	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
+		bpf_cgroup_storage_unlink(storage);
+		bpf_cgroup_storage_free(storage);
+	}
+
 	mutex_unlock(&cgroup_mutex);
 
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
@@ -290,6 +288,8 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
 	for (i = 0; i < NR; i++)
 		INIT_LIST_HEAD(&cgrp->bpf.progs[i]);
 
+	INIT_LIST_HEAD(&cgrp->bpf.storages);
+
 	for (i = 0; i < NR; i++)
 		if (compute_effective_progs(cgrp, i, &arrays[i]))
 			goto cleanup;
@@ -422,7 +422,6 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
-	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_prog_list *pl;
 	int err;
 
@@ -458,16 +457,12 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (bpf_cgroup_storages_alloc(storage, prog ? : link->link.prog))
 		return -ENOMEM;
 
+	bpf_cgroup_storages_link(storage, cgrp);
+
 	if (pl) {
 		old_prog = pl->prog;
-		bpf_cgroup_storages_unlink(pl->storage);
-		bpf_cgroup_storages_assign(old_storage, pl->storage);
 	} else {
 		pl = kmalloc(sizeof(*pl), GFP_KERNEL);
-		if (!pl) {
-			bpf_cgroup_storages_free(storage);
-			return -ENOMEM;
-		}
 		list_add_tail(&pl->node, progs);
 	}
 
@@ -480,12 +475,10 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (err)
 		goto cleanup;
 
-	bpf_cgroup_storages_free(old_storage);
 	if (old_prog)
 		bpf_prog_put(old_prog);
 	else
 		static_branch_inc(&cgroup_bpf_enabled_key);
-	bpf_cgroup_storages_link(pl->storage, cgrp, type);
 	return 0;
 
 cleanup:
@@ -493,9 +486,6 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 		pl->prog = old_prog;
 		pl->link = NULL;
 	}
-	bpf_cgroup_storages_free(pl->storage);
-	bpf_cgroup_storages_assign(pl->storage, old_storage);
-	bpf_cgroup_storages_link(pl->storage, cgrp, type);
 	if (!old_prog) {
 		list_del(&pl->node);
 		kfree(pl);
@@ -679,8 +669,6 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 
 	/* now can actually delete it from this cgroup list */
 	list_del(&pl->node);
-	bpf_cgroup_storages_unlink(pl->storage);
-	bpf_cgroup_storages_free(pl->storage);
 	kfree(pl);
 	if (list_empty(progs))
 		/* last program was detached, reset flags to zero */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9df4cc9a2907..f367fe7422ea 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2042,24 +2042,12 @@ int bpf_prog_array_copy_info(struct bpf_prog_array *array,
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
index 51bd5a8cb01b..3baac07bc65c 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -20,7 +20,6 @@ struct bpf_cgroup_storage_map {
 	struct bpf_map map;
 
 	spinlock_t lock;
-	struct bpf_prog_aux *aux;
 	struct rb_root root;
 	struct list_head list;
 };
@@ -38,10 +37,6 @@ static int bpf_cgroup_storage_key_cmp(
 		return -1;
 	else if (key1->cgroup_inode_id > key2->cgroup_inode_id)
 		return 1;
-	else if (key1->attach_type < key2->attach_type)
-		return -1;
-	else if (key1->attach_type > key2->attach_type)
-		return 1;
 	return 0;
 }
 
@@ -81,8 +76,9 @@ static struct bpf_cgroup_storage *cgroup_storage_lookup(
 	return NULL;
 }
 
-static int cgroup_storage_insert(struct bpf_cgroup_storage_map *map,
-				 struct bpf_cgroup_storage *storage)
+static struct bpf_cgroup_storage *
+cgroup_storage_lookup_insert(struct bpf_cgroup_storage_map *map,
+			     struct bpf_cgroup_storage *storage)
 {
 	struct rb_root *root = &map->root;
 	struct rb_node **new = &(root->rb_node), *parent = NULL;
@@ -101,14 +97,15 @@ static int cgroup_storage_insert(struct bpf_cgroup_storage_map *map,
 			new = &((*new)->rb_right);
 			break;
 		default:
-			return -EEXIST;
+			bpf_cgroup_storage_free(storage);
+			return this;
 		}
 	}
 
 	rb_link_node(&storage->node, parent, new);
 	rb_insert_color(&storage->node, root);
 
-	return 0;
+	return NULL;
 }
 
 static void *cgroup_storage_lookup_elem(struct bpf_map *_map, void *_key)
@@ -131,10 +128,7 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
 	struct bpf_cgroup_storage *storage;
 	struct bpf_storage_buffer *new;
 
-	if (unlikely(flags & ~(BPF_F_LOCK | BPF_EXIST | BPF_NOEXIST)))
-		return -EINVAL;
-
-	if (unlikely(flags & BPF_NOEXIST))
+	if (unlikely(flags & ~(BPF_F_LOCK | BPF_EXIST)))
 		return -EINVAL;
 
 	if (unlikely((flags & BPF_F_LOCK) &&
@@ -250,16 +244,15 @@ static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key,
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
 	next->cgroup_inode_id = storage->key.cgroup_inode_id;
 	return 0;
 
@@ -318,6 +311,13 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 static void cgroup_storage_map_free(struct bpf_map *_map)
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
+	struct list_head *storages = &map->list;
+	struct bpf_cgroup_storage *storage, *stmp;
+
+	list_for_each_entry_safe(storage, stmp, storages, list_map) {
+		bpf_cgroup_storage_unlink(storage);
+		bpf_cgroup_storage_free(storage);
+	}
 
 	WARN_ON(!RB_EMPTY_ROOT(&map->root));
 	WARN_ON(!list_empty(&map->list));
@@ -431,13 +431,10 @@ int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *_map)
 
 	spin_lock_bh(&map->lock);
 
-	if (map->aux && map->aux != aux)
-		goto unlock;
 	if (aux->cgroup_storage[stype] &&
 	    aux->cgroup_storage[stype] != _map)
 		goto unlock;
 
-	map->aux = aux;
 	aux->cgroup_storage[stype] = _map;
 	ret = 0;
 unlock:
@@ -446,20 +443,6 @@ int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *_map)
 	return ret;
 }
 
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
-}
-
 static size_t bpf_cgroup_storage_calculate_size(struct bpf_map *map, u32 *pages)
 {
 	size_t size;
@@ -562,24 +545,29 @@ void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage)
 		call_rcu(&storage->rcu, free_percpu_cgroup_storage_rcu);
 }
 
-void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
-			     struct cgroup *cgroup,
-			     enum bpf_attach_type type)
+struct bpf_cgroup_storage *
+bpf_cgroup_storage_link(struct bpf_cgroup_storage *new_storage,
+			struct cgroup *cgroup)
 {
 	struct bpf_cgroup_storage_map *map;
+	struct bpf_cgroup_storage *old_storage;
 
-	if (!storage)
-		return;
+	if (!new_storage)
+		return NULL;
 
-	storage->key.attach_type = type;
-	storage->key.cgroup_inode_id = cgroup_id(cgroup);
+	new_storage->key.cgroup_inode_id = cgroup_id(cgroup);
 
-	map = storage->map;
+	map = new_storage->map;
 
 	spin_lock_bh(&map->lock);
-	WARN_ON(cgroup_storage_insert(map, storage));
-	list_add(&storage->list, &map->list);
+	old_storage = cgroup_storage_lookup_insert(map, new_storage);
+	if (!old_storage) {
+		list_add(&new_storage->list_map, &map->list);
+		list_add(&new_storage->list_cg, &cgroup->bpf.storages);
+	}
 	spin_unlock_bh(&map->lock);
+
+	return old_storage ? : new_storage;
 }
 
 void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage)
@@ -596,7 +584,8 @@ void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage)
 	root = &map->root;
 	rb_erase(&storage->node, root);
 
-	list_del(&storage->list);
+	list_del(&storage->list_map);
+	list_del(&storage->list_cg);
 	spin_unlock_bh(&map->lock);
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index da9bf35a26f8..af8f8817b9f7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -78,7 +78,7 @@ struct bpf_lpm_trie_key {
 
 struct bpf_cgroup_storage_key {
 	__u64	cgroup_inode_id;	/* cgroup inode id */
-	__u32	attach_type;		/* program attach type */
+	__u32	attach_type;		/* program attach type, unused */
 };
 
 /* BPF syscall commands, see bpf(2) man-page for details. */
-- 
2.27.0

