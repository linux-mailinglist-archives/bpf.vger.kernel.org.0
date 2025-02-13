Return-Path: <bpf+bounces-51439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00764A34A05
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D24F173D62
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D17727126A;
	Thu, 13 Feb 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gJGH7AHX"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452D221571
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463608; cv=none; b=Gkf5B3QtGyIWv09kidslp/MsmO3YHOQII1o+MtXNrwxi4GmnR0kyN/PacNShqbWBfSuV6F7CWcJ4LKj0wiju+CK3Y+mGtm0tM+ic368nt6Whr7PDC4TwSSIa8+yJmvMDeTGLIUa8ZPd5A9bSaSn6/3ery3y4PXUsVETwZJMZKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463608; c=relaxed/simple;
	bh=KRoino9/JfLlmszYGJT45OqM6emDq3ZKsw1YtEN+cwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kij0gSHfKnRhS+/lwf4B77QXp574dy+paxqBMT+vpnE6o2ajhsmIbpL8ly5yi0TgAVC0/EHXNSq12xxNuX/SSMjB0Zc6Hpj/Inp2MlM1TObzRk3U1L/OV9KDDT6JwVldZC7lYGPaDbVQkyI18baUnzyRJa50hzNLFjVsiZfVVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gJGH7AHX; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739463603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9qeF6w52i6Hnwmtxr1UbcOKL5ocv4qD1kNlAk4pCRQ=;
	b=gJGH7AHXF0KDH5G4u38SbGHcO3oQpg3qYE3jiaiRTmXk1FnzQGXGewO248+rqcG8cc8ntX
	DnaKUAcbOm5egO/4WZt9RwNzATsXvAeddpm1BE6TxOd2jXATyUg2CM22i+R+N1oAGIVqjC
	s9l8b9KunoFs9FJfrPqVDg4mWii4si0=
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
Subject: [RESEND PATCH bpf-next v2 4/4] selftests/bpf: Add cases to test global percpu data
Date: Fri, 14 Feb 2025 00:19:31 +0800
Message-ID: <20250213161931.46399-5-leon.hwang@linux.dev>
In-Reply-To: <20250213161931.46399-1-leon.hwang@linux.dev>
References: <20250213161931.46399-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If the arch, like s390x, does not support percpu insn, this case won't
test global percpu data by checking -EOPNOTSUPP after loading prog.

The following APIs have been tested for global percpu data:
1. bpf_map__set_initial_value()
2. bpf_map__initial_value()
3. generated percpu struct pointer pointing to internal map's mmaped
4. bpf_map__lookup_elem() for global percpu data map
5. bpf_map__is_internal_percpu()

At the same time, the case is also tested with 'bpftool gen skeleton -L'.

125     global_percpu_data_init:OK
126     global_percpu_data_lskel:OK
Summary: 2/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../bpf/prog_tests/global_data_init.c         | 217 +++++++++++++++++-
 .../bpf/progs/test_global_percpu_data.c       |  20 ++
 3 files changed, 237 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_data.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0d552bfcfe7da..7991de79d55c5 100644
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
index 8466332d7406f..5ace86a0eace7 100644
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
@@ -60,3 +63,215 @@ void test_global_data_init(void)
 	free(newval);
 	bpf_object__close(obj);
 }
