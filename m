Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8BC6C552D
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 20:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCVTsg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 15:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCVTsf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 15:48:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BBEB470
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 12:48:31 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l7so2435623pjg.5
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679514511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2OohHJtVQQazdayUHWw4s/45P/q2x6ZYhmJwA5dFc0=;
        b=j5XJvzzjHDPly54c+D6JIwaGYoUk71Kwptso6JyhTDZfKmSyt2Y5pgsijZ2SvY1loj
         L42636ERuBsg0767euGlYjr+V4hOrOu8+zmUnaxKbXkGro8VPPK+tX8MHzEbI3d5WrTJ
         Zx1HsMDgqTIFoTCwAwEsaK8cYk5QV731cC2aZIH4J9XGMz/bEb3lIZdfak7gpb5MkGAb
         NI6liE63zl+q8sGS3bIRV3r2C/yuK2WpAJ92AldFefAa9jv+e0x1uOP+rbBf60VlG5wS
         LX+v3uLSIrL0vv4afhWo5BM49Xm7YvhZpV8m2WSq6CEkkK52ZgnzSdfRvQXklFhW+q8w
         rwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679514511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2OohHJtVQQazdayUHWw4s/45P/q2x6ZYhmJwA5dFc0=;
        b=C8ssxOczDv/p9/BDIEnRWg9xucREunRIdJ+/tScGfKBt+RX0ERjhwvA2GhUjoBRIis
         rEPVG2rc7xhxGRoa/ZS563wLz10PEW2tZWz8IW6XkRh878lbcQ8Sjhpcd98Sgx4Q459y
         lo3Bdkaw1X9mmFoYi2kyD+GScoO39Phgg/fmbqwUnFKk7Gc1bK2p8HTL2qFKbOBQOpYk
         nXxd2aJRBd587AbG7FjErPuJW6fk53KwYgn0QvsWCKcScpxwxMF7G1eLMieaZXNFj7y/
         vM1cUlnTA8K0cjFd2SqlAy4HhNozbDlJeweDnLEOVQok1ng+/krBHC7atecD72PYIvh4
         heyQ==
X-Gm-Message-State: AO0yUKUXQzlHZqOq6bOGI5YNSJ/I79dBVDMtqP2Y5W1Q+BCePnQwxHLy
        +7Cn8xxNBdoun3J4a/Hee6FsV7TyeyQ=
X-Google-Smtp-Source: AK7set8JyiWkpzImj1C2qW7Th+/aLy7Tv95uvT6lfmjroVwLrEpCnY4wuhS6SkYKpl36YWFQ1t4fkw==
X-Received: by 2002:a17:903:430c:b0:1a1:cef9:cc5c with SMTP id jz12-20020a170903430c00b001a1cef9cc5cmr3477877plb.15.1679514510938;
        Wed, 22 Mar 2023 12:48:30 -0700 (PDT)
Received: from localhost.localdomain ([98.42.16.172])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b0019c93ee6902sm10939946plh.109.2023.03.22.12.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:48:30 -0700 (PDT)
From:   JP Kobryn <inwardvessel@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, yhs@meta.com,
        ast@kernel.org
Cc:     kernel-team@meta.com, inwardvessel@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 2/2] bpf: return long from bpf_map_ops funcs
Date:   Wed, 22 Mar 2023 12:47:54 -0700
Message-Id: <20230322194754.185781-3-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322194754.185781-1-inwardvessel@gmail.com>
References: <20230322194754.185781-1-inwardvessel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch changes the return types of bpf_map_ops functions to long, where
previously int was returned. Using long allows for bpf programs to maintain
the sign bit in the absence of sign extension during situations where
inlined bpf helper funcs make calls to the bpf_map_ops funcs and a negative
error is returned.

The definitions of the helper funcs are generated from comments in the bpf
uapi header at `include/uapi/linux/bpf.h`. The return type of these
helpers was previously changed from int to long in commit bdb7b79b4ce8. For
any case where one of the map helpers call the bpf_map_ops funcs that are
still returning 32-bit int, a compiler might not include sign extension
instructions to properly convert the 32-bit negative value a 64-bit
negative value.

For example:
bpf assembly excerpt of an inlined helper calling a kernel function and
checking for a specific error:

