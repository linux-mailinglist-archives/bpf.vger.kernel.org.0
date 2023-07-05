Return-Path: <bpf+bounces-4075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9EB7488CF
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 18:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9386280A1E
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 16:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ADF125C2;
	Wed,  5 Jul 2023 16:01:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59865125CC
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 16:01:17 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46CC19BF
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 09:00:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so9401020f8f.2
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688572844; x=1691164844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ya3Sn6/VKvfFcfI64W03v6HOGsOp5aNbwr8qWmxPAi4=;
        b=Ooee/BdRHq68t0T9Qq9X0WemmCUZ/Qf+pPHlypbqjCc7y3hejttsLyPs04xB4Xigij
         xIUvQ3brVpqb5MLqy5bGPmQVbIJLCPGc/uPoOaBORX9DkBS2gPS38VSls0Vzf4iA7yVs
         hSbHxzvxilrT6MHMm7P4xRgcqrIb7wH4Jiek963inQlhYdyPupsvXHCFphF6XSp4p5Yo
         TjCIKAX4OAhcY7DLiZT6JHzJ8QOsxLqFYl6oq7XT5kSr6SrZttJu4w1tpw6VYGmjMCel
         AifJiKLjzKeOK4ffr2+9p/NyVmUJT8JHYFJ4Xt7GFWBVwYms7D4CMqLrE9y1DeXT4iAw
         fFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572844; x=1691164844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ya3Sn6/VKvfFcfI64W03v6HOGsOp5aNbwr8qWmxPAi4=;
        b=XPa50llxbabX8LZ6zJGM4rCjLDnWB1iwNt77esul6z6hPSRgHlH3oAK+W8XqnxLqlr
         /lCKkpPhXonCKsBqkrQr+7NW8KAFswRVbeMH/2oDRObpUwG/fPk8o70j6xxshCmKsBgU
         ibQxfgPjPBhfuMFW2qFpTRZWzcB9N2D486RixktlDpSCL0Pm8LmYKDak2TUZTIafLorq
         j+yVlW3KM4CYdoHn4eo8PjRBiwSXFZAu0ezm5QRVw5/Lct3nyGC2tS8nfemMpRbujx6B
         ZTp7OE+0eEgIYn/Cc0JPwO2g+dXXF8HLFtaWk64HRIcgkym+Kt/N22VQDnYwWjrGnIVo
         VxBg==
X-Gm-Message-State: ABy/qLaDhMNLXvelK5/8/U4tPRmwGChzaap5ffv4jNBzEvJsJBjRYcfQ
	p1rin+cGFOXIqD9r++m2R0xvnQ==
X-Google-Smtp-Source: APBJJlEIWq9VJcIKANTGGXWk+5wEGBXvE7Oj5vbylNKexbIcogmMlFBGi8zGFTXQqzAEeWvxu+lafQ==
X-Received: by 2002:adf:e4c1:0:b0:314:37ac:c896 with SMTP id v1-20020adfe4c1000000b0031437acc896mr12488028wrm.44.1688572843766;
        Wed, 05 Jul 2023 09:00:43 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00314172ba213sm16861950wrn.108.2023.07.05.09.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 09:00:43 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v4 bpf-next 5/6] selftests/bpf: test map percpu stats
Date: Wed,  5 Jul 2023 16:01:38 +0000
Message-Id: <20230705160139.19967-6-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705160139.19967-1-aspsk@isovalent.com>
References: <20230705160139.19967-1-aspsk@isovalent.com>
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

Add a new map test, map_percpu_stats.c, which is checking the correctness of
map's percpu elements counters.  For supported maps the test upserts a number
of elements, checks the correctness of the counters, then deletes all the
elements and checks again that the counters sum drops down to zero.

The following map types are tested:

    * BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC
    * BPF_MAP_TYPE_PERCPU_HASH, BPF_F_NO_PREALLOC
    * BPF_MAP_TYPE_HASH,
    * BPF_MAP_TYPE_PERCPU_HASH,
    * BPF_MAP_TYPE_LRU_HASH
    * BPF_MAP_TYPE_LRU_PERCPU_HASH
    * BPF_MAP_TYPE_LRU_HASH, BPF_F_NO_COMMON_LRU
    * BPF_MAP_TYPE_LRU_PERCPU_HASH, BPF_F_NO_COMMON_LRU
    * BPF_MAP_TYPE_HASH_OF_MAPS

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 .../bpf/map_tests/map_percpu_stats.c          | 450 ++++++++++++++++++
 .../selftests/bpf/progs/map_percpu_stats.c    |  24 +
 2 files changed, 474 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_percpu_stats.c

