Return-Path: <bpf+bounces-74788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF553C65D8F
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A88004EEC97
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 19:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3DC338596;
	Mon, 17 Nov 2025 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yd7FNE49"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E432E12A
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405819; cv=none; b=de8mSUJ/mUUo8nLtFRTdNHXAMEs05pnYtE2qi9RAsaDAy8EwRhmSo8+xkWfC90dBjI+cIjH2WAuXA9AhUo+rkjLiBFHU+kfi+adyG3X2Y9mEGChVUW45Wmv9XT6XM+z6YZZwSCYk8DsyU315bBR9lQU/cIW3MXl/n7h/rDizI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405819; c=relaxed/simple;
	bh=dKoUYxM8LL9t2vzI/PpW0eLOO45rOCFrE/qFP2Mf2do=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaeirAnHdILhYb74cVdQa9uyHbAsntbj40wKdk1FXgjZw1UmOfNxhS6mJZ8sKe2/g3VWIqvZflhSGzsqT84axE0RlUA5WlRPCUORwvtSR3CA/jsozFAlRPZNPkFWRii+c8S32FLwiiRYEHpEdC2e9hSIZ4SrpY77hCU0ZCOjPfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yd7FNE49; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763405816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W92+hDsPlnWwpf3RV+flsE4eFQLqmU6MxoptDwLVLG4=;
	b=Yd7FNE49yFZuCs8PIAuaV6cDoEa2+s5hG9DvQBNwveEEe32E2/i3UQlXUXLwgAMyjLphdj
	pVYENPVqZ2acKh1ZSZTMP6InXgKsNhCbwYq5X6ey/1NjmGfuKQVQooL6wyWIIrYdJGlOZy
	GdCh0EiKGfn2RG3GFDZSb9eM/8c6az0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-WJFHpT6FO62vQGJQD6W6Rw-1; Mon,
 17 Nov 2025 13:56:55 -0500
X-MC-Unique: WJFHpT6FO62vQGJQD6W6Rw-1
X-Mimecast-MFC-AGG-ID: WJFHpT6FO62vQGJQD6W6Rw_1763405814
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3962E1956094;
	Mon, 17 Nov 2025 18:56:54 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.81.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FB8D180049F;
	Mon, 17 Nov 2025 18:56:49 +0000 (UTC)
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
Subject: [rtla 11/13] rtla: Replace magic number with MAX_PATH
Date: Mon, 17 Nov 2025 15:41:18 -0300
Message-ID: <20251117184409.42831-12-wander@redhat.com>
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
index 5075e0f485c77..d502cbbcea91b 100644
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
index 01dbf9a6b5a51..52977e725c79c 100644
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
@@ -87,7 +87,7 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
 
 	/* add should continue with a signal handler */
 	while (true) {
-		retval = read(timerlat_fd, buffer, 1024);
+		retval = read(timerlat_fd, buffer, ARRAY_SIZE(buffer));
 		if (retval < 0)
 			break;
 	}
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 813f4368f104b..658a6e94edfba 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -330,7 +330,7 @@ int trace_event_add_trigger(struct trace_events *event, char *trigger)
 static void trace_event_disable_filter(struct trace_instance *instance,
 				       struct trace_events *tevent)
 {
-	char filter[1024];
+	char filter[MAX_PATH];
 	int retval;
 
 	if (!tevent->filter)
@@ -342,7 +342,7 @@ static void trace_event_disable_filter(struct trace_instance *instance,
 	debug_msg("Disabling %s:%s filter %s\n", tevent->system,
 		  tevent->event ? : "*", tevent->filter);
 
-	snprintf(filter, 1024, "!%s\n", tevent->filter);
+	snprintf(filter, ARRAY_SIZE(filter), "!%s\n", tevent->filter);
 
 	retval = tracefs_event_file_write(instance->inst, tevent->system,
 					  tevent->event, "filter", filter);
@@ -361,7 +361,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 {
 	int retval, index, out_fd;
 	mode_t mode = 0644;
-	char path[1024];
+	char path[MAX_PATH];
 	char *hist;
 
 	if (!tevent)
@@ -376,7 +376,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 	if (retval)
 		return;
 
-	snprintf(path, 1024, "%s_%s_hist.txt", tevent->system, tevent->event);
+	snprintf(path, ARRAY_SIZE(path), "%s_%s_hist.txt", tevent->system, tevent->event);
 
 	printf("  Saving event %s:%s hist to %s\n", tevent->system, tevent->event, path);
 
@@ -408,7 +408,7 @@ static void trace_event_save_hist(struct trace_instance *instance,
 static void trace_event_disable_trigger(struct trace_instance *instance,
 					struct trace_events *tevent)
 {
-	char trigger[1024];
+	char trigger[MAX_PATH];
 	int retval;
 
 	if (!tevent->trigger)
@@ -422,7 +422,7 @@ static void trace_event_disable_trigger(struct trace_instance *instance,
 
 	trace_event_save_hist(instance, tevent);
 
-	snprintf(trigger, 1024, "!%s\n", tevent->trigger);
+	snprintf(trigger, ARRAY_SIZE(trigger), "!%s\n", tevent->trigger);
 
 	retval = tracefs_event_file_write(instance->inst, tevent->system,
 					  tevent->event, "trigger", trigger);
@@ -461,7 +461,7 @@ void trace_events_disable(struct trace_instance *instance,
 static int trace_event_enable_filter(struct trace_instance *instance,
 				     struct trace_events *tevent)
 {
-	char filter[1024];
+	char filter[MAX_PATH];
 	int retval;
 
 	if (!tevent->filter)
@@ -473,7 +473,7 @@ static int trace_event_enable_filter(struct trace_instance *instance,
 		return 1;
 	}
 
-	snprintf(filter, 1024, "%s\n", tevent->filter);
+	snprintf(filter, ARRAY_SIZE(filter), "%s\n", tevent->filter);
 
 	debug_msg("Enabling %s:%s filter %s\n", tevent->system,
 		  tevent->event ? : "*", tevent->filter);
@@ -496,7 +496,7 @@ static int trace_event_enable_filter(struct trace_instance *instance,
 static int trace_event_enable_trigger(struct trace_instance *instance,
 				      struct trace_events *tevent)
 {
-	char trigger[1024];
+	char trigger[MAX_PATH];
 	int retval;
 
 	if (!tevent->trigger)
@@ -508,7 +508,7 @@ static int trace_event_enable_trigger(struct trace_instance *instance,
 		return 1;
 	}
 
-	snprintf(trigger, 1024, "%s\n", tevent->trigger);
+	snprintf(trigger, ARRAY_SIZE(trigger), "%s\n", tevent->trigger);
 
 	debug_msg("Enabling %s:%s trigger %s\n", tevent->system,
 		  tevent->event ? : "*", tevent->trigger);
-- 
2.51.1


