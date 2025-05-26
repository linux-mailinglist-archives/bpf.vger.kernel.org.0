Return-Path: <bpf+bounces-58947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A199AC42F3
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 18:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9A33BBC24
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 16:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D81323D29F;
	Mon, 26 May 2025 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PM0Xie+5"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8054323E320
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748276542; cv=none; b=BvX3AJx6yZY4yj1l+ESqsywz43EjzRGUZ36pD8YEluOG+SjUvavzOppnosHieyhfV3KNZMqOKSJOeF7LM2L0H0xVnb0sEMmlA6Qe0E1RZCr3XYEcRBYLgsxwSjvfCOnUCdzQDZoJviAvSOhLATfk56Mq6dn2BdSAOAQ7WqKDpUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748276542; c=relaxed/simple;
	bh=iLIQh4P1mmL63JrzKdEIcAMyTluCD12NclMqdW7pD5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rA7/P3Gm0vh/NC+C4mWunqZOZYNDMBOUUGszW9DUK36OsMWw6T+saIv98UWrIXn9hGdgD7CkwgKJNHx2q3b3A9DaUZWTvCeI5W72d7tTsHLO6+5H2Vrcky0NgQL3IJa6AHCjunfq7oq+bcgUjTXInWntDlDXtcV9fv/el7D9470=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PM0Xie+5; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748276538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WW3nvTv7z4kuuWFxikm2af58NXNpQY6XSLAGtrA6pA4=;
	b=PM0Xie+5g0uUjx7XEkyL75pWNch9wxw6ePJvd+vKtShiZTvRoglgkqAagCl8j7fyzACI6u
	fRRVzFrnBSbpB0dPntEf1W17s0hxWx82X8m9qT7DLdAyUIguJK8HuTDwLQm3+Q90aWFngk
	Fv5ZwMwv7uFJrOzGBgwwC8WUPtUT3KE=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Add cases to test global percpu data
Date: Tue, 27 May 2025 00:21:46 +0800
Message-ID: <20250526162146.24429-5-leon.hwang@linux.dev>
In-Reply-To: <20250526162146.24429-1-leon.hwang@linux.dev>
References: <20250526162146.24429-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If the arch, like s390x, does not support percpu insn, these cases won't
test global percpu data by checking -EOPNOTSUPP after loading prog.

The following APIs have been tested for global percpu data:
1. bpf_map__set_initial_value()
2. bpf_map__initial_value()
3. generated percpu struct pointer pointing to internal map's mmaped data
4. bpf_map__lookup_elem() for global percpu data map
5. bpf_map__is_internal_percpu()

At the same time, the case is also tested with 'bpftool gen skeleton -L'.

cd tools/testing/selftests/bpf; ./test_progs -t global_percpu_data
132     global_percpu_data_init:OK
133     global_percpu_data_lskel:OK
Summary: 2/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../bpf/prog_tests/global_data_init.c         | 221 +++++++++++++++++-
 .../bpf/progs/test_global_percpu_data.c       |  29 +++
 3 files changed, 250 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index cf5ed3bee573e..26121f53fa420 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -503,7 +503,7 @@ LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
-	kfunc_call_test_subprog.c
+	kfunc_call_test_subprog.c test_global_percpu_data.c
 SKEL_BLACKLIST += $$(LSKELS)
 
 test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.bpf.o
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 8466332d7406f..51fdc9c190cac 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "bpf/libbpf_internal.h"
+#include "test_global_percpu_data.skel.h"
+#include "test_global_percpu_data.lskel.h"
 
 void test_global_data_init(void)
 {
@@ -8,7 +11,7 @@ void test_global_data_init(void)
 	__u8 *buff = NULL, *newval = NULL;
 	struct bpf_object *obj;
 	struct bpf_map *map;
-        __u32 duration = 0;
+	__u32 duration = 0;
 	size_t sz;
 
 	obj = bpf_object__open_file(file, NULL);
@@ -60,3 +63,219 @@ void test_global_data_init(void)
 	free(newval);
 	bpf_object__close(obj);
 }
