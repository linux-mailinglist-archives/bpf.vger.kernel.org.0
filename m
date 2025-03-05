Return-Path: <bpf+bounces-53384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9885A509EB
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 19:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BB9189851B
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30F6230BC6;
	Wed,  5 Mar 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTKa+7mv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18E14884C
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198869; cv=none; b=lUyvl8FXasuk4uOwkynvlFQWFKo907nNvzDKMYqpiYlL+2ao4lYLWveD5l3PbLVr7TXx0Te/bDd44tFD64+0KV+EgruOko71XsICK8vlptDGffGRb7slr+97OUG+WI7iUrQvp/gneQBrLOjzf9/pCwdTi/voooFO+UTv74MjM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198869; c=relaxed/simple;
	bh=ozd2pbdY4UqD27aHF3OixPXX87oOHxQkVxVuTPD+0Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fx0xqkOzW6VGd79CE3WNcO83uynVEcEPirJAOpFFw35takvCrMBQ37oovT7xgncbWB8gQbotJyTyoZ9jd7FL1wzd2+FmvdaNU2GgKBEPYUNKV6Frex0a6fmoHCH5QGybk8ENTMNNS/NVCZi+BB0xBNmDFWqtspxwc9zjRoX75CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTKa+7mv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2feb91a25bdso9896960a91.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 10:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741198867; x=1741803667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8z4EG64PEenANta4+uVbSSODk00f9kYQBdcZkCg7FQQ=;
        b=YTKa+7mv6Hrpyicxrc93JIKtbwGsAO8uWRqcUJzYdVeGvSFjVXJ4zXWI1j+6HI3JwM
         16qoj6t/cyPbOXq/OV2X3UE22uAghiIkQ93ZVQojBr6oNiFzxtEBeOWld8cWIl7Xwb+c
         rcMPgLN7OizpmVHfMpcd7Xew1LHAaa1BsDPLhIg2dNEkajCRlXNjYj7A77HonvnVTBHs
         HTbWYXqwsMKERIHGLlluKW2ZqMN91ZFRyey9zuupZlIbs9iNg6qPaoyn0FmHl0l6o5gZ
         d8bpnodv8vyqFxbgX0Txn3f64O/ITCq9+Dc72wqbVqE/Y6VOD7XgD49NFQfgHuUqRjDf
         DE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741198867; x=1741803667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8z4EG64PEenANta4+uVbSSODk00f9kYQBdcZkCg7FQQ=;
        b=ZBtJKczdjJOV4yaYg/ex07dTW/VJmSxydYzYlr0KDyvCmFd3w4NC6sCpcKrvnk7s5B
         /G8AAoiQ9ulz4atzeTwg0sfh+kGhrsTKhUfvMvfSJ4BnZhlvJaGhVCS94gYNrvvozue+
         to6zMHf+hzImnGuSAZ+75hoM2r1c/DoV/I+xXpvsZ/pFkwGNNimDxbT8KjBecJG8tyhW
         zpOtl1znQw7GY4ILg1wR3eE5vVxcjp9kZAJxbpnjPoZdHyiy5MZ8VZUy/xBDfw6zTiwC
         A+kEU8+Kam4M1ChSUiVmE1LK4eyvraROs2gOVRgLwEq1fHTNZ4w33YdeDSLMUNsVIvwu
         3jWw==
X-Gm-Message-State: AOJu0YwsdTKaM/CqMpjMFgkNE3ZD0ZaF7VYk2LTXPJgCUCPfPBPlihXS
	j7yG/lSA0R67YbOdyAoC8aR0YxK/+KWx2G0uGr3ZipE1gXaKLow7yiivkA==
X-Gm-Gg: ASbGncsq2i6wAxtorJ4fXdQdfUGYX6ve7Qdd+hNkimw+/ICDjqbT0/9tBW+jH3ATWpq
	QQpWmW72vCF7m1Vle3ciN+gYInJCJ1YtT+vgNc0l9lTN0SVG558Lb9l86araAzOen7bKywz+Qq1
	BfCv3vqj0mIyZH2GPlsG33BK9OdHbkeL6h+GES2w1Uk9E7dazYpvm+fS+r2vxwKweV377WhqT5D
	IhXUbQd93POTptxVnvjnG+0Syjd/CVk1zx4KXS2deCYxYM7+Ik/v1PTAp6uA/rMMBqbkB8AU6h8
	d5WCP58YCTp2tEj+sem+a8gcxorSG5mjwGakXsxgNZ0hrVHgILv1Zbo4z4aCT4JCizxJQvqDN9Z
	2rVguUrmAWwTS8fGm7ko=
X-Google-Smtp-Source: AGHT+IEQCEoYxEm/wIT6rifSwoWsYLYOw5szJZwxnCJ72foKR++krivfIUBi25bK6sv3AQGGgGKu0g==
X-Received: by 2002:a17:90b:38d2:b0:2fe:8217:2da6 with SMTP id 98e67ed59e1d1-2ff4979950cmr5949717a91.22.1741198866816;
        Wed, 05 Mar 2025 10:21:06 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e8253acsm1650399a91.49.2025.03.05.10.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:21:06 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 1/3] selftests/bpf: Clean up call sites of stdio_restore()
Date: Wed,  5 Mar 2025 10:20:55 -0800
Message-ID: <20250305182057.2802606-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reset_affinity() and save_ns() are only called in run_one_test(). There is
no need to call stdio_restore() in reset_affinity() and save_ns() if
stdio_restore() is moved right after a test finishes in run_one_test().

Also remove an unnecessary check of env.stdout_saved in crash_handler()
by moving env.stdout_saved assignment to the beginning of main().

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


