Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D7652409C
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 01:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245684AbiEKXPN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 11 May 2022 19:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349052AbiEKXPL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 19:15:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E46316A240
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 16:15:09 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24BMwmBa018393
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 16:15:08 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fyx1h9dd5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 16:15:08 -0700
Received: from twshared6447.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 16:15:07 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 53C5119CA27AA; Wed, 11 May 2022 16:14:57 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: convert some selftests to high-level BPF map APIs
Date:   Wed, 11 May 2022 16:14:48 -0700
Message-ID: <20220511231448.571909-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511231448.571909-1-andrii@kernel.org>
References: <20220511231448.571909-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pkT_MzP9n5mNSUG-Yx89l0ePmOLIYX1A
X-Proofpoint-ORIG-GUID: pkT_MzP9n5mNSUG-Yx89l0ePmOLIYX1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert a bunch of selftests to using newly added high-level BPF map
APIs.

This change exposed that map_kptr selftests allocated too big buffer,
which is fixed in this patch as well.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/core_autosize.c  |  2 +-
 .../selftests/bpf/prog_tests/core_retro.c     | 17 ++++++-----
 .../selftests/bpf/prog_tests/for_each.c       | 30 +++++++++++--------
 .../bpf/prog_tests/lookup_and_delete.c        | 15 ++++++----
 .../selftests/bpf/prog_tests/map_kptr.c       | 23 ++++++++------
 .../bpf/prog_tests/stacktrace_build_id.c      |  8 ++---
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  | 11 +++----
 .../selftests/bpf/prog_tests/timer_mim.c      |  2 +-
 8 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_autosize.c b/tools/testing/selftests/bpf/prog_tests/core_autosize.c
index 1dfe14ff6aa4..f2ce4fd1cdae 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_autosize.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_autosize.c
@@ -167,7 +167,7 @@ void test_core_autosize(void)
 	if (!ASSERT_OK_PTR(bss_map, "bss_map_find"))
 		goto cleanup;
 
-	err = bpf_map_lookup_elem(bpf_map__fd(bss_map), &zero, (void *)&out);
+	err = bpf_map__lookup_elem(bss_map, &zero, sizeof(zero), &out, sizeof(out), 0);
 	if (!ASSERT_OK(err, "bss_lookup"))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/core_retro.c b/tools/testing/selftests/bpf/prog_tests/core_retro.c
index 6acb0e94d4d7..4a2c256c8db6 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_retro.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_retro.c
@@ -6,31 +6,32 @@
 
 void test_core_retro(void)
 {
-	int err, zero = 0, res, duration = 0, my_pid = getpid();
+	int err, zero = 0, res, my_pid = getpid();
 	struct test_core_retro *skel;
 
 	/* load program */
 	skel = test_core_retro__open_and_load();
-	if (CHECK(!skel, "skel_load", "skeleton open/load failed\n"))
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
 		goto out_close;
 
-	err = bpf_map_update_elem(bpf_map__fd(skel->maps.exp_tgid_map), &zero, &my_pid, 0);
-	if (CHECK(err, "map_update", "failed to set expected PID: %d\n", errno))
+	err = bpf_map__update_elem(skel->maps.exp_tgid_map, &zero, sizeof(zero),
+				   &my_pid, sizeof(my_pid), 0);
+	if (!ASSERT_OK(err, "map_update"))
 		goto out_close;
 
 	/* attach probe */
 	err = test_core_retro__attach(skel);
-	if (CHECK(err, "attach_kprobe", "err %d\n", err))
+	if (!ASSERT_OK(err, "attach_kprobe"))
 		goto out_close;
 
 	/* trigger */
 	usleep(1);
 
-	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.results), &zero, &res);
-	if (CHECK(err, "map_lookup", "failed to lookup result: %d\n", errno))
+	err = bpf_map__lookup_elem(skel->maps.results, &zero, sizeof(zero), &res, sizeof(res), 0);
+	if (!ASSERT_OK(err, "map_lookup"))
 		goto out_close;
 
