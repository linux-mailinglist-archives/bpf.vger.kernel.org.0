Return-Path: <bpf+bounces-53210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5469BA4E77D
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 18:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E3018870FB
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21170283C83;
	Tue,  4 Mar 2025 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfMBYbOA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E23827D78E
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106198; cv=none; b=WXw8miU5dy7PtB5tqQjNmvST6OLA0g6Rebnrzuqk1vh5VwF/bsXjOpfBeqkSRvDvk3t6l48hMYjU0be1XexZXJ//2Ez/tdy1LF5P1bznrB5tpeoM3fcwUYM8GzOQ4r7GkaPGsjkR+uHicVnwC8r0ElVZFd5zTNvhm9D5Gjp45fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106198; c=relaxed/simple;
	bh=cmj6bbIUqp8KpVm7XmlXg9Sr0ixNvnpECyPWlxSgQO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpDScPOmFYyWm+Z/B5TMQHCvlvc2WL8zNwg2lZwlA7O92nlo6tio6B66c1I9q4U74rPxJbzOfgfxDJLUiij4tNfWDIPDKrmuUJ6v/2xEGLfDLAMh5y/AlDmuwO4xAaTJMmZOQ5GWUdg+lCGCW3Iz7uKLO5j5qmMkHVpAUfxwLI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfMBYbOA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223cc017ef5so32988855ad.0
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 08:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741106196; x=1741710996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YwE8stpXJbXD+kGBqv12ge0hXz6xpKbJOoTcTsZBR4A=;
        b=MfMBYbOACbQ7/ks0rQUC9GiYUBHoI1WZ5VTtxBczVisbCdTKdbjlP5UTWgsq89CrX5
         iIwOsAKBaXf6QLmjQK4UwvI8LznipPKQboFHojxcAVYiSDdmxG1yI+vXtzwYS/e0ThxJ
         gp+UAZ9Ii7TO4csuTUbysmh0lnroWShJUvu0psjzJE8o8NgU0ASIIHXeSqgBZfuvBOpk
         GCrhIt5XOveyfYkJAMsQvGTPvKDVfDI2yQwZx/zosnWZCEcAos6axkSmH7GFd0hGjwfU
         eb8wNzaO5jaN7N1KSszbc7JtBL30Ju+1hJXuBSFw5i4N6HpDorKbmCcFx+bHQm+65Tz5
         wcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106196; x=1741710996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwE8stpXJbXD+kGBqv12ge0hXz6xpKbJOoTcTsZBR4A=;
        b=N8pMi2hR8z0kLXbXj8N1WXwvOuV/FvVS8UH1Cdjn6ySgHl6LZIQoWGdW/GhA+FDuVS
         cB+76UB3d+DmZC1PRYc4pAw954SkcZrUXiXqq3uCXm725offRLfE8So1U9He15rVk+WI
         y+SIGfklPxHubY07Gr9JUHmk20Lm/cL50CXB02d1MFD/bBM+BUKaSulRlH2A0eB/IMek
         nMNRW5quOf4qVb/jKbK8deziyjENtK3EVKEJMRJMSF2VnMAsY4mWnZSS9HSWZyC39aV/
         07Y0mzEBZ4prRCLSbnvLGnwKTY13FGRNAdg313GMw7JlXN+EVOtBP87WeVUdEJ0jJP4t
         4qIg==
X-Gm-Message-State: AOJu0YxxEJdrHjMU0NpR35sici7vioZoyxlvxyUPUISR71zODpmD8dy9
	xCEvLaiUL8zAvsU3jT36/xoOdfzYTkhK2+/tRUb17nEDgOO+bJKEcbfD3Q==
X-Gm-Gg: ASbGnctnkwznyK/f3It6faLPPKH1HJEyo3OR93tddegygXJuQhe47xPIcWxOtmwvabo
	rAzwFhI61qKdhqfiT4hNyJcQOQKb1XucWRk4xHpBfiEhEui6c5UMBnJxIFMJITEEtWg0AL/HNip
	fpTBvqB75jXl9vzKbq8k6fJK88CRpZsMAtQdNPWizBDrQufmgaZ43c+1b/OBooZ5Fq6mtqKRrPS
	31cM9gt5yXMffQcwTBRW0vYjvk/CIaSpH3aklCCs8g9Oz+oyRERj0Oxq+BpDz3FfCwK6jVj6d+c
	oVJsaX9L5109fM2d3/KEFzJWzezAxoEljxPB0oRV91Snxp9+UvRd3p5HMHHc1+d6SI3teSh+Y2U
	buDtcrKeOTiYC/sKnF/g=
