Return-Path: <bpf+bounces-73039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6167C20EB9
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 16:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FB8F4EB81D
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CCF363B89;
	Thu, 30 Oct 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U7jloeTH"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898DB363363
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837963; cv=none; b=RFOxTTuBnGi0TfEj7HGoyaNI2uOLXpQc0Ob/6PkJw/QEoCrMeKzNGajYTvDqCIpoYytiYcRUahAfhwxD6iSQLaHKZZk65c12mpEVwiyCVGhbv/2WHoMsn/vn7qW+uUrnDRKaYdt1df82PKOBHTg8pVnxko21kS3IGtbZylz49Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837963; c=relaxed/simple;
	bh=jvy1Eb3PmqABBKxpsTcON/POtQ/qj+v8F/oF0lZz51A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFV+DFay9j4IrlfrVIV4kpUMCE9FiAHJU3TS3dteCoo1ThiTRx9SbHCpYiHUZCyQdPgiEMkOwFhpTX486JThxtj6H0U3MeinVrkct3kgnklpZfRs4CgxPODzbqxO6vmPw5ttbL/abEKy8nnxtv3v3jWWHopmyfFetwiw0nIf5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U7jloeTH; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761837958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vg1HmdjWPqR7MRQoIa6eFE7P3tDnDAjv+S/N3RgV7ds=;
	b=U7jloeTHKUK6ahYFcfIFkfbPuoKGc5/o9uNkYz9+7ZTESO2WyMZKJ9HZIu3N7MyEptFHzw
	vkF4KyVFkUhMvbDUgbYqGB2ERkoDDsbuk+pUFWCEVMoPhTx9PEwcik9I5kTOPDAYTJfWKt
	q9fN+RyezUHx4D/d17QBPzPUFCaiEJg=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	ameryhung@gmail.com,
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: Add tests to verify freeing the special fields when update hash and local storage maps
Date: Thu, 30 Oct 2025 23:24:51 +0800
Message-ID: <20251030152451.62778-5-leon.hwang@linux.dev>
In-Reply-To: <20251030152451.62778-1-leon.hwang@linux.dev>
References: <20251030152451.62778-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add tests to verify that updating hash and local storage maps decrements
refcount when BPF_KPTR_REF objects are involved.

The tests perform the following steps:

1. Call update_elem() to insert an initial value.
2. Use bpf_refcount_acquire() to increment the refcount.
3. Store the node pointer in the map value.
4. Add the node to a linked list.
5. Probe-read the refcount and verify it is *2*.
6. Call update_elem() again to trigger refcount decrement.
7. Probe-read the refcount and verify it is *1*.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/refcounted_kptr.c          | 134 +++++++++++++++++-
 .../selftests/bpf/progs/refcounted_kptr.c     | 129 +++++++++++++++++
 2 files changed, 262 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index d6bd5e16e6372..0ec91ff914af7 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -3,7 +3,7 @@
 
 #include <test_progs.h>
 #include <network_helpers.h>
-
+#include "cgroup_helpers.h"
 #include "refcounted_kptr.skel.h"
 #include "refcounted_kptr_fail.skel.h"
 
@@ -44,3 +44,135 @@ void test_refcounted_kptr_wrong_owner(void)
 	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a2 retval");
 	refcounted_kptr__destroy(skel);
 }
