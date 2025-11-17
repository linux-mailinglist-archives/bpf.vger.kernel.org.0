Return-Path: <bpf+bounces-74783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D5C65D5B
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 842A929990
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 18:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C06F32E6A4;
	Mon, 17 Nov 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXwaqvjT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CD028468B
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405743; cv=none; b=rK1Ipyi3NuNVrarOyEV3QkSRWggfUcetrlJJhFofyh2GxGmTb3AhwxcbGt3Pj+r6MZFWp5qyHdslXXZP5s86UoxhLbQ+j/fzfs735fM6V0JVMsTKdbjGsfKNTPn1vRNgcwmFBmU1Yh+tNtkM0eAwJ08GGg+lTk8y4f+gDL/DzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405743; c=relaxed/simple;
	bh=tnI1EaKbMieNMigeQvtO8p5L3U+og8rdEkrT0BhVuXs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWoSFaCJY45k1lHg5RlVDCCwK0xUxLiCHbYMt5JTB47JcFjTfAPazijQP43emPasD7jNDYN8GMDK8GZzsjO+3riAp1uzEcOyyiAPPEactjGLE0DzvCVvScHZNkSKl0CW6vqWLO/ll5fK9jcls2Xhrhw+dfTNN4Jirf0ppZRAVWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXwaqvjT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3e7CVvlx3nIx4QGPbhLxrbC/FxCpFgytr2n93bg8nU=;
	b=fXwaqvjTmvV+tjxX/bS1VnodDV5ioezyxH6hyMlhaF+hqf7qgCuy7lbQAZ6V2m5prXB5G+
	Wpsf9jZujhdAFWCL6t0jXIhanABoPBsK2tdLf9Z+AwsAf0SajxxG7Zr+B88jwqzjthPHkJ
	24JUZhtGZbYO8r8hiRXBQ6Nsz247V2U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-Lz-5stYsN4ur77cBx3ANnA-1; Mon,
 17 Nov 2025 13:55:38 -0500
X-MC-Unique: Lz-5stYsN4ur77cBx3ANnA-1
X-Mimecast-MFC-AGG-ID: Lz-5stYsN4ur77cBx3ANnA_1763405733
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CED518A1B1A;
	Mon, 17 Nov 2025 18:55:33 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F04F41800367;
	Mon, 17 Nov 2025 18:55:28 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [rtla 06/13] rtla: Use strncmp_static() in more places
Date: Mon, 17 Nov 2025 15:41:13 -0300
Message-ID: <20251117184409.42831-7-wander@redhat.com>
In-Reply-To: <20251117184409.42831-1-wander@redhat.com>
References: <20251117184409.42831-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The recently introduced strncmp_static() helper provides a safer way
to compare strings with static strings by determining the length at
compile time.

Replace several open-coded strncmp() calls with strncmp_static() to
improve code readability and robustness. This change affects the
parsing of command-line arguments and environment variables.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/osnoise.c  | 2 +-
 tools/tracing/rtla/src/timerlat.c | 4 ++--
 tools/tracing/rtla/src/trace.c    | 2 +-
 tools/tracing/rtla/src/utils.c    | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 312c511fa0044..5075e0f485c77 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1229,7 +1229,7 @@ int osnoise_main(int argc, char *argv[])
 
 	if ((strcmp(argv[1], "-h") == 0) || (strcmp(argv[1], "--help") == 0)) {
 		osnoise_usage(0);
-	} else if (strncmp(argv[1], "-", 1) == 0) {
+	} else if (strncmp_static(argv[1], "-") == 0) {
 		/* the user skipped the tool, call the default one */
 		run_tool(&osnoise_top_ops, argc, argv);
 		exit(0);
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index b692128741279..56e0b8af041d7 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -34,7 +34,7 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 	 * Try to enable BPF, unless disabled explicitly.
 	 * If BPF enablement fails, fall back to tracefs mode.
 	 */
-	if (getenv("RTLA_NO_BPF") && strncmp(getenv("RTLA_NO_BPF"), "1", 2) == 0) {
+	if (getenv("RTLA_NO_BPF") && strncmp_static(getenv("RTLA_NO_BPF"), "1") == 0) {
 		debug_msg("RTLA_NO_BPF set, disabling BPF\n");
 		params->mode = TRACING_MODE_TRACEFS;
 	} else if (!tep_find_event_by_name(tool->trace.tep, "osnoise", "timerlat_sample")) {
@@ -275,7 +275,7 @@ int timerlat_main(int argc, char *argv[])
 
 	if ((strcmp(argv[1], "-h") == 0) || (strcmp(argv[1], "--help") == 0)) {
 		timerlat_usage(0);
-	} else if (strncmp(argv[1], "-", 1) == 0) {
+	} else if (strncmp_static(argv[1], "-") == 0) {
 		/* the user skipped the tool, call the default one */
 		run_tool(&timerlat_top_ops, argc, argv);
 		exit(0);
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 69cbc48d53d3a..813f4368f104b 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -372,7 +372,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 		return;
 
 	/* is this a hist: trigger? */
-	retval = strncmp(tevent->trigger, "hist:", strlen("hist:"));
+	retval = strncmp_static(tevent->trigger, "hist:");
 	if (retval)
 		return;
 
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 4cb765b94feec..f13d00d7b6bfe 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -196,15 +196,15 @@ long parse_ns_duration(char *val)
 	t = strtol(val, &end, 10);
 
 	if (end) {
-		if (!strncmp(end, "ns", 2)) {
+		if (!strncmp_static(end, "ns")) {
 			return t;
-		} else if (!strncmp(end, "us", 2)) {
+		} else if (!strncmp_static(end, "us")) {
 			t *= 1000;
 			return t;
-		} else if (!strncmp(end, "ms", 2)) {
+		} else if (!strncmp_static(end, "ms")) {
 			t *= 1000 * 1000;
 			return t;
-		} else if (!strncmp(end, "s", 1)) {
+		} else if (!strncmp_static(end, "s")) {
 			t *= 1000 * 1000 * 1000;
 			return t;
 		}
-- 
2.51.1


