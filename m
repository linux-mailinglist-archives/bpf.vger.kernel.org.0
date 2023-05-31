Return-Path: <bpf+bounces-1501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EF7717D95
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 13:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4F6281496
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 11:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE51C8C6;
	Wed, 31 May 2023 11:04:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B9BE60
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 11:04:55 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B02184
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 04:04:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6042d605dso41806355e9.2
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 04:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1685531070; x=1688123070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lred2PxYx4GdbO5IbKF9RW+4U/PYcdYtUTPt4+371kE=;
        b=Lmi4ppMVFTRyctLNbD17RsCaegpaU8IkyWeEynpImOzXCD54w+Lw1nD7lHgRlIoYZ7
         9kChN8KbEFQrRhh3TGqk1EWLeBMwYqKYqAOnw8TWzc6jWVgJLDh7eWgK3e6VhHpikw7g
         a4SfFoEwqmR/s7Mo/e+Fy3geBJuCKgLVFtki1yaKaJkriR1dG1qbYD6hthRwHIDQqOzE
         tjkFz0n3K1oXouIX70k/9woO0VjBz7C6bXl1cXKbl6nUIOQvQkJ6GYFYYaluGb52Tkhr
         SaV/p5GWZEwn9eE0JwKCnkhz4rIBRzYoIKE0dSA6LLmrnYoIKF9LfDsly8sQGX6R0WDJ
         L/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685531070; x=1688123070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lred2PxYx4GdbO5IbKF9RW+4U/PYcdYtUTPt4+371kE=;
        b=TR36c1Xn00hro/hw8OROYt+xj1e7SAVOIZOiPnVphSvRyWcJc+VBm+V/cGyGYgaUYf
         vMkWg3SzaZVLIxqjOpRKQL+lLE2i32msP6qR0h8moQwtF8UlUcFEsbYML+GL3n8pwwtv
         LWS+N0GRqiKMheIeL2R2ouGkE+5DpLRNTLh8B6//zzmuRINzd2B/5T3BIBBzxJckJfYg
         1dqm6d3jBtY2r0rpwQF8xNRPuOmSqn8/X0CD9F2bBmtcz7mO/G7Ss0WbEJ8xPdJeEUCG
         E4gnN+7N00NaZbdFPK6yXzH93KgyV6cTn3268E/i6ok2WDTMI+ZA2P+h7UuNJkmVVzPw
         9jIw==
X-Gm-Message-State: AC+VfDy3uigMe+X04J7eTXIBMIVVjq62BF/EGc1sK3hHd1lSDNIUiX5N
	tij61jvAniz/0nEWKKvZQND1HjhTJqEPWU2LfDuWIMs3
X-Google-Smtp-Source: ACHHUZ5d5c9/sJ5qMT8LcmCKG/XTmq4IqqmyTwHIhGyEhFvscWo5z5rWlgl6sKHck5YYfOyuiXqkFA==
X-Received: by 2002:a05:600c:b5a:b0:3f4:23b9:eed2 with SMTP id k26-20020a05600c0b5a00b003f423b9eed2mr3635909wmr.38.1685531070578;
        Wed, 31 May 2023 04:04:30 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id b9-20020adfe309000000b003079986fd71sm6536029wrj.88.2023.05.31.04.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 04:04:30 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Joe Stringer <joe@isovalent.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: test map pressure
Date: Wed, 31 May 2023 11:05:11 +0000
Message-Id: <20230531110511.64612-3-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531110511.64612-1-aspsk@isovalent.com>
References: <20230531110511.64612-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a new map test, map_pressure.c, which is checking the correctness of
map's raw_pressure values.

For maps for which the pressure equals to the current number of elements (only
such maps support the raw_pressure at the moment) the test upserts a number of
elements, checks the correctness of the pressure value, then deletes all the
elements and checks again that the pressure dropped down to zero.

The following map types are tested:

    * BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC
    * BPF_MAP_TYPE_PERCPU_HASH, BPF_F_NO_PREALLOC
    * BPF_MAP_TYPE_HASH,
    * BPF_MAP_TYPE_PERCPU_HASH,
    * BPF_MAP_TYPE_LRU_HASH
    * BPF_MAP_TYPE_LRU_PERCPU_HASH
    * BPF_MAP_TYPE_LPM_TRIE

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 .../selftests/bpf/map_tests/map_pressure.c    | 309 ++++++++++++++++++
 1 file changed, 309 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/map_tests/map_pressure.c

