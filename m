Return-Path: <bpf+bounces-63664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE5B09513
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 21:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769177A961B
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC8A2FC3D5;
	Thu, 17 Jul 2025 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QFQ1T0kj"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D3D2080C4
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781119; cv=none; b=L4ZyasBGCjIqX4aKt+08RuM0k7NykmK5ibqBGY+TEGCwO7KNdvkLqg1JrA5QjZwKaa/lTCb6oa1biuhp1R+14wEeUEu82ssSQnTzX7E8TifoQc3JGBNOPxDFgE+LGZFHUFHQKbMkOT69OUSFHGOPAA8OuiITdkSAM+fs6/4PLBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781119; c=relaxed/simple;
	bh=mpJSy73cvQwQ9eKc6ImIdEHylV/du/dAAa5BhCEdfgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5G0UHBfqQBi5CFhyy1Taoe1zyRzZQtPvO1DBogfAHiNNUGKvrAkbKQpXHZWIlyyIffsBJVnbaIfySmjkFUx/2l30eE59O9Yi5mV2OkLOi8dqVcx3GuIjJsk7ladVtTBUZAwURJB6i7kpV4df40twjC9TFuuXN3vr998o51XqwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QFQ1T0kj; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752781114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54S2WUlrE3h6hlMRPiHGte8JRH1tNYyH5qrHOuJIagI=;
	b=QFQ1T0kjNCaEKvolNWK5JXZFB1jEShCFbSVL3acWVZhGLwXJYu/10I/7F2ZmFAcu3p1mjc
	/G8zVkCcUJsXRO6yvHcaUe+JcPlb9Cl51fV2StLFG9wbLY+ky21WONu7T566wv2+x8+9Z+
	xdY1dHjlNO7h99P7p6omGgO3y2brYhU=
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
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add case to test BPF_F_CPU
Date: Fri, 18 Jul 2025 03:37:56 +0800
Message-ID: <20250717193756.37153-4-leon.hwang@linux.dev>
In-Reply-To: <20250717193756.37153-1-leon.hwang@linux.dev>
References: <20250717193756.37153-1-leon.hwang@linux.dev>
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
* bpf_map_update_elem_opts()
* bpf_map__update_elem_opts()
* bpf_map_lookup_elem_opts()
* bpf_map__lookup_elem_opts()

cd tools/testing/selftests/bpf/
./test_progs -t percpu_alloc/cpu_flag_tests
253/13  percpu_alloc/cpu_flag_tests:OK
253     percpu_alloc:OK
Summary: 1/13 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 172 ++++++++++++++++++
 .../selftests/bpf/progs/percpu_array_flag.c   |  24 +++
 2 files changed, 196 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_array_flag.c

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
index 343da65864d6..2bf4e6f1d357 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -3,6 +3,7 @@
 #include "percpu_alloc_array.skel.h"
 #include "percpu_alloc_cgrp_local_storage.skel.h"
 #include "percpu_alloc_fail.skel.h"