; err = bpf_map_update_elem(&mymap, &key, &val, BPF_NOEXIST);
  ...
  46:	call   0xffffffffe103291c	; htab_map_update_elem
; if (err && err != -EEXIST) {
  4b:	cmp    $0xffffffffffffffef,%rax ; cmp -EEXIST,%rax

kernel function assembly excerpt of return value from
`htab_map_update_elem` returning 32-bit int:

movl $0xffffffef, %r9d
...
movl %r9d, %eax

...results in the comparison:
cmp $0xffffffffffffffef, $0x00000000ffffffef

Fixes: bdb7b79b4ce8 (bpf: Switch most helper return values from 32-bit int
to 64-bit long)
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/bpf.h            | 14 ++++++-------
 include/linux/filter.h         |  6 +++---
 kernel/bpf/arraymap.c          | 12 ++++++------
 kernel/bpf/bloom_filter.c      | 12 ++++++------
 kernel/bpf/bpf_cgrp_storage.c  |  6 +++---
 kernel/bpf/bpf_inode_storage.c |  6 +++---
 kernel/bpf/bpf_struct_ops.c    |  6 +++---
 kernel/bpf/bpf_task_storage.c  |  6 +++---
 kernel/bpf/cpumap.c            |  8 ++++----
 kernel/bpf/devmap.c            | 24 +++++++++++------------
 kernel/bpf/hashtab.c           | 36 +++++++++++++++++-----------------
 kernel/bpf/local_storage.c     |  6 +++---
 kernel/bpf/lpm_trie.c          |  6 +++---
 kernel/bpf/queue_stack_maps.c  | 22 ++++++++++-----------
 kernel/bpf/reuseport_array.c   |  2 +-
 kernel/bpf/ringbuf.c           |  6 +++---
 kernel/bpf/stackmap.c          |  6 +++---
 kernel/bpf/verifier.c          | 14 ++++++-------
 net/core/bpf_sk_storage.c      |  6 +++---
 net/core/sock_map.c            |  8 ++++----
 net/xdp/xskmap.c               |  8 ++++----
 21 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3ef98fb92987..ec0df059f562 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -96,11 +96,11 @@ struct bpf_map_ops {
 
 	/* funcs callable from userspace and from eBPF programs */
 	void *(*map_lookup_elem)(struct bpf_map *map, void *key);
-	int (*map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags);
-	int (*map_delete_elem)(struct bpf_map *map, void *key);
-	int (*map_push_elem)(struct bpf_map *map, void *value, u64 flags);
-	int (*map_pop_elem)(struct bpf_map *map, void *value);
-	int (*map_peek_elem)(struct bpf_map *map, void *value);
+	long (*map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags);
+	long (*map_delete_elem)(struct bpf_map *map, void *key);
+	long (*map_push_elem)(struct bpf_map *map, void *value, u64 flags);
+	long (*map_pop_elem)(struct bpf_map *map, void *value);
+	long (*map_peek_elem)(struct bpf_map *map, void *value);
 	void *(*map_lookup_percpu_elem)(struct bpf_map *map, void *key, u32 cpu);
 
 	/* funcs called by prog_array and perf_event_array map */
@@ -139,7 +139,7 @@ struct bpf_map_ops {
 	struct bpf_local_storage __rcu ** (*map_owner_storage_ptr)(void *owner);
 
 	/* Misc helpers.*/
-	int (*map_redirect)(struct bpf_map *map, u64 key, u64 flags);
+	long (*map_redirect)(struct bpf_map *map, u64 key, u64 flags);
 
 	/* map_meta_equal must be implemented for maps that can be
 	 * used as an inner map.  It is a runtime check to ensure
@@ -157,7 +157,7 @@ struct bpf_map_ops {
 	int (*map_set_for_each_callback_args)(struct bpf_verifier_env *env,
 					      struct bpf_func_state *caller,
 					      struct bpf_func_state *callee);
-	int (*map_for_each_callback)(struct bpf_map *map,
+	long (*map_for_each_callback)(struct bpf_map *map,
 				     bpf_callback_t callback_fn,
 				     void *callback_ctx, u64 flags);
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index efa5d4a1677e..23c08c31bea9 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1504,9 +1504,9 @@ static inline bool bpf_sk_lookup_run_v6(struct net *net, int protocol,
 }
 #endif /* IS_ENABLED(CONFIG_IPV6) */
 
-static __always_inline int __bpf_xdp_redirect_map(struct bpf_map *map, u64 index,
-						  u64 flags, const u64 flag_mask,
-						  void *lookup_elem(struct bpf_map *map, u32 key))
+static __always_inline long __bpf_xdp_redirect_map(struct bpf_map *map, u64 index,
+						   u64 flags, const u64 flag_mask,
+						   void *lookup_elem(struct bpf_map *map, u32 key))
 {
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 	const u64 action_mask = XDP_ABORTED | XDP_DROP | XDP_PASS | XDP_TX;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 1588c793a715..2058e89b5ddd 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -307,8 +307,8 @@ static int array_map_get_next_key(struct bpf_map *map, void *key, void *next_key
 }
 
 /* Called from syscall or from eBPF program */
-static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
-				 u64 map_flags)
+static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
+				  u64 map_flags)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
@@ -386,7 +386,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 }
 
 /* Called from syscall or from eBPF program */
-static int array_map_delete_elem(struct bpf_map *map, void *key)
+static long array_map_delete_elem(struct bpf_map *map, void *key)
 {
 	return -EINVAL;
 }
@@ -686,8 +686,8 @@ static const struct bpf_iter_seq_info iter_seq_info = {
 	.seq_priv_size		= sizeof(struct bpf_iter_seq_array_map_info),
 };
 
-static int bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t callback_fn,
-				   void *callback_ctx, u64 flags)
+static long bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t callback_fn,
+				    void *callback_ctx, u64 flags)
 {
 	u32 i, key, num_elems = 0;
 	struct bpf_array *array;
@@ -871,7 +871,7 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 	return 0;
 }
 
