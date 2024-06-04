Return-Path: <bpf+bounces-31290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D68FAB89
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 09:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862671C24016
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 07:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD1413E05B;
	Tue,  4 Jun 2024 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubKj7aLw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24E2209B
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717484826; cv=none; b=fWBl54OY2KO874Rk1K8AuwW39CjAUwXbSdK0EHfwf4emcr/u0zeXM4ZCZdYLcDd0iix1zqQbsPA5cnt3ZnCY5LM0XdoHadGrZqdwCsE5u2XnfRuTWbdyHZqImxpo9zgLubXfhQdabWCRSFqD4XM5BwdJEPYuUuqbyOIdFe6ItEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717484826; c=relaxed/simple;
	bh=R7AOo+o/NN658LjT0dv4n4mEbRNcmxRTHW3YiqhJi64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=beHjEwzjFafbe2Sc3qfQF8foWY8pdLbARNhHRc8TkyhTyqyJg6vOjCbtHhLQ6FCFVbz9tAdBs4FauPJUWx2u3YTVlIpTQDJDs0zpCCf6fsdC7uVEUZHhXtmFZpdQyKKo1RUp+dTLW5hoTmqLZaa0fnR9sTXhR8tRBF9LNY1zXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubKj7aLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C773FC2BBFC;
	Tue,  4 Jun 2024 07:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717484826;
	bh=R7AOo+o/NN658LjT0dv4n4mEbRNcmxRTHW3YiqhJi64=;
	h=From:To:Cc:Subject:Date:From;
	b=ubKj7aLwHpKYJ0ZHh02QbZ6rbQkJXgTKOqn9uzQ64IADmtUMU3LsfDWHEJDqc8hH+
	 jTM5/T+cJX0glQ44/grHWzU42VGPgKxYJ/lteCpxq1upt/SJMDnnxQ7gsdntginFpe
	 UHKmrX9yXtV7B5yh577W15+KSBAEiAcxCHfjMQec7LHK/wITKKMMIZXboK56l1wJPt
	 adqTSQX5ZviNjvJdqtXCTDJtdc/k41AUqbQ33QdB4OnV7wutIzlgYle7WnraiBChAu
	 On1PB7A1UxyZNA7OYxWRqVk902DE38uZgsmOiNXPzrE08W4nR1tCnHKu0o0+fEqYC9
	 mWIGwZsK6hDIg==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix bpf_cookie and find_vma in nested VM
Date: Tue,  4 Jun 2024 00:07:00 -0700
Message-ID: <20240604070700.3032142-1-song@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_cookie and find_vma are flaky in nested VMs, which is used by some CI
systems. It turns out these failures are caused by unreliable perf event
in nested VM. Fix these by:

  1. Use PERF_COUNT_SW_CPU_CLOCK in find_vma;
  2. Increase sample_freq in bpf_cookie.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/find_vma.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 4407ea428e77..070c52c312e5 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -451,7 +451,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.config = PERF_COUNT_SW_CPU_CLOCK;
 	attr.freq = 1;
-	attr.sample_freq = 1000;
+	attr.sample_freq = 10000;
 	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/testing/selftests/bpf/prog_tests/find_vma.c
index 5165b38f0e59..f7619e0ade10 100644
--- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
+++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
@@ -29,8 +29,8 @@ static int open_pe(void)
 
 	/* create perf event */
 	attr.size = sizeof(attr);
-	attr.type = PERF_TYPE_HARDWARE;
-	attr.config = PERF_COUNT_HW_CPU_CYCLES;
+	attr.type = PERF_TYPE_SOFTWARE;
+	attr.config = PERF_COUNT_SW_CPU_CLOCK;
 	attr.freq = 1;
 	attr.sample_freq = 1000;
 	pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
-- 
2.43.0


