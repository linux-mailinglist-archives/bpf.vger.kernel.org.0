Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08A645CD42
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 20:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbhKXTf6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 24 Nov 2021 14:35:58 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17700 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244170AbhKXTf6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Nov 2021 14:35:58 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOErSO7010285
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 11:32:48 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3chqj1hv3u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 11:32:48 -0800
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 11:32:45 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9E019A81FA07; Wed, 24 Nov 2021 11:32:43 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 4/4] selftests/bpf: migrate selftests to bpf_map_create()
Date:   Wed, 24 Nov 2021 11:32:33 -0800
Message-ID: <20211124193233.3115996-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124193233.3115996-1-andrii@kernel.org>
References: <20211124193233.3115996-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: -33q0dKnOVSo14mB8gP9LhooBbnfyQq-
X-Proofpoint-GUID: -33q0dKnOVSo14mB8gP9LhooBbnfyQq-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_06,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=937
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111240100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Conversion is straightforward for most cases. In few cases tests are
using mutable map_flags and attribute structs, but bpf_map_create_opts
can be used in the similar fashion, so there were no problems. Just lots
of repetitive conversions.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/map_tests/array_map_batch_ops.c       |  13 +--
 .../bpf/map_tests/htab_map_batch_ops.c        |  13 +--
 .../bpf/map_tests/lpm_trie_map_batch_ops.c    |  15 +--
 .../selftests/bpf/map_tests/sk_storage_map.c  |  50 ++++----
 .../bpf/prog_tests/bloom_filter_map.c         |  36 +++---
 .../selftests/bpf/prog_tests/bpf_iter.c       |   8 +-
 tools/testing/selftests/bpf/prog_tests/btf.c  |  51 +++-----
 .../bpf/prog_tests/cgroup_attach_multi.c      |  12 +-
 .../selftests/bpf/prog_tests/pinning.c        |   4 +-
 .../selftests/bpf/prog_tests/ringbuf_multi.c  |   4 +-
 .../bpf/prog_tests/select_reuseport.c         |  21 +---
 .../selftests/bpf/prog_tests/sockmap_basic.c  |   4 +-
 .../selftests/bpf/prog_tests/sockmap_ktls.c   |   2 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c |   4 +-
 .../selftests/bpf/prog_tests/test_bpffs.c     |   2 +-
 .../selftests/bpf/test_cgroup_storage.c       |   8 +-
 tools/testing/selftests/bpf/test_lpm_map.c    |  27 +++--
 tools/testing/selftests/bpf/test_lru_map.c    |  16 +--
 tools/testing/selftests/bpf/test_maps.c       | 110 +++++++++---------
 tools/testing/selftests/bpf/test_tag.c        |   5 +-
 tools/testing/selftests/bpf/test_verifier.c   |  52 ++++-----
 21 files changed, 201 insertions(+), 256 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
index f4d870da7684..78c76496b14a 100644
--- a/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
@@ -68,13 +68,6 @@ static void map_batch_verify(int *visited, __u32 max_entries, int *keys,
 
 static void __test_map_lookup_and_update_batch(bool is_pcpu)
 {
-	struct bpf_create_map_attr xattr = {
-		.name = "array_map",
-		.map_type = is_pcpu ? BPF_MAP_TYPE_PERCPU_ARRAY :
-				      BPF_MAP_TYPE_ARRAY,
-		.key_size = sizeof(int),
-		.value_size = sizeof(__s64),
-	};
 	int map_fd, *keys, *visited;
 	__u32 count, total, total_success;
 	const __u32 max_entries = 10;
@@ -86,10 +79,10 @@ static void __test_map_lookup_and_update_batch(bool is_pcpu)
 		.flags = 0,
 	);
 
-	xattr.max_entries = max_entries;
-	map_fd = bpf_create_map_xattr(&xattr);
+	map_fd = bpf_map_create(is_pcpu ? BPF_MAP_TYPE_PERCPU_ARRAY : BPF_MAP_TYPE_ARRAY,
+				"array_map", sizeof(int), sizeof(__s64), max_entries, NULL);
 	CHECK(map_fd == -1,
-	      "bpf_create_map_xattr()", "error:%s\n", strerror(errno));
+	      "bpf_map_create()", "error:%s\n", strerror(errno));
 
 	value_size = sizeof(__s64);
 	if (is_pcpu)
diff --git a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
index 976bf415fbdd..f807d53fd8dd 100644
--- a/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/htab_map_batch_ops.c
@@ -83,22 +83,15 @@ void __test_map_lookup_and_delete_batch(bool is_pcpu)
 	int err, step, value_size;
 	bool nospace_err;
 	void *values;
-	struct bpf_create_map_attr xattr = {
-		.name = "hash_map",
-		.map_type = is_pcpu ? BPF_MAP_TYPE_PERCPU_HASH :
-			    BPF_MAP_TYPE_HASH,
-		.key_size = sizeof(int),
-		.value_size = sizeof(int),
-	};
 	DECLARE_LIBBPF_OPTS(bpf_map_batch_opts, opts,
 		.elem_flags = 0,
 		.flags = 0,
 	);
 
-	xattr.max_entries = max_entries;
-	map_fd = bpf_create_map_xattr(&xattr);
+	map_fd = bpf_map_create(is_pcpu ? BPF_MAP_TYPE_PERCPU_HASH : BPF_MAP_TYPE_HASH,
+				"hash_map", sizeof(int), sizeof(int), max_entries, NULL);
 	CHECK(map_fd == -1,
-	      "bpf_create_map_xattr()", "error:%s\n", strerror(errno));
+	      "bpf_map_create()", "error:%s\n", strerror(errno));
 
 	value_size = is_pcpu ? sizeof(value) : sizeof(int);
 	keys = malloc(max_entries * sizeof(int));
diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
index 2e986e5e4cac..87d07b596e17 100644
--- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
@@ -64,13 +64,7 @@ static void map_batch_verify(int *visited, __u32 max_entries,
 
 void test_lpm_trie_map_batch_ops(void)
 {
-	struct bpf_create_map_attr xattr = {
-		.name = "lpm_trie_map",
-		.map_type = BPF_MAP_TYPE_LPM_TRIE,
-		.key_size = sizeof(struct test_lpm_key),
-		.value_size = sizeof(int),
-		.map_flags = BPF_F_NO_PREALLOC,
-	};
+	LIBBPF_OPTS(bpf_map_create_opts, create_opts, .map_flags = BPF_F_NO_PREALLOC);
 	struct test_lpm_key *keys, key;
 	int map_fd, *values, *visited;
 	__u32 step, count, total, total_success;
@@ -82,9 +76,10 @@ void test_lpm_trie_map_batch_ops(void)
 		.flags = 0,
 	);
 
-	xattr.max_entries = max_entries;
-	map_fd = bpf_create_map_xattr(&xattr);
-	CHECK(map_fd == -1, "bpf_create_map_xattr()", "error:%s\n",
+	map_fd = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, "lpm_trie_map",
+				sizeof(struct test_lpm_key), sizeof(int),
+				max_entries, &create_opts);
+	CHECK(map_fd == -1, "bpf_map_create()", "error:%s\n",
 	      strerror(errno));
 
 	keys = malloc(max_entries * sizeof(struct test_lpm_key));
diff --git a/tools/testing/selftests/bpf/map_tests/sk_storage_map.c b/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
index e569edc679d8..8eea4ffeb092 100644
--- a/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
+++ b/tools/testing/selftests/bpf/map_tests/sk_storage_map.c
@@ -19,16 +19,12 @@
 #include <test_btf.h>
 #include <test_maps.h>
 
-static struct bpf_create_map_attr xattr = {
-	.name = "sk_storage_map",
-	.map_type = BPF_MAP_TYPE_SK_STORAGE,
-	.map_flags = BPF_F_NO_PREALLOC,
-	.max_entries = 0,
-	.key_size = 4,
-	.value_size = 8,
+static struct bpf_map_create_opts map_opts = {
+	.sz = sizeof(map_opts),
 	.btf_key_type_id = 1,
 	.btf_value_type_id = 3,
 	.btf_fd = -1,
+	.map_flags = BPF_F_NO_PREALLOC,
 };
 
 static unsigned int nr_sk_threads_done;
@@ -150,13 +146,13 @@ static int create_sk_storage_map(void)
 	btf_fd = load_btf();
 	CHECK(btf_fd == -1, "bpf_load_btf", "btf_fd:%d errno:%d\n",
 	      btf_fd, errno);
-	xattr.btf_fd = btf_fd;
+	map_opts.btf_fd = btf_fd;
 
-	map_fd = bpf_create_map_xattr(&xattr);
-	xattr.btf_fd = -1;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_SK_STORAGE, "sk_storage_map", 4, 8, 0, &map_opts);
+	map_opts.btf_fd = -1;
 	close(btf_fd);
 	CHECK(map_fd == -1,
-	      "bpf_create_map_xattr()", "errno:%d\n", errno);
+	      "bpf_map_create()", "errno:%d\n", errno);
 
 	return map_fd;
 }
@@ -463,20 +459,20 @@ static void test_sk_storage_map_basic(void)
 		int cnt;
 		int lock;
 	} value = { .cnt = 0xeB9f, .lock = 0, }, lookup_value;
-	struct bpf_create_map_attr bad_xattr;
+	struct bpf_map_create_opts bad_xattr;
 	int btf_fd, map_fd, sk_fd, err;
 
 	btf_fd = load_btf();
 	CHECK(btf_fd == -1, "bpf_load_btf", "btf_fd:%d errno:%d\n",
 	      btf_fd, errno);
-	xattr.btf_fd = btf_fd;
+	map_opts.btf_fd = btf_fd;
 
 	sk_fd = socket(AF_INET6, SOCK_STREAM, 0);
 	CHECK(sk_fd == -1, "socket()", "sk_fd:%d errno:%d\n",
 	      sk_fd, errno);
 
-	map_fd = bpf_create_map_xattr(&xattr);
-	CHECK(map_fd == -1, "bpf_create_map_xattr(good_xattr)",
+	map_fd = bpf_map_create(BPF_MAP_TYPE_SK_STORAGE, "sk_storage_map", 4, 8, 0, &map_opts);
+	CHECK(map_fd == -1, "bpf_map_create(good_xattr)",
 	      "map_fd:%d errno:%d\n", map_fd, errno);
 
 	/* Add new elem */
@@ -560,31 +556,29 @@ static void test_sk_storage_map_basic(void)
 	CHECK(!err || errno != ENOENT, "bpf_map_delete_elem()",
 	      "err:%d errno:%d\n", err, errno);
 
-	memcpy(&bad_xattr, &xattr, sizeof(xattr));
+	memcpy(&bad_xattr, &map_opts, sizeof(map_opts));
 	bad_xattr.btf_key_type_id = 0;
-	err = bpf_create_map_xattr(&bad_xattr);
-	CHECK(!err || errno != EINVAL, "bap_create_map_xattr(bad_xattr)",
+	err = bpf_map_create(BPF_MAP_TYPE_SK_STORAGE, "sk_storage_map", 4, 8, 0, &bad_xattr);
+	CHECK(!err || errno != EINVAL, "bpf_map_create(bad_xattr)",
 	      "err:%d errno:%d\n", err, errno);
 
-	memcpy(&bad_xattr, &xattr, sizeof(xattr));
+	memcpy(&bad_xattr, &map_opts, sizeof(map_opts));
 	bad_xattr.btf_key_type_id = 3;
-	err = bpf_create_map_xattr(&bad_xattr);
-	CHECK(!err || errno != EINVAL, "bap_create_map_xattr(bad_xattr)",
+	err = bpf_map_create(BPF_MAP_TYPE_SK_STORAGE, "sk_storage_map", 4, 8, 0, &bad_xattr);
+	CHECK(!err || errno != EINVAL, "bpf_map_create(bad_xattr)",
 	      "err:%d errno:%d\n", err, errno);
 
-	memcpy(&bad_xattr, &xattr, sizeof(xattr));
-	bad_xattr.max_entries = 1;
-	err = bpf_create_map_xattr(&bad_xattr);
-	CHECK(!err || errno != EINVAL, "bap_create_map_xattr(bad_xattr)",
+	err = bpf_map_create(BPF_MAP_TYPE_SK_STORAGE, "sk_storage_map", 4, 8, 1, &map_opts);
+	CHECK(!err || errno != EINVAL, "bpf_map_create(bad_xattr)",
 	      "err:%d errno:%d\n", err, errno);
 
-	memcpy(&bad_xattr, &xattr, sizeof(xattr));
+	memcpy(&bad_xattr, &map_opts, sizeof(map_opts));
 	bad_xattr.map_flags = 0;
-	err = bpf_create_map_xattr(&bad_xattr);
+	err = bpf_map_create(BPF_MAP_TYPE_SK_STORAGE, "sk_storage_map", 4, 8, 0, &bad_xattr);
 	CHECK(!err || errno != EINVAL, "bap_create_map_xattr(bad_xattr)",
 	      "err:%d errno:%d\n", err, errno);
 
-	xattr.btf_fd = -1;
+	map_opts.btf_fd = -1;
 	close(btf_fd);
 	close(map_fd);
 	close(sk_fd);
diff --git a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
index be73e3de6668..d2d9e965eba5 100644
--- a/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
@@ -7,32 +7,33 @@
 
 static void test_fail_cases(void)
 {
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
 	__u32 value;
 	int fd, err;
 
 	/* Invalid key size */
-	fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 4, sizeof(value), 100, 0);
-	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid key size"))
+	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 4, sizeof(value), 100, NULL);
+	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid key size"))
 		close(fd);
 
 	/* Invalid value size */
-	fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, 0, 100, 0);
-	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid value size 0"))
+	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, 0, 100, NULL);
+	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid value size 0"))
 		close(fd);
 
 	/* Invalid max entries size */
-	fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(value), 0, 0);
-	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid max entries size"))
+	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(value), 0, NULL);
+	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid max entries size"))
 		close(fd);
 
 	/* Bloom filter maps do not support BPF_F_NO_PREALLOC */
