Return-Path: <bpf+bounces-53386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37438A509CC
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 19:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492393AD67B
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F18E253344;
	Wed,  5 Mar 2025 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMPrmM/Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8BB1C5D4E
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198871; cv=none; b=XlCp0RJnvXGFXKAiESe6ftL8/wBKeDlmW12oStyg3Sg2GRUCuPlBJlD6Puf1e1L+TF2fWYTIR1Mvdb6tU0riUKdJSdFgxWQ7pxY3Ywd/BvSPrWM25zJznmfsDWZmZq/nwlqiE98IsBO7+frEIMqsUUIIpp3akM5AF5RDjW0zj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198871; c=relaxed/simple;
	bh=lHS1KyrhxnmX/0SRr698FzEj4PqKJqqmupD4tbsB5/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7pH/O6sp+gkdT9Lcyu8YW7pH9rIQtdkWX80ZsUv0eDQ4mnvYeEe/6Ds6hWUz53UJm0IZj5rLZmSLnskFQzXPmDQIn8J7S8Peff/otx9CY2197M3O0MrlSbZxBnrcgkS/TzwTF3l0UZkRPKi5Reqr6Hzt5zMUMo2MXKQYUgW8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMPrmM/Z; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fea795bafeso2243618a91.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 10:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741198868; x=1741803668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hWGJB8WzsONJqoghVlM8QaL0A/tpY27HaVPYYsb1iU=;
        b=bMPrmM/ZLi+jfCSeLyjkwbt4YK8hlJvBva0UKe5ItwKTIxRpN+NRNnK5T46zb9Ncpx
         vxe3zcBPaORyOe5FXU9qHBGTGjou0CNNqEV2dkHZUgU+CKAvKrvmYMAeejbrUCkJUZRY
         hgYnxSlX68LF2EUlNXgCCMWKMZXM9p2Nt6uWQQ6ObU5YnjZWY5M+/MeVu0evwmi0QYAE
         7bfScQ5kvVN17ru3TTPjbM8Vy4vnfXY7thvV10rvcihoxfZBUkGlmFE8aHHlroSyRyzJ
         MHtK4OszXZoN0M/mNgfVXNzq7n0eq1TOL2edWCmAVCxW1dGcwVI68SSkzQuhfupzl5mt
         fmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741198868; x=1741803668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hWGJB8WzsONJqoghVlM8QaL0A/tpY27HaVPYYsb1iU=;
        b=l0Kb3m3Sgkmbk0yOSQ+oxTECI1/WAgd4oSEBne8Hqf8xhLu6sSbdyLBDGUo5bSeVpI
         eJJ45uUcqW3uVgXURlwnVqjLN6XCWwwBpviHY42YcrQiuImAlPdg0o1F0vwR4jb58ncB
         uwxUpRLVncSNHlvA+wN16Iq0gqdd/FKZBwfmpQNFtZw6W5KOC2R4NDLvfa0e0calox5D
         PQG3WPoxVZgP8DIMqwsyynx0Dm9NL4ihUfDpGRBiuSSM3MHKms+DJyvcW2z2Ry2PoUDt
         3fxOnFwVrmgRMhnEiMT9EnyaME17Wpscq+/Q2E9lPdNzgCeUifZkm/M+ZomDkAiKwEhn
         YIiQ==
X-Gm-Message-State: AOJu0YwRNSAaVDMh5uYvPDqG6SeYiCVsIJjlXw6Cxon7PHw9/00sc2A2
	oPYQjXSEpr/qnKp8w+/jg1j7kbQ11EQmGgPgWrk/lhfk82BVSBgS24/tnQ==
X-Gm-Gg: ASbGncujpywn6aooSCb7TmUUS1vf+qw89TcbZSf2hENtv2jVOQ7OJuqj5Clun0DhPyx
	9zHYVEPIcMzHezmSfLEYsF0h77jocNnkA13LPh2gjoM41C3Eync7Y1Tj6Tk1z0/gaKcpHw3yWEz
	kllWMPfqg+uGJgTN9RCCpOr7AZ8F70w6dj37Rhi5nfcDpBi+x2ihdPU8x1HDmwNmm0XT/HGjfNs
	58O2eRvoJXrw92Q2gF3XG9ZozHUtKRUq4qYc6VUCPaILuZT6JDvE/7rqz+yKq1+Jbo6O3ADSO1e
	s1drrQTPbA0SFoD/mN7cVoJ5JbPLQTU/URSFSCvtkG2FPUsfbC/f7MbHUuLxgNvdLGYsOH11mqc
	Nq4gZS2n0aIUuzD0lScw=
