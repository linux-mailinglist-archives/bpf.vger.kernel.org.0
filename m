Return-Path: <bpf+bounces-52812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A193CA48B16
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 23:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E787A6674
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 22:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426082702D7;
	Thu, 27 Feb 2025 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKn0O/Cc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401731DE2A7
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694073; cv=none; b=rtEtlcZUh/7eEpmJasmvq2XvqKksxCUSsd8RShYtK96Danp+jbWXkBK3vtttlp4Zzs0m2OVhQO7HJa2FjNRsWzgeiiBiep4be+kARPMhUO+h+piu3xJcA69BPi5a8q1pIhBtCywfO1hjCDLnO91r1FAPOLx4E8dNalh7eai3F0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694073; c=relaxed/simple;
	bh=BeBDypbw7F8iA3i/DOzFaewa+TtODYfRgG92g5rtr64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IQwmZU8xKPXpQMQGwvrSKsjwjodAQ5yCyXGUo6x6RKn49aHN8JyijLmPkuJGnpKLdP+nIJpP2cnkWNLzFDqdSMwaE8wcHGSw4otH7mtJUHABFk7ijhbpvFdvuwKZgfhgFWB92s3KRwTIvLF2EUPYlDyxrtoJduWM30LR9HMgAjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKn0O/Cc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fce3b01efcso2221311a91.3
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 14:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694071; x=1741298871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YIVfRI5pF7VBMeGJ2nF2Re9S1Cx/UOrTuNw+Wunz1cU=;
        b=EKn0O/CcuhSvngym0SUCu9hcDlC5J/s4FN1BrNtr09Ylh+gMFKMSeMUHnLhD6XOw+U
         igbbaE/4QVOKP/BBcctdyIDJnoTk2XohbGYuOvR6c6Z/0uhokhqXarF5SVnlaDXDc70c
         ifv1EVP4BHprlhlWWwy3r3pLf6C/6v+OlmewiMqE2qCeF0KTMTVlqhZx12ham/6URRhA
         9n1k28yu0ymaHWdvz/RS2TDCRvLzMv5gHOlXdtQst39JCQuA5naGrwl4BKqcDN+Gwk2O
         3iWf854fwaakjx/eA/RBHtONGIyffyKnzTWqujjLFD7TD83RG+w95u4xTPfX7TeZMlkQ
         hHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694071; x=1741298871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIVfRI5pF7VBMeGJ2nF2Re9S1Cx/UOrTuNw+Wunz1cU=;
        b=ZCW/itj5Zrbxhz8kAN7nOCeqIwSZ2TSqd6fdYeEcRg/TLdmN+ztWn+9RrVSVpOMCQ4
         tGG7sG9ZFB1fqGclHQGCahhjPxqBI1+946r2KlD23Dar4Q0MVMBo6KDbBw/oQlJy3VmJ
         w0jl1uKGHk5RcrUMDt/Fymaw+3CRPWtJN0ga1E5aRp6FSvmgOK9qGFBQTnnc82K+Az2c
         XWW3NZ5uvlyFed41RGyoRNHEpXio2hk6sSVzvrAVtdjNp02UxgUSFgbmOnkXOFCNHoRy
         1XDCaUhFUKPi1brocRtqKS7vFUMeIY8BRCkxluoOtStNBDflYszWQzEKc7uq2zrUGHYK
         eryA==
X-Gm-Message-State: AOJu0YybqnA8kSBXlvvI4cwBDnazjdcjY+YSBYKzWb6K8ZvJUwrofj9N
	gXdHVe/d+TSEX7XjXgNRYdrmRO1ZrW56LPrB4Nsmp2NBYK9bQGpf3nFsBg==
X-Gm-Gg: ASbGncsyws1CFcgb7AeBwlodoR+f+XYOW7Zpll0wXNVVK6D1uPILSQHLoDDFpijrcVF
	Dj8BdBmAj9aYxMZLlFzJQAz2FlzA6uiuWsVoYQf345sp7ML0yBLT+UDIA7BGVpvT5/4KxPr+pB7
	zMmPz7IwS/nD7lUL2Bv+CyYwX0Nlj8gmNeC5mFLyAb0fKklPgNwtPaPvIcy9kDlz9BQ3ywCgj4S
	QNC5gludrV9xSFPs06Eq/HMuhsR0+kGVoIiHl6t2fXLs07T/HZkS9X0RjnICUfho1mMBsirG9P8
	l4eowfawcZPLfnzwyzeutQ6hfF73pA7TR35qaq6AA+IdpesL2k2msS4ulyYkAfUwUFKgiNUCgGk
	H
X-Google-Smtp-Source: AGHT+IHjV6Mdu+C5HtF1LxT9ud+1XL+A4oAbge0KitLiY9sMKu02d7HxR41otGPnFWJK+mhDAj3Jwg==
X-Received: by 2002:a17:90b:1b09:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-2febac1093dmr1609572a91.33.1740694071149;
        Thu, 27 Feb 2025 14:07:51 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea696d58esm2277881a91.30.2025.02.27.14.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:07:50 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/1] selftests/bpf: Fix dangling stdout seen by traffic monitor thread
Date: Thu, 27 Feb 2025 14:07:39 -0800
Message-ID: <20250227220739.2188272-1-ameryhung@gmail.com>
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
index 9f6e05d886c5..c64c58297bee 100644
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
+							 pthread_mutex_t *stdout_lock);
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