+
+void test_global_percpu_data_init(void)
+{
+	struct test_global_percpu_data__data__percpu init_value, *init_data, *data, *percpu_data;
+	int key, prog_fd, err, num_cpus, num_online, i;
+	struct test_global_percpu_data *skel = NULL;
+	__u64 args[2] = {0x1234ULL, 0x5678ULL};
+	size_t elem_sz, init_data_sz;
+	struct bpf_map *map;
+	bool *online;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .ctx_in = args,
+		    .ctx_size_in = sizeof(args),
+		    .flags = BPF_F_TEST_RUN_ON_CPU,
+	);
+
+	num_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	err = parse_cpu_mask_file("/sys/devices/system/cpu/online",
+				  &online, &num_online);
+	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
+		return;
+
+	elem_sz = sizeof(*percpu_data);
+	percpu_data = calloc(num_cpus, elem_sz);
+	if (!ASSERT_OK_PTR(percpu_data, "calloc percpu_data"))
+		goto out;
+
+	skel = test_global_percpu_data__open();
+	if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
+		goto out;
+	if (!ASSERT_OK_PTR(skel->data__percpu, "skel->data__percpu"))
+		goto out;
+
+	ASSERT_EQ(skel->data__percpu->data, -1, "skel->data__percpu->data");
+	ASSERT_FALSE(skel->data__percpu->run, "skel->data__percpu->run");
+	ASSERT_EQ(skel->data__percpu->nums[6], 0, "skel->data__percpu->nums[6]");
+	ASSERT_EQ(skel->data__percpu->struct_data.i, -1, "struct_data.i");
+	ASSERT_FALSE(skel->data__percpu->struct_data.set, "struct_data.set");
+	ASSERT_EQ(skel->data__percpu->struct_data.nums[6], 0, "struct_data.nums[6]");
+
+	map = skel->maps.data__percpu;
+	if (!ASSERT_EQ(bpf_map__type(map), BPF_MAP_TYPE_PERCPU_ARRAY, "bpf_map__type"))
+		goto out;
+	if (!ASSERT_TRUE(bpf_map__is_internal_percpu(map), "bpf_map__is_internal_percpu"))
+		goto out;
+
+	init_value.data = 2;
+	init_value.nums[6] = -1;
+	init_value.struct_data.i = 2;
+	init_value.struct_data.nums[6] = -1;
+	err = bpf_map__set_initial_value(map, &init_value, sizeof(init_value));
+	if (!ASSERT_OK(err, "bpf_map__set_initial_value"))
+		goto out;
+
+	init_data = bpf_map__initial_value(map, &init_data_sz);
+	if (!ASSERT_OK_PTR(init_data, "bpf_map__initial_value"))
+		goto out;
+
+	ASSERT_EQ(init_data->data, init_value.data, "init_value data");
+	ASSERT_EQ(init_data->run, init_value.run, "init_value run");
+	ASSERT_EQ(init_data->struct_data.i, init_value.struct_data.i,
+		  "init_value struct_data.i");
+	ASSERT_EQ(init_data->struct_data.nums[6],
+		  init_value.struct_data.nums[6],
+		  "init_value struct_data.nums[6]");
+	ASSERT_EQ(init_data_sz, sizeof(init_value), "init_value size");
+	ASSERT_EQ((void *) init_data, (void *) skel->data__percpu,
+		  "skel->data__percpu eq init_data");
+	ASSERT_EQ(skel->data__percpu->data, init_value.data,
+		  "skel->data__percpu->data");
+	ASSERT_EQ(skel->data__percpu->run, init_value.run,
+		  "skel->data__percpu->run");
+	ASSERT_EQ(skel->data__percpu->struct_data.i, init_value.struct_data.i,
+		  "skel->data__percpu->struct_data.i");
+	ASSERT_EQ(skel->data__percpu->struct_data.nums[6],
+		  init_value.struct_data.nums[6],
+		  "skel->data__percpu->struct_data.nums[6]");
+
+	err = test_global_percpu_data__load(skel);
+	if (err == -EOPNOTSUPP) {
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
+		goto out;
+
+	ASSERT_NULL(skel->data__percpu, "skel->data__percpu");
+
+	err = test_global_percpu_data__attach(skel);
+	if (!ASSERT_OK(err, "test_global_percpu_data__attach"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel->progs.update_percpu_data);
+
+	/* run on every CPU */
+	for (i = 0; i < num_online; i++) {
+		if (!online[i])
+			continue;
+
+		topts.cpu = i;
+		topts.retval = 0;
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		ASSERT_OK(err, "bpf_prog_test_run_opts");
+		ASSERT_EQ(topts.retval, 0, "bpf_prog_test_run_opts retval");
+	}
+
+	key = 0;
+	err = bpf_map__lookup_elem(map, &key, sizeof(key), percpu_data,
+				   elem_sz * num_cpus, 0);
+	if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
+		goto out;
+
+	for (i = 0; i < num_online; i++) {
+		if (!online[i])
+			continue;
+
+		data = percpu_data + i;
+		ASSERT_EQ(data->data, 1, "percpu_data->data");
+		ASSERT_TRUE(data->run, "percpu_data->run");
+		ASSERT_EQ(data->nums[6], 0xc0de, "percpu_data->nums[6]");
+		ASSERT_EQ(data->struct_data.i, 1, "struct_data.i");
+		ASSERT_TRUE(data->struct_data.set, "struct_data.set");
+		ASSERT_EQ(data->struct_data.nums[6], 0xc0de, "struct_data.nums[6]");
+	}
+
+out:
+	test_global_percpu_data__destroy(skel);
+	if (percpu_data)
+		free(percpu_data);
+	free(online);
+}
+
+void test_global_percpu_data_lskel(void)
+{
+	struct test_global_percpu_data__data__percpu *data, *percpu_data;
+	int key, prog_fd, map_fd, err, num_cpus, num_online, i;
+	struct test_global_percpu_data_lskel *lskel = NULL;
+	__u64 args[2] = {0x1234ULL, 0x5678ULL};
+	bool *online;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .ctx_in = args,
+		    .ctx_size_in = sizeof(args),
+		    .flags = BPF_F_TEST_RUN_ON_CPU,
+	);
+
+	num_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	err = parse_cpu_mask_file("/sys/devices/system/cpu/online",
+				  &online, &num_online);
+	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
+		return;
+
+	percpu_data = calloc(num_cpus, sizeof(*percpu_data));
+	if (!ASSERT_OK_PTR(percpu_data, "calloc percpu_data"))
+		goto out;
+
+	lskel = test_global_percpu_data_lskel__open();
+	if (!ASSERT_OK_PTR(lskel, "test_global_percpu_data_lskel__open"))
+		goto out;
+
+	err = test_global_percpu_data_lskel__load(lskel);
+	if (err == -EOPNOTSUPP) {
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_OK(err, "test_global_percpu_data_lskel__load"))
+		goto out;
+
+	err = test_global_percpu_data_lskel__attach(lskel);
+	if (!ASSERT_OK(err, "test_global_percpu_data_lskel__attach"))
+		goto out;
+
+	prog_fd = lskel->progs.update_percpu_data.prog_fd;
+
+	/* run on every CPU */
+	for (i = 0; i < num_online; i++) {
+		if (!online[i])
+			continue;
+
+		topts.cpu = i;
+		topts.retval = 0;
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		ASSERT_OK(err, "bpf_prog_test_run_opts");
+		ASSERT_EQ(topts.retval, 0, "bpf_prog_test_run_opts retval");
+	}
+
+	key = 0;
+	map_fd = lskel->maps.data__percpu.map_fd;
+	err = bpf_map_lookup_elem(map_fd, &key, percpu_data);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		goto out;
+
+	for (i = 0; i < num_online; i++) {
+		if (!online[i])
+			continue;
+
+		data = percpu_data + i;
+		ASSERT_EQ(data->data, 1, "percpu_data->data");
+		ASSERT_TRUE(data->run, "percpu_data->run");
+		ASSERT_EQ(data->nums[6], 0xc0de, "percpu_data->nums[6]");
+		ASSERT_EQ(data->struct_data.i, 1, "struct_data.i");
+		ASSERT_TRUE(data->struct_data.set, "struct_data.set");
+		ASSERT_EQ(data->struct_data.nums[6], 0xc0de, "struct_data.nums[6]");
+	}
+
+out:
+	test_global_percpu_data_lskel__destroy(lskel);
+	if (percpu_data)
+		free(percpu_data);
+	free(online);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
new file mode 100644
index 0000000000000..2cf8566b5465f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+int data SEC(".data..percpu") = -1;
+char run SEC(".data..percpu") = 0;
+int nums[7] SEC(".data..percpu");
+struct {
+	char set;
+	int i;
+	int nums[7];
+} struct_data SEC(".data..percpu") = {
+	.set = 0,
+	.i = -1,
+};
+
+SEC("raw_tp/task_rename")
+int update_percpu_data(struct __sk_buff *skb)
+{
+	struct_data.nums[6] = 0xc0de;
+	struct_data.set = 1;
+	struct_data.i = 1;
+	nums[6] = 0xc0de;
+	data = 1;
+	run = 1;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.49.0


