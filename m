Return-Path: <bpf+bounces-67323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B47AB4286E
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F22565C44
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B7035209B;
	Wed,  3 Sep 2025 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzONO0Ou"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422832EB849;
	Wed,  3 Sep 2025 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756922333; cv=none; b=imp9V/VdIcL5MkmBjssgaaIhqGRvcrvQOEw1S9DuAIYR8+L6tGupRe7NuZlk4v56FVbMmLqeeAmFgjnrcZ9gn5x2cPaMYJCgsLwiY7w4qkBtg1X5MjibgOgXUoH2qcJHkUk2Jlyr4fisjre9nB0ce4YGHDmsFmA/zW4iK2TNjWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756922333; c=relaxed/simple;
	bh=PKnWn6ca9EDsLnMx9Iy54O/89/K99WEwh+HMw2GGcGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tp9S8Pw0Hkx9pSaV8R6M3I1i1oIiH9IYsqRYnrDTwykivx30nuGkfgErRzNZKCiZYT+HA2Rt0uewacTCFyFvH8CgUy5ogEEJM3EGnT8pzPceLosUzi5Tm5fkG4k3tw1ljPDI4yHyqzJ9PHIVyiqhLHZFVFPdX4p390ZsFDjWyB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzONO0Ou; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7211b09f649so699466d6.3;
        Wed, 03 Sep 2025 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756922330; x=1757527130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e36OV5kUsA67CqNEN60qSeYCTRvQ0vSL6HVPi8QnIf4=;
        b=kzONO0OuGKbNMmz9DWlphMyIw6AptjnmvRbZfJoWVBQ5d3WDgCfqwpSS4MvXIeXfFb
         93yLsrvgyTqkD4dyN8ul1IOlb8mN++KygaDvyqN1f0acrVcRTIbQH6b0gHaG2D4UQusM
         ryV58KDpzxzbsR5EuaLzQOvwevLBZB3zsHXRNyzH4VljpRlzLT+5CabFoJw3Xxm3l7/C
         RqHrp99gxMhoOR6X5fyPC3H/spnkj6XxN9kGeSOqKvuHgN6hIhbXz+aLL2b34lSfEycQ
         hSpZ2KyjRwl6ekB0CoNu++8uXe8Qwg70jPlhJyP9TtjBsB5VcUKMSbevgsy36hqUY4Uc
         pAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756922330; x=1757527130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e36OV5kUsA67CqNEN60qSeYCTRvQ0vSL6HVPi8QnIf4=;
        b=XUHhsqW8RDn2A1JWaB9J8FSaq3I/Zb917ld2RfE9BKK4KlvWdk77BkAwtjtH6t8TZA
         0RtdC9tTgt1kUZ+pbNxkRdFraOgZRHp33T7H/9ZMltWroJ+1PYxV17IWJ/V/H8LeUQmp
         fRHqcqO9N5AJwYrSuVA4BKRd7TZuplSs8mQz7uX/rVq2h4DgtgQLGV0+aduUezISlVAR
         ylCgmpCbYybbALeLZn3JhyLUzjwCd9CJwrUooJe4XIHDyp1v02/qyZrcA53aLOrmW/Qo
         WhUChSObOermbaMDGW2+AiRyYjU5TBgvRi+DwZXy//j/enYdFNWZ7xhwOsiOn0YdRzIc
         ov3A==
X-Gm-Message-State: AOJu0YzL2gEGeWsC+LcZLWNJSLcFmTmVkIXXFBodSunzNZ9ZAD9MGcaW
	Nhe2+GcCTdrBGVl5kbBdkLiJSnnmC9B2rMAmEjFr0Ku7wX9V/xn0Rr/+jW4ujzXmnto=
X-Gm-Gg: ASbGnctgkjd2RI1aPlmMtoR3Kf4cPHrRO4H6l8qUMsdvxECsKHYs2J0Vili5eJX6Ht9
	DKdegTvzds0dDAwNEa5/uHmtDKC5LkZSN622fhkch5PBrz12I76xhkEd1FC5NOyAI2yT6qnpvAK
	XSOQaMR7jeiGyvRQYuGFlwEiHl5CWU1uSt1NFS81JNozYqtkF7cpI+gPWbcVSaqEkxNcsTzdG+e
	IkEkTP7SZ2DXPQEHUYTV4mh6x40atEKdE5jf6ffp5/Ubjpy3YJOIM8a1IiRRQ+7z6vTBB3lPuVU
	/KNpF0hMyii3Z0CErMIhjDm0YRRXvTWxBYsQb2rTLCfIRIJInMEqUrblRSD2QS16iCkzhDYI344
	4dq7vwK3y8/0yEPOMObWSZBxTUHz9NTN+y3XkcccR9V1iNtLyHpPBjZ4SKbR4LWMCFK3Zm193Sx
	Bh85Craw==
