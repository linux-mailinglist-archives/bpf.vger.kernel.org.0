Return-Path: <bpf+bounces-79081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CD0D26AF1
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C884E3276E89
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A33BF31D;
	Thu, 15 Jan 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOjD4v4g"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422E43BF2FF
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497893; cv=none; b=QjunAG29fvGhifzqlN1Jbt3RrHTzu/QDacmNrPZL0Bb1sMhppTcEv7Ban+lLjDqbTKxgYhTnrOfWNuzmxTeFgTNE2jFXLILnd2yC82GOLjMOREme7OiKjN6uKJIlHQuE9znuRbHHJKIMf6x4R9TE3agSuDAPmc9+JqLgB9qkE/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497893; c=relaxed/simple;
	bh=lpv/5z9xSeKmIzg4U8Z/mGk6pdKQOx9JE/ymYcbtrKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvMLe87Yw/f+L+fu9HvWSO2SInhRROj4S6MwrWEU8n6L/kqTXp/H11ahW3Vr0X4tKSPz2MzSe/1KKoxrapFY2Y8gQp/rpUWzB37EDnaIVRXUwENuNW8amuw0y+ha01mqhTGDWkvBn0IUVUcr13pK9YxI7d3rZTc49U2Ctui9B7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OOjD4v4g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768497890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jpVUckxFnqqTc+pbFGmUzfoOXq0tLVqdR2qqu4/NzrM=;
	b=OOjD4v4gfZN5LamnzRNn9M4wID9k++/0L8DmjseixhT/IHyO42/lKOWA4JOv9qlpQ1SSOM
	9tGA2o8amrZOM2CWasfOxDMmOZ4FzsKbIygk2KlNOnnJhwgY08pqo8oar61qrqFciqdsD3
	gNZAThJrtw0Uy/1gAjAtw27Awr9lKXc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-uPkaOWbAN2m81idWKl3kbw-1; Thu,
 15 Jan 2026 12:24:46 -0500
X-MC-Unique: uPkaOWbAN2m81idWKl3kbw-1
X-Mimecast-MFC-AGG-ID: uPkaOWbAN2m81idWKl3kbw_1768497885
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A3DE1800357;
	Thu, 15 Jan 2026 17:24:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.87])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 112791800285;
	Thu, 15 Jan 2026 17:24:38 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Haiyong Sun <sunhaiyong@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Wagner <dwagner@suse.de>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v3 01/18] rtla: Exit on memory allocation failures during initialization
Date: Thu, 15 Jan 2026 13:31:44 -0300
Message-ID: <20260115163650.118910-2-wander@redhat.com>
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

Most memory allocations in rtla happen during early initialization
before any resources are acquired that would require cleanup. In these
cases, propagating allocation errors just adds complexity without any
benefit. There's nothing to clean up, and the program must exit anyway.

This patch introduces fatal allocation wrappers (calloc_fatal,
reallocarray_fatal, strdup_fatal) that call fatal() on allocation
failure. These wrappers simplify the code by eliminating unnecessary
error propagation paths.

The patch converts early allocations to use these wrappers in
actions_init() and related action functions, osnoise_context_alloc()
and osnoise_init_tool(), trace_instance_init() and trace event
functions, and parameter structure allocations in main functions.