-static int fd_array_map_delete_elem(struct bpf_map *map, void *key)
+static long fd_array_map_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	void *old_ptr;
diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index 6350c5d35a9b..db19784601a7 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -41,7 +41,7 @@ static u32 hash(struct bpf_bloom_filter *bloom, void *value,
 	return h & bloom->bitset_mask;
 }
 
-static int bloom_map_peek_elem(struct bpf_map *map, void *value)
+static long bloom_map_peek_elem(struct bpf_map *map, void *value)
 {
 	struct bpf_bloom_filter *bloom =
 		container_of(map, struct bpf_bloom_filter, map);
@@ -56,7 +56,7 @@ static int bloom_map_peek_elem(struct bpf_map *map, void *value)
 	return 0;
 }
 
-static int bloom_map_push_elem(struct bpf_map *map, void *value, u64 flags)
+static long bloom_map_push_elem(struct bpf_map *map, void *value, u64 flags)
 {
 	struct bpf_bloom_filter *bloom =
 		container_of(map, struct bpf_bloom_filter, map);
@@ -73,12 +73,12 @@ static int bloom_map_push_elem(struct bpf_map *map, void *value, u64 flags)
 	return 0;
 }
 
-static int bloom_map_pop_elem(struct bpf_map *map, void *value)
+static long bloom_map_pop_elem(struct bpf_map *map, void *value)
 {
 	return -EOPNOTSUPP;
 }
 
-static int bloom_map_delete_elem(struct bpf_map *map, void *value)
+static long bloom_map_delete_elem(struct bpf_map *map, void *value)
 {
 	return -EOPNOTSUPP;
 }
@@ -177,8 +177,8 @@ static void *bloom_map_lookup_elem(struct bpf_map *map, void *key)
 	return ERR_PTR(-EINVAL);
 }
 
-static int bloom_map_update_elem(struct bpf_map *map, void *key,
-				 void *value, u64 flags)
+static long bloom_map_update_elem(struct bpf_map *map, void *key,
+				  void *value, u64 flags)
 {
 	/* The eBPF program should use map_push_elem instead */
 	return -EINVAL;
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index c975cacdd16b..f5b016a5484d 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -93,8 +93,8 @@ static void *bpf_cgrp_storage_lookup_elem(struct bpf_map *map, void *key)
 	return sdata ? sdata->data : NULL;
 }
 