X-Google-Smtp-Source: AGHT+IGFhTSKYKqN7YPQAPBBWZD32CmvfLH0GKL3oohS7NW50s5LM6YKZlpXxavTfmvp8atsFC80zg==
X-Received: by 2002:a05:6214:4107:b0:71d:d902:692b with SMTP id 6a1803df08f44-71dd9027299mr95431726d6.29.1756922329648;
        Wed, 03 Sep 2025 10:58:49 -0700 (PDT)
Received: from kerndev.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b4665fdasm31955546d6.40.2025.09.03.10.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 10:58:49 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	dwindsor@gmail.com
Subject: [PATCH 1/2] kernel/bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type and kfuncs
Date: Wed,  3 Sep 2025 13:58:40 -0400
Message-ID: <20250903175841.232537-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All other bpf local storage is obtained using helpers which benefit from
RET_PTR_TO_MAP_VALUE_OR_NULL, so can return void * pointers directly to
map values. kfuncs don't have that, so return struct
bpf_local_storage_data * and access map values through sdata->data.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 include/linux/bpf_lsm.h       |  35 +++++++
 include/linux/bpf_types.h     |   1 +
 include/uapi/linux/bpf.h      |   1 +
 kernel/bpf/Makefile           |   1 +
 kernel/bpf/bpf_cred_storage.c | 175 ++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c          |  10 +-
 kernel/cred.c                 |   7 ++
 security/bpf/hooks.c          |   1 +
 8 files changed, 228 insertions(+), 3 deletions(-)
 create mode 100644 kernel/bpf/bpf_cred_storage.c

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 643809cc78c3..b0e2e5f2a2b8 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -40,10 +40,27 @@ static inline struct bpf_storage_blob *bpf_inode(
 	return inode->i_security + bpf_lsm_blob_sizes.lbs_inode;
 }
 
+static inline struct bpf_storage_blob *bpf_cred(
+	const struct cred *cred)
+{
+	if (unlikely(!cred->security))
+		return NULL;
+
+	return cred->security + bpf_lsm_blob_sizes.lbs_cred;
+}
+
 extern const struct bpf_func_proto bpf_inode_storage_get_proto;
 extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
 void bpf_inode_storage_free(struct inode *inode);
 
+void bpf_cred_storage_free(struct cred *cred);
+struct bpf_local_storage_data *bpf_cred_storage_get(struct bpf_map *map,
+						    struct cred *cred,
+						    void *init,
+						    int init__sz,
+						    u64 flags);
+int bpf_cred_storage_delete(struct bpf_map *map, struct cred *cred);
+
 void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func);
 
 int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
@@ -81,6 +98,24 @@ static inline void bpf_inode_storage_free(struct inode *inode)
 {
 }
 
+static inline void bpf_cred_storage_free(struct cred *cred)
+{
+}
+
+static inline struct bpf_local_storage_data *bpf_cred_storage_get(struct bpf_map *map,
+								  struct cred *cred,
+								  void *init,
+								  int init__sz,
+								  u64 flags)
+{
+	return NULL;
+}
+
+static inline int bpf_cred_storage_delete(struct bpf_map *map, struct cred *cred)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 					   bpf_func_t *bpf_func)
 {
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fa78f49d4a9a..109404ff6f08 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -110,6 +110,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_HASH_OF_MAPS, htab_of_maps_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_INODE_STORAGE, inode_storage_map_ops)
 #endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_TASK_STORAGE, task_storage_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_CRED_STORAGE, cred_storage_map_ops)
 #ifdef CONFIG_NET
 BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP, dev_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP_HASH, dev_map_hash_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..8ce34453b907 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1026,6 +1026,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
 	BPF_MAP_TYPE_ARENA,
