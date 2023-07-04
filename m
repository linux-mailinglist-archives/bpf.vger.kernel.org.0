Return-Path: <bpf+bounces-3985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641AE747444
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 16:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D4E1C20AAF
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 14:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1B63BD;
	Tue,  4 Jul 2023 14:41:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF67814
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 14:41:20 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F93E49
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 07:41:17 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QwQSs67q5zqT2b;
	Tue,  4 Jul 2023 22:40:45 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 22:41:10 +0800
Subject: Re: [v3 PATCH bpf-next 5/6] selftests/bpf: test map percpu stats
To: Anton Protopopov <aspsk@isovalent.com>
References: <20230630082516.16286-1-aspsk@isovalent.com>
 <20230630082516.16286-6-aspsk@isovalent.com>
From: Hou Tao <houtao1@huawei.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, <bpf@vger.kernel.org>
Message-ID: <3e761472-051d-4e46-8a66-79926493e5db@huawei.com>
Date: Tue, 4 Jul 2023 22:41:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230630082516.16286-6-aspsk@isovalent.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/30/2023 4:25 PM, Anton Protopopov wrote:
> Add a new map test, map_percpu_stats.c, which is checking the correctness of
> map's percpu elements counters.  For supported maps the test upserts a number
> of elements, checks the correctness of the counters, then deletes all the
> elements and checks again that the counters sum drops down to zero.
>
> The following map types are tested:
>
>     * BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC
>     * BPF_MAP_TYPE_PERCPU_HASH, BPF_F_NO_PREALLOC
>     * BPF_MAP_TYPE_HASH,
>     * BPF_MAP_TYPE_PERCPU_HASH,
>     * BPF_MAP_TYPE_LRU_HASH
>     * BPF_MAP_TYPE_LRU_PERCPU_HASH

A test for BPF_MAP_TYPE_HASH_OF_MAPS is also needed.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  .../bpf/map_tests/map_percpu_stats.c          | 336 ++++++++++++++++++
>  .../selftests/bpf/progs/map_percpu_stats.c    |  24 ++
>  2 files changed, 360 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
>  create mode 100644 tools/testing/selftests/bpf/progs/map_percpu_stats.c
>
> diff --git a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
> new file mode 100644
> index 000000000000..5b45af230368
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Isovalent */
> +
> +#include <errno.h>
> +#include <unistd.h>
> +#include <pthread.h>
> +
> +#include <bpf/bpf.h>
> +#include <bpf/libbpf.h>
> +
> +#include <bpf_util.h>
> +#include <test_maps.h>
> +
> +#include "map_percpu_stats.skel.h"
> +
> +#define MAX_ENTRIES 16384
> +#define N_THREADS 37