-	CHECK(res != my_pid, "pid_check", "got %d != exp %d\n", res, my_pid);
+	ASSERT_EQ(res, my_pid, "pid_check");
 
 out_close:
 	test_core_retro__destroy(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/for_each.c b/tools/testing/selftests/bpf/prog_tests/for_each.c
index 754e80937e5d..8963f8a549f2 100644
--- a/tools/testing/selftests/bpf/prog_tests/for_each.c
+++ b/tools/testing/selftests/bpf/prog_tests/for_each.c
@@ -10,9 +10,10 @@ static unsigned int duration;
 
 static void test_hash_map(void)
 {
-	int i, err, hashmap_fd, max_entries, percpu_map_fd;
+	int i, err, max_entries;
 	struct for_each_hash_map_elem *skel;
 	__u64 *percpu_valbuf = NULL;
+	size_t percpu_val_sz;
 	__u32 key, num_cpus;
 	__u64 val;
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
@@ -25,26 +26,27 @@ static void test_hash_map(void)
 	if (!ASSERT_OK_PTR(skel, "for_each_hash_map_elem__open_and_load"))
 		return;
 
-	hashmap_fd = bpf_map__fd(skel->maps.hashmap);
 	max_entries = bpf_map__max_entries(skel->maps.hashmap);
 	for (i = 0; i < max_entries; i++) {
 		key = i;
 		val = i + 1;
-		err = bpf_map_update_elem(hashmap_fd, &key, &val, BPF_ANY);
+		err = bpf_map__update_elem(skel->maps.hashmap, &key, sizeof(key),
+					   &val, sizeof(val), BPF_ANY);
 		if (!ASSERT_OK(err, "map_update"))
 			goto out;
 	}
 
 	num_cpus = bpf_num_possible_cpus();
-	percpu_map_fd = bpf_map__fd(skel->maps.percpu_map);
-	percpu_valbuf = malloc(sizeof(__u64) * num_cpus);
+	percpu_val_sz = sizeof(__u64) * num_cpus;
+	percpu_valbuf = malloc(percpu_val_sz);
 	if (!ASSERT_OK_PTR(percpu_valbuf, "percpu_valbuf"))
 		goto out;
 
 	key = 1;
 	for (i = 0; i < num_cpus; i++)
 		percpu_valbuf[i] = i + 1;
-	err = bpf_map_update_elem(percpu_map_fd, &key, percpu_valbuf, BPF_ANY);
+	err = bpf_map__update_elem(skel->maps.percpu_map, &key, sizeof(key),
+				   percpu_valbuf, percpu_val_sz, BPF_ANY);
 	if (!ASSERT_OK(err, "percpu_map_update"))
 		goto out;
 
@@ -58,7 +60,7 @@ static void test_hash_map(void)
 	ASSERT_EQ(skel->bss->hashmap_elems, max_entries, "hashmap_elems");
 
 	key = 1;
-	err = bpf_map_lookup_elem(hashmap_fd, &key, &val);
+	err = bpf_map__lookup_elem(skel->maps.hashmap, &key, sizeof(key), &val, sizeof(val), 0);
 	ASSERT_ERR(err, "hashmap_lookup");
 
 	ASSERT_EQ(skel->bss->percpu_called, 1, "percpu_called");
@@ -75,9 +77,10 @@ static void test_hash_map(void)
 static void test_array_map(void)
 {
 	__u32 key, num_cpus, max_entries;
-	int i, arraymap_fd, percpu_map_fd, err;
+	int i, err;
 	struct for_each_array_map_elem *skel;
 	__u64 *percpu_valbuf = NULL;
+	size_t percpu_val_sz;
 	__u64 val, expected_total;
 	LIBBPF_OPTS(bpf_test_run_opts, topts,
 		.data_in = &pkt_v4,
@@ -89,7 +92,6 @@ static void test_array_map(void)
 	if (!ASSERT_OK_PTR(skel, "for_each_array_map_elem__open_and_load"))
 		return;
 
-	arraymap_fd = bpf_map__fd(skel->maps.arraymap);
 	expected_total = 0;
 	max_entries = bpf_map__max_entries(skel->maps.arraymap);
 	for (i = 0; i < max_entries; i++) {
@@ -98,21 +100,23 @@ static void test_array_map(void)
 		/* skip the last iteration for expected total */
 		if (i != max_entries - 1)
 			expected_total += val;
-		err = bpf_map_update_elem(arraymap_fd, &key, &val, BPF_ANY);
+		err = bpf_map__update_elem(skel->maps.arraymap, &key, sizeof(key),
+					   &val, sizeof(val), BPF_ANY);
 		if (!ASSERT_OK(err, "map_update"))
 			goto out;
 	}
 
 	num_cpus = bpf_num_possible_cpus();
-	percpu_map_fd = bpf_map__fd(skel->maps.percpu_map);
-	percpu_valbuf = malloc(sizeof(__u64) * num_cpus);
+	percpu_val_sz = sizeof(__u64) * num_cpus;
+	percpu_valbuf = malloc(percpu_val_sz);
 	if (!ASSERT_OK_PTR(percpu_valbuf, "percpu_valbuf"))
 		goto out;
 
 	key = 0;
 	for (i = 0; i < num_cpus; i++)
 		percpu_valbuf[i] = i + 1;
-	err = bpf_map_update_elem(percpu_map_fd, &key, percpu_valbuf, BPF_ANY);
+	err = bpf_map__update_elem(skel->maps.percpu_map, &key, sizeof(key),
+				   percpu_valbuf, percpu_val_sz, BPF_ANY);
 	if (!ASSERT_OK(err, "percpu_map_update"))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
index beebfa9730e1..a767bb4a271c 100644
--- a/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
+++ b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
@@ -112,7 +112,8 @@ static void test_lookup_and_delete_hash(void)
 
 	/* Lookup and delete element. */
 	key = 1;
-	err = bpf_map_lookup_and_delete_elem(map_fd, &key, &value);
+	err = bpf_map__lookup_and_delete_elem(skel->maps.hash_map,
+					      &key, sizeof(key), &value, sizeof(value), 0);
 	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
 		goto cleanup;
 
@@ -147,7 +148,8 @@ static void test_lookup_and_delete_percpu_hash(void)
 
 	/* Lookup and delete element. */
 	key = 1;
-	err = bpf_map_lookup_and_delete_elem(map_fd, &key, value);
+	err = bpf_map__lookup_and_delete_elem(skel->maps.hash_map,
+					      &key, sizeof(key), value, sizeof(value), 0);
 	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
 		goto cleanup;
 
@@ -191,7 +193,8 @@ static void test_lookup_and_delete_lru_hash(void)
 		goto cleanup;
 
 	/* Lookup and delete element 3. */
-	err = bpf_map_lookup_and_delete_elem(map_fd, &key, &value);
+	err = bpf_map__lookup_and_delete_elem(skel->maps.hash_map,
+					      &key, sizeof(key), &value, sizeof(value), 0);
 	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
 		goto cleanup;
 
@@ -240,10 +243,10 @@ static void test_lookup_and_delete_lru_percpu_hash(void)
 		value[i] = 0;
 
 	/* Lookup and delete element 3. */
-	err = bpf_map_lookup_and_delete_elem(map_fd, &key, value);
-	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem")) {
+	err = bpf_map__lookup_and_delete_elem(skel->maps.hash_map,
+					      &key, sizeof(key), value, sizeof(value), 0);
+	if (!ASSERT_OK(err, "bpf_map_lookup_and_delete_elem"))
 		goto cleanup;
-	}
 
 	/* Check if only one CPU has set the value. */
 	for (i = 0; i < nr_cpus; i++) {
diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index 9e2fbda64a65..a0211c294071 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -7,30 +7,35 @@ void test_map_kptr(void)
 {
 	struct map_kptr *skel;
 	int key = 0, ret;
-	char buf[24];
+	char buf[16];
 
 	skel = map_kptr__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "map_kptr__open_and_load"))
 		return;
 
-	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.array_map), &key, buf, 0);
+	ret = bpf_map__update_elem(skel->maps.array_map,
+				   &key, sizeof(key), buf, sizeof(buf), 0);
 	ASSERT_OK(ret, "array_map update");
-	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.array_map), &key, buf, 0);
+	ret = bpf_map__update_elem(skel->maps.array_map,
+				   &key, sizeof(key), buf, sizeof(buf), 0);
 	ASSERT_OK(ret, "array_map update2");
 