+	BPF_MAP_TYPE_CRED_STORAGE,
 	__MAX_BPF_MAP_TYPE
 };
 
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 269c04a24664..a9e97cca162e 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
+obj-${CONFIG_BPF_LSM}	  += bpf_cred_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o rqspinlock.o stream.o
diff --git a/kernel/bpf/bpf_cred_storage.c b/kernel/bpf/bpf_cred_storage.c
new file mode 100644
index 000000000000..3202bb95830e
--- /dev/null
+++ b/kernel/bpf/bpf_cred_storage.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/rculist.h>
+#include <linux/list.h>
+#include <linux/hash.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/bpf.h>
+#include <linux/bpf_local_storage.h>
+#include <linux/bpf_lsm.h>
+#include <linux/cred.h>
+#include <linux/btf_ids.h>
+#include <linux/rcupdate_trace.h>
+
+DEFINE_BPF_STORAGE_CACHE(cred_cache);
+
+static struct bpf_local_storage __rcu **cred_storage_ptr(void *owner)
+{
+	struct cred *cred = owner;
+	struct bpf_storage_blob *bsb;
+
+	bsb = bpf_cred(cred);
+	if (!bsb)
+		return NULL;
+	return &bsb->storage;
+}
+
+static struct bpf_local_storage_data *cred_storage_lookup(struct cred *cred,
+							  struct bpf_map *map,
+							  bool cacheit_lockit)
+{
+	struct bpf_local_storage *cred_storage;
+	struct bpf_local_storage_map *smap;
+	struct bpf_storage_blob *bsb;
+
+	bsb = bpf_cred(cred);
+	if (!bsb)
+		return NULL;
+
+	cred_storage = rcu_dereference_check(bsb->storage, bpf_rcu_lock_held());
+	if (!cred_storage)
+		return NULL;
+
+	smap = (struct bpf_local_storage_map *)map;
+	return bpf_local_storage_lookup(cred_storage, smap, cacheit_lockit);
+}
+
+void bpf_cred_storage_free(struct cred *cred)
+{
+	struct bpf_local_storage *local_storage;
+	struct bpf_storage_blob *bsb;
+
+	bsb = bpf_cred(cred);
+	if (!bsb)
+		return;
+
+	migrate_disable();
+	rcu_read_lock();
+
+	local_storage = rcu_dereference(bsb->storage);
+	if (!local_storage)
+		goto out;
+
+	bpf_local_storage_destroy(local_storage);
+out:
+	rcu_read_unlock();
+	migrate_enable();
+}
+
+static int cred_storage_delete(struct cred *cred, struct bpf_map *map)
+{
+	struct bpf_local_storage_data *sdata;
+
+	sdata = cred_storage_lookup(cred, map, false);
+	if (!sdata)
+		return -ENOENT;
+
+	bpf_selem_unlink(SELEM(sdata), false);
+
+	return 0;
+}
+
+static struct bpf_map *cred_storage_map_alloc(union bpf_attr *attr)
+{
+	return bpf_local_storage_map_alloc(attr, &cred_cache, false);
+}
+
+static void cred_storage_map_free(struct bpf_map *map)
+{
+	bpf_local_storage_map_free(map, &cred_cache, NULL);
+}
+
+static int notsupp_get_next_key(struct bpf_map *map, void *key,
+				void *next_key)
+{
+	return -ENOTSUPP;
+}
+
+const struct bpf_map_ops cred_storage_map_ops = {
+	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc_check = bpf_local_storage_map_alloc_check,
+	.map_alloc = cred_storage_map_alloc,
+	.map_free = cred_storage_map_free,
+	.map_get_next_key = notsupp_get_next_key,
+	.map_check_btf = bpf_local_storage_map_check_btf,
+	.map_mem_usage = bpf_local_storage_map_mem_usage,
+	.map_btf_id = &bpf_local_storage_map_btf_id[0],
+	.map_owner_storage_ptr = cred_storage_ptr,
+};
+
+BTF_ID_LIST_SINGLE(bpf_cred_storage_btf_ids, struct, cred)
+
+__bpf_kfunc struct bpf_local_storage_data *bpf_cred_storage_get(struct bpf_map *map,
+								struct cred *cred,
+								void *init,
+								int init__sz,
+								u64 flags)
+{
+	struct bpf_local_storage_data *sdata;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return NULL;
+
+	if (!cred || !cred_storage_ptr(cred))
+		return NULL;
+
+	sdata = cred_storage_lookup(cred, map, true);
+	if (sdata)
+		return sdata;
+
+	/* This helper must only called from where the cred is guaranteed
+	 * to have a refcount and cannot be freed.
+	 */
+	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
+		sdata = bpf_local_storage_update(
+			cred, (struct bpf_local_storage_map *)map, init,
+			BPF_NOEXIST, false, GFP_ATOMIC);
+		return IS_ERR(sdata) ? NULL : sdata;
+	}
+
+	return NULL;
+}
+
+__bpf_kfunc int bpf_cred_storage_delete(struct bpf_map *map, struct cred *cred)
+{
+	if (!cred)
+		return -EINVAL;
+
+	return cred_storage_delete(cred, map);
+}
+
+BTF_KFUNCS_START(bpf_cred_storage_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_cred_storage_delete, 0)
+BTF_ID_FLAGS(func, bpf_cred_storage_get, KF_RET_NULL)
+BTF_KFUNCS_END(bpf_cred_storage_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_cred_storage_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_cred_storage_kfunc_ids,
+};
+
+static int __init bpf_cred_storage_init(void)
+{
+	int err;
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_cred_storage_kfunc_set);
+	if (err) {
+		pr_err("bpf_cred_storage: failed to register kfuncs: %d\n", err);
+		return err;
+	}
+
+	pr_info("bpf_cred_storage: kfuncs registered successfully\n");
+	return 0;
+}
+late_initcall(bpf_cred_storage_init);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fbfa8532c39..b44e7f243e10 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1262,7 +1262,8 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 				    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
 				    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
 				    map->map_type != BPF_MAP_TYPE_TASK_STORAGE &&
