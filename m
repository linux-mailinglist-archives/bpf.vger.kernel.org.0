Return-Path: <bpf+bounces-52809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6B9A48A9A
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 22:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4A6188D894
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 21:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EC227180C;
	Thu, 27 Feb 2025 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcLPJdDY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCA6271291
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692010; cv=none; b=cVP4IvnSaXDInw7Mm5QuHVSGDC+g2RX734vm/3Ein2i6HtVDA9ZcW1kiw1LF4zay4/trOMCiCJCa6LnvQ/UIgjx3EFmOAqVRXYc4qRml+w2mG7KmSvq3f3QPHakpFpaZlE6Q9W2XKkeTwLNcj65fWclWvqcwPBJgGIDQvw/2XQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692010; c=relaxed/simple;
	bh=w9JjohAbRoD1sSO5FaIZWNR7D9TT4irTc35CLPiYAy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YjuTb8UI4bfRUs0UruU+GbNDW52YPYBxMZyb7rEToU3jvP0hhAklN7mDF7Un5f1FuraNG14lsArE3iA3TiykSbkEVJrqoKee1uUzgn5Cn3ZePae3CyMJFdaI6V0hDJn803ALwXtkmQ/cxQVemhptRrNzbaORtUBS6RtNHpFm1Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcLPJdDY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2211cd4463cso28664945ad.2
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 13:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740692008; x=1741296808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kc2BVLwC7frUoqt0TFo+1GnB7fvf1oRdOA+PwpjyhlM=;
        b=lcLPJdDYdcatks6I+A4rShcBx26+LGVViZaGAP9jaLNwfKC8IqTseJG5jGZ2lik/07
         t+efV0eTjKBsS3cYx+atQ5+EFaLYbacu/owIiJoCMbaMWU1qJR2FkI+4T39/w8J5+D5s
         usiDCEGch1CncoWni5jQUxiYWXthoYVDItLAf8m0vRJvnEJ6KiTWX146GPha+skktR2b
         21j2jNnDcvD0IlUdVaySkMr1pN1zTgwoGGQYS/SR80Dc47rLwOGGpkXYqO6FuQ6O8VtV
         wcZy1nA1z80hoLIc6tfLj5KWtWJU6xrCPFErQ4xtn+8lEa5203xMwJt74ZbcL5J5xngz
         KUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740692008; x=1741296808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kc2BVLwC7frUoqt0TFo+1GnB7fvf1oRdOA+PwpjyhlM=;
        b=cLUcS1Lh9v1Kpiod19+oLfJygkn2kH+wZU5MOE6R4yUPYXJi+zZtn89u8qnxZdxOor
         eFP4Os6w87UQpsWSx8zpjMhw54PeIEg1G0cPxf3dZ6kPOWMgUlVEe452YLNUU8mcpK4f
         dc/vD60uiS6EQE4Sk3s9nUIUhrTSs2vWyuu4gF9VLa4zgvVATBrVQSShZki3fYvNinc3
         dAKwuBJr9LytyYG9b6fysxCY0y0grUfV1q3V0uz7p9tMk900f9ciDUrlliy0b23Xx2Z5
         eqgCdrJkYlX+t785el6V3Cyf7aZRjgpGTpqDAi/eXAWfQQuIHNqavD1i0aSaBlxnzqTm
         p9ig==
X-Gm-Message-State: AOJu0Yz9OiwLh1CkxFdYfqUwHJeTU48GgJa+asHy6f/F0RAL5JGr1k1J
	Q83hCUaFYz2zdYcwyS4FqZFmkBbytxr8inLaAH8ByJWH4bTu7tMkCvwemg==
X-Gm-Gg: ASbGncs2+UEV/o+8ljtu8Mh/fiNHJBmI9EssySVyzsO2AaCLyhxqnWtJsPg/kUgIUmc
	Wit0MZ9cKcX8lvTmaDA+lUKVdJJrXWcMILrseFNmkHN3UgwemBzc5+rv1C+5voIxYwsDYKzlYst
	KANt7BcsU2oCmZJ7MqUUvKqsDDzXGQ3dEr55FocwjeSsrUjs+xy4A2kFDJQTNYLJYXNLdFC8cnw
	EvM8/LVdaxMPrNNGsXHNzfD/pFQaY+jSbh1pr4rYnkkxn124r4TGV7Z/y2IuiLQWQwqsWIztQjD
	TcHqA8Cv57X8Lze9gQwL+bWR5DaGBz4DxxCfqJi00DY9E3kyHS18CvOrpgVuFepjI2mYKKO9q5c
	i
X-Google-Smtp-Source: AGHT+IElYnODGJwEYa4Do2vJMnT6h0GqSzLU41leWJ4H/vI2WB2+Z65NqMj9l7Lq7BNRkFJH7HhOFQ==
X-Received: by 2002:a05:6a00:a96:b0:72d:3b2e:fef9 with SMTP id d2e1a72fcca58-734ac424a5emr1641837b3a.20.1740692007637;
        Thu, 27 Feb 2025 13:33:27 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0040084sm2190023b3a.121.2025.02.27.13.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:33:27 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/1] selftests/bpf: Fix dangling stdout seen by traffic monitor thread
Date: Thu, 27 Feb 2025 13:33:02 -0800
Message-ID: <20250227213302.2168420-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
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
scope. Fix it by first consolidating stdout assignment into
stdio_restore_cleanup() and then protecting the use/close/reassignment of
stdout with a lock. The locking in the main thread is always performed
regradless of whether traffic monitor is running or not for simplicity.
It won't have any side-effect.

