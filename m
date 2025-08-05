Return-Path: <bpf+bounces-65078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C27B1B889
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 18:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E56A620921
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3571F8677;
	Tue,  5 Aug 2025 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dP2dqZDh"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F21DD525
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411444; cv=none; b=CdM1QJM3Gh15Rv1Hp+5uSBbJJ2A3eZF7zP/+6/vkMF72WbXLkCXqYUlqkSac8J9Helpof6zmYfczPTYnPAcRHXZzLyfyw66sP9nptgKJT9v0yIzetWcoYZ1XaLZpx11ObUocz1fsin8sVhW8dObco8gTRCTtjS6UyN+hgZ2s8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411444; c=relaxed/simple;
	bh=ND/9dtqIK/5tbAOCHRFR4cYj7x6RV8gXK/wZw06aycw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtgmVPtgCGH5hhO8kBcnSMYtX41bskhefBlmY5fwM4wttt+31HqnoGPiJfEZCCAWOw3lQBww0+XJWs7XKpB3rnTM2FUcTWbMBAIj47mRUGlWcq265CSZZ/SumwH8u0daPDvZhM4tQ1h9Hh3/V5WQQiYv9em+uXQz9oH/b3WKzps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dP2dqZDh; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754411439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNbpuAHIy6hkYp03hpmXj5sg02ppPQE/7Zg7R/M2TjE=;
	b=dP2dqZDh0CoAWTUIsVX7Soy/P0+FqHl4ZvWlQ2fscj7sdkWAykdWGnMIfEkwCLXG2OfNaL
	2NY3yV43ZXqqgoKg94qDtshd0yDJU4e/8GhO4I0FdiitcNf/SfPen6M8L6aAfVDwiRUVR3
	dHVaJIU9BKbCpgCKyaYmfcpYGZ3xLVc=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add case to test BPF_F_CPU
Date: Wed,  6 Aug 2025 00:30:17 +0800
Message-ID: <20250805163017.17015-4-leon.hwang@linux.dev>
In-Reply-To: <20250805163017.17015-1-leon.hwang@linux.dev>
References: <20250805163017.17015-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds test coverage for the new BPF_F_CPU flag support in
percpu_array maps. The following APIs are exercised:

* bpf_map_update_batch()
* bpf_map_lookup_batch()
* bpf_map_update_elem()
* bpf_map__update_elem()
* bpf_map_lookup_elem_flags()
* bpf_map__lookup_elem()

cd tools/testing/selftests/bpf/
./test_progs -t percpu_alloc
253/13  percpu_alloc/cpu_flag_tests:OK
253     percpu_alloc:OK
Summary: 1/13 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 149 ++++++++++++++++++
 .../selftests/bpf/progs/percpu_array_flag.c   |  24 +++
 2 files changed, 173 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_array_flag.c

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
index 343da65864d6d..2500675d489df 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -3,6 +3,7 @@
 #include "percpu_alloc_array.skel.h"
 #include "percpu_alloc_cgrp_local_storage.skel.h"
 #include "percpu_alloc_fail.skel.h"
+#include "percpu_array_flag.skel.h"
 
 static void test_array(void)
 {
@@ -115,6 +116,152 @@ static void test_failure(void) {
 	RUN_TESTS(percpu_alloc_fail);
 }
 
+static void test_cpu_flag(void)
+{
+	int map_fd, *keys = NULL, value_size, cpu, i, j, nr_cpus, err;
+	size_t key_sz = sizeof(int), value_sz = sizeof(u64);
+	u64 batch = 0, *values = NULL, flags;
+	struct percpu_array_flag *skel;
+	const u64 value = 0xDEADC0DE;
+	u32 count, max_entries;
+	struct bpf_map *map;
+	LIBBPF_OPTS(bpf_map_batch_opts, batch_opts);
+
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	skel = percpu_array_flag__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "percpu_array_flag__open_and_load"))
+		return;
+
+	map = skel->maps.percpu;
+	map_fd = bpf_map__fd(map);
+	max_entries = bpf_map__max_entries(map);
+
+	value_size = value_sz * nr_cpus;
+	values = calloc(max_entries, value_size);
+	if (!ASSERT_OK_PTR(values, "calloc values"))
+		goto out;
+	keys = calloc(max_entries, key_sz);
+	if (!ASSERT_OK_PTR(keys, "calloc keys"))
+		goto out;
+
+	for (i = 0; i < max_entries; i++)
+		keys[i] = i;
+	memset(values, 0, max_entries * value_size);
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
+		batch_opts.elem_flags = (u64)BPF_ALL_CPUS << 32 | BPF_F_CPU;
+		err = bpf_map_update_batch(map_fd, keys, values, &max_entries, &batch_opts);
+		if (!ASSERT_OK(err, "bpf_map_update_batch all cpus"))
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
+		if (!ASSERT_TRUE(!err || err == -ENOENT, "bpf_map_lookup_batch all cpus"))
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
+	/* clear value on all cpus */
+	batch_opts.elem_flags = (u64)BPF_ALL_CPUS << 32 | BPF_F_CPU;
+	memset(values, 0, max_entries * value_sz);
+	err = bpf_map_update_batch(map_fd, keys, values, &max_entries, &batch_opts);
+	if (!ASSERT_OK(err, "bpf_map_update_batch all cpus"))
+		goto out;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		/* update value on specified cpu */
+		values[0] = value;
+		flags = (u64)cpu << 32 | BPF_F_CPU;
+		for (i = 0; i < max_entries; i++) {
+			err = bpf_map__update_elem(map, keys + i, key_sz, values, value_sz, flags);
+			if (!ASSERT_OK(err, "bpf_map__update_elem specified cpu"))
+				goto out;
+
+			for (j = 0; j < nr_cpus; j++) {
+				/* lookup then check value on CPUs */
+				flags = (u64)j << 32 | BPF_F_CPU;
+				err = bpf_map__lookup_elem(map, keys + i, key_sz, values, value_sz,
+							   flags);
+				if (!ASSERT_OK(err, "bpf_map__lookup_elem specified cpu"))
+					goto out;
+				if (!ASSERT_EQ(values[0], j != cpu ? 0 : value,
+					       "bpf_map__lookup_elem value on specified cpu"))
+					goto out;
+			}
+		}
+
+		/* clear value on specified cpu */
+		values[0] = 0;
+		flags = (u64)cpu << 32 | BPF_F_CPU;
+		err = bpf_map__update_elem(map, keys, key_sz, values, value_sz, flags);
+		if (!ASSERT_OK(err, "bpf_map__update_elem specified cpu"))
+			goto out;
+	}
+
+out:
+	if (keys)
+		free(keys);
+	if (values)
+		free(values);
+	percpu_array_flag__destroy(skel);
+}
+
 void test_percpu_alloc(void)
 {
 	if (test__start_subtest("array"))
@@ -125,4 +272,6 @@ void test_percpu_alloc(void)
 		test_cgrp_local_storage();
 	if (test__start_subtest("failure_tests"))
 		test_failure();
+	if (test__start_subtest("cpu_flag_tests"))
+		test_cpu_flag();
 }
diff --git a/tools/testing/selftests/bpf/progs/percpu_array_flag.c b/tools/testing/selftests/bpf/progs/percpu_array_flag.c
new file mode 100644
index 0000000000000..4d92e121958ee
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/percpu_array_flag.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, u64);
+} percpu SEC(".maps");
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test_percpu_array, int x)
+{
+	u64 value = 0xDEADC0DE;
+	int key = 0;
+
+	bpf_map_update_elem(&percpu, &key, &value, BPF_ANY);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
+
-- 
2.50.1


