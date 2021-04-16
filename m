Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E501361D97
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 12:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbhDPJ73 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 05:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhDPJ7Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Apr 2021 05:59:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1388C061574
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 02:59:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g5so34582171ejx.0
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C0ijUOZ7ICiZ6Hh9Niqfftb9ZfBpigpCl9SkrAOkajU=;
        b=wS2yVb49lSu9nQghdpLc9qr6eS0dtKQDt+aESGEngDJfPCq4wS5JbPYrmMJdXbymc7
         Kdq0sY7S1x0mDpE8UN8fF+CrcVR7LrdE0zz1wDY8qcjiluy6sKbDAkx3OPPDPGZPbNFS
         RaKt7UkYZFfexGB0NUtXjSjcm6N4btUln2mFPQeOuRbBJzPSJHZCGuyATI3CHdlwIAxU
         gijZvasJnxrleCgTLEZZ+ywkPmtPVraXitiDg1ruhRKWHxte9nKC0TiIvR/kBRhyVJ6q
         8cc16BlpGYDD2n64qh43ultGsGe5tSzVT3CRbOifIM07J/f41YiVL8BEN8n6ia4+MoJ4
         qPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C0ijUOZ7ICiZ6Hh9Niqfftb9ZfBpigpCl9SkrAOkajU=;
        b=M6LTv/7PEEf0lh3u35ttTndcfVUtBgPoXg+NlYAC5Vpa84mZcXx++fzkZB5s+G8Wdh
         AutkB35FVY7bLmkm483Ee9D603N7mG1iSPJhbPVNMY8toSMK7tpSDxy64FCx4VgIrNOB
         oidoCCa1wGMo9JLvcECco6xcuAeX0a8dm4l7sJJZT8TEzg2NXLx+fPHTmpVMMettEo7D
         e3qNm7T2454U7wF04qnEvwlCn1BJlVyGS2jtxWl2UkzlapDQQrwfaGlCC3hp3FBZc57G
         JaM2rnjeOER8UdGvzrqZj5Bnn1Aa1fhYYfFxz5O1gFLgjMZLI+obN6TX/pKWUJE8LyCk
         PLPQ==
X-Gm-Message-State: AOAM532zXdBtCQdjMHoPcKbYhNJSOyXlEen6+URH3pPkU/luzxcZVjMj
        55vNnY3IDRA1KtHjAZDCaiZIDKglP6DEpDWwYorC9LV8dAVp3T0u+WAhhHaJE0dRRgUT3J67QZ3
        Mk6O4DPKVUJn1x7XmIi59zYFtqtQX17Fz6jU++b5z7iCPnPPYdFNxHkEFunPF+8COOKs3bkgA
X-Google-Smtp-Source: ABdhPJwlwxXS4dEGwFY06jd45E+jcpYtQfVS8b7uIoI7+4jxb1Uc0vqcEdbzdIKRlW9pgER+K8nqoQ==
X-Received: by 2002:a17:906:7e53:: with SMTP id z19mr7647977ejr.422.1618567139651;
        Fri, 16 Apr 2021 02:58:59 -0700 (PDT)
