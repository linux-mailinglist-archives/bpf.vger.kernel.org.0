Return-Path: <bpf+bounces-78121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B893CFE953
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 16:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42BED3011A6E
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98C835F8D9;
	Wed,  7 Jan 2026 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b2tMfAHM"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355735E53F
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798967; cv=none; b=ZmeTDz/xL87hfAxJcIHPWocLW3Opvis7rForTHDhk2ru5/rh6wloFSM0g7lQTdnC+5sNtWKH2E1uaeNWGwOTdNUZwIBkEGZiSV4oHfwclRqFDZqxI3WycGOg9y6CivFMckd/HllYm186FvSIE3KSPMxadKFEbVpE3gP7hxqYiIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798967; c=relaxed/simple;
	bh=lMJEaWB8f3Hg9RvJw5w+N2p4NV2VpqSAAdZbuwsiP80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGNB07mYiGlWJxQ5LRprwSUUk8QDL5OwN7R9A2jrwgzyE4zMjcSDoR3PcrWiy86YmqH0nBBnSsQBEA515/88C1zeC6vf8KKASINlbdGq27POPcMr5dsek0IxMY7RdhGnTPBKxJnmLf8FQSr+hdmXMZKSJG//bSYHCsKZrca4/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b2tMfAHM; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767798963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hihqJCyk34Is6LN9qO5d1mtAMbuF5DLsZJ+b+PHXRnA=;
	b=b2tMfAHMjkgp0wbXC5haAX1DAj8QElnIiT2bizAuqq99UaT9fwA5PPzTmsxEhbzIa1IqOw
	ijQhYSTweB/Y0CodAVmHJWgCicpGYFIP1iECZyUpgKatX9qDmltDPCimUDXXil71UYMDaC
	3LQOTKAFJnpl/G3H9E17j7NOiz8h17M=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Add tests to verify no unintended eviction when updating lru_[percpu_,]hash maps
Date: Wed,  7 Jan 2026 23:14:56 +0800
Message-ID: <20260107151456.72539-6-leon.hwang@linux.dev>
In-Reply-To: <20260107151456.72539-1-leon.hwang@linux.dev>
References: <20260107151456.72539-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add four tests to verify that updating an existing element in LRU hash
maps does not cause unintended eviction of other elements.

The test creates lru_hash/lru_percpu_hash maps with max_entries slots and
populates all of them. It then updates an existing key and verifies that:
1. The update succeeds without error
2. The updated key has the new value
3. All other keys still exist with their original values

This validates the fix that prevents unnecessary LRU eviction when
updating existing elements in full LRU hash maps.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/htab_update.c    | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
index d0b405eb2966..a0c93aae2b99 100644
--- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
+++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
@@ -143,3 +143,132 @@ void test_htab_update(void)
 	if (test__start_subtest("concurrent_update"))
 		test_concurrent_update();
 }
+
+static void __setaffinity(cpu_set_t *cpus, int cpu)
+{
+	CPU_ZERO(cpus);
+	CPU_SET(cpu, cpus);
+	pthread_setaffinity_np(pthread_self(), sizeof(*cpus), cpus);
+}
+
+static void test_lru_hash_map_update_elem(enum bpf_map_type map_type, u64 map_flags)
+{
+	bool percpu = map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH;
+	int err, map_fd, i, key, nr_cpus, max_entries = 128;
+	u64 *values, value = 0xDEADC0DE;
+	cpu_set_t cpus;
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		    .map_flags = map_flags,
+	);
+
+	nr_cpus = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
+		return;
+
+	values = calloc(nr_cpus, sizeof(u64));
+	if (!ASSERT_OK_PTR(values, "calloc values"))
+		return;
+	for (i = 0; i < nr_cpus; i++)
+		values[i] = value;
+
+	map_fd = bpf_map_create(map_type, "test_lru", sizeof(int), sizeof(u64), max_entries, &opts);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create")) {
+		free(values);
+		return;
+	}
+
+	/* populate all slots */
+	for (key = 0; key < max_entries; key++) {
+		__setaffinity(&cpus, key%nr_cpus);
+		err = bpf_map_update_elem(map_fd, &key, values, 0);
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			goto out;
+	}
+
+	/* LRU eviction should not happen */
+
+#define CHECK_OTHER_CPUS_VALUES(__val)							\
+	do {										\
+		if (!percpu)								\
+			break;								\
+		for (i = 1; i < nr_cpus; i++)						\
+			if (!ASSERT_EQ(values[i], __val, "bpf_map_lookup_elem value"))	\
+				goto out;						\
+	} while (0)
+
+	__setaffinity(&cpus, 0);
+	key = 0;
+	memset(values, 0, nr_cpus * sizeof(u64));
+	err = bpf_map_update_elem(map_fd, &key, values, 0);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	err = bpf_map_lookup_elem(map_fd, &key, values);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		goto out;
+	if (!ASSERT_EQ(*values, 0, "bpf_map_lookup_elem value"))
+		goto out;
+	CHECK_OTHER_CPUS_VALUES(0);
+
+	for (key = 1; key < max_entries; key++) {
+		err = bpf_map_lookup_elem(map_fd, &key, values);
+		if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+			goto out;
+		if (!ASSERT_EQ(*values, value, "bpf_map_lookup_elem value"))
+			goto out;
+		CHECK_OTHER_CPUS_VALUES(value);
+	}
+
+	for (i = 0; i < nr_cpus; i++)
+		values[i] = value;
+
+	key = max_entries;
+	err = bpf_map_update_elem(map_fd, &key, values, 0);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	err = bpf_map_lookup_elem(map_fd, &key, values);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		goto out;
+	if (!ASSERT_EQ(*values, value, "bpf_map_lookup_elem value"))
+		goto out;
+	CHECK_OTHER_CPUS_VALUES(value);
+
+#undef CHECK_OTHER_CPUS_VALUES
+
+out:
+	close(map_fd);
+	free(values);
+}
+
+static void test_update_lru_hash_map_common_lru(void)
+{
+	test_lru_hash_map_update_elem(BPF_MAP_TYPE_LRU_HASH, 0);
+}
+
+static void test_update_lru_hash_map_percpu_lru(void)
+{
+	test_lru_hash_map_update_elem(BPF_MAP_TYPE_LRU_HASH, BPF_F_NO_COMMON_LRU);
+}
+
+static void test_update_lru_percpu_hash_map_common_lru(void)
+{
+	test_lru_hash_map_update_elem(BPF_MAP_TYPE_LRU_PERCPU_HASH, 0);
+}
+
+static void test_update_lru_percpu_hash_map_percpu_lru(void)
+{
+	test_lru_hash_map_update_elem(BPF_MAP_TYPE_LRU_PERCPU_HASH, BPF_F_NO_COMMON_LRU);
+}
+
+void test_update_lru_hash_maps(void)
+{
+	if (test__start_subtest("lru_hash/common_lru"))
+		test_update_lru_hash_map_common_lru();
+	if (test__start_subtest("lru_hash/percpu_lru"))
+		test_update_lru_hash_map_percpu_lru();
+	if (test__start_subtest("lru_percpu_hash/common_lru"))
+		test_update_lru_percpu_hash_map_common_lru();
+	if (test__start_subtest("lru_percpu_hash/percpu_lru"))
+		test_update_lru_percpu_hash_map_percpu_lru();
+}
-- 
2.52.0