The issue can be reproduced by running test_progs repeatedly with traffic
monitor enabled:

for ((i=1;i<=100;i++)); do
   ./test_progs -a flow_dissector_skb* -m '*'
done

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/network_helpers.c |  8 ++++-
 tools/testing/selftests/bpf/network_helpers.h |  3 +-
 tools/testing/selftests/bpf/test_progs.c      | 29 +++++++++++++------
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 737a952dcf80..5014fd063d67 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -743,6 +743,7 @@ struct tmonitor_ctx {
 	pcap_t *pcap;
 	pcap_dumper_t *dumper;
 	pthread_t thread;
+	pthread_mutex_t *stdout_lock;
 	int wake_fd;
 
 	volatile bool done;
@@ -953,6 +954,7 @@ static void *traffic_monitor_thread(void *arg)
 		ifindex = ntohl(ifindex);
 		ptype = packet[10];
 
+		pthread_mutex_lock(ctx->stdout_lock);
 		if (proto == ETH_P_IPV6) {
 			show_ipv6_packet(payload, ifindex, ptype);
 		} else if (proto == ETH_P_IP) {
@@ -967,6 +969,7 @@ static void *traffic_monitor_thread(void *arg)
 			printf("%-7s %-3s Unknown network protocol type 0x%x\n",
 			       ifname, pkt_type_str(ptype), proto);
 		}
+		pthread_mutex_unlock(ctx->stdout_lock);
 	}
 
 	return NULL;
@@ -1055,7 +1058,8 @@ static void encode_test_name(char *buf, size_t len, const char *test_name, const
  * in the give network namespace.
  */
 struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
-					   const char *subtest_name)
+					   const char *subtest_name,
+					   pthread_mutex_t *stdout_lock)
 {
 	struct nstoken *nstoken = NULL;
 	struct tmonitor_ctx *ctx;
@@ -1109,6 +1113,8 @@ struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_n
 		goto fail_eventfd;
 	}
 
+	ctx->stdout_lock = stdout_lock;
+
 	r = pthread_create(&ctx->thread, NULL, traffic_monitor_thread, ctx);
 	if (r) {
 		log_err("Failed to create thread");
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 9f6e05d886c5..beaa6931dcfc 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -251,7 +251,8 @@ struct tmonitor_ctx;
 
 #ifdef TRAFFIC_MONITOR
 struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
-					   const char *subtest_name);
+					   const char *subtest_name,
+					   pthread_mutex_t *stdout_lock);
 void traffic_monitor_stop(struct tmonitor_ctx *ctx);
 #else
 static inline struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 0cb759632225..db9ea69e8ba1 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -88,7 +88,9 @@ static void stdio_hijack(char **log_buf, size_t *log_cnt)
 #endif
 }
 
-static void stdio_restore_cleanup(void)
+static pthread_mutex_t stdout_lock = PTHREAD_MUTEX_INITIALIZER;
+
+static void stdio_restore_cleanup(bool restore_default)
 {
 #ifdef __GLIBC__
 	if (verbose() && env.worker_id == -1) {
@@ -98,15 +100,25 @@ static void stdio_restore_cleanup(void)
 
 	fflush(stdout);
 
+	pthread_mutex_lock(&stdout_lock);
+
 	if (env.subtest_state) {
 		fclose(env.subtest_state->stdout_saved);
 		env.subtest_state->stdout_saved = NULL;
-		stdout = env.test_state->stdout_saved;
-		stderr = env.test_state->stdout_saved;
 	} else {
 		fclose(env.test_state->stdout_saved);
 		env.test_state->stdout_saved = NULL;
 	}
+
+	if (restore_default) {
+		stdout = env.stdout_saved;
+		stderr = env.stderr_saved;
+	} else if (env.subtest_state) {
+		stdout = env.test_state->stdout_saved;
+		stderr = env.test_state->stdout_saved;
+	}
+
+	pthread_mutex_unlock(&stdout_lock);
 #endif
 }
 
@@ -121,10 +133,7 @@ static void stdio_restore(void)
 	if (stdout == env.stdout_saved)
 		return;
 
-	stdio_restore_cleanup();
-
-	stdout = env.stdout_saved;
-	stderr = env.stderr_saved;
+	stdio_restore_cleanup(true);
 #endif
 }
 
@@ -541,7 +550,8 @@ void test__end_subtest(void)
 				   test_result(subtest_state->error_cnt,
 					       subtest_state->skipped));
 
-	stdio_restore_cleanup();
+	stdio_restore_cleanup(false);
+
 	env.subtest_state = NULL;
 }
 
@@ -779,7 +789,8 @@ struct netns_obj *netns_new(const char *nsname, bool open)
 	    (env.subtest_state && env.subtest_state->should_tmon)) {
 		test_name = env.test->test_name;
 		subtest_name = env.subtest_state ? env.subtest_state->name : NULL;
-		netns_obj->tmon = traffic_monitor_start(nsname, test_name, subtest_name);
+		netns_obj->tmon = traffic_monitor_start(nsname, test_name, subtest_name,
+							&stdout_lock);
 		if (!netns_obj->tmon) {
 			fprintf(stderr, "Failed to start traffic monitor for %s\n", nsname);
 			goto fail;
-- 
2.47.1


