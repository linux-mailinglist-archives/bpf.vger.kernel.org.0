Return-Path: <bpf+bounces-74509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6112CC5CD52
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 12:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 770223441A3
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4A4313277;
	Fri, 14 Nov 2025 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuQXxISI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DD126E703
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763119047; cv=none; b=LZ5RYa+I26s25p8tpePgAexinU23G6U4PsC10HQydTGy5UUiNE7zra02GRt/R5WNS8KrOQtnSZIIx6y+t8+7ej/RWbxkJjqGntayhArSDd2O5HdOlKoKB4J++kQqEQXfnG5/I1FDGDg+d8PucxhtBCKFqkNSlgwhdiSBz6ShQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763119047; c=relaxed/simple;
	bh=2JDFpvt3eYT423AEwV2E2ZSqe4vZzg1QddrTpBq64m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8JnUk7GTBocw6XjL7ciZbc88IUv6OlisYEkkiYolmjS5oTzZGRkRr8Q1rPQNKMwVUZdEltFpgMc5EeRs7wb112zESl6uox9zMs/vJUquF49Mue4dag7M7XDbocZi6olwyCwbuQingXpXLMTTJcAbaQ1wH/bOE9cQokNf2q03Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuQXxISI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5E7C19421;
	Fri, 14 Nov 2025 11:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763119047;
	bh=2JDFpvt3eYT423AEwV2E2ZSqe4vZzg1QddrTpBq64m0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tuQXxISIsYjvLnapg6VfxKRjJcwV8i9GH0ThsS9WrFOU3eoZpBVEOR15YC0tLVM5N
	 mVHBOM2jCxyAWrBYGKpse96uOrAtwTaUhMxfddUyaYSkIFZBPhhUEvc4mylof5inhi
	 Aebp0xOGmbbNtjDh94BwUX0D1Vwd3SIap0ArhpfnvfcWYipvf0tYpbKmTnJNcXeb/c
	 t6iI2gb8lcKT8WFC+ygeXBdhRuw45qp6EN2jsoU3x39mNQp5Z28uRzYx30mCzt9+Gh
	 KazAxSyYSA+/O4vdAWl9t/GIdWK55iMfD/p+ZvXvhEuOQ9Koik0qbi0xN4UGbXdxMT
	 mY1hvuwBDEq1Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/4] selftests: bpf: test non-sleepable arena allocations
Date: Fri, 14 Nov 2025 11:16:59 +0000
Message-ID: <20251114111700.43292-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114111700.43292-1-puranjay@kernel.org>
References: <20251114111700.43292-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As arena kfuncs can now be called from non-sleepable contexts, test this
by adding non-sleepable copies of tests in verifier_arena, this is done
by using a socket program instead of syscall.

Add a new test case in verifier_arena_large to check that the
bpf_arena_alloc_pages() works for more than 1024 pages.
1024 * sizeof(struct page *) is the upper limit of kmalloc_nolock() but
bpf_arena_alloc_pages() should still succeed because it re-uses this
array in a loop.

Augment the arena_list selftest to also run in non-sleepable context by
taking rcu_read_lock.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/arena_list.c     |  20 +-
 .../testing/selftests/bpf/progs/arena_list.c  |  11 ++
 .../selftests/bpf/progs/verifier_arena.c      | 185 ++++++++++++++++++
 .../bpf/progs/verifier_arena_large.c          |  24 +++
 4 files changed, 235 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_list.c b/tools/testing/selftests/bpf/prog_tests/arena_list.c
index d15867cddde0..4f2866a615ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_list.c
@@ -27,17 +27,23 @@ static int list_sum(struct arena_list_head *head)
 	return sum;
 }
 
-static void test_arena_list_add_del(int cnt)
+static void test_arena_list_add_del(int cnt, bool nonsleepable)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 	struct arena_list *skel;
 	int expected_sum = (u64)cnt * (cnt - 1) / 2;
 	int ret, sum;
 
-	skel = arena_list__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "arena_list__open_and_load"))
+	skel = arena_list__open();
+	if (!ASSERT_OK_PTR(skel, "arena_list__open"))
 		return;
 
+	skel->rodata->nonsleepable = nonsleepable;
+
+	ret = arena_list__load(skel);
+	if (!ASSERT_OK(ret, "arena_list__load"))
+		goto out;
+
 	skel->bss->cnt = cnt;
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_list_add), &opts);
 	ASSERT_OK(ret, "ret_add");