Received: from localhost.localdomain (93-136-90-129.adsl.net.t-com.hr. [93.136.90.129])
        by smtp.gmail.com with ESMTPSA id h15sm3926719ejs.72.2021.04.16.02.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 02:58:58 -0700 (PDT)
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     bpf@vger.kernel.org
Cc:     Denis Salopek <denis.salopek@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 1/3] bpf: add lookup_and_delete_elem support to hashtab
Date:   Fri, 16 Apr 2021 11:58:12 +0200
Message-Id: <20210416095814.2771-1-denis.salopek@sartura.hr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend the existing bpf_map_lookup_and_delete_elem() functionality to
hashtab map types, in addition to stacks and queues.
Create a new hashtab bpf_map_ops function that does lookup and deletion
of the element under the same bucket lock and add the created map_ops to
bpf.h.

Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
Cc: Yonghong Song <yhs@fb.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
---
v2: Add functionality for LRU/per-CPU, add test_progs tests.
v3: Add bpf_map_lookup_and_delete_elem_flags() and enable BPF_F_LOCK
flag, change CHECKs to ASSERT_OKs, initialize variables to 0.
v4: Fix the return value for unsupported map types.
v5: Split patch to 3 patches. Extend BPF_MAP_LOOKUP_AND_DELETE_ELEM
documentation with this changes.
---
 include/linux/bpf.h            |  2 +
 include/uapi/linux/bpf.h       | 13 +++++
 kernel/bpf/hashtab.c           | 99 ++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           | 33 ++++++++++--
 tools/include/uapi/linux/bpf.h | 13 +++++
 5 files changed, 156 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ff8cd68c01b3..d39fe682799e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -68,6 +68,8 @@ struct bpf_map_ops {
 	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
 	int (*map_lookup_batch)(struct bpf_map *map, const union bpf_attr *attr,
 				union bpf_attr __user *uattr);
+	int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key,
+					  void *value, u64 flags);
 	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
 					   const union bpf_attr *attr,
 					   union bpf_attr __user *uattr);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index df164a44bb41..f30cabe02814 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -527,6 +527,15 @@ union bpf_iter_link_info {
  *		Look up an element with the given *key* in the map referred to
  *		by the file descriptor *fd*, and if found, delete the element.
  *
+ *		For **BPF_MAP_TYPE_QUEUE** and **BPF_MAP_TYPE_STACK** map
+ *		types, the *flags* argument needs to be set to 0, but for other
+ *		map types, it may be specified as:
+ *
+ *		**BPF_F_LOCK**
+ *			Look up and delete the value of a spin-locked map
+ *			without returning the lock. This must be specified if
+ *			the elements contain a spinlock.
+ *
  *		The **BPF_MAP_TYPE_QUEUE** and **BPF_MAP_TYPE_STACK** map types
  *		implement this command as a "pop" operation, deleting the top
  *		element rather than one corresponding to *key*.
@@ -536,6 +545,10 @@ union bpf_iter_link_info {
  *		This command is only valid for the following map types:
  *		* **BPF_MAP_TYPE_QUEUE**
  *		* **BPF_MAP_TYPE_STACK**
+ *		* **BPF_MAP_TYPE_HASH**
+ *		* **BPF_MAP_TYPE_PERCPU_HASH**
+ *		* **BPF_MAP_TYPE_LRU_HASH**
+ *		* **BPF_MAP_TYPE_LRU_PERCPU_HASH**
  *
  *	Return
  *		Returns zero on success. On error, -1 is returned and *errno*
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d7ebb12ffffc..5e57503d4706 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1401,6 +1401,101 @@ static void htab_map_seq_show_elem(struct bpf_map *map, void *key,
 	rcu_read_unlock();
 }
 
+static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
+					     void *value, bool is_lru_map,
+					     bool is_percpu, u64 flags)
+{
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	struct hlist_nulls_head *head;
+	unsigned long bflags;
+	struct htab_elem *l;
+	u32 hash, key_size;
+	struct bucket *b;
+	int ret;
+
+	if ((flags & ~BPF_F_LOCK) ||
+	    ((flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
+		return -EINVAL;
+
+	key_size = map->key_size;
+
+	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	b = __select_bucket(htab, hash);
+	head = &b->head;
+
+	ret = htab_lock_bucket(htab, b, hash, &bflags);
+	if (ret)
+		return ret;
+
+	l = lookup_elem_raw(head, hash, key, key_size);
+	if (l) {
+		if (is_percpu) {
+			u32 roundup_value_size = round_up(map->value_size, 8);
+			void __percpu *pptr;
+			int off = 0, cpu;
+
+			pptr = htab_elem_get_ptr(l, key_size);
+			for_each_possible_cpu(cpu) {
+				bpf_long_memcpy(value + off,
+						per_cpu_ptr(pptr, cpu),
+						roundup_value_size);
+				off += roundup_value_size;
+			}
+		} else {
+			if (flags & BPF_F_LOCK)
+				copy_map_value_locked(map, value, l->key +
+						      round_up(key_size, 8),
+						      true);
+			else
+				copy_map_value(map, value, l->key +
+					       round_up(key_size, 8));
+			check_and_init_map_lock(map, value);
+		}
+
+		hlist_nulls_del_rcu(&l->hash_node);
+		if (!is_lru_map)
+			free_htab_elem(htab, l);
+	} else
+		ret = -ENOENT;
+
+	htab_unlock_bucket(htab, b, hash, bflags);
+
+	if (is_lru_map && l)
+		bpf_lru_push_free(&htab->lru, &l->lru_node);
+
+	return ret;
+}
+
+static int htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
+					   void *value, u64 flags)
+{
+	return __htab_map_lookup_and_delete_elem(map, key, value, false, false,
+						 flags);
+}
+
+static int htab_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
+						  void *key, void *value,
+						  u64 flags)
+{
+	return __htab_map_lookup_and_delete_elem(map, key, value, false, true,
+						 flags);
+}
+
+static int htab_lru_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
+					       void *value, u64 flags)
+{
+	return __htab_map_lookup_and_delete_elem(map, key, value, true, false,
+						 flags);
+}
+
+static int htab_lru_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
+						      void *key, void *value,
+						      u64 flags)
+{
+	return __htab_map_lookup_and_delete_elem(map, key, value, true, true,
+						 flags);
+}
+
 static int
 __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 				   const union bpf_attr *attr,
