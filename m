Return-Path: <bpf+bounces-41997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FE499E296
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD051C21EFB
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C451DDA1C;
	Tue, 15 Oct 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+vvHpbn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837071D5AB4
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983614; cv=none; b=CQRXJj+C/+8tjsHfB3cV2SAGuw0WPMCYQvrgg6l9GXAG9HUxj+7//y1t3l3iyp3QoakdG6u4FtN7AZhDM3k0tho2BMpkFy1M8GnGEy6n2T/YqgY+JlEto7VycLfJsQge35yTZylYLNGUf9mE11MeX59JHZ8YBBn5rd0H6Ff6/Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983614; c=relaxed/simple;
	bh=pTG0eoCi2cwlEEnPjFZATQKK+Rr2HsrTjR6DuJXFZ58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4uwoi1r7/QNIqZPBBwa9I/MAv2+CvvFvmwo1ylgnENNTxmC4ZuuJDeu/omaOIKp+DdLNXKSB4HLcx3F027O+j7AismDdF0E3xNMnUDX5dgDVzK1H0pKvv2K85q5cSOVyfraR+aVNT1Ty9I764EVeXy2wdWDaWSzdlH9WokZ6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+vvHpbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C146C4CEC6;
	Tue, 15 Oct 2024 09:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728983614;
	bh=pTG0eoCi2cwlEEnPjFZATQKK+Rr2HsrTjR6DuJXFZ58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+vvHpbnDpAf1w+3d+tC8Z3NZkBtRIw8/+VJYsFJX11GEiWlWKEoXF98zxxZ6IoYK
	 qC4uoA4+SkYh8v4NgAmKBLd6SlYL3PfIlYsRu5jOhPs4F7p9BtzTrpnew+jZyQIRhw
	 8krVVnPH1hhJ9Hm2pvUERKKODjSkqYwvFWaAuJLYjZLrEpzN5T43dszxx+zYte0LxN
	 9xpjY/KDSE7IKRQmDPQYw+69itzExUxHh/M9eezsJBpGjQ31tES+Db0Mqnt4/6Sj7g
	 maCXATuazvDzL68Uz2VPnoarGd/m3H8CbJF1fZyZ3zclBxJCwlsbkCrYh4tNQZbU7l
	 S4Dmv/3QSOIvw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv7 bpf-next 15/15] selftests/bpf: Add threads to consumer test
Date: Tue, 15 Oct 2024 11:10:50 +0200
Message-ID: <20241015091050.3731669-16-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015091050.3731669-1-jolsa@kernel.org>
References: <20241015091050.3731669-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With recent uprobe fix [1] the sync time after unregistering uprobe is
much longer and prolongs the consumer test which creates and destroys
hundreds of uprobes.

This change adds 16 threads (which fits the test logic) and speeds up
the test.

Before the change:

  # perf stat --null ./test_progs -t uprobe_multi_test/consumers
  #421/9   uprobe_multi_test/consumers:OK
  #421     uprobe_multi_test:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

   Performance counter stats for './test_progs -t uprobe_multi_test/consumers':

        28.818778973 seconds time elapsed

         0.745518000 seconds user
         0.919186000 seconds sys

After the change:

  # perf stat --null ./test_progs -t uprobe_multi_test/consumers 2>&1
  #421/9   uprobe_multi_test/consumers:OK
  #421     uprobe_multi_test:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

   Performance counter stats for './test_progs -t uprobe_multi_test/consumers':

         3.504790814 seconds time elapsed

         0.012141000 seconds user
         0.751760000 seconds sys

[1] commit 87195a1ee332 ("uprobes: switch to RCU Tasks Trace flavor for better performance")

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 98 +++++++++++++++----
 1 file changed, 80 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index e96b153a0f5d..cdb986871835 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -789,7 +789,7 @@ get_link(struct uprobe_multi_consumers *skel, int link)
 	}
 }
 
-static int uprobe_attach(struct uprobe_multi_consumers *skel, int idx)
+static int uprobe_attach(struct uprobe_multi_consumers *skel, int idx, unsigned long offset)
 {
 	struct bpf_program *prog = get_program(skel, idx);
 	struct bpf_link **link = get_link(skel, idx);
@@ -798,6 +798,9 @@ static int uprobe_attach(struct uprobe_multi_consumers *skel, int idx)
 	if (!prog || !link)
 		return -1;
 
+	opts.offsets = &offset;
+	opts.cnt = 1;
+
 	/*
 	 * bit/prog: 0 uprobe entry
 	 * bit/prog: 1 uprobe return
@@ -807,9 +810,7 @@ static int uprobe_attach(struct uprobe_multi_consumers *skel, int idx)
 	opts.retprobe = idx == 1;
 	opts.session  = idx == 2 || idx == 3;
 
-	*link = bpf_program__attach_uprobe_multi(prog, 0, "/proc/self/exe",
-						"uprobe_consumer_test",
-						&opts);
+	*link = bpf_program__attach_uprobe_multi(prog, 0, "/proc/self/exe", NULL, &opts);
 	if (!ASSERT_OK_PTR(*link, "bpf_program__attach_uprobe_multi"))
 		return -1;
 	return 0;
@@ -830,7 +831,8 @@ static bool test_bit(int bit, unsigned long val)
 
 noinline int
 uprobe_consumer_test(struct uprobe_multi_consumers *skel,
-		     unsigned long before, unsigned long after)
+		     unsigned long before, unsigned long after,
+		     unsigned long offset)
 {
 	int idx;
 
@@ -843,15 +845,43 @@ uprobe_consumer_test(struct uprobe_multi_consumers *skel,
 	/* ... and attach all new programs in 'after' state */
 	for (idx = 0; idx < 4; idx++) {
 		if (!test_bit(idx, before) && test_bit(idx, after)) {
-			if (!ASSERT_OK(uprobe_attach(skel, idx), "uprobe_attach_after"))
+			if (!ASSERT_OK(uprobe_attach(skel, idx, offset), "uprobe_attach_after"))
 				return -1;
 		}
 	}
 	return 0;
 }
 