This simplifies the code while maintaining the same behavior: immediate
exit on allocation failure during initialization. Allocations that
require cleanup, such as those in histogram allocation functions with
goto cleanup paths, are left unchanged and continue to return errors.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c       | 50 ++++++++++++--------------
 tools/tracing/rtla/src/actions.h       |  8 ++---
 tools/tracing/rtla/src/osnoise.c       | 22 ++++--------
 tools/tracing/rtla/src/osnoise_hist.c  | 22 ++++--------
 tools/tracing/rtla/src/osnoise_top.c   | 22 ++++--------
 tools/tracing/rtla/src/timerlat_hist.c | 22 ++++--------
 tools/tracing/rtla/src/timerlat_top.c  | 22 ++++--------
 tools/tracing/rtla/src/trace.c         | 30 ++++------------
 tools/tracing/rtla/src/trace.h         |  4 +--
 tools/tracing/rtla/src/utils.c         | 35 ++++++++++++++++++
 tools/tracing/rtla/src/utils.h         |  3 ++
 11 files changed, 108 insertions(+), 132 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index a42615011962d..22b8283a183f3 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -15,7 +15,7 @@ void
 actions_init(struct actions *self)
 {
 	self->size = action_default_size;
-	self->list = calloc(self->size, sizeof(struct action));
+	self->list = calloc_fatal(self->size, sizeof(struct action));
 	self->len = 0;
 	self->continue_flag = false;
 
@@ -50,8 +50,10 @@ static struct action *
 actions_new(struct actions *self)
 {
 	if (self->len >= self->size) {
-		self->size *= 2;
-		self->list = realloc(self->list, self->size * sizeof(struct action));
+		const size_t new_size = self->size * 2;
+
+		self->list = reallocarray_fatal(self->list, new_size, sizeof(struct action));
+		self->size = new_size;
 	}
 
 	return &self->list[self->len++];
@@ -60,25 +62,21 @@ actions_new(struct actions *self)
 /*
  * actions_add_trace_output - add an action to output trace
  */
-int
+void
 actions_add_trace_output(struct actions *self, const char *trace_output)
 {
 	struct action *action = actions_new(self);
 
 	self->present[ACTION_TRACE_OUTPUT] = true;
 	action->type = ACTION_TRACE_OUTPUT;
-	action->trace_output = calloc(strlen(trace_output) + 1, sizeof(char));
-	if (!action->trace_output)
-		return -1;
+	action->trace_output = calloc_fatal(strlen(trace_output) + 1, sizeof(char));
 	strcpy(action->trace_output, trace_output);
-
-	return 0;
 }
 
 /*
  * actions_add_trace_output - add an action to send signal to a process
  */
-int
+void
 actions_add_signal(struct actions *self, int signal, int pid)
 {
 	struct action *action = actions_new(self);
@@ -87,40 +85,32 @@ actions_add_signal(struct actions *self, int signal, int pid)
 	action->type = ACTION_SIGNAL;
 	action->signal = signal;
 	action->pid = pid;
-
-	return 0;
 }
 
 /*
  * actions_add_shell - add an action to execute a shell command
  */
-int
+void
 actions_add_shell(struct actions *self, const char *command)
 {
 	struct action *action = actions_new(self);
 
 	self->present[ACTION_SHELL] = true;
 	action->type = ACTION_SHELL;
-	action->command = calloc(strlen(command) + 1, sizeof(char));
-	if (!action->command)
-		return -1;
+	action->command = calloc_fatal(strlen(command) + 1, sizeof(char));
 	strcpy(action->command, command);
-
-	return 0;
 }
 
 /*
  * actions_add_continue - add an action to resume measurement
  */
-int
+void
 actions_add_continue(struct actions *self)
 {
 	struct action *action = actions_new(self);
 
 	self->present[ACTION_CONTINUE] = true;
 	action->type = ACTION_CONTINUE;
-
-	return 0;
 }
 
 /*
@@ -176,7 +166,8 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 				/* Only one argument allowed */
 				return -1;
 		}
-		return actions_add_trace_output(self, trace_output);
+		actions_add_trace_output(self, trace_output);
+		break;
 	case ACTION_SIGNAL:
 		/* Takes two arguments, num (signal) and pid */
 		while (token != NULL) {
@@ -200,21 +191,26 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 			/* Missing argument */
 			return -1;
 
-		return actions_add_signal(self, signal, pid);
+		actions_add_signal(self, signal, pid);
+		break;
 	case ACTION_SHELL:
 		if (token == NULL)
 			return -1;
-		if (strlen(token) > 8 && strncmp(token, "command=", 8) == 0)
-			return actions_add_shell(self, token + 8);
-		return -1;
+		if (strlen(token) > 8 && strncmp(token, "command=", 8))
+			return -1;
+		actions_add_shell(self, token + 8);
+		break;
 	case ACTION_CONTINUE:
 		/* Takes no argument */
 		if (token != NULL)
 			return -1;
-		return actions_add_continue(self);
+		actions_add_continue(self);
+		break;
 	default:
 		return -1;
 	}
+
+	return 0;
 }
 
 /*
diff --git a/tools/tracing/rtla/src/actions.h b/tools/tracing/rtla/src/actions.h
index fb77069c972ba..034048682fefb 100644
--- a/tools/tracing/rtla/src/actions.h
+++ b/tools/tracing/rtla/src/actions.h
@@ -49,9 +49,9 @@ struct actions {
 
 void actions_init(struct actions *self);
 void actions_destroy(struct actions *self);
-int actions_add_trace_output(struct actions *self, const char *trace_output);
-int actions_add_signal(struct actions *self, int signal, int pid);
-int actions_add_shell(struct actions *self, const char *command);
-int actions_add_continue(struct actions *self);
+void actions_add_trace_output(struct actions *self, const char *trace_output);
+void actions_add_signal(struct actions *self, int signal, int pid);
+void actions_add_shell(struct actions *self, const char *command);
+void actions_add_continue(struct actions *self);
 int actions_parse(struct actions *self, const char *trigger, const char *tracefn);
 int actions_perform(struct actions *self);
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 945eb61efc465..ec074cd53dd84 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -938,9 +938,7 @@ struct osnoise_context *osnoise_context_alloc(void)
 {
 	struct osnoise_context *context;
 
-	context = calloc(1, sizeof(*context));
-	if (!context)
-		return NULL;
+	context = calloc_fatal(1, sizeof(*context));
 
 	context->orig_stop_us		= OSNOISE_OPTION_INIT_VAL;
 	context->stop_us		= OSNOISE_OPTION_INIT_VAL;
@@ -1017,24 +1015,16 @@ void osnoise_destroy_tool(struct osnoise_tool *top)
 struct osnoise_tool *osnoise_init_tool(char *tool_name)
 {
 	struct osnoise_tool *top;
-	int retval;
-
-	top = calloc(1, sizeof(*top));
-	if (!top)
-		return NULL;
 
+	top = calloc_fatal(1, sizeof(*top));
 	top->context = osnoise_context_alloc();
-	if (!top->context)
-		goto out_err;
 
-	retval = trace_instance_init(&top->trace, tool_name);
-	if (retval)
-		goto out_err;
+	if (trace_instance_init(&top->trace, tool_name)) {
+		osnoise_destroy_tool(top);
+		return NULL;
+	}
 
 	return top;
-out_err:
-	osnoise_destroy_tool(top);
-	return NULL;
 }
 
 /*
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 9d70ea34807ff..efbd2e834cf0e 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -466,9 +466,7 @@ static struct common_params
 	int c;
 	char *trace_output = NULL;
 
-	params = calloc(1, sizeof(*params));
-	if (!params)
-		exit(1);
+	params = calloc_fatal(1, sizeof(*params));
 
 	actions_init(&params->common.threshold_actions);
 	actions_init(&params->common.end_actions);
@@ -579,22 +577,16 @@ static struct common_params
 			params->common.hist.with_zeros = 1;
 			break;
 		case '4': /* trigger */
