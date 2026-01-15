Return-Path: <bpf+bounces-78987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D6DD22840
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 07:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EE1730443ED
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 06:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACEE2D8372;
	Thu, 15 Jan 2026 06:13:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF6D2848B2
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457615; cv=none; b=vCDVjQ9f7r6o3QOepR/h0jwCLFVGDaxvKNRbXkrA+rNTsSa5bnKWeqr0y/0TmcecnkpdGFv2gLAAlDZoPiKsqitLspDE6vh9p7fOK0quGEwiW0W223kQXRJ2bVJ0B1OETTIPLpIYaoHLEfRGJBcpN9gg8ufRQtOxy8SAZmuSJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457615; c=relaxed/simple;
	bh=1ItSjQW85jgaG113tIuXpJhekQ8T9BKrD22v88PSltg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8Rzy/CA44PV20VYjUoTEU3r1IC7ZVeIwLCqO5gzS+wg+kOI616Cy/ty/9sz/eCPHvLQAn9SIdyCFwcRJ8sEHmjzAG1LZGK9uYVyj498hA1GTHdFlW8UFmEXjHfXC2+IQmt8hBl3AkM6LqoNFLDCpL4LCWqEVPTSntFDxAowwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E202A18E9CC1A; Wed, 14 Jan 2026 22:13:19 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix map_kptr test failure
Date: Wed, 14 Jan 2026 22:13:19 -0800
Message-ID: <20260115061319.2895636-1-yonghong.song@linux.dev>
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

In stead of one kern_sync_rcu() before test_map_kptr_success(),
I added two more kern_sync_rcu() to have a longer delay and
the test succeeded.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/map_kptr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/te=
sting/selftests/bpf/prog_tests/map_kptr.c
index 8743df599567..f9cfc4d3153c 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -148,11 +148,15 @@ void serial_test_map_kptr(void)
=20
 		ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
 		ASSERT_OK(kern_sync_rcu(), "sync rcu");
+		ASSERT_OK(kern_sync_rcu(), "sync rcu");
+		ASSERT_OK(kern_sync_rcu(), "sync rcu");
 		/* Observe refcount dropping to 1 on bpf_map_free_deferred */
 		test_map_kptr_success(false);
=20
 		ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
 		ASSERT_OK(kern_sync_rcu(), "sync rcu");
+		ASSERT_OK(kern_sync_rcu(), "sync rcu");
+		ASSERT_OK(kern_sync_rcu(), "sync rcu");
 		/* Observe refcount dropping to 1 on synchronous delete elem */
 		test_map_kptr_success(true);
 	}
--=20
2.47.3


