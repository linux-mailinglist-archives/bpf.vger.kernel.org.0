Return-Path: <bpf+bounces-73659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CCAC3658E
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 16:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7214E5004D0
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE591334C3F;
	Wed,  5 Nov 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GsIrZWgA"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A048334C10
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355778; cv=none; b=bTWentcVNd7Q4jiBQKB+3+yZMFy85TmBA8MoAHCvt81buiI6skUsCKGwvDhCcnOlJV9T49xb9TlETzhIDtuXVBTW9UW2EBgOf21lPGDUJDsUiJfIILf0K8+F25jIsPNaIkf+GOpJZ4BuBK1nCeVNaar7drVZ3jpRL83YCLAUL0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355778; c=relaxed/simple;
	bh=rJTtHrK1MQ6wRfBIm0WngyG0NegtLpRqfoH9sizKqvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGVCgWk45HbX6v+2Z5EvWLAzSNFTqr5TzSEzjHjXFP2YSSr16rkroeRBe5WqeWNhPkdc1ZWPmeFJ4aRy5upH1zFL4pYEUc+tydtxU5btz1SCTX5ErI7FxKyPBxQtdqcozKNQFgLgF3e0zobrZ7LZyh5dK80oZHzspXA3uvKiClo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GsIrZWgA; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762355774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGk84jQ2XkxWi5Eq+6YQXJlTeelSrNDS1DJNo0IH9Lw=;
	b=GsIrZWgAELCkW+My7cw2E3qDRz8e36W1QnxgBb5fwGfs3SolTJs1BrJ8/JGQ26Lj90cVHc
	HVgqDK18YBWL1g47wlW4uyLwltX/vrm32uI8YOAd23FJxChBbds9s+juMP9P3Zq/MM6tn7
	O4FuGTKksDufPed440ymftsbY6PvfC0=
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
Subject: [PATCH bpf-next v6 2/2] selftests/bpf: Add test to verify freeing the special fields when update [lru_,]percpu_hash maps
Date: Wed,  5 Nov 2025 23:14:07 +0800
Message-ID: <20251105151407.12723-3-leon.hwang@linux.dev>
In-Reply-To: <20251105151407.12723-1-leon.hwang@linux.dev>
References: <20251105151407.12723-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add test to verify that updating [lru_,]percpu_hash maps decrements
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
 .../bpf/prog_tests/refcounted_kptr.c          | 57 ++++++++++++++++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 60 +++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index d6bd5e16e6372..086f679fa3f61 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -44,3 +44,60 @@ void test_refcounted_kptr_wrong_owner(void)
 	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a2 retval");
 	refcounted_kptr__destroy(skel);
 }
+
+void test_percpu_hash_refcounted_kptr_refcount_leak(void)
+{
+	struct refcounted_kptr *skel;
+	int cpu_nr, fd, err, key = 0;
+	struct bpf_map *map;
+	size_t values_sz;
+	u64 *values;
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
+	map = skel->maps.percpu_hash;
+	err = bpf_map__update_elem(map, &key, sizeof(key), values, values_sz, 0);
+	if (!ASSERT_OK(err, "bpf_map__update_elem"))
+		goto out;
+
+	fd = bpf_program__fd(skel->progs.percpu_hash_refcount_leak);
+	err = bpf_prog_test_run_opts(fd, &opts);
+	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
+		goto out;
+	if (!ASSERT_EQ(opts.retval, 2, "opts.retval"))
+		goto out;
+
+	err = bpf_map__update_elem(map, &key, sizeof(key), values, values_sz, 0);
+	if (!ASSERT_OK(err, "bpf_map__update_elem"))
+		goto out;
+
+	fd = bpf_program__fd(skel->progs.check_percpu_hash_refcount);
+	err = bpf_prog_test_run_opts(fd, &opts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+	ASSERT_EQ(opts.retval, 1, "opts.retval");
+
+out:
+	refcounted_kptr__destroy(skel);
+	free(values);
+}
+
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 893a4fdb4b6e9..1aca85d86aebc 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -568,4 +568,64 @@ int BPF_PROG(rbtree_sleepable_rcu_no_explicit_rcu_lock,
 	return 0;
 }
 
+private(kptr_ref) u64 ref;
+
+static int probe_read_refcount(void)
+{
+	u32 refcount;
+
+	bpf_probe_read_kernel(&refcount, sizeof(refcount), (void *) ref);
+	return refcount;
+}
+
+static int __insert_in_list(struct bpf_list_head *head, struct bpf_spin_lock *lock,
+			    struct node_data __kptr **node)
+{
+	struct node_data *node_new, *node_ref, *node_old;
+
+	node_new = bpf_obj_new(typeof(*node_new));
+	if (!node_new)
+		return -1;
+
+	node_ref = bpf_refcount_acquire(node_new);
+	node_old = bpf_kptr_xchg(node, node_new);
+	if (node_old) {
+		bpf_obj_drop(node_old);
+		bpf_obj_drop(node_ref);
+		return -2;
+	}
+
+	bpf_spin_lock(lock);
+	bpf_list_push_front(head, &node_ref->l);
+	ref = (u64)(void *) &node_ref->ref;
+	bpf_spin_unlock(lock);
+	return probe_read_refcount();
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} percpu_hash SEC(".maps");
+
+SEC("tc")
+int percpu_hash_refcount_leak(void *ctx)
+{
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&percpu_hash, &key);
+	if (!v)
+		return 0;
+
+	return __insert_in_list(&head, &lock, &v->node);
+}
+
+SEC("tc")
+int check_percpu_hash_refcount(void *ctx)
+{
+	return probe_read_refcount();
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.51.2