X-Google-Smtp-Source: AGHT+IELemUSWwGqFUT2uKH88X7MFmXvaaKcmpdm52VXhJkqszx1FPBbXfxF2/nhYq3hXvhzPOFg5g==
X-Received: by 2002:a17:90b:2b4c:b0:2f9:d0cd:3403 with SMTP id 98e67ed59e1d1-2ff617bbe47mr500902a91.16.1741198868410;
        Wed, 05 Mar 2025 10:21:08 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e8253acsm1650399a91.49.2025.03.05.10.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:21:08 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Fix dangling stdout seen by traffic monitor thread
Date: Wed,  5 Mar 2025 10:20:57 -0800
Message-ID: <20250305182057.2802606-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305182057.2802606-1-ameryhung@gmail.com>
References: <20250305182057.2802606-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Traffic monitor thread may see dangling stdout as the main thread closes
and reassigns stdout without protection. This happens when the main thread
finishes one subtest and moves to another one in the same netns_new()
scope.

The issue can be reproduced by running test_progs repeatedly with traffic
monitor enabled:

for ((i=1;i<=100;i++)); do
   ./test_progs -a flow_dissector_skb* -m '*'
done

For restoring stdout in crash_handler(), since it does not really care
about closing stdout, simlpy flush stdout and restore it to the original
one.

Then, Fix the issue by consolidating stdio_restore_cleanup() and
stdio_restore(), and protecting the use/close/assignment of stdout with
a lock. The locking in the main thread is always performed regradless of
whether traffic monitor is running or not for simplicity. It won't have
any side-effect.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 39 +++++++++++++-----------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index ab0f2fed3c58..d4ec9586b98c 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -88,7 +88,9 @@ static void stdio_hijack(char **log_buf, size_t *log_cnt)
 #endif
 }
 
-static void stdio_restore_cleanup(void)
+static pthread_mutex_t stdout_lock = PTHREAD_MUTEX_INITIALIZER;
+
+static void stdio_restore(void)
 {
 #ifdef __GLIBC__
 	if (verbose() && env.worker_id == -1) {
@@ -98,6 +100,8 @@ static void stdio_restore_cleanup(void)
 
 	fflush(stdout);
 
+	pthread_mutex_lock(&stdout_lock);
+
 	if (env.subtest_state) {
 		fclose(env.subtest_state->stdout_saved);
 		env.subtest_state->stdout_saved = NULL;
@@ -106,26 +110,21 @@ static void stdio_restore_cleanup(void)
 	} else {
 		fclose(env.test_state->stdout_saved);
 		env.test_state->stdout_saved = NULL;
+		stdout = env.stdout_saved;
+		stderr = env.stderr_saved;
 	}
+
+	pthread_mutex_unlock(&stdout_lock);
 #endif
 }
 
-static void stdio_restore(void)
+static int traffic_monitor_print_fn(const char *format, va_list args)
 {
-#ifdef __GLIBC__
-	if (verbose() && env.worker_id == -1) {
-		/* nothing to do, output to stdout by default */
-		return;
-	}
-
-	if (stdout == env.stdout_saved)
-		return;
-
-	stdio_restore_cleanup();
+	pthread_mutex_lock(&stdout_lock);
+	vfprintf(stdout, format, args);
+	pthread_mutex_unlock(&stdout_lock);
 
-	stdout = env.stdout_saved;
-	stderr = env.stderr_saved;
-#endif
+	return 0;
 }
 
 /* Adapted from perf/util/string.c */
@@ -536,7 +535,8 @@ void test__end_subtest(void)
 				   test_result(subtest_state->error_cnt,
 					       subtest_state->skipped));
 
-	stdio_restore_cleanup();
+	stdio_restore();
+
 	env.subtest_state = NULL;
 }
 
@@ -1265,7 +1265,10 @@ void crash_handler(int signum)
 
 	sz = backtrace(bt, ARRAY_SIZE(bt));
 
-	stdio_restore();
+	fflush(stdout);
+	stdout = env.stdout_saved;
+	stderr = env.stderr_saved;
+
 	if (env.test) {
 		env.test_state->error_cnt++;
 		dump_test_log(env.test, env.test_state, true, false, NULL);
@@ -1957,6 +1960,8 @@ int main(int argc, char **argv)
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
 	libbpf_set_print(libbpf_print_fn);
 
+	traffic_monitor_set_print(traffic_monitor_print_fn);
+
 	srand(time(NULL));
 
 	env.jit_enabled = is_jit_enabled();
-- 
2.47.1