-static int bpf_cgrp_storage_update_elem(struct bpf_map *map, void *key,
-					  void *value, u64 map_flags)
+static long bpf_cgrp_storage_update_elem(struct bpf_map *map, void *key,
+					 void *value, u64 map_flags)
 {
 	struct bpf_local_storage_data *sdata;
 	struct cgroup *cgroup;
@@ -125,7 +125,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
 	return 0;
 }
 
-static int bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
+static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
 {
 	struct cgroup *cgroup;
 	int err, fd;
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index ad2ab0187e45..9a5f05151898 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -91,8 +91,8 @@ static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
 	return sdata ? sdata->data : NULL;
 }
 
-static int bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
-					 void *value, u64 map_flags)
+static long bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
+					     void *value, u64 map_flags)
 {
 	struct bpf_local_storage_data *sdata;
 	struct file *f;
@@ -127,7 +127,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	return 0;
 }
 
-static int bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
+static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
 {
 	struct file *f;
 	int fd, err;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 38903fb52f98..ba7a94276e3b 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -349,8 +349,8 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 					   model, flags, tlinks, NULL);
 }
 
-static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
-					  void *value, u64 flags)
+static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
+					   void *value, u64 flags)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 	const struct bpf_struct_ops *st_ops = st_map->st_ops;
@@ -524,7 +524,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	return err;
 }
 
-static int bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
+static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 {
 	enum bpf_struct_ops_state prev_state;
 	struct bpf_struct_ops_map *st_map;
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index c88cc04c17c1..ab5bd1ef58c4 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -120,8 +120,8 @@ static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
 	return ERR_PTR(err);
 }
 
-static int bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
-					    void *value, u64 map_flags)
+static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
+					     void *value, u64 map_flags)
 {
 	struct bpf_local_storage_data *sdata;
 	struct task_struct *task;
@@ -173,7 +173,7 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
 	return 0;
 }
 
-static int bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
+static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
 {
 	struct task_struct *task;
 	unsigned int f_flags;
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 871809e71b4e..8ec18faa74ac 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -540,7 +540,7 @@ static void __cpu_map_entry_replace(struct bpf_cpu_map *cmap,
 	}
 }
 
-static int cpu_map_delete_elem(struct bpf_map *map, void *key)
+static long cpu_map_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_cpu_map *cmap = container_of(map, struct bpf_cpu_map, map);
 	u32 key_cpu = *(u32 *)key;
@@ -553,8 +553,8 @@ static int cpu_map_delete_elem(struct bpf_map *map, void *key)
 	return 0;
 }
 
-static int cpu_map_update_elem(struct bpf_map *map, void *key, void *value,
-			       u64 map_flags)
+static long cpu_map_update_elem(struct bpf_map *map, void *key, void *value,
+				u64 map_flags)
 {
 	struct bpf_cpu_map *cmap = container_of(map, struct bpf_cpu_map, map);
 	struct bpf_cpumap_val cpumap_value = {};
@@ -667,7 +667,7 @@ static int cpu_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	return 0;
 }
 
-static int cpu_map_redirect(struct bpf_map *map, u64 index, u64 flags)
+static long cpu_map_redirect(struct bpf_map *map, u64 index, u64 flags)
 {
 	return __bpf_xdp_redirect_map(map, index, flags, 0,
 				      __cpu_map_lookup_elem);
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 19b036a228f7..802692fa3905 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -809,7 +809,7 @@ static void __dev_map_entry_free(struct rcu_head *rcu)
 	kfree(dev);
 }
 
-static int dev_map_delete_elem(struct bpf_map *map, void *key)
+static long dev_map_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *old_dev;
@@ -826,7 +826,7 @@ static int dev_map_delete_elem(struct bpf_map *map, void *key)
 	return 0;
 }
 
-static int dev_map_hash_delete_elem(struct bpf_map *map, void *key)
+static long dev_map_hash_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *old_dev;
@@ -897,8 +897,8 @@ static struct bpf_dtab_netdev *__dev_map_alloc_node(struct net *net,
 	return ERR_PTR(-EINVAL);
 }
 
