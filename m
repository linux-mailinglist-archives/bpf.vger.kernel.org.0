Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF103271C4
	for <lists+bpf@lfdr.de>; Sun, 28 Feb 2021 10:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhB1Jk7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Feb 2021 04:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhB1Jk5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Feb 2021 04:40:57 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D1CC06174A
        for <bpf@vger.kernel.org>; Sun, 28 Feb 2021 01:40:16 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f6so849569edd.12
        for <bpf@vger.kernel.org>; Sun, 28 Feb 2021 01:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+OgipFGzYg3Kn/9X9W/fi8sh8IUGgLFJ8MTth/cT/dU=;
        b=OM6RVMrJ2IBqyGlMQyFgGR++KuGdQm8BBdT6Cy3HII38QxrHQaRzCL9oOA0zCIcGcb
         4JaPaiC4B/vqMDRpSZTSlLOMmVePQCv4/NtwbmmOfDh8vjElr1fmmAjEnqD1asiLwJsU
         zeaNZumOd2fEavuHuDdS75uUEl/LnLbPfBGchrI3Ensc0wgK2v6Rfya87u+5dPJlsKzY
         8TUh5ertzCxt0u/bQ0Z6W1K2Q7SssFOCbt6lQja+75bAuHtXu5C3iuLDYQujz2f04hER
         UBTkd/B5l2Jmscpu3EOM9lYQRdLuK+xickudiUVR/iedLbJ0RDO6YgK00GGOdWsikVBz
         kfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+OgipFGzYg3Kn/9X9W/fi8sh8IUGgLFJ8MTth/cT/dU=;
        b=YUjFS1jQdp/ASUi6ahQoyeIZf3tjGSoANep4GyAaPwhWg/8jcu6OllGr2OxiLAtf7s
         8zrqeIPLvhdlvrXnY6boXUGSttB9Ei9z0bXS/Dv9zv9CUkqDyTnxaWLNcisCsDA0hESP
         DcDk3sA/W/odaBl+8bUkJA2P3nsOc76ajnCgabT6bqT4Xa3aQeEE0sXJVAwRWx9HAXse
         Z2H6WG6rQ5L11FrbR6o0GuHIPdZNdm9wcR6g3flHI1ey2dOfFje6Cu/KzU6CI8sqDFzk
         rEKMKbP09DguRUM3/jk4gXc81qW8yhWz7ZVIM+rSr+kvkpycpSv69ZdY+J9v0Aqr+0aH
         kf1g==
X-Gm-Message-State: AOAM532y+K7ed5DofREnpDUGiwx7ksVrasgnnJacLKsN35LnD1Nqd88b
        fHtngxmsROoGemrqbyR/xqW+YwJQM9c2v25AmZo55ktztTgwrTGnfcTkpYv7wpp5L5EY7KcOlWb
        DCrVZ9WH1IozVuuJJ9TnkbbOG6dowzh6EaHz6iollQBiO7UY9lPvwks6aNPNPPrMxXpUj+/hy
X-Google-Smtp-Source: ABdhPJzGXKybHTY/CycgUgkLZVbs27i6afJ8Ghh+WjlY20+4qYyrzh2WmEEL79UXubMER4YfjDtDJQ==
X-Received: by 2002:a05:6402:1c9c:: with SMTP id cy28mr11283711edb.275.1614505215250;
        Sun, 28 Feb 2021 01:40:15 -0800 (PST)
Received: from gmail.com (93-136-95-83.adsl.net.t-com.hr. [93.136.95.83])
        by smtp.gmail.com with ESMTPSA id s18sm11502694edc.21.2021.02.28.01.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 01:40:14 -0800 (PST)
Date:   Sun, 28 Feb 2021 10:40:14 +0100
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     bpf@vger.kernel.org
Cc:     juraj.vijtiuk@sartura.hr, luka.oreskovic@sartura.hr,
        luka.perkov@sartura.hr
Subject: [PATCH v2 bpf-next] bpf: add lookup_and_delete_elem support to
 hashtab
Message-ID: <YDtk/vr/lk62L4KP@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend the existing bpf_map_lookup_and_delete_elem() functionality to
hashtab maps, in addition to stacks and queues.
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
---
 include/linux/bpf.h                           |   2 +
 kernel/bpf/hashtab.c                          |  80 +++++
 kernel/bpf/syscall.c                          |  14 +-
 .../bpf/prog_tests/lookup_and_delete.c        | 283 ++++++++++++++++++
 .../bpf/progs/test_lookup_and_delete.c        |  26 ++
 tools/testing/selftests/bpf/test_lru_map.c    |   8 +
 tools/testing/selftests/bpf/test_maps.c       |  19 +-
 7 files changed, 430 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4c730863fa77..0bcc4f89af40 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -67,6 +67,8 @@ struct bpf_map_ops {
 	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
 	int (*map_lookup_batch)(struct bpf_map *map, const union bpf_attr *attr,
 				union bpf_attr __user *uattr);
+	int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key,
+					  void *value);
 	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
 					   const union bpf_attr *attr,
 					   union bpf_attr __user *uattr);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 330d721dd2af..8c3334d1b6b3 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1401,6 +1401,82 @@ static void htab_map_seq_show_elem(struct bpf_map *map, void *key,
 	rcu_read_unlock();
 }
 