@@ -65,7 +71,11 @@ static void test_arena_list_add_del(int cnt)
 void test_arena_list(void)
 {
 	if (test__start_subtest("arena_list_1"))
-		test_arena_list_add_del(1);
+		test_arena_list_add_del(1, false);
 	if (test__start_subtest("arena_list_1000"))
-		test_arena_list_add_del(1000);
+		test_arena_list_add_del(1000, false);
+	if (test__start_subtest("arena_list_1_nonsleepable"))
+		test_arena_list_add_del(1, true);
+	if (test__start_subtest("arena_list_1000_nonsleepable"))
+		test_arena_list_add_del(1000, true);
 }
diff --git a/tools/testing/selftests/bpf/progs/arena_list.c b/tools/testing/selftests/bpf/progs/arena_list.c
index 3a2ddcacbea6..235d8cc95bdd 100644
--- a/tools/testing/selftests/bpf/progs/arena_list.c
+++ b/tools/testing/selftests/bpf/progs/arena_list.c
@@ -30,6 +30,7 @@ struct arena_list_head __arena *list_head;
 int list_sum;
 int cnt;
 bool skip = false;
+const volatile bool nonsleepable = false;
 
 #ifdef __BPF_FEATURE_ADDR_SPACE_CAST
 long __arena arena_sum;
@@ -42,6 +43,9 @@ int test_val SEC(".addr_space.1");
 
 int zero;
 
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
 SEC("syscall")
 int arena_list_add(void *ctx)
 {
@@ -71,6 +75,10 @@ int arena_list_del(void *ctx)
 	struct elem __arena *n;
 	int sum = 0;
 
+	/* Take rcu_read_lock to test non-sleepable context */
+	if (nonsleepable)
+		bpf_rcu_read_lock();
+
 	arena_sum = 0;
 	list_for_each_entry(n, list_head, node) {
 		sum += n->value;
@@ -79,6 +87,9 @@ int arena_list_del(void *ctx)
 		bpf_free(n);
 	}
 	list_sum = sum;
+
+	if (nonsleepable)
+		bpf_rcu_read_unlock();
 #else
 	skip = true;
 #endif
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 7f4827eede3c..4a9d96344813 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -21,6 +21,37 @@ struct {
 #endif
 } arena SEC(".maps");
 
+SEC("socket")
+__success __retval(0)
+int basic_alloc1_nosleep(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	volatile int __arena *page1, *page2, *no_page;
+
+	page1 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page1)
+		return 1;
+	*page1 = 1;
+	page2 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page2)
+		return 2;
+	*page2 = 2;
+	no_page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (no_page)
+		return 3;
+	if (*page1 != 1)
+		return 4;
+	if (*page2 != 2)
+		return 5;
+	bpf_arena_free_pages(&arena, (void __arena *)page2, 1);
+	if (*page1 != 1)
+		return 6;
+	if (*page2 != 0 && *page2 != 2) /* use-after-free should return 0 or the stored value */
+		return 7;
+#endif
+	return 0;
+}
+
 SEC("syscall")
 __success __retval(0)
 int basic_alloc1(void *ctx)
@@ -60,6 +91,44 @@ int basic_alloc1(void *ctx)
 	return 0;
 }
 
+SEC("socket")
+__success __retval(0)
+int basic_alloc2_nosleep(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	volatile char __arena *page1, *page2, *page3, *page4;
+
+	page1 = bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0);
+	if (!page1)
+		return 1;
+	page2 = page1 + __PAGE_SIZE;
+	page3 = page1 + __PAGE_SIZE * 2;
+	page4 = page1 - __PAGE_SIZE;
+	*page1 = 1;
+	*page2 = 2;
+	*page3 = 3;
+	*page4 = 4;
+	if (*page1 != 1)
+		return 1;
+	if (*page2 != 2)
+		return 2;
+	if (*page3 != 0)
+		return 3;
+	if (*page4 != 0)
+		return 4;
+	bpf_arena_free_pages(&arena, (void __arena *)page1, 2);
+	if (*page1 != 0 && *page1 != 1)
+		return 5;
+	if (*page2 != 0 && *page2 != 2)
+		return 6;
+	if (*page3 != 0)
+		return 7;
+	if (*page4 != 0)
+		return 8;
+#endif
+	return 0;
+}
+
 SEC("syscall")
 __success __retval(0)
 int basic_alloc2(void *ctx)
@@ -102,6 +171,19 @@ struct bpf_arena___l {
         struct bpf_map map;
 } __attribute__((preserve_access_index));
 