Why 37 thread is needed here ? Does a small number of threads work as well ?
> +
> +#define MAX_MAP_KEY_SIZE 4
> +
> +static void map_info(int map_fd, struct bpf_map_info *info)
> +{
> +	__u32 len = sizeof(*info);
> +	int ret;
> +
> +	memset(info, 0, sizeof(*info));
> +
> +	ret = bpf_obj_get_info_by_fd(map_fd, info, &len);
> +	CHECK(ret < 0, "bpf_obj_get_info_by_fd", "error: %s\n", strerror(errno));
Please use ASSERT_OK instead.
> +}
> +
> +static const char *map_type_to_s(__u32 type)
> +{
> +	switch (type) {
> +	case BPF_MAP_TYPE_HASH:
> +		return "HASH";
> +	case BPF_MAP_TYPE_PERCPU_HASH:
> +		return "PERCPU_HASH";
> +	case BPF_MAP_TYPE_LRU_HASH:
> +		return "LRU_HASH";
> +	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
> +		return "LRU_PERCPU_HASH";
> +	default:
> +		return "<define-me>";
> +	}
> +}
> +
> +/* Map i -> map-type-specific-key */
> +static void *map_key(__u32 type, __u32 i)
> +{
> +	static __thread __u8 key[MAX_MAP_KEY_SIZE];

Why a per-thread key is necessary here ? Could we just define it when
the key is needed ?
> +
> +	*(__u32 *)key = i;
> +	return key;
> +}
> +
> +static __u32 map_count_elements(__u32 type, int map_fd)
> +{
> +	void *key = map_key(type, -1);
> +	int n = 0;
> +
> +	while (!bpf_map_get_next_key(map_fd, key, key))
> +		n++;
> +	return n;
> +}
> +
> +static void delete_all_elements(__u32 type, int map_fd)
> +{
> +	void *key = map_key(type, -1);
> +	void *keys;
> +	int n = 0;
> +	int ret;
> +
> +	keys = calloc(MAX_MAP_KEY_SIZE, MAX_ENTRIES);
> +	CHECK(!keys, "calloc", "error: %s\n", strerror(errno));
> +
> +	for (; !bpf_map_get_next_key(map_fd, key, key); n++)
> +		memcpy(keys + n*MAX_MAP_KEY_SIZE, key, MAX_MAP_KEY_SIZE);
> +
> +	while (--n >= 0) {
> +		ret = bpf_map_delete_elem(map_fd, keys + n*MAX_MAP_KEY_SIZE);
> +		CHECK(ret < 0, "bpf_map_delete_elem", "error: %s\n", strerror(errno));
> +	}
> +}