-			if (params->common.events) {
-				retval = trace_event_add_trigger(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding trigger %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_trigger(params->common.events, optarg);
+			else
 				fatal("--trigger requires a previous -e");
-			}
 			break;
 		case '5': /* filter */
-			if (params->common.events) {
-				retval = trace_event_add_filter(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding filter %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_filter(params->common.events, optarg);
+			else
 				fatal("--filter requires a previous -e");
-			}
 			break;
 		case '6':
 			params->common.warmup = get_llong_from_str(optarg);
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index d54d47947fb44..d2b4ac64e77b4 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -319,9 +319,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 	int c;
 	char *trace_output = NULL;
 
-	params = calloc(1, sizeof(*params));
-	if (!params)
-		exit(1);
+	params = calloc_fatal(1, sizeof(*params));
 
 	actions_init(&params->common.threshold_actions);
 	actions_init(&params->common.end_actions);
@@ -410,22 +408,16 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			params->threshold = get_llong_from_str(optarg);
 			break;
 		case '0': /* trigger */
-			if (params->common.events) {
-				retval = trace_event_add_trigger(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding trigger %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_trigger(params->common.events, optarg);
+			else
 				fatal("--trigger requires a previous -e");
-			}
 			break;
 		case '1': /* filter */
-			if (params->common.events) {
-				retval = trace_event_add_filter(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding filter %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_filter(params->common.events, optarg);
+			else
 				fatal("--filter requires a previous -e");
-			}
 			break;
 		case '2':
 			params->common.warmup = get_llong_from_str(optarg);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4e8c38a61197c..6ea397421f1c9 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -766,9 +766,7 @@ static struct common_params
 	int c;
 	char *trace_output = NULL;
 
-	params = calloc(1, sizeof(*params));
-	if (!params)
-		exit(1);
+	params = calloc_fatal(1, sizeof(*params));
 
 	actions_init(&params->common.threshold_actions);
 	actions_init(&params->common.end_actions);
@@ -914,22 +912,16 @@ static struct common_params
 			params->common.hist.with_zeros = 1;
 			break;
 		case '6': /* trigger */
-			if (params->common.events) {
-				retval = trace_event_add_trigger(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding trigger %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_trigger(params->common.events, optarg);
+			else
 				fatal("--trigger requires a previous -e");
-			}
 			break;
 		case '7': /* filter */
-			if (params->common.events) {
-				retval = trace_event_add_filter(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding filter %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_filter(params->common.events, optarg);
+			else
 				fatal("--filter requires a previous -e");
-			}
 			break;
 		case '8':
 			params->dma_latency = get_llong_from_str(optarg);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 284b74773c2b5..dd727cb48b551 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -537,9 +537,7 @@ static struct common_params
 	int c;
 	char *trace_output = NULL;
 
-	params = calloc(1, sizeof(*params));
-	if (!params)
-		exit(1);
+	params = calloc_fatal(1, sizeof(*params));
 
 	actions_init(&params->common.threshold_actions);
 	actions_init(&params->common.end_actions);
@@ -664,22 +662,16 @@ static struct common_params
 			params->common.user_data = true;
 			break;
 		case '0': /* trigger */
-			if (params->common.events) {
-				retval = trace_event_add_trigger(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding trigger %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_trigger(params->common.events, optarg);
+			else
 				fatal("--trigger requires a previous -e");
-			}
 			break;
 		case '1': /* filter */
-			if (params->common.events) {
-				retval = trace_event_add_filter(params->common.events, optarg);
-				if (retval)
-					fatal("Error adding filter %s", optarg);
-			} else {
+			if (params->common.events)
+				trace_event_add_filter(params->common.events, optarg);
+			else
 				fatal("--filter requires a previous -e");
-			}
 			break;
 		case '2': /* dma-latency */
 			params->dma_latency = get_llong_from_str(optarg);
diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index b8be3e28680ee..211ca54b15b0e 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -191,9 +191,7 @@ void trace_instance_destroy(struct trace_instance *trace)
  */
 int trace_instance_init(struct trace_instance *trace, char *tool_name)
 {
-	trace->seq = calloc(1, sizeof(*trace->seq));
-	if (!trace->seq)
-		goto out_err;
+	trace->seq = calloc_fatal(1, sizeof(*trace->seq));
 
 	trace_seq_init(trace->seq);
 
@@ -274,15 +272,9 @@ struct trace_events *trace_event_alloc(const char *event_string)
 {
 	struct trace_events *tevent;
 
-	tevent = calloc(1, sizeof(*tevent));
-	if (!tevent)
-		return NULL;
+	tevent = calloc_fatal(1, sizeof(*tevent));
 
-	tevent->system = strdup(event_string);
-	if (!tevent->system) {
-		free(tevent);
-		return NULL;
-	}
+	tevent->system = strdup_fatal(event_string);
 
 	tevent->event = strstr(tevent->system, ":");
 	if (tevent->event) {
@@ -296,31 +288,23 @@ struct trace_events *trace_event_alloc(const char *event_string)
 /*
  * trace_event_add_filter - record an event filter
  */
-int trace_event_add_filter(struct trace_events *event, char *filter)
+void trace_event_add_filter(struct trace_events *event, char *filter)
 {
 	if (event->filter)
 		free(event->filter);
 
-	event->filter = strdup(filter);
-	if (!event->filter)
-		return 1;
-
-	return 0;
+	event->filter = strdup_fatal(filter);
 }
 
 /*
  * trace_event_add_trigger - record an event trigger action
  */
-int trace_event_add_trigger(struct trace_events *event, char *trigger)
+void trace_event_add_trigger(struct trace_events *event, char *trigger)
 {
 	if (event->trigger)
 		free(event->trigger);
 
-	event->trigger = strdup(trigger);
-	if (!event->trigger)
-		return 1;
-
-	return 0;
+	event->trigger = strdup_fatal(trigger);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index 1e5aee4b828dd..95b911a2228b2 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -45,6 +45,6 @@ void trace_events_destroy(struct trace_instance *instance,
 int trace_events_enable(struct trace_instance *instance,
 			  struct trace_events *events);
 
-int trace_event_add_filter(struct trace_events *event, char *filter);
-int trace_event_add_trigger(struct trace_events *event, char *trigger);
+void trace_event_add_filter(struct trace_events *event, char *filter);
+void trace_event_add_trigger(struct trace_events *event, char *trigger);
 int trace_set_buffer_size(struct trace_instance *trace, int size);
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 18986a5aed3c1..75cdcc63d5a15 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -1032,3 +1032,38 @@ int strtoi(const char *s, int *res)
 	*res = (int) lres;
 	return 0;
 }
+
+static inline void fatal_alloc(void)
+{
+	fatal("Error allocating memory\n");
+}
+
+void *calloc_fatal(size_t n, size_t size)
+{
+	void *p = calloc(n, size);
+
+	if (!p)
+		fatal_alloc();
+
+	return p;
+}
+
+void *reallocarray_fatal(void *p, size_t n, size_t size)
+{
+	p = reallocarray(p, n, size);
+
+	if (!p)
+		fatal_alloc();
+
+	return p;
+}
+
+char *strdup_fatal(const char *s)
+{
+	char *p = strdup(s);
+
+	if (!p)
+		fatal_alloc();
+
+	return p;
+}
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index f7c2a52a0ab54..e29c2eb5d569d 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -69,6 +69,9 @@ int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr);
 int set_comm_cgroup(const char *comm_prefix, const char *cgroup);
 int set_pid_cgroup(pid_t pid, const char *cgroup);
 int set_cpu_dma_latency(int32_t latency);
+void *calloc_fatal(size_t n, size_t size);
+void *reallocarray_fatal(void *p, size_t n, size_t size);
+char *strdup_fatal(const char *s);
 #ifdef HAVE_LIBCPUPOWER_SUPPORT
 int save_cpu_idle_disable_state(unsigned int cpu);
 int restore_cpu_idle_disable_state(unsigned int cpu);
-- 
2.52.0


