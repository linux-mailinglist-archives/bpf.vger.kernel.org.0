Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128FF3737BA
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 11:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhEEJml (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 05:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhEEJmk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 05:42:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A6AC061574
        for <bpf@vger.kernel.org>; Wed,  5 May 2021 02:41:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gx5so1784981ejb.11
        for <bpf@vger.kernel.org>; Wed, 05 May 2021 02:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMT1vNIMte/iWBmo3qQZuRvYGjSr1+jRg9ifWgit8wM=;
        b=kofbh9gvPK7TqT9EfS8qWPvcKQp6c2yMiOq07aliXXI1JChTopcDNFZBcjpXiTZkFZ
         j/lxTkumqdgYwCot70eh96dma84/eTJ4EnuvHjH4Nib/RA/O1m5BCfzJi6nzKNJaA27F
         /SR9cxdwkazHfziS5j+gq3xxHX2dipNAPSnk1cSlwSh6yPpJRGCxRQ3+R1SbIIxGtlJD
         OK01gaSK31UpBDJp0AdlCJnHQhKcnqzXt1WuPhoKsHR9NBEKzLmYh/vCoJ66HDxzELDn
         5Tp5AGs25ONd7lRpQnPMykrVM+39X0ajRv78b77eTtJhQa3mH8/8NBkuwxV0AcCcKsib
         Omcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMT1vNIMte/iWBmo3qQZuRvYGjSr1+jRg9ifWgit8wM=;
        b=dyNQIad5Aa0rkJaFHKyszjDtOLmxK8wwYA/CBIhb+p5V5y1dcxcMZeUEgNMoQ7yW+D
         tEmDiXV9oSgkdclzEG09SOUu1iVgfoavY7VbZaM/V3lAJ/eMScDzX2V8VY9xitK+1bu9
         AU/4WsgEFUSH+kT4PNN0CdRhodZyK9LFQRbz6q1QwLhQTjf8H9QD8gugMlL/OochGK+L
         hUb/J9qg7FdqoSIyhpzRp1xE//CD7zicz6WCqUjwhBuPq69kpNlzyDRYObIr6gFmZh4W
         lx8LZfSZu7OEBT+fiHmae1hVA0POslONzYle2dnYabRtXDiduV9uQCA8Vhr56GLW3YnV
         j8Iw==
X-Gm-Message-State: AOAM531ptN1Yb+54GJ++WQMBEeRi96MLCb+5DuhX4Hocfj0wbMlcsVcF
        LYhIecE3cRSHn2T3AeVk9EorYEfRjdBGgIjUuNWeulv7bwpyNvkBhcfUMOVHBWz+GcqsRDYPACu
        bQ0vh1eTkoY8p+BwUsuki8RpwAiUSc3wIY6MbCkxfqFZiSU4rQwJ5338zPz9RkvaW8TIg7n43
X-Google-Smtp-Source: ABdhPJxc44ejEEDvzkFTknyjJGiktboEp3VPqM4CMYV1I59SF2bInHjfld3kXSWEiP6cANqcOaBYlw==
X-Received: by 2002:a17:906:5c52:: with SMTP id c18mr27106022ejr.354.1620207702173;
        Wed, 05 May 2021 02:41:42 -0700 (PDT)
Received: from localhost.localdomain (93-136-23-177.adsl.net.t-com.hr. [93.136.23.177])
        by smtp.gmail.com with ESMTPSA id e12sm2599975ejk.99.2021.05.05.02.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 02:41:41 -0700 (PDT)
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     bpf@vger.kernel.org
Cc:     Denis Salopek <denis.salopek@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 1/3] bpf: add lookup_and_delete_elem support to hashtab
Date:   Wed,  5 May 2021 11:40:26 +0200
Message-Id: <20210505094028.22079-1-denis.salopek@sartura.hr>
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
v6: Remove unneeded flag check, minor code/format fixes.
---
 include/linux/bpf.h            |  2 +
 include/uapi/linux/bpf.h       | 13 +++++
 kernel/bpf/hashtab.c           | 97 ++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           | 34 ++++++++++--
 tools/include/uapi/linux/bpf.h | 13 +++++
 5 files changed, 155 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 02b02cb29ce2..9da98d98db25 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -69,6 +69,8 @@ struct bpf_map_ops {
 	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
 	int (*map_lookup_batch)(struct bpf_map *map, const union bpf_attr *attr,
 				union bpf_attr __user *uattr);
+	int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key,
+					  void *value, u64 flags);
 	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
 					   const union bpf_attr *attr,
 					   union bpf_attr __user *uattr);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ec6d85a81744..c10ba06af69e 100644
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
index d7ebb12ffffc..d68d403795e4 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1401,6 +1401,99 @@ static void htab_map_seq_show_elem(struct bpf_map *map, void *key,
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
+	if (!l) {
+		ret = -ENOENT;
+	} else {
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
+			u32 roundup_key_size = round_up(map->key_size, 8);
+			if (flags & BPF_F_LOCK)
+				copy_map_value_locked(map, value, l->key +
+						      roundup_key_size,
+						      true);
+			else
+				copy_map_value(map, value, l->key +
+					       roundup_key_size);
+			check_and_init_map_lock(map, value);
+		}
+
+		hlist_nulls_del_rcu(&l->hash_node);
+		if (!is_lru_map)
+			free_htab_elem(htab, l);
+	}
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
@@ -1934,6 +2027,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_map_lookup_elem,
+	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
 	.map_update_elem = htab_map_update_elem,
 	.map_delete_elem = htab_map_delete_elem,
 	.map_gen_lookup = htab_map_gen_lookup,
@@ -1954,6 +2048,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_lru_map_lookup_elem,
+	.map_lookup_and_delete_elem = htab_lru_map_lookup_and_delete_elem,
 	.map_lookup_elem_sys_only = htab_lru_map_lookup_elem_sys,
 	.map_update_elem = htab_lru_map_update_elem,
 	.map_delete_elem = htab_lru_map_delete_elem,
@@ -2077,6 +2172,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_percpu_map_lookup_elem,
+	.map_lookup_and_delete_elem = htab_percpu_map_lookup_and_delete_elem,
 	.map_update_elem = htab_percpu_map_update_elem,
 	.map_delete_elem = htab_map_delete_elem,
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
@@ -2096,6 +2192,7 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_lru_percpu_map_lookup_elem,
+	.map_lookup_and_delete_elem = htab_lru_percpu_map_lookup_and_delete_elem,
 	.map_update_elem = htab_lru_percpu_map_update_elem,
 	.map_delete_elem = htab_lru_map_delete_elem,
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 941ca06d9dfa..d1c51da2f477 100644
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
@@ -1494,24 +1497,47 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
+	if (attr->flags &&
+	    (map->map_type == BPF_MAP_TYPE_QUEUE ||
+	     map->map_type == BPF_MAP_TYPE_STACK)) {
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
index ec6d85a81744..c10ba06af69e 100644
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

