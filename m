Return-Path: <bpf+bounces-71429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E17BF2823
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB7E942684A
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EB232ED51;
	Mon, 20 Oct 2025 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qdrc+UKg"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABECC330B3C
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978815; cv=none; b=PqQoSdbVogg8PT8SN6WLiUlTRM5wBDPfWFYppm2MXII3AmeCdyZeds5Tl4y8D8cQAuhAEjey7/weRlEimr2pMxU+gPckQLkPHJd+6U8BjtIFYksrhULaYh2oa55LJWeoSlPW9oDsc5xYpdpIaFePpDCBxDzkupvkyvlaSPGK7qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978815; c=relaxed/simple;
	bh=vG3+Go6UC5T7FOBaderERe8+6lxEQmMeFglvzrhIA0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfT5C8zbgzznlBNL2T8liZQrOIjuzc+LBHZb+3mNo+y9agDI1ff4Pp9O9ugJY7jOfcN6CGix7NMTcGzZIIb5s5ZbhXNgXok49goslCT23Uf5BX+R7WdYB5ZQwYJ+c8rSvFtknbn3l/hqnYugcVE9WCPt6gpW83Lj/HpHZbUj7jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qdrc+UKg; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760978811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYNgGs1ndibKH788F5dG/PgeEGnQ7wEDq1gqnEleHTQ=;
	b=qdrc+UKg5SEvMpkMLZvr0psEkT5nIypk6UmvnhNB+PEUwmZGJM7YYWSSuD4nlFdl6qfzEc
	GfhYrGzpwbzeDsjntq4g3+9XVUxYG0K+piV+sw+gpcwVkWtRfG73V6mkoyzq4UsUpmpvRU
	Gs4KIgI0jA1S01K/Old2DEnSdGcnozQ=
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
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf v2 4/4] selftests/bpf: Add tests to verify no memleak when updating hash and cgrp storage maps
Date: Tue, 21 Oct 2025 00:46:08 +0800
Message-ID: <20251020164608.20536-5-leon.hwang@linux.dev>
In-Reply-To: <20251020164608.20536-1-leon.hwang@linux.dev>
References: <20251020164608.20536-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add tests to verify that updating hash and local storage maps does not
leak memory when BPF_KPTR_REF objects are involved.

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
 .../bpf/prog_tests/refcounted_kptr.c          | 167 +++++++++++++++++-
 .../selftests/bpf/progs/refcounted_kptr.c     | 160 +++++++++++++++++
 2 files changed, 326 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index d6bd5e16e6372..83a59c68e70cb 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -3,7 +3,7 @@
 
 #include <test_progs.h>
 #include <network_helpers.h>
-
+#include "cgroup_helpers.h"
 #include "refcounted_kptr.skel.h"
 #include "refcounted_kptr_fail.skel.h"
 
@@ -44,3 +44,168 @@ void test_refcounted_kptr_wrong_owner(void)
 	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a2 retval");
 	refcounted_kptr__destroy(skel);
 }