-				    map->map_type != BPF_MAP_TYPE_CGRP_STORAGE) {
+				    map->map_type != BPF_MAP_TYPE_CGRP_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_CRED_STORAGE) {
 					ret = -EOPNOTSUPP;
 					goto free_map_tab;
 				}
@@ -1289,13 +1290,15 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 				    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
 				    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
 				    map->map_type != BPF_MAP_TYPE_TASK_STORAGE &&
-				    map->map_type != BPF_MAP_TYPE_CGRP_STORAGE) {
+				    map->map_type != BPF_MAP_TYPE_CGRP_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_CRED_STORAGE) {
 					ret = -EOPNOTSUPP;
 					goto free_map_tab;
 				}
 				break;
 			case BPF_UPTR:
-				if (map->map_type != BPF_MAP_TYPE_TASK_STORAGE) {
+				if (map->map_type != BPF_MAP_TYPE_TASK_STORAGE &&
+			    map->map_type != BPF_MAP_TYPE_CRED_STORAGE) {
 					ret = -EOPNOTSUPP;
 					goto free_map_tab;
 				}
@@ -1449,6 +1452,7 @@ static int map_create(union bpf_attr *attr, bool kernel)
 	case BPF_MAP_TYPE_SK_STORAGE:
 	case BPF_MAP_TYPE_INODE_STORAGE:
 	case BPF_MAP_TYPE_TASK_STORAGE:
+	case BPF_MAP_TYPE_CRED_STORAGE:
 	case BPF_MAP_TYPE_CGRP_STORAGE:
 	case BPF_MAP_TYPE_BLOOM_FILTER:
 	case BPF_MAP_TYPE_LPM_TRIE:
diff --git a/kernel/cred.c b/kernel/cred.c
index 9676965c0981..a1be27fe5f4c 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -38,6 +38,10 @@ static struct kmem_cache *cred_jar;
 /* init to 2 - one for init_task, one to ensure it is never freed */
 static struct group_info init_groups = { .usage = REFCOUNT_INIT(2) };
 
+#ifdef CONFIG_BPF_LSM
+#include <linux/bpf_lsm.h>
+#endif
+
 /*
  * The initial credentials for the initial task
  */
@@ -76,6 +80,9 @@ static void put_cred_rcu(struct rcu_head *rcu)
 		      cred, atomic_long_read(&cred->usage));
 
 	security_cred_free(cred);
+#ifdef CONFIG_BPF_LSM
+	bpf_cred_storage_free(cred);
+#endif
 	key_put(cred->session_keyring);
 	key_put(cred->process_keyring);
 	key_put(cred->thread_keyring);
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index db759025abe1..d42badc18eb6 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -30,6 +30,7 @@ static int __init bpf_lsm_init(void)
 
 struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
 	.lbs_inode = sizeof(struct bpf_storage_blob),
+	.lbs_cred = sizeof(struct bpf_storage_blob),
 };
 
 DEFINE_LSM(bpf) = {
-- 
2.43.0