+
+void test_global_percpu_data_init(void)
+{
+	struct test_global_percpu_data__percpu init_value, *init_data, *data, *percpu_data;
+	int key, prog_fd, err, num_cpus, num_online, comm_fd = -1, i;
+	struct test_global_percpu_data *skel = NULL;
+	__u64 args[2] = {0x1234ULL, 0x5678ULL};
+	size_t elem_sz, init_data_sz;
+	char buf[] = "new_name";
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
+	if (!ASSERT_OK_PTR(skel->percpu, "skel->percpu"))
+		goto out;
+
+	ASSERT_EQ(skel->percpu->data, -1, "skel->percpu->data");
+	ASSERT_FALSE(skel->percpu->run, "skel->percpu->run");
+	ASSERT_EQ(skel->percpu->data2, 0, "skel->percpu->data2");
+
+	map = skel->maps.percpu;
+	if (!ASSERT_EQ(bpf_map__type(map), BPF_MAP_TYPE_PERCPU_ARRAY, "bpf_map__type"))
+		goto out;
+	if (!ASSERT_TRUE(bpf_map__is_internal_percpu(map), "bpf_map__is_internal_percpu"))
+		goto out;
+
+	init_value.data = 2;
+	init_value.run = false;
+	err = bpf_map__set_initial_value(map, &init_value, sizeof(init_value));
+	if (!ASSERT_OK(err, "bpf_map__set_initial_value"))
+		goto out;
+
+	init_data = bpf_map__initial_value(map, &init_data_sz);
+	if (!ASSERT_OK_PTR(init_data, "bpf_map__initial_value"))
+		goto out;
+
+	ASSERT_EQ(init_data->data, init_value.data, "initial_value data");
+	ASSERT_EQ(init_data->run, init_value.run, "initial_value run");
+	ASSERT_EQ(init_data_sz, sizeof(init_value), "initial_value size");
+	ASSERT_EQ((void *) init_data, (void *) skel->percpu, "skel->percpu eq init_data");
+	ASSERT_EQ(skel->percpu->data, init_value.data, "skel->percpu->data");
+	ASSERT_EQ(skel->percpu->run, init_value.run, "skel->percpu->run");
+
+	err = test_global_percpu_data__load(skel);
+	if (err == -EOPNOTSUPP) {
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
+		goto out;
+
+	ASSERT_NULL(skel->percpu, "NULL skel->percpu");
+
+	err = test_global_percpu_data__attach(skel);
+	if (!ASSERT_OK(err, "test_global_percpu_data__attach"))
+		goto out;
+
+	comm_fd = open("/proc/self/comm", O_WRONLY|O_TRUNC);
+	if (!ASSERT_GE(comm_fd, 0, "open /proc/self/comm"))
+		goto out;
+
+	err = write(comm_fd, buf, sizeof(buf));
+	if (!ASSERT_GE(err, 0, "task rename"))
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
+		ASSERT_EQ(data->data2, 0xc0de, "percpu_data->data2");
+	}
+
+out:
+	close(comm_fd);
+	test_global_percpu_data__destroy(skel);
+	if (percpu_data)
+		free(percpu_data);
+	free(online);
+}
+
+void test_global_percpu_data_lskel(void)
+{
+	int key, prog_fd, map_fd, err, num_cpus, num_online, comm_fd = -1, i;
+	struct test_global_percpu_data__percpu *data, *percpu_data;
+	struct test_global_percpu_data_lskel *lskel = NULL;
+	__u64 args[2] = {0x1234ULL, 0x5678ULL};
+	char buf[] = "new_name";
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
+	comm_fd = open("/proc/self/comm", O_WRONLY|O_TRUNC);
+	if (!ASSERT_GE(comm_fd, 0, "open /proc/self/comm"))
+		goto out;
+
+	err = write(comm_fd, buf, sizeof(buf));
+	if (!ASSERT_GE(err, 0, "task rename"))
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
+	map_fd = lskel->maps.percpu.map_fd;
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
+		ASSERT_EQ(data->data2, 0xc0de, "percpu_data->data2");
+	}
+
+out:
+	close(comm_fd);
+	test_global_percpu_data_lskel__destroy(lskel);
+	if (percpu_data)
+		free(percpu_data);
+	free(online);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
new file mode 100644
index 0000000000000..ada292d3a164c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Leon Hwang */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+int data SEC(".percpu") = -1;
+int run SEC(".percpu") = 0;
+int data2 SEC(".percpu");
+
+SEC("raw_tp/task_rename")
+int update_percpu_data(struct __sk_buff *skb)
+{
+	data = 1;
+	run = 1;
+	data2 = 0xc0de;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.1


