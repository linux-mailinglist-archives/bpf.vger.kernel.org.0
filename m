Return-Path: <bpf+bounces-68039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA68B51DA4
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 18:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252D11C8233F
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255D73375B1;
	Wed, 10 Sep 2025 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RWamZ+ER"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905C1335BB8
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521724; cv=none; b=hgfK1yg/V2iGVL0j71bZU1VVLNtL7wdfGKI+8Y6u6P4Ele0rr3bVYWFslll6uN+51Ljdd+d6U6U4tsl2IeOR58UbFlvsfFgaSz3eK1PDhkDeMnFVXc79By0pW2BuGZdEHWoyec0GGgDkZfZqZbBRmSEUV4kPDl0aCNAWVysjMaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521724; c=relaxed/simple;
	bh=52SVDhAZOzcAQfi6MpfJhoSnxL6rrE1g6tSyxIxoa4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yj4qgAppOUdWHi9Yh2cGVXVC6sqx8vAPbBcq+s25sr6kjMNtxpbQ2RyD/c2VJyLx0NtfTR6eV8oprDHR06gYiLyUs8HL3h2kxlWIBsV7V7ukWdAKUOZzhxfIrFjjl7JszXpbQgoPW/+DI5m/EKj/kEcsjPfclgq3v9aJhCdYge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RWamZ+ER; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757521720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NaKKXPowhxLLBLmYs2d0c2ww9TKp9cIZF1u5SNwDTyg=;
	b=RWamZ+ER/DsVtlHJMF/CYfUfCCbjI0I4yBMkjS0lwPh3pBCs47v9QusbRAXXI0WIytDpqf
	NTeyeqehVqVxECgUkmJ6TBnQZZHnB1UGrLE+hVf0zKGSWabstMgzSgHV9iSQEU/coOYgxb
	gPXGeunK8fwbAsJKzDeE5e1zSPNVBiA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	jolsa@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v7 7/7] selftests/bpf: Add cases to test BPF_F_CPU and BPF_F_ALL_CPUS flags
Date: Thu, 11 Sep 2025 00:27:33 +0800
Message-ID: <20250910162733.82534-8-leon.hwang@linux.dev>
In-Reply-To: <20250910162733.82534-1-leon.hwang@linux.dev>
References: <20250910162733.82534-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add test coverage for the new BPF_F_CPU and BPF_F_ALL_CPUS flags support
in percpu maps. The following APIs are exercised:

* bpf_map_update_batch()
* bpf_map_lookup_batch()
* bpf_map_update_elem()
* bpf_map__update_elem()
* bpf_map_lookup_elem_flags()
* bpf_map__lookup_elem()

cd tools/testing/selftests/bpf/
./test_progs -t percpu_alloc
253/13  percpu_alloc/cpu_flag_percpu_array:OK
253/14  percpu_alloc/cpu_flag_percpu_hash:OK
253/15  percpu_alloc/cpu_flag_lru_percpu_hash:OK
253/16  percpu_alloc/cpu_flag_percpu_cgroup_storage:OK
253     percpu_alloc:OK
Summary: 1/16 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 233 ++++++++++++++++++
 .../selftests/bpf/progs/percpu_alloc_array.c  |  32 +++
 2 files changed, 265 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
index 343da65864d6d..fcc51e2a325b4 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "cgroup_helpers.h"
 #include "percpu_alloc_array.skel.h"
 #include "percpu_alloc_cgrp_local_storage.skel.h"
 #include "percpu_alloc_fail.skel.h"
@@ -115,6 +116,230 @@ static void test_failure(void) {
 	RUN_TESTS(percpu_alloc_fail);
 }
 
