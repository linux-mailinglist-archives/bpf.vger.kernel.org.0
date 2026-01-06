Return-Path: <bpf+bounces-77950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD631CF89B8
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E1363025A85
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC5B344022;
	Tue,  6 Jan 2026 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6AeM9g2"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C24D31B808
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707046; cv=none; b=qDJ8jLAjkxRZ9H0qbsCTEURdSYfz34o/cBSzQIw07imbt+ijSYebkzeyZV+Uow0hw/fO2awDE/nqJjb8rMupHXv3cBqYCfCdk0jfCYesrjJ+3QiK3ePqnbXM9J7mq3iIvMPTsOmgOqykKnilFee2d3q/fKM3I58TUNtArprQb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707046; c=relaxed/simple;
	bh=2U4r2XRmpmt1WppRdog4l707g0lRT881+Ovs94/4edM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnclF9fVq++SPqBhQw0TxY04bSWOXePHfPfi/VKk6nTH3a8jTJAfxJZ+dlcr1QxAqbBZiv+tq9YvjV1ejvMuAyf4H7UIpPtphlMm9Ti6Ta2XqW9mc8+sWl5WcdWcz5+lrw7AZBiQOkq8iKo+y68L49Ut7Z7JQ3i9YqEamus0M0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6AeM9g2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O/mLUsFgLgHuGHJkWjp3gM3O8QtESBk5+FkGgdYbFbM=;
	b=K6AeM9g2LQQiIFPEvETBXOApEk4DXtu+ASOy+++vGkHi8npTA84rNArpWdc6ZzSHy5cN0V
	pb+e1HQKEQasU1qCU2cXpyCn00S/HOopOiachjuKb5rDVH+zKlJfMo1WnxEDgYfJ+iC2c6
	9ArKZoGa/1M7ZuveFbLx/fj6sj5kH/A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-PRmrgqd9MwKXz6FBrBlZew-1; Tue,
 06 Jan 2026 08:44:01 -0500
X-MC-Unique: PRmrgqd9MwKXz6FBrBlZew-1
X-Mimecast-MFC-AGG-ID: PRmrgqd9MwKXz6FBrBlZew_1767707040
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1594D1956058;
	Tue,  6 Jan 2026 13:44:00 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7091B1800367;
	Tue,  6 Jan 2026 13:43:56 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v2 10/18] rtla: Replace magic number with MAX_PATH
Date: Tue,  6 Jan 2026 08:49:46 -0300
Message-ID: <20260106133655.249887-11-wander@redhat.com>
In-Reply-To: <20260106133655.249887-1-wander@redhat.com>
References: <20260106133655.249887-1-wander@redhat.com>
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
index f2ec2da7b6d3a..68927d799dde5 100644
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
index 45328c5121f79..0a81a2e4667ef 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -314,7 +314,7 @@ void trace_event_add_trigger(struct trace_events *event, char *trigger)
 static void trace_event_disable_filter(struct trace_instance *instance,
 				       struct trace_events *tevent)
 {
-	char filter[1024];
+	char filter[MAX_PATH];
 	int retval;
 
 	if (!tevent->filter)
@@ -326,7 +326,7 @@ static void trace_event_disable_filter(struct trace_instance *instance,
 	debug_msg("Disabling %s:%s filter %s\n", tevent->system,
 		  tevent->event ? : "*", tevent->filter);
 
-	snprintf(filter, 1024, "!%s\n", tevent->filter);
+	snprintf(filter, ARRAY_SIZE(filter), "!%s\n", tevent->filter);
 
 	retval = tracefs_event_file_write(instance->inst, tevent->system,
 					  tevent->event, "filter", filter);
@@ -345,7 +345,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 {
 	int retval, index, out_fd;
 	mode_t mode = 0644;
-	char path[1024];
+	char path[MAX_PATH];
 	char *hist;
 
 	if (!tevent)
@@ -360,7 +360,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 	if (retval)
 		return;
 
-	snprintf(path, 1024, "%s_%s_hist.txt", tevent->system, tevent->event);
+	snprintf(path, ARRAY_SIZE(path), "%s_%s_hist.txt", tevent->system, tevent->event);
 
 	printf("  Saving event %s:%s hist to %s\n", tevent->system, tevent->event, path);
 
@@ -392,7 +392,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 static void trace_event_disable_trigger(struct trace_instance *instance,
 					struct trace_events *tevent)
 {
-	char trigger[1024];
+	char trigger[MAX_PATH];
 	int retval;
 
 	if (!tevent->trigger)
@@ -406,7 +406,7 @@ static void trace_event_disable_trigger(struct trace_instance *instance,
 
 	trace_event_save_hist(instance, tevent);
 
-	snprintf(trigger, 1024, "!%s\n", tevent->trigger);
+	snprintf(trigger, ARRAY_SIZE(trigger), "!%s\n", tevent->trigger);
 
 	retval = tracefs_event_file_write(instance->inst, tevent->system,
 					  tevent->event, "trigger", trigger);
@@ -445,7 +445,7 @@ void trace_events_disable(struct trace_instance *instance,
 static int trace_event_enable_filter(struct trace_instance *instance,
 				     struct trace_events *tevent)
 {
-	char filter[1024];
+	char filter[MAX_PATH];
 	int retval;
 
 	if (!tevent->filter)
@@ -457,7 +457,7 @@ static int trace_event_enable_filter(struct trace_instance *instance,
 		return 1;
 	}
 
-	snprintf(filter, 1024, "%s\n", tevent->filter);
+	snprintf(filter, ARRAY_SIZE(filter), "%s\n", tevent->filter);
 
 	debug_msg("Enabling %s:%s filter %s\n", tevent->system,
 		  tevent->event ? : "*", tevent->filter);
@@ -480,7 +480,7 @@ static int trace_event_enable_filter(struct trace_instance *instance,
 static int trace_event_enable_trigger(struct trace_instance *instance,
 				      struct trace_events *tevent)
 {
-	char trigger[1024];
+	char trigger[MAX_PATH];
 	int retval;
 
 	if (!tevent->trigger)
@@ -492,7 +492,7 @@ static int trace_event_enable_trigger(struct trace_instance *instance,
 		return 1;
 	}
 
-	snprintf(trigger, 1024, "%s\n", tevent->trigger);
+	snprintf(trigger, ARRAY_SIZE(trigger), "%s\n", tevent->trigger);
 
 	debug_msg("Enabling %s:%s trigger %s\n", tevent->system,
 		  tevent->event ? : "*", tevent->trigger);
-- 
2.52.0


