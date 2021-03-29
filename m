Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFBD34D0A6
	for <lists+bpf@lfdr.de>; Mon, 29 Mar 2021 14:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhC2M5z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 08:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhC2M5p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 08:57:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C58C061574
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 05:57:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h10so14064636edt.13
        for <bpf@vger.kernel.org>; Mon, 29 Mar 2021 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OIfOcNu5oxHJbcAc7u67mGvG7/XVrtAtT0DjT281GpA=;
        b=elXmjyFqeaq4BK0TwUCF2sbOA+2XINf3QdlmvLFLq0O3jRTyQONBeolr6nAB0z8TiL
         v9C2nFP2IjXst4yu8FXzrLGSyuIgKg868TbFnC2uGUd2Y8UZNntTOFDYac7nDS6CapXy
         fI7r1vrTm3e38Mmg9V8YyQuW+h3h9TT61Fb57x/INl8ptpmWkUgualj3vYgIqkTwaINI
         Tn/uU2+rZXEoiXp/mkwmTu1n4bBrI7twjNjQPDWQqmsCNOxiqmWAvVD4F7ng5qx3EXEQ
         1DCrYDyQ5eLzxSjCrjNkJvRb/eoPp7ZBIPB878K6ma8eDGmkRqYmT+tQRHStvjrwQiHc
         otAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OIfOcNu5oxHJbcAc7u67mGvG7/XVrtAtT0DjT281GpA=;
        b=IInstXuq9F7UQ53RHXX0ZQ5ZdaODGidag4j1rDUOwc1efk5lIOfp1clmtD9e6HGgIT
         65gZ1aZb8i3JfJtgjfLfqZK5iZc6TIfiaa/TpXQnJqZWxzVhBcspVzsgiyqhw8Vvk6ue
         n+TOho1yXz/MWtcPwENmsd7QEIV6CPQrC2Laf75WsX4cZeX8/cwDakbMY1MSqaJZs7OJ
         O3awAwI+nPiPNKdSiTKULAvMrNWdeRTAbpZuWPwNiQedLMapL7o77HtWTwj3yHpSDZdj
         MrYnbgs0iflQ3BFxYz0hQRdPcE8VN1NmUtsUokXxwsIrEAZ0PqVH8lXjt+hotqcJ0tlP
         4WPw==
X-Gm-Message-State: AOAM532pm9UrybkE+dqdWVtr/F0Twf5YiNf7UdmAuNrSpmdif1UraNFM
        gJ4ykcxGqnhvs+GJKfZV2aqY5TWwf3VywdSAGkg8OPDRzrlS8i9D3XeiPlPKfmhBS6A7wUKs0Jl
        3iVgZqpark3GMWyBQRoIFyttXvIVwfB6Bp/C3Tk2evV2PY4bll4Ek5fUjjQWNuJRIe7gaWrdz
X-Google-Smtp-Source: ABdhPJzs6jjknIklnwSu5wCjFNSyt167kij9WwkJqPd+/JaQVN0jyVMVTkaSDFm1jyoJ9oHCLo1DAg==
X-Received: by 2002:a05:6402:1853:: with SMTP id v19mr28152003edy.179.1617022663647;
        Mon, 29 Mar 2021 05:57:43 -0700 (PDT)
Received: from gmail.com (89-172-121-178.adsl.net.t-com.hr. [89.172.121.178])
        by smtp.gmail.com with ESMTPSA id da17sm9146757edb.83.2021.03.29.05.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:57:42 -0700 (PDT)
Date:   Mon, 29 Mar 2021 14:57:40 +0200
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     bpf@vger.kernel.org
Cc:     juraj.vijtiuk@sartura.hr, luka.oreskovic@sartura.hr,
        luka.perkov@sartura.hr, yhs@fb.com, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com
Subject: [PATCH v4 bpf-next] bpf: add lookup_and_delete_elem support to
 hashtab