-	fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(value), 100,
-			    BPF_F_NO_PREALLOC);
-	if (!ASSERT_LT(fd, 0, "bpf_create_map bloom filter invalid flags"))
+	opts.map_flags = BPF_F_NO_PREALLOC;
+	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(value), 100, &opts);
+	if (!ASSERT_LT(fd, 0, "bpf_map_create bloom filter invalid flags"))
 		close(fd);
 
-	fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(value), 100, 0);
-	if (!ASSERT_GE(fd, 0, "bpf_create_map bloom filter"))
+	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(value), 100, NULL);
+	if (!ASSERT_GE(fd, 0, "bpf_map_create bloom filter"))
 		return;
 
 	/* Test invalid flags */
@@ -56,13 +57,14 @@ static void test_fail_cases(void)
 
 static void test_success_cases(void)
 {
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
 	char value[11];
 	int fd, err;
 
 	/* Create a map */
-	fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(value), 100,
-			    BPF_F_ZERO_SEED | BPF_F_NUMA_NODE);
-	if (!ASSERT_GE(fd, 0, "bpf_create_map bloom filter success case"))
+	opts.map_flags = BPF_F_ZERO_SEED | BPF_F_NUMA_NODE;
+	fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(value), 100, &opts);
+	if (!ASSERT_GE(fd, 0, "bpf_map_create bloom filter success case"))
 		return;
 
 	/* Add a value to the bloom filter */
@@ -100,9 +102,9 @@ static void test_inner_map(struct bloom_filter_map *skel, const __u32 *rand_vals
 	struct bpf_link *link;
 
 	/* Create a bloom filter map that will be used as the inner map */
-	inner_map_fd = bpf_create_map(BPF_MAP_TYPE_BLOOM_FILTER, 0, sizeof(*rand_vals),
-				      nr_rand_vals, 0);
-	if (!ASSERT_GE(inner_map_fd, 0, "bpf_create_map bloom filter inner map"))
+	inner_map_fd = bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(*rand_vals),
+				      nr_rand_vals, NULL);
+	if (!ASSERT_GE(inner_map_fd, 0, "bpf_map_create bloom filter inner map"))
 		return;
 
 	for (i = 0; i < nr_rand_vals; i++) {
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 3e10abce3e5a..0b996be923b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -469,12 +469,12 @@ static void test_overflow(bool test_e2big_overflow, bool ret1)
 	 * fills seq_file buffer and then the other will trigger
 	 * overflow and needs restart.
 	 */
-	map1_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 8, 1, 0);
-	if (CHECK(map1_fd < 0, "bpf_create_map",
+	map1_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 8, 1, NULL);
+	if (CHECK(map1_fd < 0, "bpf_map_create",
 		  "map_creation failed: %s\n", strerror(errno)))
 		goto out;
-	map2_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 8, 1, 0);
-	if (CHECK(map2_fd < 0, "bpf_create_map",
+	map2_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 8, 1, NULL);
+	if (CHECK(map2_fd < 0, "bpf_map_create",
 		  "map_creation failed: %s\n", strerror(errno)))
 		goto free_map1;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index f9326a13badb..cab810bab593 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4074,7 +4074,7 @@ static void *btf_raw_create(const struct btf_header *hdr,
 static void do_test_raw(unsigned int test_num)
 {
 	struct btf_raw_test *test = &raw_tests[test_num - 1];
-	struct bpf_create_map_attr create_attr = {};
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
 	int map_fd = -1, btf_fd = -1;
 	unsigned int raw_btf_size;
 	struct btf_header *hdr;
@@ -4117,16 +4117,11 @@ static void do_test_raw(unsigned int test_num)
 	if (err || btf_fd < 0)
 		goto done;
 
-	create_attr.name = test->map_name;
-	create_attr.map_type = test->map_type;
-	create_attr.key_size = test->key_size;
-	create_attr.value_size = test->value_size;
-	create_attr.max_entries = test->max_entries;
-	create_attr.btf_fd = btf_fd;
-	create_attr.btf_key_type_id = test->key_type_id;
-	create_attr.btf_value_type_id = test->value_type_id;
-
-	map_fd = bpf_create_map_xattr(&create_attr);
+	opts.btf_fd = btf_fd;
+	opts.btf_key_type_id = test->key_type_id;
+	opts.btf_value_type_id = test->value_type_id;
+	map_fd = bpf_map_create(test->map_type, test->map_name,
+				test->key_size, test->value_size, test->max_entries, &opts);
 
 	err = ((map_fd < 0) != test->map_create_err);
 	CHECK(err, "map_fd:%d test->map_create_err:%u",
@@ -4290,7 +4285,7 @@ static int test_big_btf_info(unsigned int test_num)
 static int test_btf_id(unsigned int test_num)
 {
 	const struct btf_get_info_test *test = &get_info_tests[test_num - 1];
-	struct bpf_create_map_attr create_attr = {};
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
 	uint8_t *raw_btf = NULL, *user_btf[2] = {};
 	int btf_fd[2] = {-1, -1}, map_fd = -1;
 	struct bpf_map_info map_info = {};
@@ -4355,16 +4350,11 @@ static int test_btf_id(unsigned int test_num)
 	}
 
 	/* Test btf members in struct bpf_map_info */
-	create_attr.name = "test_btf_id";
-	create_attr.map_type = BPF_MAP_TYPE_ARRAY;
-	create_attr.key_size = sizeof(int);
-	create_attr.value_size = sizeof(unsigned int);
-	create_attr.max_entries = 4;
-	create_attr.btf_fd = btf_fd[0];
-	create_attr.btf_key_type_id = 1;
-	create_attr.btf_value_type_id = 2;
-
-	map_fd = bpf_create_map_xattr(&create_attr);
+	opts.btf_fd = btf_fd[0];
+	opts.btf_key_type_id = 1;
+	opts.btf_value_type_id = 2;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "test_btf_id",
+				sizeof(int), sizeof(int), 4, &opts);
 	if (CHECK(map_fd < 0, "errno:%d", errno)) {
 		err = -1;
 		goto done;
@@ -5153,7 +5143,7 @@ static void do_test_pprint(int test_num)
 {
 	const struct btf_raw_test *test = &pprint_test_template[test_num];
 	enum pprint_mapv_kind_t mapv_kind = test->mapv_kind;
-	struct bpf_create_map_attr create_attr = {};
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
 	bool ordered_map, lossless_map, percpu_map;
 	int err, ret, num_cpus, rounded_value_size;
 	unsigned int key, nr_read_elems;
@@ -5189,16 +5179,11 @@ static void do_test_pprint(int test_num)
 		goto done;
 	}
 
-	create_attr.name = test->map_name;
-	create_attr.map_type = test->map_type;
-	create_attr.key_size = test->key_size;
-	create_attr.value_size = test->value_size;
-	create_attr.max_entries = test->max_entries;
-	create_attr.btf_fd = btf_fd;
-	create_attr.btf_key_type_id = test->key_type_id;
-	create_attr.btf_value_type_id = test->value_type_id;
-
-	map_fd = bpf_create_map_xattr(&create_attr);
+	opts.btf_fd = btf_fd;
+	opts.btf_key_type_id = test->key_type_id;
+	opts.btf_value_type_id = test->value_type_id;
+	map_fd = bpf_map_create(test->map_type, test->map_name,
+				test->key_size, test->value_size, test->max_entries, &opts);
 	if (CHECK(map_fd < 0, "errno:%d", errno)) {
 		err = -1;
 		goto done;
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
index de9c3e12b0ea..d3e8f729c623 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
@@ -15,22 +15,22 @@ static int prog_load_cnt(int verdict, int val)
 	int cgroup_storage_fd, percpu_cgroup_storage_fd;
 
 	if (map_fd < 0)
-		map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 8, 1, 0);
+		map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 8, 1, NULL);
 	if (map_fd < 0) {
 		printf("failed to create map '%s'\n", strerror(errno));
 		return -1;
 	}
 
-	cgroup_storage_fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE,
-				sizeof(struct bpf_cgroup_storage_key), 8, 0, 0);
+	cgroup_storage_fd = bpf_map_create(BPF_MAP_TYPE_CGROUP_STORAGE, NULL,
+				sizeof(struct bpf_cgroup_storage_key), 8, 0, NULL);
 	if (cgroup_storage_fd < 0) {
 		printf("failed to create map '%s'\n", strerror(errno));
 		return -1;
 	}
 
-	percpu_cgroup_storage_fd = bpf_create_map(
-		BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
-		sizeof(struct bpf_cgroup_storage_key), 8, 0, 0);
+	percpu_cgroup_storage_fd = bpf_map_create(
+		BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, NULL,
+		sizeof(struct bpf_cgroup_storage_key), 8, 0, NULL);
 	if (percpu_cgroup_storage_fd < 0) {
 		printf("failed to create map '%s'\n", strerror(errno));
 		return -1;
diff --git a/tools/testing/selftests/bpf/prog_tests/pinning.c b/tools/testing/selftests/bpf/prog_tests/pinning.c
index d4b953ae3407..31c09ba577eb 100644
--- a/tools/testing/selftests/bpf/prog_tests/pinning.c
+++ b/tools/testing/selftests/bpf/prog_tests/pinning.c
@@ -241,8 +241,8 @@ void test_pinning(void)
 		goto out;
 	}
 
-	map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(__u32),
-				sizeof(__u64), 1, 0);
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(__u32),
+				sizeof(__u64), 1, NULL);
 	if (CHECK(map_fd < 0, "create pinmap manually", "fd %d\n", map_fd))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