diff --git a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
new file mode 100644
index 000000000000..37df564d9604
--- /dev/null
+++ b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
@@ -0,0 +1,450 @@
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
+#include "map_percpu_stats.skel.h"
+
+#define MAX_ENTRIES			16384
+#define MAX_ENTRIES_HASH_OF_MAPS	64
+#define N_THREADS			8
+#define MAX_MAP_KEY_SIZE		4
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
+	default:
+		return "<define-me>";
+	}
+}
+
+static __u32 map_count_elements(__u32 type, int map_fd)
+{
+	__u32 key = -1;
+	int n = 0;
+
+	while (!bpf_map_get_next_key(map_fd, &key, &key))
+		n++;
+	return n;
+}
+
+#define BATCH	true
+
+static void delete_and_lookup_batch(int map_fd, void *keys, __u32 count)
+{
+	static __u8 values[(8 << 10) * MAX_ENTRIES];
+	void *in_batch = NULL, *out_batch;
+	__u32 save_count = count;
+	int ret;
+
+	ret = bpf_map_lookup_and_delete_batch(map_fd,
+					      &in_batch, &out_batch,
+					      keys, values, &count,
+					      NULL);
+
+	/*
+	 * Despite what uapi header says, lookup_and_delete_batch will return
+	 * -ENOENT in case we successfully have deleted all elements, so check
+	 * this separately
+	 */
+	CHECK(ret < 0 && (errno != ENOENT || !count), "bpf_map_lookup_and_delete_batch",
+		       "error: %s\n", strerror(errno));
+
+	CHECK(count != save_count,
+			"bpf_map_lookup_and_delete_batch",
+			"deleted not all elements: removed=%u expected=%u\n",
+			count, save_count);
+}
+
+static void delete_all_elements(__u32 type, int map_fd, bool batch)
+{
+	static __u8 val[8 << 10]; /* enough for 1024 CPUs */
+	__u32 key = -1;
+	void *keys;
+	__u32 i, n;
+	int ret;
+
+	keys = calloc(MAX_MAP_KEY_SIZE, MAX_ENTRIES);
+	CHECK(!keys, "calloc", "error: %s\n", strerror(errno));
+
+	for (n = 0; !bpf_map_get_next_key(map_fd, &key, &key); n++)
+		memcpy(keys + n*MAX_MAP_KEY_SIZE, &key, MAX_MAP_KEY_SIZE);
+
+	if (batch) {
+		/* Can't mix delete_batch and delete_and_lookup_batch because
+		 * they have different semantics in relation to the keys
+		 * argument. However, delete_batch utilize map_delete_elem,
+		 * so we actually test it in non-batch scenario */
+		delete_and_lookup_batch(map_fd, keys, n);
+	} else {
+		/* Intentionally mix delete and lookup_and_delete so we can test both */
+		for (i = 0; i < n; i++) {
+			void *keyp = keys + i*MAX_MAP_KEY_SIZE;
+
+			if (i % 2 || type == BPF_MAP_TYPE_HASH_OF_MAPS) {
+				ret = bpf_map_delete_elem(map_fd, keyp);
+				CHECK(ret < 0, "bpf_map_delete_elem",
+					       "error: key %u: %s\n", i, strerror(errno));
+			} else {
+				ret = bpf_map_lookup_and_delete_elem(map_fd, keyp, val);
+				CHECK(ret < 0, "bpf_map_lookup_and_delete_elem",
+					       "error: key %u: %s\n", i, strerror(errno));
+			}
+		}
+	}
+
+	free(keys);
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
+static int create_small_hash(void)
+{
+	int map_fd;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_HASH, "small", 4, 4, 4, NULL);
+	CHECK(map_fd < 0, "bpf_map_create()", "error:%s (name=%s)\n",
+			strerror(errno), "small");
+
+	return map_fd;
+}
+
+static void *patch_map_thread(void *arg)
+{
+	struct upsert_opts *opts = arg;
+	int val;
+	int ret;
+	int i;
+
+	for (i = 0; i < opts->n; i++) {
+		if (opts->map_type == BPF_MAP_TYPE_HASH_OF_MAPS)
+			val = create_small_hash();
+		else
+			val = rand();
+		ret = bpf_map_update_elem(opts->map_fd, &i, &val, 0);
+		CHECK(ret < 0, "bpf_map_update_elem", "key=%d error: %s\n", i, strerror(errno));
+
+		if (opts->map_type == BPF_MAP_TYPE_HASH_OF_MAPS)
+			close(val);
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
+static __u32 read_cur_elements(int iter_fd)
+{
+	char buf[64];
+	ssize_t n;
+	__u32 ret;
+
+	n = read(iter_fd, buf, sizeof(buf)-1);
+	CHECK(n <= 0, "read", "error: %s\n", strerror(errno));
+	buf[n] = '\0';
+
+	errno = 0;
+	ret = (__u32)strtol(buf, NULL, 10);
+	CHECK(errno != 0, "strtol", "error: %s\n", strerror(errno));
+
+	return ret;
+}
+
+static __u32 get_cur_elements(int map_id)
+{
+	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	struct map_percpu_stats *skel;
+	struct bpf_link *link;
+	__u32 n_elements;
+	int iter_fd;
+	int ret;
+
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	skel = map_percpu_stats__open();
+	CHECK(skel == NULL, "map_percpu_stats__open", "error: %s", strerror(errno));
+
+	skel->bss->target_id = map_id;
+
+	ret = map_percpu_stats__load(skel);
+	CHECK(ret != 0, "map_percpu_stats__load", "error: %s", strerror(errno));
+
+	link = bpf_program__attach_iter(skel->progs.dump_bpf_map, &opts);
+	CHECK(!link, "bpf_program__attach_iter", "error: %s\n", strerror(errno));
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	CHECK(iter_fd < 0, "bpf_iter_create", "error: %s\n", strerror(errno));
+
+	n_elements = read_cur_elements(iter_fd);
+
+	close(iter_fd);
+	bpf_link__destroy(link);
+	map_percpu_stats__destroy(skel);
+
+	return n_elements;
+}
+
+static void check_expected_number_elements(__u32 n_inserted, int map_fd,
+					   struct bpf_map_info *info)
+{
+	__u32 n_real;
+	__u32 n_iter;
+
+	/* Count the current number of elements in the map by iterating through
+	 * all the map keys via bpf_get_next_key
+	 */
+	n_real = map_count_elements(info->type, map_fd);
+
+	/* The "real" number of elements should be the same as the inserted
+	 * number of elements in all cases except LRU maps, where some elements
+	 * may have been evicted
+	 */
+	if (n_inserted == 0 || !is_lru(info->type))
+		CHECK(n_inserted != n_real, "map_count_elements",
+		      "n_real(%u) != n_inserted(%u)\n", n_real, n_inserted);
+
+	/* Count the current number of elements in the map using an iterator */
+	n_iter = get_cur_elements(info->id);
+
+	/* Both counts should be the same, as all updates are over */
+	CHECK(n_iter != n_real, "get_cur_elements",
+	      "n_iter=%u, expected %u (map_type=%s,map_flags=%08x)\n",
+	      n_iter, n_real, map_type_to_s(info->type), info->map_flags);
+}
+
+static void __test(int map_fd)
+{
+	struct upsert_opts opts = {
+		.map_fd = map_fd,
+	};
+	struct bpf_map_info info;
+
+	map_info(map_fd, &info);
+	opts.map_type = info.type;
+	opts.n = info.max_entries;
+
+	/* Reduce the number of elements we are updating such that we don't
+	 * bump into -E2BIG from non-preallocated hash maps, but still will
+	 * have some evictions for LRU maps  */
+	if (opts.map_type != BPF_MAP_TYPE_HASH_OF_MAPS)
+		opts.n -= 512;
+	else
+		opts.n /= 2;
+
+	/*
+	 * Upsert keys [0, n) under some competition: with random values from
+	 * N_THREADS threads. Check values, then delete all elements and check
+	 * values again.
+	 */
+	upsert_elements(&opts);
+	check_expected_number_elements(opts.n, map_fd, &info);
+	delete_all_elements(info.type, map_fd, !BATCH);
+	check_expected_number_elements(0, map_fd, &info);
+
+	/* Now do the same, but using batch delete operations */
+	upsert_elements(&opts);
+	check_expected_number_elements(opts.n, map_fd, &info);
+	delete_all_elements(info.type, map_fd, BATCH);
+	check_expected_number_elements(0, map_fd, &info);
+
+	close(map_fd);
+}
+
+static int map_create_opts(__u32 type, const char *name,
+			   struct bpf_map_create_opts *map_opts,
+			   __u32 key_size, __u32 val_size)
+{
+	int max_entries;
+	int map_fd;
+
+	if (type == BPF_MAP_TYPE_HASH_OF_MAPS)
+		max_entries = MAX_ENTRIES_HASH_OF_MAPS;
+	else
+		max_entries = MAX_ENTRIES;
+
+	map_fd = bpf_map_create(type, name, key_size, val_size, max_entries, map_opts);
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
+static int create_lru_hash(__u32 type, __u32 map_flags)
+{
+	struct bpf_map_create_opts map_opts = {
+		.sz = sizeof(map_opts),
+		.map_flags = map_flags,
+	};
+
+	return map_create(type, "lru_hash", &map_opts);
+}
+
+static int create_hash_of_maps(void)
+{
+	struct bpf_map_create_opts map_opts = {
+		.sz = sizeof(map_opts),
+		.map_flags = BPF_F_NO_PREALLOC,
+		.inner_map_fd = create_small_hash(),
+	};
+	int ret;
+
+	ret = map_create_opts(BPF_MAP_TYPE_HASH_OF_MAPS, "hash_of_maps",
+			      &map_opts, sizeof(int), sizeof(int));
+	close(map_opts.inner_map_fd);
+	return ret;
+}
+
+static void map_percpu_stats_hash(void)
+{
+	__test(create_hash());
+	printf("test_%s:PASS\n", __func__);
+}
+
+static void map_percpu_stats_percpu_hash(void)
+{
+	__test(create_percpu_hash());
+	printf("test_%s:PASS\n", __func__);
+}
+
+static void map_percpu_stats_hash_prealloc(void)
+{
+	__test(create_hash_prealloc());
+	printf("test_%s:PASS\n", __func__);
+}
+
+static void map_percpu_stats_percpu_hash_prealloc(void)
+{
+	__test(create_percpu_hash_prealloc());
+	printf("test_%s:PASS\n", __func__);
+}
+
+static void map_percpu_stats_lru_hash(void)
+{
+	__test(create_lru_hash(BPF_MAP_TYPE_LRU_HASH, 0));
+	printf("test_%s:PASS\n", __func__);
+}
+
+static void map_percpu_stats_lru_hash_no_common(void)
+{
+	__test(create_lru_hash(BPF_MAP_TYPE_LRU_HASH, BPF_F_NO_COMMON_LRU));
+	printf("test_%s:PASS\n", __func__);
+}
+
+static void map_percpu_stats_percpu_lru_hash(void)
+{
+	__test(create_lru_hash(BPF_MAP_TYPE_LRU_PERCPU_HASH, 0));
+	printf("test_%s:PASS\n", __func__);
+}
+
+static void map_percpu_stats_percpu_lru_hash_no_common(void)
+{
+	__test(create_lru_hash(BPF_MAP_TYPE_LRU_PERCPU_HASH, BPF_F_NO_COMMON_LRU));
+	printf("test_%s:PASS\n", __func__);
+}
+
+static void map_percpu_stats_hash_of_maps(void)
+{
+	__test(create_hash_of_maps());
+	printf("test_%s:PASS\n", __func__);
+}
+
+void test_map_percpu_stats(void)
+{
+	map_percpu_stats_hash();
+	map_percpu_stats_percpu_hash();
+	map_percpu_stats_hash_prealloc();
+	map_percpu_stats_percpu_hash_prealloc();
+	map_percpu_stats_lru_hash();
+	map_percpu_stats_lru_hash_no_common();
+	map_percpu_stats_percpu_lru_hash();
+	map_percpu_stats_percpu_lru_hash_no_common();
+	map_percpu_stats_hash_of_maps();
+}
diff --git a/tools/testing/selftests/bpf/progs/map_percpu_stats.c b/tools/testing/selftests/bpf/progs/map_percpu_stats.c
new file mode 100644
index 000000000000..10b2325c1720
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/map_percpu_stats.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+__u32 target_id;
+
+__s64 bpf_map_sum_elem_count(struct bpf_map *map) __ksym;
+
+SEC("iter/bpf_map")
+int dump_bpf_map(struct bpf_iter__bpf_map *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct bpf_map *map = ctx->map;
+
+	if (map && map->id == target_id)
+		BPF_SEQ_PRINTF(seq, "%lld", bpf_map_sum_elem_count(map));
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


