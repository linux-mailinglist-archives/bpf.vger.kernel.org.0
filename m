Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD8E226F57
	for <lists+bpf@lfdr.de>; Mon, 20 Jul 2020 21:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgGTTzM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 15:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbgGTTzL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 15:55:11 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774F7C061794
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 12:55:10 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k6so14389783ili.6
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 12:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7C4FbpTt1cXqFOfacZ2aXmH+uuIX6W3mPxgZ4Kdjswg=;
        b=NV+fbgolaeou8qumfNNMAN9tZndvi5ihM2NDNYU9r8PabUurJSLANkN7Xxtb7kITXu
         EomFRzGfEdcZ4Y2DKfJ8l5LrVJJGrsl1UMOU3GUPV8aEzvvYfuY+YatY/4Eb+L8FunT9
         bN32+VMFAIe6uqspbgPJFg8os/NR0tX9SEjVvf2fMu6pTgREXBfDW3cYR6dQvbMuw/Eh
         SitLTx6gBRU9T8OERFlVkJERpsSBPUt0cVRxTaH51wWQt/AYvsF1p202Xpb4oSvRLa/J
         O/ed0S+OnGz5N7mlUFte++l+zk8C1TBdhTQMRv9BU0hzn0P8wH2tpM9UsY5CsVXEM4tP
         pYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7C4FbpTt1cXqFOfacZ2aXmH+uuIX6W3mPxgZ4Kdjswg=;
        b=TJ5RRdcXtXFGZoJCkaue7P5fUTJPW7chfrJ81uCLf4hXtaRKv1TV1QLJ4c5KWTtgBF
         6tIH01iC6vIrClpxeX3s8LNwyqSNCFuz7DdqZDFl6p8fTHjBw6fnkFBvH9h2u85T50k3
         jB6VIaDpkpTx2CqLtFDw6KJk+ANAB54Wzg0d8j6+2yLkqeAQA1Bzkka9+bmqomn1BjyE
         hMS9wobY7aTtRx/ZCjPYSvev3ThQLLfauInX9QI60KOCNlfUbmAr5PSJz4d6L8yD2ST3
         FE/fwH0WVSUOfcHTqLpKqBSbAtVJNWcD3wCl39U6dRfCPMoj8xu/mrJxZiObKvpyALRX
         iYsA==
X-Gm-Message-State: AOAM532/kX9bni4JFR5TLhl5BvNUykIEOwEjv5uW8l24o1q9BcDBFqRA
        LB14W/SBWupRf6TfDSvGQiRQyICwkEcdcQ==
X-Google-Smtp-Source: ABdhPJyaWyxJaMgXhpzKdKnmztD+XbYaZGg0PxqBf0UbQayfmY5NjbzvZBnXn5X0MVOupbIiD+1G4Q==
X-Received: by 2002:a92:d24a:: with SMTP id v10mr25660096ilg.224.1595274907927;
        Mon, 20 Jul 2020 12:55:07 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id v10sm9347174ilj.40.2020.07.20.12.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 12:55:07 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 3/5] bpf: Make cgroup storages shared across attaches on the same cgroup
Date:   Mon, 20 Jul 2020 14:54:53 -0500
Message-Id: <f56279652110face35e35f2d4182da371cfe937c.1595274799.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595274799.git.zhuyifei@google.com>
References: <cover.1595274799.git.zhuyifei@google.com>
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
the key that still matters is the cgroup inode. bpftool map dump
will also show an attach type of zero.

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
 include/linux/bpf-cgroup.h     | 15 ++++---
 include/uapi/linux/bpf.h       |  2 +-
 kernel/bpf/cgroup.c            | 69 ++++++++++++++++++--------------
 kernel/bpf/core.c              | 12 ------
 kernel/bpf/local_storage.c     | 73 ++++++++++++----------------------
 tools/include/uapi/linux/bpf.h |  2 +-
 6 files changed, 76 insertions(+), 97 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 2c6f26670acc..2d5a04c0f4be 100644
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
 
@@ -161,15 +165,16 @@ static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
 		this_cpu_write(bpf_cgroup_storage[stype], storage[stype]);
 }
 
+struct bpf_cgroup_storage *
+cgroup_storage_lookup(struct bpf_cgroup_storage_map *map,
+		      struct bpf_cgroup_storage_key *key, bool locked);
 struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(struct bpf_prog *prog,
 					enum bpf_cgroup_storage_type stype);
 void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage);
 void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
-			     struct cgroup *cgroup,
-			     enum bpf_attach_type type);
+			     struct cgroup *cgroup);
 void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
 int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *map);
-void bpf_cgroup_storage_release(struct bpf_prog_aux *aux, struct bpf_map *map);
 
 int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
 int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
@@ -383,8 +388,6 @@ static inline void bpf_cgroup_storage_set(
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE]) {}
 static inline int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux,
 					    struct bpf_map *map) { return 0; }