-static int __dev_map_update_elem(struct net *net, struct bpf_map *map,
-				 void *key, void *value, u64 map_flags)
+static long __dev_map_update_elem(struct net *net, struct bpf_map *map,
+				  void *key, void *value, u64 map_flags)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *dev, *old_dev;
@@ -939,15 +939,15 @@ static int __dev_map_update_elem(struct net *net, struct bpf_map *map,
 	return 0;
 }
 
-static int dev_map_update_elem(struct bpf_map *map, void *key, void *value,
-			       u64 map_flags)
+static long dev_map_update_elem(struct bpf_map *map, void *key, void *value,
+				u64 map_flags)
 {
 	return __dev_map_update_elem(current->nsproxy->net_ns,
 				     map, key, value, map_flags);
 }
 
-static int __dev_map_hash_update_elem(struct net *net, struct bpf_map *map,
-				     void *key, void *value, u64 map_flags)
+static long __dev_map_hash_update_elem(struct net *net, struct bpf_map *map,
+				       void *key, void *value, u64 map_flags)
 {
 	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
 	struct bpf_dtab_netdev *dev, *old_dev;
@@ -999,21 +999,21 @@ static int __dev_map_hash_update_elem(struct net *net, struct bpf_map *map,
 	return err;
 }
 
-static int dev_map_hash_update_elem(struct bpf_map *map, void *key, void *value,
-				   u64 map_flags)
+static long dev_map_hash_update_elem(struct bpf_map *map, void *key, void *value,
+				     u64 map_flags)
 {
 	return __dev_map_hash_update_elem(current->nsproxy->net_ns,
 					 map, key, value, map_flags);
 }
 
-static int dev_map_redirect(struct bpf_map *map, u64 ifindex, u64 flags)
+static long dev_map_redirect(struct bpf_map *map, u64 ifindex, u64 flags)
 {
 	return __bpf_xdp_redirect_map(map, ifindex, flags,
 				      BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS,
 				      __dev_map_lookup_elem);
 }
 
-static int dev_hash_map_redirect(struct bpf_map *map, u64 ifindex, u64 flags)
+static long dev_hash_map_redirect(struct bpf_map *map, u64 ifindex, u64 flags)
 {
 	return __bpf_xdp_redirect_map(map, ifindex, flags,
 				      BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS,
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 0df4b0c10f59..96b645bba3a4 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1073,8 +1073,8 @@ static int check_flags(struct bpf_htab *htab, struct htab_elem *l_old,
 }
 
 /* Called from syscall or from eBPF program */
-static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
-				u64 map_flags)
+static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
+				 u64 map_flags)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l_new = NULL, *l_old;
@@ -1175,8 +1175,8 @@ static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *elem)
 	bpf_lru_push_free(&htab->lru, &elem->lru_node);
 }
 
-static int htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
-				    u64 map_flags)
+static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
+				     u64 map_flags)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l_new, *l_old = NULL;
@@ -1242,9 +1242,9 @@ static int htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value,
 	return ret;
 }
 
-static int __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
-					 void *value, u64 map_flags,
-					 bool onallcpus)
+static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
+					  void *value, u64 map_flags,
+					  bool onallcpus)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l_new = NULL, *l_old;
@@ -1297,9 +1297,9 @@ static int __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 	return ret;
 }
 
-static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
-					     void *value, u64 map_flags,
-					     bool onallcpus)
+static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
+					      void *value, u64 map_flags,
+					      bool onallcpus)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l_new = NULL, *l_old;
@@ -1364,21 +1364,21 @@ static int __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	return ret;
 }
 
-static int htab_percpu_map_update_elem(struct bpf_map *map, void *key,
-				       void *value, u64 map_flags)
+static long htab_percpu_map_update_elem(struct bpf_map *map, void *key,
+					void *value, u64 map_flags)
 {
 	return __htab_percpu_map_update_elem(map, key, value, map_flags, false);
 }
 
-static int htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
-					   void *value, u64 map_flags)
+static long htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
+					    void *value, u64 map_flags)
 {
 	return __htab_lru_percpu_map_update_elem(map, key, value, map_flags,
 						 false);
 }
 
 /* Called from syscall or from eBPF program */