-	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.hash_map), &key, buf, 0);
+	ret = bpf_map__update_elem(skel->maps.hash_map,
+				   &key, sizeof(key), buf, sizeof(buf), 0);
 	ASSERT_OK(ret, "hash_map update");
-	ret = bpf_map_delete_elem(bpf_map__fd(skel->maps.hash_map), &key);
+	ret = bpf_map__delete_elem(skel->maps.hash_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "hash_map delete");
 
-	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.hash_malloc_map), &key, buf, 0);
+	ret = bpf_map__update_elem(skel->maps.hash_malloc_map,
+				   &key, sizeof(key), buf, sizeof(buf), 0);
 	ASSERT_OK(ret, "hash_malloc_map update");
-	ret = bpf_map_delete_elem(bpf_map__fd(skel->maps.hash_malloc_map), &key);
+	ret = bpf_map__delete_elem(skel->maps.hash_malloc_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "hash_malloc_map delete");
 
-	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.lru_hash_map), &key, buf, 0);
+	ret = bpf_map__update_elem(skel->maps.lru_hash_map,
+				   &key, sizeof(key), buf, sizeof(buf), 0);
 	ASSERT_OK(ret, "lru_hash_map update");
-	ret = bpf_map_delete_elem(bpf_map__fd(skel->maps.lru_hash_map), &key);
+	ret = bpf_map__delete_elem(skel->maps.lru_hash_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "lru_hash_map delete");
 
 	map_kptr__destroy(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
index e8399ae50e77..9ad09a6c538a 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
@@ -8,7 +8,7 @@ void test_stacktrace_build_id(void)
 	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
 	struct test_stacktrace_build_id *skel;
 	int err, stack_trace_len;
-	__u32 key, previous_key, val, duration = 0;
+	__u32 key, prev_key, val, duration = 0;
 	char buf[256];
 	int i, j;
 	struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
@@ -58,7 +58,7 @@ void test_stacktrace_build_id(void)
 		  "err %d errno %d\n", err, errno))
 		goto cleanup;
 