index 167cd8a2edfd..e945195b24c9 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf_multi.c
@@ -62,8 +62,8 @@ void test_ringbuf_multi(void)
 	if (CHECK(err != 0, "bpf_map__set_max_entries", "bpf_map__set_max_entries failed\n"))
 		goto cleanup;
 
-	proto_fd = bpf_create_map(BPF_MAP_TYPE_RINGBUF, 0, 0, page_size, 0);
-	if (CHECK(proto_fd < 0, "bpf_create_map", "bpf_create_map failed\n"))
+	proto_fd = bpf_map_create(BPF_MAP_TYPE_RINGBUF, NULL, 0, 0, page_size, NULL);
+	if (CHECK(proto_fd < 0, "bpf_map_create", "bpf_map_create failed\n"))
 		goto cleanup;
 
 	err = bpf_map__set_inner_map_fd(skel->maps.ringbuf_hash, proto_fd);
diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 3cfc910ab3c1..980ac0f2c0bb 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -66,29 +66,20 @@ static union sa46 {
 
 static int create_maps(enum bpf_map_type inner_type)
 {
-	struct bpf_create_map_attr attr = {};
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
 
 	inner_map_type = inner_type;
 
 	/* Creating reuseport_array */
-	attr.name = "reuseport_array";
-	attr.map_type = inner_type;
-	attr.key_size = sizeof(__u32);
-	attr.value_size = sizeof(__u32);
-	attr.max_entries = REUSEPORT_ARRAY_SIZE;
-
-	reuseport_array = bpf_create_map_xattr(&attr);
+	reuseport_array = bpf_map_create(inner_type, "reuseport_array",
+					 sizeof(__u32), sizeof(__u32), REUSEPORT_ARRAY_SIZE, NULL);
 	RET_ERR(reuseport_array < 0, "creating reuseport_array",
 		"reuseport_array:%d errno:%d\n", reuseport_array, errno);
 
 	/* Creating outer_map */
-	attr.name = "outer_map";
-	attr.map_type = BPF_MAP_TYPE_ARRAY_OF_MAPS;
-	attr.key_size = sizeof(__u32);
-	attr.value_size = sizeof(__u32);
-	attr.max_entries = 1;
-	attr.inner_map_fd = reuseport_array;
-	outer_map = bpf_create_map_xattr(&attr);
+	opts.inner_map_fd = reuseport_array;
+	outer_map = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS, "outer_map",
+				   sizeof(__u32), sizeof(__u32), 1, &opts);
 	RET_ERR(outer_map < 0, "creating outer_map",
 		"outer_map:%d errno:%d\n", outer_map, errno);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 1352ec104149..85db0f4cdd95 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -91,9 +91,9 @@ static void test_sockmap_create_update_free(enum bpf_map_type map_type)
 	if (CHECK_FAIL(s < 0))
 		return;
 
-	map = bpf_create_map(map_type, sizeof(int), sizeof(int), 1, 0);
+	map = bpf_map_create(map_type, NULL, sizeof(int), sizeof(int), 1, NULL);
 	if (CHECK_FAIL(map < 0)) {
-		perror("bpf_create_map");
+		perror("bpf_cmap_create");
 		goto out;
 	}
 
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 7a0d64fdc192..af293ea1542c 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -97,7 +97,7 @@ static void run_tests(int family, enum bpf_map_type map_type)
 	char test_name[MAX_TEST_NAME];
 	int map;
 
-	map = bpf_create_map(map_type, sizeof(int), sizeof(int), 1, 0);
+	map = bpf_map_create(map_type, NULL, sizeof(int), sizeof(int), 1, NULL);
 	if (CHECK_FAIL(map < 0)) {
 		perror("bpf_map_create");
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 2a9cb951bfd6..7e21bfab6358 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -502,8 +502,8 @@ static void test_lookup_32_bit_value(int family, int sotype, int mapfd)
 	if (s < 0)
 		return;
 
-	mapfd = bpf_create_map(BPF_MAP_TYPE_SOCKMAP, sizeof(key),
-			       sizeof(value32), 1, 0);
+	mapfd = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(key),
+			       sizeof(value32), 1, NULL);
 	if (mapfd < 0) {
 		FAIL_ERRNO("map_create");
 		goto close;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
index d29ebfeef9c5..ada95bfb9b1b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
@@ -80,7 +80,7 @@ static int fn(void)
 	if (!ASSERT_OK(err, "creating " TDIR "/fs1/b"))
 		goto out;
 
-	map = bpf_create_map(BPF_MAP_TYPE_ARRAY, 4, 4, 1, 0);
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 4, 1, NULL);
 	if (!ASSERT_GT(map, 0, "create_map(ARRAY)"))
 		goto out;
 	err = bpf_obj_pin(map, TDIR "/fs1/c");
diff --git a/tools/testing/selftests/bpf/test_cgroup_storage.c b/tools/testing/selftests/bpf/test_cgroup_storage.c
index a63787e7bb1a..5b8314cd77fd 100644
--- a/tools/testing/selftests/bpf/test_cgroup_storage.c
+++ b/tools/testing/selftests/bpf/test_cgroup_storage.c
@@ -51,15 +51,15 @@ int main(int argc, char **argv)
 		goto err;
 	}
 