-static int htab_map_delete_elem(struct bpf_map *map, void *key)
+static long htab_map_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct hlist_nulls_head *head;
@@ -1414,7 +1414,7 @@ static int htab_map_delete_elem(struct bpf_map *map, void *key)
 	return ret;
 }
 
-static int htab_lru_map_delete_elem(struct bpf_map *map, void *key)
+static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct hlist_nulls_head *head;
@@ -2134,8 +2134,8 @@ static const struct bpf_iter_seq_info iter_seq_info = {
 	.seq_priv_size		= sizeof(struct bpf_iter_seq_hash_map_info),
 };
 
-static int bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
-				  void *callback_ctx, u64 flags)
+static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
+				   void *callback_ctx, u64 flags)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct hlist_nulls_head *head;
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index a993560f200a..4c7bbec4a9e4 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -141,8 +141,8 @@ static void *cgroup_storage_lookup_elem(struct bpf_map *_map, void *key)
 	return &READ_ONCE(storage->buf)->data[0];
 }
 
-static int cgroup_storage_update_elem(struct bpf_map *map, void *key,
-				      void *value, u64 flags)
+static long cgroup_storage_update_elem(struct bpf_map *map, void *key,
+				       void *value, u64 flags)
 {
 	struct bpf_cgroup_storage *storage;
 	struct bpf_storage_buffer *new;
@@ -348,7 +348,7 @@ static void cgroup_storage_map_free(struct bpf_map *_map)
 	bpf_map_area_free(map);
 }
 
-static int cgroup_storage_delete_elem(struct bpf_map *map, void *key)
+static long cgroup_storage_delete_elem(struct bpf_map *map, void *key)
 {
 	return -EINVAL;
 }
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index dc23f2ac9cde..e0d3ddf2037a 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -300,8 +300,8 @@ static struct lpm_trie_node *lpm_trie_node_alloc(const struct lpm_trie *trie,
 }
 
 /* Called from syscall or from eBPF program */
-static int trie_update_elem(struct bpf_map *map,
-			    void *_key, void *value, u64 flags)
+static long trie_update_elem(struct bpf_map *map,
+			     void *_key, void *value, u64 flags)
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
 	struct lpm_trie_node *node, *im_node = NULL, *new_node = NULL;
@@ -431,7 +431,7 @@ static int trie_update_elem(struct bpf_map *map,
 }
 
 /* Called from syscall or from eBPF program */
-static int trie_delete_elem(struct bpf_map *map, void *_key)
+static long trie_delete_elem(struct bpf_map *map, void *_key)
 {
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
 	struct bpf_lpm_trie_key *key = _key;
diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index 63ecbbcb349d..601609164ef3 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -95,7 +95,7 @@ static void queue_stack_map_free(struct bpf_map *map)
 	bpf_map_area_free(qs);
 }
 
-static int __queue_map_get(struct bpf_map *map, void *value, bool delete)
+static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
 {
 	struct bpf_queue_stack *qs = bpf_queue_stack(map);
 	unsigned long flags;
@@ -124,7 +124,7 @@ static int __queue_map_get(struct bpf_map *map, void *value, bool delete)
 }
 
 
-static int __stack_map_get(struct bpf_map *map, void *value, bool delete)
+static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
 {
 	struct bpf_queue_stack *qs = bpf_queue_stack(map);
 	unsigned long flags;
@@ -156,32 +156,32 @@ static int __stack_map_get(struct bpf_map *map, void *value, bool delete)
 }
 
 /* Called from syscall or from eBPF program */
-static int queue_map_peek_elem(struct bpf_map *map, void *value)
+static long queue_map_peek_elem(struct bpf_map *map, void *value)
 {
 	return __queue_map_get(map, value, false);
 }
 
 /* Called from syscall or from eBPF program */
-static int stack_map_peek_elem(struct bpf_map *map, void *value)
+static long stack_map_peek_elem(struct bpf_map *map, void *value)
 {
 	return __stack_map_get(map, value, false);
 }
 
 /* Called from syscall or from eBPF program */
-static int queue_map_pop_elem(struct bpf_map *map, void *value)
+static long queue_map_pop_elem(struct bpf_map *map, void *value)
 {
 	return __queue_map_get(map, value, true);
 }
 
 /* Called from syscall or from eBPF program */
