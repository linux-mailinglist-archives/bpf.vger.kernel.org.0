Return-Path: <bpf+bounces-49871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D48A1DA70
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 17:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C4B163EB6
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 16:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23941547F2;
	Mon, 27 Jan 2025 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Eyp/pzIK"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060A415442D
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994974; cv=none; b=TU+e6B4D8TWvIbQfMJyTPLXJFqGBg9GQUfG7MZ6b9Gaen7tk3iZWFKCP6SmqpRT1/ezEj+0/N1W4e1SgnRathTyfdzwlUO0AqosvqXg3pJoZAg+lQ/t6OC94zk6g5AZM57dUsOOv65zV0kcJnQyublFgd4huTofN1414LUc1fQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994974; c=relaxed/simple;
	bh=zXF+iIWfXeqpjqcalFixwr56iIRI0Gz3CXU1eGflHTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCl4EtEM/q6jv+86g0v/h8XrBW/0eicMF/RgZqWydOcdI35O/3GJM4HlKnAkBNV+CfBzuog4zN9lHUsZ7ulz1ZpdQnXpch1bWwzxbZzTsp8IIiu8kBQAKdT9V1/Y9LfT8UBJNXO4VvS1h5n0Tk2elBOZi+Hh/fLHw2NvCpueTY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Eyp/pzIK; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737994970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1J1mQJZm9dOclTH351NApfaEMSuhjnTGy0CaWvBwMus=;
	b=Eyp/pzIK7hJXyZMAFDD0dRxuXyAb8qFSWsQZoIj3x+xFMK6wCmk55ZFshcw4v592RzwtQJ
	ijhfy6qW4cxqIAFeK+FsApIwssbzDTbfelUMNTn2liqcHFYa8V4BQbhHEfZOQsZFtTV4Id
	dYXwSqjypu7yBfFOxn3GwYyLy6L+VY4=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add a case to test global percpu data
Date: Tue, 28 Jan 2025 00:21:58 +0800
Message-ID: <20250127162158.84906-5-leon.hwang@linux.dev>
In-Reply-To: <20250127162158.84906-1-leon.hwang@linux.dev>
References: <20250127162158.84906-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If the arch, like s390x, does not support percpu insn, this case won't
test global percpu data by checking -EOPNOTSUPP when load prog.

The following APIs have been tested for global percpu data:
1. bpf_map__set_initial_value()
2. bpf_map__initial_value()
3. generated percpu struct pointer that points to internal map's data
4. bpf_map__lookup_elem() for global percpu data map

cd tools/testing/selftests/bpf; ./test_progs -t global_percpu_data
124     global_percpu_data_init:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/global_data_init.c         | 89 ++++++++++++++++++-
 .../bpf/progs/test_global_percpu_data.c       | 21 +++++
 2 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 8466332d7406f..a5d0890444f67 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "test_global_percpu_data.skel.h"
 
 void test_global_data_init(void)
 {
@@ -8,7 +9,7 @@ void test_global_data_init(void)
 	__u8 *buff = NULL, *newval = NULL;
 	struct bpf_object *obj;
 	struct bpf_map *map;
-        __u32 duration = 0;
+	__u32 duration = 0;
 	size_t sz;
 
 	obj = bpf_object__open_file(file, NULL);
@@ -60,3 +61,89 @@ void test_global_data_init(void)
 	free(newval);
 	bpf_object__close(obj);
 }
+
+void test_global_percpu_data_init(void)
+{
+	struct test_global_percpu_data *skel = NULL;
+	u64 *percpu_data = NULL;
+	struct bpf_map *map;
+	size_t init_data_sz;
+	char buff[128] = {};
+	int init_value = 2;
+	int key, value_sz;
+	int prog_fd, err;
+	int *init_data;
+	int num_cpus;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = buff,
+		    .data_size_in = sizeof(buff),
+		    .repeat = 1,
+	);
+
+	num_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	percpu_data = calloc(num_cpus, sizeof(*percpu_data));
+	if (!ASSERT_FALSE(percpu_data == NULL, "calloc percpu_data"))
+		return;
+
+	value_sz = sizeof(*percpu_data) * num_cpus;
+	memset(percpu_data, 0, value_sz);
+
+	skel = test_global_percpu_data__open();
+	if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
+		goto out;
+
+	ASSERT_EQ(skel->percpu->percpu_data, -1, "skel->percpu->percpu_data");
+
+	map = skel->maps.percpu;
+	err = bpf_map__set_initial_value(map, &init_value,
+					 sizeof(init_value));
+	if (!ASSERT_OK(err, "bpf_map__set_initial_value"))
+		goto out;
+
+	init_data = bpf_map__initial_value(map, &init_data_sz);
+	if (!ASSERT_OK_PTR(init_data, "bpf_map__initial_value"))
+		goto out;
+
+	ASSERT_EQ(*init_data, init_value, "initial_value");
+	ASSERT_EQ(init_data_sz, sizeof(init_value), "initial_value size");
+
+	if (!ASSERT_EQ((void *) init_data, (void *) skel->percpu, "skel->percpu"))
+		goto out;
+	ASSERT_EQ(skel->percpu->percpu_data, init_value, "skel->percpu->percpu_data");
+
+	err = test_global_percpu_data__load(skel);
+	if (err == -EOPNOTSUPP)
+		goto out;
+	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
+		goto out;
+
+	ASSERT_EQ(bpf_map__type(map), BPF_MAP_TYPE_PERCPU_ARRAY,
+		  "bpf_map__type");
+
+	prog_fd = bpf_program__fd(skel->progs.update_percpu_data);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "update_percpu_data");
+	ASSERT_EQ(topts.retval, 0, "update_percpu_data retval");
+
+	key = 0;
+	err = bpf_map__lookup_elem(map, &key, sizeof(key), percpu_data,
+				   value_sz, 0);
+	if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
+		goto out;
+
+	if (!ASSERT_LT(skel->bss->curr_cpu, num_cpus, "curr_cpu"))
+		goto out;
+	ASSERT_EQ((int) percpu_data[skel->bss->curr_cpu], 1, "percpu_data");
+	if (num_cpus > 1)
+		ASSERT_EQ((int) percpu_data[(skel->bss->curr_cpu+1)%num_cpus],
+			  init_value, "init_value");
+
+out:
+	test_global_percpu_data__destroy(skel);
+	if (percpu_data)
+		free(percpu_data);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
new file mode 100644
index 0000000000000..731c3214b0bb4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Leon Hwang */
+
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+
+#include <bpf/bpf_helpers.h>
+
+int percpu_data SEC(".percpu") = -1;
+int curr_cpu;
+
+SEC("tc")
+int update_percpu_data(struct __sk_buff *skb)
+{
+	curr_cpu = bpf_get_smp_processor_id();
+	percpu_data = 1;
+
+	return TC_ACT_OK;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


