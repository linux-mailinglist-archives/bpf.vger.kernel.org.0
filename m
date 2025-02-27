Return-Path: <bpf+bounces-52825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A00A48B76
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 23:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9D43B3887
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 22:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8037827560B;
	Thu, 27 Feb 2025 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goHMTFA+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657E274248
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695029; cv=none; b=PvA4HzuwFD0/28n8StcXNCPjIeVWPCM25IFBllmGXKibYnwn23xLfnRwlzFbpJjHS9865K/rTbldw3Mv//hltjDBC8UlVYZKg2pn/9F316n+iaKhuRRkFCrkHsElqCr43s/nrSy5DP1MW26SzP0kwUmkU6E60Ji9XahH0y8ltqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695029; c=relaxed/simple;
	bh=uEhxlXKm9oAk+4kJhIouc7ERwUrGCYKBAUcCKzlhYlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N+NNOJ80ugADRLzaq1OQzqTquq6fRFTIx7tGgmWZkKRkYkmNR8O61ZXjaDsOEE2bL+bHJfnlR8JlvmvlrG3IVE5jsWj0M3huLhe1mJ2+rqUKygICafgNzC+iNQ7rCyesDSN2+4Bx3XruuDdkn3zbxzJDj8Z1rYaN+ZNLVGW958Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goHMTFA+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-222e8d07dc6so28210735ad.1
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 14:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740695027; x=1741299827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I+38UpU5+kc0ioOv4dnMjWZ8IO4n4GyIDJAa7pHegq0=;
        b=goHMTFA+1BmijVSmYGzFeWmGBXxtzI0iRgmPTIphiw8UfRO6QBZ80fCBR3mQMkj5Kz
         Hli0T5kD2wT/5IIohh6bJlfZirwe6MiNRX70rdRtzJgGQMDUMbh032KQCLpvhti6wk38
         OI+IXw0sA7Nby84kMFO/8er5cgm2PHOnGpFm7swKGvvoD/Jlh5Ac+b7928e3UypxBHaD
         QMDDifTDzww4WRDDntWEaFKAwadAyDdIoGk7Y9qdjotcDOu555PbChe4y9RIp0RbDJpV
         QOcV+p23u2RSZk4yMFKseZeYzN5e4j43p/CEAEqi/SNfeKv4WCh6x6/2nreGjqfB8eCa
         EWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695027; x=1741299827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+38UpU5+kc0ioOv4dnMjWZ8IO4n4GyIDJAa7pHegq0=;
        b=rV4H8fGr+osvzOLqeMOVaudf+p8ROSkYKZBqSbl9iY9XgWLYb5JUHtxj5pdro79qj2
         FmeMYE2y8vxJoCml/Vhb2Tlj4Se3cy/Ag6PMj2E0E/QEG9mOYdmU+mletZnOEZKWLoR7
         RWhZ0dDMGZLsQM4s4v+q7+1/j/ScYYhey+uwCAqi+zKeU36f/pY0eoFYfRULJYVe71Ji
         1zqgHNHLQkA6LskKSA3P1xUQtebaRMkw0oCFFTdO8ueuHYvdiadFs0geM1addQx6dkG6
         jrfBFgxc4aMyRvI3WCkPoNX78LIPK55ZmKbrtRS59Pr7tUwW51JstEnHCSrP1MWYMaj7
         ooMQ==
X-Gm-Message-State: AOJu0YxrU1OAMBmsUWq68zWfbC7hMad5H45J3XvZHy1IvWvOgEe87RjU
	PnTWHUEIYCAz50MRrpclIeKPKaRi8QCCMSawW0v8lA24KBZQi6BklV/7dg==
X-Gm-Gg: ASbGnculYBPspc0iM2jRav08Gxl/DWwHBoTz3PnExJT89fxrCie9eeIhguvJDhrImG/
	fAH8HMjl1ZbDKWP6eiQdLC7BqEuyGqVrKfHj0+3MuQJtQyNAmbZ71oxb7evHytGk6YsQoSaVlMw
	/FPSOD6GzUakzUohbuuLbOs8MpNTtI38gSHqCK+y9GFh3zj/HWMI0B4RylOU68Qj79OPOHzfbi9
	hK/XWPLBoEoWkJkVlAS3J4exPZukkhIL/C+tmcNaEVH9v/oZrgcdaUp08d8AH9zvMAVFPCy5oUv
	EjBiDgwfZDGzaRwaM0Igr90VfKjjF0RoUxovG1jaJ5jLOi2di3k1ltLduiaON6i+g3XcjyAuvpq
	2
X-Google-Smtp-Source: AGHT+IHovCvgkQzz+dmAe+X2RRziXXgYizAnHIWMfAFNLBIzY9oshjWyCm3yDZb1VIEOTd9/Ri6LPw==
X-Received: by 2002:a17:903:230c:b0:215:a2f4:d4ab with SMTP id d9443c01a7336-22367434621mr18671115ad.7.1740695026547;
        Thu, 27 Feb 2025 14:23:46 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5979sm20610315ad.151.2025.02.27.14.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:23:46 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 1/1] selftests/bpf: Fix dangling stdout seen by traffic monitor thread
Date: Thu, 27 Feb 2025 14:23:36 -0800
Message-ID: <20250227222336.2236460-1-ameryhung@gmail.com>
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
 tools/testing/selftests/bpf/network_helpers.h |  6 ++--
 tools/testing/selftests/bpf/test_progs.c      | 29 +++++++++++++------
 3 files changed, 31 insertions(+), 12 deletions(-)

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
index 9f6e05d886c5..b80954eab8d8 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -251,11 +251,13 @@ struct tmonitor_ctx;
 
 #ifdef TRAFFIC_MONITOR
 struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
-					   const char *subtest_name);
+					   const char *subtest_name,
+					   pthread_mutex_t *stdout_lock);
 void traffic_monitor_stop(struct tmonitor_ctx *ctx);
 #else
 static inline struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
-							 const char *subtest_name)
+							 const char *subtest_name,
+							 pthread_mutex_t *stdout_lock)
 {
 	return NULL;
 }
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