+
+static void test_refcnt_leak(struct refcounted_kptr *skel, int key, void *values, size_t values_sz,
+			     u64 flags, struct bpf_map *map, struct bpf_program *prog_leak,
+			     struct bpf_program *prog_check, struct bpf_test_run_opts *opts)
+{
+	int ret, fd;
+
+	ret = bpf_map__update_elem(map, &key, sizeof(key), values, values_sz, flags);
+	if (!ASSERT_OK(ret, "bpf_map__update_elem init"))
+		return;
+
+	fd = bpf_program__fd(prog_leak);
+	ret = bpf_prog_test_run_opts(fd, opts);
+	if (!ASSERT_OK(ret, "bpf_prog_test_run_opts"))
+		return;
+	if (!ASSERT_EQ(skel->bss->kptr_refcount, 2, "refcount"))
+		return;
+
+	ret = bpf_map__update_elem(map, &key, sizeof(key), values, values_sz, flags);
+	if (!ASSERT_OK(ret, "bpf_map__update_elem dec refcount"))
+		return;
+
+	fd = bpf_program__fd(prog_check);
+	ret = bpf_prog_test_run_opts(fd, opts);
+	ASSERT_OK(ret, "bpf_prog_test_run_opts");
+	ASSERT_EQ(skel->bss->kptr_refcount, 1, "refcount");
+}
+
+static void test_percpu_hash_refcount_leak(void)
+{
+	struct refcounted_kptr *skel;
+	size_t values_sz;
+	u64 *values;
+	int cpu_nr;
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4),
+		    .repeat = 1,
+	);
+
+	cpu_nr = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(cpu_nr, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	values = calloc(cpu_nr, sizeof(u64));
+	if (!ASSERT_OK_PTR(values, "calloc values"))
+		return;
+
+	skel = refcounted_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load")) {
+		free(values);
+		return;
+	}
+
+	values_sz = cpu_nr * sizeof(u64);
+	memset(values, 0, values_sz);
+
+	test_refcnt_leak(skel, 0, values, values_sz, 0, skel->maps.pcpu_hash,
+			 skel->progs.pcpu_hash_refcount_leak,
+			 skel->progs.check_pcpu_hash_refcount, &opts);
+
+	refcounted_kptr__destroy(skel);
+	free(values);
+}
+
+struct lock_map_value {
+	u64 kptr;
+	struct bpf_spin_lock lock;
+	int value;
+};
+
+static void test_hash_lock_refcount_leak(void)
+{
+	struct lock_map_value value = {};
+	struct refcounted_kptr *skel;
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4),
+		    .repeat = 1,
+	);
+
+	skel = refcounted_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load"))
+		return;
+
+	test_refcnt_leak(skel, 0, &value, sizeof(value), BPF_F_LOCK, skel->maps.lock_hash,
+			 skel->progs.hash_lock_refcount_leak,
+			 skel->progs.check_hash_lock_refcount, &opts);
+
+	refcounted_kptr__destroy(skel);
+}
+
+static void test_cgroup_storage_lock_refcount_leak(void)
+{
+	struct lock_map_value value = {};
+	struct refcounted_kptr *skel;
+	int cgroup, err;
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		return;
+
+	cgroup = get_root_cgroup();
+	if (!ASSERT_GE(cgroup, 0, "get_root_cgroup")) {
+		cleanup_cgroup_environment();
+		return;
+	}
+
+	skel = refcounted_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load"))
+		goto out;
+
+	test_refcnt_leak(skel, cgroup, &value, sizeof(value), BPF_F_LOCK, skel->maps.cgrp_strg,
+			 skel->progs.cgroup_storage_lock_refcount_leak,
+			 skel->progs.check_cgroup_storage_lock_refcount, &opts);
+
+	refcounted_kptr__destroy(skel);
+out:
+	close(cgroup);
+	cleanup_cgroup_environment();
+}
+
+void test_kptr_refcount_leak(void)
+{
+	if (test__start_subtest("percpu_hash_refcount_leak"))
+		test_percpu_hash_refcount_leak();
+	if (test__start_subtest("hash_lock_refcount_leak"))
+		test_hash_lock_refcount_leak();
+	if (test__start_subtest("cgroup_storage_lock_refcount_leak"))
+		test_cgroup_storage_lock_refcount_leak();
+}
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 893a4fdb4b6e9..101ba630d93e8 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -568,4 +568,133 @@ int BPF_PROG(rbtree_sleepable_rcu_no_explicit_rcu_lock,
 	return 0;
 }
 
+private(kptr_ref) u64 ref;
+u32 kptr_refcount;
+
+static int probe_read_refcount(void)
+{
+	bpf_probe_read_kernel(&kptr_refcount, sizeof(kptr_refcount), (void *) ref);
+	return 0;
+}
+
+static int __insert_in_list(struct bpf_list_head *head, struct bpf_spin_lock *lock,
+			    struct node_data __kptr **node)
+{
+	struct node_data *n, *m;
+
+	n = bpf_obj_new(typeof(*n));
+	if (!n)
+		return 0;
+
+	m = bpf_refcount_acquire(n);
+	n = bpf_kptr_xchg(node, n);
+	if (n) {
+		bpf_obj_drop(n);
+		bpf_obj_drop(m);
+		return 0;
+	}
+
+	bpf_spin_lock(lock);
+	bpf_list_push_front(head, &m->l);
+	ref = (u64)(void *) &m->ref;
+	bpf_spin_unlock(lock);
+	return probe_read_refcount();
+}
+
+static void *__lookup_map(void *map)
+{
+	int key = 0;
+
+	return bpf_map_lookup_elem(map, &key);
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} pcpu_hash SEC(".maps");
+
+SEC("tc")
+int pcpu_hash_refcount_leak(void *ctx)
+{
+	struct map_value *v;
+
+	v = __lookup_map(&pcpu_hash);
+	if (!v)
+		return 0;
+
+	return __insert_in_list(&head, &lock, &v->node);
+}
+
+SEC("tc")
+int check_pcpu_hash_refcount(void *ctx)
+{
+	return probe_read_refcount();
+}
+
+struct lock_map_value {
+	struct node_data __kptr *node;
+	struct bpf_spin_lock lock;
+	int value;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, struct lock_map_value);
+	__uint(max_entries, 1);
+} lock_hash SEC(".maps");
+
+SEC("tc")
+int hash_lock_refcount_leak(void *ctx)
+{
+	struct lock_map_value *v;
+
+	v = __lookup_map(&lock_hash);
+	if (!v)
+		return 0;
+
+	bpf_spin_lock(&v->lock);
+	v->value = 42;
+	bpf_spin_unlock(&v->lock);
+	return __insert_in_list(&head, &lock, &v->node);
+}
+
+SEC("tc")
+int check_hash_lock_refcount(void *ctx)
+{
+	return probe_read_refcount();
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct lock_map_value);
+} cgrp_strg SEC(".maps");
+
+SEC("syscall")
+int BPF_PROG(cgroup_storage_lock_refcount_leak)
+{
+	struct lock_map_value *v;
+	struct task_struct *task;
+
+	task = bpf_get_current_task_btf();
+	bpf_rcu_read_lock();
+	v = bpf_cgrp_storage_get(&cgrp_strg, task->cgroups->dfl_cgrp, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	bpf_rcu_read_unlock();
+	if (!v)
+		return 0;
+
+	return __insert_in_list(&head, &lock, &v->node);
+}
+
+SEC("syscall")
+int BPF_PROG(check_cgroup_storage_lock_refcount)
+{
+	return probe_read_refcount();
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.51.1


