Return-Path: <bpf+bounces-73447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC7C3185A
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 15:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71913BF6AC
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69BD32ED59;
	Tue,  4 Nov 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lskt+sJO"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8C3271EF
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266472; cv=none; b=SdB5ppBfI5brY/9JsiPlnd9BRbu/8dLXrMNzs70EmoifHrcUto1nL9U4N1L0wvsFo+ZCmqtYiXuP2/eXMQxzdEjygUt8UgF3YeI4jQmfOMnEr3FzFxP/sF4W3InmfaE6L0H40D7pA5E/0A5cI6RYFdlTTQwiHQxHsk2W0ZYoPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266472; c=relaxed/simple;
	bh=Wy7fZsHwdHKbfl3emFIKps5tmwm662kVweqCr2/axHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWP9bOftpN6nMgXHpmc2pPuDYjF06aSRuJv//D3oEEmyk4u/qTnY2PmriBKt6U0EOlF0VPIL6q/GULnKVJtT/k7NJrZPfmP9UHj7zCa3MKGOtyyuYgPdYyvnJn3RKCfruy5i/l5qOqJLvQsmRSng/UHJJgSEFrkBrnLJlH5F9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lskt+sJO; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762266468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRYFcLw4DCyiRATjaYotN8jkTN5kuIx12CLhkTkRv28=;
	b=lskt+sJOBNRgPGn4tFmVtA9FDFocBRzVObLXbVr9KaDIaD/wWhgAlm9eWWGb5E1rGJkJus
	65cQViMvEqR3KlwrvC5KpSOppFyrEx/B4XAt3DXs+XfyvEiPBSuYg+Gv93dFN18/oaNjxW
	bEbtdrTG7PICYbURmLHOQFlJh3WwNjo=
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
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Add test to verify freeing the special fields when update [lru_,]percpu_hash maps
Date: Tue,  4 Nov 2025 22:27:14 +0800
Message-ID: <20251104142714.99878-3-leon.hwang@linux.dev>
In-Reply-To: <20251104142714.99878-1-leon.hwang@linux.dev>
References: <20251104142714.99878-1-leon.hwang@linux.dev>
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
index d6bd5e16e6372..b95551768d27b 100644
--- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
@@ -44,3 +44,60 @@ void test_refcounted_kptr_wrong_owner(void)
 	ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a2 retval");
 	refcounted_kptr__destroy(skel);
 }
+
+void test_percpu_hash_kptr_refcount_leak(void)
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
index 893a4fdb4b6e9..87b0cc018f840 100644
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
2.51.1