+static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
+					     void *value, bool is_lru_map,
+					     bool is_percpu)
+{
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	u32 hash, key_size, value_size;
+	struct hlist_nulls_head *head;
+	int cpu, off = 0, ret;
+	struct htab_elem *l;
+	unsigned long flags;
+	void __percpu *pptr;
+	struct bucket *b;
+
+	key_size = map->key_size;
+	value_size = round_up(map->value_size, 8);
+
+	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	b = __select_bucket(htab, hash);
+	head = &b->head;
+
+	ret = htab_lock_bucket(htab, b, hash, &flags);
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
+			copy_map_value(map, value, l->key + round_up(key_size, 8));
+		}
+
+		hlist_nulls_del_rcu(&l->hash_node);
+		if (!is_lru_map)
+			free_htab_elem(htab, l);
+	} else
+		ret = -ENOENT;
+
+	htab_unlock_bucket(htab, b, hash, flags);
+
+	if (is_lru_map && l)
+		bpf_lru_push_free(&htab->lru, &l->lru_node);
+
+	return ret;
+}
+
+static int htab_map_lookup_and_delete_elem(struct bpf_map *map,
+					   void *key, void *value)
+{
+	return __htab_map_lookup_and_delete_elem(map, key, value, false, false);
+}
+
+static int htab_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
+						  void *key, void *value)
+{
+	return __htab_map_lookup_and_delete_elem(map, key, value, false, true);
+}
+
+static int htab_lru_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
+					       void *value)
+{
+	return __htab_map_lookup_and_delete_elem(map, key, value, true, false);
+}
+
+static int htab_lru_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
+						      void *key, void *value)
+{
+	return __htab_map_lookup_and_delete_elem(map, key, value, true, true);
+}
+
 static int
 __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 				   const union bpf_attr *attr,
@@ -1934,6 +2010,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_map_lookup_elem,
+	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
 	.map_update_elem = htab_map_update_elem,
 	.map_delete_elem = htab_map_delete_elem,
 	.map_gen_lookup = htab_map_gen_lookup,
@@ -1954,6 +2031,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_lru_map_lookup_elem,
+	.map_lookup_and_delete_elem = htab_lru_map_lookup_and_delete_elem,
 	.map_lookup_elem_sys_only = htab_lru_map_lookup_elem_sys,
 	.map_update_elem = htab_lru_map_update_elem,
 	.map_delete_elem = htab_lru_map_delete_elem,
@@ -2077,6 +2155,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_percpu_map_lookup_elem,
+	.map_lookup_and_delete_elem = htab_percpu_map_lookup_and_delete_elem,
 	.map_update_elem = htab_percpu_map_update_elem,
 	.map_delete_elem = htab_map_delete_elem,
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
@@ -2096,6 +2175,7 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_lru_percpu_map_lookup_elem,
+	.map_lookup_and_delete_elem = htab_lru_percpu_map_lookup_and_delete_elem,
 	.map_update_elem = htab_lru_percpu_map_update_elem,
 	.map_delete_elem = htab_lru_map_delete_elem,
 	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c859bc46d06c..2634aa4a2f37 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1495,7 +1495,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	value_size = map->value_size;
+	value_size = bpf_map_value_size(map);
 
 	err = -ENOMEM;
 	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