+#include "percpu_array_flag.skel.h"
 
 static void test_array(void)
 {
@@ -115,6 +116,175 @@ static void test_failure(void) {
 	RUN_TESTS(percpu_alloc_fail);
 }
 
+static void test_cpu_flag(void)
+{
+	int map_fd, *keys = NULL, value_size, cpu, i, j, nr_cpus, err;
+	size_t key_sz = sizeof(int), value_sz = sizeof(u64);
+	struct percpu_array_flag *skel;
+	u64 batch = 0, *values = NULL;
+	const u64 value = 0xDEADC0DE;
+	u32 count, max_entries;
+	struct bpf_map *map;
+	LIBBPF_OPTS(bpf_map_lookup_elem_opts, lookup_opts,
+		    .flags = BPF_F_CPU,
+		    .cpu = 0,
+	);
+	LIBBPF_OPTS(bpf_map_update_elem_opts, update_opts,
+		    .flags = BPF_F_CPU,
+		    .cpu = 0,
+	);
+	LIBBPF_OPTS(bpf_map_batch_opts, batch_opts,
+		    .elem_flags = BPF_F_CPU,
+		    .flags = 0,
+	);
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
+	batch_opts.cpu = nr_cpus;
+	err = bpf_map_update_batch(map_fd, keys, values, &max_entries, &batch_opts);
+	if (!ASSERT_EQ(err, -E2BIG, "bpf_map_update_batch -E2BIG"))
+		goto out;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		memset(values, 0, max_entries * value_size);
+
+		/* clear values on all CPUs */
+		batch_opts.cpu = BPF_ALL_CPUS;
+		batch_opts.elem_flags = BPF_F_CPU;
+		err = bpf_map_update_batch(map_fd, keys, values, &max_entries, &batch_opts);
+		if (!ASSERT_OK(err, "bpf_map_update_batch all cpus"))
+			goto out;
+
+		/* update values on current CPU */
+		for (i = 0; i < max_entries; i++)
+			values[i] = value;
+
+		batch_opts.cpu = cpu;
+		err = bpf_map_update_batch(map_fd, keys, values, &max_entries, &batch_opts);
+		if (!ASSERT_OK(err, "bpf_map_update_batch current cpu"))
+			goto out;
+
+		/* lookup values on current CPU */
+		batch_opts.cpu = cpu;
+		batch_opts.elem_flags = BPF_F_CPU;
+		memset(values, 0, max_entries * value_sz);
+		err = bpf_map_lookup_batch(map_fd, NULL, &batch, keys, values, &count, &batch_opts);
+		if (!ASSERT_TRUE(!err || err == -ENOENT, "bpf_map_lookup_batch current cpu"))
+			goto out;
+
+		for (i = 0; i < max_entries; i++)
+			if (!ASSERT_EQ(values[i], value, "value on current cpu"))
+				goto out;
+
+		/* lookup values on all CPUs */
+		batch_opts.cpu = 0;
+		batch_opts.elem_flags = 0;
+		memset(values, 0, max_entries * value_size);
+		err = bpf_map_lookup_batch(map_fd, NULL, &batch, keys, values, &count, &batch_opts);
+		if (!ASSERT_TRUE(!err || err == -ENOENT, "bpf_map_lookup_batch all cpus"))
+			goto out;
+
+		for (i = 0; i < max_entries; i++) {
+			for (j = 0; j < nr_cpus; j++) {
+				if (!ASSERT_EQ(values[i*nr_cpus + j], j != cpu ? 0 : value,
+					       "value on cpu"))
+					goto out;
+			}
+		}
+	}
+
+	update_opts.cpu = nr_cpus;
+	err = bpf_map_update_elem_opts(map_fd, keys, values, &update_opts);
+	if (!ASSERT_EQ(err, -E2BIG, "bpf_map_update_elem_opts -E2BIG"))
+		goto out;
+
+	err = bpf_map__update_elem_opts(map, keys, key_sz, values, value_sz,
+					&update_opts);
+	if (!ASSERT_EQ(err, -E2BIG, "bpf_map__update_elem_opts -E2BIG"))
+		goto out;
+
+	lookup_opts.cpu = nr_cpus;
+	err = bpf_map_lookup_elem_opts(map_fd, keys, values, &lookup_opts);
+	if (!ASSERT_EQ(err, -E2BIG, "bpf_map_lookup_elem_opts -E2BIG"))
+		goto out;
+
+	err = bpf_map__lookup_elem_opts(map, keys, key_sz, values, value_sz,
+					&lookup_opts);
+	if (!ASSERT_EQ(err, -E2BIG, "bpf_map__lookup_elem_opts -E2BIG"))
+		goto out;
+
+	/* clear value on all cpus */
+	batch_opts.cpu = BPF_ALL_CPUS;
+	batch_opts.elem_flags = BPF_F_CPU;
+	memset(values, 0, max_entries * value_sz);
+	err = bpf_map_update_batch(map_fd, keys, values, &max_entries, &batch_opts);
+	if (!ASSERT_OK(err, "bpf_map_update_batch all cpus"))
+		goto out;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		/* update value on current cpu */
+		values[0] = value;
+		update_opts.cpu = cpu;
+		for (i = 0; i < max_entries; i++) {
+			err = bpf_map__update_elem_opts(map, keys + i,
+							key_sz, values,
+							value_sz, &update_opts);
+			if (!ASSERT_OK(err, "bpf_map__update_elem_opts current cpu"))
+				goto out;
+
+			for (j = 0; j < nr_cpus; j++) {
+				/* lookup then check value on CPUs */
+				lookup_opts.cpu = j;
+				err = bpf_map__lookup_elem_opts(map, keys + i,
+								key_sz, values,
+								value_sz,
+								&lookup_opts);
+				if (!ASSERT_OK(err, "bpf_map__lookup_elem_opts current cpu"))
+					goto out;
+				if (!ASSERT_EQ(values[0], j != cpu ? 0 : value,
+					       "bpf_map__lookup_elem_opts value on current cpu"))
+					goto out;
+			}
+		}
+
+		/* clear value on current cpu */
+		values[0] = 0;
+		err = bpf_map__update_elem_opts(map, keys, key_sz, values,
+						value_sz, &update_opts);
+		if (!ASSERT_OK(err, "bpf_map__update_elem_opts current cpu"))
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
@@ -125,4 +295,6 @@ void test_percpu_alloc(void)
 		test_cgrp_local_storage();
 	if (test__start_subtest("failure_tests"))
 		test_failure();
+	if (test__start_subtest("cpu_flag_tests"))
+		test_cpu_flag();
 }
diff --git a/tools/testing/selftests/bpf/progs/percpu_array_flag.c b/tools/testing/selftests/bpf/progs/percpu_array_flag.c
new file mode 100644
index 000000000000..4d92e121958e
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