-	map_fd = bpf_create_map(BPF_MAP_TYPE_CGROUP_STORAGE, sizeof(key),
-				sizeof(value), 0, 0);
+	map_fd = bpf_map_create(BPF_MAP_TYPE_CGROUP_STORAGE, NULL, sizeof(key),
+				sizeof(value), 0, NULL);
 	if (map_fd < 0) {
 		printf("Failed to create map: %s\n", strerror(errno));
 		goto out;
 	}
 
-	percpu_map_fd = bpf_create_map(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
-				       sizeof(key), sizeof(value), 0, 0);
+	percpu_map_fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, NULL,
+				       sizeof(key), sizeof(value), 0, NULL);
 	if (percpu_map_fd < 0) {
 		printf("Failed to create map: %s\n", strerror(errno));
 		goto out;
diff --git a/tools/testing/selftests/bpf/test_lpm_map.c b/tools/testing/selftests/bpf/test_lpm_map.c
index 006be3963977..b36d34ae9e51 100644
--- a/tools/testing/selftests/bpf/test_lpm_map.c
+++ b/tools/testing/selftests/bpf/test_lpm_map.c
@@ -208,6 +208,7 @@ static void test_lpm_order(void)
 
 static void test_lpm_map(int keysize)
 {
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
 	size_t i, j, n_matches, n_matches_after_delete, n_nodes, n_lookups;
 	struct tlpm_node *t, *list = NULL;
 	struct bpf_lpm_trie_key *key;
@@ -233,11 +234,11 @@ static void test_lpm_map(int keysize)
 	key = alloca(sizeof(*key) + keysize);
 	memset(key, 0, sizeof(*key) + keysize);
 
-	map = bpf_create_map(BPF_MAP_TYPE_LPM_TRIE,
+	map = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, NULL,
 			     sizeof(*key) + keysize,
 			     keysize + 1,
 			     4096,
-			     BPF_F_NO_PREALLOC);
+			     &opts);
 	assert(map >= 0);
 
 	for (i = 0; i < n_nodes; ++i) {
@@ -329,6 +330,7 @@ static void test_lpm_map(int keysize)
 
 static void test_lpm_ipaddr(void)
 {
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
 	struct bpf_lpm_trie_key *key_ipv4;
 	struct bpf_lpm_trie_key *key_ipv6;
 	size_t key_size_ipv4;
@@ -342,14 +344,14 @@ static void test_lpm_ipaddr(void)
 	key_ipv4 = alloca(key_size_ipv4);
 	key_ipv6 = alloca(key_size_ipv6);
 
-	map_fd_ipv4 = bpf_create_map(BPF_MAP_TYPE_LPM_TRIE,
+	map_fd_ipv4 = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, NULL,
 				     key_size_ipv4, sizeof(value),
-				     100, BPF_F_NO_PREALLOC);
+				     100, &opts);
 	assert(map_fd_ipv4 >= 0);
 
-	map_fd_ipv6 = bpf_create_map(BPF_MAP_TYPE_LPM_TRIE,
+	map_fd_ipv6 = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, NULL,
 				     key_size_ipv6, sizeof(value),
-				     100, BPF_F_NO_PREALLOC);
+				     100, &opts);
 	assert(map_fd_ipv6 >= 0);
 
 	/* Fill data some IPv4 and IPv6 address ranges */
@@ -423,6 +425,7 @@ static void test_lpm_ipaddr(void)
 
 static void test_lpm_delete(void)
 {
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
 	struct bpf_lpm_trie_key *key;
 	size_t key_size;
 	int map_fd;
@@ -431,9 +434,9 @@ static void test_lpm_delete(void)
 	key_size = sizeof(*key) + sizeof(__u32);
 	key = alloca(key_size);
 
-	map_fd = bpf_create_map(BPF_MAP_TYPE_LPM_TRIE,
+	map_fd = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, NULL,
 				key_size, sizeof(value),
-				100, BPF_F_NO_PREALLOC);
+				100, &opts);
 	assert(map_fd >= 0);
 
 	/* Add nodes:
@@ -535,6 +538,7 @@ static void test_lpm_delete(void)
 
 static void test_lpm_get_next_key(void)
 {
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
 	struct bpf_lpm_trie_key *key_p, *next_key_p;
 	size_t key_size;
 	__u32 value = 0;
@@ -544,8 +548,7 @@ static void test_lpm_get_next_key(void)
 	key_p = alloca(key_size);
 	next_key_p = alloca(key_size);
 
-	map_fd = bpf_create_map(BPF_MAP_TYPE_LPM_TRIE, key_size, sizeof(value),
-				100, BPF_F_NO_PREALLOC);
+	map_fd = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, NULL, key_size, sizeof(value), 100, &opts);
 	assert(map_fd >= 0);
 
 	/* empty tree. get_next_key should return ENOENT */
@@ -753,6 +756,7 @@ static void setup_lpm_mt_test_info(struct lpm_mt_test_info *info, int map_fd)
 
 static void test_lpm_multi_thread(void)
 {
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC); 
 	struct lpm_mt_test_info info[4];
 	size_t key_size, value_size;
 	pthread_t thread_id[4];
@@ -762,8 +766,7 @@ static void test_lpm_multi_thread(void)
 	/* create a trie */
 	value_size = sizeof(__u32);
 	key_size = sizeof(struct bpf_lpm_trie_key) + value_size;
-	map_fd = bpf_create_map(BPF_MAP_TYPE_LPM_TRIE, key_size, value_size,
-				100, BPF_F_NO_PREALLOC);
+	map_fd = bpf_map_create(BPF_MAP_TYPE_LPM_TRIE, NULL, key_size, value_size, 100, &opts);
 
 	/* create 4 threads to test update, delete, lookup and get_next_key */
 	setup_lpm_mt_test_info(&info[0], map_fd);
diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index 7f3d1d8460b4..b9f1bbbc8aba 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -28,13 +28,14 @@ static int nr_cpus;
 
 static int create_map(int map_type, int map_flags, unsigned int size)
 {
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = map_flags);
 	int map_fd;
 
-	map_fd = bpf_create_map(map_type, sizeof(unsigned long long),
-				sizeof(unsigned long long), size, map_flags);
+	map_fd = bpf_map_create(map_type, NULL,  sizeof(unsigned long long),
+				sizeof(unsigned long long), size, &opts);
 
 	if (map_fd == -1)
-		perror("bpf_create_map");
+		perror("bpf_map_create");
 
 	return map_fd;
 }