-static inline void bpf_cgroup_storage_release(struct bpf_prog_aux *aux,
-					      struct bpf_map *map) {}
 static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
 	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return NULL; }
 static inline void bpf_cgroup_storage_free(
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 54d0c886e3ba..db93a211d2b1 100644
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
index ac53102e244a..f91c554d6be6 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -37,17 +37,33 @@ static void bpf_cgroup_storages_free(struct bpf_cgroup_storage *storages[])
 }
 
 static int bpf_cgroup_storages_alloc(struct bpf_cgroup_storage *storages[],
-				     struct bpf_prog *prog)
+				     struct bpf_cgroup_storage *new_storages[],
+				     struct bpf_prog *prog,
+				     struct cgroup *cgrp)
 {
 	enum bpf_cgroup_storage_type stype;
+	struct bpf_cgroup_storage_key key;
+	struct bpf_map *map;
+
+	key.cgroup_inode_id = cgroup_id(cgrp);
+	key.attach_type = 0;
 
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
@@ -63,21 +79,12 @@ static void bpf_cgroup_storages_assign(struct bpf_cgroup_storage *dst[],
 }
 
 static void bpf_cgroup_storages_link(struct bpf_cgroup_storage *storages[],
-				     struct cgroup* cgrp,
-				     enum bpf_attach_type attach_type)
-{
-	enum bpf_cgroup_storage_type stype;
-
-	for_each_cgroup_storage_type(stype)
-		bpf_cgroup_storage_link(storages[stype], cgrp, attach_type);
-}
-
-static void bpf_cgroup_storages_unlink(struct bpf_cgroup_storage *storages[])
+				     struct cgroup *cgrp)
 {
 	enum bpf_cgroup_storage_type stype;
 
 	for_each_cgroup_storage_type(stype)
-		bpf_cgroup_storage_unlink(storages[stype]);
+		bpf_cgroup_storage_link(storages[stype], cgrp);
 }
 
 /* Called when bpf_cgroup_link is auto-detached from dying cgroup.
@@ -101,22 +108,23 @@ static void cgroup_bpf_release(struct work_struct *work)
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
@@ -126,6 +134,11 @@ static void cgroup_bpf_release(struct work_struct *work)
 		bpf_prog_array_free(old_array);
 	}
 
+	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
+		bpf_cgroup_storage_unlink(storage);
+		bpf_cgroup_storage_free(storage);
+	}
+
 	mutex_unlock(&cgroup_mutex);
 
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
@@ -290,6 +303,8 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
 	for (i = 0; i < NR; i++)
 		INIT_LIST_HEAD(&cgrp->bpf.progs[i]);
 
+	INIT_LIST_HEAD(&cgrp->bpf.storages);
+
 	for (i = 0; i < NR; i++)
 		if (compute_effective_progs(cgrp, i, &arrays[i]))
 			goto cleanup;
@@ -422,7 +437,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 	struct list_head *progs = &cgrp->bpf.progs[type];
 	struct bpf_prog *old_prog = NULL;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
-	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
+	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_prog_list *pl;
 	int err;
 
@@ -455,17 +470,16 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (IS_ERR(pl))
 		return PTR_ERR(pl);
 
-	if (bpf_cgroup_storages_alloc(storage, prog ? : link->link.prog))
+	if (bpf_cgroup_storages_alloc(storage, new_storage,
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
@@ -480,12 +494,11 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (err)
 		goto cleanup;
 
-	bpf_cgroup_storages_free(old_storage);
 	if (old_prog)
 		bpf_prog_put(old_prog);
 	else
 		static_branch_inc(&cgroup_bpf_enabled_key);
-	bpf_cgroup_storages_link(pl->storage, cgrp, type);
+	bpf_cgroup_storages_link(new_storage, cgrp);
 	return 0;
 
 cleanup:
@@ -493,9 +506,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
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
@@ -679,8 +690,6 @@ int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 
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
index 51bd5a8cb01b..0b94b4ba99ba 100644
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
@@ -38,16 +39,12 @@ static int bpf_cgroup_storage_key_cmp(
 		return -1;
 	else if (key1->cgroup_inode_id > key2->cgroup_inode_id)
 		return 1;
-	else if (key1->attach_type < key2->attach_type)
-		return -1;
-	else if (key1->attach_type > key2->attach_type)
-		return 1;
 	return 0;
 }
 
-static struct bpf_cgroup_storage *cgroup_storage_lookup(
-	struct bpf_cgroup_storage_map *map, struct bpf_cgroup_storage_key *key,
-	bool locked)
+struct bpf_cgroup_storage *
+cgroup_storage_lookup(struct bpf_cgroup_storage_map *map,
+		      struct bpf_cgroup_storage_key *key, bool locked)
 {
 	struct rb_root *root = &map->root;
 	struct rb_node *node;
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
 
@@ -318,6 +311,17 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
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
@@ -426,38 +430,13 @@ const struct bpf_map_ops cgroup_storage_map_ops = {
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
@@ -563,22 +542,21 @@ void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage)
 }
 
 void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
-			     struct cgroup *cgroup,
-			     enum bpf_attach_type type)
+			     struct cgroup *cgroup)
 {
 	struct bpf_cgroup_storage_map *map;
 
 	if (!storage)
 		return;
 
-	storage->key.attach_type = type;
 	storage->key.cgroup_inode_id = cgroup_id(cgroup);
 
 	map = storage->map;
 
 	spin_lock_bh(&map->lock);
 	WARN_ON(cgroup_storage_insert(map, storage));
-	list_add(&storage->list, &map->list);
+	list_add(&storage->list_map, &map->list);
+	list_add(&storage->list_cg, &cgroup->bpf.storages);
 	spin_unlock_bh(&map->lock);
 }
 
@@ -596,7 +574,8 @@ void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage)
 	root = &map->root;
 	rb_erase(&storage->node, root);
 
-	list_del(&storage->list);
+	list_del(&storage->list_map);
+	list_del(&storage->list_cg);
 	spin_unlock_bh(&map->lock);
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 54d0c886e3ba..db93a211d2b1 100644
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

