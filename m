Return-Path: <bpf+bounces-72253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3411EC0ACD9
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 16:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DB418870F5
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34282E8E10;
	Sun, 26 Oct 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sFrBEqMr"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6A273809
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761493269; cv=none; b=V3SGj23A2+0Kr6ySiQWOZ6Kk2oIZPzME1Ij0ukiAnBcFGX4wPbIjlGOCnft/rR8jk3FV6Gk2kH+RNF6wSxtQ3kB7JZBXFcytwZr4n7fxi9E8x87iKG4oPOgnbLZ9GWy7K1c56BKmvjzGfhSEP376Fptvnm59K42R53pQ8siWCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761493269; c=relaxed/simple;
	bh=C3zkqmEN+0VKTKhHfs/UaVL0bK8vWpsQGcqgmrbpIG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6ESj/z2KVK7HIhIgnHFbRhYjCNwOvnZjBJZPiZiQVy2rOGk5Fc5qufutof075AD4RMsZ924ALcSgPOa8CMpjklkXhHq27D2AKYSOq/pAc3SuRQQVpQ3FHZYUFhi/a2gW5NqzoLj1lGfQH4+fPAj0XsWkkn4HwRhUsQ+9qGAvh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sFrBEqMr; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761493264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqcmwyQ2OLmdmL3C4h4UHcEZUs1IdL0HZCQ+ZeNIF+g=;
	b=sFrBEqMrXOLWm23MyiVBMoVab2PmNuJdZHQvKcVwS1JKHDNsW1aO97lSJ+xl4T/jd6/TU9
	adzf2hPhSzG7+2hLJ8ZzwLaAv5uQrrPAZLT6FXJHugjkNcyZNpvPdK5e9mkDkxYUJ2qSui
	v+StlZCos1zVEs66EM4OpKeTOYnawAE=
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
Subject: [PATCH bpf v3 4/4] selftests/bpf: Add tests to verify freeing the special fields when update hash and local storage maps
Date: Sun, 26 Oct 2025 23:40:00 +0800
Message-ID: <20251026154000.34151-5-leon.hwang@linux.dev>
In-Reply-To: <20251026154000.34151-1-leon.hwang@linux.dev>
References: <20251026154000.34151-1-leon.hwang@linux.dev>
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
 .../bpf/prog_tests/refcounted_kptr.c          | 178 +++++++++++++++++-
 .../selftests/bpf/progs/refcounted_kptr.c     | 160 ++++++++++++++++
 2 files changed, 337 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index d6bd5e16e6372..0a60330a1f4b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -3,7 +3,7 @@
 
 #include <test_progs.h>
 #include <network_helpers.h>
-
+#include "cgroup_helpers.h"
 #include "refcounted_kptr.skel.h"
 #include "refcounted_kptr_fail.skel.h"
 
@@ -44,3 +44,179 @@ void test_refcounted_kptr_wrong_owner(void)
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
+static void test_cgrp_storage_refcount_leak(u64 flags)
+{
+	int server_fd = -1, client_fd = -1;
+	struct lock_map_value value = {};
+	struct refcounted_kptr *skel;
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
+static void test_cgroup_storage_refcount_leak(void)
+{
+	test_cgrp_storage_refcount_leak(0);
+}
+
+static void test_cgroup_storage_lock_refcount_leak(void)
+{
+	test_cgrp_storage_refcount_leak(BPF_F_LOCK);
+}
+
+void test_kptr_refcount_leak(void)
+{
+	if (test__start_subtest("percpu_hash_refcount_leak"))
+		test_percpu_hash_refcount_leak();
+	if (test__start_subtest("hash_lock_refcount_leak"))
+		test_hash_lock_refcount_leak();
+	if (test__start_subtest("cgroup_storage_refcount_leak"))
+		test_cgroup_storage_refcount_leak();
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