-static int stack_map_pop_elem(struct bpf_map *map, void *value)
+static long stack_map_pop_elem(struct bpf_map *map, void *value)
 {
 	return __stack_map_get(map, value, true);
 }
 
 /* Called from syscall or from eBPF program */
-static int queue_stack_map_push_elem(struct bpf_map *map, void *value,
-				     u64 flags)
+static long queue_stack_map_push_elem(struct bpf_map *map, void *value,
+				      u64 flags)
 {
 	struct bpf_queue_stack *qs = bpf_queue_stack(map);
 	unsigned long irq_flags;
@@ -227,14 +227,14 @@ static void *queue_stack_map_lookup_elem(struct bpf_map *map, void *key)
 }
 
 /* Called from syscall or from eBPF program */
-static int queue_stack_map_update_elem(struct bpf_map *map, void *key,
-				       void *value, u64 flags)
+static long queue_stack_map_update_elem(struct bpf_map *map, void *key,
+					void *value, u64 flags)
 {
 	return -EINVAL;
 }
 
 /* Called from syscall or from eBPF program */
-static int queue_stack_map_delete_elem(struct bpf_map *map, void *key)
+static long queue_stack_map_delete_elem(struct bpf_map *map, void *key)
 {
 	return -EINVAL;
 }
diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 71cb72f5b733..cbf2d8d784b8 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -59,7 +59,7 @@ static void *reuseport_array_lookup_elem(struct bpf_map *map, void *key)
 }
 
 /* Called from syscall only */
-static int reuseport_array_delete_elem(struct bpf_map *map, void *key)
+static long reuseport_array_delete_elem(struct bpf_map *map, void *key)
 {
 	struct reuseport_array *array = reuseport_array(map);
 	u32 index = *(u32 *)key;
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 0d2a45ff83f1..875ac9b698d9 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -242,13 +242,13 @@ static void *ringbuf_map_lookup_elem(struct bpf_map *map, void *key)
 	return ERR_PTR(-ENOTSUPP);
 }
 
-static int ringbuf_map_update_elem(struct bpf_map *map, void *key, void *value,
-				   u64 flags)
+static long ringbuf_map_update_elem(struct bpf_map *map, void *key, void *value,
+				    u64 flags)
 {
 	return -ENOTSUPP;
 }
 
-static int ringbuf_map_delete_elem(struct bpf_map *map, void *key)
+static long ringbuf_map_delete_elem(struct bpf_map *map, void *key)
 {
 	return -ENOTSUPP;
 }
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 0f1d8dced933..b25fce425b2c 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -618,14 +618,14 @@ static int stack_map_get_next_key(struct bpf_map *map, void *key,
 	return 0;
 }
 
-static int stack_map_update_elem(struct bpf_map *map, void *key, void *value,
-				 u64 map_flags)
+static long stack_map_update_elem(struct bpf_map *map, void *key, void *value,
+				  u64 map_flags)
 {
 	return -EINVAL;
 }
 
 /* Called from syscall or from eBPF program */
-static int stack_map_delete_elem(struct bpf_map *map, void *key)
+static long stack_map_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *old_bucket;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5693e4a92752..50c995697f0e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17692,21 +17692,21 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			BUILD_BUG_ON(!__same_type(ops->map_lookup_elem,
 				     (void *(*)(struct bpf_map *map, void *key))NULL));
 			BUILD_BUG_ON(!__same_type(ops->map_delete_elem,
-				     (int (*)(struct bpf_map *map, void *key))NULL));
+				     (long (*)(struct bpf_map *map, void *key))NULL));
 			BUILD_BUG_ON(!__same_type(ops->map_update_elem,
-				     (int (*)(struct bpf_map *map, void *key, void *value,
+				     (long (*)(struct bpf_map *map, void *key, void *value,
 					      u64 flags))NULL));
 			BUILD_BUG_ON(!__same_type(ops->map_push_elem,
-				     (int (*)(struct bpf_map *map, void *value,
+				     (long (*)(struct bpf_map *map, void *value,
 					      u64 flags))NULL));
 			BUILD_BUG_ON(!__same_type(ops->map_pop_elem,
-				     (int (*)(struct bpf_map *map, void *value))NULL));
+				     (long (*)(struct bpf_map *map, void *value))NULL));
 			BUILD_BUG_ON(!__same_type(ops->map_peek_elem,
-				     (int (*)(struct bpf_map *map, void *value))NULL));
+				     (long (*)(struct bpf_map *map, void *value))NULL));
 			BUILD_BUG_ON(!__same_type(ops->map_redirect,
-				     (int (*)(struct bpf_map *map, u64 index, u64 flags))NULL));
+				     (long (*)(struct bpf_map *map, u64 index, u64 flags))NULL));
 			BUILD_BUG_ON(!__same_type(ops->map_for_each_callback,
-				     (int (*)(struct bpf_map *map,
+				     (long (*)(struct bpf_map *map,
 					      bpf_callback_t callback_fn,
 					      void *callback_ctx,
 					      u64 flags))NULL));
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 24c3dc0d62e5..cb0f5a105b89 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -94,8 +94,8 @@ static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *key)
 	return ERR_PTR(err);
 }
 
