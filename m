Return-Path: <bpf+bounces-68274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8077CB55926
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 00:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AC5A071CD
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 22:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD6E287514;
	Fri, 12 Sep 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctjt2XuY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3762857CD
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715945; cv=none; b=ujH6HInHHsuCdQtWusLzfVkA254Eh55RiayZ1lbdfjESw+empA9lxS7YaAyYenkMLuWL57BYDWHblfvHToFfXR9TVEaQC27rvM1LYCGBRffKTD1OmY/pRM8HDIOIE5dCwQGXj4t58539khdwPhtM8XBUjFtuUNzr5Nw7FeIVBJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715945; c=relaxed/simple;
	bh=im8p1MwiowuH07mrhd/0ZSWs4hwuCqJPFh1cvmTw+Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zy3blHi1jVmvRj+Oy4Q5phxWBDTTPqjvdigNQggzDG1qlnhkcQtyemnsVjBpn0+Vbpn+Ma08EqiSmard7JLzi3BZQhthTzt+sVImQ9oB5KZqbr9ocAriueoyzyg/2kK9C2zAvTzBcX7DefCeazh9nuF5X7CaLxlmuK/DbG7OcTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctjt2XuY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-807e414bf03so270309685a.0
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757715942; x=1758320742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9eeLYtqmzeirHXOAVftjlCGnIxvSAPAR9CKbvB/moo=;
        b=ctjt2XuY0Ui4IyJILOziLtD2Z3mscPpn2H13+aGE9phcu4pXRCuSAthIqw0D76Y2xQ
         cFIvWuq7gUYwf97AqTtsRicAYROldLPvtNTtfqm3VpF4AWEl2OwKVTReJkqGmjcG3h4W
         PIvA5eZq3CCaj5oe89XxcmdlNNpg4H8xcsEwHs5azGYu1pR8IvzbkoQnQWgIPwCrPn43
         MmR/brlx1dsSz1gvlEGhHa3+GJVXN2/2IjIl5trIK0x8LZo6Z1riJKryWxLpnW31yT02
         wEx9bnc71hG1pCBw11MnzgVA7zvacqAwovJNj9yehSU+7mB4fZMMVQmAlXtmHx5zDV6S
         CJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757715942; x=1758320742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9eeLYtqmzeirHXOAVftjlCGnIxvSAPAR9CKbvB/moo=;
        b=rbOyWhe7ThAZ7sIHz4+DRXepGCM2jJj8vlBNSlPwB+8Z44XsIkHSx36XmkvE0Sxn/T
         ZaSyIK2bfN8rHbyEenvX+pv8mrCAhe0OrTz6Fi8OeLBsaij3zx8E4JBNjb7OLP8B3Fa4
         iK7HLYT3ZRjfUCNdia90jAARMC70xZh07Lk/+/W9R4ET6dGAwONkGkoG8gIro/aBv++y
         qge1fuI1BgReoElw4CEGHPHe5DGcQAJ6z0at/LrevPpO1nkKETy5dZjG6rAvRyKOR100
         UgT/ixIA1/B0JZ+VhPmmR88l2s01iIJ9htMmqKKI+6BxqxEI4tpOwWko9/FeoARa1jnw
         Pd5Q==
X-Gm-Message-State: AOJu0YxcFaT+/cymNBVeuW8AyxMgTAm5vUYshReuA2vU2Xp6pGfV3Lc5
	3bhZUFhPQLHxqrqlUPekobIOvK0l7AhEHbEnvUjA7PBjsWFaCOoi677VMQjmbmojMnhJUw==
X-Gm-Gg: ASbGncuDszeBTN8dqwXUVeJfjGJ551KcmrUTpKkMbPawskuLqSJDg2Er9IJSmkBPRH0
	vDn5nVDD47b7mhWb5W6bkXWsjlVXeuYoS+O5zxLK42Vk0QuvR1Bd6I18NPxgAmen93v1H3KgG5p
	BTy8TVgTe0SqN3L1QmyYXWzB2vF+thmn3Qe0Bzp6hhbyy2gvaE4o7zIHYlD15zH0zW6Inc77n3k
	RP02UhtBIkhgKOMDOr3jyvrTusNHYXEQXa5xqAexGvzghnz7toGm8SXFhFyigY6VT2CHArYm9C3
	IBZpcWI7/Qb7PEdR/ZhzVh7/U+Yh21V2O+rSr7wbEg92yA5nmzT8HL+Mg7hOFPfRaFjAtCubnMm
	qStyXgU2LWcHGd5DEezgo6f6aqAsSFA1Kre5ZbLOxIR4qhZz8gagZM/IPJtFuAZ+2VUYPPDLAa0
	YgPqzAiil5EZitfUd07nad5pPxPSQ5hGUm1qDCEn0FhFpYxB0V
X-Google-Smtp-Source: AGHT+IGP0KpqOm/pZlOs4b+QLjSKyCCdFMY8afu3MqyI+seBsSqKuMeKlaWA0l3kWuALbYCdnATv8A==
X-Received: by 2002:a05:620a:a1d5:10b0:826:82e5:8e90 with SMTP id af79cd13be357-82682e590f1mr180949285a.21.1757715941962;
        Fri, 12 Sep 2025 15:25:41 -0700 (PDT)
Received: from kerndev.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974d635sm339136985a.25.2025.09.12.15.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 15:25:41 -0700 (PDT)
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
Subject: [PATCH 1/2] bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type and kfuncs
Date: Fri, 12 Sep 2025 18:25:38 -0400
Message-ID: <20250912222539.149952-2-dwindsor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912222539.149952-1-dwindsor@gmail.com>
References: <20250912222539.149952-1-dwindsor@gmail.com>
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
index fa78f49d4a9a..b8349e837158 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -108,6 +108,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY_OF_MAPS, array_of_maps_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_HASH_OF_MAPS, htab_of_maps_map_ops)
 #ifdef CONFIG_BPF_LSM
 BPF_MAP_TYPE(BPF_MAP_TYPE_INODE_STORAGE, inode_storage_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_CRED_STORAGE, cred_storage_map_ops)
 #endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_TASK_STORAGE, task_storage_map_ops)
 #ifdef CONFIG_NET
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
index f6cf8c2af5f7..7fd8746b2d51 100644
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
index 3f178a0f8eb1..f03811efe266 100644
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


