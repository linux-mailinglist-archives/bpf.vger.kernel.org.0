Return-Path: <bpf+bounces-48703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB97A0BBBC
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 16:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8651623B5
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774CB240258;
	Mon, 13 Jan 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T7aOLI+G"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3050B240251
	for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781913; cv=none; b=MLbtCyBl4YVXScuQLqLLpBPCnHcOab1o5QtCSxFQfOOF/aELzwXPlZdg6+23oXX4b7vEp1aLiXrquEE5EKt7jkqE0jiuDjFKviVx1+t6ALDR+lHH6Jr9obACgK4Vq6rlvrhpVwKAf1ieXPnS8NzHMsfhU4Q9Ib5UNUeRJDb23WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781913; c=relaxed/simple;
	bh=e7xXB+6ORnajGpRlL2bFKaGrOmTsLAem73wWSnnQ5UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NY5YzkYUJx2e/cYZy/Sgpx4tpYbS14GVdYyUVjlz/4F7YiR3ge0ASghgsb56l9Duaj9RoDwviVBapKkT/5cwoLYdMzkEuGQ4uOYYfDDzCJ4WkPWFKdFaIqteWN/E4zjnS5aTAe/RJToDBO/S/dcJrTMHdo+KPSDR46vxVkOjbG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T7aOLI+G; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736781909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pFYVCpRGcLSmyBVmB+8s2302SUUqr8f3yfySdSEGbgo=;
	b=T7aOLI+Gl9DFG6nDy0AbYOhrZEbKkkX/nkuiA7jybFWKVlgneggIKsUiGbJvQGclZxg4rH
	GhVWbJp7r051nhl2gNXAx2oVomMN5ng54oHXai0bIpb/cluN3iAsjthPHoYG08vjEaYkp7
	Ng4UttM8My3hvWxdIDrrU58Pj+rThO0=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: Add a case to test global percpu data
Date: Mon, 13 Jan 2025 23:24:37 +0800
Message-ID: <20250113152437.67196-3-leon.hwang@linux.dev>
In-Reply-To: <20250113152437.67196-1-leon.hwang@linux.dev>
References: <20250113152437.67196-1-leon.hwang@linux.dev>
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

cd tools/testing/selftests/bpf; ./test_progs -t global_percpu_data
124     global_percpu_data_init:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/global_data_init.c         | 83 ++++++++++++++++++-
 .../bpf/progs/test_global_percpu_data.c       | 21 +++++
 2 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 8466332d7406f..634ff531bf5a4 100644
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
@@ -60,3 +61,83 @@ void test_global_data_init(void)
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
+	map = skel->maps.data__percpu;
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
+	ASSERT_EQ(percpu_data[skel->bss->curr_cpu], 1, "percpu_data");
+	if (num_cpus > 1)
+		ASSERT_EQ(percpu_data[(skel->bss->curr_cpu+1)%num_cpus],
+			  init_value, "init_value");
+
+out:
+	test_global_percpu_data__destroy(skel);
+	if (percpu_data)
+		free(percpu_data);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
new file mode 100644
index 0000000000000..2f01051b782c6
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
+int percpu_data SEC(".data..percpu");
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