X-Google-Smtp-Source: AGHT+IGt6Bw8UQPPlJNYmEvlfVCTLToEjDkUpEl1qwr46xOXVv5w/HCQR3m4ah0LcsvgrNxYfDyXAg==
X-Received: by 2002:a05:6a00:1791:b0:736:434f:57f4 with SMTP id d2e1a72fcca58-736434f5acdmr15641179b3a.21.1741106196184;
        Tue, 04 Mar 2025 08:36:36 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a640sm11522175b3a.16.2025.03.04.08.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:36:35 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 1/3] selftests/bpf: Clean up call sites of stdio_restore()
Date: Tue,  4 Mar 2025 08:36:24 -0800
Message-ID: <20250304163626.1362031-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to call a bunch of stdio_restore() in test_progs if the
scope of stdio redirection is reduced to what it needs to be: only
hijacking tests/subtests' stdio.

Also remove an unnecessary check of env.stdout_saved in the crash handler.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 0cb759632225..ab0f2fed3c58 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -474,8 +474,6 @@ static void dump_test_log(const struct prog_test_def *test,
 	print_test_result(test, test_state);
 }
 
-static void stdio_restore(void);
-
 /* A bunch of tests set custom affinity per-thread and/or per-process. Reset
  * it after each test/sub-test.
  */
@@ -490,13 +488,11 @@ static void reset_affinity(void)
 
 	err = sched_setaffinity(0, sizeof(cpuset), &cpuset);
 	if (err < 0) {
-		stdio_restore();
 		fprintf(stderr, "Failed to reset process affinity: %d!\n", err);
 		exit(EXIT_ERR_SETUP_INFRA);
 	}
 	err = pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
 	if (err < 0) {
-		stdio_restore();
 		fprintf(stderr, "Failed to reset thread affinity: %d!\n", err);
 		exit(EXIT_ERR_SETUP_INFRA);
 	}
@@ -514,7 +510,6 @@ static void save_netns(void)
 static void restore_netns(void)
 {
 	if (setns(env.saved_netns_fd, CLONE_NEWNET) == -1) {
-		stdio_restore();
 		perror("setns(CLONE_NEWNS)");
 		exit(EXIT_ERR_SETUP_INFRA);
 	}
@@ -1270,8 +1265,7 @@ void crash_handler(int signum)
 
 	sz = backtrace(bt, ARRAY_SIZE(bt));
 
-	if (env.stdout_saved)
-		stdio_restore();
+	stdio_restore();
 	if (env.test) {
 		env.test_state->error_cnt++;
 		dump_test_log(env.test, env.test_state, true, false, NULL);
@@ -1400,6 +1394,8 @@ static void run_one_test(int test_num)
 
 	state->tested = true;
 
+	stdio_restore();
+
 	if (verbose() && env.worker_id == -1)
 		print_test_result(test, state);
 
@@ -1408,7 +1404,6 @@ static void run_one_test(int test_num)
 	if (test->need_cgroup_cleanup)
 		cleanup_cgroup_environment();
 
-	stdio_restore();
 	free(stop_libbpf_log_capture());
 
 	dump_test_log(test, state, false, false, NULL);
@@ -1943,6 +1938,9 @@ int main(int argc, char **argv)
 
 	sigaction(SIGSEGV, &sigact, NULL);
 
+	env.stdout_saved = stdout;
+	env.stderr_saved = stderr;
+
 	env.secs_till_notify = 10;
 	env.secs_till_kill = 120;
 	err = argp_parse(&argp, argc, argv, 0, NULL, &env);
@@ -1969,9 +1967,6 @@ int main(int argc, char **argv)
 		return -1;
 	}
 
-	env.stdout_saved = stdout;
-	env.stderr_saved = stderr;
-
 	env.has_testmod = true;
 	if (!env.list_test_names) {
 		/* ensure previous instance of the module is unloaded */
-- 
2.47.1