-static int bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
-					 void *value, u64 map_flags)
+static long bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
+					  void *value, u64 map_flags)
 {
 	struct bpf_local_storage_data *sdata;
 	struct socket *sock;
@@ -114,7 +114,7 @@ static int bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
 	return err;
 }
 
-static int bpf_fd_sk_storage_delete_elem(struct bpf_map *map, void *key)
+static long bpf_fd_sk_storage_delete_elem(struct bpf_map *map, void *key)
 {
 	struct socket *sock;
 	int fd, err;
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 9b854e236d23..7c189c2e2fbf 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -437,7 +437,7 @@ static void sock_map_delete_from_link(struct bpf_map *map, struct sock *sk,
 	__sock_map_delete(stab, sk, link_raw);
 }
 
-static int sock_map_delete_elem(struct bpf_map *map, void *key)
+static long sock_map_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
 	u32 i = *(u32 *)key;
@@ -587,8 +587,8 @@ int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value,
 	return ret;
 }
 
-static int sock_map_update_elem(struct bpf_map *map, void *key,
-				void *value, u64 flags)
+static long sock_map_update_elem(struct bpf_map *map, void *key,
+				 void *value, u64 flags)
 {
 	struct sock *sk = (struct sock *)value;
 	int ret;
@@ -925,7 +925,7 @@ static void sock_hash_delete_from_link(struct bpf_map *map, struct sock *sk,
 	raw_spin_unlock_bh(&bucket->lock);
 }
 
-static int sock_hash_delete_elem(struct bpf_map *map, void *key)
+static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_shtab *htab = container_of(map, struct bpf_shtab, map);
 	u32 hash, key_size = map->key_size;
diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index 0c38d7175922..2c1427074a3b 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -162,8 +162,8 @@ static void *xsk_map_lookup_elem_sys_only(struct bpf_map *map, void *key)
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
-static int xsk_map_update_elem(struct bpf_map *map, void *key, void *value,
-			       u64 map_flags)
+static long xsk_map_update_elem(struct bpf_map *map, void *key, void *value,
+				u64 map_flags)
 {
 	struct xsk_map *m = container_of(map, struct xsk_map, map);
 	struct xdp_sock __rcu **map_entry;
@@ -223,7 +223,7 @@ static int xsk_map_update_elem(struct bpf_map *map, void *key, void *value,
 	return err;
 }
 
-static int xsk_map_delete_elem(struct bpf_map *map, void *key)
+static long xsk_map_delete_elem(struct bpf_map *map, void *key)
 {
 	struct xsk_map *m = container_of(map, struct xsk_map, map);
 	struct xdp_sock __rcu **map_entry;
@@ -243,7 +243,7 @@ static int xsk_map_delete_elem(struct bpf_map *map, void *key)
 	return 0;
 }
 
-static int xsk_map_redirect(struct bpf_map *map, u64 index, u64 flags)
+static long xsk_map_redirect(struct bpf_map *map, u64 index, u64 flags)
 {
 	return __bpf_xdp_redirect_map(map, index, flags, 0,
 				      __xsk_map_lookup_elem);
-- 
2.39.2