+/*
+ * We generate 16 consumer_testX functions that will have uprobe installed on
+ * and will be called in separate threads. All function pointer are stored in
+ * "consumers" section and each thread will pick one function based on index.
+ */
+
+extern const void *__start_consumers;
+
+#define __CONSUMER_TEST(func) 							\
+noinline int func(struct uprobe_multi_consumers *skel, unsigned long before,	\
+		  unsigned long after, unsigned long offset)			\
+{										\
+	return uprobe_consumer_test(skel, before, after, offset);		\
+}										\
+static void *__ ## func __used __attribute__((section("consumers"))) = (void *) func;
+
+#define CONSUMER_TEST(func) __CONSUMER_TEST(func)
+
+#define C1  CONSUMER_TEST(__PASTE(consumer_test, __COUNTER__))
+#define C4  C1 C1 C1 C1
+#define C16 C4 C4 C4 C4
+
+C16
+
+typedef int (*test_t)(struct uprobe_multi_consumers *, unsigned long,
+		      unsigned long, unsigned long);
+
 static int consumer_test(struct uprobe_multi_consumers *skel,
-			 unsigned long before, unsigned long after)
+			 unsigned long before, unsigned long after,
+			 test_t test, unsigned long offset)
 {
 	int err, idx, ret = -1;
 
@@ -860,12 +890,12 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 	/* 'before' is each, we attach uprobe for every set idx */
 	for (idx = 0; idx < 4; idx++) {
 		if (test_bit(idx, before)) {
-			if (!ASSERT_OK(uprobe_attach(skel, idx), "uprobe_attach_before"))
+			if (!ASSERT_OK(uprobe_attach(skel, idx, offset), "uprobe_attach_before"))
 				goto cleanup;
 		}
 	}
 
-	err = uprobe_consumer_test(skel, before, after);
+	err = test(skel, before, after, offset);
 	if (!ASSERT_EQ(err, 0, "uprobe_consumer_test"))
 		goto cleanup;
 
@@ -934,14 +964,46 @@ static int consumer_test(struct uprobe_multi_consumers *skel,
 	return ret;
 }
 
-static void test_consumers(void)
+#define CONSUMER_MAX 16
+
+/*
+ * Each thread runs 1/16 of the load by running test for single
+ * 'before' number (based on thread index) and full scale of
+ * 'after' numbers.
+ */
+static void *consumer_thread(void *arg)
 {
+	unsigned long idx = (unsigned long) arg;
 	struct uprobe_multi_consumers *skel;
-	int before, after;
+	unsigned long offset;
+	const void *func;
+	int after;
 
 	skel = uprobe_multi_consumers__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "uprobe_multi_consumers__open_and_load"))
-		return;
+		return NULL;
+
+	func = *((&__start_consumers) + idx);
+
+	offset = get_uprobe_offset(func);
+	if (!ASSERT_GE(offset, 0, "uprobe_offset"))
+		goto out;
+
+	for (after = 0; after < CONSUMER_MAX; after++)
+		if (consumer_test(skel, idx, after, func, offset))
+			goto out;
+
+out:
+	uprobe_multi_consumers__destroy(skel);
+	return NULL;
+}
+
+
+static void test_consumers(void)
+{
+	pthread_t pt[CONSUMER_MAX];
+	unsigned long idx;
+	int err;
 
 	/*
 	 * The idea of this test is to try all possible combinations of
@@ -982,14 +1044,14 @@ static void test_consumers(void)
 	 * before/after bits.
 	 */
 
-	for (before = 0; before < 16; before++) {
-		for (after = 0; after < 16; after++)
-			if (consumer_test(skel, before, after))
-				goto out;
+	for (idx = 0; idx < CONSUMER_MAX; idx++) {
+		err = pthread_create(&pt[idx], NULL, consumer_thread, (void *) idx);
+		if (!ASSERT_OK(err, "pthread_create"))
+			break;
 	}
 
-out:
-	uprobe_multi_consumers__destroy(skel);
+	while (idx)
+		pthread_join(pt[--idx], NULL);
 }
 
 static struct bpf_program *uprobe_multi_program(struct uprobe_multi_pid_filter *skel, int idx)
-- 
2.46.2