+
+static void test_refcnt_leak(void *values, size_t values_sz, u64 flags, struct bpf_map *map,
+			     struct bpf_program *prog_leak, struct bpf_program *prog_check)
+{
+	int ret, fd, key = 0;
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		    .data_in = &pkt_v4,
+		    .data_size_in = sizeof(pkt_v4),
+		    .repeat = 1,
+	);
+
+	ret = bpf_map__update_elem(map, &key, sizeof(key), values, values_sz, flags);
+	if (!ASSERT_OK(ret, "bpf_map__update_elem init"))
+		return;
+
+	fd = bpf_program__fd(prog_leak);
+	ret = bpf_prog_test_run_opts(fd, &opts);
+	if (!ASSERT_OK(ret, "test_run_opts"))
+		return;
+	if (!ASSERT_EQ(opts.retval, 2, "retval refcount"))
+		return;
+
+	ret = bpf_map__update_elem(map, &key, sizeof(key), values, values_sz, flags);
+	if (!ASSERT_OK(ret, "bpf_map__update_elem dec refcount"))
+		return;
+
+	fd = bpf_program__fd(prog_check);
+	ret = bpf_prog_test_run_opts(fd, &opts);
+	ASSERT_OK(ret, "test_run_opts");
+	ASSERT_EQ(opts.retval, 1, "retval");
+}
+
+static void test_percpu_hash_refcount_leak(void)
+{
+	struct refcounted_kptr *skel;
+	size_t values_sz;
+	u64 *values;
+	int cpu_nr;
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
+	test_refcnt_leak(values, values_sz, 0, skel->maps.pcpu_hash,
+			 skel->progs.pcpu_hash_refcount_leak,
+			 skel->progs.check_pcpu_hash_refcount);
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
+
+	skel = refcounted_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load"))
+		return;
+
+	test_refcnt_leak(&value, sizeof(value), BPF_F_LOCK, skel->maps.lock_hash,
+			 skel->progs.hash_lock_refcount_leak,
+			 skel->progs.check_hash_lock_refcount);
+
+	refcounted_kptr__destroy(skel);
+}
+
+static void test_cgroup_storage_lock_refcount_leak(void)
+{
+	int server_fd = -1, client_fd = -1;
+	struct lock_map_value value = {};
+	struct refcounted_kptr *skel;
+	u64 flags = BPF_F_LOCK;
+	struct bpf_link *link;
+	struct bpf_map *map;
+	int cgroup, err;
+
+	cgroup = test__join_cgroup("/cg_refcount_leak");
+	if (!ASSERT_GE(cgroup, 0, "test__join_cgroup"))
+		return;
+
+	skel = refcounted_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "refcounted_kptr__open_and_load"))
+		goto out;
+
+	link = bpf_program__attach_cgroup(skel->progs.cgroup_storage_refcount_leak, cgroup);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_cgroup"))
+		goto out;
+	skel->links.cgroup_storage_refcount_leak = link;
+
+	server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto out;
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
+		goto out;
+
+	map = skel->maps.cgrp_strg;
+	err = bpf_map__lookup_elem(map, &cgroup, sizeof(cgroup), &value, sizeof(value), flags);
+	if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
+		goto out;
+
+	ASSERT_EQ(value.value, 2, "refcount");
+
+	err = bpf_map__update_elem(map, &cgroup, sizeof(cgroup), &value, sizeof(value), flags);
+	if (!ASSERT_OK(err, "bpf_map__update_elem"))
+		goto out;
+
+	err = bpf_link__detach(skel->links.cgroup_storage_refcount_leak);
+	if (!ASSERT_OK(err, "bpf_link__detach"))
+		goto out;
+
+	link = bpf_program__attach(skel->progs.check_cgroup_storage_refcount);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		goto out;
+	skel->links.check_cgroup_storage_refcount = link;
+
+	close(client_fd);
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
+		goto out;
+
+	err = bpf_map__lookup_elem(map, &cgroup, sizeof(cgroup), &value, sizeof(value), flags);
+	if (!ASSERT_OK(err, "bpf_map__lookup_elem"))
+		goto out;
+
+	ASSERT_EQ(value.value, 1, "refcount");
+out:
+	close(cgroup);
+	refcounted_kptr__destroy(skel);
+	if (client_fd >= 0)
+		close(client_fd);
+	if (server_fd >= 0)
+		close(server_fd);
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
index 893a4fdb4b6e9..09efae9537c9b 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -7,6 +7,7 @@
 #include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
+#include "bpf_tracing_net.h"
 
 extern void bpf_rcu_read_lock(void) __ksym;
 extern void bpf_rcu_read_unlock(void) __ksym;
@@ -568,4 +569,163 @@ int BPF_PROG(rbtree_sleepable_rcu_no_explicit_rcu_lock,
 	return 0;
 }
 
+private(leak) u64 ref;
+
+static u32 probe_read_refcount(void)
+{
+	u32 refcnt;
+
+	bpf_probe_read_kernel(&refcnt, sizeof(refcnt), (void *) ref);
+	return refcnt;
+}
+
+static int __insert_in_list(struct bpf_list_head *head, struct bpf_spin_lock *lock,
+			    struct node_data __kptr **node)
+{
+	struct node_data *n, *m;
+
+	n = bpf_obj_new(typeof(*n));
+	if (!n)
+		return -1;
+
+	m = bpf_refcount_acquire(n);
+	n = bpf_kptr_xchg(node, n);
+	if (n) {
+		bpf_obj_drop(n);
+		bpf_obj_drop(m);
+		return -2;
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
+SEC("cgroup/connect6")
+int cgroup_storage_refcount_leak(struct bpf_sock_addr *ctx)
+{
+	struct lock_map_value *v;
+	struct tcp_sock *tsk;
+	struct bpf_sock *sk;
+	u32 refcnt;
+
+	if (ctx->family != AF_INET6 || ctx->user_family != AF_INET6)
+		return 1;
+
+	sk = ctx->sk;
+	if (!sk)
+		return 1;
+
+	tsk = bpf_skc_to_tcp_sock(sk);
+	if (!tsk)
+		return 1;
+
+	v = bpf_cgrp_storage_get(&cgrp_strg, tsk->inet_conn.icsk_inet.sk.sk_cgrp_data.cgroup, 0,
+				 BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!v)
+		return 1;
+
+	refcnt = __insert_in_list(&head, &lock, &v->node);
+	bpf_spin_lock(&v->lock);
+	v->value = refcnt;
+	bpf_spin_unlock(&v->lock);
+	return 1;
+}
+
+SEC("fexit/inet_stream_connect")
+int BPF_PROG(check_cgroup_storage_refcount, struct socket *sock, struct sockaddr *uaddr, int addr_len,
+	     int flags)
+{
+	struct lock_map_value *v;
+	u32 refcnt;
+
+	if (uaddr->sa_family != AF_INET6)
+		return 0;
+
+	v = bpf_cgrp_storage_get(&cgrp_strg, sock->sk->sk_cgrp_data.cgroup, 0, 0);
+	if (!v)
+		return 0;
+
+	refcnt = probe_read_refcount();
+	bpf_spin_lock(&v->lock);
+	v->value = refcnt;
+	bpf_spin_unlock(&v->lock);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.51.0


