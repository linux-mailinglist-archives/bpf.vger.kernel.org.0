Return-Path: <bpf+bounces-79085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6C5D26830
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 797FF304C53D
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F643C00B0;
	Thu, 15 Jan 2026 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ok+n70MR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC83BF2EA
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497973; cv=none; b=fJSpGqkOQ8x1rl2xvW0f/uDlyiSt0qTHZ8ZpzLn1QF0TF9wRZL0WewtciwHP+tZfuXSzcOkHpwf7gK1x9WMr1lLLedDFEzoSXKenrmI32ALoRBLwQRmWIXF3+To/fZVlKc2vAU5qnTn5odeU3DKPHpCuD7+9rtmkMpymqNLXwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497973; c=relaxed/simple;
	bh=GZcEHYQTtmZ0VfDcQ20iq3OLyxEpGboaa5o647sLiJE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=po0LnqVLtxhq2//yO/N1TiTfaYuAQ1CCnVUWcWHMHJo4KCyAMCqpw8HhtT4SP0kDIrpv2aY2yLnzip2+HojoXo2VrAjx3WntNlD/yosPsmoaP5k01t2/TNYH+6fIFP3iBtdDwWpF1aeikqDSnduUZIntkz6oQ4QS93CUvrX5Q/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ok+n70MR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768497970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60sKp2ZfEgwvQCWM+SD55B2y7ixOltC+YNnJohYOh4k=;
	b=Ok+n70MRnCPCPOPFvwVjre+G1dP6rthXwQ1ECzM2r5qqltv6XZhXt/bLACUVOREbgjqiBY
	ILNceYwC8U21Uo9qkIE9107nlxRNO6T8pWpnGUp15soEK3P+Lsz7Z1/GN+dhrI7MHOJraz
	b4yz6Xrcd+wIXosILyCpaedAzjBrSrs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-5_Q0xnrFM8CY7zLUftDHaQ-1; Thu,
 15 Jan 2026 12:26:04 -0500
X-MC-Unique: 5_Q0xnrFM8CY7zLUftDHaQ-1
X-Mimecast-MFC-AGG-ID: 5_Q0xnrFM8CY7zLUftDHaQ_1768497963
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EABE195606E;
	Thu, 15 Jan 2026 17:26:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8278A1800285;
	Thu, 15 Jan 2026 17:25:58 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v3 05/18] rtla: Replace magic number with MAX_PATH
Date: Thu, 15 Jan 2026 13:31:48 -0300
Message-ID: <20260115163650.118910-6-wander@redhat.com>
In-Reply-To: <20260115163650.118910-1-wander@redhat.com>
References: <20260115163650.118910-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The trace functions use a buffer to manipulate strings that will be
written to tracefs files. These buffers are defined with a magic number
of 1024, which is a common source of vulnerabilities.