Please use ASSERT_xxx() to replace CHECK().
> +
> +static bool is_lru(__u32 map_type)
> +{
> +	return map_type == BPF_MAP_TYPE_LRU_HASH ||
> +	       map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH;
> +}
> +
> +struct upsert_opts {
> +	__u32 map_type;
> +	int map_fd;
> +	__u32 n;
> +};
> +
> +static void *patch_map_thread(void *arg)
> +{
> +	struct upsert_opts *opts = arg;
> +	void *key;
> +	int val;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < opts->n; i++) {
> +		key = map_key(opts->map_type, i);
> +		val = rand();
> +		ret = bpf_map_update_elem(opts->map_fd, key, &val, 0);
> +		CHECK(ret < 0, "bpf_map_update_elem", "error: %s\n", strerror(errno));
> +	}
> +	return NULL;
> +}
> +
> +static void upsert_elements(struct upsert_opts *opts)
> +{
> +	pthread_t threads[N_THREADS];
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(threads); i++) {
> +		ret = pthread_create(&i[threads], NULL, patch_map_thread, opts);
> +		CHECK(ret != 0, "pthread_create", "error: %s\n", strerror(ret));
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(threads); i++) {
> +		ret = pthread_join(i[threads], NULL);
> +		CHECK(ret != 0, "pthread_join", "error: %s\n", strerror(ret));
> +	}
> +}
> +
> +static __u32 read_cur_elements(int iter_fd)
> +{
> +	char buf[64];
> +	ssize_t n;
> +	__u32 ret;
> +
> +	n = read(iter_fd, buf, sizeof(buf)-1);
> +	CHECK(n <= 0, "read", "error: %s\n", strerror(errno));
> +	buf[n] = '\0';
> +
> +	errno = 0;
> +	ret = (__u32)strtol(buf, NULL, 10);
> +	CHECK(errno != 0, "strtol", "error: %s\n", strerror(errno));
> +
> +	return ret;
> +}
> +
> +static __u32 get_cur_elements(int map_id)
> +{
> +	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	union bpf_iter_link_info linfo;
> +	struct map_percpu_stats *skel;
> +	struct bpf_link *link;
> +	int iter_fd;
> +	int ret;
> +
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	skel = map_percpu_stats__open();
> +	CHECK(skel == NULL, "map_percpu_stats__open", "error: %s", strerror(errno));
> +
> +	skel->bss->target_id = map_id;
> +
> +	ret = map_percpu_stats__load(skel);
> +	CHECK(ret != 0, "map_percpu_stats__load", "error: %s", strerror(errno));
> +
> +	link = bpf_program__attach_iter(skel->progs.dump_bpf_map, &opts);
> +	CHECK(!link, "bpf_program__attach_iter", "error: %s\n", strerror(errno));
> +
> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	CHECK(iter_fd < 0, "bpf_iter_create", "error: %s\n", strerror(errno));
> +
> +	return read_cur_elements(iter_fd);

Need to do close(iter_fd), bpf_link__destroy(link) and
map__percpu_stats__destroy() before return, otherwise there will be
resource leak.
> +}
> +
> +static void __test(int map_fd)
> +{
> +	__u32 n = MAX_ENTRIES - 1000;
> +	__u32 real_current_elements;
> +	__u32 iter_current_elements;
> +	struct upsert_opts opts = {
> +		.map_fd = map_fd,
> +		.n = n,
> +	};
> +	struct bpf_map_info info;
> +
> +	map_info(map_fd, &info);
> +	opts.map_type = info.type;
> +
> +	/*
> +	 * Upsert keys [0, n) under some competition: with random values from
> +	 * N_THREADS threads
> +	 */
> +	upsert_elements(&opts);
> +
> +	/*
> +	 * The sum of percpu elements counters for all hashtable-based maps
> +	 * should be equal to the number of elements present in the map. For
> +	 * non-lru maps this number should be the number n of upserted
> +	 * elements. For lru maps some elements might have been evicted. Check
> +	 * that all numbers make sense
> +	 */
> +	map_info(map_fd, &info);

I think there is no need to call map_info() multiple times because the
needed type and id will not be changed after creation.
> +	real_current_elements = map_count_elements(info.type, map_fd);
> +	if (!is_lru(info.type))
> +		CHECK(n != real_current_elements, "map_count_elements",
> +		      "real_current_elements(%u) != expected(%u)\n", real_current_elements, n);
For LRU map, please use ASSERT_EQ(). For LRU map, should we check "n >=
real_current_elements" instead ?
> +
> +	iter_current_elements = get_cur_elements(info.id);
> +	CHECK(iter_current_elements != real_current_elements, "get_cur_elements",
> +	      "iter_current_elements=%u, expected %u (map_type=%s,map_flags=%08x)\n",
> +	      iter_current_elements, real_current_elements, map_type_to_s(info.type), info.map_flags);
> +
> +	/*
> +	 * Cleanup the map and check that all elements are actually gone and
> +	 * that the sum of percpu elements counters is back to 0 as well
> +	 */
> +	delete_all_elements(info.type, map_fd);
> +	map_info(map_fd, &info);
> +	real_current_elements = map_count_elements(info.type, map_fd);
> +	CHECK(real_current_elements, "map_count_elements",
> +	      "expected real_current_elements=0, got %u", real_current_elements);

ASSERT_EQ
> +
> +	iter_current_elements = get_cur_elements(info.id);
> +	CHECK(iter_current_elements != 0, "get_cur_elements",
> +	      "iter_current_elements=%u, expected 0 (map_type=%s,map_flags=%08x)\n",
> +	      iter_current_elements, map_type_to_s(info.type), info.map_flags);
> +
ASSERT_NEQ
> +	close(map_fd);
> +}
> +
> +static int map_create_opts(__u32 type, const char *name,
> +			   struct bpf_map_create_opts *map_opts,
> +			   __u32 key_size, __u32 val_size)
> +{
> +	int map_fd;
> +
> +	map_fd = bpf_map_create(type, name, key_size, val_size, MAX_ENTRIES, map_opts);
> +	CHECK(map_fd < 0, "bpf_map_create()", "error:%s (name=%s)\n",
> +			strerror(errno), name);

Please use ASSERT_GE instead.
> +
> +	return map_fd;
> +}
> +
> +static int map_create(__u32 type, const char *name, struct bpf_map_create_opts *map_opts)
> +{
> +	return map_create_opts(type, name, map_opts, sizeof(int), sizeof(int));
> +}
> +
> +static int create_hash(void)
> +{
> +	struct bpf_map_create_opts map_opts = {
> +		.sz = sizeof(map_opts),
> +		.map_flags = BPF_F_NO_PREALLOC,
> +	};
> +
> +	return map_create(BPF_MAP_TYPE_HASH, "hash", &map_opts);
> +}
> +
> +static int create_percpu_hash(void)
> +{
> +	struct bpf_map_create_opts map_opts = {
> +		.sz = sizeof(map_opts),
> +		.map_flags = BPF_F_NO_PREALLOC,
> +	};
> +
> +	return map_create(BPF_MAP_TYPE_PERCPU_HASH, "percpu_hash", &map_opts);
> +}
> +
> +static int create_hash_prealloc(void)
> +{
> +	return map_create(BPF_MAP_TYPE_HASH, "hash", NULL);
> +}
> +
> +static int create_percpu_hash_prealloc(void)
> +{
> +	return map_create(BPF_MAP_TYPE_PERCPU_HASH, "percpu_hash_prealloc", NULL);
> +}
> +
> +static int create_lru_hash(void)
> +{
> +	return map_create(BPF_MAP_TYPE_LRU_HASH, "lru_hash", NULL);
> +}
> +
> +static int create_percpu_lru_hash(void)
> +{
> +	return map_create(BPF_MAP_TYPE_LRU_PERCPU_HASH, "lru_hash_percpu", NULL);
> +}
> +
> +static void map_percpu_stats_hash(void)
> +{
> +	__test(create_hash());
> +	printf("test_%s:PASS\n", __func__);
> +}
> +
> +static void map_percpu_stats_percpu_hash(void)
> +{
> +	__test(create_percpu_hash());
> +	printf("test_%s:PASS\n", __func__);
> +}
> +
> +static void map_percpu_stats_hash_prealloc(void)
> +{
> +	__test(create_hash_prealloc());
> +	printf("test_%s:PASS\n", __func__);
> +}
> +
> +static void map_percpu_stats_percpu_hash_prealloc(void)
> +{
> +	__test(create_percpu_hash_prealloc());
> +	printf("test_%s:PASS\n", __func__);
> +}
> +
> +static void map_percpu_stats_lru_hash(void)
> +{
> +	__test(create_lru_hash());
> +	printf("test_%s:PASS\n", __func__);
> +}
> +
> +static void map_percpu_stats_percpu_lru_hash(void)
> +{
> +	__test(create_percpu_lru_hash());
> +	printf("test_%s:PASS\n", __func__);

After switch to subtest, the printf() can be removed.
> +}
> +
> +void test_map_percpu_stats(void)
> +{
> +	map_percpu_stats_hash();
> +	map_percpu_stats_percpu_hash();
> +	map_percpu_stats_hash_prealloc();
> +	map_percpu_stats_percpu_hash_prealloc();
> +	map_percpu_stats_lru_hash();
> +	map_percpu_stats_percpu_lru_hash();
> +}

Please use test__start_subtest() to create multiple subtests.
> diff --git a/tools/testing/selftests/bpf/progs/map_percpu_stats.c b/tools/testing/selftests/bpf/progs/map_percpu_stats.c
> new file mode 100644
> index 000000000000..10b2325c1720
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/map_percpu_stats.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Isovalent */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +__u32 target_id;
> +
> +__s64 bpf_map_sum_elem_count(struct bpf_map *map) __ksym;
> +
> +SEC("iter/bpf_map")
> +int dump_bpf_map(struct bpf_iter__bpf_map *ctx)
> +{
> +	struct seq_file *seq = ctx->meta->seq;
> +	struct bpf_map *map = ctx->map;
> +
> +	if (map && map->id == target_id)
> +		BPF_SEQ_PRINTF(seq, "%lld", bpf_map_sum_elem_count(map));
> +
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";


