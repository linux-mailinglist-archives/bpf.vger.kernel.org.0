Return-Path: <bpf+bounces-71114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC91BBE40F2
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 17:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ABB64FB431
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DA234AAF4;
	Thu, 16 Oct 2025 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FqH/Ufhj"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E669A346A19
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626754; cv=none; b=j2futy3omR0b/UUzC4Lg5dRHAgaWjLF+ZxokZftOBux/r3R4erw7wDBe8DKgLbiBnz7cTz9plaTCjTamsCJn0z6vVyuEu9I2NTKqPev9A1sS5DlZw60HCiCX+8rDweoRzuo1ylYeFBayjcBfpeJgdnsCW472SXqIGc8p+HEhfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626754; c=relaxed/simple;
	bh=ifwca9t1FI0mZhA6m3XOD4QjIFQPi+wiT20RQvJdTxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjG0yrbiDG5VqbjVYgDyixM9eAPOWoCKYno+cOOCjhhTuaY9kOLa35WNvg3WZgv4sOBsGxeR9L3jM8nzXn7E3p/B6cWA0IJH8muDAsqMor33kafCTPzMrzoNTPnpbUdFT1Fj2deE3Yb8SeBZDArWbiJHbLLw2B1ScDsNQT/sbRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FqH/Ufhj; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760626751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKCoDyLrQNMo0GUUrFtOSIsoXntBFB19+5Bb9S8gtlE=;
	b=FqH/UfhjxE2UZeGjnz+9+4zQ1b6CRzfMOC+vS4dq/f2aKo/ptlWzm60MvVEu39KXABlR1H
	lEvOR9D+PFfyIe+NIeBHNe4g7lRZ4jDwnY13A1aA/7A0cdzpkSaor6YvtnCO+VqzvjlO0u
	M3GSy9KiAVvQCE6zXkU/xob9X3jtxpg=
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
Subject: [PATCH bpf 3/3] selftests/bpf: Add test to verify no memleak when updating hash maps
Date: Thu, 16 Oct 2025 22:58:01 +0800
Message-ID: <20251016145801.47552-4-leon.hwang@linux.dev>
In-Reply-To: <20251016145801.47552-1-leon.hwang@linux.dev>
References: <20251016145801.47552-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add two tests to verify that updating hash maps does not leak memory
when BPF_KPTR_REF objects are involved.

The test performs the following steps:

1. Call update_elem() to insert an initial value.
2. Use bpf_refcount_acquire() to increment the refcount.
3. Store the node pointer in the map value.
4. Add the node to a linked list.
5. Probe-read the refcount and verify it is *2*.
6. Call update_elem() again to trigger refcount decrement.
7. Verify that the field has been reset.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../bpf/prog_tests/refcounted_kptr.c          |  93 ++++++++++++++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 101 ++++++++++++++++++
 2 files changed, 194 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
index d6bd5e16e6372..9dc9a425cc65d 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -44,3 +44,96 @@ void test_refcounted_kptr_wrong_owner(void)
 	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a2 retval");
 	refcounted_kptr__destroy(skel);
 }
+
+static void test_refcnt_leak(void *values, size_t values_sz, u64 flags, bool lock_hash)
+{
+	struct refcounted_kptr *skel;
+	int ret, fd, key = 0;
+	struct bpf_map *map;
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
+	map = skel->maps.pcpu_hash;
+	if (lock_hash)
+		map = skel->maps.lock_hash;
+
+	ret = bpf_map__update_elem(map, &key, sizeof(key), values, values_sz, flags);
+	if (!ASSERT_OK(ret, "bpf_map__update_elem first"))
+		goto out;
+
+	fd = bpf_program__fd(skel->progs.pcpu_hash_refcount_leak);
+	if (lock_hash)
+		fd = bpf_program__fd(skel->progs.hash_lock_refcount_leak);
+
+	ret = bpf_prog_test_run_opts(fd, &opts);
+	if (!ASSERT_OK(ret, "test_run_opts"))
+		goto out;
+	if (!ASSERT_EQ(opts.retval, 2, "retval refcount"))
+		goto out;
+
+	ret = bpf_map__update_elem(map, &key, sizeof(key), values, values_sz, flags);
+	if (!ASSERT_OK(ret, "bpf_map__update_elem second"))
+		goto out;
+
+	fd = bpf_program__fd(skel->progs.check_pcpu_hash_refcount);
+	if (lock_hash)
+		fd = bpf_program__fd(skel->progs.check_hash_lock_refcount);
+
+	ret = bpf_prog_test_run_opts(fd, &opts);
+	if (!ASSERT_OK(ret, "test_run_opts"))
+		goto out;
+	if (!ASSERT_EQ(opts.retval, 1, "retval"))
+		goto out;
+
+out:
+	refcounted_kptr__destroy(skel);
+}
+
+static void test_percpu_hash_refcount_leak(void)
+{
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
+	values_sz = cpu_nr * sizeof(u64);
+	memset(values, 0, values_sz);
+
+	test_refcnt_leak(values, values_sz, 0, false);
+
+	free(values);
+}
+
+struct hash_lock_value {
+	struct bpf_spin_lock lock;
+	u64 node;
+};
+
+static void test_hash_lock_refcount_leak(void)
+{
+	struct hash_lock_value value = {};
+
+	test_refcnt_leak(&value, sizeof(value), BPF_F_LOCK, true);
+}
+
+void test_refcount_leak(void)
+{
+	if (test__start_subtest("percpu_hash_refcount_leak"))
+		test_percpu_hash_refcount_leak();
+	if (test__start_subtest("hash_lock_refcount_leak"))
+		test_hash_lock_refcount_leak();
+}
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 893a4fdb4b6e9..8c41fe53da9e3 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -568,4 +568,105 @@ int BPF_PROG(rbtree_sleepable_rcu_no_explicit_rcu_lock,
 	return 0;
 }
 
+static int __insert_in_list(struct bpf_list_head *head, struct bpf_spin_lock *lock,
+			    struct node_data __kptr **node)
+{
+	struct node_data *n, *m;
+	u32 refcnt;
+	void *ref;
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
+	ref = (void *) &m->ref;
+	bpf_spin_unlock(lock);
+
+	bpf_probe_read_kernel(&refcnt, sizeof(refcnt), ref);
+	return refcnt;
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
+	struct map_value *v;
+
+	v = __lookup_map(&pcpu_hash);
+	return v && v->node == NULL;
+}
+
+struct hash_lock_map_value {
+	struct node_data __kptr *node;
+	struct bpf_spin_lock lock;
+	int value;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, struct hash_lock_map_value);
+	__uint(max_entries, 1);
+} lock_hash SEC(".maps");
+
+SEC("tc")
+int hash_lock_refcount_leak(void *ctx)
+{
+	struct hash_lock_map_value *v;
+
+	v = __lookup_map(&lock_hash);
+	if (!v)
+		return 0;
+
+	bpf_spin_lock(&v->lock);
+	v->value = 42;
+	bpf_spin_unlock(&v->lock);
+
+	return __insert_in_list(&head, &lock, &v->node);
+}
+
+SEC("tc")
+int check_hash_lock_refcount(void *ctx)
+{
+	struct hash_lock_map_value *v;
+
+	v = __lookup_map(&lock_hash);
+	return v && v->node == NULL;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.51.0