@@ -42,7 +43,6 @@ static int create_map(int map_type, int map_flags, unsigned int size)
 static int bpf_map_lookup_elem_with_ref_bit(int fd, unsigned long long key,
 					    void *value)
 {
-	struct bpf_create_map_attr map;
 	struct bpf_insn insns[] = {
 		BPF_LD_MAP_VALUE(BPF_REG_9, 0, 0),
 		BPF_LD_MAP_FD(BPF_REG_1, fd),
@@ -63,13 +63,7 @@ static int bpf_map_lookup_elem_with_ref_bit(int fd, unsigned long long key,
 	int mfd, pfd, ret, zero = 0;
 	__u32 retval = 0;
 
-	memset(&map, 0, sizeof(map));
-	map.map_type = BPF_MAP_TYPE_ARRAY;
-	map.key_size = sizeof(int);
-	map.value_size = sizeof(unsigned long long);
-	map.max_entries = 1;
-
-	mfd = bpf_create_map_xattr(&map);
+	mfd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), sizeof(__u64), 1, NULL);
 	if (mfd < 0)
 		return -1;
 
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 8b31bc1a801d..f4cd658bbe00 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -33,15 +33,14 @@
 
 static int skips;
 
-static int map_flags;
+static struct bpf_map_create_opts map_opts = { .sz = sizeof(map_opts) };
 
 static void test_hashmap(unsigned int task, void *data)
 {
 	long long key, next_key, first_key, value;
 	int fd;
 
-	fd = bpf_create_map(BPF_MAP_TYPE_HASH, sizeof(key), sizeof(value),
-			    2, map_flags);
+	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value), 2, &map_opts);
 	if (fd < 0) {
 		printf("Failed to create hashmap '%s'!\n", strerror(errno));
 		exit(1);
@@ -138,8 +137,7 @@ static void test_hashmap_sizes(unsigned int task, void *data)
 
 	for (i = 1; i <= 512; i <<= 1)
 		for (j = 1; j <= 1 << 18; j <<= 1) {
-			fd = bpf_create_map(BPF_MAP_TYPE_HASH, i, j,
-					    2, map_flags);
+			fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, i, j, 2, &map_opts);
 			if (fd < 0) {
 				if (errno == ENOMEM)
 					return;
@@ -160,8 +158,8 @@ static void test_hashmap_percpu(unsigned int task, void *data)
 	int expected_key_mask = 0;
 	int fd, i;
 
-	fd = bpf_create_map(BPF_MAP_TYPE_PERCPU_HASH, sizeof(key),
-			    sizeof(bpf_percpu(value, 0)), 2, map_flags);
+	fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_HASH, NULL, sizeof(key),
+			    sizeof(bpf_percpu(value, 0)), 2, &map_opts);
 	if (fd < 0) {
 		printf("Failed to create hashmap '%s'!\n", strerror(errno));
 		exit(1);
@@ -272,11 +270,11 @@ static int helper_fill_hashmap(int max_entries)
 	int i, fd, ret;
 	long long key, value;
 
-	fd = bpf_create_map(BPF_MAP_TYPE_HASH, sizeof(key), sizeof(value),
-			    max_entries, map_flags);
+	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value),
+			    max_entries, &map_opts);
 	CHECK(fd < 0,
 	      "failed to create hashmap",
-	      "err: %s, flags: 0x%x\n", strerror(errno), map_flags);
+	      "err: %s, flags: 0x%x\n", strerror(errno), map_opts.map_flags);
 
 	for (i = 0; i < max_entries; i++) {
 		key = i; value = key;
@@ -332,8 +330,8 @@ static void test_hashmap_zero_seed(void)
 	int i, first, second, old_flags;
 	long long key, next_first, next_second;
 
-	old_flags = map_flags;
-	map_flags |= BPF_F_ZERO_SEED;
+	old_flags = map_opts.map_flags;
+	map_opts.map_flags |= BPF_F_ZERO_SEED;
 
 	first = helper_fill_hashmap(3);
 	second = helper_fill_hashmap(3);
@@ -355,7 +353,7 @@ static void test_hashmap_zero_seed(void)
 		key = next_first;
 	}
 
-	map_flags = old_flags;
+	map_opts.map_flags = old_flags;
 	close(first);
 	close(second);
 }
@@ -365,8 +363,7 @@ static void test_arraymap(unsigned int task, void *data)
 	int key, next_key, fd;
 	long long value;
 
