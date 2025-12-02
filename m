Return-Path: <bpf+bounces-75892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82833C9BF67
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 16:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21ACE4E3BAE
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 15:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37FA314B77;
	Tue,  2 Dec 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oQAy/qfd"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C3F31578B
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689490; cv=none; b=jy85oHyOKlk9/lwPoDKdYYAHBp9UgfWi42PAJcxHY0PuRsUJhnuzBNvsWBgnYDn49qtu2484L9zkZIxAD2UBVsp3h3OHbG9ibaPdiirHPI0Mt6qi+ssIr7Djo5aBU2yR3Z+zozbTKz2q6J759AUZ8a09xNV8iFVRdNDKbIRH+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689490; c=relaxed/simple;
	bh=aYG1v8OXnFfsxr0Z2dlbvmif0jKb/kE5QGX/8Pwt1jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXTV/4X286JosZXnk26tB/nhzqSDmOs7yYrNWn6oRZSnAVfjvr7qyO5GpdIZ1p3vnS4rqIsHWkEg35AQUtJJpKlFBMZIS6v6F6+ZpJMww14XmdbCFuX8u1/+urCb+fER9Y4l2v5NFAFG4Cz1rd+nKEhuk9XR5SWrQKd+ogIp9qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oQAy/qfd; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764689486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myEkj/Tt8emWRWV/C6c8mu8IbhrqGMttgi2XHib/hp0=;
	b=oQAy/qfd3mSikV0HDFCjhH0Y6VbqVg2rxGKQSr+SboiLgO1asbyvv5EukuWUxbXLcRMq8T
	vVAzEwDwE/7lKa8Op9V00ifApiFMWpsk0lPBQ2/0utPwHCiYdgAIv5vkGRKq1hmYMWfFCA
	tDmp7C6GPJ1CZtrXnoOpUpU0GGNYkaU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
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
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add tests to verify no unintended eviction when updating lru hash maps
Date: Tue,  2 Dec 2025 23:30:32 +0800
Message-ID: <20251202153032.10118-4-leon.hwang@linux.dev>
In-Reply-To: <20251202153032.10118-1-leon.hwang@linux.dev>
References: <20251202153032.10118-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add two tests to verify that updating an existing element in LRU hash
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
 .../selftests/bpf/prog_tests/htab_update.c    | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
index d0b405eb2966..bd29a915bb05 100644
--- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
+++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
@@ -143,3 +143,76 @@ void test_htab_update(void)
 	if (test__start_subtest("concurrent_update"))
 		test_concurrent_update();
 }
+
+static void test_lru_hash_map_update_elem(enum bpf_map_type map_type)
+{
+	int err, map_fd, i, key, nr_cpus, max_entries = 128;
+	u64 *values, value = 0xDEADC0DE;
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
+	map_fd = bpf_map_create(map_type, "test_lru", sizeof(int), sizeof(u64), max_entries, NULL);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create")) {
+		free(values);
+		return;
+	}
+
+	/* populate all slots */
+	for (key = 0; key < max_entries; key++) {
+		err = bpf_map_update_elem(map_fd, &key, values, 0);
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			goto out;
+	}
+
+	/* LRU eviction should not happen */
+
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
+
+	for (key = 1; key < max_entries; key++) {
+		err = bpf_map_lookup_elem(map_fd, &key, values);
+		if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+			goto out;
+		if (!ASSERT_EQ(*values, value, "bpf_map_lookup_elem value"))
+			goto out;
+	}
+
+out:
+	close(map_fd);
+	free(values);
+}
+
+static void test_update_lru_hash_map(void)
+{
+	test_lru_hash_map_update_elem(BPF_MAP_TYPE_LRU_HASH);
+}
+
+static void test_update_lru_percpu_hash_map(void)
+{
+	test_lru_hash_map_update_elem(BPF_MAP_TYPE_LRU_PERCPU_HASH);
+}
+
+void test_update_lru_hash_maps(void)
+{
+	if (test__start_subtest("lru_hash"))
+		test_update_lru_hash_map();
+	if (test__start_subtest("lru_percpu_hash"))
+		test_update_lru_percpu_hash_map();
+}
-- 
2.52.0