+static void test_percpu_map_op_cpu_flag(struct bpf_map *map, void *keys, size_t key_sz,
+					u32 max_entries, bool test_batch)
+{
+	int i, j, cpu, map_fd, value_size, nr_cpus, err;
+	u64 *values = NULL, batch = 0, flags;
+	const u64 value = 0xDEADC0DE;
+	size_t value_sz = sizeof(u64);
+	u32 count = max_entries;
+	LIBBPF_OPTS(bpf_map_batch_opts, batch_opts);
+
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	value_size = value_sz * nr_cpus;
+	values = calloc(max_entries, value_size);
+	if (!ASSERT_OK_PTR(values, "calloc values"))
+		goto out;
+	memset(values, 0, value_size * max_entries);
+
+	map_fd = bpf_map__fd(map);
+	flags = BPF_F_CPU | BPF_F_ALL_CPUS;
+	err = bpf_map_lookup_elem_flags(map_fd, keys, values, flags);
+	if (!ASSERT_ERR(err, "bpf_map_lookup_elem_flags err"))
+		goto out;
+
+	err = bpf_map_update_elem(map_fd, keys, values, flags);
+	if (!ASSERT_ERR(err, "bpf_map_update_elem err"))
+		goto out;
+
+	flags = (u64)nr_cpus << 32 | BPF_F_CPU;
+	err = bpf_map_update_elem(map_fd, keys, values, flags);
+	if (!ASSERT_EQ(err, -ERANGE, "bpf_map_update_elem -ERANGE"))
+		goto out;
+
+	err = bpf_map__update_elem(map, keys, key_sz, values, value_sz, flags);
+	if (!ASSERT_EQ(err, -ERANGE, "bpf_map__update_elem -ERANGE"))
+		goto out;
+
+	err = bpf_map_lookup_elem_flags(map_fd, keys, values, flags);
+	if (!ASSERT_EQ(err, -ERANGE, "bpf_map_lookup_elem_flags -ERANGE"))
+		goto out;
+
+	err = bpf_map__lookup_elem(map, keys, key_sz, values, value_sz, flags);
+	if (!ASSERT_EQ(err, -ERANGE, "bpf_map__lookup_elem -ERANGE"))
+		goto out;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		/* clear value on all cpus */
+		values[0] = 0;
+		flags = BPF_F_ALL_CPUS;
+		for (i = 0; i < max_entries; i++) {
+			err = bpf_map__update_elem(map, keys + i * key_sz, key_sz, values,
+						   value_sz, flags);
+			if (!ASSERT_OK(err, "bpf_map__update_elem all_cpus"))
+				goto out;
+		}
+
+		/* update value on specified cpu */
+		for (i = 0; i < max_entries; i++) {
+			values[0] = value;
+			flags = (u64)cpu << 32 | BPF_F_CPU;
+			err = bpf_map__update_elem(map, keys + i * key_sz, key_sz, values,
+						   value_sz, flags);
+			if (!ASSERT_OK(err, "bpf_map__update_elem specified cpu"))
+				goto out;
+
+			/* lookup then check value on CPUs */
+			for (j = 0; j < nr_cpus; j++) {
+				flags = (u64)j << 32 | BPF_F_CPU;
+				err = bpf_map__lookup_elem(map, keys + i * key_sz, key_sz, values,
+							   value_sz, flags);
+				if (!ASSERT_OK(err, "bpf_map__lookup_elem specified cpu"))
+					goto out;
+				if (!ASSERT_EQ(values[0], j != cpu ? 0 : value,
+					       "bpf_map__lookup_elem value on specified cpu"))
+					goto out;
+			}
+		}
+	}
+
+	if (!test_batch)
+		goto out;
+
+	batch_opts.elem_flags = (u64)nr_cpus << 32 | BPF_F_CPU;
+	err = bpf_map_update_batch(map_fd, keys, values, &max_entries, &batch_opts);
+	if (!ASSERT_EQ(err, -ERANGE, "bpf_map_update_batch -ERANGE"))
+		goto out;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		memset(values, 0, max_entries * value_size);
+
+		/* clear values across all CPUs */
+		batch_opts.elem_flags = BPF_F_ALL_CPUS;
+		err = bpf_map_update_batch(map_fd, keys, values, &max_entries, &batch_opts);
+		if (!ASSERT_OK(err, "bpf_map_update_batch all_cpus"))
+			goto out;
+
+		/* update values on specified CPU */
+		for (i = 0; i < max_entries; i++)
+			values[i] = value;
+
+		batch_opts.elem_flags = (u64)cpu << 32 | BPF_F_CPU;
+		err = bpf_map_update_batch(map_fd, keys, values, &max_entries, &batch_opts);
+		if (!ASSERT_OK(err, "bpf_map_update_batch specified cpu"))
+			goto out;
+
+		/* lookup values on specified CPU */
+		memset(values, 0, max_entries * value_sz);
+		err = bpf_map_lookup_batch(map_fd, NULL, &batch, keys, values, &count, &batch_opts);
+		if (!ASSERT_TRUE(!err || err == -ENOENT, "bpf_map_lookup_batch specified cpu"))
+			goto out;
+
+		for (i = 0; i < max_entries; i++)
+			if (!ASSERT_EQ(values[i], value, "value on specified cpu"))
+				goto out;
+
+		/* lookup values from all CPUs */
+		batch_opts.elem_flags = 0;
+		memset(values, 0, max_entries * value_size);
+		err = bpf_map_lookup_batch(map_fd, NULL, &batch, keys, values, &count, &batch_opts);
+		if (!ASSERT_TRUE(!err || err == -ENOENT, "bpf_map_lookup_batch all_cpus"))
+			goto out;
+
+		for (i = 0; i < max_entries; i++) {
+			for (j = 0; j < nr_cpus; j++) {
+				if (!ASSERT_EQ(values[i*nr_cpus + j], j != cpu ? 0 : value,
+					       "value on specified cpu"))
+					goto out;
+			}
+		}
+	}
+
+out:
+	if (values)
+		free(values);
+}
+
+static void test_percpu_map_cpu_flag(enum bpf_map_type map_type)
+{
+	struct percpu_alloc_array *skel;
+	size_t key_sz = sizeof(int);
+	int *keys = NULL, i, err;
+	struct bpf_map *map;
+	u32 max_entries;
+
+	skel = percpu_alloc_array__open();
+	if (!ASSERT_OK_PTR(skel, "percpu_alloc_array__open"))
+		return;
+
+	map = skel->maps.percpu;
+	bpf_map__set_type(map, map_type);
+
+	err = percpu_alloc_array__load(skel);
+	if (!ASSERT_OK(err, "test_percpu_alloc__load"))
+		goto out;
+
+	max_entries = bpf_map__max_entries(map);
+	keys = calloc(max_entries, key_sz);
+	if (!ASSERT_OK_PTR(keys, "calloc keys"))
+		goto out;
+
+	for (i = 0; i < max_entries; i++)
+		keys[i] = i;
+
+	test_percpu_map_op_cpu_flag(map, keys, key_sz, max_entries, true);
+out:
+	if (keys)
+		free(keys);
+	percpu_alloc_array__destroy(skel);
+}
+
+static void test_percpu_array_cpu_flag(void)
+{
+	test_percpu_map_cpu_flag(BPF_MAP_TYPE_PERCPU_ARRAY);
+}
+
+static void test_percpu_hash_cpu_flag(void)
+{
+	test_percpu_map_cpu_flag(BPF_MAP_TYPE_PERCPU_HASH);
+}
+
+static void test_lru_percpu_hash_cpu_flag(void)
+{
+	test_percpu_map_cpu_flag(BPF_MAP_TYPE_LRU_PERCPU_HASH);
+}
+
+static void test_percpu_cgroup_storage_cpu_flag(void)
+{
+	struct bpf_cgroup_storage_key key;
+	struct percpu_alloc_array *skel;
+	int cgroup = -1, prog_fd, err;
+	struct bpf_map *map;
+
+	skel = percpu_alloc_array__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "percpu_alloc_array__open_and_load"))
+		return;
+
+	cgroup = create_and_get_cgroup("/cg_percpu");
+	if (!ASSERT_GE(cgroup, 0, "create_and_get_cgroup"))
+		goto out;
+
+	err = join_cgroup("/cg_percpu");
+	if (!ASSERT_OK(err, "join_cgroup"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.cgroup_egress);
+	err = bpf_prog_attach(prog_fd, cgroup, BPF_CGROUP_INET_EGRESS, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	map = skel->maps.percpu_cgroup_storage;
+	err = bpf_map_get_next_key(bpf_map__fd(map), NULL, &key);
+	if (!ASSERT_OK(err, "bpf_map_get_next_key"))
+		goto out;
+
+	test_percpu_map_op_cpu_flag(map, &key, sizeof(key), 1, false);
+out:
+	bpf_prog_detach2(-1, cgroup, BPF_CGROUP_INET_EGRESS);
+	close(cgroup);
+	cleanup_cgroup_environment();
+	percpu_alloc_array__destroy(skel);
+}
+
 void test_percpu_alloc(void)
 {
 	if (test__start_subtest("array"))
@@ -125,4 +350,12 @@ void test_percpu_alloc(void)
 		test_cgrp_local_storage();
 	if (test__start_subtest("failure_tests"))
 		test_failure();
+	if (test__start_subtest("cpu_flag_percpu_array"))
+		test_percpu_array_cpu_flag();
+	if (test__start_subtest("cpu_flag_percpu_hash"))
+		test_percpu_hash_cpu_flag();
+	if (test__start_subtest("cpu_flag_lru_percpu_hash"))
+		test_lru_percpu_hash_cpu_flag();
+	if (test__start_subtest("cpu_flag_percpu_cgroup_storage"))
+		test_percpu_cgroup_storage_cpu_flag();
 }
diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_array.c b/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
index 37c2d2608ec0b..427301909c349 100644
--- a/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
@@ -187,4 +187,36 @@ int BPF_PROG(test_array_map_10)
 	return 0;
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, u64);
+} percpu SEC(".maps");
+
+SEC("?fentry/bpf_fentry_test1")
+int BPF_PROG(test_percpu_array, int x)
+{
+	u64 value = 0xDEADC0DE;
+	int key = 0;
+
+	bpf_map_update_elem(&percpu, &key, &value, BPF_ANY);
+	return 0;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
+	__type(key, struct bpf_cgroup_storage_key);
+	__type(value, u64);
+} percpu_cgroup_storage SEC(".maps");
+
+SEC("cgroup_skb/egress")
+int cgroup_egress(struct __sk_buff *skb)
+{
+	u64 *val = bpf_get_local_storage(&percpu_cgroup_storage, 0);
+
+	__sync_fetch_and_add(val, 1);
+	return 1;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.50.1


