Return-Path: <bpf+bounces-79186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE13ED2BE6A
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 06:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59B9B3006F49
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 05:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C992E9EAC;
	Fri, 16 Jan 2026 05:22:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6361C695
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 05:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768540979; cv=none; b=JrCE0+KFP9EwJ3u5sJwkQNhDoWS2pe7uE3QBXwF8w83iOZK846Dhw9vTPEzHbabZXB/pdeptLVgfpp50jNJryOhsAMfIKKkRXEsntTwgc7QH3Pj0FV5Kvg/mOYjTr2bgmjz/AitJjCSY6zxvI7VijXxkZM8vHbZadMozNwaW9co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768540979; c=relaxed/simple;
	bh=bVt+RsaqLnPSAPXuIsJr00m63I2rSLBUnMAhJTPZk+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKSvwOitpWvH1xNkafYZw3uDPiowQTZzqWfJ98ugpZW2vj4LuS8eF0ib+f2b3Je+VeXPzcuTjyenH4wo1x3+g69bGBcT6dcYGXLSQFktomg94JMlmVdwW4gqO6JzSxQvLW7hBxOpphrPMlPqvO5+qvPNyChzia47sssbfT/Wbmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 134FE18F83555; Thu, 15 Jan 2026 21:22:45 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2] selftests/bpf: Fix map_kptr test failure
Date: Thu, 15 Jan 2026 21:22:45 -0800
Message-ID: <20260116052245.3692405-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On my arm64 machine, I get the following failure:
  ...
  tester_init:PASS:tester_log_buf 0 nsec
  process_subtest:PASS:obj_open_mem 0 nsec
  process_subtest:PASS:specs_alloc 0 nsec
  serial_test_map_kptr:PASS:rcu_tasks_trace_gp__open_and_load 0 nsec
  ...
  test_map_kptr_success:PASS:map_kptr__open_and_load 0 nsec
  test_map_kptr_success:PASS:test_map_kptr_ref1 refcount 0 nsec
  test_map_kptr_success:FAIL:test_map_kptr_ref1 retval unexpected error: =
2 (errno 2)
  test_map_kptr_success:PASS:test_map_kptr_ref2 refcount 0 nsec
  test_map_kptr_success:FAIL:test_map_kptr_ref2 retval unexpected error: =
1 (errno 2)
  ...
  #201/21  map_kptr/success-map:FAIL

In serial_test_map_kptr(), before test_map_kptr_success(), one
kern_sync_rcu() is used to have some delay for freeing the map.
But in my environment, one kern_sync_rcu() seems not enough and
caused the test failure.

In bpf_map_free_in_work() in syscall.c, the queue time for
  queue_work(system_dfl_wq, &map->work)
may be longer than expected. This may cause the test failure
since test_map_kptr_success() expects all previous maps having been freed=
.

Since it is not clear how long queue_work() time takes, a bpf prog
is added to count the reference after bpf_kfunc_call_test_acquire().
If the number of references is 2 (for initial ref and the one just
acquired), all previous maps should have been released. This will
resolve the above 'retval unexpected error' issue.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/map_kptr.c       | 23 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/map_kptr.c  | 18 +++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/te=
sting/selftests/bpf/prog_tests/map_kptr.c
index 8743df599567..f372162c0280 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -131,6 +131,25 @@ static int kern_sync_rcu_tasks_trace(struct rcu_task=
s_trace_gp *rcu)
 	return 0;
 }
=20
+static void wait_for_map_release(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, lopts);
+	struct map_kptr *skel;
+	int ret;
+
+	skel =3D map_kptr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "map_kptr__open_and_load"))
+		return;
+
+	do {
+		ret =3D bpf_prog_test_run_opts(bpf_program__fd(skel->progs.count_ref),=
 &lopts);
+		ASSERT_OK(ret, "count_ref ret");
+		ASSERT_OK(lopts.retval, "count_ref retval");
+	} while (skel->bss->num_of_refs !=3D 2);
+
+	map_kptr__destroy(skel);
+}
+
 void serial_test_map_kptr(void)
 {
 	struct rcu_tasks_trace_gp *skel;
@@ -148,11 +167,15 @@ void serial_test_map_kptr(void)
=20
 		ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
 		ASSERT_OK(kern_sync_rcu(), "sync rcu");
+		wait_for_map_release();
+
 		/* Observe refcount dropping to 1 on bpf_map_free_deferred */
 		test_map_kptr_success(false);
=20
 		ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
 		ASSERT_OK(kern_sync_rcu(), "sync rcu");
+		wait_for_map_release();
+
 		/* Observe refcount dropping to 1 on synchronous delete elem */
 		test_map_kptr_success(true);
 	}
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing=
/selftests/bpf/progs/map_kptr.c
index edaba481db9d..e708ffbe1f61 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -487,6 +487,24 @@ int test_map_kptr_ref3(struct __sk_buff *ctx)
 	return 0;
 }
=20
+int num_of_refs;
+
+SEC("syscall")
+int count_ref(void *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	unsigned long arg =3D 0;
+
+	p =3D bpf_kfunc_call_test_acquire(&arg);
+	if (!p)
+		return 1;
+
+	num_of_refs =3D p->cnt.refs.counter;
+
+	bpf_kfunc_call_test_release(p);
+	return 0;
+}
+
 SEC("syscall")
 int test_ls_map_kptr_ref1(void *ctx)
 {
--=20
2.47.3