@@ -1934,6 +2029,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_map_lookup_elem,
+	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
 	.map_update_elem = htab_map_update_elem,
 	.map_delete_elem = htab_map_delete_elem,
 	.map_gen_lookup = htab_map_gen_lookup,
@@ -1954,6 +2050,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_lru_map_lookup_elem,
+	.map_lookup_and_delete_elem = htab_lru_map_lookup_and_delete_elem,
 	.map_lookup_elem_sys_only = htab_lru_map_lookup_elem_sys,
 	.map_update_elem = htab_lru_map_update_elem,
 	.map_delete_elem = htab_lru_map_delete_elem,
@@ -2077,6 +2174,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_percpu_map_lookup_elem,
+	.map_lookup_and_delete_elem = htab_percpu_map_lookup_and_delete_elem,
 	.map_update_elem = htab_percpu_map_update_elem,
 	.map_delete_elem = htab_map_delete_elem,
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
@@ -2096,6 +2194,7 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_lru_percpu_map_lookup_elem,
+	.map_lookup_and_delete_elem = htab_lru_percpu_map_lookup_and_delete_elem,
 	.map_update_elem = htab_lru_percpu_map_update_elem,
 	.map_delete_elem = htab_lru_map_delete_elem,
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fd495190115e..78f6312d9bdb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1468,7 +1468,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	return err;
 }
 
-#define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD value
+#define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD flags
 
 static int map_lookup_and_delete_elem(union bpf_attr *attr)
 {
@@ -1484,6 +1484,9 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_MAP_LOOKUP_AND_DELETE_ELEM))
 		return -EINVAL;
 
+	if (attr->flags & ~BPF_F_LOCK)
+		return -EINVAL;
+
 	f = fdget(ufd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
@@ -1494,24 +1497,46 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
+	if (attr->flags && (map->map_type == BPF_MAP_TYPE_QUEUE ||
+	    map->map_type == BPF_MAP_TYPE_STACK)) {
+		err = -EINVAL;
+		goto err_put;
+	}
+
+	if ((attr->flags & BPF_F_LOCK) &&
+	    !map_value_has_spin_lock(map)) {
+		err = -EINVAL;
+		goto err_put;
+	}
+
 	key = __bpf_copy_key(ukey, map->key_size);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
 	}
 
-	value_size = map->value_size;
+	value_size = bpf_map_value_size(map);
 
 	err = -ENOMEM;
 	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
 	if (!value)
 		goto free_key;
 
+	err = -ENOTSUPP;
 	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
 	    map->map_type == BPF_MAP_TYPE_STACK) {
 		err = map->ops->map_pop_elem(map, value);
-	} else {
-		err = -ENOTSUPP;
+	} else if (map->map_type == BPF_MAP_TYPE_HASH ||
+		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
+		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
+		if (!bpf_map_is_dev_bound(map)) {
+			bpf_disable_instrumentation();
+			rcu_read_lock();
+			err = map->ops->map_lookup_and_delete_elem(map, key, value, attr->flags);
+			rcu_read_unlock();
+			bpf_enable_instrumentation();
+		}
 	}
 
 	if (err)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index df164a44bb41..f30cabe02814 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -527,6 +527,15 @@ union bpf_iter_link_info {
  *		Look up an element with the given *key* in the map referred to
  *		by the file descriptor *fd*, and if found, delete the element.
  *
+ *		For **BPF_MAP_TYPE_QUEUE** and **BPF_MAP_TYPE_STACK** map
+ *		types, the *flags* argument needs to be set to 0, but for other
+ *		map types, it may be specified as:
+ *
+ *		**BPF_F_LOCK**
+ *			Look up and delete the value of a spin-locked map
+ *			without returning the lock. This must be specified if
+ *			the elements contain a spinlock.
+ *
  *		The **BPF_MAP_TYPE_QUEUE** and **BPF_MAP_TYPE_STACK** map types
  *		implement this command as a "pop" operation, deleting the top
  *		element rather than one corresponding to *key*.
@@ -536,6 +545,10 @@ union bpf_iter_link_info {
  *		This command is only valid for the following map types:
  *		* **BPF_MAP_TYPE_QUEUE**
  *		* **BPF_MAP_TYPE_STACK**
+ *		* **BPF_MAP_TYPE_HASH**
+ *		* **BPF_MAP_TYPE_PERCPU_HASH**
+ *		* **BPF_MAP_TYPE_LRU_HASH**
+ *		* **BPF_MAP_TYPE_LRU_PERCPU_HASH**
  *
  *	Return
  *		Returns zero on success. On error, -1 is returned and *errno*
-- 
2.26.2