Replace the magic number 1024 with the MAX_PATH macro to make the code
safer and more readable. While at it, replace other instances of the
magic number with ARRAY_SIZE() when the buffer is locally defined.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/osnoise.c    |  4 ++--
 tools/tracing/rtla/src/timerlat_u.c |  4 ++--
 tools/tracing/rtla/src/trace.c      | 20 ++++++++++----------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index ec074cd53dd84..4890a9a9d6466 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -52,7 +52,7 @@ char *osnoise_get_cpus(struct osnoise_context *context)
 int osnoise_set_cpus(struct osnoise_context *context, char *cpus)
 {
 	char *orig_cpus = osnoise_get_cpus(context);
-	char buffer[1024];
+	char buffer[MAX_PATH];
 	int retval;
 
 	if (!orig_cpus)
@@ -62,7 +62,7 @@ int osnoise_set_cpus(struct osnoise_context *context, char *cpus)
 	if (!context->curr_cpus)
 		return -1;
 
-	snprintf(buffer, 1024, "%s\n", cpus);
+	snprintf(buffer, ARRAY_SIZE(buffer), "%s\n", cpus);
 
 	debug_msg("setting cpus to %s from %s", cpus, context->orig_cpus);
 
diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index ce68e39d25fde..efe2f72686486 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -32,7 +32,7 @@
 static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
 {
 	struct sched_param sp = { .sched_priority = 95 };
-	char buffer[1024];
+	char buffer[MAX_PATH];
 	int timerlat_fd;
 	cpu_set_t set;
 	int retval;
@@ -83,7 +83,7 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
 
 	/* add should continue with a signal handler */
 	while (true) {
-		retval = read(timerlat_fd, buffer, 1024);
+		retval = read(timerlat_fd, buffer, ARRAY_SIZE(buffer));
 		if (retval < 0)
 			break;
 	}
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 211ca54b15b0e..e1af54f9531b8 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -313,7 +313,7 @@ void trace_event_add_trigger(struct trace_events *event, char *trigger)
 static void trace_event_disable_filter(struct trace_instance *instance,
 				       struct trace_events *tevent)
 {
-	char filter[1024];
+	char filter[MAX_PATH];
 	int retval;
 
 	if (!tevent->filter)
@@ -325,7 +325,7 @@ static void trace_event_disable_filter(struct trace_instance *instance,
 	debug_msg("Disabling %s:%s filter %s\n", tevent->system,
 		  tevent->event ? : "*", tevent->filter);
 
-	snprintf(filter, 1024, "!%s\n", tevent->filter);
+	snprintf(filter, ARRAY_SIZE(filter), "!%s\n", tevent->filter);
 
 	retval = tracefs_event_file_write(instance->inst, tevent->system,
 					  tevent->event, "filter", filter);
@@ -344,7 +344,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 {
 	int retval, index, out_fd;
 	mode_t mode = 0644;
-	char path[1024];
+	char path[MAX_PATH];
 	char *hist;
 
 	if (!tevent)
@@ -359,7 +359,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 	if (retval)
 		return;
 
-	snprintf(path, 1024, "%s_%s_hist.txt", tevent->system, tevent->event);
+	snprintf(path, ARRAY_SIZE(path), "%s_%s_hist.txt", tevent->system, tevent->event);
 
 	printf("  Saving event %s:%s hist to %s\n", tevent->system, tevent->event, path);
 
@@ -391,7 +391,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 static void trace_event_disable_trigger(struct trace_instance *instance,
 					struct trace_events *tevent)
 {
-	char trigger[1024];
+	char trigger[MAX_PATH];
 	int retval;
 
 	if (!tevent->trigger)
@@ -405,7 +405,7 @@ static void trace_event_disable_trigger(struct trace_instance *instance,
 
 	trace_event_save_hist(instance, tevent);
 
-	snprintf(trigger, 1024, "!%s\n", tevent->trigger);
+	snprintf(trigger, ARRAY_SIZE(trigger), "!%s\n", tevent->trigger);
 
 	retval = tracefs_event_file_write(instance->inst, tevent->system,
 					  tevent->event, "trigger", trigger);
@@ -444,7 +444,7 @@ void trace_events_disable(struct trace_instance *instance,
 static int trace_event_enable_filter(struct trace_instance *instance,
 				     struct trace_events *tevent)
 {
-	char filter[1024];
+	char filter[MAX_PATH];
 	int retval;
 
 	if (!tevent->filter)
@@ -456,7 +456,7 @@ static int trace_event_enable_filter(struct trace_instance *instance,
 		return 1;
 	}
 
-	snprintf(filter, 1024, "%s\n", tevent->filter);
+	snprintf(filter, ARRAY_SIZE(filter), "%s\n", tevent->filter);
 
 	debug_msg("Enabling %s:%s filter %s\n", tevent->system,
 		  tevent->event ? : "*", tevent->filter);
@@ -479,7 +479,7 @@ static int trace_event_enable_filter(struct trace_instance *instance,
 static int trace_event_enable_trigger(struct trace_instance *instance,
 				      struct trace_events *tevent)
 {
-	char trigger[1024];
+	char trigger[MAX_PATH];
 	int retval;
 
 	if (!tevent->trigger)
@@ -491,7 +491,7 @@ static int trace_event_enable_trigger(struct trace_instance *instance,
 		return 1;
 	}
 
-	snprintf(trigger, 1024, "%s\n", tevent->trigger);
+	snprintf(trigger, ARRAY_SIZE(trigger), "%s\n", tevent->trigger);
 
 	debug_msg("Enabling %s:%s trigger %s\n", tevent->system,
 		  tevent->event ? : "*", tevent->trigger);
-- 
2.52.0