diff --git a/tools/testing/selftests/bpf/map_tests/map_pressure.c b/tools/testing/selftests/bpf/map_tests/map_pressure.c
new file mode 100644
index 000000000000..c34ae31aef4b
--- /dev/null
+++ b/tools/testing/selftests/bpf/map_tests/map_pressure.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Isovalent */
+
+#include <errno.h>
+#include <unistd.h>
+#include <pthread.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include <bpf_util.h>
+#include <test_maps.h>
+
+#define MAX_ENTRIES 4096
+#define N_THREADS 17
+
+#define MAX_MAP_KEY_SIZE (sizeof(struct bpf_lpm_trie_key) + 4)
+
+static void map_info(int map_fd, struct bpf_map_info *info)
+{
+	__u32 len = sizeof(*info);
+	int ret;
+
+	memset(info, 0, sizeof(*info));
+
+	ret = bpf_obj_get_info_by_fd(map_fd, info, &len);
+	CHECK(ret < 0, "bpf_obj_get_info_by_fd", "error: %s\n", strerror(errno));
+}
+
+static const char *map_type_to_s(__u32 type)
+{
+	switch (type) {
+	case BPF_MAP_TYPE_HASH:
+		return "HASH";
+	case BPF_MAP_TYPE_PERCPU_HASH:
+		return "PERCPU_HASH";
+	case BPF_MAP_TYPE_LRU_HASH:
+		return "LRU_HASH";
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+		return "LRU_PERCPU_HASH";
+	case BPF_MAP_TYPE_LPM_TRIE:
+		return "LPM_TRIE";
+	default:
+		return "<define-me>";
+	}
+}
+
+/* Map index -> map-type-specific-key */
+static void *map_key(__u32 type, __u32 i)
+{
+	static __thread __u8 key[MAX_MAP_KEY_SIZE];
+
+	if (type == BPF_MAP_TYPE_LPM_TRIE) {
+		/* prefixlen = 32, data[0..3] = i */
+		*(__u32 *)key = 32;
+		*(__u32 *)(key+4) = i;
+	} else {
+		*(__u32 *)key = i;
+	}
+	return key;
+}
+
+static __u32 map_count_elements(__u32 type, int map_fd)
+{
+	void *key = map_key(type, -1);
+	int n = 0;
+
+	while (!bpf_map_get_next_key(map_fd, key, key))
+		n++;
+	return n;
+}
+
+static void delete_all_elements(__u32 type, int map_fd)
+{
+	void *key = map_key(type, -1);
+	void *keys;
+	int n = 0;
+	int ret;
+
+	keys = calloc(MAX_MAP_KEY_SIZE, MAX_ENTRIES);
+	CHECK(!keys, "calloc", "error: %s\n", strerror(errno));
+
+	for (; !bpf_map_get_next_key(map_fd, key, key); n++)
+		memcpy(keys + n*MAX_MAP_KEY_SIZE, key, MAX_MAP_KEY_SIZE);
+
+	while (--n >= 0) {
+		ret = bpf_map_delete_elem(map_fd, keys + n*MAX_MAP_KEY_SIZE);
+		CHECK(ret < 0, "bpf_map_delete_elem", "error: %s\n", strerror(errno));
+	}
+}
+
+static bool is_lru(__u32 map_type)
+{
+	return map_type == BPF_MAP_TYPE_LRU_HASH ||
+	       map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH;
+}
+
+struct upsert_opts {
+	__u32 map_type;
+	int map_fd;
+	__u32 n;
+};
+
+static void *patch_map_thread(void *arg)
+{
+	struct upsert_opts *opts = arg;
+	void *key;
+	int val;
+	int ret;
+	int i;
+
+	for (i = 0; i < opts->n; i++) {
+		key = map_key(opts->map_type, i);
+		val = rand();
+		ret = bpf_map_update_elem(opts->map_fd, key, &val, 0);
+		CHECK(ret < 0, "bpf_map_update_elem", "error: %s\n", strerror(errno));
+	}
+	return NULL;
+}
+
+static void upsert_elements(struct upsert_opts *opts)
+{
+	pthread_t threads[N_THREADS];
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(threads); i++) {
+		ret = pthread_create(&i[threads], NULL, patch_map_thread, opts);
+		CHECK(ret != 0, "pthread_create", "error: %s\n", strerror(ret));
+	}
+
+	for (i = 0; i < ARRAY_SIZE(threads); i++) {
+		ret = pthread_join(i[threads], NULL);
+		CHECK(ret != 0, "pthread_join", "error: %s\n", strerror(ret));
+	}
+}
+
+static void __test_map_pressure(int map_fd)
+{
+	__u32 n = MAX_ENTRIES - 1000, current_elements;
+	struct upsert_opts opts = {
+		.map_fd = map_fd,
+		.n = n,
+	};
+	struct bpf_map_info info;
+
+	map_info(map_fd, &info);
+	opts.map_type = info.type;
+
+	/*
+	 * Upsert keys [0, n) under some competition: with random values from
+	 * N_THREADS threads
+	 */
+	upsert_elements(&opts);
+
+	/*
+	 * Raw pressure for all hashtable-based maps should be equal to the
+	 * number of elements present in the map. For non-lru maps this number
+	 * should be the number n of upserted elements. For lru maps some
+	 * elements might have been evicted. Check that all numbers make sense
+	 */
+	map_info(map_fd, &info);
+	current_elements = map_count_elements(info.type, map_fd);
+	if (!is_lru(info.type))
+		CHECK(n != current_elements, "map_count_elements",
+		      "current_elements(%u) != expected(%u)", current_elements, n);
+	CHECK(info.raw_pressure != current_elements, "map_pressure",
+	      "raw_pressure=%u, expected %u (map_type=%s,map_flags=%08x)\n",
+	      info.raw_pressure, current_elements, map_type_to_s(info.type), info.map_flags);
+
+	/*
+	 * Cleanup the map and check that all elements are actually gone and
+	 * that the map raw_pressure is back to 0 as well
+	 */
+	delete_all_elements(info.type, map_fd);
+	map_info(map_fd, &info);
+	current_elements = map_count_elements(info.type, map_fd);
+	CHECK(current_elements, "map_count_elements",
+	      "expected current_elements=0, got %u", current_elements);
+	CHECK(info.raw_pressure != 0, "map_pressure",
+	      "raw_pressure=%u, expected 0 (map_type=%s,map_flags=%08x)\n",
+	      info.raw_pressure, map_type_to_s(info.type), info.map_flags);
+
+	close(map_fd);
+}
+
+static int map_create_opts(__u32 type, const char *name,
+			   struct bpf_map_create_opts *map_opts,
+			   __u32 key_size, __u32 val_size)
+{
+	int map_fd;
+
+	map_fd = bpf_map_create(type, name, key_size, val_size, MAX_ENTRIES, map_opts);
+	CHECK(map_fd < 0, "bpf_map_create()", "error:%s (name=%s)\n",
+			strerror(errno), name);
+
+	return map_fd;
+}
+
+static int map_create(__u32 type, const char *name, struct bpf_map_create_opts *map_opts)
+{
+	return map_create_opts(type, name, map_opts, sizeof(int), sizeof(int));
+}
+
+static int create_hash(void)
+{
+	struct bpf_map_create_opts map_opts = {
+		.sz = sizeof(map_opts),
+		.map_flags = BPF_F_NO_PREALLOC,
+	};
+
+	return map_create(BPF_MAP_TYPE_HASH, "hash", &map_opts);
+}
+
+static int create_percpu_hash(void)
+{
+	struct bpf_map_create_opts map_opts = {
+		.sz = sizeof(map_opts),
+		.map_flags = BPF_F_NO_PREALLOC,
+	};
+
+	return map_create(BPF_MAP_TYPE_PERCPU_HASH, "percpu_hash", &map_opts);
+}
+
+static int create_hash_prealloc(void)
+{
+	return map_create(BPF_MAP_TYPE_HASH, "hash", NULL);
+}
+
+static int create_percpu_hash_prealloc(void)
+{
+	return map_create(BPF_MAP_TYPE_PERCPU_HASH, "percpu_hash_prealloc", NULL);
+}
+
+static int create_lru_hash(void)
+{
+	return map_create(BPF_MAP_TYPE_LRU_HASH, "lru_hash", NULL);
+}
+
+static int create_percpu_lru_hash(void)
+{
+	return map_create(BPF_MAP_TYPE_LRU_PERCPU_HASH, "lru_hash_percpu", NULL);
+}
+
+static int create_lpm_trie(void)
+{
+	struct bpf_map_create_opts map_opts = {
+		.sz = sizeof(map_opts),
+		.map_flags = BPF_F_NO_PREALLOC,
+	};
+	__u32 key_size = sizeof(struct bpf_lpm_trie_key) + 4;
+	__u32 val_size = sizeof(int);
+
+	return map_create_opts(BPF_MAP_TYPE_LPM_TRIE, "lpm_trie",
+			       &map_opts, key_size, val_size);
+}
+
+static void map_pressure_hash(void)
+{
+	__test_map_pressure(create_hash());
+	printf("test_%s:PASS\n", __func__);
+}
+
+static void map_pressure_percpu_hash(void)
+{
+	__test_map_pressure(create_percpu_hash());
+	printf("test_%s:PASS\n", __func__);
+}
+
+static void map_pressure_hash_prealloc(void)
+{
+	__test_map_pressure(create_hash_prealloc());
+	printf("test_%s:PASS\n", __func__);
+}
+
+static void map_pressure_percpu_hash_prealloc(void)
+{
+	__test_map_pressure(create_percpu_hash_prealloc());
+	printf("test_%s:PASS\n", __func__);
+}
+
+static void map_pressure_lru_hash(void)
+{
+	__test_map_pressure(create_lru_hash());
+	printf("test_%s:PASS\n", __func__);
+}
+
+static void map_pressure_percpu_lru_hash(void)
+{
+	__test_map_pressure(create_percpu_lru_hash());
+	printf("test_%s:PASS\n", __func__);
+}
+
+static void map_pressure_lpm_trie(void)
+{
+	__test_map_pressure(create_lpm_trie());
+	printf("test_%s:PASS\n", __func__);
+}
+
+void test_map_pressure(void)
+{
+	map_pressure_hash();
+	map_pressure_percpu_hash();
+	map_pressure_hash_prealloc();
+	map_pressure_percpu_hash_prealloc();
+	map_pressure_lru_hash();
+	map_pressure_percpu_lru_hash();
+	map_pressure_lpm_trie();
+}
-- 
2.34.1