@@ -1505,6 +1505,18 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
 	    map->map_type == BPF_MAP_TYPE_STACK) {
 		err = map->ops->map_pop_elem(map, value);
+	} else if (map->map_type == BPF_MAP_TYPE_HASH ||
+		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
+		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
+		if (!bpf_map_is_dev_bound(map)) {
+			bpf_disable_instrumentation();
+			rcu_read_lock();
+			err = map->ops->map_lookup_and_delete_elem(map, key, value);
+			rcu_read_unlock();
+			bpf_enable_instrumentation();
+			maybe_wait_bpf_programs(map);
+		}
 	} else {
 		err = -ENOTSUPP;
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
new file mode 100644
index 000000000000..05123bbcdc1c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
@@ -0,0 +1,283 @@
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
+		if (CHECK(err, "bpf_map_update_elem", "failed\n"))
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
+		if (CHECK(err, "bpf_map_update_elem", "failed\n"))
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
+	if (CHECK(!skel, "test_lookup_and_delete__open", "failed\n"))
+		return NULL;
+
+	err = bpf_map__set_type(skel->maps.hash_map, map_type);
+	if (CHECK(err, "bpf_map__set_type", "failed\n"))
+		goto error;
+
+	err = test_lookup_and_delete__load(skel);
+	if (CHECK(err, "test_lookup_and_delete__load", "failed\n"))
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
+	if (CHECK(err, "test_lookup_and_delete__attach", "failed\n"))
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
+	if (CHECK(!skel, "setup_prog", "failed\n"))
+		return;
+
+	err = fill_values(map_fd);
+	if (CHECK(err, "fill_values", "failed\n"))
+		goto cleanup;
+
+	/* Lookup and delete element. */
+	key = 1;
+	err = bpf_map_lookup_and_delete_elem(map_fd, &key, &value);
+	if (CHECK(err, "bpf_map_lookup_and_delete_elem", "failed, errno=%d\n",
+		  errno))
+		goto cleanup;
+
+	/* Fetched value should match the initially set value. */
+	if (CHECK(value != START_VALUE, "bpf_map_lookup_and_delete_elem",
+		  "value=%lld\n", value))
+		goto cleanup;
+
+	/* Check that the entry is non existent. */
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (CHECK(!err, "bpf_map_lookup_elem", "succeded, should fail\n"))
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
+	if (CHECK(!skel, "setup_prog", "failed\n"))
+		return;
+
+	err = fill_values_percpu(map_fd);
+	if (CHECK(err, "fill_values_percpu", "failed\n"))
+		goto cleanup;
+
+	/* Lookup and delete element. */
+	key = 1;
+	err = bpf_map_lookup_and_delete_elem(map_fd, &key, value);
+	if (CHECK(err, "bpf_map_lookup_and_delete_elem", "failed, errno=%d\n",
+		  errno))
+		goto cleanup;
+
+	for (i = 0; i < nr_cpus; i++) {
+		if (bpf_percpu(value, i))
+			val = bpf_percpu(value, i);
+	}
+
+	/* Fetched value should match the initially set value. */
+	if (CHECK(val != START_VALUE, "bpf_map_lookup_and_delete_elem",
+		  "val=%lld\n", val))
+		goto cleanup;
+
+	/* Check that the entry is non existent. */
+	err = bpf_map_lookup_elem(map_fd, &key, value);
+	if (CHECK(!err, "bpf_map_lookup_elem", "succeded, should fail\n"))
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
+	if (CHECK(!skel, "setup_prog", "failed\n"))
+		return;
+
+	err = fill_values(map_fd);
+	if (CHECK(err, "fill_values", "failed\n"))
+		goto cleanup;
+
+	/* Insert new element at key=3, should reuse LRU element. */
+	key = 3;
+	err = trigger_tp(skel, key, NEW_VALUE);
+	if (CHECK(err, "trigger_tp", "failed"))
+		goto cleanup;
+
+	/* Lookup and delete element 3. */
+	err = bpf_map_lookup_and_delete_elem(map_fd, &key, &value);
+	if (CHECK(err, "bpf_map_lookup_and_delete_elem", "failed, errno=%d\n",
+		  errno))
+		goto cleanup;
+
+	/* Value should match the new value. */
+	if (CHECK(value != NEW_VALUE, "bpf_map_lookup_and_delete_elem",
+		  "value=%lld\n", value))
+		goto cleanup;
+
+	/* Check that entries 3 and 1 are non existent. */
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (CHECK(!err, "bpf_map_lookup_elem", "succeded, should fail\n"))
+		goto cleanup;
+
+	key = 1;
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (CHECK(!err, "bpf_map_lookup_elem", "succeded, should fail\n"))
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
+	if (CHECK(!skel, "setup_prog", "failed\n"))
+		return;
+
+	err = fill_values_percpu(map_fd);
+	if (CHECK(err, "fill_values_percpu", "failed\n"))
+		goto cleanup;
+
+	/* Insert new element at key=3, should reuse LRU element. */
+	key = 3;
+	err = trigger_tp(skel, key, NEW_VALUE);
+	if (CHECK(err, "trigger_tp", "failed"))
+		goto cleanup;
+
+	/* Lookup and delete element 3. */
+	err = bpf_map_lookup_and_delete_elem(map_fd, &key, &value);
+	if (CHECK(err, "bpf_map_lookup_and_delete_elem", "failed, errno=%d\n",
+		  errno))
+		goto cleanup;
+
+	for (i = 0; i < nr_cpus; i++) {
+		if (bpf_percpu(value, i))
+			val = bpf_percpu(value, i);
+	}
+
+	/* Value should match the new value. */
+	if (CHECK(val != NEW_VALUE, "bpf_map_lookup_and_delete_elem",
+		  "val=%lld\n", val))
+		goto cleanup;
+
+	/* Check that entries 3 and 1 are non existent. */
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (CHECK(!err, "bpf_map_lookup_elem", "succeded, should fail\n"))
+		goto cleanup;
+
+	key = 1;
+	err = bpf_map_lookup_elem(map_fd, &key, &value);
+	if (CHECK(!err, "bpf_map_lookup_elem", "succeded, should fail\n"))
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
index 000000000000..eb19de8bb415
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+__u32 set_pid;
+__u64 set_key;
+__u64 set_value;
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