+SEC("socket")
+__success __retval(0) __log_level(2)
+int basic_alloc3_nosleep(void *ctx)
+{
+	struct bpf_arena___l *ar = (struct bpf_arena___l *)&arena;
+	volatile char __arena *pages;
+
+	pages = bpf_arena_alloc_pages(&ar->map, NULL, ar->map.max_entries, NUMA_NO_NODE, 0);
+	if (!pages)
+		return 1;
+	return 0;
+}
+
 SEC("syscall")
 __success __retval(0) __log_level(2)
 int basic_alloc3(void *ctx)
@@ -115,6 +197,38 @@ int basic_alloc3(void *ctx)
 	return 0;
 }
 
+SEC("socket")
+__success __retval(0)
+int basic_reserve1_nosleep(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *page;
+	int ret;
+
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!page)
+		return 1;
+
+	page += __PAGE_SIZE;
+
+	/* Reserve the second page */
+	ret = bpf_arena_reserve_pages(&arena, page, 1);
+	if (ret)
+		return 2;
+
+	/* Try to explicitly allocate the reserved page. */
+	page = bpf_arena_alloc_pages(&arena, page, 1, NUMA_NO_NODE, 0);
+	if (page)
+		return 3;
+
+	/* Try to implicitly allocate the page (since there's only 2 of them). */
+	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (page)
+		return 4;
+#endif
+	return 0;
+}
+
 SEC("syscall")
 __success __retval(0)
 int basic_reserve1(void *ctx)
@@ -147,6 +261,26 @@ int basic_reserve1(void *ctx)
 	return 0;
 }
 
+SEC("socket")
+__success __retval(0)
+int basic_reserve2_nosleep(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *page;
+	int ret;
+
+	page = arena_base(&arena);
+	ret = bpf_arena_reserve_pages(&arena, page, 1);
+	if (ret)
+		return 1;
+
+	page = bpf_arena_alloc_pages(&arena, page, 1, NUMA_NO_NODE, 0);
+	if ((u64)page)
+		return 2;
+#endif
+	return 0;
+}
+
 SEC("syscall")
 __success __retval(0)
 int basic_reserve2(void *ctx)
@@ -168,6 +302,27 @@ int basic_reserve2(void *ctx)
 }
 
 /* Reserve the same page twice, should return -EBUSY. */
+SEC("socket")
+__success __retval(0)
+int reserve_twice_nosleep(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *page;
+	int ret;
+
+	page = arena_base(&arena);
+
+	ret = bpf_arena_reserve_pages(&arena, page, 1);
+	if (ret)
+		return 1;
+
+	ret = bpf_arena_reserve_pages(&arena, page, 1);
+	if (ret != -EBUSY)
+		return 2;
+#endif
+	return 0;
+}
+
 SEC("syscall")
 __success __retval(0)
 int reserve_twice(void *ctx)
@@ -190,6 +345,36 @@ int reserve_twice(void *ctx)
 }
 
 /* Try to reserve past the end of the arena. */
+SEC("socket")
+__success __retval(0)
+int reserve_invalid_region_nosleep(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *page;
+	int ret;
+
+	/* Try a NULL pointer. */
+	ret = bpf_arena_reserve_pages(&arena, NULL, 3);
+	if (ret != -EINVAL)
+		return 1;
+
+	page = arena_base(&arena);
+
+	ret = bpf_arena_reserve_pages(&arena, page, 3);
+	if (ret != -EINVAL)
+		return 2;
+
+	ret = bpf_arena_reserve_pages(&arena, page, 4096);
+	if (ret != -EINVAL)
+		return 3;
+
+	ret = bpf_arena_reserve_pages(&arena, page, (1ULL << 32) - 1);
+	if (ret != -EINVAL)
+		return 4;
+#endif
+	return 0;
+}
+
 SEC("syscall")
 __success __retval(0)
 int reserve_invalid_region(void *ctx)
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index f19e15400b3e..507cd489e3e2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -270,5 +270,29 @@ int big_alloc2(void *ctx)
 		return 9;
 	return 0;
 }
+
+SEC("socket")
+__success __retval(0)
+int big_alloc3(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *pages;
+	u64 i;
+
+	/* Allocate 2051 pages (more than 1024) at once to test the limit of kmalloc_nolock() */
+	pages = bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NODE, 0);
+	if (!pages)
+		return -1;
+
+	bpf_for(i, 0, 2051)
+		        pages[i * PAGE_SIZE] = 123;
+	bpf_for(i, 0, 2051)
+		        if (pages[i * PAGE_SIZE] != 123)
+				return i;
+
+	bpf_arena_free_pages(&arena, pages, 1025);
+#endif
+	return 0;
+}
 #endif
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