-	err = bpf_map_get_next_key(stackmap_fd, NULL, &key);
+	err = bpf_map__get_next_key(skel->maps.stackmap, NULL, &key, sizeof(key));
 	if (CHECK(err, "get_next_key from stackmap",
 		  "err %d, errno %d\n", err, errno))
 		goto cleanup;
@@ -79,8 +79,8 @@ void test_stacktrace_build_id(void)
 				if (strstr(buf, build_id) != NULL)
 					build_id_matches = 1;
 			}
-		previous_key = key;
-	} while (bpf_map_get_next_key(stackmap_fd, &previous_key, &key) == 0);
+		prev_key = key;
+	} while (bpf_map__get_next_key(skel->maps.stackmap, &prev_key, &key, sizeof(key)) == 0);
 
 	/* stack_map_get_build_id_offset() is racy and sometimes can return
 	 * BPF_STACK_BUILD_ID_IP instead of BPF_STACK_BUILD_ID_VALID;
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
index f45a1d7b0a28..f4ea1a215ce4 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
@@ -27,7 +27,7 @@ void test_stacktrace_build_id_nmi(void)
 		.type = PERF_TYPE_HARDWARE,
 		.config = PERF_COUNT_HW_CPU_CYCLES,
 	};
-	__u32 key, previous_key, val, duration = 0;
+	__u32 key, prev_key, val, duration = 0;
 	char buf[256];
 	int i, j;
 	struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
@@ -100,7 +100,7 @@ void test_stacktrace_build_id_nmi(void)
 		  "err %d errno %d\n", err, errno))
 		goto cleanup;
 
-	err = bpf_map_get_next_key(stackmap_fd, NULL, &key);
+	err = bpf_map__get_next_key(skel->maps.stackmap, NULL, &key, sizeof(key));
 	if (CHECK(err, "get_next_key from stackmap",
 		  "err %d, errno %d\n", err, errno))
 		goto cleanup;
@@ -108,7 +108,8 @@ void test_stacktrace_build_id_nmi(void)
 	do {
 		char build_id[64];
 
-		err = bpf_map_lookup_elem(stackmap_fd, &key, id_offs);
+		err = bpf_map__lookup_elem(skel->maps.stackmap, &key, sizeof(key),
+					   id_offs, sizeof(id_offs), 0);
 		if (CHECK(err, "lookup_elem from stackmap",
 			  "err %d, errno %d\n", err, errno))
 			goto cleanup;
@@ -121,8 +122,8 @@ void test_stacktrace_build_id_nmi(void)
 				if (strstr(buf, build_id) != NULL)
 					build_id_matches = 1;
 			}
-		previous_key = key;
-	} while (bpf_map_get_next_key(stackmap_fd, &previous_key, &key) == 0);
+		prev_key = key;
+	} while (bpf_map__get_next_key(skel->maps.stackmap, &prev_key, &key, sizeof(key)) == 0);
 
 	/* stack_map_get_build_id_offset() is racy and sometimes can return
 	 * BPF_STACK_BUILD_ID_IP instead of BPF_STACK_BUILD_ID_VALID;
diff --git a/tools/testing/selftests/bpf/prog_tests/timer_mim.c b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
index 2ee5f5ae11d4..9ff7843909e7 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_mim.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
@@ -35,7 +35,7 @@ static int timer_mim(struct timer_mim *timer_skel)
 	ASSERT_EQ(timer_skel->bss->ok, 1 | 2, "ok");
 
 	close(bpf_map__fd(timer_skel->maps.inner_htab));
-	err = bpf_map_delete_elem(bpf_map__fd(timer_skel->maps.outer_arr), &key1);
+	err = bpf_map__delete_elem(timer_skel->maps.outer_arr, &key1, sizeof(key1), 0);
 	ASSERT_EQ(err, 0, "delete inner map");
 
 	/* check that timer_cb[12] are no longer running */
-- 
2.30.2