Message-ID: <YGHOxEIA/k5vG/s5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend the existing bpf_map_lookup_and_delete_elem() functionality to
hashtab maps, in addition to stacks and queues.
Add bpf_map_lookup_and_delete_elem_flags() libbpf API in order to use
the BPF_F_LOCK flag.
Create a new hashtab bpf_map_ops function that does lookup and deletion
of the element under the same bucket lock and add the created map_ops to
bpf.h.
Add the appropriate test cases to 'maps' and 'lru_map' selftests
accompanied with new test_progs.

Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
---
v2: Add functionality for LRU/per-CPU, add test_progs tests.
v3: Add bpf_map_lookup_and_delete_elem_flags() and enable BPF_F_LOCK
flag, change CHECKs to ASSERT_OKs, initialize variables to 0.
v4: Fix the return value for unsupported map types.
---
 include/linux/bpf.h                           |   2 +
 kernel/bpf/hashtab.c                          |  97 ++++++
 kernel/bpf/syscall.c                          |  27 +-
 tools/lib/bpf/bpf.c                           |  13 +
 tools/lib/bpf/bpf.h                           |   2 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../bpf/prog_tests/lookup_and_delete.c        | 279 ++++++++++++++++++
 .../bpf/progs/test_lookup_and_delete.c        |  26 ++
 tools/testing/selftests/bpf/test_lru_map.c    |   8 +
 tools/testing/selftests/bpf/test_maps.c       |  19 +-
 10 files changed, 469 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9fdd839b418c..8af4bd7c7229 100644
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
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d7ebb12ffffc..0d2085ce9a38 100644
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
+	u32 hash, key_size, value_size;
+	struct hlist_nulls_head *head;
+	int cpu, off = 0, ret;
+	struct htab_elem *l;
+	unsigned long bflags;
+	void __percpu *pptr;
+	struct bucket *b;
+
+	if ((flags & ~BPF_F_LOCK) ||
+	    ((flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
+		return -EINVAL;
+
+	key_size = map->key_size;
+	value_size = round_up(map->value_size, 8);
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
+			pptr = htab_elem_get_ptr(l, key_size);
+			for_each_possible_cpu(cpu) {
+				bpf_long_memcpy(value + off,
+						per_cpu_ptr(pptr, cpu),
+						value_size);
+				off += value_size;
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
index 9603de81811a..e3851bafb603 100644
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
@@ -1494,24 +1497,40 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
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
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index bba48ff4c5c0..b7c2cc12034c 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -458,6 +458,19 @@ int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
 	return sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
 }
 
+int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key, void *value, __u64 flags)
+{
+	union bpf_attr attr;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.map_fd = fd;
+	attr.key = ptr_to_u64(key);
+	attr.value = ptr_to_u64(value);
+	attr.flags = flags;
+
+	return sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
+}
+
 int bpf_map_delete_elem(int fd, const void *key)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 875dde20d56e..4f758f8f50cd 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -124,6 +124,8 @@ LIBBPF_API int bpf_map_lookup_elem_flags(int fd, const void *key, void *value,
 					 __u64 flags);
 LIBBPF_API int bpf_map_lookup_and_delete_elem(int fd, const void *key,
 					      void *value);
+LIBBPF_API int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key,
+						    void *value, __u64 flags);
 LIBBPF_API int bpf_map_delete_elem(int fd, const void *key);
 LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
 LIBBPF_API int bpf_map_freeze(int fd);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f5990f7208ce..589dde8311e1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -132,6 +132,7 @@ LIBBPF_0.0.2 {
 		bpf_probe_prog_type;
 		bpf_map__resize;
 		bpf_map_lookup_elem_flags;
+		bpf_map_lookup_and_delete_elem_flags;
 		bpf_object__btf;
 		bpf_object__find_map_fd_by_name;
 		bpf_get_link_xdp_id;
diff --git a/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
new file mode 100644
index 000000000000..8ace0e4a2349
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <test_progs.h>
+#include "test_lookup_and_delete.skel.h"
+
+#define START_VALUE 1234
+#define NEW_VALUE 4321
+#define MAX_ENTRIES 2
+
+static int duration;
+static int nr_cpus;
+
+static int fill_values(int map_fd)
+{
+	__u64 key, value = START_VALUE;
+	int err;
+
+	for (key = 1; key < MAX_ENTRIES + 1; key++) {
+		err = bpf_map_update_elem(map_fd, &key, &value, BPF_NOEXIST);
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			return -1;
+	}
+
+	return 0;
+}
+
+static int fill_values_percpu(int map_fd)
+{
+	BPF_DECLARE_PERCPU(__u64, value);
+	int i, err;
+	u64 key;
+
+	for (i = 0; i < nr_cpus; i++)
+		bpf_percpu(value, i) = START_VALUE;
+
+	for (key = 1; key < MAX_ENTRIES + 1; key++) {
+		err = bpf_map_update_elem(map_fd, &key, value, BPF_NOEXIST);
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			return -1;
+	}
+
+	return 0;
+}
+
+static struct test_lookup_and_delete *setup_prog(enum bpf_map_type map_type,
+						 int *map_fd)
+{
+	struct test_lookup_and_delete *skel;
+	int err;
+
+	skel = test_lookup_and_delete__open();
+	if (!ASSERT_OK(!skel, "test_lookup_and_delete__open"))
+		return NULL;
+
+	err = bpf_map__set_type(skel->maps.hash_map, map_type);
+	if (!ASSERT_OK(err, "bpf_map__set_type"))
+		goto error;
+
+	err = test_lookup_and_delete__load(skel);
+	if (!ASSERT_OK(err, "test_lookup_and_delete__load"))
+		goto error;
+
+	*map_fd = bpf_map__fd(skel->maps.hash_map);
+	if (CHECK(*map_fd < 0, "bpf_map__fd", "failed\n"))
+		goto error;
+
+	return skel;
+
+error:
+	test_lookup_and_delete__destroy(skel);
+	return NULL;
+}
+
+/* Triggers BPF program that updates map with given key and value */
+static int trigger_tp(struct test_lookup_and_delete *skel, __u64 key,
+		      __u64 value)
+{
+	int err;
+
+	skel->bss->set_pid = getpid();
+	skel->bss->set_key = key;
+	skel->bss->set_value = value;
+
+	err = test_lookup_and_delete__attach(skel);
+	if (!ASSERT_OK(err, "test_lookup_and_delete__attach"))
+		return -1;
+
+	syscall(__NR_getpgid);
+
+	test_lookup_and_delete__detach(skel);
+
+	return 0;
+}
+
+static void test_lookup_and_delete_hash(void)
+{
+	struct test_lookup_and_delete *skel;
+	__u64 key, value;
+	int map_fd, err;
+
+	/* Setup program and fill the map. */
+	skel = setup_prog(BPF_MAP_TYPE_HASH, &map_fd);
+	if (!ASSERT_OK_PTR(skel, "setup_prog"))
+		return;
+
+	err = fill_values(map_fd);
+	if (!ASSERT_OK(err, "fill_values"))
+		goto cleanup;
+
+	/* Lookup and delete element. */
+	key = 1;
+	err = bpf_map_lookup_and_delete_elem(map_fd, &key, &value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
+		goto cleanup;
+
+	/* Fetched value should match the initially set value. */
+	if (CHECK(value != START_VALUE, "bpf_map_lookup_and_delete_elem",
+		  "unexpected value=%lld\n", value))
+		goto cleanup;
+
+	/* Check that the entry is non existent. */
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (!ASSERT_OK(!err, "bpf_map_lookup_elem"))
+		goto cleanup;
+
+cleanup:
+	test_lookup_and_delete__destroy(skel);
+}
+
+static void test_lookup_and_delete_percpu_hash(void)
+{
+	struct test_lookup_and_delete *skel;
+	BPF_DECLARE_PERCPU(__u64, value);
+	int map_fd, err, i;
+	__u64 key, val;
+
+	/* Setup program and fill the map. */
+	skel = setup_prog(BPF_MAP_TYPE_PERCPU_HASH, &map_fd);
+	if (!ASSERT_OK_PTR(skel, "setup_prog"))
+		return;
+
+	err = fill_values_percpu(map_fd);
+	if (!ASSERT_OK(err, "fill_values_percpu"))
+		goto cleanup;
+
+	/* Lookup and delete element. */
+	key = 1;
+	err = bpf_map_lookup_and_delete_elem(map_fd, &key, value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
+		goto cleanup;
+
+	for (i = 0; i < nr_cpus; i++) {
+		if (bpf_percpu(value, i))
+			val = bpf_percpu(value, i);
+	}
+
+	/* Fetched value should match the initially set value. */
+	if (CHECK(val != START_VALUE, "bpf_map_lookup_and_delete_elem",
+		  "unexpected value=%lld\n", val))
+		goto cleanup;
+
+	/* Check that the entry is non existent. */
+	err = bpf_map_lookup_elem(map_fd, &key, value);
+	if (!ASSERT_OK(!err, "bpf_map_lookup_elem"))
+		goto cleanup;
+
+cleanup:
+	test_lookup_and_delete__destroy(skel);
+}
+
+static void test_lookup_and_delete_lru_hash(void)
+{
+	struct test_lookup_and_delete *skel;
+	__u64 key, value;
+	int map_fd, err;
+
+	/* Setup program and fill the LRU map. */
+	skel = setup_prog(BPF_MAP_TYPE_LRU_HASH, &map_fd);
+	if (!ASSERT_OK_PTR(skel, "setup_prog"))
+		return;
+
+	err = fill_values(map_fd);
+	if (!ASSERT_OK(err, "fill_values"))
+		goto cleanup;
+
+	/* Insert new element at key=3, should reuse LRU element. */
+	key = 3;
+	err = trigger_tp(skel, key, NEW_VALUE);
+	if (!ASSERT_OK(err, "trigger_tp"))
+		goto cleanup;
+
+	/* Lookup and delete element 3. */
+	err = bpf_map_lookup_and_delete_elem(map_fd, &key, &value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
+		goto cleanup;
+
+	/* Value should match the new value. */
+	if (CHECK(value != NEW_VALUE, "bpf_map_lookup_and_delete_elem",
+		  "unexpected value=%lld\n", value))
+		goto cleanup;
+
+	/* Check that entries 3 and 1 are non existent. */
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (!ASSERT_OK(!err, "bpf_map_lookup_elem"))
+		goto cleanup;
+
+	key = 1;
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (!ASSERT_OK(!err, "bpf_map_lookup_elem"))
+		goto cleanup;
+
+cleanup:
+	test_lookup_and_delete__destroy(skel);
+}
+
+static void test_lookup_and_delete_lru_percpu_hash(void)
+{
+	struct test_lookup_and_delete *skel;
+	BPF_DECLARE_PERCPU(__u64, value);
+	int map_fd, err, i;
+	__u64 key, val;
+
+	/* Setup program and fill the LRU map. */
+	skel = setup_prog(BPF_MAP_TYPE_LRU_PERCPU_HASH, &map_fd);
+	if (!ASSERT_OK_PTR(skel, "setup_prog"))
+		return;
+
+	err = fill_values_percpu(map_fd);
+	if (!ASSERT_OK(err, "fill_values_percpu"))
+		goto cleanup;
+
+	/* Insert new element at key=3, should reuse LRU element. */
+	key = 3;
+	err = trigger_tp(skel, key, NEW_VALUE);
+	if (!ASSERT_OK(err, "trigger_tp"))
+		goto cleanup;
+
+	/* Lookup and delete element 3. */
+	err = bpf_map_lookup_and_delete_elem(map_fd, &key, &value);
+	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
+		goto cleanup;
+
+	for (i = 0; i < nr_cpus; i++) {
+		if (bpf_percpu(value, i))
+			val = bpf_percpu(value, i);
+	}
+
+	/* Value should match the new value. */
+	if (CHECK(val != NEW_VALUE, "bpf_map_lookup_and_delete_elem",
+		  "unexpected value=%lld\n", val))
+		goto cleanup;
+
+	/* Check that entries 3 and 1 are non existent. */
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (!ASSERT_OK(!err, "bpf_map_lookup_elem"))
+		goto cleanup;
+
+	key = 1;
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (!ASSERT_OK(!err, "bpf_map_lookup_elem"))
+		goto cleanup;
+
+cleanup:
+	test_lookup_and_delete__destroy(skel);
+}
+
+void test_lookup_and_delete(void)
+{
+	nr_cpus = bpf_num_possible_cpus();
+
+	if (test__start_subtest("lookup_and_delete"))
+		test_lookup_and_delete_hash();
+	if (test__start_subtest("lookup_and_delete_percpu"))
+		test_lookup_and_delete_percpu_hash();
+	if (test__start_subtest("lookup_and_delete_lru"))
+		test_lookup_and_delete_lru_hash();
+	if (test__start_subtest("lookup_and_delete_lru_percpu"))
+		test_lookup_and_delete_lru_percpu_hash();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c b/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
new file mode 100644
index 000000000000..3a193f42c7e7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+__u32 set_pid = 0;
+__u64 set_key = 0;
+__u64 set_value = 0;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 2);
+	__type(key, __u64);
+	__type(value, __u64);
+} hash_map SEC(".maps");
+
+SEC("tp/syscalls/sys_enter_getpgid")
+int bpf_lookup_and_delete_test(const void *ctx)
+{
+	if (set_pid == bpf_get_current_pid_tgid() >> 32)
+		bpf_map_update_elem(&hash_map, &set_key, &set_value, BPF_NOEXIST);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index 6a5349f9eb14..f33fb6de76bc 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -231,6 +231,14 @@ static void test_lru_sanity0(int map_type, int map_flags)
 	assert(bpf_map_lookup_elem(lru_map_fd, &key, value) == -1 &&
 	       errno == ENOENT);
 
+	/* lookup elem key=3 and delete it, than check it doesn't exist */
+	key = 1;
+	assert(!bpf_map_lookup_and_delete_elem(lru_map_fd, &key, &value));
+	assert(value[0] == 1234);
+
+	/* remove the same element from the expected map */
+	assert(!bpf_map_delete_elem(expected_map_fd, &key));
+
 	assert(map_equal(lru_map_fd, expected_map_fd));
 
 	close(expected_map_fd);
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 51adc42b2b40..dbd5f95e8bde 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -65,6 +65,13 @@ static void test_hashmap(unsigned int task, void *data)
 	assert(bpf_map_lookup_elem(fd, &key, &value) == 0 && value == 1234);
 
 	key = 2;
+	value = 1234;
+	/* Insert key=2 element. */
+	assert(bpf_map_update_elem(fd, &key, &value, BPF_ANY) == 0);
+
+	/* Check that key=2 matches the value and delete it */
+	assert(bpf_map_lookup_and_delete_elem(fd, &key, &value) == 0 && value == 1234);
+
 	/* Check that key=2 is not found. */
 	assert(bpf_map_lookup_elem(fd, &key, &value) == -1 && errno == ENOENT);
 
@@ -164,8 +171,18 @@ static void test_hashmap_percpu(unsigned int task, void *data)
 
 	key = 1;
 	/* Insert key=1 element. */
-	assert(!(expected_key_mask & key));
 	assert(bpf_map_update_elem(fd, &key, value, BPF_ANY) == 0);
+
+	/* Lookup and delete elem key=1 and check value. */
+	assert(bpf_map_lookup_and_delete_elem(fd, &key, value) == 0 &&
+	       bpf_percpu(value, 0) == 100);
+
+	for (i = 0; i < nr_cpus; i++)
+		bpf_percpu(value, i) = i + 100;
+
+	/* Insert key=1 element which should not exist. */
+	assert(!(expected_key_mask & key));
+	assert(bpf_map_update_elem(fd, &key, value, BPF_NOEXIST) == 0);
 	expected_key_mask |= key;
 
 	/* BPF_NOEXIST means add new element if it doesn't exist. */
-- 
2.26.2

