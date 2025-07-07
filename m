Return-Path: <bpf+bounces-62539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 791D1AFB83F
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 18:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DEB31888F59
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532B222577E;
	Mon,  7 Jul 2025 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mcUX4jq7"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044E5209F45
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904273; cv=none; b=UQJJyDemy1XXU/xNboacGUyHl4t4e6M89n95tENcuKn7S9yWliCTZofeAEag9ITsaJXVJ9mZsDG3AAw/qEQTW8T37M4G0UOYGm3wikp96r00Hj7bD4YD2mP+AFFoIJEXU0c3ttP8Yx3QQe+FEhei9kiK1S+4iqQ3aLZ3czAXEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904273; c=relaxed/simple;
	bh=8W2AF453l0RDmRUaaGEyrt2wEVm9irqpmIf7PCUDsDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiP/Uq+HwmEBk1eq4TSbxyQaBZo0K+zCgQszOkuduDJuW5MkM+oo4PFbnbFNQ5X/bGrWANjE2e+aOZ39Wsz+XgfSJrV3yvRlM7q4c68GRmmB+GRt8FH/7RLRr7HlilITllOPpu/7ywrANm4q10yNTQgKCUIVz7cgrlwDQJBEKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mcUX4jq7; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751904268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=om1rKIs/r0QiaOcPXOv0e1W2GAT6TDx3jaw2edjFVCc=;
	b=mcUX4jq79JM/N8sfsJaq6N4IK1/GPxmvjU60Qa4/BUU4Q6WzXuY/lhA6+4sCEPM98AFnLY
	85JUbbYO/LExc4t3AlclOt+leiYRdATWQcs0UWtGUnKmH163jAdvEuPvcTJwGUOITJfAEk
	GIOSWThHo0Xiv0h214GeLzNWYtGE/2k=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v2 3/3] selftests/bpf: Add case to test BPF_F_CPU
Date: Tue,  8 Jul 2025 00:04:04 +0800
Message-ID: <20250707160404.64933-4-leon.hwang@linux.dev>
In-Reply-To: <20250707160404.64933-1-leon.hwang@linux.dev>
References: <20250707160404.64933-1-leon.hwang@linux.dev>
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
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 170 ++++++++++++++++++
 .../selftests/bpf/progs/percpu_array_flag.c   |  24 +++
 2 files changed, 194 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_array_flag.c

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
index 343da65864d6..6f0d0e6dc76a 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -3,6 +3,7 @@
 #include "percpu_alloc_array.skel.h"
 #include "percpu_alloc_cgrp_local_storage.skel.h"
 #include "percpu_alloc_fail.skel.h"
+#include "percpu_array_flag.skel.h"
 
 static void test_array(void)
 {
@@ -115,6 +116,173 @@ static void test_failure(void) {
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
+	keys = calloc(max_entries, key_sz);
+	if (!ASSERT_FALSE(!keys || !values, "calloc keys and values"))
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
@@ -125,4 +293,6 @@ void test_percpu_alloc(void)
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
2.50.0