-	fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(key), sizeof(value),
-			    2, 0);
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(key), sizeof(value), 2, NULL);
 	if (fd < 0) {
 		printf("Failed to create arraymap '%s'!\n", strerror(errno));
 		exit(1);
@@ -421,8 +418,8 @@ static void test_arraymap_percpu(unsigned int task, void *data)
 	BPF_DECLARE_PERCPU(long, values);
 	int key, next_key, fd, i;
 
-	fd = bpf_create_map(BPF_MAP_TYPE_PERCPU_ARRAY, sizeof(key),
-			    sizeof(bpf_percpu(values, 0)), 2, 0);
+	fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, NULL, sizeof(key),
+			    sizeof(bpf_percpu(values, 0)), 2, NULL);
 	if (fd < 0) {
 		printf("Failed to create arraymap '%s'!\n", strerror(errno));
 		exit(1);
@@ -484,8 +481,8 @@ static void test_arraymap_percpu_many_keys(void)
 	unsigned int nr_keys = 2000;
 	int key, fd, i;
 
-	fd = bpf_create_map(BPF_MAP_TYPE_PERCPU_ARRAY, sizeof(key),
-			    sizeof(bpf_percpu(values, 0)), nr_keys, 0);
+	fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, NULL, sizeof(key),
+			    sizeof(bpf_percpu(values, 0)), nr_keys, NULL);
 	if (fd < 0) {
 		printf("Failed to create per-cpu arraymap '%s'!\n",
 		       strerror(errno));
@@ -516,8 +513,7 @@ static void test_devmap(unsigned int task, void *data)
 	int fd;
 	__u32 key, value;
 
-	fd = bpf_create_map(BPF_MAP_TYPE_DEVMAP, sizeof(key), sizeof(value),
-			    2, 0);
+	fd = bpf_map_create(BPF_MAP_TYPE_DEVMAP, NULL, sizeof(key), sizeof(value), 2, NULL);
 	if (fd < 0) {
 		printf("Failed to create devmap '%s'!\n", strerror(errno));
 		exit(1);
@@ -531,8 +527,7 @@ static void test_devmap_hash(unsigned int task, void *data)
 	int fd;
 	__u32 key, value;
 
-	fd = bpf_create_map(BPF_MAP_TYPE_DEVMAP_HASH, sizeof(key), sizeof(value),
-			    2, 0);
+	fd = bpf_map_create(BPF_MAP_TYPE_DEVMAP_HASH, NULL, sizeof(key), sizeof(value), 2, NULL);
 	if (fd < 0) {
 		printf("Failed to create devmap_hash '%s'!\n", strerror(errno));
 		exit(1);
@@ -552,14 +547,12 @@ static void test_queuemap(unsigned int task, void *data)
 		vals[i] = rand();
 
 	/* Invalid key size */
-	fd = bpf_create_map(BPF_MAP_TYPE_QUEUE, 4, sizeof(val), MAP_SIZE,
-			    map_flags);
+	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 4, sizeof(val), MAP_SIZE, &map_opts);
 	assert(fd < 0 && errno == EINVAL);
 
-	fd = bpf_create_map(BPF_MAP_TYPE_QUEUE, 0, sizeof(val), MAP_SIZE,
-			    map_flags);
+	fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0, sizeof(val), MAP_SIZE, &map_opts);
 	/* Queue map does not support BPF_F_NO_PREALLOC */
-	if (map_flags & BPF_F_NO_PREALLOC) {
+	if (map_opts.map_flags & BPF_F_NO_PREALLOC) {
 		assert(fd < 0 && errno == EINVAL);
 		return;
 	}
@@ -610,14 +603,12 @@ static void test_stackmap(unsigned int task, void *data)
 		vals[i] = rand();
 
 	/* Invalid key size */
-	fd = bpf_create_map(BPF_MAP_TYPE_STACK, 4, sizeof(val), MAP_SIZE,
-			    map_flags);
+	fd = bpf_map_create(BPF_MAP_TYPE_STACK, NULL, 4, sizeof(val), MAP_SIZE, &map_opts);
 	assert(fd < 0 && errno == EINVAL);
 
-	fd = bpf_create_map(BPF_MAP_TYPE_STACK, 0, sizeof(val), MAP_SIZE,
-			    map_flags);
+	fd = bpf_map_create(BPF_MAP_TYPE_STACK, NULL, 0, sizeof(val), MAP_SIZE, &map_opts);
 	/* Stack map does not support BPF_F_NO_PREALLOC */
-	if (map_flags & BPF_F_NO_PREALLOC) {
+	if (map_opts.map_flags & BPF_F_NO_PREALLOC) {
 		assert(fd < 0 && errno == EINVAL);
 		return;
 	}
@@ -744,9 +735,9 @@ static void test_sockmap(unsigned int tasks, void *data)
 	}
 
 	/* Test sockmap with connected sockets */
-	fd = bpf_create_map(BPF_MAP_TYPE_SOCKMAP,
+	fd = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL,
 			    sizeof(key), sizeof(value),
-			    6, 0);
+			    6, NULL);
 	if (fd < 0) {
 		if (!bpf_probe_map_type(BPF_MAP_TYPE_SOCKMAP, 0)) {
 			printf("%s SKIP (unsupported map type BPF_MAP_TYPE_SOCKMAP)\n",
@@ -1168,8 +1159,7 @@ static void test_map_in_map(void)
 
 	obj = bpf_object__open(MAPINMAP_PROG);
 
-	fd = bpf_create_map(BPF_MAP_TYPE_HASH, sizeof(int), sizeof(int),
-			    2, 0);
+	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(int), sizeof(int), 2, NULL);
 	if (fd < 0) {
 		printf("Failed to create hashmap '%s'!\n", strerror(errno));
 		exit(1);
@@ -1315,8 +1305,8 @@ static void test_map_large(void)
 	} key;
 	int fd, i, value;
 
-	fd = bpf_create_map(BPF_MAP_TYPE_HASH, sizeof(key), sizeof(value),
-			    MAP_SIZE, map_flags);
+	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value),
+			    MAP_SIZE, &map_opts);
 	if (fd < 0) {
 		printf("Failed to create large map '%s'!\n", strerror(errno));
 		exit(1);
@@ -1469,8 +1459,8 @@ static void test_map_parallel(void)
 	int i, fd, key = 0, value = 0;
 	int data[2];
 
-	fd = bpf_create_map(BPF_MAP_TYPE_HASH, sizeof(key), sizeof(value),
-			    MAP_SIZE, map_flags);
+	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value),
+			    MAP_SIZE, &map_opts);
 	if (fd < 0) {
 		printf("Failed to create map for parallel test '%s'!\n",
 		       strerror(errno));
@@ -1518,9 +1508,13 @@ static void test_map_parallel(void)
 static void test_map_rdonly(void)
 {
 	int fd, key = 0, value = 0;
+	__u32 old_flags;
 
-	fd = bpf_create_map(BPF_MAP_TYPE_HASH, sizeof(key), sizeof(value),
-			    MAP_SIZE, map_flags | BPF_F_RDONLY);
+	old_flags = map_opts.map_flags;
+	map_opts.map_flags |= BPF_F_RDONLY;
+	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value),
+			    MAP_SIZE, &map_opts);
+	map_opts.map_flags = old_flags;
 	if (fd < 0) {
 		printf("Failed to create map for read only test '%s'!\n",
 		       strerror(errno));
@@ -1543,9 +1537,13 @@ static void test_map_rdonly(void)
 static void test_map_wronly_hash(void)
 {
 	int fd, key = 0, value = 0;
+	__u32 old_flags;
 
-	fd = bpf_create_map(BPF_MAP_TYPE_HASH, sizeof(key), sizeof(value),
-			    MAP_SIZE, map_flags | BPF_F_WRONLY);
+	old_flags = map_opts.map_flags;
+	map_opts.map_flags |= BPF_F_WRONLY;
+	fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(key), sizeof(value),
+			    MAP_SIZE, &map_opts);
+	map_opts.map_flags = old_flags;
 	if (fd < 0) {
 		printf("Failed to create map for write only test '%s'!\n",
 		       strerror(errno));
@@ -1567,13 +1565,17 @@ static void test_map_wronly_hash(void)
 static void test_map_wronly_stack_or_queue(enum bpf_map_type map_type)
 {
 	int fd, value = 0;
+	__u32 old_flags;
+
 
 	assert(map_type == BPF_MAP_TYPE_QUEUE ||
 	       map_type == BPF_MAP_TYPE_STACK);
-	fd = bpf_create_map(map_type, 0, sizeof(value), MAP_SIZE,
-			    map_flags | BPF_F_WRONLY);
+	old_flags = map_opts.map_flags;
+	map_opts.map_flags |= BPF_F_WRONLY;
+	fd = bpf_map_create(map_type, NULL, 0, sizeof(value), MAP_SIZE, &map_opts);
+	map_opts.map_flags = old_flags;
 	/* Stack/Queue maps do not support BPF_F_NO_PREALLOC */
-	if (map_flags & BPF_F_NO_PREALLOC) {
+	if (map_opts.map_flags & BPF_F_NO_PREALLOC) {
 		assert(fd < 0 && errno == EINVAL);
 		return;
 	}
@@ -1700,8 +1702,8 @@ static void test_reuseport_array(void)
 	__u32 fds_idx = 0;
 	int fd;
 
-	map_fd = bpf_create_map(BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
-				sizeof(__u32), sizeof(__u64), array_size, 0);
+	map_fd = bpf_map_create(BPF_MAP_TYPE_REUSEPORT_SOCKARRAY, NULL,
+				sizeof(__u32), sizeof(__u64), array_size, NULL);
 	CHECK(map_fd < 0, "reuseport array create",
 	      "map_fd:%d, errno:%d\n", map_fd, errno);
 
@@ -1837,8 +1839,8 @@ static void test_reuseport_array(void)
 	close(map_fd);
 
 	/* Test 32 bit fd */
-	map_fd = bpf_create_map(BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
-				sizeof(__u32), sizeof(__u32), array_size, 0);
+	map_fd = bpf_map_create(BPF_MAP_TYPE_REUSEPORT_SOCKARRAY, NULL,
+				sizeof(__u32), sizeof(__u32), array_size, NULL);
 	CHECK(map_fd < 0, "reuseport array create",
 	      "map_fd:%d, errno:%d\n", map_fd, errno);
 	prepare_reuseport_grp(SOCK_STREAM, map_fd, sizeof(__u32), &fd64,
@@ -1896,10 +1898,10 @@ int main(void)
 
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
 
-	map_flags = 0;
+	map_opts.map_flags = 0;
 	run_all_tests();
 
-	map_flags = BPF_F_NO_PREALLOC;
+	map_opts.map_flags = BPF_F_NO_PREALLOC;
 	run_all_tests();
 
 #define DEFINE_TEST(name) test_##name();
diff --git a/tools/testing/selftests/bpf/test_tag.c b/tools/testing/selftests/bpf/test_tag.c
index 5c7bea525626..0851c42ee31c 100644
--- a/tools/testing/selftests/bpf/test_tag.c
+++ b/tools/testing/selftests/bpf/test_tag.c
@@ -185,11 +185,12 @@ static void do_test(uint32_t *tests, int start_insns, int fd_map,
 
 int main(void)
 {
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_NO_PREALLOC);
 	uint32_t tests = 0;
 	int i, fd_map;
 
-	fd_map = bpf_create_map(BPF_MAP_TYPE_HASH, sizeof(int),
-				sizeof(int), 1, BPF_F_NO_PREALLOC);
+	fd_map = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, sizeof(int),
+				sizeof(int), 1, &opts);
 	assert(fd_map > 0);
 
 	for (i = 0; i < 5; i++) {
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index e512b715a785..222cb063ddf4 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -461,11 +461,11 @@ static int __create_map(uint32_t type, uint32_t size_key,
 			uint32_t size_value, uint32_t max_elem,
 			uint32_t extra_flags)
 {
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
 	int fd;
 
-	fd = bpf_create_map(type, size_key, size_value, max_elem,
-			    (type == BPF_MAP_TYPE_HASH ?
-			     BPF_F_NO_PREALLOC : 0) | extra_flags);
+	opts.map_flags = (type == BPF_MAP_TYPE_HASH ? BPF_F_NO_PREALLOC : 0) | extra_flags;
+	fd = bpf_map_create(type, NULL, size_key, size_value, max_elem, &opts);
 	if (fd < 0) {
 		if (skip_unsupported_map(type))
 			return -1;
@@ -521,8 +521,8 @@ static int create_prog_array(enum bpf_prog_type prog_type, uint32_t max_elem,
 {
 	int mfd, p1fd, p2fd, p3fd;
 
-	mfd = bpf_create_map(BPF_MAP_TYPE_PROG_ARRAY, sizeof(int),
-			     sizeof(int), max_elem, 0);
+	mfd = bpf_map_create(BPF_MAP_TYPE_PROG_ARRAY, NULL, sizeof(int),
+			     sizeof(int), max_elem, NULL);
 	if (mfd < 0) {
 		if (skip_unsupported_map(BPF_MAP_TYPE_PROG_ARRAY))
 			return -1;
@@ -552,10 +552,11 @@ static int create_prog_array(enum bpf_prog_type prog_type, uint32_t max_elem,
 
 static int create_map_in_map(void)
 {
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
 	int inner_map_fd, outer_map_fd;
 
-	inner_map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(int),
-				      sizeof(int), 1, 0);
+	inner_map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int),
+				      sizeof(int), 1, NULL);
 	if (inner_map_fd < 0) {
 		if (skip_unsupported_map(BPF_MAP_TYPE_ARRAY))
 			return -1;
@@ -563,8 +564,9 @@ static int create_map_in_map(void)
 		return inner_map_fd;
 	}
 
-	outer_map_fd = bpf_create_map_in_map(BPF_MAP_TYPE_ARRAY_OF_MAPS, NULL,
-					     sizeof(int), inner_map_fd, 1, 0);
+	opts.inner_map_fd = inner_map_fd;
+	outer_map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS, NULL,
+				      sizeof(int), sizeof(int), 1, &opts);
 	if (outer_map_fd < 0) {
 		if (skip_unsupported_map(BPF_MAP_TYPE_ARRAY_OF_MAPS))
 			return -1;
@@ -583,8 +585,8 @@ static int create_cgroup_storage(bool percpu)
 		BPF_MAP_TYPE_CGROUP_STORAGE;
 	int fd;
 
-	fd = bpf_create_map(type, sizeof(struct bpf_cgroup_storage_key),
-			    TEST_DATA_LEN, 0, 0);
+	fd = bpf_map_create(type, NULL, sizeof(struct bpf_cgroup_storage_key),
+			    TEST_DATA_LEN, 0, NULL);
 	if (fd < 0) {
 		if (skip_unsupported_map(type))
 			return -1;
@@ -648,22 +650,17 @@ static int load_btf(void)
 
 static int create_map_spin_lock(void)
 {
-	struct bpf_create_map_attr attr = {
-		.name = "test_map",
-		.map_type = BPF_MAP_TYPE_ARRAY,
-		.key_size = 4,
-		.value_size = 8,
-		.max_entries = 1,
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
 		.btf_key_type_id = 1,
 		.btf_value_type_id = 3,
-	};
+	);
 	int fd, btf_fd;
 
 	btf_fd = load_btf();
 	if (btf_fd < 0)
 		return -1;
-	attr.btf_fd = btf_fd;
-	fd = bpf_create_map_xattr(&attr);
+	opts.btf_fd = btf_fd;
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "test_map", 4, 8, 1, &opts);
 	if (fd < 0)
 		printf("Failed to create map with spin_lock\n");
 	return fd;
@@ -671,24 +668,19 @@ static int create_map_spin_lock(void)
 
 static int create_sk_storage_map(void)
 {
-	struct bpf_create_map_attr attr = {
-		.name = "test_map",
-		.map_type = BPF_MAP_TYPE_SK_STORAGE,
-		.key_size = 4,
-		.value_size = 8,
-		.max_entries = 0,
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
 		.map_flags = BPF_F_NO_PREALLOC,
 		.btf_key_type_id = 1,
 		.btf_value_type_id = 3,
-	};
+	);
 	int fd, btf_fd;
 
 	btf_fd = load_btf();
 	if (btf_fd < 0)
 		return -1;
-	attr.btf_fd = btf_fd;
-	fd = bpf_create_map_xattr(&attr);
-	close(attr.btf_fd);
+	opts.btf_fd = btf_fd;
+	fd = bpf_map_create(BPF_MAP_TYPE_SK_STORAGE, "test_map", 4, 8, 0, &opts);
+	close(opts.btf_fd);
 	if (fd < 0)
 		printf("Failed to create sk_storage_map\n");
 	return fd;
-- 
2.30.2

